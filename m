Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5B83D3EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhGWQws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:52:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:35503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232659AbhGWQwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627061557;
        bh=duJRMUeDGYztQ7bUtgH0RbbuveqShOnGO4B6w0gSG9E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=g0rf0gJAgcNOkj+jD0iRdPuo8UDznyZw1TXqgYLY05JUy3Hk+e44E4YlubJD2cWiL
         espA/iOEjM2VovLBj8zMFxmGEUXoGHo9irPPRafXpooiWe7Srh1vQQ7b4US4GIhJvd
         G6zhY98uQ2OtR4j4PcWUGjwlKvWaXW32rB+n5Wxo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MWAOQ-1lZJDa2muw-00XbYM; Fri, 23 Jul 2021 19:32:36 +0200
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
Subject: [PATCH v2] staging/rtl8192e: Remove all strcpy() uses
Date:   Fri, 23 Jul 2021 19:32:16 +0200
Message-Id: <20210723173216.12157-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sn1+zFtP5guq0Fn9p9L2IpcWp22Ddi/hnyDIc2BLewBiiSL52Sg
 nwEGkSDf7/G9rbzfFs6xWgKqB7ObnyxOkWnNzTmL7LgnQ/J6pFslURsn8fR9iGv55qg8Fnt
 69qJqkx9Od9Ro+BsVyeU2a2OWVK+FXs+zB1XQJD6rEfULjTKXobm/klV4ZRgA0dckeaDmGq
 UGzoyP+yI8jBUAkqU3/LQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bda641CZFfE=:KjWRDbnU5sfvmphDdwxc+V
 4cDZoiSSNESJiQ3KWCqEknz8G3wr8fREexTLfu3e4vxxb+Hn/HZVxnoazroPqVP/c0LLTyDcH
 9IJj90KId3by9fKC75CfX4fCfrzEFEmo8ATekXgLN+gq8Ghxop67v5+CuHn7vhdh2UxfUhGJ1
 h+Pwg6nlKnRtWp8tMrSh4B8s62lwOdUm2Y9GYiNV8NgYNb9OMmMg1/3davmnjPO6Ea5xe//JF
 f4zFhBAzbUUy+CGKbIC4vInU6uXra0V6QIR+k2izZ9aOip/t+71I/ZVO9KA7YJ4qpU2o2OvF6
 2z4u+GQIqiM5qWD5U2s3pHv/0XwJhLPN+eoapFD7aG7FESam0TKJZPt2QXou32+HDlvEtxih9
 a5uQ5xHPMAg7fJps2R9T5KKStdKR2OjiRfLuEGB+JRf64UCCD2ueWeKwLEhG908zE5KnNS0cv
 KPtvHf85Ii2GFR9ZIx14MYdbB0+sF+wxd5entY9QIzlVo1FP1AURyt/2vfBYW06wzmYfAXKA1
 iNMsWqMqTfrr8rzJ2gqV9jtdAy0dttgHqsNR3td4UyH0MsOB+4126rmJOw/Kw3OlRC1JU2uE1
 UC2blJff8JtLzdI9U1viruq8ShIBW+2pwOEJz4G6qCNdiGWVAqhN4VqhN0yX78q8NbXUzumEB
 FnktyPpdTnVbU0CQpBWsRm6cP+GwxaKWrfFTTyXRsqEITeQ8p1E3hiZUf3d0ODP+a2PjdER+R
 4/rkVgFVQ4L7lQcm1FcFxxKxCnm8tYdghQU7U827P3sPZkOJmrY/+9hLHP7RDVy9VfqrEFlQ0
 9GSBCGdmeGrilC3VvB6rgEKlKIu0QrEVvZv1NrlFwR9U9UoE6OVqmCv5nh+plBrYVDPDooMZF
 ETGVv5isxu0ifN6ieyIA7Ydc2IPT8SdLnKbMUnpwSIiivuLgl97V/o2r2gsmDRh3gwPFErpN2
 infgO08JZrMy2IiR3bvFjS+dIzabLMa5mp5qOl3/Ab2w/9emFNFbo1pDmF9S4+qLRw4Ns2Qu/
 17ka5gvUqmN/v2Jf2LEGwNZVjtj4swkq98F5lOwcfPD88xO8gDqLwyyRpKP58EPUeMXH8YFKU
 qLm7cdlEGIH5TyhcocJGwTkvhuIcvEjlkAN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

It is also dangerous a strcpy() followed by a strcat(). In this case,
refactor the code using scnprintf() and avoid this combination.

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Changelog v1 -> v2
- Refactor the code to avoid the strcpy() + strcat() combination (Dan
  Carpenter)

 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c      |  3 ++-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c   | 18 +++++++-----------
 3 files changed, 10 insertions(+), 13 deletions(-)

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
index f89799d43b1b..57a6d1130b6a 100644
=2D-- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -539,18 +539,14 @@ int rtllib_wx_set_rawtx(struct rtllib_device *ieee,
 }
 EXPORT_SYMBOL(rtllib_wx_set_rawtx);

-int rtllib_wx_get_name(struct rtllib_device *ieee,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
+int rtllib_wx_get_name(struct rtllib_device *ieee, struct iw_request_info=
 *info,
+		       union iwreq_data *wrqu, char *extra)
 {
-	strcpy(wrqu->name, "802.11");
-
-	if (ieee->modulation & RTLLIB_CCK_MODULATION)
-		strcat(wrqu->name, "b");
-	if (ieee->modulation & RTLLIB_OFDM_MODULATION)
-		strcat(wrqu->name, "g");
-	if (ieee->mode & (IEEE_N_24G | IEEE_N_5G))
-		strcat(wrqu->name, "n");
+	const char *b =3D ieee->modulation & RTLLIB_CCK_MODULATION ? "b" : "";
+	const char *g =3D ieee->modulation & RTLLIB_OFDM_MODULATION ? "g" : "";
+	const char *n =3D ieee->mode & (IEEE_N_24G | IEEE_N_5G) ? "n" : "";
+
+	scnprintf(wrqu->name, sizeof(wrqu->name), "802.11%s%s%s", b, g, n);
 	return 0;
 }
 EXPORT_SYMBOL(rtllib_wx_get_name);
=2D-
2.25.1

