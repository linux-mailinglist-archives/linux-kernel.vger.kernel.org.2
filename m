Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C7934FD54
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhCaJmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbhCaJlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2E7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j3so21475427edp.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8FXPpLLADsZI/wAhBXoOsztEBJgB12aQSgCOdnpYtYA=;
        b=AJQr40enzUaHQUmPAsQl9Gkjj7rU5tiyA9i6wFb9njxU5Yhsaos4KPcodp8mlVnDS+
         RHkzPOhZwBF4SPrvBrQoJmZmc+fZ/orovcwo0QSCMoZh7g+RM6pPLB0ZLz0vPpFEu1W2
         BIY0n+4fie+cX7iumRp4j3vKHOC3WmvHY4xwZNuLqoL/K5eSCjIw+SB3/VIzDaIJdKw3
         TgIrwI/4lLzdHRzdlEvHX82D9nn7ualsVFQ4kRs5nxtKBG+uKaztHQp+wuQhKkHm5ecI
         b6n0bxwEdbHeGCrVVwm+wUKijVAJh5MACzNoqhsO/8TocWbTkxMCCFj0S7Zix/TR8m4I
         py8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8FXPpLLADsZI/wAhBXoOsztEBJgB12aQSgCOdnpYtYA=;
        b=L6j3Xe6p2sFPadjrMhhAPE33xVYBwXnsUjMmHyvuduA36e6X3IPAKLGDfBZihhjLII
         MJ+oPKVc7pBjxZEpfbbRutz/SfrEH7DM+VHkRCWMdMF6NSfXxbuy9ciU4hyha2FhLPLe
         x+GoDnFK1cuPZcIsHyouM5CoAN6r9clqJU43roJf0I7VUWBPFdvEEufq4I4VF7Qdc84B
         C9JW0lgO33TpIB6qbBxmvdXuzlHJajBSSZ4bgkPWX6WVbrpuArhXfal664bZ56k3DOoI
         HZQtuw3fIOY4gViqhdRkQ5JSTw9EZCyWzq2XUVztLNieCfB7iNvfFOeH3+AQbSPzH2WA
         l+qA==
X-Gm-Message-State: AOAM532ZCGTrItbCgtYFKFe7l/nQ57uswsOtt//MwslYsgOqDx1PPFzV
        60xoHxqvyeV5ISHaJcIsAV4=
X-Google-Smtp-Source: ABdhPJzWcWn4Dd2PFAubFb0/5am4shrXMv2QsRMu6UAZ8RoGqpnrErJBm1ngkdPollGBvSv5TJ3dGQ==
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr2574401edu.100.1617183677490;
        Wed, 31 Mar 2021 02:41:17 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id hy25sm816772ejc.119.2021.03.31.02.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 35/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in os_dep/os_intfs.c
Date:   Wed, 31 Mar 2021 11:40:03 +0200
Message-Id: <5dbcc13fba646c44999a22ccfec1668836818646.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 65 ++++++++++-----------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 405aa95af579..1c6530d34cb8 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -479,7 +479,7 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	struct adapter *padapter;
 	struct net_device *pnetdev;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+init_net_dev\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	if (old_padapter)
 		pnetdev = rtw_alloc_etherdev_with_old_priv(sizeof(struct adapter), (void *)old_padapter);
@@ -529,7 +529,7 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 {
 	u32 _status = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_start_drv_threads\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 	padapter->xmitThread = kthread_run(rtw_xmit_thread, padapter, "RTW_XMIT_THREAD");
 	if (IS_ERR(padapter->xmitThread))
 		_status = _FAIL;
@@ -546,14 +546,14 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 
 void rtw_stop_drv_threads(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_stop_drv_threads\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	rtw_stop_cmd_thread(padapter);
 
 	/*  Below is to termindate tx_thread... */
 	complete(&padapter->xmitpriv.xmit_comp);
 	wait_for_completion(&padapter->xmitpriv.terminate_xmitthread_comp);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("\n drv_halt: rtw_xmit_thread can be terminated !\n"));
+	pr_info("%s drv_halt: rtw_xmit_thread can be terminated !\n", DRIVER_PREFIX);
 
 	rtw_hal_stop_thread(padapter);
 }
@@ -697,14 +697,14 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 {
 	u8 ret8 = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	rtw_init_default_value(padapter);
 
 	rtw_init_hal_com_default_value(padapter);
 
 	if (rtw_init_cmd_priv(&padapter->cmdpriv)) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init cmd_priv\n"));
+		pr_err("%s %s Can't init cmd_priv\n", DRIVER_PREFIX, __func__);
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -712,14 +712,14 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	padapter->cmdpriv.padapter = padapter;
 
 	if (rtw_init_evt_priv(&padapter->evtpriv)) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init evt_priv\n"));
+		pr_err("%s Can't init evt_priv\n", DRIVER_PREFIX);
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 
 	if (rtw_init_mlme_priv(padapter) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_priv\n"));
+		pr_err("%s Can't init mlme_priv\n", DRIVER_PREFIX);
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -760,29 +760,29 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 exit:
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_init_drv_sw\n"));
+	pr_info("%s-%s\n", DRIVER_PREFIX, __func__);
 
 	return ret8;
 }
 
 void rtw_cancel_all_timer(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_cancel_all_timer\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	del_timer_sync(&padapter->mlmepriv.assoc_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel association timer complete!\n"));
+	pr_info("%s %s:cancel association timer complete!\n", DRIVER_PREFIX, __func__);
 
 	del_timer_sync(&padapter->mlmepriv.scan_to_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel scan_to_timer!\n"));
+	pr_info("%s %s:cancel scan_to_timer!\n", DRIVER_PREFIX, __func__);
 
 	del_timer_sync(&padapter->mlmepriv.dynamic_chk_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel dynamic_chk_timer!\n"));
+	pr_info("%s %s:cancel dynamic_chk_timer!\n", DRIVER_PREFIX, __func__);
 
 	del_timer_sync(&(adapter_to_pwrctl(padapter)->pwr_state_check_timer));
 
 	del_timer_sync(&padapter->mlmepriv.set_scan_deny_timer);
 	rtw_clear_scan_deny(padapter);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel set_scan_deny_timer!\n"));
+	pr_info("%s %s:cancel set_scan_deny_timer!\n", DRIVER_PREFIX, __func__);
 
 	del_timer_sync(&padapter->recvpriv.signal_stat_timer);
 
@@ -792,7 +792,7 @@ void rtw_cancel_all_timer(struct adapter *padapter)
 
 u8 rtw_free_drv_sw(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("==>rtw_free_drv_sw"));
+	pr_info("%s ==> %s", DRIVER_PREFIX, __func__);
 
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
@@ -816,7 +816,7 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	rtw_hal_free_data(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("<==rtw_free_drv_sw\n"));
+	pr_info("%s <== %s\n", DRIVER_PREFIX, __func__);
 
 	/* free the old_pnetdev */
 	if (padapter->rereg_nd_name_priv.old_pnetdev) {
@@ -828,7 +828,7 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	if (padapter->pbuddy_adapter)
 		padapter->pbuddy_adapter->pbuddy_adapter = NULL;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_free_drv_sw\n"));
+	pr_info("%s-%s\n", DRIVER_PREFIX, __func__);
 
 	return _SUCCESS;
 }
@@ -879,7 +879,7 @@ static int _netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+871x_drv - dev_open\n"));
+	pr_info("%s+871x_drv - dev_open\n", DRIVER_PREFIX);
 	DBG_871X("+871x_drv - drv_open, bup =%d\n", padapter->bup);
 
 	padapter->netif_up = true;
@@ -896,7 +896,7 @@ static int _netdev_open(struct net_device *pnetdev)
 
 		status = rtw_hal_init(padapter);
 		if (status == _FAIL) {
-			RT_TRACE(_module_os_intfs_c_, _drv_err_, ("rtl871x_hal_init(): Can't init h/w!\n"));
+			pr_err("%s rtl871x_hal_init(): Can't init h/w!\n", DRIVER_PREFIX);
 			goto netdev_open_error;
 		}
 
@@ -927,7 +927,7 @@ static int _netdev_open(struct net_device *pnetdev)
 
 netdev_open_normal_process:
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-871x_drv - dev_open\n"));
+	pr_info("%s -871x_drv - dev_open\n", DRIVER_PREFIX);
 	DBG_871X("-871x_drv - drv_open, bup =%d\n", padapter->bup);
 
 	return 0;
@@ -939,7 +939,7 @@ static int _netdev_open(struct net_device *pnetdev)
 	netif_carrier_off(pnetdev);
 	rtw_netif_stop_queue(pnetdev);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_err_, ("-871x_drv - dev_open, fail!\n"));
+	pr_err("%s -871x_drv - dev_open, fail!\n", DRIVER_PREFIX);
 	DBG_871X("-871x_drv - drv_open fail, bup =%d\n", padapter->bup);
 
 	return (-1);
@@ -978,7 +978,7 @@ static int  ips_netdrv_open(struct adapter *padapter)
 
 	status = rtw_hal_init(padapter);
 	if (status == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("ips_netdrv_open(): Can't init h/w!\n"));
+		pr_err("%s %s: Can't init h/w!\n", DRIVER_PREFIX, __func__);
 		goto netdev_open_error;
 	}
 
@@ -1050,7 +1050,7 @@ static int netdev_close(struct net_device *pnetdev)
 	struct adapter *padapter = rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctl = adapter_to_pwrctl(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+871x_drv - drv_close\n"));
+	pr_info("%s+871x_drv - drv_close\n", DRIVER_PREFIX);
 
 	if (pwrctl->bInternalAutoSuspend) {
 		/* rtw_pwr_wakeup(padapter); */
@@ -1092,7 +1092,7 @@ static int netdev_close(struct net_device *pnetdev)
 	rtw_scan_abort(padapter);
 	adapter_wdev_data(padapter)->bandroid_scan = false;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-871x_drv - drv_close\n"));
+	pr_info("%s-871x_drv - drv_close\n", DRIVER_PREFIX);
 	DBG_871X("-871x_drv - drv_close, bup =%d\n", padapter->bup);
 
 	return 0;
@@ -1113,7 +1113,7 @@ void rtw_dev_unload(struct adapter *padapter)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	u8 cnt = 0;
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+%s\n", __func__));
+	pr_notice("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	if (padapter->bup) {
 
@@ -1124,7 +1124,7 @@ void rtw_dev_unload(struct adapter *padapter)
 		if (padapter->intf_stop)
 			padapter->intf_stop(padapter);
 
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ rtw_dev_unload: stop intf complete!\n"));
+		pr_notice("%s @ %s: stop intf complete!\n", DRIVER_PREFIX, __func__);
 
 		if (!pwrctl->bInternalAutoSuspend)
 			rtw_stop_drv_threads(padapter);
@@ -1140,7 +1140,7 @@ void rtw_dev_unload(struct adapter *padapter)
 			}
 		}
 
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ %s: stop thread complete!\n", __func__));
+		pr_notice("%s @ %s: stop thread complete!\n", DRIVER_PREFIX, __func__);
 
 		/* check the status of IPS */
 		if (rtw_hal_check_ips_status(padapter) || pwrctl->rf_pwrstate == rf_off) {
@@ -1160,17 +1160,16 @@ void rtw_dev_unload(struct adapter *padapter)
 
 			padapter->bSurpriseRemoved = true;
 		}
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_,
-			 ("@ %s: deinit hal complete!\n", __func__));
+		pr_notice("%s @ %s: deinit hal complete!\n", DRIVER_PREFIX, __func__);
 
 		padapter->bup = false;
 
 	} else {
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("%s: bup ==false\n", __func__));
+		pr_notice("%s %s: bup ==false\n", DRIVER_PREFIX, __func__);
 		DBG_871X("%s: bup ==false\n", __func__);
 	}
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("-%s\n", __func__));
+	pr_notice("%s-%s\n", DRIVER_PREFIX, __func__);
 }
 
 static int rtw_suspend_free_assoc_resource(struct adapter *padapter)
@@ -1329,14 +1328,14 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 	/* if (sdio_init(adapter_to_dvobj(padapter)) != _SUCCESS) */
 	if ((padapter->intf_init) && (padapter->intf_init(adapter_to_dvobj(padapter)) != _SUCCESS)) {
 		ret = -1;
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: initialize SDIO Failed!!\n", __func__));
+		pr_err("%s %s: initialize SDIO Failed!!\n", DRIVER_PREFIX, __func__);
 		goto exit;
 	}
 	rtw_hal_disable_interrupt(padapter);
 	/* if (sdio_alloc_irq(adapter_to_dvobj(padapter)) != _SUCCESS) */
 	if ((padapter->intf_alloc_irq) && (padapter->intf_alloc_irq(adapter_to_dvobj(padapter)) != _SUCCESS)) {
 		ret = -1;
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: sdio_alloc_irq Failed!!\n", __func__));
+		pr_err("%s %s: sdio_alloc_irq Failed!!\n", DRIVER_PREFIX, __func__);
 		goto exit;
 	}
 
-- 
2.20.1

