Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D5D394C28
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhE2MQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 08:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhE2MQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 08:16:10 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32F7C061574;
        Sat, 29 May 2021 05:14:33 -0700 (PDT)
Received: from dslb-188-096-150-056.188.096.pools.vodafone-ip.de ([188.96.150.56] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lmxrJ-00023z-1t; Sat, 29 May 2021 14:14:29 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] staging: rtl8188eu: remove dummy wext handlers
Date:   Sat, 29 May 2021 14:13:45 +0200
Message-Id: <20210529121346.8422-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210529121346.8422-1-martin@kaiser.cx>
References: <20210529121346.8422-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the wext handlers that link to an empty dummy function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
If no handler is installed for a wext ioctl, the wext core will return
-ENOTSUPP to user space. The dummy function returned -1. It could be argued
that this change breaks the user space ABI.

However, it's rather unlikely that an application expects a particular wlan
driver and chipset when it configures a wireless network. Checking for
errno==1 explicitly will already be non-portable as most other drivers set
errn==ENOTSUPP for non-existing ioctls.

 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index a23ccda6fefe..78699999c4fe 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -1910,12 +1910,6 @@ static int rtw_wx_get_nick(struct net_device *dev,
 	return 0;
 }
 
-static int dummy(struct net_device *dev, struct iw_request_info *a,
-		 union iwreq_data *wrqu, char *b)
-{
-	return -1;
-}
-
 static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
 {
 	uint ret = 0;
@@ -2900,27 +2894,20 @@ static int rtw_wx_set_priv(struct net_device *dev,
 
 static iw_handler rtw_handlers[] = {
 	IW_HANDLER(SIOCGIWNAME, rtw_wx_get_name),
-	IW_HANDLER(SIOCSIWNWID, dummy),
-	IW_HANDLER(SIOCGIWNWID, dummy),
 	IW_HANDLER(SIOCSIWFREQ, rtw_wx_set_freq),
 	IW_HANDLER(SIOCGIWFREQ, rtw_wx_get_freq),
 	IW_HANDLER(SIOCSIWMODE, rtw_wx_set_mode),
 	IW_HANDLER(SIOCGIWMODE, rtw_wx_get_mode),
-	IW_HANDLER(SIOCSIWSENS, dummy),
 	IW_HANDLER(SIOCGIWSENS, rtw_wx_get_sens),
 	IW_HANDLER(SIOCGIWRANGE, rtw_wx_get_range),
 	IW_HANDLER(SIOCSIWPRIV, rtw_wx_set_priv),
-	IW_HANDLER(SIOCSIWSPY, dummy),
-	IW_HANDLER(SIOCGIWSPY, dummy),
 	IW_HANDLER(SIOCSIWAP, rtw_wx_set_wap),
 	IW_HANDLER(SIOCGIWAP, rtw_wx_get_wap),
 	IW_HANDLER(SIOCSIWMLME, rtw_wx_set_mlme),
-	IW_HANDLER(SIOCGIWAPLIST, dummy),
 	IW_HANDLER(SIOCSIWSCAN, rtw_wx_set_scan),
 	IW_HANDLER(SIOCGIWSCAN, rtw_wx_get_scan),
 	IW_HANDLER(SIOCSIWESSID, rtw_wx_set_essid),
 	IW_HANDLER(SIOCGIWESSID, rtw_wx_get_essid),
-	IW_HANDLER(SIOCSIWNICKN, dummy),
 	IW_HANDLER(SIOCGIWNICKN, rtw_wx_get_nick),
 	IW_HANDLER(SIOCSIWRATE, rtw_wx_set_rate),
 	IW_HANDLER(SIOCGIWRATE, rtw_wx_get_rate),
@@ -2928,13 +2915,9 @@ static iw_handler rtw_handlers[] = {
 	IW_HANDLER(SIOCGIWRTS, rtw_wx_get_rts),
 	IW_HANDLER(SIOCSIWFRAG, rtw_wx_set_frag),
 	IW_HANDLER(SIOCGIWFRAG, rtw_wx_get_frag),
-	IW_HANDLER(SIOCSIWTXPOW, dummy),
-	IW_HANDLER(SIOCGIWTXPOW, dummy),
-	IW_HANDLER(SIOCSIWRETRY, dummy),
 	IW_HANDLER(SIOCGIWRETRY, rtw_wx_get_retry),
 	IW_HANDLER(SIOCSIWENCODE, rtw_wx_set_enc),
 	IW_HANDLER(SIOCGIWENCODE, rtw_wx_get_enc),
-	IW_HANDLER(SIOCSIWPOWER, dummy),
 	IW_HANDLER(SIOCGIWPOWER, rtw_wx_get_power),
 	IW_HANDLER(SIOCSIWGENIE, rtw_wx_set_gen_ie),
 	IW_HANDLER(SIOCSIWAUTH, rtw_wx_set_auth),
-- 
2.20.1

