Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78E23E361C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhHGPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhHGPhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:37:54 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF3BC061799
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 08:37:21 -0700 (PDT)
Received: from dslb-084-059-249-202.084.059.pools.vodafone-ip.de ([84.59.249.202] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mCONv-0003Y3-Sv; Sat, 07 Aug 2021 17:37:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/12] staging: r8188eu: remove RT_TRACE prints from os_intfs.c
Date:   Sat,  7 Aug 2021 17:36:30 +0200
Message-Id: <20210807153636.11712-7-martin@kaiser.cx>
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

Handle errors from dev_alloc_name in one place instead of showing a debug
print.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/os_intfs.c | 49 ++++-------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 935e35c82666..c98dbedd10f7 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -697,8 +697,11 @@ static const struct net_device_ops rtw_netdev_ops = {
 
 int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname)
 {
-	if (dev_alloc_name(pnetdev, ifname) < 0)
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("dev_alloc_name, fail!\n"));
+	int err;
+
+	err = dev_alloc_name(pnetdev, ifname);
+	if (err < 0)
+		return err;
 
 	netif_carrier_off(pnetdev);
 	return 0;
@@ -719,8 +722,6 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	struct adapter *padapter;
 	struct net_device *pnetdev;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+init_net_dev\n"));
-
 	if (old_padapter)
 		pnetdev = rtw_alloc_etherdev_with_old_priv(sizeof(struct adapter), (void *)old_padapter);
 	else
@@ -747,8 +748,6 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 {
 	u32 _status = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_start_drv_threads\n"));
-
 	padapter->cmdThread = kthread_run(rtw_cmd_thread, padapter, "RTW_CMD_THREAD");
 	if (IS_ERR(padapter->cmdThread))
 		_status = _FAIL;
@@ -761,8 +760,6 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 
 void rtw_stop_drv_threads(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_stop_drv_threads\n"));
-
 	/* Below is to termindate rtw_cmd_thread & event_thread... */
 	up(&padapter->cmdpriv.cmd_queue_sema);
 	if (padapter->cmdThread)
@@ -858,10 +855,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	u8	ret8 = _SUCCESS;
 	unsigned long flags;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
-
 	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init cmd_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -869,13 +863,11 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	padapter->cmdpriv.padapter = padapter;
 
 	if ((rtw_init_evt_priv(&padapter->evtpriv)) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init evt_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 	if (rtw_init_mlme_priv(padapter) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -887,7 +879,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 #endif /* CONFIG_88EU_P2P */
 
 	if (init_mlme_ext_priv(padapter) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_ext_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -929,29 +920,19 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	spin_lock_init(&padapter->br_ext_lock);
 
 exit:
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_init_drv_sw\n"));
-
-
-
 	return ret8;
 }
 
 void rtw_cancel_all_timer(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_cancel_all_timer\n"));
-
 	_cancel_timer_ex(&padapter->mlmepriv.assoc_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel association timer complete!\n"));
 
 	_cancel_timer_ex(&padapter->mlmepriv.scan_to_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel scan_to_timer!\n"));
 
 	_cancel_timer_ex(&padapter->mlmepriv.dynamic_chk_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel dynamic_chk_timer!\n"));
 
 	/*  cancel sw led timer */
 	rtw_hal_sw_led_deinit(padapter);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel DeInitSwLeds!\n"));
 
 	_cancel_timer_ex(&padapter->pwrctrlpriv.pwr_state_check_timer);
 
@@ -962,8 +943,6 @@ void rtw_cancel_all_timer(struct adapter *padapter)
 
 u8 rtw_free_drv_sw(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("==>rtw_free_drv_sw"));
-
 	/* we can call rtw_p2p_enable here, but: */
 	/*  1. rtw_p2p_enable may have IO operation */
 	/*  2. rtw_p2p_enable is bundled with wext interface */
@@ -996,8 +975,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	rtw_hal_free_data(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("<== rtw_free_drv_sw\n"));
-
 	/* free the old_pnetdev */
 	if (padapter->rereg_nd_name_priv.old_pnetdev) {
 		free_netdev(padapter->rereg_nd_name_priv.old_pnetdev);
@@ -1008,8 +985,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	if (padapter->pbuddy_adapter)
 		padapter->pbuddy_adapter->pbuddy_adapter = NULL;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_free_drv_sw\n"));
-
 	return _SUCCESS;
 }
 
@@ -1048,7 +1023,6 @@ int _netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+88eu_drv - dev_open\n"));
 	DBG_88E("+88eu_drv - drv_open, bup =%d\n", padapter->bup);
 
 	if (pwrctrlpriv->ps_flag) {
@@ -1062,10 +1036,8 @@ int _netdev_open(struct net_device *pnetdev)
 		padapter->bCardDisableWOHSM = false;
 
 		status = rtw_hal_init(padapter);
-		if (status == _FAIL) {
-			RT_TRACE(_module_os_intfs_c_, _drv_err_, ("rtl88eu_hal_init(): Can't init h/w!\n"));
+		if (status == _FAIL)
 			goto netdev_open_error;
-		}
 
 		pr_info("MAC Address = %pM\n", pnetdev->dev_addr);
 
@@ -1102,7 +1074,6 @@ int _netdev_open(struct net_device *pnetdev)
 	netdev_br_init(pnetdev);
 
 netdev_open_normal_process:
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-88eu_drv - dev_open\n"));
 	DBG_88E("-88eu_drv - drv_open, bup =%d\n", padapter->bup);
 	return 0;
 
@@ -1110,7 +1081,6 @@ int _netdev_open(struct net_device *pnetdev)
 	padapter->bup = false;
 	netif_carrier_off(pnetdev);
 	rtw_netif_stop_queue(pnetdev);
-	RT_TRACE(_module_os_intfs_c_, _drv_err_, ("-88eu_drv - dev_open, fail!\n"));
 	DBG_88E("-88eu_drv - drv_open fail, bup =%d\n", padapter->bup);
 	return -1;
 }
@@ -1137,10 +1107,8 @@ static int  ips_netdrv_open(struct adapter *padapter)
 	padapter->bCardDisableWOHSM = false;
 
 	status = rtw_hal_init(padapter);
-	if (status == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("ips_netdrv_open(): Can't init h/w!\n"));
+	if (status == _FAIL)
 		goto netdev_open_error;
-	}
 
 	if (padapter->intf_start)
 		padapter->intf_start(padapter);
@@ -1216,8 +1184,6 @@ int netdev_close(struct net_device *pnetdev)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+88eu_drv - drv_close\n"));
-
 	if (padapter->pwrctrlpriv.bInternalAutoSuspend) {
 		if (padapter->pwrctrlpriv.rf_pwrstate == rf_off)
 			padapter->pwrctrlpriv.ps_flag = true;
@@ -1256,7 +1222,6 @@ int netdev_close(struct net_device *pnetdev)
 	kfree(dvobj->firmware.szFwBuffer);
 	dvobj->firmware.szFwBuffer = NULL;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-88eu_drv - drv_close\n"));
 	DBG_88E("-88eu_drv - drv_close, bup =%d\n", padapter->bup);
 	return 0;
 }
-- 
2.20.1

