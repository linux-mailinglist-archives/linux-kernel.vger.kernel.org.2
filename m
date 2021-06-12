Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4583E3A5002
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhFLSDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhFLSD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 14:03:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9772AC061767;
        Sat, 12 Jun 2021 11:01:24 -0700 (PDT)
Received: from dslb-188-097-213-151.188.097.pools.vodafone-ip.de ([188.97.213.151] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ls7we-0003B8-Iv; Sat, 12 Jun 2021 20:01:20 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/6] staging: rtl8188eu: remove RT_TRACE and DBG_88E prints from usb_intf.c
Date:   Sat, 12 Jun 2021 20:00:19 +0200
Message-Id: <20210612180019.20387-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210612180019.20387-1-martin@kaiser.cx>
References: <20210612180019.20387-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These prints are disabled by default.

Replace the print after dev_alloc_name with proper error handling.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 30 +++------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 3a970d67aa8c..b03d6aa629ad 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -143,16 +143,6 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 
 void usb_intf_stop(struct adapter *padapter)
 {
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+%s\n", __func__));
-
-	/* disable_hw_interrupt */
-	if (!padapter->bSurpriseRemoved) {
-		/* device still exists, so driver can do i/o operation */
-		/* TODO: */
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("SurpriseRemoved == false\n"));
-	}
-
 	/* cancel in irp */
 	rtw_hal_inirp_deinit(padapter);
 
@@ -160,14 +150,10 @@ void usb_intf_stop(struct adapter *padapter)
 	usb_write_port_cancel(padapter);
 
 	/* todo:cancel other irps */
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-%s\n", __func__));
 }
 
 static void rtw_dev_unload(struct adapter *padapter)
 {
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+%s\n", __func__));
-
 	if (padapter->bup) {
 		pr_debug("===> %s\n", __func__);
 		padapter->bDriverStopped = true;
@@ -186,14 +172,9 @@ static void rtw_dev_unload(struct adapter *padapter)
 		}
 
 		padapter->bup = false;
-	} else {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("r871x_dev_unload():padapter->bup == false\n"));
 	}
 
 	pr_debug("<=== %s\n", __func__);
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-%s\n", __func__));
 }
 
 static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
@@ -351,7 +332,6 @@ static int rtw_usb_if1_init(struct usb_interface *pusb_intf)
 
 	padapter->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
 	if (!padapter->HalData) {
-		DBG_88E("Failed to allocate memory for HAL data\n");
 		err = -ENOMEM;
 		goto free_adapter;
 	}
@@ -367,8 +347,6 @@ static int rtw_usb_if1_init(struct usb_interface *pusb_intf)
 
 	/* step 5. */
 	if (rtw_init_drv_sw(padapter) == _FAIL) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("Initialize driver software resource Failed!\n"));
 		err = -ENOMEM;
 		goto free_hal_data;
 	}
@@ -388,8 +366,9 @@ static int rtw_usb_if1_init(struct usb_interface *pusb_intf)
 		pr_debug("can't get autopm:\n");
 
 	/*  alloc dev name after read efuse. */
-	if (dev_alloc_name(pnetdev, padapter->registrypriv.ifname) < 0)
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("dev_alloc_name, fail!\n"));
+	err = dev_alloc_name(pnetdev, padapter->registrypriv.ifname)
+	if (err < 0)
+		goto free_hal_data;
 
 	netif_carrier_off(pnetdev);
 
@@ -401,7 +380,6 @@ static int rtw_usb_if1_init(struct usb_interface *pusb_intf)
 	/* step 6. Tell the network stack we exist */
 	err = register_netdev(pnetdev);
 	if (err) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("register_netdev() failed\n"));
 		goto free_hal_data;
 	}
 
@@ -478,7 +456,6 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 	struct adapter *padapter = dvobj->if1;
 
 	pr_debug("+%s\n", __func__);
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+dev_remove()\n"));
 
 	if (!pusb_intf->unregistering)
 		padapter->bSurpriseRemoved = true;
@@ -492,7 +469,6 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 
 	usb_dvobj_deinit(pusb_intf);
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-dev_remove()\n"));
 	pr_debug("-r871xu_dev_remove, done\n");
 }
 
-- 
2.20.1

