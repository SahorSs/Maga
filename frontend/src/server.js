// frontend/src/server.js

import "@babel/polyfill"
import React from 'react'
import {renderToString} from 'react-dom/server'
import {Provider} from 'react-redux'
import App from './components/app'
import {navigate} from "./redux/actions";
import configureStore from "./redux/configureStore";

export default function render(initialState, url) {
    // Создаём store, как и на клиенте.
    const store = configureStore(initialState);
    store.dispatch(navigate(url));

    let app = (
        <Provider store={store}>
            <App/>
        </Provider>
    );

    // Оказывается, в реакте уже есть функция рендеринга в строку!
    // Автор, ну и зачем ты десять разделов пудрил мне мозги?
    let content = renderToString(app);
    let preloadedState = store.getState();

    return {content, preloadedState};
};