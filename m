Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60B3E3620
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhHGPjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhHGPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:37:59 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4CC06179B
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 08:37:18 -0700 (PDT)
Received: from dslb-084-059-249-202.084.059.pools.vodafone-ip.de ([84.59.249.202] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mCONt-0003Y3-Vj; Sat, 07 Aug 2021 17:37:14 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/12] staging: r8188eu: remove empty function
Date:   Sat,  7 Aug 2021 17:36:28 +0200
Message-Id: <20210807153636.11712-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807153636.11712-1-martin@kaiser.cx>
References: <20210807153636.11712-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the RT_TRACE print removed, the rtw_wx_set_freq function is now
empty.

This function should be removed. At the moment, the setfreq ioctl
returns success to the caller although the frequency wasn't set.
It makes more sense to inform callers that this driver does not
support setfreq.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 3d26d50abd7e..404744c90518 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -801,13 +801,6 @@ static int rtw_wx_get_name(struct net_device *dev,
 	return 0;
 }
 
-static int rtw_wx_set_freq(struct net_device *dev,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
-{
-	return 0;
-}
-
 static int rtw_wx_get_freq(struct net_device *dev,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
@@ -7437,7 +7430,7 @@ static iw_handler rtw_handlers[] = {
 	rtw_wx_get_name,		/* SIOCGIWNAME */
 	dummy,					/* SIOCSIWNWID */
 	dummy,					/* SIOCGIWNWID */
-	rtw_wx_set_freq,		/* SIOCSIWFREQ */
+	NULL,				/* SIOCSIWFREQ */
 	rtw_wx_get_freq,		/* SIOCGIWFREQ */
 	rtw_wx_set_mode,		/* SIOCSIWMODE */
 	rtw_wx_get_mode,		/* SIOCGIWMODE */
-- 
2.20.1

