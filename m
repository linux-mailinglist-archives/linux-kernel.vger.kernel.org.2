Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6517F3A72D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFOASF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFOASD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:03 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82CAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:43 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a15so9935526qtx.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qu18AVonD1gBKRBU0+Dl98hCQ8kYd88HRAYfFcexAB8=;
        b=RMaaDiMxtVb3w62p5IGV45uPURzLkVcTgNW6a+GfmQLZgLie4aGbWMugceP9nmsxIu
         91ZF+x6IT9TUdRsjrAm4FzhI26qhiZRB467tOcwOQxDVh8IFrLnR6ec7IJ/vzy9ebgYa
         gmq7UJxnTj2xSgOtSRG1N7g8Beb8ouM/lXymQ+XlYnj1DlLL6eC6Wru5bu+5xAAh2Tnv
         5SWfEZToIVCcmbueJgX0Rz8q/Sr6c4xsZJZBfPD2c0UK9XO/OnU9tFey9km9r5bwqI++
         C9SIqICgu086s6dIgZxkDgrBHMT3MvwpMxKKGd5EQrcVYn6PKUlwTuby8UCha4OUMJpf
         FJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qu18AVonD1gBKRBU0+Dl98hCQ8kYd88HRAYfFcexAB8=;
        b=cFYKRBPAAfhKT1mVwgi+VVR4SEYGNPalMWgWDBZztYqeQ2jq6QQmaXCcBU34s3CJTU
         1sxtKDYbwKq9cAeVB1FCgBFgHYUWOWvA6HtqTI1X6F5MlGL2arTMq4gUfRxZkjKCuaD6
         lLAy7TgH/mgfqdLc0ZEgLCN6NQVhYfQyoukuEeNUrzAjpy65lFACY9pBcOtx09DVS0hI
         dp1JPEaJ6WmQcJmw2Y8GE5a4vWcyHmd9jeZ5FkJ3VR0dGZVhwf7iB54genT0OsdtTDUO
         BSP6TQT9MPRMYeQjqseLEuvJcLQkmh9LDByG1ZzN/6I6wTzMFBWi9bQuQWAKIW/qDrW3
         LQsg==
X-Gm-Message-State: AOAM531Hou2L0KFKmv5w01p2cFYngqFRppmHy1ejQg1nQD25U4uzr+rE
        t5cWuImxCex0QKYDTAbBQbNR9w==
X-Google-Smtp-Source: ABdhPJy7LBDmAd7zVubg/CLky7McjR/AVmM2K36yaYmxC7XDrC8UoxVAPw5S87zMpGu+LXknQBT82A==
X-Received: by 2002:ac8:5394:: with SMTP id x20mr19164760qtp.192.1623716143000;
        Mon, 14 Jun 2021 17:15:43 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:42 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 06/28] staging: rtl8188eu: remove all DBG_88E calls from core/rtw_pwrctrl.c
Date:   Tue, 15 Jun 2021 01:14:45 +0100
Message-Id: <20210615001507.1171-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from core/rtw_pwrctrl.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself. Also remove pmlmepriv declaration from within rtw_ps_processor
as it is now no longer used.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 40 +-------------------
 1 file changed, 2 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index 4d507d9faec2..f6fe43e0965d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -18,17 +18,12 @@ static int rtw_hw_suspend(struct adapter *padapter)
 	struct net_device *pnetdev = padapter->pnetdev;
 
 	if ((!padapter->bup) || (padapter->bDriverStopped) ||
-	    (padapter->bSurpriseRemoved)) {
-		DBG_88E("padapter->bup=%d bDriverStopped=%d bSurpriseRemoved = %d\n",
-			padapter->bup, padapter->bDriverStopped,
-			padapter->bSurpriseRemoved);
+	    (padapter->bSurpriseRemoved))
 		goto error_exit;
-	}
 
 	/* system suspend */
 	LeaveAllPowerSaveMode(padapter);
 
-	DBG_88E("==> %s\n", __func__);
 	mutex_lock(&pwrpriv->mutex_lock);
 	pwrpriv->bips_processing = true;
 	/* s1. */
@@ -69,7 +64,6 @@ static int rtw_hw_suspend(struct adapter *padapter)
 	return 0;
 
 error_exit:
-	DBG_88E("%s, failed\n", __func__);
 	return -1;
 }
 
@@ -79,7 +73,6 @@ static int rtw_hw_resume(struct adapter *padapter)
 	struct net_device *pnetdev = padapter->pnetdev;
 
 	/* system resume */
-	DBG_88E("==> %s\n", __func__);
 	mutex_lock(&pwrpriv->mutex_lock);
 	pwrpriv->bips_processing = true;
 	rtw_reset_drv_sw(padapter);
@@ -107,7 +100,6 @@ static int rtw_hw_resume(struct adapter *padapter)
 
 	return 0;
 error_exit:
-	DBG_88E("%s, Open net dev failed\n", __func__);
 	return -1;
 }
 
@@ -135,7 +127,6 @@ void ips_enter(struct adapter *padapter)
 	pwrpriv->ips_mode = pwrpriv->ips_mode_req;
 
 	pwrpriv->ips_enter_cnts++;
-	DBG_88E("==>%s:%d\n", __func__, pwrpriv->ips_enter_cnts);
 	if (rf_off == pwrpriv->change_rfpwrstate) {
 		pwrpriv->bpower_saving = true;
 		DBG_88E_LEVEL(_drv_info_, "nolinked power save enter\n");
@@ -165,7 +156,6 @@ int ips_leave(struct adapter *padapter)
 		pwrpriv->bips_processing = true;
 		pwrpriv->change_rfpwrstate = rf_on;
 		pwrpriv->ips_leave_cnts++;
-		DBG_88E("==>%s:%d\n", __func__, pwrpriv->ips_leave_cnts);
 
 		result = rtw_ips_pwr_up(padapter);
 		if (result == _SUCCESS)
@@ -174,7 +164,6 @@ int ips_leave(struct adapter *padapter)
 		DBG_88E_LEVEL(_drv_info_, "nolinked power save leave\n");
 
 		if ((psecuritypriv->dot11PrivacyAlgrthm == _WEP40_) || (psecuritypriv->dot11PrivacyAlgrthm == _WEP104_)) {
-			DBG_88E("==>%s, channel(%d), processing(%x)\n", __func__, padapter->mlmeextpriv.cur_channel, pwrpriv->bips_processing);
 			set_channel_bwmode(padapter, padapter->mlmeextpriv.cur_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 			for (keyid = 0; keyid < 4; keyid++) {
 				if (pmlmepriv->key_mask & BIT(keyid)) {
@@ -186,7 +175,6 @@ int ips_leave(struct adapter *padapter)
 			}
 		}
 
-		DBG_88E("==> %s.....LED(0x%08x)...\n", __func__, usb_read32(padapter, 0x4c));
 		pwrpriv->bips_processing = false;
 
 		pwrpriv->bkeepfwalive = false;
@@ -217,7 +205,6 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 void rtw_ps_processor(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	enum rt_rf_power_state rfpwrstate;
 
 	pwrpriv->ps_processing = true;
@@ -227,7 +214,6 @@ void rtw_ps_processor(struct adapter *padapter)
 
 	if (padapter->pwrctrlpriv.bHWPwrPindetect) {
 		rfpwrstate = RfOnOffDetect(padapter);
-		DBG_88E("@@@@- #2  %s==> rfstate:%s\n", __func__, (rfpwrstate == rf_on) ? "rf_on" : "rf_off");
 
 		if (rfpwrstate != pwrpriv->rf_pwrstate) {
 			if (rfpwrstate == rf_off) {
@@ -238,7 +224,6 @@ void rtw_ps_processor(struct adapter *padapter)
 				pwrpriv->change_rfpwrstate = rf_on;
 				rtw_hw_resume(padapter);
 			}
-			DBG_88E("current rf_pwrstate(%s)\n", (pwrpriv->rf_pwrstate == rf_off) ? "rf_off" : "rf_on");
 		}
 		pwrpriv->pwr_state_check_cnts++;
 	}
@@ -250,7 +235,6 @@ void rtw_ps_processor(struct adapter *padapter)
 		goto exit;
 
 	if ((pwrpriv->rf_pwrstate == rf_on) && ((pwrpriv->pwr_state_check_cnts % 4) == 0)) {
-		DBG_88E("==>%s .fw_state(%x)\n", __func__, get_fwstate(pmlmepriv));
 		pwrpriv->change_rfpwrstate = rf_off;
 
 		ips_enter(padapter);
@@ -349,10 +333,8 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 	if (pwrpriv->bInSuspend)
 		return false;
 	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X &&
-	    !padapter->securitypriv.binstallGrpkey) {
-		DBG_88E("Group handshake still in progress !!!\n");
+	    !padapter->securitypriv.binstallGrpkey)
 		return false;
-	}
 	return true;
 }
 
@@ -381,7 +363,6 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 	/* if (pwrpriv->pwr_mode == PS_MODE_ACTIVE) */
 	if (ps_mode == PS_MODE_ACTIVE) {
 		if (PS_RDY_CHECK(padapter)) {
-			DBG_88E("%s: Enter 802.11 power save\n", __func__);
 			pwrpriv->bFwCurrentInPSMode = true;
 			pwrpriv->pwr_mode = ps_mode;
 			pwrpriv->smart_ps = smart_ps;
@@ -412,13 +393,11 @@ s32 LPS_RF_ON_check(struct adapter *padapter, u32 delay_ms)
 
 		if (padapter->bSurpriseRemoved) {
 			err = -2;
-			DBG_88E("%s: device surprise removed!!\n", __func__);
 			break;
 		}
 
 		if (jiffies_to_msecs(jiffies - start_time) > delay_ms) {
 			err = -1;
-			DBG_88E("%s: Wait for FW LPS leave more than %u ms!!!\n", __func__, delay_ms);
 			break;
 		}
 		msleep(1);
@@ -443,7 +422,6 @@ void LPS_Enter(struct adapter *padapter)
 		if (pwrpriv->LpsIdleCount >= 2) { /*   4 Sec */
 			if (pwrpriv->pwr_mode == PS_MODE_ACTIVE) {
 				pwrpriv->bpower_saving = true;
-				DBG_88E("%s smart_ps:%d\n", __func__, pwrpriv->smart_ps);
 				/* For Tenda W311R IOT issue */
 				rtw_set_ps_mode(padapter, pwrpriv->power_mgnt, pwrpriv->smart_ps, 0);
 			}
@@ -549,14 +527,9 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 
 	start = jiffies;
 	if (pwrpriv->ps_processing) {
-		DBG_88E("%s wait ps_processing...\n", __func__);
 		while (pwrpriv->ps_processing &&
 		       jiffies_to_msecs(jiffies - start) <= 3000)
 			udelay(1500);
-		if (pwrpriv->ps_processing)
-			DBG_88E("%s wait ps_processing timeout\n", __func__);
-		else
-			DBG_88E("%s wait ps_processing done\n", __func__);
 	}
 
 	/* System suspend is not allowed to wakeup */
@@ -577,9 +550,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		goto exit;
 	}
 	if (rf_off == pwrpriv->rf_pwrstate) {
-		DBG_88E("%s call ips_leave....\n", __func__);
 		if (ips_leave(padapter) ==  _FAIL) {
-			DBG_88E("======> ips_leave fail.............\n");
 			ret = _FAIL;
 			goto exit;
 		}
@@ -588,11 +559,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 	/* TODO: the following checking need to be merged... */
 	if (padapter->bDriverStopped || !padapter->bup ||
 	    !padapter->hw_init_completed) {
-		DBG_88E("%s: bDriverStopped=%d, bup=%d, hw_init_completed =%u\n"
-			, caller
-			, padapter->bDriverStopped
-			, padapter->bup
-			, padapter->hw_init_completed);
 		ret = false;
 		goto exit;
 	}
@@ -631,11 +597,9 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
 
 	if (mode == IPS_NORMAL || mode == IPS_LEVEL_2) {
 		rtw_ips_mode_req(pwrctrlpriv, mode);
-		DBG_88E("%s %s\n", __func__, mode == IPS_NORMAL ? "IPS_NORMAL" : "IPS_LEVEL_2");
 		return 0;
 	} else if (mode == IPS_NONE) {
 		rtw_ips_mode_req(pwrctrlpriv, mode);
-		DBG_88E("%s %s\n", __func__, "IPS_NONE");
 		if ((padapter->bSurpriseRemoved == 0) && (rtw_pwr_wakeup(padapter) == _FAIL))
 			return -EFAULT;
 	} else {
-- 
2.30.2

