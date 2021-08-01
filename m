Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33543DCCF7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 19:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhHARbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 13:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhHARbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 13:31:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5BDC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 10:31:05 -0700 (PDT)
Received: from ipservice-092-217-078-141.092.217.pools.vodafone-ip.de ([92.217.78.141] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mAFIg-0002WQ-9i; Sun, 01 Aug 2021 19:30:58 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] staging: r8188eu: remove RT_TRACE and DBG_88E prints from usb_intf.c
Date:   Sun,  1 Aug 2021 19:30:22 +0200
Message-Id: <20210801173023.1370-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use the standard mechanism for debug prints. Remove the
prints that use driver-specific macros.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 131 ++--------------------
 1 file changed, 9 insertions(+), 122 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bc7f4bd7ce0b..8a2b370ec774 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -120,7 +120,6 @@ static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
 
 	dvobj->usb_alloc_vendor_req_buf = rtw_zmalloc(MAX_USB_IO_CTL_SIZE);
 	if (!dvobj->usb_alloc_vendor_req_buf) {
-		DBG_88E("alloc usb_vendor_req_buf failed... /n");
 		rst = _FAIL;
 		goto exit;
 	}
@@ -192,19 +191,13 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 		pdvobjpriv->ep_num[i] = ep_num;
 	}
 
-	if (pusbd->speed == USB_SPEED_HIGH) {
+	if (pusbd->speed == USB_SPEED_HIGH)
 		pdvobjpriv->ishighspeed = true;
-		DBG_88E("USB_SPEED_HIGH\n");
-	} else {
+	else
 		pdvobjpriv->ishighspeed = false;
-		DBG_88E("NON USB_SPEED_HIGH\n");
-	}
 
-	if (rtw_init_intf_priv(pdvobjpriv) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_,
-			 ("\n Can't INIT rtw_init_intf_priv\n"));
+	if (rtw_init_intf_priv(pdvobjpriv) == _FAIL)
 		goto free_dvobj;
-	}
 
 	/* 3 misc */
 	sema_init(&(pdvobjpriv->usb_suspend_sema), 0);
@@ -241,7 +234,6 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 				 * on sitesurvey for the first time when
 				 * device is up . Reset usb port for sitesurvey
 				 * fail issue. */
-				DBG_88E("usb attached..., try to reset usb device\n");
 				usb_reset_device(interface_to_usbdev(usb_intf));
 			}
 		}
@@ -262,25 +254,11 @@ static void chip_by_usb_id(struct adapter *padapter,
 
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
 
@@ -288,16 +266,11 @@ static void usb_intf_stop(struct adapter *padapter)
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
-		DBG_88E("===> rtw_dev_unload\n");
 		padapter->bDriverStopped = true;
 		if (padapter->xmitpriv.ack_tx)
 			rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_DRV_STOP);
@@ -315,14 +288,7 @@ static void rtw_dev_unload(struct adapter *padapter)
 		}
 
 		padapter->bup = false;
-	} else {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("r871x_dev_unload():padapter->bup == false\n"));
 	}
-
-	DBG_88E("<=== rtw_dev_unload\n");
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-rtw_dev_unload\n"));
 }
 
 static void process_spec_devid(const struct usb_device_id *pdid)
@@ -355,16 +321,12 @@ int rtw_hw_suspend(struct adapter *padapter)
 
 	if ((!padapter->bup) || (padapter->bDriverStopped) ||
 	    (padapter->bSurpriseRemoved)) {
-		DBG_88E("padapter->bup=%d bDriverStopped=%d bSurpriseRemoved = %d\n",
-			padapter->bup, padapter->bDriverStopped,
-			padapter->bSurpriseRemoved);
 		goto error_exit;
 	}
 
 	if (padapter) { /* system suspend */
 		LeaveAllPowerSaveMode(padapter);
 
-		DBG_88E("==> rtw_hw_suspend\n");
 		_enter_pwrlock(&pwrpriv->lock);
 		pwrpriv->bips_processing = true;
 		/* s1. */
@@ -407,7 +369,6 @@ int rtw_hw_suspend(struct adapter *padapter)
 		return 0;
 
 error_exit:
-	DBG_88E("%s, failed\n", __func__);
 	return -1;
 }
 
@@ -418,7 +379,6 @@ int rtw_hw_resume(struct adapter *padapter)
 
 
 	if (padapter) { /* system resume */
-		DBG_88E("==> rtw_hw_resume\n");
 		_enter_pwrlock(&pwrpriv->lock);
 		pwrpriv->bips_processing = true;
 		rtw_reset_drv_sw(padapter);
@@ -450,7 +410,6 @@ int rtw_hw_resume(struct adapter *padapter)
 
 	return 0;
 error_exit:
-	DBG_88E("%s, Open net dev failed\n", __func__);
 	return -1;
 }
 
@@ -466,13 +425,8 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 	u32 start_time = jiffies;
 
 
-	DBG_88E("==> %s (%s:%d)\n", __func__, current->comm, current->pid);
-
 	if ((!padapter->bup) || (padapter->bDriverStopped) ||
 	    (padapter->bSurpriseRemoved)) {
-		DBG_88E("padapter->bup=%d bDriverStopped=%d bSurpriseRemoved = %d\n",
-			padapter->bup, padapter->bDriverStopped,
-			padapter->bSurpriseRemoved);
 		goto exit;
 	}
 
@@ -492,12 +446,6 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
 	    check_fwstate(pmlmepriv, _FW_LINKED)) {
-		DBG_88E("%s:%d %s(%pM), length:%d assoc_ssid.length:%d\n",
-			__func__, __LINE__,
-			pmlmepriv->cur_network.network.Ssid.Ssid,
-			pmlmepriv->cur_network.network.MacAddress,
-			pmlmepriv->cur_network.network.Ssid.SsidLength,
-			pmlmepriv->assoc_ssid.SsidLength);
 
 		pmlmepriv->to_roaming = 1;
 	}
@@ -518,10 +466,7 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 		rtw_indicate_disconnect(padapter);
 
 exit:
-	DBG_88E("<===  %s return %d.............. in %dms\n", __func__
-		, ret, rtw_get_passing_time_ms(start_time));
-
-		return ret;
+	return ret;
 }
 
 static int rtw_resume(struct usb_interface *pusb_intf)
@@ -545,8 +490,6 @@ int rtw_resume_process(struct adapter *padapter)
 	int ret = -1;
 	u32 start_time = jiffies;
 
-	DBG_88E("==> %s (%s:%d)\n", __func__, current->comm, current->pid);
-
 	if (padapter) {
 		pnetdev = padapter->pnetdev;
 		pwrpriv = &padapter->pwrctrlpriv;
@@ -559,7 +502,6 @@ int rtw_resume_process(struct adapter *padapter)
 	if (pwrpriv)
 		pwrpriv->bkeepfwalive = false;
 
-	DBG_88E("bkeepfwalive(%x)\n", pwrpriv->bkeepfwalive);
 	if (pm_netdev_open(pnetdev, true) != 0)
 		goto exit;
 
@@ -569,7 +511,6 @@ int rtw_resume_process(struct adapter *padapter)
 	_exit_pwrlock(&pwrpriv->lock);
 
 	if (padapter->pid[1] != 0) {
-		DBG_88E("pid[1]:%d\n", padapter->pid[1]);
 		rtw_signal_process(padapter->pid[1], SIGUSR2);
 	}
 
@@ -579,9 +520,6 @@ int rtw_resume_process(struct adapter *padapter)
 exit:
 	if (pwrpriv)
 		pwrpriv->bInSuspend = false;
-	DBG_88E("<===  %s return %d.............. in %dms\n", __func__,
-		ret, rtw_get_passing_time_ms(start_time));
-
 
 	return ret;
 }
@@ -643,28 +581,17 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
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
 		dvobj->pusbdev->do_remote_wakeup = 1;
 		pusb_intf->needs_remote_wakeup = 1;
 		device_init_wakeup(&pusb_intf->dev, 1);
-		DBG_88E("\n  padapter->pwrctrlpriv.bSupportRemoteWakeup~~~~~~\n");
-		DBG_88E("\n  padapter->pwrctrlpriv.bSupportRemoteWakeup~~~[%d]~~~\n",
-			device_may_wakeup(&pusb_intf->dev));
 	}
 #endif
 
-	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
-	 * suspend influence */
-	if (usb_autopm_get_interface(pusb_intf) < 0)
-			DBG_88E("can't get autopm:\n");
-
 	/*  alloc dev name after read efuse. */
 	rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname);
 	rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);
@@ -673,21 +600,10 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 				  padapter->eeprompriv.mac_addr);
 #endif
 	memcpy(pnetdev->dev_addr, padapter->eeprompriv.mac_addr, ETH_ALEN);
-	DBG_88E("MAC Address from pnetdev->dev_addr =  %pM\n",
-		pnetdev->dev_addr);
 
 	/* step 6. Tell the network stack we exist */
-	if (register_netdev(pnetdev) != 0) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("register_netdev() failed\n"));
+	if (register_netdev(pnetdev) != 0)
 		goto free_hal_data;
-	}
-
-	DBG_88E("bDriverStopped:%d, bSurpriseRemoved:%d, bup:%d, hw_init_completed:%d\n"
-		, padapter->bDriverStopped
-		, padapter->bSurpriseRemoved
-		, padapter->bup
-		, padapter->hw_init_completed
-	);
 
 	status = _SUCCESS;
 
@@ -731,8 +647,6 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
 	rtw_cancel_all_timer(if1);
 
 	rtw_dev_unload(if1);
-	DBG_88E("+r871xu_dev_remove, hw_init_completed=%d\n",
-		if1->hw_init_completed);
 	rtw_handle_dualmac(if1, 0);
 	rtw_free_drv_sw(if1);
 	if (pnetdev)
@@ -745,31 +659,20 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
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
-	if (!if1) {
-		DBG_88E("rtw_init_primarystruct adapter Failed!\n");
+	if (!if1)
 		goto free_dvobj;
-	}
 
-	if (ui_pid[1] != 0) {
-		DBG_88E("ui_pid[1]:%d\n", ui_pid[1]);
+	if (ui_pid[1] != 0)
 		rtw_signal_process(ui_pid[1], SIGUSR2);
-	}
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-871x_drv - drv_init, success!\n"));
 
 	status = _SUCCESS;
 
@@ -791,9 +694,6 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
 	struct adapter *padapter = dvobj->if1;
 
-	DBG_88E("+rtw_dev_remove\n");
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+dev_remove()\n"));
-
 	if (usb_drv->drv_registered)
 		padapter->bSurpriseRemoved = true;
 
@@ -805,19 +705,10 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 	rtw_usb_if1_deinit(padapter);
 
 	usb_dvobj_deinit(pusb_intf);
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-dev_remove()\n"));
-	DBG_88E("-r871xu_dev_remove, done\n");
-
-	return;
 }
 
 static int __init rtw_drv_entry(void)
 {
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+rtw_drv_entry\n"));
-
-	DBG_88E(DRV_NAME " driver version=%s\n", DRIVERVERSION);
-
 	rtw_suspend_lock_init();
 
 	_rtw_mutex_init(&usb_drv->hw_init_mutex);
@@ -828,16 +719,12 @@ static int __init rtw_drv_entry(void)
 
 static void __exit rtw_drv_halt(void)
 {
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+rtw_drv_halt\n"));
-	DBG_88E("+rtw_drv_halt\n");
-
 	rtw_suspend_lock_uninit();
 
 	usb_drv->drv_registered = false;
 	usb_deregister(&usb_drv->usbdrv);
 
 	_rtw_mutex_free(&usb_drv->hw_init_mutex);
-	DBG_88E("-rtw_drv_halt\n");
 }
 
 module_init(rtw_drv_entry);
-- 
2.20.1

