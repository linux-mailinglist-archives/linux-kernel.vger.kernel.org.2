Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1459D3E9C10
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhHLBxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:53:13 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7064EC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:52:49 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h11so7837100oie.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fln9VeidunkEiogQHBZsImxl7ENoYGE7zHIqJYXPjy8=;
        b=XQDqObU//f+O2gtsWu1NY7TVb7u0swbDdsIth+i4O++Ngfx2PwRQn2Wi0sSbOksEwt
         f2ysFPt1hFusie4CubBzNinqfq8AAW+YivRMIXR1Tri0k2sniOPAcRsFP5ndkaQO8FNf
         S2FOuiOKFhWpTTeHG63X/aujwP3DlRJBCZFY5FLwHNECakObuxnBeEIvDyIpfwKQolV5
         bTupiyqsHIK3Ij9Suih5XWVRmHWPHMSsj8QPcpaKD5z+H1ALBk6jT4W2Z0wnQzbsgzT1
         v+7jDa/EgyWI6BCZdt4AQuYs5e37QpJtTqnCtZPj5E7Bs/lBuq+iKGWZVPmr0nWKJlLl
         H/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fln9VeidunkEiogQHBZsImxl7ENoYGE7zHIqJYXPjy8=;
        b=d6bEKQJgANrkY9FP+xEejjVh7RWSxzzcHKoZ2zuBf8Liy2yVDZ/k5WhTbDLPVpVCUH
         mAZBuBM5XNWz0zoIycxNuyK9RYvrOEox8rUPjTOK+Vgkh0/Q5V8jclPhUEk2TaV6w0sw
         x5uo25CWAla9HgWHVDuyfDc+7j65Q20IV0Vo/T9JnoZB9ecHTvdp9mI/TbgeE9c1V+9A
         LA2vMUu47vsMBhN6hOfHImwQzTK5NJdE2bCFWAVPEA1y/HVAZ7qKtTn85U8cYKV7CmXe
         4qZFejUUWPwiLrjDK6Es0J2d9GXeYs9Z/ucyB7qOKX3gcE7i4bCzW7YNNXrUFG6sI88R
         gQNA==
X-Gm-Message-State: AOAM531xARb93zeuH+OvXWDAlD/4Z8ufUszuH4VgRytGVM6D35pxsssz
        yF+74y/rHTjB3bv9PA1iTZY=
X-Google-Smtp-Source: ABdhPJzruPsIYzRLqYsF9IUAt95RMprxoNu5TTU8X5eovYVAOQUvp9U5n99ZDH/SmwdUweCivUWhGw==
X-Received: by 2002:aca:1014:: with SMTP id 20mr8542157oiq.70.1628733168778;
        Wed, 11 Aug 2021 18:52:48 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id q21sm305718otn.61.2021.08.11.18.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 18:52:48 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 1/3] staging: r8188eu: Fix Smatch warnings for core/*.c
Date:   Wed, 11 Aug 2021 20:52:30 -0500
Message-Id: <20210812015232.23784-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812015232.23784-1-Larry.Finger@lwfinger.net>
References: <20210812015232.23784-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports the following problems:
drivers/staging/r8188eu/core/rtw_br_ext.c:655 nat25_db_handle() warn: if statement not indented
drivers/staging/r8188eu/core/rtw_cmd.c:436 rtw_sitesurvey_cmd() warn: if statement not indented
drivers/staging/r8188eu/core/rtw_cmd.c:450 rtw_sitesurvey_cmd() warn: if statement not indented
drivers/staging/r8188eu/core/rtw_led.c:330 SwLedBlink2() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_led.c:359 SwLedBlink2() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_led.c:538 SwLedBlink4() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_led.c:567 SwLedBlink4() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_led.c:685 SwLedBlink5() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_led.c:771 SwLedControlMode1() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_led.c:819 SwLedControlMode1() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_led.c:845 SwLedControlMode1() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_led.c:1574 LedControl8188eu() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_mlme.c:420 is_same_network() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_mlme.c:986 rtw_joinbss_update_stainfo() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_mlme.c:1162 rtw_joinbss_event_prehandle() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_mlme.c:1858 rtw_restruct_sec_ie() error: uninitialized symbol 'authmode'.
drivers/staging/r8188eu/core/rtw_mlme.c:1869 rtw_restruct_sec_ie() error: uninitialized symbol 'authmode'.
drivers/staging/r8188eu/core/rtw_mlme_ext.c:401 _mgt_dispatcher() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_mlme_ext.c:3210 is_matched_in_profilelist() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_mlme_ext.c:4351 dump_mgntframe_and_wait() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_mlme_ext.c:4374 dump_mgntframe_and_wait_ack() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_mlme_ext.c:7378 _linked_rx_signal_strehgth_display() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_mp.c:694 SetPacketTx() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_mp.c:900 _rtw_mp_xmit_priv() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_p2p.c:1130 process_p2p_group_negotation_req() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_recv.c:188 rtw_free_recvframe() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_recv.c:499 portctrl() error: uninitialized symbol 'ether_type'.
drivers/staging/r8188eu/core/rtw_recv.c:507 portctrl() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_recv.c:722 sta2sta_data_frame() warn: if statement not indented
drivers/staging/r8188eu/core/rtw_recv.c:1601 amsdu_to_msdu() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_security.c:283 rtw_seccalctkipmic() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_security.c:1116 aes_cipher() warn: for statement not indented
drivers/staging/r8188eu/core/rtw_security.c:1213 rtw_aes_encrypt() warn: inconsistent indenting
rivers/staging/r8188eu/core/rtw_sta_mgt.c:18 _rtw_init_stainfo() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_sta_mgt.c:475 rtw_get_bcmc_stainfo() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_wlan_util.c:65 cckratesonly_included() warn: if statement not indented
drivers/staging/r8188eu/core/rtw_wlan_util.c:1150 should_forbid_n_rate() warn: if statement not indented
drivers/staging/r8188eu/core/rtw_wlan_util.c:1401 check_assoc_AP() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_wlan_util.c:1403 check_assoc_AP() warn: inconsistent indenting
drivers/staging/r8188eu/core/rtw_xmit.c:805 rtw_make_wlanhdr() warn: if statement not indented
drivers/staging/r8188eu/core/rtw_xmit.c:1691 rtw_br_client_tx() warn: inconsistent indenting
drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c:199 ODM_ReadAndConfig_RadioA_1T_8188E() warn: inconsistent indenting

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - no changes
---
 drivers/staging/r8188eu/core/rtw_br_ext.c     |  2 +-
 drivers/staging/r8188eu/core/rtw_cmd.c        |  6 ------
 drivers/staging/r8188eu/core/rtw_ieee80211.c  |  2 +-
 drivers/staging/r8188eu/core/rtw_io.c         |  2 +-
 drivers/staging/r8188eu/core/rtw_led.c        | 20 +++++++++----------
 drivers/staging/r8188eu/core/rtw_mlme.c       | 16 +++++++--------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 16 ++++++++-------
 drivers/staging/r8188eu/core/rtw_mp.c         |  6 +++---
 drivers/staging/r8188eu/core/rtw_p2p.c        |  4 ++--
 drivers/staging/r8188eu/core/rtw_recv.c       | 18 ++++++++---------
 drivers/staging/r8188eu/core/rtw_security.c   |  6 +++---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  6 +++---
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 14 ++++++-------
 drivers/staging/r8188eu/core/rtw_xmit.c       |  4 ++--
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |  2 +-
 15 files changed, 59 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 63a4cabdd3a8..22737cd0fe44 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -653,7 +653,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			switch (method) {
 			case NAT25_CHECK:
 				if (!memcmp(skb->data+ETH_ALEN, ipx->ipx_source.node, ETH_ALEN))
-				DEBUG_INFO("NAT25: Check IPX skb_copy\n");
+					DEBUG_INFO("NAT25: Check IPX skb_copy\n");
 				return 0;
 			case NAT25_INSERT:
 				DEBUG_INFO("NAT25: Insert IPX, Dest =%08x,%02x%02x%02x%02x%02x%02x,%04x Source =%08x,%02x%02x%02x%02x%02x%02x,%04x\n",
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index a62dd3c986e5..df83f4fb7fd0 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -433,9 +433,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 			if (ssid[i].SsidLength) {
 				memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
 				psurveyPara->ssid_num++;
-				if (0)
-				DBG_88E(FUNC_ADPT_FMT" ssid:(%s, %d)\n", FUNC_ADPT_ARG(padapter),
-					psurveyPara->ssid[i].Ssid, psurveyPara->ssid[i].SsidLength);
 			}
 		}
 	}
@@ -447,9 +444,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
 				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
 				psurveyPara->ch_num++;
-				if (0)
-				DBG_88E(FUNC_ADPT_FMT" ch:%u\n", FUNC_ADPT_ARG(padapter),
-					psurveyPara->ch[i].hw_value);
 			}
 		}
 	}
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 55d2b8f90d91..183da156ba9f 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -402,7 +402,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 		wireless_mode = pregistrypriv->wireless_mode;
 	}
 
-		rtw_set_supported_rate(pdev_network->SupportedRates, wireless_mode);
+	rtw_set_supported_rate(pdev_network->SupportedRates, wireless_mode);
 
 	rateLen = rtw_get_rateset_len(pdev_network->SupportedRates);
 
diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index b5cd9bbc1ce1..cde0205816b1 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -266,7 +266,7 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pme
 	if (ret == _SUCCESS)
 		ret = rtw_sctx_wait(&sctx);
 
-	 return ret;
+	return ret;
 }
 
 void _rtw_write_port_cancel(struct adapter *adapter)
diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 671c7cbc7cc3..306862aec53a 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -323,7 +323,7 @@ static void SwLedBlink2(struct LED_871x *pLed)
 			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
 				SwLedOff(padapter, pLed);
 			} else {
-				 if (pLed->bLedOn)
+				if (pLed->bLedOn)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
@@ -352,7 +352,7 @@ static void SwLedBlink2(struct LED_871x *pLed)
 			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
 				SwLedOff(padapter, pLed);
 			} else {
-				 if (pLed->bLedOn)
+				if (pLed->bLedOn)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
@@ -531,7 +531,7 @@ static void SwLedBlink4(struct LED_871x *pLed)
 			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
 				SwLedOff(padapter, pLed);
 			} else {
-				 if (pLed->bLedOn)
+				if (pLed->bLedOn)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
@@ -560,7 +560,7 @@ static void SwLedBlink4(struct LED_871x *pLed)
 			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
 				SwLedOff(padapter, pLed);
 			} else {
-				 if (pLed->bLedOn)
+				if (pLed->bLedOn)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
@@ -678,7 +678,7 @@ static void SwLedBlink5(struct LED_871x *pLed)
 			if (padapter->pwrctrlpriv.rf_pwrstate != rf_on && padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) {
 				SwLedOff(padapter, pLed);
 			} else {
-				 if (pLed->bLedOn)
+				if (pLed->bLedOn)
 					pLed->BlinkingLedState = RTW_LED_OFF;
 				else
 					pLed->BlinkingLedState = RTW_LED_ON;
@@ -768,7 +768,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			}
 			if (pLed->bLedLinkBlinkInProgress) {
 				_cancel_timer_ex(&pLed->BlinkTimer);
-				 pLed->bLedLinkBlinkInProgress = false;
+				pLed->bLedLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
 				_cancel_timer_ex(&pLed->BlinkTimer);
@@ -816,7 +816,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			}
 			if (pLed->bLedLinkBlinkInProgress) {
 				_cancel_timer_ex(&pLed->BlinkTimer);
-				 pLed->bLedLinkBlinkInProgress = false;
+				pLed->bLedLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
 				_cancel_timer_ex(&pLed->BlinkTimer);
@@ -842,7 +842,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		}
 		if (pLed->bLedLinkBlinkInProgress) {
 			_cancel_timer_ex(&pLed->BlinkTimer);
-			 pLed->bLedLinkBlinkInProgress = false;
+			pLed->bLedLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedBlinkInProgress) {
 			_cancel_timer_ex(&pLed->BlinkTimer);
@@ -1571,8 +1571,8 @@ void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct registry_priv *registry_par;
 
-       if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped) ||
-	   (!padapter->hw_init_completed))
+	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped) ||
+	    (!padapter->hw_init_completed))
 		return;
 
 	if (!ledpriv->bRegUseLed)
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d688f2427b03..f702f24941a3 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -416,7 +416,7 @@ static int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
 
 int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst)
 {
-	 u16 s_cap, d_cap;
+	u16 s_cap, d_cap;
 	__le16 le_scap, le_dcap;
 
 	memcpy((u8 *)&le_scap, rtw_get_capability_from_ie(src->IEs), 2);
@@ -983,7 +983,7 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 	if (psta) { /* update ptarget_sta */
 		DBG_88E("%s\n", __func__);
 		psta->aid  = pnetwork->join_res;
-			psta->mac_id = 0;
+		psta->mac_id = 0;
 		/* sta mode */
 		rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
 		/* security related */
@@ -1159,10 +1159,10 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			}
 
 			/* s4. indicate connect */
-				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
-					pmlmepriv->cur_network_scanned = ptarget_wlan;
-					rtw_indicate_connect(adapter);
-				}
+			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+				pmlmepriv->cur_network_scanned = ptarget_wlan;
+				rtw_indicate_connect(adapter);
+			}
 
 			/* s5. Cancle assoc_timer */
 			_cancel_timer(&pmlmepriv->assoc_timer, &timer_cancelled);
@@ -1738,7 +1738,6 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	INIT_LIST_HEAD(&pcmd->list);
 	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
 exit:
-
 	return res;
 }
 
@@ -1833,10 +1832,9 @@ static int rtw_append_pmkid(struct adapter *Adapter, int iEntry, u8 *ie, uint ie
 
 int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_len)
 {
-	u8 authmode;
+	u8 authmode = 0;
 	uint	ielength;
 	int iEntry;
-
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 	uint	ndisauthmode = psecuritypriv->ndisauthtype;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 967c7574215a..33ac9982a364 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -398,8 +398,8 @@ static void _mgt_dispatcher(struct adapter *padapter, struct mlme_handler *ptabl
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	u8 *pframe = precv_frame->rx_data;
 
-	  if (ptable->func) {
-	 /* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
+	if (ptable->func) {
+	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
 		if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
 		    memcmp(GetAddr1Ptr(pframe), bc_addr, ETH_ALEN))
 			return;
@@ -3205,8 +3205,9 @@ static u8 is_matched_in_profilelist(u8 *peermacaddr, struct profile_info *profil
 		peermacaddr[0], peermacaddr[1], peermacaddr[2], peermacaddr[3], peermacaddr[4], peermacaddr[5]);
 
 	for (i = 0; i < P2P_MAX_PERSISTENT_GROUP_NUM; i++, profileinfo++) {
-	       DBG_88E("[%s] profileinfo_mac=%.2X %.2X %.2X %.2X %.2X %.2X\n", __func__,
-			    profileinfo->peermac[0], profileinfo->peermac[1], profileinfo->peermac[2], profileinfo->peermac[3], profileinfo->peermac[4], profileinfo->peermac[5]);
+		DBG_88E("[%s] profileinfo_mac=%.2X %.2X %.2X %.2X %.2X %.2X\n", __func__,
+			profileinfo->peermac[0], profileinfo->peermac[1], profileinfo->peermac[2],
+			profileinfo->peermac[3], profileinfo->peermac[4], profileinfo->peermac[5]);
 		if (!memcmp(peermacaddr, profileinfo->peermac, ETH_ALEN)) {
 			match_result = 1;
 			DBG_88E("[%s] Match!\n", __func__);
@@ -4347,7 +4348,7 @@ s32 dump_mgntframe_and_wait(struct adapter *padapter, struct xmit_frame *pmgntfr
 	if (ret == _SUCCESS)
 		ret = rtw_sctx_wait(&sctx);
 
-	 return ret;
+	return ret;
 }
 
 s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmgntframe)
@@ -4370,7 +4371,7 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
 	pxmitpriv->ack_tx = false;
 	_exit_critical_mutex(&pxmitpriv->ack_tx_mutex, NULL);
 
-	 return ret;
+	return ret;
 }
 
 static int update_hidden_ssid(u8 *ies, u32 ies_len, u8 hidden_ssid_mode)
@@ -7374,9 +7375,10 @@ void _linked_rx_signal_strehgth_display(struct adapter *padapter);
 void _linked_rx_signal_strehgth_display(struct adapter *padapter)
 {
 	struct mlme_ext_priv    *pmlmeext = &padapter->mlmeextpriv;
-      struct mlme_ext_info    *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_info    *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 mac_id;
 	int UndecoratedSmoothedPWDB;
+
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE)
 		mac_id = 0;
 	else if ((pmlmeinfo->state&0x03) == _HW_STATE_AP_)
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 7f7a7eddda4a..8de6af042156 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -691,7 +691,7 @@ void SetPacketTx(struct adapter *padapter)
 
 	desc->txdw1 |= cpu_to_le32((0x01 << 26) & 0xff000000);
 	/*  offset 4 */
-		desc->txdw1 |= cpu_to_le32((pattrib->mac_id) & 0x3F); /* CAM_ID(MAC_ID) */
+	desc->txdw1 |= cpu_to_le32((pattrib->mac_id) & 0x3F); /* CAM_ID(MAC_ID) */
 	desc->txdw1 |= cpu_to_le32((pattrib->qsel << QSEL_SHT) & 0x00001F00); /*  Queue Select, TID */
 
 	desc->txdw1 |= cpu_to_le32((pattrib->raid << RATE_ID_SHT) & 0x000F0000); /*  Rate Adaptive ID */
@@ -897,11 +897,11 @@ u32 mp_query_psd(struct adapter *pAdapter, u8 *data)
 void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 {
 	int i, res;
-	 struct adapter *padapter = pxmitpriv->adapter;
+	struct adapter *padapter = pxmitpriv->adapter;
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
-
 	u32 max_xmit_extbuf_size = MAX_XMIT_EXTBUF_SZ;
 	u32 num_xmit_extbuf = NR_XMIT_EXTBUFF;
+
 	if (padapter->registrypriv.mp_mode == 0) {
 		max_xmit_extbuf_size = MAX_XMIT_EXTBUF_SZ;
 		num_xmit_extbuf = NR_XMIT_EXTBUFF;
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 9b3ea8a31508..bd7935d89015 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1127,7 +1127,7 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_ING);
 
-			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GO_INTENT, &attr_content, &attr_contentlen)) {
+		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GO_INTENT, &attr_content, &attr_contentlen)) {
 			DBG_88E("[%s] GO Intent = %d, tie = %d\n", __func__, attr_content >> 1, attr_content & 0x01);
 			pwdinfo->peer_intent = attr_content;	/*	include both intent and tie breaker values. */
 
@@ -1182,7 +1182,7 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 						peer_operating_ch = operatingch_info[4];
 
 					if (rtw_p2p_is_channel_list_ok(peer_operating_ch,
-								       ch_list_inclusioned, ch_num_inclusioned)) {
+							       ch_list_inclusioned, ch_num_inclusioned)) {
 						/**
 						 *	Change our operating channel as peer's for compatibility.
 						 */
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index f0a042467386..9b3637e49052 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -185,7 +185,7 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
 				precvpriv->free_recvframe_cnt++;
 	}
 
-      spin_unlock_bh(&pfree_recv_queue->lock);
+	spin_unlock_bh(&pfree_recv_queue->lock);
 
 	return _SUCCESS;
 }
@@ -455,7 +455,7 @@ static struct recv_frame *portctrl(struct adapter *adapter, struct recv_frame *p
 	struct sta_info *psta;
 	struct sta_priv *pstapriv;
 	struct recv_frame *prtnframe;
-	u16	ether_type;
+	u16 ether_type = 0;
 	u16  eapol_type = 0x888e;/* for Funia BD's WPA issue */
 	struct rx_pkt_attrib *pattrib;
 	__be16 be_tmp;
@@ -504,7 +504,7 @@ static struct recv_frame *portctrl(struct adapter *adapter, struct recv_frame *p
 		prtnframe = precv_frame;
 	}
 
-		return prtnframe;
+	return prtnframe;
 }
 
 static int recv_decache(struct recv_frame *precv_frame, u8 bretry, struct stainfo_rxcache *prxcache)
@@ -720,7 +720,7 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 	if (!*psta) {
 		if (adapter->registrypriv.mp_mode == 1) {
 			if (check_fwstate(pmlmepriv, WIFI_MP_STATE) == true)
-			adapter->mppriv.rx_pktloss++;
+				adapter->mppriv.rx_pktloss++;
 		}
 		ret = _FAIL;
 		goto exit;
@@ -1598,13 +1598,13 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 
 		/* Indicate the packets to upper layer */
 			/*  Insert NAT2.5 RX here! */
-			sub_skb->protocol = eth_type_trans(sub_skb, padapter->pnetdev);
-			sub_skb->dev = padapter->pnetdev;
+		sub_skb->protocol = eth_type_trans(sub_skb, padapter->pnetdev);
+		sub_skb->dev = padapter->pnetdev;
 
-			sub_skb->ip_summed = CHECKSUM_NONE;
+		sub_skb->ip_summed = CHECKSUM_NONE;
 
-			netif_rx(sub_skb);
-		}
+		netif_rx(sub_skb);
+	}
 
 exit:
 
diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 6cacf7d01626..845301476e8b 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -279,7 +279,7 @@ void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_cod
 
 	/* Michael MIC pseudo header: DA, SA, 3 x 0, Priority */
 	if (header[1]&1) {   /* ToDS == 1 */
-			rtw_secmicappend(&micdata, &header[16], 6);  /* DA */
+		rtw_secmicappend(&micdata, &header[16], 6);  /* DA */
 		if (header[1]&2)  /* From Ds == 1 */
 			rtw_secmicappend(&micdata, &header[24], 6);
 		else
@@ -1114,7 +1114,7 @@ static int aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 
 	/* Insert MIC into payload */
 	for (j = 0; j < 8; j++)
-	pframe[payload_index+j] = mic[j];	/* message[payload_index+j] = mic[j]; */
+		pframe[payload_index+j] = mic[j]; /* message[payload_index+j] = mic[j]; */
 
 	payload_index = hdrlen + 8;
 	for (i = 0; i < num_blocks; i++) {
@@ -1210,7 +1210,7 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 		}
 	}
 
-		return res;
+	return res;
 }
 
 static int aes_decipher(u8 *key, uint	hdrlen,
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index a74d0741658a..b4568ec1c48a 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -15,7 +15,7 @@ static void _rtw_init_stainfo(struct sta_info *psta)
 
 	memset((u8 *)psta, 0, sizeof (struct sta_info));
 
-	 spin_lock_init(&psta->lock);
+	spin_lock_init(&psta->lock);
 	INIT_LIST_HEAD(&psta->list);
 	INIT_LIST_HEAD(&psta->hash_list);
 	_rtw_init_queue(&psta->sleep_q);
@@ -463,7 +463,7 @@ struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter)
 	struct sta_priv		*pstapriv = &padapter->stapriv;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	 psta = rtw_get_stainfo(pstapriv, bc_addr);
+	psta = rtw_get_stainfo(pstapriv, bc_addr);
 
 	return psta;
 }
@@ -500,7 +500,7 @@ u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 	else if (pacl_list->mode == 2)/* deny unless in accept list */
 		res = (match) ? true : false;
 	else
-		 res = true;
+		res = true;
 
 #endif
 
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index e897920b7af1..25caa3ecb9f1 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -62,9 +62,9 @@ int cckratesonly_included(unsigned char *rate, int ratelen)
 	int	i;
 
 	for (i = 0; i < ratelen; i++) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-			   (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
-		return false;
+		if ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
+		    (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+			return false;
 	}
 
 	return true;
@@ -1148,8 +1148,8 @@ unsigned int should_forbid_n_rate(struct adapter *padapter)
 				break;
 			case _RSN_IE_2_:
 				if  ((!memcmp((pIE->data + 8), RSN_CIPHER_SUITE_CCMP, 4))  ||
-				       (!memcmp((pIE->data + 12), RSN_CIPHER_SUITE_CCMP, 4)))
-				return false;
+				     (!memcmp((pIE->data + 12), RSN_CIPHER_SUITE_CCMP, 4)))
+					return false;
 			default:
 				break;
 			}
@@ -1397,10 +1397,10 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 				DBG_88E("link to Airgo Cap\n");
 				return HT_IOT_PEER_AIRGO;
 			} else if (!memcmp(pIE->data, EPIGRAM_OUI, 3)) {
-				 epigram_vendor_flag = 1;
+				epigram_vendor_flag = 1;
 				if (ralink_vendor_flag) {
 					DBG_88E("link to Tenda W311R AP\n");
-					 return HT_IOT_PEER_TENDA;
+					return HT_IOT_PEER_TENDA;
 				} else {
 					DBG_88E("Capture EPIGRAM_OUI\n");
 				}
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 1b05f1643ebf..f941150e5f94 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -803,7 +803,7 @@ s32 rtw_make_wlanhdr (struct adapter *padapter, u8 *hdr, struct pkt_attrib *patt
 			/* check if enable ampdu */
 			if (pattrib->ht_en && psta->htpriv.ampdu_enable) {
 				if (psta->htpriv.agg_enable_bitmap & BIT(pattrib->priority))
-				pattrib->ampdu_en = true;
+					pattrib->ampdu_en = true;
 			}
 
 			/* re-check if enable ampdu by BA_starting_seqctrl */
@@ -1688,7 +1688,7 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 	if (memcmp(skb->data+MACADDRLEN, GET_MY_HWADDR(padapter), MACADDRLEN)) {
 		DEBUG_ERR("TX DROP: untransformed frame SA:%02X%02X%02X%02X%02X%02X!\n",
 			  skb->data[6], skb->data[7], skb->data[8], skb->data[9], skb->data[10], skb->data[11]);
-			return -1;
+		return -1;
 	}
 	return 0;
 }
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index fa51023cd48e..c5895e0c798b 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -196,7 +196,7 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 			} else {
 				odm_ConfigRF_RadioA_8188E(pDM_Odm, v1, v2);
 			}
-		    continue;
+			continue;
 		} else { /*  This line is the start line of branch. */
 			if (!CheckCondition(Array[i], hex)) {
 				/*  Discard the following (offset, data) pairs. */
-- 
2.32.0

