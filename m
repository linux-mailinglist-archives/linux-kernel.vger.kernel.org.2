Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699823B39F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhFYAKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhFYAK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:26 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833DC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:06 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g4so17464677qkl.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZnc0vzQpRjjaJbIXuAXhS/+m6BMaGuKQTo0uowLOvY=;
        b=AeRpQIxja5piQVJsw9ApfDvnaxqaTXCRZLamEm2tLbBirjUbyd7fzX7d50AAvyD3Rj
         pmZJj6Lzo+DxVLqZyb7c6xp5W3DJ4GQymqsGHUgEMBosTDfk7LwXe9ygvgt46hRrGIqQ
         S8H0993XoPq+GJzapt/A3XzGh1YasCoNZ2da8kR9KWVRMc6nGBk87K+isq4WqlCkBC4f
         nB2v26ZW1ENLYzpKE2NkRM0gW/8RY5Sybr+oMxDPdHqZrpkXUBVCJEuA/yAKAcg3jfFG
         3w9GHoLDMn4pFVDWpta7Fyf37ZO5ncWbjon0eg854MH0Ce9d1s4DO22nBANodncYDAjR
         KpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZnc0vzQpRjjaJbIXuAXhS/+m6BMaGuKQTo0uowLOvY=;
        b=PHoamYArgCvx0KAz0XfIQxIAZ1f1j1DiQFj8X+ssWiQeO3YN/bFDqt/hT1OyElcjcF
         pQt1OXGxdXAnB/TZ+Jd7BGal8hdpbLslrd2bCYs0UPyVorkMzDhDqO+WaOqJeOY4Q5mI
         YOlY+GNVfamryAqFahnkxlSMo9wbERrEdCFLwJgKE1l7HW/GR+6dshd+egCFr0HwxrOO
         1kpc/kXoKdv0IEAhvmL7gf9AaHcoJcJMINZUlJQM6u5JygM0aJ2quKIVGG+sV9m72XoT
         313QQkPQvwLE2jYXnBoQhCjtW6kYdr/XZmpazl6yHoIg89mVc0x+MsenPmoB332vIZQO
         udPA==
X-Gm-Message-State: AOAM532qDcykXP11Mlu7Q1fRZf52FFb581cgk9OYOI/W6M4Yz2kBkWK0
        vfLu+1O2DUn8WM6AL8z92BcK11dk5F5sRw==
X-Google-Smtp-Source: ABdhPJwMLikqrLTBStNvMiA6nCmZrZ4yhDBziBk0J/0msGayVeyxh9QyNSMGbTYRsCSim/gBhkye+A==
X-Received: by 2002:a37:aac1:: with SMTP id t184mr3976504qke.163.1624579685655;
        Thu, 24 Jun 2021 17:08:05 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:04 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 03/23] staging: rtl8188eu: remove all RT_TRACE calls from os_dep/os_intfs.c
Date:   Fri, 25 Jun 2021 01:07:36 +0100
Message-Id: <20210625000756.6313-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from os_dep/os_intfs.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 39 ++-------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 70e9161a429e..950d70978856 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -301,8 +301,6 @@ struct net_device *rtw_init_netdev(void)
 	struct adapter *padapter;
 	struct net_device *pnetdev;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+init_net_dev\n"));
-
 	pnetdev = alloc_etherdev_mq(sizeof(struct adapter), 4);
 	if (!pnetdev)
 		return NULL;
@@ -324,8 +322,6 @@ static int rtw_start_drv_threads(struct adapter *padapter)
 {
 	int err = 0;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+%s\n", __func__));
-
 	padapter->cmdThread = kthread_run(rtw_cmd_thread, padapter, "RTW_CMD_THREAD");
 	if (IS_ERR(padapter->cmdThread)) {
 		err = PTR_ERR(padapter->cmdThread);
@@ -337,8 +333,6 @@ static int rtw_start_drv_threads(struct adapter *padapter)
 
 void rtw_stop_drv_threads(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+%s\n", __func__));
-
 	if (!padapter->cmdThread)
 		return;
 
@@ -421,18 +415,14 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 {
 	u8 ret8 = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+%s\n", __func__));
-
 	rtw_init_cmd_priv(&padapter->cmdpriv);
 
 	if (rtw_init_mlme_priv(padapter) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 	if (init_mlme_ext_priv(padapter) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_ext_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -466,27 +456,19 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	rtw_hal_sreset_init(padapter);
 
 exit:
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-%s\n", __func__));
-
 	return ret8;
 }
 
 void rtw_cancel_all_timer(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+%s\n", __func__));
-
 	del_timer_sync(&padapter->mlmepriv.assoc_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("%s:cancel association timer complete!\n", __func__));
 
 	del_timer_sync(&padapter->mlmepriv.scan_to_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("%s:cancel scan_to_timer!\n", __func__));
 
 	del_timer_sync(&padapter->mlmepriv.dynamic_chk_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("%s:cancel dynamic_chk_timer!\n", __func__));
 
 	/*  cancel sw led timer */
 	rtw_hal_sw_led_deinit(padapter);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("%s:cancel DeInitSwLeds!\n", __func__));
 
 	del_timer_sync(&padapter->pwrctrlpriv.pwr_state_check_timer);
 
@@ -495,8 +477,6 @@ void rtw_cancel_all_timer(struct adapter *padapter)
 
 u8 rtw_free_drv_sw(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("==>%s", __func__));
-
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
 	rtw_free_mlme_priv(&padapter->mlmepriv);
@@ -509,12 +489,8 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	rtw_hal_free_data(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("<== %s\n", __func__));
-
 	mutex_destroy(&padapter->hw_init_mutex);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-%s\n", __func__));
-
 	return _SUCCESS;
 }
 
@@ -525,8 +501,6 @@ static int _netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+88eu_drv - dev_open\n"));
-
 	if (pwrctrlpriv->ps_flag) {
 		padapter->net_closed = false;
 		goto netdev_open_normal_process;
@@ -537,10 +511,8 @@ static int _netdev_open(struct net_device *pnetdev)
 		padapter->bSurpriseRemoved = false;
 
 		status = rtw_hal_init(padapter);
-		if (status == _FAIL) {
-			RT_TRACE(_module_os_intfs_c_, _drv_err_, ("rtl88eu_hal_init(): Can't init h/w!\n"));
+		if (status == _FAIL)
 			goto netdev_open_error;
-		}
 
 		pr_info("MAC Address = %pM\n", pnetdev->dev_addr);
 
@@ -574,14 +546,12 @@ static int _netdev_open(struct net_device *pnetdev)
 		netif_tx_wake_all_queues(pnetdev);
 
 netdev_open_normal_process:
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-88eu_drv - dev_open\n"));
 	return 0;
 
 netdev_open_error:
 	padapter->bup = false;
 	netif_carrier_off(pnetdev);
 	netif_tx_stop_all_queues(pnetdev);
-	RT_TRACE(_module_os_intfs_c_, _drv_err_, ("-88eu_drv - dev_open, fail!\n"));
 	return -1;
 }
 
@@ -607,10 +577,8 @@ int  ips_netdrv_open(struct adapter *padapter)
 	padapter->bSurpriseRemoved = false;
 
 	status = rtw_hal_init(padapter);
-	if (status == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("%s(): Can't init h/w!\n", __func__));
+	if (status == _FAIL)
 		goto netdev_open_error;
-	}
 
 	rtw_hal_inirp_init(padapter);
 
@@ -661,8 +629,6 @@ static int netdev_close(struct net_device *pnetdev)
 {
 	struct adapter *padapter = netdev_priv(pnetdev);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+88eu_drv - drv_close\n"));
-
 	if (padapter->pwrctrlpriv.bInternalAutoSuspend) {
 		if (padapter->pwrctrlpriv.rf_pwrstate == rf_off)
 			padapter->pwrctrlpriv.ps_flag = true;
@@ -689,6 +655,5 @@ static int netdev_close(struct net_device *pnetdev)
 		led_control_8188eu(padapter, LED_CTL_POWER_OFF);
 	}
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-88eu_drv - drv_close\n"));
 	return 0;
 }
-- 
2.31.1

