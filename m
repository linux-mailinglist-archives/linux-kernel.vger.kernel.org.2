Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3550394C26
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE2MQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 08:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhE2MQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 08:16:02 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E7C061574;
        Sat, 29 May 2021 05:14:24 -0700 (PDT)
Received: from dslb-188-096-150-056.188.096.pools.vodafone-ip.de ([188.96.150.56] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lmxr8-00023z-Ib; Sat, 29 May 2021 14:14:18 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] staging: rtl8188eu: use IW_HANDLER to declare wext handlers
Date:   Sat, 29 May 2021 14:13:44 +0200
Message-Id: <20210529121346.8422-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the IW_HANDLER macro to declare the handler functions for
wext ioctls.  We don't have to skip unused ioctl numbers manually.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 97 ++++++++-----------
 1 file changed, 41 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 9dacdd595b63..a23ccda6fefe 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -2899,62 +2899,47 @@ static int rtw_wx_set_priv(struct net_device *dev,
 }
 
 static iw_handler rtw_handlers[] = {
-	NULL,					/* SIOCSIWCOMMIT */
-	rtw_wx_get_name,		/* SIOCGIWNAME */
-	dummy,					/* SIOCSIWNWID */
-	dummy,					/* SIOCGIWNWID */
-	rtw_wx_set_freq,		/* SIOCSIWFREQ */
-	rtw_wx_get_freq,		/* SIOCGIWFREQ */
-	rtw_wx_set_mode,		/* SIOCSIWMODE */
-	rtw_wx_get_mode,		/* SIOCGIWMODE */
-	dummy,					/* SIOCSIWSENS */
-	rtw_wx_get_sens,		/* SIOCGIWSENS */
-	NULL,					/* SIOCSIWRANGE */
-	rtw_wx_get_range,		/* SIOCGIWRANGE */
-	rtw_wx_set_priv,		/* SIOCSIWPRIV */
-	NULL,					/* SIOCGIWPRIV */
-	NULL,					/* SIOCSIWSTATS */
-	NULL,					/* SIOCGIWSTATS */
-	dummy,					/* SIOCSIWSPY */
-	dummy,					/* SIOCGIWSPY */
-	NULL,					/* SIOCGIWTHRSPY */
-	NULL,					/* SIOCWIWTHRSPY */
-	rtw_wx_set_wap,		/* SIOCSIWAP */
-	rtw_wx_get_wap,		/* SIOCGIWAP */
-	rtw_wx_set_mlme,		/* request MLME operation; uses struct iw_mlme */
-	dummy,					/* SIOCGIWAPLIST -- depricated */
-	rtw_wx_set_scan,		/* SIOCSIWSCAN */
-	rtw_wx_get_scan,		/* SIOCGIWSCAN */
-	rtw_wx_set_essid,		/* SIOCSIWESSID */
-	rtw_wx_get_essid,		/* SIOCGIWESSID */
-	dummy,					/* SIOCSIWNICKN */
-	rtw_wx_get_nick,		/* SIOCGIWNICKN */
-	NULL,					/* -- hole -- */
-	NULL,					/* -- hole -- */
-	rtw_wx_set_rate,		/* SIOCSIWRATE */
-	rtw_wx_get_rate,		/* SIOCGIWRATE */
-	rtw_wx_set_rts,			/* SIOCSIWRTS */
-	rtw_wx_get_rts,			/* SIOCGIWRTS */
-	rtw_wx_set_frag,		/* SIOCSIWFRAG */
-	rtw_wx_get_frag,		/* SIOCGIWFRAG */
-	dummy,					/* SIOCSIWTXPOW */
-	dummy,					/* SIOCGIWTXPOW */
-	dummy,					/* SIOCSIWRETRY */
-	rtw_wx_get_retry,		/* SIOCGIWRETRY */
-	rtw_wx_set_enc,			/* SIOCSIWENCODE */
-	rtw_wx_get_enc,			/* SIOCGIWENCODE */
-	dummy,					/* SIOCSIWPOWER */
-	rtw_wx_get_power,		/* SIOCGIWPOWER */
-	NULL,					/*---hole---*/
-	NULL,					/*---hole---*/
-	rtw_wx_set_gen_ie,		/* SIOCSIWGENIE */
-	NULL,					/* SIOCGWGENIE */
-	rtw_wx_set_auth,		/* SIOCSIWAUTH */
-	NULL,					/* SIOCGIWAUTH */
-	rtw_wx_set_enc_ext,		/* SIOCSIWENCODEEXT */
-	NULL,					/* SIOCGIWENCODEEXT */
-	rtw_wx_set_pmkid,		/* SIOCSIWPMKSA */
-	NULL,					/*---hole---*/
+	IW_HANDLER(SIOCGIWNAME, rtw_wx_get_name),
+	IW_HANDLER(SIOCSIWNWID, dummy),
+	IW_HANDLER(SIOCGIWNWID, dummy),
+	IW_HANDLER(SIOCSIWFREQ, rtw_wx_set_freq),
+	IW_HANDLER(SIOCGIWFREQ, rtw_wx_get_freq),
+	IW_HANDLER(SIOCSIWMODE, rtw_wx_set_mode),
+	IW_HANDLER(SIOCGIWMODE, rtw_wx_get_mode),
+	IW_HANDLER(SIOCSIWSENS, dummy),
+	IW_HANDLER(SIOCGIWSENS, rtw_wx_get_sens),
+	IW_HANDLER(SIOCGIWRANGE, rtw_wx_get_range),
+	IW_HANDLER(SIOCSIWPRIV, rtw_wx_set_priv),
+	IW_HANDLER(SIOCSIWSPY, dummy),
+	IW_HANDLER(SIOCGIWSPY, dummy),
+	IW_HANDLER(SIOCSIWAP, rtw_wx_set_wap),
+	IW_HANDLER(SIOCGIWAP, rtw_wx_get_wap),
+	IW_HANDLER(SIOCSIWMLME, rtw_wx_set_mlme),
+	IW_HANDLER(SIOCGIWAPLIST, dummy),
+	IW_HANDLER(SIOCSIWSCAN, rtw_wx_set_scan),
+	IW_HANDLER(SIOCGIWSCAN, rtw_wx_get_scan),
+	IW_HANDLER(SIOCSIWESSID, rtw_wx_set_essid),
+	IW_HANDLER(SIOCGIWESSID, rtw_wx_get_essid),
+	IW_HANDLER(SIOCSIWNICKN, dummy),
+	IW_HANDLER(SIOCGIWNICKN, rtw_wx_get_nick),
+	IW_HANDLER(SIOCSIWRATE, rtw_wx_set_rate),
+	IW_HANDLER(SIOCGIWRATE, rtw_wx_get_rate),
+	IW_HANDLER(SIOCSIWRTS, rtw_wx_set_rts),
+	IW_HANDLER(SIOCGIWRTS, rtw_wx_get_rts),
+	IW_HANDLER(SIOCSIWFRAG, rtw_wx_set_frag),
+	IW_HANDLER(SIOCGIWFRAG, rtw_wx_get_frag),
+	IW_HANDLER(SIOCSIWTXPOW, dummy),
+	IW_HANDLER(SIOCGIWTXPOW, dummy),
+	IW_HANDLER(SIOCSIWRETRY, dummy),
+	IW_HANDLER(SIOCGIWRETRY, rtw_wx_get_retry),
+	IW_HANDLER(SIOCSIWENCODE, rtw_wx_set_enc),
+	IW_HANDLER(SIOCGIWENCODE, rtw_wx_get_enc),
+	IW_HANDLER(SIOCSIWPOWER, dummy),
+	IW_HANDLER(SIOCGIWPOWER, rtw_wx_get_power),
+	IW_HANDLER(SIOCSIWGENIE, rtw_wx_set_gen_ie),
+	IW_HANDLER(SIOCSIWAUTH, rtw_wx_set_auth),
+	IW_HANDLER(SIOCSIWENCODEEXT, rtw_wx_set_enc_ext),
+	IW_HANDLER(SIOCSIWPMKSA, rtw_wx_set_pmkid),
 };
 
 static struct iw_statistics *rtw_get_wireless_stats(struct net_device *dev)
-- 
2.20.1

