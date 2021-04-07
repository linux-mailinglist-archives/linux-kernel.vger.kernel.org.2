Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4128356DD3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhDGNup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347697AbhDGNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28BFC061762
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y18so1965254wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Phg/XL4QmEpBvDg6kgsmHRc0OVA+J7BSe5dPOPwy0I4=;
        b=h3EpKJWy0GjDJHiYr/cl/0I8RbSr6hGGqdD9cR3hZKLPCq5Q6oAGlMPoFwbGt3htz1
         5yMxjavmTPDR3Bxvkl8O8UzAIrV9qtOIddIBIFpMmF0sXzu9RdvfEUw1JY5SY08naS5l
         Rdp6EaWeFW1xWPsHNvRKRsXRJ79DPdLBsuf31I74CGYmWb4MhyYGncSgMf34XyNv8Ymi
         O+FOLFGCeP+pp0PaohUzcZgu2LDe/ndB8HMWl2rDm4y8LBa3Lw/iUJSJnQZ4BXnXcusj
         ue4oCRKUxZQhXGS/M0D1/uEJ9XW3Yoptvo+lXCrY8U10QWpGebisVxYY/DshopW41+49
         So1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Phg/XL4QmEpBvDg6kgsmHRc0OVA+J7BSe5dPOPwy0I4=;
        b=pyUn0Iftr9O/s6KTPYpugG+WkWBSRs+sKF0VzVeGxb0yfmtmscnWqAMAh42Xo2hhw4
         p0mlJUDoc+7tCbPG+QnvTFXazlQw61PIAisKWnPRxnifiguF0wd6eGoKs0if6zvsykje
         giW1hkQkf+LexelkIewGj59ckPJxB6ZiP4Yu/VHk7bH/pF9fWjn9gE5i6qOXpBTd8c35
         s3Zzsrw9Uy8Exw70OzC6hTggaaAnMGzrWG6C5SCvwJXr/xsLti9FWZ1rKROZfP9ulhVA
         TyKTefk+g5YMS/CebqSZksxaMEXVLEZmo5ZwIHcLf440gSbVtHS6xjIen/SIDF2a0VcM
         BILA==
X-Gm-Message-State: AOAM532gaeWtapS5FMsld69w2UWBw3ABixJ1lquPMUYxn/NKIxzVbhnO
        4r77l013iP3gNBn7/AgMd7Y=
X-Google-Smtp-Source: ABdhPJxs5U/gtc+F5TEnx5pVrdizQGXZPG6ILxj42G0vMptXzpFfi4ZMy5A7TkGFzbj27Tm9+oKs8g==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr4572287wrr.425.1617803405117;
        Wed, 07 Apr 2021 06:50:05 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id q19sm8464879wmc.44.2021.04.07.06.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 06/19] staging: rtl8723bs: remove all if-else empty blocks left by DBG_871X removal
Date:   Wed,  7 Apr 2021 15:49:30 +0200
Message-Id: <56055b20bc064d7ac1e8f14bd1ed42aba6b02c36.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all if-else empty {} blocks left by spatch application.

removed unused variables and an unused static function definition
after if-else blocks removal, to suppress compiler warnings.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 22 +++-------
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  5 ---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  4 --
 drivers/staging/rtl8723bs/core/rtw_io.c       |  2 +-
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 16 --------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 40 +------------------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 21 ++--------
 drivers/staging/rtl8723bs/core/rtw_recv.c     |  7 ----
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  6 ---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  8 ----
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 24 -----------
 drivers/staging/rtl8723bs/hal/hal_com.c       |  6 +--
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 32 ++++-----------
 drivers/staging/rtl8723bs/hal/hal_intf.c      | 10 +----
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 10 +----
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  7 ----
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  3 --
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  3 --
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  2 -
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  4 --
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  7 +---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 38 +++---------------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 34 ++--------------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  3 --
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c | 20 ----------
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  1 -
 27 files changed, 33 insertions(+), 305 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index ae477abced65..30afe9f4ceef 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -195,8 +195,6 @@ void expire_timeout_chk(struct adapter *padapter)
 
 	/* check auth_queue */
 	#ifdef DBG_EXPIRATION_CHK
-	if (phead != plist) {
-	}
 	#endif
 	while (phead != plist) {
 		psta = container_of(plist, struct sta_info, auth_list);
@@ -228,8 +226,6 @@ void expire_timeout_chk(struct adapter *padapter)
 
 	/* check asoc_queue */
 	#ifdef DBG_EXPIRATION_CHK
-	if (phead != plist) {
-	}
 	#endif
 	while (phead != plist) {
 		psta = container_of(plist, struct sta_info, asoc_list);
@@ -392,7 +388,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		arg[3] = psta->init_rate;
 
 		rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
-	} else {
 	}
 }
 
@@ -468,7 +463,6 @@ void update_bmc_sta(struct adapter *padapter)
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
 
-	} else {
 	}
 }
 
@@ -662,8 +656,6 @@ static void update_hw_ht_param(struct adapter *padapter)
 	pmlmeinfo->SM_PS = (le16_to_cpu(
 		pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
 	) & 0x0C) >> 2;
-	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		{}
 
 	/*  */
 	/*  Config current HT Protection mode. */
@@ -832,8 +824,7 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 		update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 
 		/* issue beacon frame */
-		if (send_beacon(padapter) == _FAIL)
-			{}
+		send_beacon(padapter);
 	}
 
 	/* update bc/mc sta_info */
@@ -1573,9 +1564,6 @@ static void update_bcn_vendor_spec_ie(struct adapter *padapter, u8 *oui)
 
 	else if (!memcmp(P2P_OUI, oui, 4))
 		update_bcn_p2p_ie(padapter);
-
-	else
-		{}
 }
 
 void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
@@ -1863,8 +1851,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 			psta->no_ht_set = 1;
 			pmlmepriv->num_sta_no_ht++;
 		}
-		if (pmlmepriv->htpriv.ht_option == true) {
-		}
 	}
 
 	if (rtw_ht_operation_update(padapter) > 0) {
@@ -2117,8 +2103,10 @@ void rtw_ap_restore_network(struct adapter *padapter)
 	for (i = 0; i < chk_alive_num; i++) {
 		psta = rtw_get_stainfo_by_offset(pstapriv, chk_alive_list[i]);
 
-		if (psta == NULL) {
-		} else if (psta->state & _FW_LINKED) {
+		if (psta == NULL)
+			continue;
+
+		if (psta->state & _FW_LINKED) {
 			rtw_sta_media_status_rpt(padapter, psta, 1);
 			Update_RA_Entry(padapter, psta);
 			/* pairwise key */
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 2000e7703571..c29cd23b74a0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -388,7 +388,6 @@ int rtw_cmd_thread(void *context)
 	struct cmd_obj *pcmd;
 	u8 *pcmdbuf;
 	unsigned long cmd_start_time;
-	unsigned long cmd_process_time;
 	u8 (*cmd_hdl)(struct adapter *padapter, u8 *pbuf);
 	void (*pcmd_callback)(struct adapter *dev, struct cmd_obj *pcmd);
 	struct adapter *padapter = context;
@@ -483,10 +482,6 @@ int rtw_cmd_thread(void *context)
 			mutex_unlock(&(pcmd->padapter->cmdpriv.sctx_mutex));
 		}
 
-		cmd_process_time = jiffies_to_msecs(jiffies - cmd_start_time);
-		if (cmd_process_time > 1000) {
-		}
-
 		/* call callback function for post-processed */
 		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
 			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 00be36165f87..f57d6552c338 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -819,8 +819,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	 * OUI of the vendor. The following byte is used a vendor specific
 	 * sub-type. */
 	if (elen < 4) {
-		if (show_errors) {
-		}
 		return -1;
 	}
 
@@ -908,8 +906,6 @@ enum ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
 		left -= 2;
 
 		if (elen > left) {
-			if (show_errors) {
-			}
 			return ParseFailed;
 		}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index ed01354f58bd..25fc52e557d1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -174,8 +174,8 @@ int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
 	int value = atomic_inc_return(&dvobj->continual_io_error);
 	if (value > MAX_CONTINUAL_IO_ERR) {
 		ret = true;
-	} else {
 	}
+
 	return ret;
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index fbc8e5f60b0c..f6bd360f3183 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -422,8 +422,7 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 		rtw_indicate_disconnect(padapter);
 		/* modify for CONFIG_IEEE80211W, none 11w can use it */
 		rtw_free_assoc_resources_cmd(padapter);
-		if (_FAIL == rtw_pwr_wakeup(padapter))
-			{}
+		rtw_pwr_wakeup(padapter);
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index fa2f78948fee..f5eb13e4c36e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -519,8 +519,6 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	dst->Rssi = rssi_final;
 
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) && 1
-	if (strcmp(dst->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
-	}
 	#endif
 }
 
@@ -1051,8 +1049,6 @@ void rtw_scan_abort(struct adapter *adapter)
 	}
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
-		if (!adapter->bDriverStopped && !adapter->bSurpriseRemoved)
-			{}
 		rtw_indicate_scan_done(adapter, true);
 	}
 	pmlmeext->scan_abort = false;
@@ -1705,9 +1701,6 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 	if (adapter->net_closed)
 		return;
 
-	if (is_primary_adapter(adapter))
-		{}
-
 	if ((adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
 		&& !(hal_btcoex_IsBtControlLps(adapter))
 		) {
@@ -1884,9 +1877,6 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 		updated = true;
 	}
 
-	if (updated) {
-	}
-
 exit:
 	return updated;
 }
@@ -2350,8 +2340,6 @@ void rtw_ht_use_default_setting(struct adapter *padapter)
 		if (TEST_FLAG(pregistrypriv->ldpc_cap, BIT5))
 			SET_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX);
 	}
-	if (phtpriv->ldpc_cap)
-		{}
 
 	/*  STBC */
 	rtw_hal_get_def_var(padapter, HAL_DEF_TX_STBC, (u8 *)&bHwSTBCSupport);
@@ -2365,8 +2353,6 @@ void rtw_ht_use_default_setting(struct adapter *padapter)
 		if (TEST_FLAG(pregistrypriv->stbc_cap, BIT4))
 			SET_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_RX);
 	}
-	if (phtpriv->stbc_cap)
-		{}
 
 	/*  Beamforming setting */
 	rtw_hal_get_def_var(padapter, HAL_DEF_EXPLICIT_BEAMFORMER, (u8 *)&bHwSupportBeamformer);
@@ -2644,8 +2630,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	pmlmeinfo->SM_PS =
 		(le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) &
 		 0x0C) >> 2;
-	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		{}
 
 	/*  */
 	/*  Config current HT Protection mode. */
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 7ad0d680fffa..b889e1214ef2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1373,8 +1373,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 
 	/* get a unique AID */
-	if (pstat->aid > 0) {
-	} else {
+	if (pstat->aid == 0) {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
 			if (pstapriv->sta_aid[pstat->aid - 1] == NULL)
 				break;
@@ -2684,12 +2683,6 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 		#endif
 	}
 
-	if (try_cnt && wait_ms) {
-		if (da)
-			{}
-		else
-			{}
-	}
 exit:
 	return ret;
 }
@@ -3044,12 +3037,10 @@ void issue_assocreq(struct adapter *padapter)
 			if ((pmlmeinfo->network.SupportedRates[i]|IEEE80211_BASIC_RATE_MASK)
 					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK)) {
 				break;
-			} else {
 			}
 		}
 
-		if (j == sta_bssrate_len) {
-		} else {
+		if (j != sta_bssrate_len) {
 			/*  the rate is supported by STA */
 			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
 		}
@@ -3252,12 +3243,6 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 		#endif
 	}
 
-	if (try_cnt && wait_ms) {
-		if (da)
-			{}
-		else
-			{}
-	}
 exit:
 	return ret;
 }
@@ -3394,12 +3379,6 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 		#endif
 	}
 
-	if (try_cnt && wait_ms) {
-		if (da)
-			{}
-		else
-			{}
-	}
 exit:
 	return ret;
 }
@@ -3495,12 +3474,6 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 		#endif
 	}
 
-	if (try_cnt && wait_ms) {
-		if (da)
-			{}
-		else
-			{}
-	}
 exit:
 	return ret;
 }
@@ -3915,7 +3888,6 @@ unsigned int send_beacon(struct adapter *padapter)
 	u8 bxmitok = false;
 	int	issue = 0;
 	int poll = 0;
-	unsigned long start = jiffies;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_BCN_VALID, NULL);
 	rtw_hal_set_hwreg(padapter, HW_VAR_DL_BCN_SEL, NULL);
@@ -3938,12 +3910,6 @@ unsigned int send_beacon(struct adapter *padapter)
 	if (false == bxmitok) {
 		return _FAIL;
 	} else {
-		unsigned long passing_time = jiffies_to_msecs(jiffies - start);
-
-		if (passing_time > 100 || issue > 3)
-			{}
-		/* else */
-
 		return _SUCCESS;
 	}
 }
@@ -4225,8 +4191,6 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	}
 
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) & 1
-	if (strcmp(bssid->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
-	}
 	#endif
 
 	/*  mark bss info receiving from nearby channel as SignalQuality 101 */
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 22a3174533bb..8b2993e817a0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -249,8 +249,7 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 
 	pslv = PS_STATE(pslv);
 
-	if (pwrpriv->brpwmtimeout) {
-	} else {
+	if (!pwrpriv->brpwmtimeout) {
 		if (pwrpriv->rpwm == pslv ||
 		    (pwrpriv->rpwm >= PS_STATE_S2 && pslv >= PS_STATE_S2))
 			return;
@@ -535,8 +534,7 @@ void LeaveAllPowerSaveModeDirect(struct adapter *Adapter)
 		rtw_lps_ctrl_wk_cmd(pri_padapter, LPS_CTRL_LEAVE, 0);
 	} else {
 		if (pwrpriv->rf_pwrstate == rf_off)
-			if (!ips_leave(pri_padapter))
-				{}
+			ips_leave(pri_padapter);
 	}
 }
 
@@ -569,8 +567,7 @@ void LeaveAllPowerSaveMode(struct adapter *Adapter)
 		LPS_Leave_check(Adapter);
 	} else {
 		if (adapter_to_pwrctl(Adapter)->rf_pwrstate == rf_off) {
-			if (!ips_leave(Adapter))
-				{}
+			ips_leave(Adapter);
 		}
 	}
 }
@@ -1059,10 +1056,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 	if (pwrpriv->ps_processing) {
 		while (pwrpriv->ps_processing && jiffies_to_msecs(jiffies - start) <= 3000)
 			mdelay(10);
-		if (pwrpriv->ps_processing)
-			{}
-		else
-			{}
 	}
 
 	if (!(pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend) {
@@ -1070,10 +1063,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		) {
 			mdelay(10);
 		}
-		if (pwrpriv->bInSuspend)
-			{}
-		else
-			{}
 	}
 
 	/* System suspend is not allowed to wakeup */
@@ -1174,8 +1163,6 @@ void rtw_ps_deny(struct adapter *padapter, enum ps_deny_reason reason)
 	pwrpriv = adapter_to_pwrctl(padapter);
 
 	mutex_lock(&pwrpriv->lock);
-	if (pwrpriv->ps_deny & BIT(reason)) {
-	}
 	pwrpriv->ps_deny |= BIT(reason);
 	mutex_unlock(&pwrpriv->lock);
 }
@@ -1191,8 +1178,6 @@ void rtw_ps_deny_cancel(struct adapter *padapter, enum ps_deny_reason reason)
 	pwrpriv = adapter_to_pwrctl(padapter);
 
 	mutex_lock(&pwrpriv->lock);
-	if ((pwrpriv->ps_deny & BIT(reason)) == 0) {
-	}
 	pwrpriv->ps_deny &= ~BIT(reason);
 	mutex_unlock(&pwrpriv->lock);
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index fac25dd0f174..71ec5af0455d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -248,9 +248,6 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 		cnt++;
 	}
 
-	if (cnt)
-		{}
-
 	return cnt;
 }
 
@@ -367,7 +364,6 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 				if ((prxattrib->bdecrypted == true) && (brpt_micerror == true)) {
 					rtw_handle_tkip_mic_err(adapter, (u8)IS_MCAST(prxattrib->ra));
-				} else {
 				}
 
 				res = _FAIL;
@@ -2157,9 +2153,6 @@ static int recv_func(struct adapter *padapter, union recv_frame *rframe)
 			cnt++;
 			recv_func_posthandle(padapter, pending_frame);
 		}
-
-		if (cnt)
-			{}
 	}
 
 	ret = recv_func_prehandle(padapter, rframe);
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 2afda4f7d58c..6e5a0841950c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -106,17 +106,11 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 {
 	int offset = (((u8 *)sta) - stapriv->pstainfo_buf)/sizeof(struct sta_info);
 
-	if (!stainfo_offset_valid(offset))
-		{}
-
 	return offset;
 }
 
 inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
 {
-	if (!stainfo_offset_valid(offset))
-		{}
-
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 0a098bddf135..d6579c2b21f6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -379,9 +379,6 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 {
 	u8 center_ch, chnl_offset80 = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
-	if (padapter->bNotifyChannelChange)
-		{}
-
 	center_ch = rtw_get_center_ch(channel, bwmode, channel_offset);
 
 	if (bwmode == CHANNEL_WIDTH_80) {
@@ -626,11 +623,6 @@ static s16 _rtw_camid_search(struct adapter *adapter, u8 *addr, s16 kid)
 		break;
 	}
 
-	if (addr)
-		{}
-	else
-		{}
-
 	return cam_id;
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 62429571151c..1af4aad59b8f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1425,7 +1425,6 @@ static struct xmit_buf *__rtw_alloc_cmd_xmitbuf(struct xmit_priv *pxmitpriv,
 		if (pxmitbuf->sctx) {
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
-	} else {
 	}
 
 	return pxmitbuf;
@@ -1561,8 +1560,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		}
 	}
 	#ifdef DBG_XMIT_BUF
-	else
-		{}
 	#endif
 
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
@@ -1988,8 +1985,6 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
 
 	if (jiffies_to_msecs(jiffies - start) > 2000) {
-		if (drop_cnt)
-			{}
 		start = jiffies;
 		drop_cnt = 0;
 	}
@@ -2590,26 +2585,9 @@ int rtw_sctx_wait(struct submit_ctx *sctx, const char *msg)
 	return ret;
 }
 
-static bool rtw_sctx_chk_warning_status(int status)
-{
-	switch (status) {
-	case RTW_SCTX_DONE_UNKNOWN:
-	case RTW_SCTX_DONE_BUF_ALLOC:
-	case RTW_SCTX_DONE_BUF_FREE:
-
-	case RTW_SCTX_DONE_DRV_STOP:
-	case RTW_SCTX_DONE_DEV_REMOVE:
-		return true;
-	default:
-		return false;
-	}
-}
-
 void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
-		if (rtw_sctx_chk_warning_status(status))
-			{}
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
 		*sctx = NULL;
@@ -2638,6 +2616,4 @@ void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status)
 
 	if (pxmitpriv->ack_tx)
 		rtw_sctx_done_err(&pack_tx_ops, status);
-	else
-		{}
 }
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index da617b5343f5..509eac352c15 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1648,8 +1648,6 @@ void rtw_bb_rf_gain_offset(struct adapter *padapter)
 			/* res |= (padapter->eeprompriv.EEPROMRFGainVal & 0x0f)<< 15; */
 			/* rtw_hal_write_rfreg(padapter, RF_PATH_A, REG_RF_BB_GAIN_OFFSET, RF_GAIN_OFFSET_MASK, res); */
 			res = rtw_hal_read_rfreg(padapter, RF_PATH_A, 0x7f, 0xffffffff);
-		} else
-			{}
-	} else
-		{}
+		}
+	}
 }
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index db8f4aa43a94..de73e6504d9c 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -88,8 +88,7 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 Band, u8 RfPath,
 		default:
 			break;
 		}
-	} else
-		{}
+	}
 
 	return value;
 }
@@ -177,8 +176,7 @@ phy_SetTxPowerByRateBase(
 		default:
 			break;
 		}
-	} else
-		{}
+	}
 }
 
 static void
@@ -770,9 +768,7 @@ void PHY_StoreTxPowerByRate(
 			pHalData->pwrGroupCnt++;
 		else if (RegAddr == rTxAGC_B_Mcs15_Mcs12 && pHalData->rf_type != RF_1T1R)
 			pHalData->pwrGroupCnt++;
-	} else
-		{}
-
+	}
 }
 
 static void
@@ -963,8 +959,7 @@ void PHY_SetTxPowerIndexByRateSection(
 					       pHalData->CurrentChannelBW,
 					       Channel, vhtRates4T,
 					       ARRAY_SIZE(vhtRates4T));
-	} else
-		{}
+	}
 }
 
 static bool phy_GetChnlIndex(u8 Channel, u8 *ChannelIdx)
@@ -1020,8 +1015,6 @@ u8 PHY_GetTxPowerIndexBase(
 			txPower = pHalData->Index24G_CCK_Base[RFPath][chnlIdx];
 		else if (MGN_6M <= Rate)
 			txPower = pHalData->Index24G_BW40_Base[RFPath][chnlIdx];
-		else
-			{}
 
 		/*  OFDM-1T */
 		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate)) {
@@ -1063,8 +1056,6 @@ u8 PHY_GetTxPowerIndexBase(
 	} else {/* 3 ============================== 5 G ============================== */
 		if (MGN_6M <= Rate)
 			txPower = pHalData->Index5G_BW40_Base[RFPath][chnlIdx];
-		else
-			{}
 
 		/*  OFDM-1T */
 		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate)) {
@@ -1520,11 +1511,7 @@ static s8 phy_GetChannelIndexOfTxPowerLimit(u8 Band, u8 Channel)
 			if (channel5G[i] == Channel)
 				channelIndex = i;
 		}
-	} else
-		{}
-
-	if (channelIndex == -1)
-		{}
+	}
 
 	return channelIndex;
 }
@@ -1635,9 +1622,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	idx_bandwidth = get_bandwidth_idx(bandwidth);
 	idx_rate_sctn = get_rate_sctn_idx(data_rate);
 
-	if (band_type == BAND_ON_5G && idx_rate_sctn == 0)
-		{}
-
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  OFDM only exists in BW 20M */
 	/*  CCK table will only be given in BW 20M */
@@ -1692,7 +1676,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 					       [idx_rate_sctn]
 					       [idx_channel]
 					       [rf_path];
-	} else {
 	}
 
 	return pwr_lmt;
@@ -1831,9 +1814,8 @@ void PHY_SetTxPowerLimit(
 	u8 regulation = 0, bandwidth = 0, rateSection = 0, channel;
 	s8 powerLimit = 0, prevPowerLimit, channelIndex;
 
-	if (!GetU1ByteIntegerFromStringInDecimal((s8 *)Channel, &channel) ||
-		 !GetU1ByteIntegerFromStringInDecimal((s8 *)PowerLimit, &powerLimit))
-		{}
+	GetU1ByteIntegerFromStringInDecimal((s8 *)Channel, &channel);
+	GetU1ByteIntegerFromStringInDecimal((s8 *)PowerLimit, &powerLimit);
 
 	powerLimit = powerLimit > MAX_POWER_INDEX ? MAX_POWER_INDEX : powerLimit;
 
diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 71afbb17448c..bc9ae2088754 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -120,8 +120,8 @@ uint rtw_hal_deinit(struct adapter *padapter)
 	if (status == _SUCCESS) {
 		padapter = dvobj->padapters;
 		padapter->hw_init_completed = false;
-	} else {
 	}
+
 	return status;
 }
 
@@ -173,16 +173,12 @@ void rtw_hal_enable_interrupt(struct adapter *padapter)
 {
 	if (padapter->HalFunc.enable_interrupt)
 		padapter->HalFunc.enable_interrupt(padapter);
-	else
-		{}
 }
 
 void rtw_hal_disable_interrupt(struct adapter *padapter)
 {
 	if (padapter->HalFunc.disable_interrupt)
 		padapter->HalFunc.disable_interrupt(padapter);
-	else
-		{}
 }
 
 u8 rtw_hal_check_ips_status(struct adapter *padapter)
@@ -190,8 +186,6 @@ u8 rtw_hal_check_ips_status(struct adapter *padapter)
 	u8 val = false;
 	if (padapter->HalFunc.check_ips_status)
 		val = padapter->HalFunc.check_ips_status(padapter);
-	else
-		{}
 
 	return val;
 }
@@ -443,8 +437,6 @@ s32 rtw_hal_fill_h2c_cmd(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8
 
 	if (padapter->HalFunc.fill_h2c_cmd)
 		ret = padapter->HalFunc.fill_h2c_cmd(padapter, ElementID, CmdLen, pCmdBuffer);
-	else
-		{}
 
 	return ret;
 }
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 7369e2c5fc39..66140fcfb40f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -389,11 +389,6 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 	u8 u1H2CPwrModeParm[H2C_PWRMODE_LEN] = {0};
 	u8 PowerState = 0, awake_intvl = 1, byte5 = 0, rlbm = 0;
 
-	if (pwrpriv->dtim > 0)
-		{}
-	else
-		{}
-
 	if (pwrpriv->dtim > 0 && pwrpriv->dtim < 16)
 		awake_intvl = pwrpriv->dtim+1;/* DTIM = (awake_intvl - 1) */
 	else
@@ -468,7 +463,6 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 			pmlmeext->bcn_cnt = 0;
 			pmlmeext->adaptive_tsf_done = true;
 
-		} else {
 		}
 
 /* offload to FW if fw version > v15.10
@@ -732,9 +726,7 @@ void rtl8723b_download_rsvd_page(struct adapter *padapter, u8 mstatus)
 		} while (!bcn_valid && DLBcnCount <= 100 && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
 
 		if (padapter->bSurpriseRemoved || padapter->bDriverStopped) {
-		} else if (!bcn_valid)
-			{}
-		else {
+		} else {
 			struct pwrctrl_priv *pwrctl = adapter_to_pwrctl(padapter);
 			pwrctl->fw_psmode_iface_id = padapter->iface_id;
 		}
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index fda356e19da7..1930049756b2 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -33,9 +33,6 @@ static void _FWDownloadEnable(struct adapter *padapter, bool enable)
 			msleep(1);
 		} while (count++ < 100);
 
-		if (count > 0)
-			{}
-
 		/*  8051 reset */
 		tmp = rtw_read8(padapter, REG_MCUFWDL+2);
 		rtw_write8(padapter, REG_MCUFWDL+2, tmp&0xf7);
@@ -2695,8 +2692,6 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 				SCSettingOfDesc = VHT_DATA_SC_40_LOWER_OF_80MHZ;
 			else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 				SCSettingOfDesc = VHT_DATA_SC_40_UPPER_OF_80MHZ;
-			else
-				{}
 		} else {
 			if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER))
 				SCSettingOfDesc = VHT_DATA_SC_20_LOWEST_OF_80MHZ;
@@ -2706,8 +2701,6 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 				SCSettingOfDesc = VHT_DATA_SC_20_UPPER_OF_80MHZ;
 			else if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER))
 				SCSettingOfDesc = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
-			else
-				{}
 		}
 	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
 		if (pattrib->bwmode == CHANNEL_WIDTH_40) {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 5c1aa45c2984..973ade5f0d54 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -741,9 +741,6 @@ static void phy_SwChnlAndSetBwMode8723B(struct adapter *Adapter)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	if (Adapter->bNotifyChannelChange) {
-	}
-
 	if (Adapter->bDriverStopped || Adapter->bSurpriseRemoved)
 		return;
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 116f5e6644c3..38d798cfe413 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -420,9 +420,6 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 				alignment = tmpaddr & (RECVBUFF_ALIGN_SZ-1);
 				skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 			}
-
-			if (!precvbuf->pskb) {
-			}
 		}
 
 		list_add_tail(&precvbuf->list, &precvpriv->free_recv_buf_queue.queue);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 2f4601aab9d5..b18d20242d6d 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -26,8 +26,6 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
 		HalQueryTxOQTBufferStatus8723BSdio(padapter);
 
 		if ((++n % 60) == 0) {
-			if ((n % 300) == 0) {
-			}
 			msleep(1);
 			/* yield(); */
 		}
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 05524cd72c17..839fd32fc8dc 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -960,7 +960,6 @@ static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
 						cnt++;
 						mdelay(10);
 					} while (cnt < 100 && (val8 != 0xEA));
-				} else {
 				}
 
 				adapter_to_pwrctl(padapter)->pre_ips_type = 0;
@@ -1110,9 +1109,6 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
 	/*  This part read and parse the eeprom/efuse content */
 	/*  */
 
-	if (sizeof(pEEPROM->efuse_eeprom_data) < HWSET_MAX_SIZE_8723B)
-		{}
-
 	hwinfo = pEEPROM->efuse_eeprom_data;
 
 	Hal_InitPGData(padapter, hwinfo);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index cdfc8cf4aba4..d417b1372fe2 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -958,8 +958,7 @@ void sd_int_dpc(struct adapter *adapter)
 			}
 		} else {
 			/* Error handling for malloc fail */
-			if (rtw_cbuf_push(adapter->evtpriv.c2h_queue, NULL) != _SUCCESS)
-				{}
+			rtw_cbuf_push(adapter->evtpriv.c2h_queue, NULL);
 			_set_workitem(&adapter->evtpriv.c2h_wk);
 		}
 	}
@@ -997,10 +996,6 @@ void sd_int_dpc(struct adapter *adapter)
 			if (!hisr)
 				break;
 		} while (1);
-
-		if (alloc_fail_time == 10)
-			{}
-
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 62106d4c7006..4506ddf19d17 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -274,13 +274,9 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 			{
 				DBG_8192C("ssid =%s, len =%d\n", pssid->Ssid, pssid->SsidLength);
 
-				if (ssids[0].ssid_len == 0) {
-				}
-				else if (pssid->SsidLength == ssids[0].ssid_len &&
-					!memcmp(pssid->Ssid, ssids[0].ssid, ssids[0].ssid_len))
-				{
-				}
-				else
+				if (ssids[0].ssid_len != 0 &&
+				    (pssid->SsidLength != ssids[0].ssid_len ||
+				     memcmp(pssid->Ssid, ssids[0].ssid, ssids[0].ssid_len)))
 				{
 					if (psr)
 						*psr = 0; /* clear sr */
@@ -405,10 +401,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 		{
 
 			memcpy(&cur_network->network, pnetwork, sizeof(struct wlan_bssid_ex));
-			if (!rtw_cfg80211_inform_bss(padapter, cur_network))
-				{}
-			else
-				{}
+			rtw_cfg80211_inform_bss(padapter, cur_network);
 		}
 		else
 		{
@@ -419,9 +412,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 			if (!memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
 				&& !memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
 			) {
-				if (!rtw_cfg80211_inform_bss(padapter, scanned)) {
-				} else {
-				}
+				rtw_cfg80211_inform_bss(padapter, scanned);
 			} else {
 				rtw_warn_on(1);
 			}
@@ -462,9 +453,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		if (!memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
 			&& !memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
 		) {
-			if (!rtw_cfg80211_inform_bss(padapter, scanned)) {
-			} else {
-			}
+			rtw_cfg80211_inform_bss(padapter, scanned);
 		} else {
 			rtw_warn_on(1);
 		}
@@ -2354,10 +2343,6 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 
 		DBG_8192C("RTW_Tx:da =%pM via "FUNC_NDEV_FMT"\n",
 			MAC_ARG(GetAddr1Ptr(buf)), FUNC_NDEV_ARG(ndev));
-		if (category == RTW_WLAN_CATEGORY_PUBLIC)
-			{}
-		else
-			{}
 
 		/* starting alloc mgmt frame to dump it */
 		pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -2773,10 +2758,6 @@ void rtw_cfg80211_rx_action(struct adapter *adapter, u8 *frame, uint frame_len,
 	rtw_action_frame_parse(frame, frame_len, &category, &action);
 
 	DBG_8192C("RTW_Rx:cur_ch =%d\n", channel);
-	if (msg)
-		{}
-	else
-		{}
 
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
 
@@ -2901,10 +2882,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	}
 
 	DBG_8192C("RTW_Tx:tx_ch =%d, da =%pM\n", tx_ch, MAC_ARG(GetAddr1Ptr(buf)));
-	if (category == RTW_WLAN_CATEGORY_PUBLIC)
-		{}
-	else
-		{}
 
 	rtw_ps_deny(padapter, PS_DENY_MGNT_TX);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
@@ -2917,9 +2894,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 		tx_ret = _cfg80211_rtw_mgmt_tx(padapter, tx_ch, buf, len);
 	} while (dump_cnt < dump_limit && tx_ret != _SUCCESS);
 
-	if (tx_ret != _SUCCESS || dump_cnt > 1) {
-	}
-
 	switch (type) {
 	case P2P_GO_NEGO_CONF:
 		rtw_clear_scan_deny(padapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 91f540d50774..2392eb2b0458 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -369,7 +369,6 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		}
-	} else if (value & WLAN_AUTH_LEAP) {
 	} else {
 		ret = -EINVAL;
 	}
@@ -1223,7 +1222,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 
 			spin_unlock_bh(&pmlmepriv->lock);
 
-		} else if (req->scan_type == IW_SCAN_TYPE_PASSIVE) {
 		}
 
 	} else if (wrqu->data.length >= WEXT_CSCAN_HEADER_SIZE
@@ -1412,9 +1410,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	if (wrqu->essid.flags && wrqu->essid.length) {
 		len = (wrqu->essid.length < IW_ESSID_MAX_SIZE) ? wrqu->essid.length : IW_ESSID_MAX_SIZE;
 
-		if (wrqu->essid.length != 33)
-			{}
-
 		memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
 		ndis_ssid.SsidLength = len;
 		memcpy(ndis_ssid.Ssid, extra, len);
@@ -2204,9 +2199,7 @@ static int rtw_wx_set_channel_plan(struct net_device *dev,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	u8 channel_plan_req = (u8)(*((int *)wrqu));
 
-	if (_SUCCESS == rtw_set_chplan_cmd(padapter, channel_plan_req, 1, 1))
-		{}
-	 else
+	if (_SUCCESS != rtw_set_chplan_cmd(padapter, channel_plan_req, 1, 1))
 		return -EPERM;
 
 	return 0;
@@ -2360,8 +2353,6 @@ static int rtw_set_pid(struct net_device *dev,
 	if (selector < 3 && selector >= 0) {
 		padapter->pid[selector] = *(pdata+1);
 	}
-	else
-		{}
 
 exit:
 
@@ -2585,11 +2576,8 @@ static int rtw_dbg_port(struct net_device *dev,
 
 						for (i = 0; i < 16; i++) {
 							preorder_ctrl = &psta->recvreorder_ctrl[i];
-							if (preorder_ctrl->enable)
-								{}
 						}
 
-					} else {
 					}
 					break;
 				case 0x06:
@@ -2626,8 +2614,6 @@ static int rtw_dbg_port(struct net_device *dev,
 								if (extra_arg == psta->aid) {
 									for (j = 0; j < 16; j++) {
 										preorder_ctrl = &psta->recvreorder_ctrl[j];
-										if (preorder_ctrl->enable)
-											{}
 									}
 								}
 							}
@@ -2695,9 +2681,7 @@ static int rtw_dbg_port(struct net_device *dev,
 					/* default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
 					if (extra_arg == 0 || extra_arg == 1 || extra_arg == 2 || extra_arg == 3) {
 						pregpriv->rx_stbc = extra_arg;
-					} else
-						{}
-
+					}
 				}
 				break;
 				case 0x13: /* set ampdu_enable */
@@ -2706,9 +2690,7 @@ static int rtw_dbg_port(struct net_device *dev,
 					/*  0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
 					if (extra_arg < 3) {
 						pregpriv->ampdu_enable = extra_arg;
-					} else
-						{}
-
+					}
 				}
 				break;
 				case 0x14:
@@ -3435,11 +3417,8 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 
 		psta = NULL;
 
-	} else {
-		/* ret = -1; */
 	}
 
-
 	return ret;
 
 }
@@ -3535,7 +3514,6 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 			param->u.wpa_ie.len = copy_len;
 
 			memcpy(param->u.wpa_ie.reserved, psta->wpa_ie, copy_len);
-		} else {
 		}
 	} else {
 		ret = -1;
@@ -3674,16 +3652,10 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 		memcpy(ssid, ssid_ie+2, ssid_len);
 		ssid[ssid_len] = 0x0;
 
-		if (0)
-			{}
-
 		memcpy(pbss_network->Ssid.Ssid, (void *)ssid, ssid_len);
 		pbss_network->Ssid.SsidLength = ssid_len;
 		memcpy(pbss_network_ext->Ssid.Ssid, (void *)ssid, ssid_len);
 		pbss_network_ext->Ssid.SsidLength = ssid_len;
-
-		if (0)
-			{}
 	}
 
 	return ret;
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 5062aeef169f..2a366b4e3716 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1088,7 +1088,6 @@ void rtw_dev_unload(struct adapter *padapter)
 
 		padapter->bup = false;
 
-	} else {
 	}
 }
 
@@ -1259,8 +1258,6 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 
 	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		rtw_ap_restore_network(padapter);
-	} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-	} else {
 	}
 
 exit:
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 827ce3013acb..6ece6daee499 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -52,8 +52,6 @@ u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	v = sdio_f0_readb(func, addr, err);
 	if (claim_needed)
 		sdio_release_host(func);
-	if (err && *err)
-		{}
 	return v;
 }
 
@@ -217,8 +215,6 @@ u8 sd_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	v = sdio_readb(func, addr, err);
 	if (claim_needed)
 		sdio_release_host(func);
-	if (err && *err)
-		{}
 	return v;
 }
 
@@ -272,12 +268,6 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 				}
 			}
 		}
-
-		if (i == SD_IO_TRY_CNT)
-			{}
-		else
-			{}
-
 	}
 	return  v;
 }
@@ -306,8 +296,6 @@ void sd_write8(struct intf_hdl *pintfhdl, u32 addr, u8 v, s32 *err)
 	sdio_writeb(func, v, addr, err);
 	if (claim_needed)
 		sdio_release_host(func);
-	if (err && *err)
-		{}
 }
 
 void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
@@ -359,10 +347,6 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 			}
 		}
 
-		if (i == SD_IO_TRY_CNT)
-			{}
-		else
-			{}
 	}
 }
 
@@ -415,8 +399,6 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	}
 
 	err = sdio_memcpy_fromio(func, pdata, addr, cnt);
-	if (err)
-		{}
 
 	return err;
 }
@@ -514,8 +496,6 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 
 	size = cnt;
 	err = sdio_memcpy_toio(func, addr, pdata, size);
-	if (err)
-		{}
 
 	return err;
 }
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index eea7b59f2034..0c9dfbaafcfd 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -211,7 +211,6 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 			res = rtw_mlcst2unicst(padapter, pkt);
 			if (res)
 				goto exit;
-		} else {
 		}
 	}
 
-- 
2.20.1

