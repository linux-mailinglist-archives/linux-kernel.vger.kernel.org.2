Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CAF45EF6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353719AbhKZNvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352202AbhKZNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:49:01 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D5C0619F8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:04:28 -0800 (PST)
Received: from dslb-178-004-171-146.178.004.pools.vodafone-ip.de ([178.4.171.146] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqatp-0006Hl-Cj; Fri, 26 Nov 2021 14:04:21 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 4/4] staging: r8188eu: loadparam needs no net_device
Date:   Fri, 26 Nov 2021 14:04:00 +0100
Message-Id: <20211126130400.26151-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126130400.26151-1-martin@kaiser.cx>
References: <20211125164745.8188-1-martin@kaiser.cx>
 <20211126130400.26151-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the second parameter of the loadparam function. This parameter
is not used.

Reviewed-by: Michael Straube <straube.linux@gmail.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - add Reviewed-by

 drivers/staging/r8188eu/os_dep/os_intfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 397981bc9a62..02700834c587 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -153,7 +153,7 @@ MODULE_PARM_DESC(rtw_notch_filter, "0:Disable, 1:Enable, 2:Enable only for P2P")
 module_param_named(debug, rtw_debug, int, 0444);
 MODULE_PARM_DESC(debug, "Set debug level (1-9) (default 1)");
 
-static uint loadparam(struct adapter *padapter,  struct  net_device *pnetdev)
+static uint loadparam(struct adapter *padapter)
 {
 	struct registry_priv  *registry_par = &padapter->registrypriv;
 
@@ -371,7 +371,7 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	pnetdev->wireless_handlers = (struct iw_handler_def *)&rtw_handlers_def;
 
 	/* step 2. */
-	loadparam(padapter, pnetdev);
+	loadparam(padapter);
 
 	return pnetdev;
 }
-- 
2.20.1

