Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF813DA9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhG2RKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhG2RJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:09:49 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD6C061796
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:46 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t14so9425790oiw.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLH/96za2hneYg41eDWcEtUAcmpg39IO4TzLwlnrUu8=;
        b=IR04GtDBnZp7C9PxQPcFaXsbi7nri6hOL1Mm5JN6mk2XeuyCjUfg6KHHwubEvrXHjh
         w0qc18AwoCftFUaA9NrKL+NK2L15cvBXWjEndO5n7E1zvD4FHZqtAXRnDBDzZMMyRbJP
         btTVMymU+kCnKfg6f5BhqeBwzmAF22idyOeWu2Pi2uWJEsTrLsja52ryQhZPh1x3o/MU
         2tVPmEPTavJvWsIXabP8FPYBHed6m8eGqrPVtMuKLYRSw0PwjAJznqrkAI401X2j9pOU
         e1Mnih8cOWh/HEVk//NV7xNcsuxbOrn0AXaJEMMb7orMEYijDJRUHkbpH13/jhOro8t6
         Pkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bLH/96za2hneYg41eDWcEtUAcmpg39IO4TzLwlnrUu8=;
        b=ZGvLt3stsDir0mWI9qLZgybxbMNcDuck9duPS98iin2LQoiDo//JbRrZt61YU70cKS
         THh30dlYzE6TgHvD5OQ0OrIE5y6I7oSshlZKH1eZGjKEv0On3DWMxRta0UaN/vNGzPzM
         78rXFS8lI2xX4t9L5EgIAWcnt0fWGyj+H5e1hi1iVlQW6BXo+NBGfuKELTKA2YtshaRB
         AMFdgZbdOn7eajZcC7Ze5Xh7e9TOA3+WX50ZPxU8QR1qcaSCimhcLEEXKAQOtXwpKL6R
         jl3HVT+MITRunQmwA/aGOBv9y9jT3ti+ACc2IwDhyHAn5FW/ifRdl062s3H/TLgIbW6z
         M0bA==
X-Gm-Message-State: AOAM5329mPUZ9iN55HQavPMdrxy5IsKk1CMStq/Cd6MN5bAbd6dQ0Ssj
        A51sRrO3+R7HXEJBV6D5ep4=
X-Google-Smtp-Source: ABdhPJwMG5ZjvJhFWtaTo0CkBxNby/k8YsZe+nR5XW7I0xKoQYhfON5RlNhnnpPN6dMuIXemfvZ7aA==
X-Received: by 2002:a05:6808:bcf:: with SMTP id o15mr3868909oik.118.1627578585612;
        Thu, 29 Jul 2021 10:09:45 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id a23sm614358otv.79.2021.07.29.10.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:09:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/6] staging: r8188eu: Remove tests of kernel version
Date:   Thu, 29 Jul 2021 12:09:26 -0500
Message-Id: <20210729170930.23171-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
References: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the GitHub repository from which this driver was derived, old kernels
had to be supported. Now that the driver is included in the kernel,
this code can be removed as well as all mention of version.h.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_led.c        | 12 ----
 drivers/staging/r8188eu/core/rtw_p2p.c        | 53 ----------------
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 12 ----
 drivers/staging/r8188eu/core/rtw_recv.c       | 16 -----
 drivers/staging/r8188eu/core/rtw_xmit.c       |  8 ---
 drivers/staging/r8188eu/hal/odm.c             |  9 ---
 drivers/staging/r8188eu/hal/odm_interface.c   | 10 ---
 drivers/staging/r8188eu/include/odm_precomp.h |  4 --
 .../staging/r8188eu/include/osdep_service.h   | 12 ----
 drivers/staging/r8188eu/include/rtw_led.h     |  4 --
 drivers/staging/r8188eu/include/rtw_mlme.h    |  5 --
 .../staging/r8188eu/include/rtw_security.h    |  8 ---
 drivers/staging/r8188eu/include/usb_ops.h     | 16 -----
 drivers/staging/r8188eu/include/wifi.h        |  3 -
 drivers/staging/r8188eu/os_dep/mlme_linux.c   | 63 -------------------
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c   | 16 -----
 17 files changed, 252 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 37c9766b4c64..ee90e52adc90 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -9,17 +9,9 @@
 /*		Callback function of LED BlinkTimer, */
 /*		it just schedules to corresponding BlinkWorkItem/led_blink_hdl */
 /*  */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 void BlinkTimerCallback(struct timer_list *t)
-#else
-void BlinkTimerCallback(void *data)
-#endif
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	struct LED_871x *pLed = from_timer(pLed, t, BlinkTimer);
-#else
-	struct LED_871x *pLed = (struct LED_871x *)data;
-#endif
 	struct adapter *padapter = pLed->padapter;
 
 	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
@@ -69,11 +61,7 @@ void InitLed871x(struct adapter *padapter, struct LED_871x *pLed, enum LED_PIN_8
 
 	ResetLedStatus(pLed);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	timer_setup(&pLed->BlinkTimer, BlinkTimerCallback, 0);
-#else
-	_init_timer(&(pLed->BlinkTimer), padapter->pnetdev, BlinkTimerCallback, pLed);
-#endif
 	_init_workitem(&(pLed->BlinkWorkItem), BlinkWorkItemCallback, pLed);
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 0c97c42eb420..3ec988fad6ea 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1728,17 +1728,9 @@ u8 p2p_ps_wk_cmd(struct adapter *padapter, u8 p2p_ps_state, u8 enqueue)
 	return res;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 static void reset_ch_sitesurvey_timer_process(struct timer_list *t)
-#else
-static void reset_ch_sitesurvey_timer_process (void *FunctionContext)
-#endif
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	struct adapter *adapter = from_timer(adapter, t, pwrctrlpriv.pwr_state_check_timer);
-#else
-	struct adapter *adapter = (struct adapter *)FunctionContext;
-#endif
 	struct	wifidirect_info		*pwdinfo = &adapter->wdinfo;
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
@@ -1750,17 +1742,9 @@ static void reset_ch_sitesurvey_timer_process (void *FunctionContext)
 	pwdinfo->rx_invitereq_info.scan_op_ch_only = 0;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 static void reset_ch_sitesurvey_timer_process2 (struct timer_list *t)
-#else
-static void reset_ch_sitesurvey_timer_process2 (void *FunctionContext)
-#endif
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	struct adapter *adapter = from_timer(adapter, t, pwrctrlpriv.pwr_state_check_timer);
-#else
-	struct adapter *adapter = (struct adapter *)FunctionContext;
-#endif
 	struct	wifidirect_info		*pwdinfo = &adapter->wdinfo;
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
@@ -1772,17 +1756,9 @@ static void reset_ch_sitesurvey_timer_process2 (void *FunctionContext)
 	pwdinfo->p2p_info.scan_op_ch_only = 0;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 static void restore_p2p_state_timer_process(struct timer_list *t)
-#else
-static void restore_p2p_state_timer_process (void *FunctionContext)
-#endif
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	struct adapter *adapter = from_timer(adapter, t, wdinfo.restore_p2p_state_timer);
-#else
-	struct adapter *adapter = (struct adapter *)FunctionContext;
-#endif
 	struct	wifidirect_info		*pwdinfo = &adapter->wdinfo;
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
@@ -1791,17 +1767,9 @@ static void restore_p2p_state_timer_process (void *FunctionContext)
 	p2p_protocol_wk_cmd(adapter, P2P_RESTORE_STATE_WK);
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 static void pre_tx_scan_timer_process(struct timer_list *t)
-#else
-static void pre_tx_scan_timer_process(void *FunctionContext)
-#endif
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	struct adapter *adapter = from_timer(adapter, t, wdinfo.pre_tx_scan_timer);
-#else
-	struct adapter *adapter = (struct adapter *)FunctionContext;
-#endif
 	struct	wifidirect_info *pwdinfo = &adapter->wdinfo;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
@@ -1829,17 +1797,9 @@ static void pre_tx_scan_timer_process(void *FunctionContext)
 	spin_unlock_bh(&pmlmepriv->lock);
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 static void find_phase_timer_process(struct timer_list *t)
-#else
-static void find_phase_timer_process(void *FunctionContext)
-#endif
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	struct adapter *adapter = from_timer(adapter, t, wdinfo.find_phase_timer);
-#else
-	struct adapter *adapter = (struct adapter *)FunctionContext;
-#endif
 	struct	wifidirect_info		*pwdinfo = &adapter->wdinfo;
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
@@ -1865,19 +1825,11 @@ void rtw_init_wifidirect_timers(struct adapter *padapter)
 {
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	timer_setup(&pwdinfo->find_phase_timer, find_phase_timer_process, 0);
 	timer_setup(&pwdinfo->restore_p2p_state_timer, restore_p2p_state_timer_process, 0);
 	timer_setup(&pwdinfo->pre_tx_scan_timer, pre_tx_scan_timer_process, 0);
 	timer_setup(&pwdinfo->reset_ch_sitesurvey, reset_ch_sitesurvey_timer_process, 0);
 	timer_setup(&pwdinfo->reset_ch_sitesurvey2, reset_ch_sitesurvey_timer_process2, 0);
-#else
-	_init_timer(&pwdinfo->find_phase_timer, padapter->pnetdev, find_phase_timer_process, padapter);
-	_init_timer(&pwdinfo->restore_p2p_state_timer, padapter->pnetdev, restore_p2p_state_timer_process, padapter);
-	_init_timer(&pwdinfo->pre_tx_scan_timer, padapter->pnetdev, pre_tx_scan_timer_process, padapter);
-	_init_timer(&pwdinfo->reset_ch_sitesurvey, padapter->pnetdev, reset_ch_sitesurvey_timer_process, padapter);
-	_init_timer(&pwdinfo->reset_ch_sitesurvey2, padapter->pnetdev, reset_ch_sitesurvey_timer_process2, padapter);
-#endif
 }
 
 void rtw_init_wifidirect_addrs(struct adapter *padapter, u8 *dev_addr, u8 *iface_addr)
@@ -2019,11 +1971,6 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 			_cancel_timer_ex(&pwdinfo->pre_tx_scan_timer);
 			_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
 			_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey2);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
-#else
-			reset_ch_sitesurvey_timer_process(padapter);
-			reset_ch_sitesurvey_timer_process2(padapter);
-#endif
 			rtw_p2p_set_state(pwdinfo, P2P_STATE_NONE);
 			rtw_p2p_set_role(pwdinfo, P2P_ROLE_DISABLE);
 			memset(&pwdinfo->rx_prov_disc_info, 0x00, sizeof(struct rx_provdisc_req_info));
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 56980998e094..a7b63413000b 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -192,19 +192,11 @@ void rtw_ps_processor(struct adapter *padapter)
 	return;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 static void pwr_state_check_handler(struct timer_list *t)
-#else
-static void pwr_state_check_handler(void *FunctionContext)
-#endif
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	struct adapter *padapter =
 		from_timer(padapter, t,
 			   pwrctrlpriv.pwr_state_check_timer);
-#else
-	struct adapter *padapter = (struct adapter *)FunctionContext;
-#endif
 	rtw_ps_cmd(padapter);
 }
 
@@ -492,11 +484,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 
 	pwrctrlpriv->btcoex_rfon = false;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	timer_setup(&pwrctrlpriv->pwr_state_check_timer, pwr_state_check_handler, 0);
-#else
-	_init_timer(&(pwrctrlpriv->pwr_state_check_timer), padapter->pnetdev, pwr_state_check_handler, (u8 *)padapter);
-#endif
 }
 
 void rtw_free_pwrctrl_priv(struct adapter *adapter)
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index f3cbf71a3a4a..3872aa5cb982 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -25,11 +25,7 @@ static u8 rtw_rfc1042_header[] = {
        0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
 };
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 void rtw_signal_stat_timer_hdl(struct timer_list *);
-#else
-void rtw_signal_stat_timer_hdl(RTW_TIMER_HDL_ARGS);
-#endif
 
 void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 {
@@ -91,11 +87,7 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 
 	res = rtw_hal_init_recv_priv(padapter);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	timer_setup(&precvpriv->signal_stat_timer, rtw_signal_stat_timer_hdl, 0);
-#else
-	_init_timer(&precvpriv->signal_stat_timer, padapter->pnetdev, RTW_TIMER_HDL_NAME(signal_stat), padapter);
-#endif
 	precvpriv->signal_stat_sampling_interval = 1000; /* ms */
 
 	rtw_set_signal_stat_timer(precvpriv);
@@ -2174,17 +2166,9 @@ s32 rtw_recv_entry(struct recv_frame *precvframe)
 	return ret;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 void rtw_signal_stat_timer_hdl(struct timer_list *t)
-#else
-void rtw_signal_stat_timer_hdl(RTW_TIMER_HDL_ARGS)
-#endif
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 	struct adapter *adapter = from_timer(adapter, t, recvpriv.signal_stat_timer);
-#else
-	struct adapter *adapter = (struct adapter *)FunctionContext;
-#endif
 	struct recv_priv *recvpriv = &adapter->recvpriv;
 
 	u32 tmp_s, tmp_q;
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 27d82f91c8a7..c2a3d62facd1 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1671,11 +1671,7 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 	void *br_port = NULL;
 
 	rcu_read_lock();
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
 	br_port = rcu_dereference(padapter->pnetdev->rx_handler_data);
-#else
-	br_port = rcu_dereference(padapter->pnetdev->br_port);
-#endif
 	rcu_read_unlock();
 	spin_lock_bh(&padapter->br_ext_lock);
 	if (!(skb->data[0] & 1) && br_port &&
@@ -1859,11 +1855,7 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	}
 
 	rcu_read_lock();
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
 	br_port = rcu_dereference(padapter->pnetdev->rx_handler_data);
-#else
-	br_port = rcu_dereference(padapter->pnetdev->br_port);
-#endif
 	rcu_read_unlock();
 
 	if (br_port && check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_ADHOC_STATE)) {
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 81fe727115d9..a26b2ae35b73 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1563,12 +1563,7 @@ void odm_RSSIMonitorCheckAP(struct odm_dm_struct *pDM_Odm)
 
 void ODM_InitAllTimers(struct odm_dm_struct *pDM_Odm)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	ODM_InitializeTimer(pDM_Odm, &pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer,
-			    (void *)odm_SwAntDivChkAntSwitchCallback, NULL, "SwAntennaSwitchTimer");
-#else
 	timer_setup(&pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer, odm_SwAntDivChkAntSwitchCallback, 0);
-#endif
 }
 
 void ODM_CancelAllTimers(struct odm_dm_struct *pDM_Odm)
@@ -1677,11 +1672,7 @@ void ODM_SwAntDivRestAfterLink(struct odm_dm_struct *pDM_Odm)
 {
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-void odm_SwAntDivChkAntSwitchCallback(void *FunctionContext)
-#else
 void odm_SwAntDivChkAntSwitchCallback(struct timer_list *t)
-#endif
 {
 }
 
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 8875a9954981..e26a6461e70b 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -160,16 +160,6 @@ void ODM_SetTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer, u32
 	_set_timer(pTimer, msDelay); /* ms */
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-void ODM_InitializeTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer,
-			 void *CallBackFunc, void *pContext,
-			 const char *szID)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	_init_timer(pTimer, Adapter->pnetdev, CallBackFunc, pDM_Odm);
-}
-#endif
-
 void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer)
 {
 	_cancel_timer_ex(pTimer);
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index ff2dae597d5b..cec1035e4fe0 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -75,11 +75,7 @@ void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingCheckCE(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingCheckMP(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingCheckAP(struct odm_dm_struct *pDM_Odm);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-void odm_SwAntDivChkAntSwitchCallback(void *FunctionContext);
-#else
 void odm_SwAntDivChkAntSwitchCallback(struct timer_list *t);
-#endif
 void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm);
 void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm);
 
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 5b08e985257a..e61113c2608c 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -4,10 +4,7 @@
 #ifndef __OSDEP_SERVICE_H_
 #define __OSDEP_SERVICE_H_
 
-#include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 11, 0)
 #include <linux/sched/signal.h>
-#endif
 #include <basic_types.h>
 
 #define _FAIL		0
@@ -76,15 +73,6 @@ static inline void rtw_list_delete(struct list_head *plist)
 	list_del_init(plist);
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-static inline void _init_timer(struct timer_list *ptimer,struct  net_device *nic_hdl,void *pfunc,void* cntx)
-{
-	ptimer->function = pfunc;
-	ptimer->data = (unsigned long)cntx;
-	init_timer(ptimer);
-}
-#endif
-
 static inline void _set_timer(struct timer_list *ptimer,u32 delay_time)
 {
 	mod_timer(ptimer , (jiffies+(delay_time*HZ/1000)));
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 128cdc10b9b5..def9d04a20ce 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -163,11 +163,7 @@ struct led_priv{
 			(adapt)->ledpriv.LedControlHandler((adapt), (action)); \
 	} while (0)
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 void BlinkTimerCallback(struct timer_list *t);
-#else
-void BlinkTimerCallback(void *data);
-#endif
 void BlinkWorkItemCallback(struct work_struct *work);
 
 void ResetLedStatus(struct LED_871x * pLed);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 7cab18047cef..3ef1a008c602 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -453,13 +453,8 @@ void indicate_wx_scan_complete_event(struct adapter *padapter);
 void rtw_indicate_wx_assoc_event(struct adapter *padapter);
 void rtw_indicate_wx_disassoc_event(struct adapter *padapter);
 int event_thread(void *context);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-void rtw_join_timeout_handler (void *FunctionContext);
-void _rtw_scan_timeout_handler(void *FunctionContext);
-#else
 void rtw_join_timeout_handler (struct timer_list *t);
 void _rtw_scan_timeout_handler (struct timer_list *t);
-#endif
 void rtw_free_network_queue(struct adapter *adapter, u8 isfreeall);
 int rtw_init_mlme_priv(struct adapter *adapter);
 void rtw_free_mlme_priv (struct mlme_priv *pmlmepriv);
diff --git a/drivers/staging/r8188eu/include/rtw_security.h b/drivers/staging/r8188eu/include/rtw_security.h
index 6e039e87b04d..2d8522c01027 100644
--- a/drivers/staging/r8188eu/include/rtw_security.h
+++ b/drivers/staging/r8188eu/include/rtw_security.h
@@ -152,14 +152,6 @@ struct security_priv {
 	u8 bWepDefaultKeyIdxSet;
 };
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(5, 8, 0)
-struct sha256_state {
-	u64 length;
-	u32 state[8], curlen;
-	u8 buf[64];
-};
-#endif
-
 #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)		\
 do {									\
 	switch (psecuritypriv->dot11AuthAlgrthm) {			\
diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 40e834390a10..9e60b3a9a02a 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -4,7 +4,6 @@
 #ifndef __USB_OPS_H_
 #define __USB_OPS_H_
 
-#include <linux/version.h>
 #include <osdep_service.h>
 #include <drv_types.h>
 #include <osdep_intf.h>
@@ -22,7 +21,6 @@ enum {
 #define MAX_VENDOR_REQ_CMD_SIZE	254	/* 8188cu SIE Support */
 #define MAX_USB_IO_CTL_SIZE	(MAX_VENDOR_REQ_CMD_SIZE + ALIGNMENT_UNIT)
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 12))
 #define rtw_usb_control_msg(dev, pipe, request, requesttype,		\
 			    value, index, data, size, timeout_ms)	\
 	usb_control_msg((dev), (pipe), (request), (requesttype), (value),\
@@ -30,20 +28,6 @@ enum {
 #define rtw_usb_bulk_msg(usb_dev, pipe, data, len, actual_length, timeout_ms) \
 	usb_bulk_msg((usb_dev), (pipe), (data), (len),			\
 		     (actual_length), (timeout_ms))
-#else
-#define rtw_usb_control_msg(dev, pipe, request, requesttype,		\
-			    value, index, data, size, timeout_ms)	\
-	usb_control_msg((dev), (pipe), (request), (requesttype),	\
-			(value), (index), (data), (size),		\
-			((timeout_ms) == 0) ||				\
-			((timeout_ms)*HZ/1000 > 0) ?			\
-			((timeout_ms)*HZ/1000) : 1)
-#define rtw_usb_bulk_msg(usb_dev, pipe, data, len,			\
-			 actual_length, timeout_ms) \
-	usb_bulk_msg((usb_dev), (pipe), (data), (len), (actual_length), \
-		     ((timeout_ms) == 0) || ((timeout_ms)*HZ/1000 > 0) ?\
-		     ((timeout_ms)*HZ/1000) : 1)
-#endif
 #include <usb_ops_linux.h>
 
 void rtl8188eu_set_hw_type(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 9760989ffc4c..2c56d1d70d03 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -714,9 +714,6 @@ enum ht_cap_ampdu_factor {
  * According to IEEE802.11n spec size varies from 8K to 64K (in powers of 2)
  */
 #define IEEE80211_MIN_AMPDU_BUF 0x8
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,19,0))
-#define IEEE80211_MAX_AMPDU_BUF 0x40
-#endif
 
 /* Spatial Multiplexing Power Save Modes */
 #define WLAN_HT_CAP_SM_PS_STATIC	0
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index 22d37e994101..8d78b8697016 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -7,47 +7,23 @@
 #include <drv_types.h>
 #include <mlme_osdep.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-void rtw_join_timeout_handler (void *FunctionContext)
-#else
 void rtw_join_timeout_handler (struct timer_list *t)
-#endif
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	struct adapter *adapter = (struct adapter *)FunctionContext;
-#else
 	struct adapter *adapter = from_timer(adapter, t, mlmepriv.assoc_timer);
-#endif
 
 	_rtw_join_timeout_handler(adapter);
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-void _rtw_scan_timeout_handler (void *FunctionContext)
-#else
 void _rtw_scan_timeout_handler (struct timer_list *t)
-#endif
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	struct adapter *adapter = (struct adapter *)FunctionContext;
-#else
 	struct adapter *adapter = from_timer(adapter, t, mlmepriv.scan_to_timer);
-#endif
 
 	rtw_scan_timeout_handler(adapter);
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-static void _dynamic_check_timer_handlder(void *FunctionContext)
-#else
 static void _dynamic_check_timer_handlder(struct timer_list *t)
-#endif
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	struct adapter *adapter = (struct adapter *)FunctionContext;
-#else
 	struct adapter *adapter = from_timer(adapter, t, mlmepriv.dynamic_chk_timer);
-#endif
 
 	if (adapter->registrypriv.mp_mode == 1)
 		return;
@@ -59,15 +35,9 @@ void rtw_init_mlme_timer(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	_init_timer(&(pmlmepriv->assoc_timer), padapter->pnetdev, rtw_join_timeout_handler, padapter);
-	_init_timer(&(pmlmepriv->scan_to_timer), padapter->pnetdev, _rtw_scan_timeout_handler, padapter);
-	_init_timer(&(pmlmepriv->dynamic_chk_timer), padapter->pnetdev, _dynamic_check_timer_handlder, padapter);
-#else
 	timer_setup(&pmlmepriv->assoc_timer, rtw_join_timeout_handler, 0);
 	timer_setup(&pmlmepriv->scan_to_timer, _rtw_scan_timeout_handler, 0);
 	timer_setup(&pmlmepriv->dynamic_chk_timer, _dynamic_check_timer_handlder, 0);
-#endif
 }
 
 void rtw_os_indicate_connect(struct adapter *adapter)
@@ -169,69 +139,36 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	}
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-static void _survey_timer_hdl(void *FunctionContext)
-#else
 static void _survey_timer_hdl(struct timer_list *t)
-#endif
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	struct adapter *padapter = (struct adapter *)FunctionContext;
-#else
 	struct adapter *padapter = from_timer(padapter, t, mlmeextpriv.survey_timer);
-#endif
 
 	survey_timer_hdl(padapter);
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-static void _link_timer_hdl(void *FunctionContext)
-#else
 static void _link_timer_hdl(struct timer_list *t)
-#endif
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	struct adapter *padapter = (struct adapter *)FunctionContext;
-#else
 	struct adapter *padapter = from_timer(padapter, t, mlmeextpriv.link_timer);
-#endif
 	link_timer_hdl(padapter);
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-static void _addba_timer_hdl(void *FunctionContext)
-#else
 static void _addba_timer_hdl(struct timer_list *t)
-#endif
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	struct sta_info *psta = (struct sta_info *)FunctionContext;
-#else
 	struct sta_info *psta = from_timer(psta, t, addba_retry_timer);
-#endif
 	addba_timer_hdl(psta);
 }
 
 void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	_init_timer(&psta->addba_retry_timer, padapter->pnetdev, _addba_timer_hdl, psta);
-#else
 	timer_setup(&psta->addba_retry_timer, _addba_timer_hdl, 0);
-#endif
 }
 
 void init_mlme_ext_timer(struct adapter *padapter)
 {
 	struct	mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	_init_timer(&pmlmeext->survey_timer, padapter->pnetdev, _survey_timer_hdl, padapter);
-	_init_timer(&pmlmeext->link_timer, padapter->pnetdev, _link_timer_hdl, padapter);
-#else
 	timer_setup(&pmlmeext->survey_timer, _survey_timer_hdl, 0);
 	timer_setup(&pmlmeext->link_timer, _link_timer_hdl, 0);
-#endif
 }
 
 #ifdef CONFIG_88EU_AP_MODE
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 2cf91516d739..454b94b037f3 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -3,7 +3,6 @@
 
 #define _OS_INTFS_C_
 
-#include <linux/version.h>
 #include <osdep_service.h>
 #include <drv_types.h>
 #include <xmit_osdep.h>
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 558050c62bb1..5af8ffac870b 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -179,11 +179,7 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	}
 
 	rcu_read_lock();
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
 	rcu_dereference(padapter->pnetdev->rx_handler_data);
-#else
-	rcu_dereference(padapter->pnetdev->br_port);
-#endif
 	rcu_read_unlock();
 
 	skb->ip_summed = CHECKSUM_NONE;
@@ -226,19 +222,11 @@ void rtw_os_read_port(struct adapter *padapter, struct recv_buf *precvbuf)
 			      (unsigned char *)precvbuf);
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-static void _rtw_reordering_ctrl_timeout_handler(void *func_context)
-#else
 static void _rtw_reordering_ctrl_timeout_handler(struct timer_list *t)
-#endif
 {
 	struct recv_reorder_ctrl *preorder_ctrl;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	preorder_ctrl = (struct recv_reorder_ctrl *)func_context;
-#else
 	preorder_ctrl = from_timer(preorder_ctrl, t, reordering_ctrl_timer);
-#endif
 	rtw_reordering_ctrl_timeout_handler(preorder_ctrl);
 }
 
@@ -246,9 +234,5 @@ void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl)
 {
 	struct adapter *padapter = preorder_ctrl->padapter;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
-	_init_timer(&(preorder_ctrl->reordering_ctrl_timer), padapter->pnetdev, _rtw_reordering_ctrl_timeout_handler, preorder_ctrl);
-#else
 	timer_setup(&preorder_ctrl->reordering_ctrl_timer, _rtw_reordering_ctrl_timeout_handler, 0);
-#endif
 }
-- 
2.32.0

