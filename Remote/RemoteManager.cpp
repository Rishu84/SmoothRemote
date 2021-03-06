/****************************************************************************
**
** Copyright (C) Paul Lemire, Tepee3DTeam and/or its subsidiary(-ies).
** Contact: paul.lemire@epitech.eu
** Contact: tepee3d_2014@labeip.epitech.eu
**
** This file is part of the Tepee3D project
**
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
****************************************************************************/

#include "RemoteManager.h"

RemoteManager::RemoteManager(QObject *parent) : QObject(parent)
{
}

RemoteManager::~RemoteManager()
{
}

void RemoteManager::receiveResultFromHttpRequest(QNetworkReply *reply, int id, QPointer<QObject> data)
{
    Q_UNUSED(id);
    Q_UNUSED(data);
    this->moveKeyCallBack(reply);
}

int RemoteManager::getMajorIDRequestHandled() const
{
    return MAJOR_ID_REQUEST_REMOTE;
}

void RemoteManager::moveKey(const QString &keyCode)
{
     QJsonObject requestJson;
     requestJson.insert("jsonrpc", QJsonValue(QString("2.0")));
     qDebug() << "Executing Key " << keyCode;
     requestJson.insert("method", QJsonValue(keyCode));
     emit performJsonRPCRequest(requestJson, REQUEST_ID_BUILDER(MAJOR_ID_REQUEST_REMOTE, KEY_PRESSED));
}

void RemoteManager::showOSD()
{
    this->moveKey("Input.ShowOSD");
}

void RemoteManager::showInfos()
{
    this->moveKey("Input.Info");
}

void RemoteManager::showCodecs()
{
    this->moveKey("Input.ShowCodec");
}

void RemoteManager::sendText(const QString &text)
{
    QJsonObject requestJson;
    requestJson.insert("jsonrpc", QJsonValue(QString("2.0")));
    requestJson.insert("method", QJsonValue(QString("Input.SendText")));
    QJsonObject params;
    params.insert("text", QJsonValue(text));
    requestJson.insert("params", QJsonValue(params));
    qDebug() << "Sending Text";
    emit performJsonRPCRequest(requestJson, REQUEST_ID_BUILDER(MAJOR_ID_REQUEST_REMOTE, KEY_PRESSED));
}

void RemoteManager::moveKeyCallBack(QNetworkReply *reply)
{
    qDebug() << "Move Key CallBack";
    QJsonDocument replyJs = Utils::QJsonDocumentFromReply(reply);
    qDebug() << replyJs.toJson();
}
