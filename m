Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11E2347C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhCXPVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:21:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46398 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbhCXPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:21:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lP5KB-0002zn-T7; Wed, 24 Mar 2021 15:21:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: rtl8188eu: Fix null pointer dereference on free_netdev call
Date:   Wed, 24 Mar 2021 15:21:35 +0000
Message-Id: <20210324152135.254152-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An unregister_netdev call checks if pnetdev is null, hence a later
call to free_netdev can potentially be passing a null pointer, causing
a null pointer dereference. Avoid this by adding a null pointer check
on pnetdev before calling free_netdev.

Fixes: 1665c8fdffbb ("staging: rtl8188eu: use netdev routines for private data")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 518e9feb3f46..91a3d34a1050 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -446,7 +446,8 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
 	pr_debug("+r871xu_dev_remove, hw_init_completed=%d\n",
 		 if1->hw_init_completed);
 	rtw_free_drv_sw(if1);
-	free_netdev(pnetdev);
+	if (pnetdev)
+		free_netdev(pnetdev);
 }
 
 static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device_id *pdid)
-- 
2.30.2

