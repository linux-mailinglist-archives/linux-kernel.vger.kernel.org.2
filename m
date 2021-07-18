Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840E03CC83F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhGRJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 05:10:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:49343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231821AbhGRJKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 05:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626599225;
        bh=+6rDoqUFu3qBP1AIrVC/pau8jOnDcbVJF+6LXY1WD7w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KqQg8YsX2lUz9W8bmXr4wCSfSmODfsGaOgBHM9C0XJP5HBPBXTMQt9euVm+zC7TaY
         9BgIf1tf13tbBZ9DEpx7/TMmBMyAs8kjQbrVOD+VEl84dRY5GBpy7G38zBfPUT9oSH
         ZF7ytNKZ5mG0L/y6hPG+o1kq+7rzOu7VS4GuJIIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MYNJq-1lZbjP21pa-00VPl3; Sun, 18 Jul 2021 11:07:05 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>, Nikolay Kyx <knv418@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        William Durand <will+git@drnd.me>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        zhaoxiao <zhaoxiao@uniontech.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging/rtl8192e: Remove all strcpy() uses in favor of strscpy()
Date:   Sun, 18 Jul 2021 11:06:36 +0200
Message-Id: <20210718090636.7905-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Voc2Cp0NQ9L4VJxa4xEKXL2Qq4U+GqL3n7u+Nbx+4c0jmibXiCJ
 iBsyR+7se8vo5P7RV9Sww1ThVkRZhbQL0bcx1j1LIOnwv12rQnnbAut6z9QqubHfQIW4iye
 /k/UPwVx7lOo/CpHEuEA070RcVOmUUDmE/zUyjCzGIsNl3y/Ba7vBxnKAd4y9BQ0emW0yNd
 FyG2A1i3sKzOgGHIN8TnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RYSB4NMtGLo=:ENQBY+LZT4mPpBEaX4bRB4
 /tYy06anyPRnuzVEmoJVI3MpcmD1EiksDz3vKGbUc9gjiWswp+robXZ7nvEjKVaIcNlDhwWOp
 7wVkp15+5ce/U+OLTAJwZiWdM80jB7RSUsmZrqWycepxVszVoNrPdmaocgEYiTKkKFhlxmTYV
 r83MqcBuoppbWYOQkRp36i+EFjgBy6f5sB7x7g+S1AjOHJYMqY075IfwYfxWpetzkToDMUzp/
 6QSVkMkXPBHqeaaSSl6pPu6FkWyS3deOfRpQ/oP6SwrKIff6iRkN584MeE2nAgH/K1rYsKQks
 epDO2qx9V4ZSe2CV3AbB0R2QeAQ/+ewFJLvBeQuZDvgqJ0x2Q0noYOM978RnpAb6Ycikj5Xvj
 dJSlQc3oRitSGXK43fx5k9UO2u7q6899I8H3vZIYc6GVVznLWM3f/YDJJuT7H3iNY8Wncs/gt
 xJUIYqriTyA7sNdXIV6oBsZ+74Umu91N42X8Rs1Ot4PwTH+8ltxNFgMyptUlHJZRXoOPPJF/f
 f3IO41l8M8JbHvz2VaCh6fFobsMuAGU65o832y6n1QIdG8OTsI18443Sgcf2xvJuRFOzbGtMy
 rbxbskedo7a4yx36nCwQdl0bRSL3vgU9yzugDP0+erncPjx8JMA7jbnRdrQEarVjtxCriz57X
 5WirWNnidEPKcr2sDGmGj248HuJXcRFEKsvXAeA58zrZecpsLYuB/tbufU1oPa/uMyJsXYr+/
 Nx2sTYuafU70M5qqzO/JCkv9iEHU85G9OF0Osxyz/A/xTqBQPDZQAjc4CQo/B4QdNCyZIbjcs
 zGNi9zElVI1NJWTprE7QF7eNdAMQezo9gzey4DoWbYLjYlgruL3qmgZgZayZPSN70F13W+rbI
 cRVJrnOQKlHMbI9YA8BaC0h5lTT2eoFvTv2dJ5Kt0InUtZJCa03jzgVOHcVD9OeI1UDvcJsV8
 1SO+nZkMM+Q37/NnW/zUEvigg8hKMNg2VyWnxhOoU0kiRzttZhgxURBDIsV3yxU0WyQ1bo482
 jD64Qn7qFPXs4BvzMgLl+HidjPSds1laKWRER2cUqRNAdoDbeLrWyrxQZmg/sOUbRAOOZ8Hxb
 aCD6LM7/hNVaT75Je1h/ZMPtn4NLu25t6pW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c      | 3 ++-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c   | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/stag=
ing/rtl8192e/rtl8192e/r8192E_dev.c
index b626ac45db80..358b629d2cc6 100644
=2D-- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -2167,7 +2167,7 @@ rtl92e_init_variables(struct net_device  *dev)
 {
 	struct r8192_priv *priv =3D rtllib_priv(dev);

-	strcpy(priv->nick, "rtl8192E");
+	strscpy(priv->nick, "rtl8192E", sizeof(priv->nick));

 	priv->rtllib->softmac_features  =3D IEEE_SOFTMAC_SCAN |
 		IEEE_SOFTMAC_ASSOCIATE | IEEE_SOFTMAC_PROBERQ |
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/r=
tl8192e/rtllib_softmac.c
index 25b3d3950a3c..d2726d01c757 100644
=2D-- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2582,7 +2582,8 @@ static void rtllib_start_ibss_wq(void *data)
 	mutex_lock(&ieee->wx_mutex);

 	if (ieee->current_network.ssid_len =3D=3D 0) {
-		strcpy(ieee->current_network.ssid, RTLLIB_DEFAULT_TX_ESSID);
+		strscpy(ieee->current_network.ssid, RTLLIB_DEFAULT_TX_ESSID,
+			sizeof(ieee->current_network.ssid));
 		ieee->current_network.ssid_len =3D strlen(RTLLIB_DEFAULT_TX_ESSID);
 		ieee->ssid_set =3D 1;
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/stagin=
g/rtl8192e/rtllib_softmac_wx.c
index f89799d43b1b..5968407c646d 100644
=2D-- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -543,7 +543,7 @@ int rtllib_wx_get_name(struct rtllib_device *ieee,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
-	strcpy(wrqu->name, "802.11");
+	strscpy(wrqu->name, "802.11", sizeof(wrqu->name));

 	if (ieee->modulation & RTLLIB_CCK_MODULATION)
 		strcat(wrqu->name, "b");
=2D-
2.25.1

