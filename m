Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81C33E3621
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhHGPju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhHGPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:37:59 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B135C06179C
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 08:37:21 -0700 (PDT)
Received: from dslb-084-059-249-202.084.059.pools.vodafone-ip.de ([84.59.249.202] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mCONw-0003Y3-Vk; Sat, 07 Aug 2021 17:37:17 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/12] staging: r8188eu: remove an RT_TRACE print from osdep_service.c
Date:   Sat,  7 Aug 2021 17:36:31 +0200
Message-Id: <20210807153636.11712-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807153636.11712-1-martin@kaiser.cx>
References: <20210807153636.11712-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use the standard mechanism for debug prints. Remove a print that
uses a driver-specific macro.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/osdep_service.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 9f097f2b3ddd..36bb3813c677 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -235,11 +235,9 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 		ret = register_netdev(pnetdev);
 	else
 		ret = register_netdevice(pnetdev);
-	if (ret != 0) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("register_netdev() failed\n"));
+	if (ret != 0)
 		goto error;
-	}
+
 	rtw_proc_init_one(pnetdev);
 	return 0;
 error:
-- 
2.20.1

