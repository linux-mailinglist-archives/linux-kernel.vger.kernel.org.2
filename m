Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3312394C2A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 14:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhE2MQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 08:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhE2MQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 08:16:13 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03521C061574;
        Sat, 29 May 2021 05:14:36 -0700 (PDT)
Received: from dslb-188-096-150-056.188.096.pools.vodafone-ip.de ([188.96.150.56] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lmxrN-00023z-1B; Sat, 29 May 2021 14:14:33 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/3] staging: rtl8188eu: remove dummy setfreq handler
Date:   Sat, 29 May 2021 14:13:46 +0200
Message-Id: <20210529121346.8422-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210529121346.8422-1-martin@kaiser.cx>
References: <20210529121346.8422-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setfreq handler contains only a debug print. It returns success
although the frequency wasn't set.

Remove this handler and inform callers that this driver does not
support setfreq.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 78699999c4fe..ebd61ba93ef0 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -667,14 +667,6 @@ static int rtw_wx_get_name(struct net_device *dev,
 	return 0;
 }
 
-static int rtw_wx_set_freq(struct net_device *dev,
-			   struct iw_request_info *info,
-			   union iwreq_data *wrqu, char *extra)
-{
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+%s\n", __func__));
-	return 0;
-}
-
 static int rtw_wx_get_freq(struct net_device *dev,
 			   struct iw_request_info *info,
 			   union iwreq_data *wrqu, char *extra)
@@ -2894,7 +2886,6 @@ static int rtw_wx_set_priv(struct net_device *dev,
 
 static iw_handler rtw_handlers[] = {
 	IW_HANDLER(SIOCGIWNAME, rtw_wx_get_name),
-	IW_HANDLER(SIOCSIWFREQ, rtw_wx_set_freq),
 	IW_HANDLER(SIOCGIWFREQ, rtw_wx_get_freq),
 	IW_HANDLER(SIOCSIWMODE, rtw_wx_set_mode),
 	IW_HANDLER(SIOCGIWMODE, rtw_wx_get_mode),
-- 
2.20.1

