Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC00351221
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhDAJX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbhDAJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FFCC061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r12so1851369ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKcFi2fc3Wy8Z1lrS6DNKXPqI4a6Z8RYVdRQPPrB/cA=;
        b=kqq0tb1Oa2/z6XdiEY1gc+SJeQTuij5WjYRqoYHnoyQVIFLo/gPc/JIAPhbuTP0n9f
         p7/r491nc3vk9NkZbBNMgT9uyVrad3dx+50hLgWLoC3mlKgGDSlDvnO5VcjnZMwRaMnF
         4pzXfTq4sHazDNTOhZCCk9NIsY5mz6Sf3xVn8tm2SlCzvnvFsbiLB/C9grFxtpElPnbH
         Jl4jsdak988ziKRLiB5bxJ5T2/D3QkSyA62fg6urgupWZopCqr4Q9y/s+Yf2mnDHbUT8
         mfzqKFtjDsZybTTDNStD7aqaybqO/MQuibIOkGBezMaAr7XCTsYaASAeMdxiYA3e/C/h
         F2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKcFi2fc3Wy8Z1lrS6DNKXPqI4a6Z8RYVdRQPPrB/cA=;
        b=nFNxG+q+zoKPIQwDjYvbIjluU+3mkVSmYwYPQY/t1gNnBlYglYVSDSYL7EoetzACmR
         qw+Tan1u33c1k64gxgiNBITQ9w7hUcIxOU199Kgx/qoT1iYneUgkF/mg9XRx4tB8RSY6
         gj0awAnCRqPyUo8pT3V8BsUdeIuzZi8n3EYgcSsp4dRhkhr1TY6atW3gm2+qLnuNU3pz
         MK9ye9c1ipCCPZmlaG1QclTs6mdpRimF/ojN4lor2DNZQKCq+VYCuDj/srenU0COGXm3
         d6ieTukb92myLwq9Qdv5Z7Y4EZ1hlhehGjKbUncWl3jHvmMNN159fW+LKf+bZbszzMnZ
         qciQ==
X-Gm-Message-State: AOAM532iewOWn+JqS7Pvo2+XJbayXxFvfKdOjAuudtffDR0dhkinzON6
        5qaPlSPHssqIOfImniIsIug=
X-Google-Smtp-Source: ABdhPJwesXiGKuy2YG81D4j2x22aJCNt3T6u6G1A5JWUuRPYBx/7dHnROtcsUeHIQejSkOCTpv+6Ww==
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr8361704eja.287.1617268961227;
        Thu, 01 Apr 2021 02:22:41 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id gn3sm2436875ejc.2.2021.04.01.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:40 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 48/49] staging: rtl8723bs: remove RT_TRACE logs in os_dep/os_intfs.c
Date:   Thu,  1 Apr 2021 11:21:18 +0200
Message-Id: <ca0acbfba4f426de530a5701d133180154861009.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 45 ---------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 405aa95af579..902ea040da25 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -479,8 +479,6 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	struct adapter *padapter;
 	struct net_device *pnetdev;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+init_net_dev\n"));
-
 	if (old_padapter)
 		pnetdev = rtw_alloc_etherdev_with_old_priv(sizeof(struct adapter), (void *)old_padapter);
 	else
@@ -529,7 +527,6 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 {
 	u32 _status = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_start_drv_threads\n"));
 	padapter->xmitThread = kthread_run(rtw_xmit_thread, padapter, "RTW_XMIT_THREAD");
 	if (IS_ERR(padapter->xmitThread))
 		_status = _FAIL;
@@ -546,14 +543,11 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 
 void rtw_stop_drv_threads(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_stop_drv_threads\n"));
-
 	rtw_stop_cmd_thread(padapter);
 
 	/*  Below is to termindate tx_thread... */
 	complete(&padapter->xmitpriv.xmit_comp);
 	wait_for_completion(&padapter->xmitpriv.terminate_xmitthread_comp);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("\n drv_halt: rtw_xmit_thread can be terminated !\n"));
 
 	rtw_hal_stop_thread(padapter);
 }
@@ -697,14 +691,11 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 {
 	u8 ret8 = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
-
 	rtw_init_default_value(padapter);
 
 	rtw_init_hal_com_default_value(padapter);
 
 	if (rtw_init_cmd_priv(&padapter->cmdpriv)) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init cmd_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -712,14 +703,12 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	padapter->cmdpriv.padapter = padapter;
 
 	if (rtw_init_evt_priv(&padapter->evtpriv)) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init evt_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 
 	if (rtw_init_mlme_priv(padapter) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -760,29 +749,21 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 exit:
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_init_drv_sw\n"));
-
 	return ret8;
 }
 
 void rtw_cancel_all_timer(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_cancel_all_timer\n"));
-
 	del_timer_sync(&padapter->mlmepriv.assoc_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel association timer complete!\n"));
 
 	del_timer_sync(&padapter->mlmepriv.scan_to_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel scan_to_timer!\n"));
 
 	del_timer_sync(&padapter->mlmepriv.dynamic_chk_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel dynamic_chk_timer!\n"));
 
 	del_timer_sync(&(adapter_to_pwrctl(padapter)->pwr_state_check_timer));
 
 	del_timer_sync(&padapter->mlmepriv.set_scan_deny_timer);
 	rtw_clear_scan_deny(padapter);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel set_scan_deny_timer!\n"));
 
 	del_timer_sync(&padapter->recvpriv.signal_stat_timer);
 
@@ -792,8 +773,6 @@ void rtw_cancel_all_timer(struct adapter *padapter)
 
 u8 rtw_free_drv_sw(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("==>rtw_free_drv_sw"));
-
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
 	rtw_free_cmd_priv(&padapter->cmdpriv);
@@ -816,8 +795,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	rtw_hal_free_data(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("<==rtw_free_drv_sw\n"));
-
 	/* free the old_pnetdev */
 	if (padapter->rereg_nd_name_priv.old_pnetdev) {
 		free_netdev(padapter->rereg_nd_name_priv.old_pnetdev);
@@ -828,8 +805,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	if (padapter->pbuddy_adapter)
 		padapter->pbuddy_adapter->pbuddy_adapter = NULL;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_free_drv_sw\n"));
-
 	return _SUCCESS;
 }
 
@@ -879,7 +854,6 @@ static int _netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+871x_drv - dev_open\n"));
 	DBG_871X("+871x_drv - drv_open, bup =%d\n", padapter->bup);
 
 	padapter->netif_up = true;
@@ -896,7 +870,6 @@ static int _netdev_open(struct net_device *pnetdev)
 
 		status = rtw_hal_init(padapter);
 		if (status == _FAIL) {
-			RT_TRACE(_module_os_intfs_c_, _drv_err_, ("rtl871x_hal_init(): Can't init h/w!\n"));
 			goto netdev_open_error;
 		}
 
@@ -927,7 +900,6 @@ static int _netdev_open(struct net_device *pnetdev)
 
 netdev_open_normal_process:
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-871x_drv - dev_open\n"));
 	DBG_871X("-871x_drv - drv_open, bup =%d\n", padapter->bup);
 
 	return 0;
@@ -939,7 +911,6 @@ static int _netdev_open(struct net_device *pnetdev)
 	netif_carrier_off(pnetdev);
 	rtw_netif_stop_queue(pnetdev);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_err_, ("-871x_drv - dev_open, fail!\n"));
 	DBG_871X("-871x_drv - drv_open fail, bup =%d\n", padapter->bup);
 
 	return (-1);
@@ -978,7 +949,6 @@ static int  ips_netdrv_open(struct adapter *padapter)
 
 	status = rtw_hal_init(padapter);
 	if (status == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("ips_netdrv_open(): Can't init h/w!\n"));
 		goto netdev_open_error;
 	}
 
@@ -1050,8 +1020,6 @@ static int netdev_close(struct net_device *pnetdev)
 	struct adapter *padapter = rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctl = adapter_to_pwrctl(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+871x_drv - drv_close\n"));
-
 	if (pwrctl->bInternalAutoSuspend) {
 		/* rtw_pwr_wakeup(padapter); */
 		if (pwrctl->rf_pwrstate == rf_off)
@@ -1092,7 +1060,6 @@ static int netdev_close(struct net_device *pnetdev)
 	rtw_scan_abort(padapter);
 	adapter_wdev_data(padapter)->bandroid_scan = false;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-871x_drv - drv_close\n"));
 	DBG_871X("-871x_drv - drv_close, bup =%d\n", padapter->bup);
 
 	return 0;
@@ -1113,8 +1080,6 @@ void rtw_dev_unload(struct adapter *padapter)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	u8 cnt = 0;
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+%s\n", __func__));
-
 	if (padapter->bup) {
 
 		padapter->bDriverStopped = true;
@@ -1124,8 +1089,6 @@ void rtw_dev_unload(struct adapter *padapter)
 		if (padapter->intf_stop)
 			padapter->intf_stop(padapter);
 
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ rtw_dev_unload: stop intf complete!\n"));
-
 		if (!pwrctl->bInternalAutoSuspend)
 			rtw_stop_drv_threads(padapter);
 
@@ -1140,8 +1103,6 @@ void rtw_dev_unload(struct adapter *padapter)
 			}
 		}
 
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ %s: stop thread complete!\n", __func__));
-
 		/* check the status of IPS */
 		if (rtw_hal_check_ips_status(padapter) || pwrctl->rf_pwrstate == rf_off) {
 			/* check HW status and SW state */
@@ -1160,17 +1121,13 @@ void rtw_dev_unload(struct adapter *padapter)
 
 			padapter->bSurpriseRemoved = true;
 		}
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_,
-			 ("@ %s: deinit hal complete!\n", __func__));
 
 		padapter->bup = false;
 
 	} else {
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("%s: bup ==false\n", __func__));
 		DBG_871X("%s: bup ==false\n", __func__);
 	}
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("-%s\n", __func__));
 }
 
 static int rtw_suspend_free_assoc_resource(struct adapter *padapter)
@@ -1329,14 +1286,12 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 	/* if (sdio_init(adapter_to_dvobj(padapter)) != _SUCCESS) */
 	if ((padapter->intf_init) && (padapter->intf_init(adapter_to_dvobj(padapter)) != _SUCCESS)) {
 		ret = -1;
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: initialize SDIO Failed!!\n", __func__));
 		goto exit;
 	}
 	rtw_hal_disable_interrupt(padapter);
 	/* if (sdio_alloc_irq(adapter_to_dvobj(padapter)) != _SUCCESS) */
 	if ((padapter->intf_alloc_irq) && (padapter->intf_alloc_irq(adapter_to_dvobj(padapter)) != _SUCCESS)) {
 		ret = -1;
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: sdio_alloc_irq Failed!!\n", __func__));
 		goto exit;
 	}
 
-- 
2.20.1

