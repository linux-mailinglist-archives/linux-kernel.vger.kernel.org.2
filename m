Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964F73DF63E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbhHCUPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbhHCUPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:15:38 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1F0C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 13:15:26 -0700 (PDT)
Received: from dslb-188-104-062-095.188.104.pools.vodafone-ip.de ([188.104.62.95] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mB0os-0007wl-AL; Tue, 03 Aug 2021 22:15:22 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/6] staging: r8188eu: remove RT_TRACE and DBG_88E prints from os_intfs.c
Date:   Tue,  3 Aug 2021 22:15:07 +0200
Message-Id: <20210803201511.29000-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803201511.29000-1-martin@kaiser.cx>
References: <20210803201511.29000-1-martin@kaiser.cx>
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
 drivers/staging/r8188eu/os_dep/os_intfs.c | 77 +++--------------------
 1 file changed, 9 insertions(+), 68 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 5f1ec883d6ed..4ea78061a204 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -179,10 +179,8 @@ void rtw_proc_init_one(struct net_device *dev)
 		memcpy(rtw_proc_name, DRV_NAME, sizeof(DRV_NAME));
 
 		rtw_proc = create_proc_entry(rtw_proc_name, S_IFDIR, init_net.proc_net);
-		if (!rtw_proc) {
-			DBG_88E(KERN_ERR "Unable to create rtw_proc directory\n");
+		if (!rtw_proc)
 			return;
-		}
 
 		entry = create_proc_read_entry("ver_info", S_IFREG | S_IRUGO, rtw_proc, proc_get_drv_version, dev);
 		if (!entry) {
@@ -697,8 +695,11 @@ static const struct net_device_ops rtw_netdev_ops = {
 
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
@@ -719,8 +720,6 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	struct adapter *padapter;
 	struct net_device *pnetdev;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+init_net_dev\n"));
-
 	if (old_padapter)
 		pnetdev = rtw_alloc_etherdev_with_old_priv(sizeof(struct adapter), (void *)old_padapter);
 	else
@@ -732,7 +731,6 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	pnetdev->dev.type = &wlan_type;
 	padapter = rtw_netdev_priv(pnetdev);
 	padapter->pnetdev = pnetdev;
-	DBG_88E("register rtw_netdev_ops to netdev_ops\n");
 	pnetdev->netdev_ops = &rtw_netdev_ops;
 	pnetdev->watchdog_timeo = HZ*3; /* 3 second timeout */
 	pnetdev->wireless_handlers = (struct iw_handler_def *)&rtw_handlers_def;
@@ -747,8 +745,6 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 {
 	u32 _status = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_start_drv_threads\n"));
-
 	padapter->cmdThread = kthread_run(rtw_cmd_thread, padapter, "RTW_CMD_THREAD");
 	if (IS_ERR(padapter->cmdThread))
 		_status = _FAIL;
@@ -761,8 +757,6 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 
 void rtw_stop_drv_threads(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_stop_drv_threads\n"));
-
 	/* Below is to termindate rtw_cmd_thread & event_thread... */
 	up(&padapter->cmdpriv.cmd_queue_sema);
 	if (padapter->cmdThread)
@@ -858,10 +852,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	u8	ret8 = _SUCCESS;
 	unsigned long flags;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
-
 	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init cmd_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -869,13 +860,11 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
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
@@ -887,25 +876,21 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 #endif /* CONFIG_88EU_P2P */
 
 	if (init_mlme_ext_priv(padapter) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_ext_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
-		DBG_88E("Can't _rtw_init_xmit_priv\n");
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
-		DBG_88E("Can't _rtw_init_recv_priv\n");
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
-		DBG_88E("Can't _rtw_init_sta_priv\n");
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -916,8 +901,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 	rtw_init_pwrctrl_priv(padapter);
 
-	if (init_mp_priv(padapter) == _FAIL)
-		DBG_88E("%s: initialize MP private data Fail!\n", __func__);
+	init_mp_priv(padapter);
 
 	ret8 = rtw_init_default_value(padapter);
 
@@ -929,29 +913,19 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
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
 
@@ -962,8 +936,6 @@ void rtw_cancel_all_timer(struct adapter *padapter)
 
 u8 rtw_free_drv_sw(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("==>rtw_free_drv_sw"));
-
 	/* we can call rtw_p2p_enable here, but: */
 	/*  1. rtw_p2p_enable may have IO operation */
 	/*  2. rtw_p2p_enable is bundled with wext interface */
@@ -998,8 +970,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	rtw_hal_free_data(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("<== rtw_free_drv_sw\n"));
-
 	/* free the old_pnetdev */
 	if (padapter->rereg_nd_name_priv.old_pnetdev) {
 		free_netdev(padapter->rereg_nd_name_priv.old_pnetdev);
@@ -1010,8 +980,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	if (padapter->pbuddy_adapter)
 		padapter->pbuddy_adapter->pbuddy_adapter = NULL;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_free_drv_sw\n"));
-
 	return _SUCCESS;
 }
 
@@ -1050,9 +1018,6 @@ int _netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+88eu_drv - dev_open\n"));
-	DBG_88E("+88eu_drv - drv_open, bup =%d\n", padapter->bup);
-
 	if (pwrctrlpriv->ps_flag) {
 		padapter->net_closed = false;
 		goto netdev_open_normal_process;
@@ -1064,10 +1029,8 @@ int _netdev_open(struct net_device *pnetdev)
 		padapter->bCardDisableWOHSM = false;
 
 		status = rtw_hal_init(padapter);
-		if (status == _FAIL) {
-			RT_TRACE(_module_os_intfs_c_, _drv_err_, ("rtl88eu_hal_init(): Can't init h/w!\n"));
+		if (status == _FAIL)
 			goto netdev_open_error;
-		}
 
 		pr_info("MAC Address = %pM\n", pnetdev->dev_addr);
 
@@ -1104,16 +1067,12 @@ int _netdev_open(struct net_device *pnetdev)
 	netdev_br_init(pnetdev);
 
 netdev_open_normal_process:
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-88eu_drv - dev_open\n"));
-	DBG_88E("-88eu_drv - drv_open, bup =%d\n", padapter->bup);
 	return 0;
 
 netdev_open_error:
 	padapter->bup = false;
 	netif_carrier_off(pnetdev);
 	rtw_netif_stop_queue(pnetdev);
-	RT_TRACE(_module_os_intfs_c_, _drv_err_, ("-88eu_drv - dev_open, fail!\n"));
-	DBG_88E("-88eu_drv - drv_open fail, bup =%d\n", padapter->bup);
 	return -1;
 }
 
@@ -1132,17 +1091,14 @@ static int  ips_netdrv_open(struct adapter *padapter)
 {
 	int status = _SUCCESS;
 	padapter->net_closed = false;
-	DBG_88E("===> %s.........\n", __func__);
 
 	padapter->bDriverStopped = false;
 	padapter->bSurpriseRemoved = false;
 	padapter->bCardDisableWOHSM = false;
 
 	status = rtw_hal_init(padapter);
-	if (status == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("ips_netdrv_open(): Can't init h/w!\n"));
+	if (status == _FAIL)
 		goto netdev_open_error;
-	}
 
 	if (padapter->intf_start)
 		padapter->intf_start(padapter);
@@ -1153,8 +1109,6 @@ static int  ips_netdrv_open(struct adapter *padapter)
 	 return _SUCCESS;
 
 netdev_open_error:
-	DBG_88E("-ips_netdrv_open - drv_open failure, bup =%d\n", padapter->bup);
-
 	return _FAIL;
 }
 
@@ -1162,21 +1116,18 @@ int rtw_ips_pwr_up(struct adapter *padapter)
 {
 	int result;
 	u32 start_time = jiffies;
-	DBG_88E("===>  rtw_ips_pwr_up..............\n");
 	rtw_reset_drv_sw(padapter);
 
 	result = ips_netdrv_open(padapter);
 
 	rtw_led_control(padapter, LED_CTL_NO_LINK);
 
-	DBG_88E("<===  rtw_ips_pwr_up.............. in %dms\n", rtw_get_passing_time_ms(start_time));
 	return result;
 }
 
 void rtw_ips_pwr_down(struct adapter *padapter)
 {
 	u32 start_time = jiffies;
-	DBG_88E("===> rtw_ips_pwr_down...................\n");
 
 	padapter->bCardDisableWOHSM = true;
 	padapter->net_closed = true;
@@ -1185,13 +1136,10 @@ void rtw_ips_pwr_down(struct adapter *padapter)
 
 	rtw_ips_dev_unload(padapter);
 	padapter->bCardDisableWOHSM = false;
-	DBG_88E("<=== rtw_ips_pwr_down..................... in %dms\n", rtw_get_passing_time_ms(start_time));
 }
 
 void rtw_ips_dev_unload(struct adapter *padapter)
 {
-	DBG_88E("====> %s...\n", __func__);
-
 	rtw_hal_set_hwreg(padapter, HW_VAR_FIFO_CLEARN_UP, NULL);
 
 	if (padapter->intf_stop)
@@ -1218,8 +1166,6 @@ int netdev_close(struct net_device *pnetdev)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+88eu_drv - drv_close\n"));
-
 	if (padapter->pwrctrlpriv.bInternalAutoSuspend) {
 		if (padapter->pwrctrlpriv.rf_pwrstate == rf_off)
 			padapter->pwrctrlpriv.ps_flag = true;
@@ -1227,9 +1173,6 @@ int netdev_close(struct net_device *pnetdev)
 	padapter->net_closed = true;
 
 	if (padapter->pwrctrlpriv.rf_pwrstate == rf_on) {
-		DBG_88E("(2)88eu_drv - drv_close, bup =%d, hw_init_completed =%d\n",
-			padapter->bup, padapter->hw_init_completed);
-
 		/* s1. */
 		if (pnetdev) {
 			if (!rtw_netif_queue_stopped(pnetdev))
@@ -1258,7 +1201,5 @@ int netdev_close(struct net_device *pnetdev)
 	kfree(dvobj->firmware.szFwBuffer);
 	dvobj->firmware.szFwBuffer = NULL;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-88eu_drv - drv_close\n"));
-	DBG_88E("-88eu_drv - drv_close, bup =%d\n", padapter->bup);
 	return 0;
 }
-- 
2.20.1

