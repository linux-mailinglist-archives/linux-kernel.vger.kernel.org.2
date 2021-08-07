Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EAC3E361A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhHGPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhHGPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:37:37 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3509FC0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 08:37:17 -0700 (PDT)
Received: from dslb-084-059-249-202.084.059.pools.vodafone-ip.de ([84.59.249.202] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mCONq-0003Y3-Mj; Sat, 07 Aug 2021 17:37:10 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/12] staging: r8188eu: remove RT_TRACE prints from usb_intf.c
Date:   Sat,  7 Aug 2021 17:36:25 +0200
Message-Id: <20210807153636.11712-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807153636.11712-1-martin@kaiser.cx>
References: <20210807153636.11712-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use the standard mechanism for debug prints. Remove the prints
that use driver-specific macros.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 51 ++---------------------
 1 file changed, 4 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index b1184c36ddfc..cdd9734adf94 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -200,11 +200,8 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 		DBG_88E("NON USB_SPEED_HIGH\n");
 	}
 
-	if (rtw_init_intf_priv(pdvobjpriv) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_,
-			 ("\n Can't INIT rtw_init_intf_priv\n"));
+	if (rtw_init_intf_priv(pdvobjpriv) == _FAIL)
 		goto free_dvobj;
-	}
 
 	/* 3 misc */
 	sema_init(&(pdvobjpriv->usb_suspend_sema), 0);
@@ -262,25 +259,11 @@ static void chip_by_usb_id(struct adapter *padapter,
 
 static void usb_intf_start(struct adapter *padapter)
 {
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+usb_intf_start\n"));
-
 	rtw_hal_inirp_init(padapter);
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-usb_intf_start\n"));
 }
 
 static void usb_intf_stop(struct adapter *padapter)
 {
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+usb_intf_stop\n"));
-
-	/* disabel_hw_interrupt */
-	if (!padapter->bSurpriseRemoved) {
-		/* device still exists, so driver can do i/o operation */
-		/* TODO: */
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("SurpriseRemoved == false\n"));
-	}
-
 	/* cancel in irp */
 	rtw_hal_inirp_deinit(padapter);
 
@@ -288,14 +271,10 @@ static void usb_intf_stop(struct adapter *padapter)
 	rtw_write_port_cancel(padapter);
 
 	/* todo:cancel other irps */
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-usb_intf_stop\n"));
 }
 
 static void rtw_dev_unload(struct adapter *padapter)
 {
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+rtw_dev_unload\n"));
-
 	if (padapter->bup) {
 		DBG_88E("===> rtw_dev_unload\n");
 		padapter->bDriverStopped = true;
@@ -315,14 +294,9 @@ static void rtw_dev_unload(struct adapter *padapter)
 		}
 
 		padapter->bup = false;
-	} else {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("r871x_dev_unload():padapter->bup == false\n"));
 	}
 
 	DBG_88E("<=== rtw_dev_unload\n");
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-rtw_dev_unload\n"));
 }
 
 static void process_spec_devid(const struct usb_device_id *pdid)
@@ -643,11 +617,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	rtw_hal_read_chip_info(padapter);
 
 	/* step 5. */
-	if (rtw_init_drv_sw(padapter) == _FAIL) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("Initialize driver software resource Failed!\n"));
+	if (rtw_init_drv_sw(padapter) == _FAIL)
 		goto free_hal_data;
-	}
 
 #ifdef CONFIG_PM
 	if (padapter->pwrctrlpriv.bSupportRemoteWakeup) {
@@ -677,10 +648,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 		pnetdev->dev_addr);
 
 	/* step 6. Tell the network stack we exist */
-	if (register_netdev(pnetdev) != 0) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("register_netdev() failed\n"));
+	if (register_netdev(pnetdev) != 0)
 		goto free_hal_data;
-	}
 
 	DBG_88E("bDriverStopped:%d, bSurpriseRemoved:%d, bup:%d, hw_init_completed:%d\n"
 		, padapter->bDriverStopped
@@ -745,18 +714,13 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 	int status;
 	struct dvobj_priv *dvobj;
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+rtw_drv_init\n"));
-
 	/* step 0. */
 	process_spec_devid(pdid);
 
 	/* Initialize dvobj_priv */
 	dvobj = usb_dvobj_init(pusb_intf);
-	if (!dvobj) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("initialize device object priv Failed!\n"));
+	if (!dvobj)
 		goto exit;
-	}
 
 	if1 = rtw_usb_if1_init(dvobj, pusb_intf, pdid);
 	if (!if1) {
@@ -769,8 +733,6 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 		rtw_signal_process(ui_pid[1], SIGUSR2);
 	}
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-871x_drv - drv_init, success!\n"));
-
 	status = _SUCCESS;
 
 	if (status != _SUCCESS && if1)
@@ -792,7 +754,6 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 	struct adapter *padapter = dvobj->if1;
 
 	DBG_88E("+rtw_dev_remove\n");
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+dev_remove()\n"));
 
 	if (usb_drv->drv_registered)
 		padapter->bSurpriseRemoved = true;
@@ -806,14 +767,11 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 
 	usb_dvobj_deinit(pusb_intf);
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-dev_remove()\n"));
 	DBG_88E("-r871xu_dev_remove, done\n");
 }
 
 static int __init rtw_drv_entry(void)
 {
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+rtw_drv_entry\n"));
-
 	DBG_88E(DRV_NAME " driver version=%s\n", DRIVERVERSION);
 
 	_rtw_mutex_init(&usb_drv->hw_init_mutex);
@@ -824,7 +782,6 @@ static int __init rtw_drv_entry(void)
 
 static void __exit rtw_drv_halt(void)
 {
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+rtw_drv_halt\n"));
 	DBG_88E("+rtw_drv_halt\n");
 
 	usb_drv->drv_registered = false;
-- 
2.20.1

