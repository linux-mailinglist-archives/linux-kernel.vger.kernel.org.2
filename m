Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27FF356DDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347930AbhDGNvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347637AbhDGNuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:32 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971CAC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z24-20020a1cf4180000b029012463a9027fso618793wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VnwaLe2mSn9uKM1irWYMaIXo2iBiq2AHIuiXWm3aaoQ=;
        b=A1bgaPUQy0F3XoBZfbxqvBzMJvRyFYcwE+h/yqbJ9x7NqLiO8r3RUTd5fQzq7QliIQ
         OJrQgsIt2ZlS37ioihD2iMkIOFuO+lwOPvViU7zoBB/0yINPUtgMj2qDgxpoeZFOsU0H
         c4wKLYMprXsi1/y1On/scRZCdd5ZYltaQplzVGDuX50kI72YDzWRZ2BFJOxbkVOjwo9J
         7XJJ5kgz4HRm7WkWY5KaT5ATpNMOsjyhV/4hkgqmhrM9XMqxMWZMI8AXdynPd4mst+ZC
         xq+62qaMhVVcCnQO/I8n5C1PBFT6/NhgSuh9eNEcZzgIvHqzZceE/MJVhWWT7RqvBHPF
         9Xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnwaLe2mSn9uKM1irWYMaIXo2iBiq2AHIuiXWm3aaoQ=;
        b=T+15QB0a4DaLF3dsN7TcUZLxLtR2w+jMDDnOYXe6fGqQtPmuH6/kyIj3U0Ke26xjMr
         /EGiYhCdiTj+CWF8UoYtEisNkL5JB9XjBn3lh/9Rgoig9EmYDTp8lIFIPJQ1MEq6OQC0
         byZBO8nwtMz+jOFUHU54UgGpA0ZoK52cn1rm3JJSxlRdju90ToDeqYQW1fdopxEq4jd+
         mLaRYEAbI0xGrFzQUGRcEkhkVv9/XIYbXR1cDB7ax9KEtPG3bnvdTAMDhgk+i6BG+Zt2
         CugAXVslX2O/nRJpJsosLKashAMl8UYfQayrc6W15dHEgSvXEopYFB+BpiQfSFHsbzuQ
         rutg==
X-Gm-Message-State: AOAM530uyuzGr2EKeC3aFawfyT10WObt7qG5EHdViwlCEW9z4A1u/TyQ
        lWBSgisNJa5Gi/iRiOmVycE=
X-Google-Smtp-Source: ABdhPJzAKC0O4vBAjpkAD+cQB7Wo2FhcPWT/XnaAbsq9mFBw1my+Aqw/aEdU6EawLkOYblPxIGXihw==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr3171371wmh.78.1617803415860;
        Wed, 07 Apr 2021 06:50:15 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id h13sm7460342wmq.29.2021.04.07.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 12/19] staging: rtl8723bs: remove unnecessary bracks on DBG_871X removal sites
Date:   Wed,  7 Apr 2021 15:49:36 +0200
Message-Id: <35f5edf0f39b717b3de3ad7861cbaa5f4ba60576.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary bracks on DBG_871X removal sites

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  9 +-
 drivers/staging/rtl8723bs/core/rtw_btcoex.c   |  6 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 10 +--
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 10 +--
 drivers/staging/rtl8723bs/core/rtw_io.c       |  3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 32 +++----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 77 ++++++-----------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 54 +++++-------
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 28 +++---
 drivers/staging/rtl8723bs/core/rtw_security.c | 15 ++--
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 85 ++++++++-----------
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 61 +++++--------
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c  |  4 +-
 drivers/staging/rtl8723bs/hal/hal_com.c       |  6 +-
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 69 ++++++---------
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 12 +--
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  8 +-
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  3 +-
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  9 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  4 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  6 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 18 ++--
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 57 +++++--------
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |  4 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 22 ++---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |  3 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  9 +-
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c | 52 ++++--------
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  9 +-
 29 files changed, 254 insertions(+), 431 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 015c1d74a92d..10589d52bba9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -274,9 +274,8 @@ void expire_timeout_chk(struct adapter *padapter)
 				&& padapter->xmitpriv.free_xmitframe_cnt < ((
 					NR_XMITFRAME / pstapriv->asoc_list_cnt
 				) / 2)
-			) {
+			)
 				wakeup_sta_to_xmit(padapter, psta);
-			}
 		}
 	}
 
@@ -536,15 +535,13 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 
 		/*  B0 Config LDPC Coding Capability */
 		if (TEST_FLAG(phtpriv_ap->ldpc_cap, LDPC_HT_ENABLE_TX) &&
-			      GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap))) {
+			      GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap)))
 			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
-		}
 
 		/*  B7 B8 B9 Config STBC setting */
 		if (TEST_FLAG(phtpriv_ap->stbc_cap, STBC_HT_ENABLE_TX) &&
-			      GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap))) {
+			      GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap)))
 			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
-		}
 	} else {
 		phtpriv_sta->ampdu_enable = false;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
index ebdbd328b62c..62cbf84b079a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_btcoex.c
+++ b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
@@ -21,13 +21,11 @@ void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 mediaStatus)
 
 void rtw_btcoex_HaltNotify(struct adapter *padapter)
 {
-	if (!padapter->bup) {
+	if (!padapter->bup)
 		return;
-	}
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return;
-	}
 
 	hal_btcoex_HaltNotify(padapter);
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index c29cd23b74a0..cc00bd4f4bc6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -313,9 +313,9 @@ int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 
 	if ((pcmdpriv->padapter->hw_init_completed == false && bAllow == false)
 		|| atomic_read(&(pcmdpriv->cmdthd_running)) == false	/* com_thread not running */
-	) {
+	)
 		return _FAIL;
-	}
+
 	return _SUCCESS;
 }
 
@@ -419,9 +419,8 @@ int rtw_cmd_thread(void *context)
 			break;
 		}
 
-		if (list_empty(&(pcmdpriv->cmd_queue.queue))) {
+		if (list_empty(&(pcmdpriv->cmd_queue.queue)))
 			continue;
-		}
 
 		if (rtw_register_cmd_alive(padapter) != _SUCCESS)
 			continue;
@@ -1508,9 +1507,8 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
 
 	mutex_lock(&pwrpriv->lock);
 
-	if (pwrpriv->dtim != dtim) {
+	if (pwrpriv->dtim != dtim)
 		pwrpriv->dtim = dtim;
-	}
 
 	if ((pwrpriv->bFwCurrentInPSMode == true) && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
 		u8 ps_mode = pwrpriv->pwr_mode;
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index f57d6552c338..1b60252545b3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -818,9 +818,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	/* first 3 bytes in vendor specific information element are the IEEE
 	 * OUI of the vendor. The following byte is used a vendor specific
 	 * sub-type. */
-	if (elen < 4) {
+	if (elen < 4)
 		return -1;
-	}
 
 	oui = get_unaligned_be24(pos);
 	switch (oui) {
@@ -835,9 +834,9 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->wpa_ie_len = elen;
 			break;
 		case WME_OUI_TYPE: /* this is a Wi-Fi WME info. element */
-			if (elen < 5) {
+			if (elen < 5)
 				return -1;
-			}
+
 			switch (pos[4]) {
 			case WME_OUI_SUBTYPE_INFORMATION_ELEMENT:
 			case WME_OUI_SUBTYPE_PARAMETER_ELEMENT:
@@ -905,9 +904,8 @@ enum ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
 		elen = *pos++;
 		left -= 2;
 
-		if (elen > left) {
+		if (elen > left)
 			return ParseFailed;
-		}
 
 		switch (id) {
 		case WLAN_EID_SSID:
diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index 25fc52e557d1..1208ead0ed52 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -172,9 +172,8 @@ int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
 {
 	int ret = false;
 	int value = atomic_inc_return(&dvobj->continual_io_error);
-	if (value > MAX_CONTINUAL_IO_ERR) {
+	if (value > MAX_CONTINUAL_IO_ERR)
 		ret = true;
-	}
 
 	return ret;
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 9af75f683a18..585048c2520b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -707,9 +707,8 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 		}
 	}
 
-	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0)) {
+	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0))
 		bselected = false;
-	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 		if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
@@ -1040,9 +1039,9 @@ void rtw_scan_abort(struct adapter *adapter)
 		msleep(20);
 	}
 
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		rtw_indicate_scan_done(adapter, true);
-	}
+
 	pmlmeext->scan_abort = false;
 }
 
@@ -1657,13 +1656,11 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 		&& jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time) > pmlmepriv->auto_scan_int_ms) {
 
 		if (!padapter->registrypriv.wifi_spec) {
-			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true) {
+			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
 				goto exit;
-			}
 
-			if (pmlmepriv->LinkDetectInfo.bBusyTraffic) {
+			if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
 				goto exit;
-			}
 		}
 
 		rtw_set_802_11_bssid_list_scan(padapter, NULL, 0);
@@ -2344,12 +2341,11 @@ void rtw_ht_use_default_setting(struct adapter *padapter)
 	rtw_hal_get_def_var(padapter, HAL_DEF_EXPLICIT_BEAMFORMER, (u8 *)&bHwSupportBeamformer);
 	rtw_hal_get_def_var(padapter, HAL_DEF_EXPLICIT_BEAMFORMEE, (u8 *)&bHwSupportBeamformee);
 	CLEAR_FLAGS(phtpriv->beamform_cap);
-	if (TEST_FLAG(pregistrypriv->beamform_cap, BIT4) && bHwSupportBeamformer) {
+	if (TEST_FLAG(pregistrypriv->beamform_cap, BIT4) && bHwSupportBeamformer)
 		SET_FLAG(phtpriv->beamform_cap, BEAMFORMING_HT_BEAMFORMER_ENABLE);
-	}
-	if (TEST_FLAG(pregistrypriv->beamform_cap, BIT5) && bHwSupportBeamformee) {
+
+	if (TEST_FLAG(pregistrypriv->beamform_cap, BIT5) && bHwSupportBeamformee)
 		SET_FLAG(phtpriv->beamform_cap, BEAMFORMING_HT_BEAMFORMEE_ENABLE);
-	}
 }
 
 void rtw_build_wmm_ie_ht(struct adapter *padapter, u8 *out_ie, uint *pout_len)
@@ -2445,9 +2441,8 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 
 	if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_RX)) {
 		if ((channel <= 14 && pregistrypriv->rx_stbc == 0x1) ||	/* enable for 2.4GHz */
-			(pregistrypriv->wifi_spec == 1)) {
+			(pregistrypriv->wifi_spec == 1))
 			stbc_rx_enable = 1;
-		}
 	}
 
 	/* fill default supported_mcs_set */
@@ -2639,17 +2634,14 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 	priority = pattrib->priority;
 
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
-	if (pattrib->psta != psta) {
+	if (pattrib->psta != psta)
 		return;
-	}
 
-	if (!psta) {
+	if (!psta)
 		return;
-	}
 
-	if (!(psta->state & _FW_LINKED)) {
+	if (!(psta->state & _FW_LINKED))
 		return;
-	}
 
 	phtpriv = &psta->htpriv;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index c353ce2c8e0a..93eb12130066 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -400,9 +400,8 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 
 	memset(channel_set, 0, sizeof(struct rt_channel_info)*MAX_CHANNEL_NUM);
 
-	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE) {
+	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
 		return chanset_size;
-	}
 
 	if (IsSupported24G(padapter->registrypriv.wireless_mode)) {
 		b2_4GBand = true;
@@ -621,10 +620,8 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 _issue_probersp:
 		if ((check_fwstate(pmlmepriv, _FW_LINKED)  &&
-			pmlmepriv->cur_network.join_res) || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
+			pmlmepriv->cur_network.join_res) || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
 			issue_probersp(padapter, get_sa(pframe), is_valid_p2p_probereq);
-		}
-
 	}
 
 	return _SUCCESS;
@@ -661,10 +658,9 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 
 	p = rtw_get_ie(pframe + sizeof(struct ieee80211_hdr_3addr) + _BEACON_IE_OFFSET_, WLAN_EID_EXT_SUPP_RATES, &ielen, precv_frame->u.hdr.len - sizeof(struct ieee80211_hdr_3addr) - _BEACON_IE_OFFSET_);
 	if (p && ielen > 0) {
-		if ((*(p + 1 + ielen) == 0x2D) && (*(p + 2 + ielen) != 0x2D)) {
+		if ((*(p + 1 + ielen) == 0x2D) && (*(p + 2 + ielen) != 0x2D))
 			/* Invalid value 0x2D is detected in Extended Supported Rates (ESR) IE. Try to fix the IE length to avoid failed Beacon parsing. */
 			*(p + 1) = ielen - 1;
-		}
 	}
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
@@ -979,9 +975,8 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (p == NULL) {
+			if (p == NULL)
 				goto authclnt_fail;
-			}
 
 			memcpy((void *)(pmlmeinfo->chg_txt), (void *)(p + 2), len);
 			pmlmeinfo->auth_seq = 3;
@@ -1052,9 +1047,8 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	}
 
 
-	if (pkt_len < sizeof(struct ieee80211_hdr_3addr) + ie_offset) {
+	if (pkt_len < sizeof(struct ieee80211_hdr_3addr) + ie_offset)
 		return _FAIL;
-	}
 
 	pstat = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 	if (!pstat) {
@@ -1824,13 +1818,11 @@ static s32 rtw_action_public_decache(union recv_frame *recv_frame, s32 token)
 	if (GetRetry(frame)) {
 		if (token >= 0) {
 			if ((seq_ctrl == mlmeext->action_public_rxseq)
-				&& (token == mlmeext->action_public_dialog_token)) {
+				&& (token == mlmeext->action_public_dialog_token))
 				return _FAIL;
-			}
 		} else {
-			if (seq_ctrl == mlmeext->action_public_rxseq) {
+			if (seq_ctrl == mlmeext->action_public_rxseq)
 				return _FAIL;
-			}
 		}
 	}
 
@@ -2021,9 +2013,8 @@ static struct xmit_frame *_alloc_mgtxmitframe(struct xmit_priv *pxmitpriv, bool
 	else
 		pmgntframe = rtw_alloc_xmitframe_ext(pxmitpriv);
 
-	if (pmgntframe == NULL) {
+	if (pmgntframe == NULL)
 		goto exit;
-	}
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
 	if (pxmitbuf == NULL) {
@@ -2230,9 +2221,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (!pmgntframe) {
+	if (!pmgntframe)
 		return;
-	}
 
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
 
@@ -2351,9 +2341,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
 
-	if ((pattrib->pktlen + TXDESC_SIZE) > 512) {
+	if ((pattrib->pktlen + TXDESC_SIZE) > 512)
 		return;
-	}
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
@@ -2386,10 +2375,8 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		return;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (pmgntframe == NULL)
 		return;
-	}
-
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -3033,15 +3020,13 @@ void issue_assocreq(struct adapter *padapter)
 		for (j = 0; j < sta_bssrate_len; j++) {
 			 /*  Avoid the proprietary data rate (22Mbps) of Handlink WSG-4000 AP */
 			if ((pmlmeinfo->network.SupportedRates[i]|IEEE80211_BASIC_RATE_MASK)
-					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK)) {
+					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK))
 				break;
-			}
 		}
 
-		if (j != sta_bssrate_len) {
+		if (j != sta_bssrate_len)
 			/*  the rate is supported by STA */
 			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
-		}
 	}
 
 	bssrate_len = index;
@@ -3490,9 +3475,8 @@ void issue_action_SA_Query(struct adapter *padapter, unsigned char *raddr, unsig
 	__le16 le_tmp;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (pmgntframe == NULL)
 		return;
-	}
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -3903,11 +3887,10 @@ unsigned int send_beacon(struct adapter *padapter)
 	}
 
 
-	if (false == bxmitok) {
+	if (false == bxmitok)
 		return _FAIL;
-	} else {
+	else
 		return _SUCCESS;
-	}
 }
 
 /****************************************************************************
@@ -4048,9 +4031,8 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
-	if (len > MAX_IE_SZ) {
+	if (len > MAX_IE_SZ)
 		return _FAIL;
-	}
 
 	memset(bssid, 0, sizeof(struct wlan_bssid_ex));
 
@@ -4086,14 +4068,13 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_SSID, &len, bssid->IELength - ie_offset);
-	if (p == NULL) {
+	if (p == NULL)
 		return _FAIL;
-	}
 
 	if (*(p + 1)) {
-		if (len > NDIS_802_11_LENGTH_SSID) {
+		if (len > NDIS_802_11_LENGTH_SSID)
 			return _FAIL;
-		}
+
 		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
 		bssid->Ssid.SsidLength = *(p + 1);
 	} else
@@ -4105,18 +4086,18 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	i = 0;
 	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_SUPP_RATES, &len, bssid->IELength - ie_offset);
 	if (p) {
-		if (len > NDIS_802_11_LENGTH_RATES_EX) {
+		if (len > NDIS_802_11_LENGTH_RATES_EX)
 			return _FAIL;
-		}
+
 		memcpy(bssid->SupportedRates, (p + 2), len);
 		i = len;
 	}
 
 	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_EXT_SUPP_RATES, &len, bssid->IELength - ie_offset);
 	if (p) {
-		if (len > (NDIS_802_11_LENGTH_RATES_EX-i)) {
+		if (len > (NDIS_802_11_LENGTH_RATES_EX-i))
 			return _FAIL;
-		}
+
 		memcpy(bssid->SupportedRates + i, (p + 2), len);
 	}
 
@@ -5250,9 +5231,8 @@ void linked_status_chk(struct adapter *padapter)
 					}
 				}
 
-				if (tx_chk != _SUCCESS && pmlmeinfo->link_count++ == link_count_limit) {
+				if (tx_chk != _SUCCESS && pmlmeinfo->link_count++ == link_count_limit)
 					tx_chk = issue_nulldata_in_interrupt(padapter, NULL);
-				}
 			}
 
 			if (rx_chk == _FAIL) {
@@ -5326,9 +5306,7 @@ void survey_timer_hdl(struct timer_list *t)
 		}
 
 		if (pmlmeext->scan_abort) {
-			{
-				pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
-			}
+			pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
 
 			pmlmeext->scan_abort = false;/* reset */
 		}
@@ -6136,9 +6114,8 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	if (send_beacon(padapter) == _FAIL) {
+	if (send_beacon(padapter) == _FAIL)
 		return H2C_PARAMETERS_ERROR;
-	}
 
 	/* tx bc/mc frames after update TIM */
 	chk_bmc_sleepq_hdl(padapter, NULL);
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 8b2993e817a0..d43462d5e618 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -97,13 +97,11 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 
 	bool ret = false;
 
-	if (adapter_to_pwrctl(adapter)->bpower_saving) {
+	if (adapter_to_pwrctl(adapter)->bpower_saving)
 		goto exit;
-	}
 
-	if (time_before(jiffies, adapter_to_pwrctl(adapter)->ips_deny_time)) {
+	if (time_before(jiffies, adapter_to_pwrctl(adapter)->ips_deny_time))
 		goto exit;
-	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE|WIFI_SITE_MONITOR)
 		|| check_fwstate(pmlmepriv, WIFI_UNDER_LINKING|WIFI_UNDER_WPS)
@@ -153,9 +151,8 @@ void rtw_ps_processor(struct adapter *padapter)
 	mutex_lock(&adapter_to_pwrctl(padapter)->lock);
 	ps_deny = rtw_ps_deny_get(padapter);
 	mutex_unlock(&adapter_to_pwrctl(padapter)->lock);
-	if (ps_deny != 0) {
+	if (ps_deny != 0)
 		goto exit;
-	}
 
 	if (pwrpriv->bInSuspend) {/* system suspend or autosuspend */
 		pdbgpriv->dbg_ps_insuspend_cnt++;
@@ -221,9 +218,8 @@ void traffic_check_for_leave_lps(struct adapter *padapter, u8 tx, u32 tx_packets
 		if (pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod > 4/*2*/) {
 			if (adapter_to_pwrctl(padapter)->bLeisurePs
 			    && (adapter_to_pwrctl(padapter)->pwr_mode != PS_MODE_ACTIVE)
-			    && !(hal_btcoex_IsBtControlLps(padapter))) {
+			    && !(hal_btcoex_IsBtControlLps(padapter)))
 				bLeaveLPS = true;
-			}
 		}
 	}
 
@@ -336,9 +332,8 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 	)
 		return false;
 
-	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) && !(padapter->securitypriv.binstallGrpkey)) {
+	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) && !(padapter->securitypriv.binstallGrpkey))
 		return false;
-	}
 
 	if (!rtw_cfg80211_pwr_mgmt(padapter))
 		return false;
@@ -515,15 +510,13 @@ void LeaveAllPowerSaveModeDirect(struct adapter *Adapter)
 	struct mlme_priv *pmlmepriv = &(Adapter->mlmepriv);
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(Adapter);
 
-	if (Adapter->bSurpriseRemoved) {
+	if (Adapter->bSurpriseRemoved)
 		return;
-	}
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) { /* connect */
 
-		if (pwrpriv->pwr_mode == PS_MODE_ACTIVE) {
+		if (pwrpriv->pwr_mode == PS_MODE_ACTIVE)
 			return;
-		}
 
 		mutex_lock(&pwrpriv->lock);
 
@@ -548,13 +541,11 @@ void LeaveAllPowerSaveMode(struct adapter *Adapter)
 	u8 enqueue = 0;
 	int n_assoc_iface = 0;
 
-	if (!Adapter->bup) {
+	if (!Adapter->bup)
 		return;
-	}
 
-	if (Adapter->bSurpriseRemoved) {
+	if (Adapter->bSurpriseRemoved)
 		return;
-	}
 
 	if (check_fwstate(&(dvobj->padapters->mlmepriv), WIFI_ASOC_STATE))
 		n_assoc_iface++;
@@ -598,9 +589,9 @@ void LPS_Leave_check(struct adapter *padapter)
 		if (bReady)
 			break;
 
-		if (jiffies_to_msecs(jiffies - start_time) > 100) {
+		if (jiffies_to_msecs(jiffies - start_time) > 100)
 			break;
-		}
+
 		msleep(1);
 	}
 }
@@ -620,9 +611,8 @@ void cpwm_int_hdl(struct adapter *padapter, struct reportpwrstate_parm *preportp
 
 	mutex_lock(&pwrpriv->lock);
 
-	if (pwrpriv->rpwm < PS_STATE_S2) {
+	if (pwrpriv->rpwm < PS_STATE_S2)
 		goto exit;
-	}
 
 	pwrpriv->cpwm = PS_STATE(preportpwrstate->state);
 	pwrpriv->cpwm_tog = preportpwrstate->state & PS_TOGGLE;
@@ -663,9 +653,9 @@ static void rpwmtimeout_workitem_callback(struct work_struct *work)
 	padapter = dvobj->if1;
 
 	mutex_lock(&pwrpriv->lock);
-	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2)) {
+	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2))
 		goto exit;
-	}
+
 	mutex_unlock(&pwrpriv->lock);
 
 	if (rtw_read8(padapter, 0x100) != 0xEA) {
@@ -679,9 +669,9 @@ static void rpwmtimeout_workitem_callback(struct work_struct *work)
 
 	mutex_lock(&pwrpriv->lock);
 
-	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2)) {
+	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2))
 		goto exit;
-	}
+
 	pwrpriv->brpwmtimeout = true;
 	rtw_set_rpwm(padapter, pwrpriv->rpwm);
 	pwrpriv->brpwmtimeout = false;
@@ -697,9 +687,8 @@ static void pwr_rpwm_timeout_handler(struct timer_list *t)
 {
 	struct pwrctrl_priv *pwrpriv = from_timer(pwrpriv, t, pwr_rpwm_timer);
 
-	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2)) {
+	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2))
 		return;
-	}
 
 	_set_workitem(&pwrpriv->rpwmtimeoutwi);
 }
@@ -1053,17 +1042,14 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		pwrpriv->ips_deny_time = deny_time;
 
 
-	if (pwrpriv->ps_processing) {
+	if (pwrpriv->ps_processing)
 		while (pwrpriv->ps_processing && jiffies_to_msecs(jiffies - start) <= 3000)
 			mdelay(10);
-	}
 
-	if (!(pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend) {
+	if (!(pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend)
 		while (pwrpriv->bInSuspend && jiffies_to_msecs(jiffies - start) <= 3000
-		) {
+		)
 			mdelay(10);
-		}
-	}
 
 	/* System suspend is not allowed to wakeup */
 	if (!(pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 3980873f3b37..866b8c540c0c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -362,9 +362,8 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				if ((IS_MCAST(prxattrib->ra) == true)  && (prxattrib->key_index != pmlmeinfo->key_index))
 					brpt_micerror = false;
 
-				if ((prxattrib->bdecrypted == true) && (brpt_micerror == true)) {
+				if ((prxattrib->bdecrypted == true) && (brpt_micerror == true))
 					rtw_handle_tkip_mic_err(adapter, (u8)IS_MCAST(prxattrib->ra));
-				}
 
 				res = _FAIL;
 
@@ -773,9 +772,8 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 		     !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
 
-			if (!bmcast) {
+			if (!bmcast)
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
-			}
 
 			ret = _FAIL;
 			goto exit;
@@ -1592,14 +1590,12 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 		/* Offset 12 denote 2 mac address */
 		nSubframe_Length = get_unaligned_be16(pdata + 12);
 
-		if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
+		if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length))
 			break;
-		}
 
 		sub_pkt = rtw_os_alloc_msdu_pkt(prframe, nSubframe_Length, pdata);
-		if (!sub_pkt) {
+		if (!sub_pkt)
 			break;
-		}
 
 		/* move the data point to data content */
 		pdata += ETH_HLEN;
@@ -1607,9 +1603,8 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 
 		subframes[nr_subframes++] = sub_pkt;
 
-		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
+		if (nr_subframes >= MAX_SUBFRAME_COUNT)
 			break;
-		}
 
 		pdata += nSubframe_Length;
 		a_len -= nSubframe_Length;
@@ -1618,9 +1613,9 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 			if (padding_len == 4)
 				padding_len = 0;
 
-			if (a_len < padding_len) {
+			if (a_len < padding_len)
 				break;
-			}
+
 			pdata += padding_len;
 			a_len -= padding_len;
 		}
@@ -1794,9 +1789,8 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 			plist = get_next(plist);
 			list_del_init(&(prframe->u.hdr.list));
 
-			if (SN_EQUAL(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
+			if (SN_EQUAL(preorder_ctrl->indicate_seq, pattrib->seq_num))
 				preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) & 0xFFF;
-			}
 
 			/* Set this as a lock to make sure that only one thread is indicating packet. */
 			/* pTS->RxIndicateState = RXTS_INDICATE_PROCESSING; */
@@ -1976,9 +1970,8 @@ static int process_recv_indicatepkts(struct adapter *padapter, union recv_frame
 		}
 	} else { /* B/G mode */
 		retval = wlanhdr_to_ethhdr(prframe);
-		if (retval != _SUCCESS) {
+		if (retval != _SUCCESS)
 			return retval;
-		}
 
 		if ((padapter->bDriverStopped == false) && (padapter->bSurpriseRemoved == false)) {
 			/* indicate this recv_frame */
@@ -2024,9 +2017,8 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	}
 
 	prframe = recvframe_chk_defrag(padapter, prframe);
-	if (!prframe)	{
+	if (!prframe)
 		goto _recv_data_drop;
-	}
 
 	prframe = portctrl(padapter, prframe);
 	if (!prframe) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index eca1e0f0680c..302479d9236b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1587,9 +1587,8 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
-		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i]) {
+		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i])
 			res = _FAIL;
-		}
 	}
 	return res;
 }
@@ -1688,9 +1687,9 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 	ori_len = pattrib->pkt_len-WLAN_HDR_A3_LEN+BIP_AAD_SIZE;
 	BIP_AAD = rtw_zmalloc(ori_len);
 
-	if (BIP_AAD == NULL) {
+	if (BIP_AAD == NULL)
 		return _FAIL;
-	}
+
 	/* PKT start */
 	pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
 	/* mapping to wlan header */
@@ -1707,15 +1706,15 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 		memcpy(&le_tmp64, p+4, 6);
 		temp_ipn = le64_to_cpu(le_tmp64);
 		/* BIP packet number should bigger than previous BIP packet */
-		if (temp_ipn <= pmlmeext->mgnt_80211w_IPN_rx) {
+		if (temp_ipn <= pmlmeext->mgnt_80211w_IPN_rx)
 			goto BIP_exit;
-		}
+
 		/* copy key index */
 		memcpy(&le_tmp, p+2, 2);
 		keyid = le16_to_cpu(le_tmp);
-		if (keyid != padapter->securitypriv.dot11wBIPKeyid) {
+		if (keyid != padapter->securitypriv.dot11wBIPKeyid)
 			goto BIP_exit;
-		}
+
 		/* clear the MIC field of MME to zero */
 		memset(p+2+len-8, 0, 8);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index d6579c2b21f6..7a73186de69d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -901,9 +901,8 @@ void WMMOnAssocRsp(struct adapter *padapter)
 			}
 		}
 
-		for (i = 0; i < 4; i++) {
+		for (i = 0; i < 4; i++)
 			pxmitpriv->wmm_para_seq[i] = inx[i];
-		}
 	}
 }
 
@@ -1059,21 +1058,21 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		/*  Config STBC setting */
-		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_TX_STBC(pIE->data)) {
+		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_TX_STBC(pIE->data))
 			SET_FLAG(cur_stbc_cap, STBC_HT_ENABLE_TX);
-		}
+
 		phtpriv->stbc_cap = cur_stbc_cap;
 	} else {
 		/*  Config LDPC Coding Capability */
-		if (TEST_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_LDPC_CAP(pIE->data)) {
+		if (TEST_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_LDPC_CAP(pIE->data))
 			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
-		}
+
 		phtpriv->ldpc_cap = cur_ldpc_cap;
 
 		/*  Config STBC setting */
-		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data)) {
+		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data))
 			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
-		}
+
 		phtpriv->stbc_cap = cur_stbc_cap;
 	}
 }
@@ -1221,18 +1220,15 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
-	if (len > MAX_IE_SZ) {
+	if (len > MAX_IE_SZ)
 		return _FAIL;
-	}
 
-	if (memcmp(cur_network->network.MacAddress, pbssid, 6)) {
+	if (memcmp(cur_network->network.MacAddress, pbssid, 6))
 		return true;
-	}
 
 	bssid = rtw_zmalloc(sizeof(struct wlan_bssid_ex));
-	if (!bssid) {
+	if (!bssid)
 		return true;
-	}
 
 	if ((pmlmepriv->timeBcnInfoChkStart != 0) && (jiffies_to_msecs(jiffies - pmlmepriv->timeBcnInfoChkStart) > DISCONNECT_BY_CHK_BCN_FAIL_OBSERV_PERIOD_IN_MS)) {
 		pmlmepriv->timeBcnInfoChkStart = 0;
@@ -1283,16 +1279,15 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	if (p) {
 			bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
-			rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, bssid->IELength - _FIXED_IE_LENGTH_);
-			if (pht_info) {
-					bcn_channel = pht_info->primary_channel;
-			} else { /* we don't find channel IE, so don't check it */
-					bcn_channel = Adapter->mlmeextpriv.cur_channel;
-			}
+		rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+		if (pht_info)
+			bcn_channel = pht_info->primary_channel;
+		else /* we don't find channel IE, so don't check it */
+			bcn_channel = Adapter->mlmeextpriv.cur_channel;
 	}
-	if (bcn_channel != Adapter->mlmeextpriv.cur_channel) {
+
+	if (bcn_channel != Adapter->mlmeextpriv.cur_channel)
 			goto _mismatch;
-	}
 
 	/* checking SSID */
 	ssid_len = 0;
@@ -1306,11 +1301,9 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	bssid->Ssid.SsidLength = ssid_len;
 
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
-			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
-		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
+			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength)
+		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) /* not hidden ssid */
 			goto _mismatch;
-		}
-	}
 
 	/* check encryption info */
 	val16 = rtw_get_capability((struct wlan_bssid_ex *)bssid);
@@ -1320,24 +1313,21 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	else
 		bssid->Privacy = 0;
 
-	if (cur_network->network.Privacy != bssid->Privacy) {
+	if (cur_network->network.Privacy != bssid->Privacy)
 		goto _mismatch;
-	}
 
 	rtw_get_sec_ie(bssid->IEs, bssid->IELength, NULL, &rsn_len, NULL, &wpa_len);
 
-	if (rsn_len > 0) {
+	if (rsn_len > 0)
 		encryp_protocol = ENCRYP_PROTOCOL_WPA2;
-	} else if (wpa_len > 0) {
+	else if (wpa_len > 0)
 		encryp_protocol = ENCRYP_PROTOCOL_WPA;
-	} else {
+	else
 		if (bssid->Privacy)
 			encryp_protocol = ENCRYP_PROTOCOL_WEP;
-	}
 
-	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol) {
+	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol)
 		goto _mismatch;
-	}
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
 		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
@@ -1347,19 +1337,16 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		} else {
 			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
 
-			if (pbuf && (wpa_ielen > 0)) {
+			if (pbuf && (wpa_ielen > 0))
 				rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher,
 						  &pairwise_cipher, &is_8021x);
-			}
 		}
 
-		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
+		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher)
 			goto _mismatch;
-		}
 
-		if (is_8021x != cur_network->BcnInfo.is_8021x) {
+		if (is_8021x != cur_network->BcnInfo.is_8021x)
 			goto _mismatch;
-		}
 	}
 
 	kfree(bssid);
@@ -1538,12 +1525,11 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 						Vender = HT_IOT_PEER_REALTEK_SOFTAP;
 
 					if (pIE->data[4] == 2) {
-						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT) {
+						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)
 							Vender = HT_IOT_PEER_REALTEK_JAGUAR_BCUTAP;
-						}
-						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT) {
+
+						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)
 							Vender = HT_IOT_PEER_REALTEK_JAGUAR_CCUTAP;
-						}
 					}
 				}
 
@@ -1819,13 +1805,11 @@ void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 			ratio_20_delay += pmlmeext->bcn_delay_ratio[i];
 			ratio_80_delay += pmlmeext->bcn_delay_ratio[i];
 
-			if (ratio_20_delay > 20 && DrvBcnEarly == 0xff) {
+			if (ratio_20_delay > 20 && DrvBcnEarly == 0xff)
 				DrvBcnEarly = i;
-			}
 
-			if (ratio_80_delay > 80 && DrvBcnTimeOut == 0xff) {
+			if (ratio_80_delay > 80 && DrvBcnTimeOut == 0xff)
 				DrvBcnTimeOut = i;
-			}
 
 			/* reset adaptive_early_32k cnt */
 			pmlmeext->bcn_delay_cnt[i] = 0;
@@ -1862,11 +1846,10 @@ void rtw_alloc_macid(struct adapter *padapter, struct sta_info *psta)
 	}
 	spin_unlock_bh(&pdvobj->lock);
 
-	if (i > (NUM_STA-1)) {
+	if (i > (NUM_STA-1))
 		psta->mac_id = NUM_STA;
-	} else {
+	else
 		psta->mac_id = i;
-	}
 }
 
 void rtw_release_macid(struct adapter *padapter, struct sta_info *psta)
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index be65d550d6a0..af69f2da6ecd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -710,9 +710,8 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		goto exit;
 	}
 
-	if (!(psta->state & _FW_LINKED)) {
+	if (!(psta->state & _FW_LINKED))
 		return _FAIL;
-	}
 
 	/* TODO:_lock */
 	if (update_attrib_sec_info(padapter, pattrib, psta) == _FAIL) {
@@ -931,17 +930,14 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			struct sta_info *psta;
 
 			psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
-			if (pattrib->psta != psta) {
+			if (pattrib->psta != psta)
 				return _FAIL;
-			}
 
-			if (!psta) {
+			if (!psta)
 				return _FAIL;
-			}
 
-			if (!(psta->state & _FW_LINKED)) {
+			if (!(psta->state & _FW_LINKED))
 				return _FAIL;
-			}
 
 			if (psta) {
 				psta->sta_xmitpriv.txseq_tid[pattrib->priority]++;
@@ -1175,9 +1171,9 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, s
 		goto xmitframe_coalesce_success;
 
 	/* IGTK key is not install, it may not support 802.11w */
-	if (padapter->securitypriv.binstallBIPkey != true) {
+	if (padapter->securitypriv.binstallBIPkey != true)
 		goto xmitframe_coalesce_success;
-	}
+
 	/* station mode doesn't need TX BIP, just ready the code */
 	if (bmcst) {
 		int frame_body_len;
@@ -1231,13 +1227,11 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, s
 			else
 				psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 
-			if (!psta) {
+			if (!psta)
 				goto xmitframe_coalesce_fail;
-			}
 
-			if (!(psta->state & _FW_LINKED) || !pxmitframe->buf_addr) {
+			if (!(psta->state & _FW_LINKED) || !pxmitframe->buf_addr)
 				goto xmitframe_coalesce_fail;
-			}
 
 			/* according 802.11-2012 standard, these five types are not robust types */
 			if (subtype == WIFI_ACTION &&
@@ -1414,9 +1408,8 @@ static struct xmit_buf *__rtw_alloc_cmd_xmitbuf(struct xmit_priv *pxmitpriv,
 		pxmitbuf->agg_num = 0;
 		pxmitbuf->pg_num = 0;
 
-		if (pxmitbuf->sctx) {
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 
 	return pxmitbuf;
@@ -1429,9 +1422,8 @@ struct xmit_frame *__rtw_alloc_cmdxmitframe(struct xmit_priv *pxmitpriv,
 	struct xmit_buf		*pxmitbuf;
 
 	pcmdframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (!pcmdframe) {
+	if (!pcmdframe)
 		return NULL;
-	}
 
 	pxmitbuf = __rtw_alloc_cmd_xmitbuf(pxmitpriv, buf_type);
 	if (!pxmitbuf) {
@@ -1480,9 +1472,8 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		pxmitbuf->pdata = pxmitbuf->ptail = pxmitbuf->phead;
 		pxmitbuf->agg_num = 1;
 
-		if (pxmitbuf->sctx) {
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 
 	spin_unlock_irqrestore(&pfree_queue->lock, irqL);
@@ -1541,9 +1532,8 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		pxmitbuf->agg_num = 0;
 		pxmitbuf->pg_num = 0;
 
-		if (pxmitbuf->sctx) {
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
@@ -1559,9 +1549,8 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 	if (!pxmitbuf)
 		return _FAIL;
 
-	if (pxmitbuf->sctx) {
+	if (pxmitbuf->sctx)
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_FREE);
-	}
 
 	if (pxmitbuf->buf_tag == XMITBUF_CMD) {
 	} else if (pxmitbuf->buf_tag == XMITBUF_MGNT) {
@@ -1814,9 +1803,8 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	signed int res = _SUCCESS;
 
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
-	if (pattrib->psta != psta) {
+	if (pattrib->psta != psta)
 		return _FAIL;
-	}
 
 	if (!psta) {
 		res = _FAIL;
@@ -1824,9 +1812,8 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 		goto exit;
 	}
 
-	if (!(psta->state & _FW_LINKED)) {
+	if (!(psta->state & _FW_LINKED))
 		return _FAIL;
-	}
 
 	ptxservq = rtw_get_sta_pending(padapter, psta, pattrib->priority, (u8 *)(&ac_index));
 
@@ -2016,9 +2003,9 @@ inline bool xmitframe_hiq_filter(struct xmit_frame *xmitframe)
 		if (attrib->ether_type == 0x0806 ||
 		    attrib->ether_type == 0x888e ||
 		    attrib->dhcp_pkt
-		) {
+		)
 			allow = true;
-		}
+
 	} else if (registry->hiq_filter == RTW_HIQ_FILTER_ALLOW_ALL)
 		allow = true;
 	else if (registry->hiq_filter == RTW_HIQ_FILTER_DENY_ALL) {
@@ -2041,17 +2028,14 @@ signed int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct x
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == false)
 		return ret;
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
-	if (pattrib->psta != psta) {
+	if (pattrib->psta != psta)
 		return false;
-	}
 
-	if (!psta) {
+	if (!psta)
 		return false;
-	}
 
-	if (!(psta->state & _FW_LINKED)) {
+	if (!(psta->state & _FW_LINKED))
 		return false;
-	}
 
 	if (pattrib->triggered == 1) {
 		if (bmcst && xmitframe_hiq_filter(pxmitframe))
@@ -2552,12 +2536,11 @@ int rtw_sctx_wait(struct submit_ctx *sctx, const char *msg)
 	int status = 0;
 
 	expire = sctx->timeout_ms ? msecs_to_jiffies(sctx->timeout_ms) : MAX_SCHEDULE_TIMEOUT;
-	if (!wait_for_completion_timeout(&sctx->done, expire)) {
+	if (!wait_for_completion_timeout(&sctx->done, expire))
 		/* timeout, do something?? */
 		status = RTW_SCTX_DONE_TIMEOUT;
-	} else {
+	else
 		status = sctx->status;
-	}
 
 	if (status == RTW_SCTX_DONE_SUCCESS)
 		ret = _SUCCESS;
diff --git a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
index 1d2c828cafe8..5f9e94a7e6ad 100644
--- a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
@@ -116,9 +116,9 @@ u8 HalPwrSeqCmdParsing(
 					else
 						udelay(10);
 
-					if (pollingCount++ > maxPollingCnt) {
+					if (pollingCount++ > maxPollingCnt)
 						return false;
-					}
+
 				} while (!bPollingBit);
 
 				break;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 509eac352c15..6b871f2cb8dd 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -151,9 +151,8 @@ bool HAL_IsLegalChannel(struct adapter *Adapter, u32 Channel)
 	bool bLegalChannel = true;
 
 	if ((Channel <= 14) && (Channel >= 1)) {
-		if (IsSupported24G(Adapter->registrypriv.wireless_mode) == false) {
+		if (IsSupported24G(Adapter->registrypriv.wireless_mode) == false)
 			bLegalChannel = false;
-		}
 	} else {
 		bLegalChannel = false;
 	}
@@ -1335,9 +1334,8 @@ bool GetHexValueFromString(char *szStr, u32 *pu4bVal, u32 *pu4bMove)
 	char *szScan = szStr;
 
 	/*  Check input parameter. */
-	if (!szStr || !pu4bVal || !pu4bMove) {
+	if (!szStr || !pu4bVal || !pu4bMove)
 		return false;
-	}
 
 	/*  Initialize output. */
 	*pu4bMove = 0;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index de73e6504d9c..94d11689b4ac 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -17,9 +17,8 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 Band, u8 RfPath,
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
 	u8	value = 0;
 
-	if (RfPath > ODM_RF_PATH_D) {
+	if (RfPath > ODM_RF_PATH_D)
 		return 0;
-	}
 
 	if (Band == BAND_ON_2_4G) {
 		switch (RateSection) {
@@ -105,9 +104,8 @@ phy_SetTxPowerByRateBase(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
 
-	if (RfPath > ODM_RF_PATH_D) {
+	if (RfPath > ODM_RF_PATH_D)
 		return;
-	}
 
 	if (Band == BAND_ON_2_4G) {
 		switch (RateSection) {
@@ -703,17 +701,14 @@ static void PHY_StoreTxPowerByRateNew(
 
 	PHY_GetRateValuesOfTxPowerByRate(padapter, RegAddr, BitMask, Data, rateIndex, PwrByRateVal, &rateNum);
 
-	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G) {
+	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G)
 		return;
-	}
 
-	if (RfPath > ODM_RF_PATH_D) {
+	if (RfPath > ODM_RF_PATH_D)
 		return;
-	}
 
-	if (TxNum > ODM_RF_PATH_D) {
+	if (TxNum > ODM_RF_PATH_D)
 		return;
-	}
 
 	for (i = 0; i < rateNum; ++i) {
 		if (rateIndex[i] == PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS0) ||
@@ -1004,9 +999,8 @@ u8 PHY_GetTxPowerIndexBase(
 	u8 txPower = 0;
 	u8 chnlIdx = (Channel-1);
 
-	if (HAL_IsLegalChannel(padapter, Channel) == false) {
+	if (HAL_IsLegalChannel(padapter, Channel) == false)
 		chnlIdx = 0;
-	}
 
 	*bIn24G = phy_GetChnlIndex(Channel, &chnlIdx);
 
@@ -1017,9 +1011,9 @@ u8 PHY_GetTxPowerIndexBase(
 			txPower = pHalData->Index24G_BW40_Base[RFPath][chnlIdx];
 
 		/*  OFDM-1T */
-		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate)) {
+		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate))
 			txPower += pHalData->OFDM_24G_Diff[RFPath][TX_1S];
-		}
+
 		if (BandWidth == CHANNEL_WIDTH_20) { /*  BW20-1S, BW20-2S */
 			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW20_24G_Diff[RFPath][TX_1S];
@@ -1058,9 +1052,8 @@ u8 PHY_GetTxPowerIndexBase(
 			txPower = pHalData->Index5G_BW40_Base[RFPath][chnlIdx];
 
 		/*  OFDM-1T */
-		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate)) {
+		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate))
 			txPower += pHalData->OFDM_5G_Diff[RFPath][TX_1S];
-		}
 
 		/*  BW20-1S, BW20-2S */
 		if (BandWidth == CHANNEL_WIDTH_20) {
@@ -1115,13 +1108,11 @@ s8 PHY_GetTxPowerTrackingOffset(struct adapter *padapter, u8 RFPath, u8 Rate)
 	if (pDM_Odm->RFCalibrateInfo.TxPowerTrackControl  == false)
 		return offset;
 
-	if ((Rate == MGN_1M) || (Rate == MGN_2M) || (Rate == MGN_5_5M) || (Rate == MGN_11M)) {
+	if ((Rate == MGN_1M) || (Rate == MGN_2M) || (Rate == MGN_5_5M) || (Rate == MGN_11M))
 		offset = pDM_Odm->Remnant_CCKSwingIdx;
-	} else {
+	else
 		offset = pDM_Odm->Remnant_OFDMSwingIdx[RFPath];
 
-	}
-
 	return offset;
 }
 
@@ -1399,18 +1390,17 @@ s8 PHY_GetTxPowerByRate(
 		   padapter->registrypriv.RegEnableTxPowerByRate == 0)
 		return 0;
 
-	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G) {
+	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G)
 		return value;
-	}
-	if (RFPath > ODM_RF_PATH_D) {
+
+	if (RFPath > ODM_RF_PATH_D)
 		return value;
-	}
-	if (TxNum >= RF_MAX_TX_NUM) {
+
+	if (TxNum >= RF_MAX_TX_NUM)
 		return value;
-	}
-	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE) {
+
+	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE)
 		return value;
-	}
 
 	return pHalData->TxPwrByRateOffset[Band][RFPath][TxNum][rateIndex];
 
@@ -1428,18 +1418,17 @@ void PHY_SetTxPowerByRate(
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 	u8 rateIndex = PHY_GetRateIndexOfTxPowerByRate(Rate);
 
-	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G) {
+	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G)
 		return;
-	}
-	if (RFPath > ODM_RF_PATH_D) {
+
+	if (RFPath > ODM_RF_PATH_D)
 		return;
-	}
-	if (TxNum >= RF_MAX_TX_NUM) {
+
+	if (TxNum >= RF_MAX_TX_NUM)
 		return;
-	}
-	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE) {
+
+	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE)
 		return;
-	}
 
 	pHalData->TxPwrByRateOffset[Band][RFPath][TxNum][rateIndex] = Value;
 }
@@ -1636,10 +1625,8 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 		channel = phy_GetChannelIndexOfTxPowerLimit(band_type, channel);
 
 	if (idx_band == -1 || idx_regulation == -1 || idx_bandwidth == -1 ||
-	    idx_rate_sctn == -1 || idx_channel == -1) {
-
+	    idx_rate_sctn == -1 || idx_channel == -1)
 		return MAX_POWER_INDEX;
-	}
 
 	if (band_type == BAND_ON_2_4G) {
 		s8 limits[10] = {0}; u8 i = 0;
@@ -1848,10 +1835,8 @@ void PHY_SetTxPowerLimit(
 		rateSection = 8;
 	else if (eqNByte(RateSection, (u8 *)("VHT"), 3) && eqNByte(RfPath, (u8 *)("4T"), 2))
 		rateSection = 9;
-	else {
+	else
 		return;
-	}
-
 
 	if (eqNByte(Bandwidth, (u8 *)("20M"), 3))
 		bandwidth = 0;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 66140fcfb40f..f2ab878babcb 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -197,9 +197,8 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 
 _ConstructBeacon:
 
-	if ((pktlen + TXDESC_SIZE) > 512) {
+	if ((pktlen + TXDESC_SIZE) > 512)
 		return;
-	}
 
 	*pLength = pktlen;
 
@@ -446,13 +445,11 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 				ratio_20_delay += pmlmeext->bcn_delay_ratio[i];
 				ratio_80_delay += pmlmeext->bcn_delay_ratio[i];
 
-				if (ratio_20_delay > 20 && pmlmeext->DrvBcnEarly == 0xff) {
+				if (ratio_20_delay > 20 && pmlmeext->DrvBcnEarly == 0xff)
 					pmlmeext->DrvBcnEarly = i;
-				}
 
-				if (ratio_80_delay > 80 && pmlmeext->DrvBcnTimeOut == 0xff) {
+				if (ratio_80_delay > 80 && pmlmeext->DrvBcnTimeOut == 0xff)
 					pmlmeext->DrvBcnTimeOut = i;
-				}
 
 				/* reset adaptive_early_32k cnt */
 				pmlmeext->bcn_delay_cnt[i] = 0;
@@ -553,9 +550,8 @@ static void rtl8723b_set_FwRsvdPagePkt(
 	MaxRsvdPageBufSize = RsvdPageNum*PageSize;
 
 	pcmdframe = rtw_alloc_cmdxmitframe(pxmitpriv);
-	if (!pcmdframe) {
+	if (!pcmdframe)
 		return;
-	}
 
 	ReservedPagePacket = pcmdframe->buf_addr;
 	memset(&RsvdPageLoc, 0, sizeof(struct rsvdpage_loc));
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 1930049756b2..e31ad3feed62 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -327,9 +327,8 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 	/* 2. read power_state = 0xA0[1:0] */
 	tmp_ps = rtw_read8(padapter, 0xa0);
 	tmp_ps &= 0x03;
-	if (tmp_ps != 0x01) {
+	if (tmp_ps != 0x01)
 		pdbgpriv->dbg_downloadfw_pwr_state_cnt++;
-	}
 
 	fwfilepath = "rtlwifi/rtl8723bs_nic.bin";
 
@@ -1970,11 +1969,10 @@ static void rtl8723b_SetHalODMVar(
 
 static void hal_notch_filter_8723b(struct adapter *adapter, bool enable)
 {
-	if (enable) {
+	if (enable)
 		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) | BIT1);
-	} else {
+	else
 		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) & ~BIT1);
-	}
 }
 
 static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 973ade5f0d54..e302c404fec0 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -777,9 +777,8 @@ static void PHY_HandleSwChnlAndSetBW8723B(
 	u8 tmpCenterFrequencyIndex1 = pHalData->CurrentCenterFrequencyIndex1;
 
 	/* check is swchnl or setbw */
-	if (!bSwitchChannel && !bSetBandWidth) {
+	if (!bSwitchChannel && !bSetBandWidth)
 		return;
-	}
 
 	/* skip change for channel or bandwidth is the same */
 	if (bSwitchChannel) {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 247cf095d0e1..b40d2e1a4fd1 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -19,9 +19,8 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
 		if (
 			(padapter->bSurpriseRemoved) ||
 			(padapter->bDriverStopped)
-		) {
+		)
 			return false;
-		}
 
 		HalQueryTxOQTBufferStatus8723BSdio(padapter);
 
@@ -275,14 +274,12 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 				}
 
 				/*  ok to send, remove frame from queue */
-				if (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true) {
+				if (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true)
 					if (
 						(pxmitframe->attrib.psta->state & WIFI_SLEEP_STATE) &&
 						(pxmitframe->attrib.triggered == 0)
-					) {
+					)
 						break;
-					}
-				}
 
 				list_del_init(&pxmitframe->list);
 				ptxservq->qcnt--;
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 839fd32fc8dc..0251ddafe605 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -651,9 +651,9 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 			if ((cpwm_orig ^ cpwm_now) & 0x80)
 				break;
 
-			if (jiffies_to_msecs(jiffies - start_time) > 100) {
+			if (jiffies_to_msecs(jiffies - start_time) > 100)
 				break;
-			}
+
 		} while (1);
 
 		rtl8723b_set_FwPwrModeInIPS_cmd(padapter, 0);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index d417b1372fe2..8df3350d53fb 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -469,9 +469,8 @@ static u32 sdio_write_port(
 	adapter = intfhdl->padapter;
 	psdio = &adapter_to_dvobj(adapter)->intf_data;
 
-	if (!adapter->hw_init_completed) {
+	if (!adapter->hw_init_completed)
 		return _FAIL;
-	}
 
 	cnt = round_up(cnt, 4);
 	HalSdioGetCmdAddr8723BSdio(adapter, addr, cnt >> 2, &addr);
@@ -856,9 +855,8 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 			skb_reserve(recvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 		}
 
-		if (!recvbuf->pskb) {
+		if (!recvbuf->pskb)
 			return NULL;
-		}
 	}
 
 	/* 3 3. read data from rxfifo */
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 3514a74068c3..ca58ea6c4fb8 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -236,9 +236,8 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
 	bssinf_len = pnetwork->network.IELength + sizeof(struct ieee80211_hdr_3addr);
-	if (bssinf_len > MAX_BSSINFO_LEN) {
+	if (bssinf_len > MAX_BSSINFO_LEN)
 		goto exit;
-	}
 
 	{
 		u16 wapi_len = 0;
@@ -246,9 +245,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		if (rtw_get_wapi_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &wapi_len) > 0)
 		{
 			if (wapi_len > 0)
-			{
 				goto exit;
-			}
 		}
 	}
 
@@ -411,11 +408,10 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 			}
 			if (!memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
 				&& !memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
-			) {
+			)
 				rtw_cfg80211_inform_bss(padapter, scanned);
-			} else {
+			else
 				rtw_warn_on(1);
-			}
 		}
 
 		if (!rtw_cfg80211_check_bss(padapter))
@@ -452,11 +448,10 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 
 		if (!memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
 			&& !memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
-		) {
+		)
 			rtw_cfg80211_inform_bss(padapter, scanned);
-		} else {
+		else
 			rtw_warn_on(1);
-		}
 	}
 
 check_bss:
@@ -2196,9 +2191,8 @@ static int cfg80211_rtw_del_pmksa(struct wiphy *wiphy,
 		}
 	}
 
-	if (false == bMatched) {
+	if (false == bMatched)
 		return -EINVAL;
-	}
 
 	return 0;
 }
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 730c4728ae92..21e85409edd1 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -208,11 +208,10 @@ static char *translate_scan(struct adapter *padapter,
 	if (vht_cap) {
 		max_rate = vht_data_rate;
 	} else if (ht_cap) {
-		if (mcs_rate&0x8000) { /* MCS15 */
+		if (mcs_rate&0x8000) /* MCS15 */
 			max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
-		} else { /* default MCS7 */
+		else /* default MCS7 */
 			max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
-		}
 
 		max_rate = max_rate*2;/* Mbps/2; */
 	}
@@ -2325,9 +2324,8 @@ static int rtw_set_pid(struct net_device *dev,
 	}
 
 	selector = *pdata;
-	if (selector < 3 && selector >= 0) {
+	if (selector < 3 && selector >= 0)
 		padapter->pid[selector] = *(pdata+1);
-	}
 
 exit:
 
@@ -2549,9 +2547,8 @@ static int rtw_dbg_port(struct net_device *dev,
 						int i;
 						struct recv_reorder_ctrl *preorder_ctrl;
 
-						for (i = 0; i < 16; i++) {
+						for (i = 0; i < 16; i++)
 							preorder_ctrl = &psta->recvreorder_ctrl[i];
-						}
 
 					}
 					break;
@@ -2586,11 +2583,9 @@ static int rtw_dbg_port(struct net_device *dev,
 
 								plist = get_next(plist);
 
-								if (extra_arg == psta->aid) {
-									for (j = 0; j < 16; j++) {
+								if (extra_arg == psta->aid)
+									for (j = 0; j < 16; j++)
 										preorder_ctrl = &psta->recvreorder_ctrl[j];
-									}
-								}
 							}
 						}
 
@@ -2619,12 +2614,11 @@ static int rtw_dbg_port(struct net_device *dev,
 					break;
 				case 0x0c:/* dump rx/tx packet */
 					{
-						if (arg == 0) {
+						if (arg == 0)
 							/* pHalData->bDumpRxPkt =extra_arg; */
 							rtw_hal_set_def_var(padapter, HAL_DEF_DBG_DUMP_RXPKT, &(extra_arg));
-						} else if (arg == 1) {
+						else if (arg == 1)
 							rtw_hal_set_def_var(padapter, HAL_DEF_DBG_DUMP_TXPKT, &(extra_arg));
-						}
 					}
 					break;
 				case 0x0e:
@@ -2654,18 +2648,16 @@ static int rtw_dbg_port(struct net_device *dev,
 					struct registry_priv *pregpriv = &padapter->registrypriv;
 					/*  0: disable, bit(0):enable 2.4g, bit(1):enable 5g, 0x3: enable both 2.4g and 5g */
 					/* default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
-					if (extra_arg == 0 || extra_arg == 1 || extra_arg == 2 || extra_arg == 3) {
+					if (extra_arg == 0 || extra_arg == 1 || extra_arg == 2 || extra_arg == 3)
 						pregpriv->rx_stbc = extra_arg;
-					}
 				}
 				break;
 				case 0x13: /* set ampdu_enable */
 				{
 					struct registry_priv *pregpriv = &padapter->registrypriv;
 					/*  0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
-					if (extra_arg < 3) {
+					if (extra_arg < 3)
 						pregpriv->ampdu_enable = extra_arg;
-					}
 				}
 				break;
 				case 0x14:
@@ -2704,11 +2696,10 @@ static int rtw_dbg_port(struct net_device *dev,
 						/*  extra_arg : */
 						/*  BIT0: Enable VHT LDPC Rx, BIT1: Enable VHT LDPC Tx, */
 						/*  BIT4: Enable HT LDPC Rx, BIT5: Enable HT LDPC Tx */
-						if (arg == 0) {
+						if (arg == 0)
 							pregistrypriv->ldpc_cap = 0x00;
-						} else if (arg == 1) {
+						else if (arg == 1)
 							pregistrypriv->ldpc_cap = (u8)(extra_arg&0x33);
-						}
 					}
 					break;
 				case 0x1a:
@@ -2717,11 +2708,10 @@ static int rtw_dbg_port(struct net_device *dev,
 						/*  extra_arg : */
 						/*  BIT0: Enable VHT STBC Rx, BIT1: Enable VHT STBC Tx, */
 						/*  BIT4: Enable HT STBC Rx, BIT5: Enable HT STBC Tx */
-						if (arg == 0) {
+						if (arg == 0)
 							pregistrypriv->stbc_cap = 0x00;
-						} else if (arg == 1) {
+						else if (arg == 1)
 							pregistrypriv->stbc_cap = (u8)(extra_arg&0x33);
-						}
 					}
 					break;
 				case 0x1b:
@@ -3038,10 +3028,9 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		}
 	} else {
 		psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-		if (!psta) {
+		if (!psta)
 			/* ret = -EINVAL; */
 			goto exit;
-		}
 	}
 
 	if (strcmp(param->u.crypt.alg, "none") == 0 && (psta == NULL)) {
@@ -3070,9 +3059,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
-			if (pwep == NULL) {
+			if (pwep == NULL)
 				goto exit;
-			}
 
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
@@ -3519,9 +3507,8 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	if (ie_len > 0) {
 		pmlmepriv->wps_beacon_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_beacon_ie_len = ie_len;
-		if (pmlmepriv->wps_beacon_ie == NULL) {
+		if (pmlmepriv->wps_beacon_ie == NULL)
 			return -EINVAL;
-		}
 
 		memcpy(pmlmepriv->wps_beacon_ie, param->u.bcn_ie.buf, ie_len);
 
@@ -3554,9 +3541,9 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_probe_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_probe_resp_ie_len = ie_len;
-		if (pmlmepriv->wps_probe_resp_ie == NULL) {
+		if (pmlmepriv->wps_probe_resp_ie == NULL)
 			return -EINVAL;
-		}
+
 		memcpy(pmlmepriv->wps_probe_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
 
@@ -3584,9 +3571,8 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_assoc_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_assoc_resp_ie_len = ie_len;
-		if (pmlmepriv->wps_assoc_resp_ie == NULL) {
+		if (pmlmepriv->wps_assoc_resp_ie == NULL)
 			return -EINVAL;
-		}
 
 		memcpy(pmlmepriv->wps_assoc_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
@@ -3939,9 +3925,8 @@ static int rtw_test(
 	len = wrqu->data.length;
 
 	pbuf = rtw_zmalloc(len);
-	if (pbuf == NULL) {
+	if (pbuf == NULL)
 		return -ENOMEM;
-	}
 
 	if (copy_from_user(pbuf, wrqu->data.pointer, len)) {
 		kfree(pbuf);
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 8a97458f05e0..f5c94509ad71 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -148,9 +148,9 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	buff = NULL;
 	if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
 		buff = rtw_zmalloc(IW_CUSTOM_MAX);
-		if (NULL == buff) {
+		if (NULL == buff)
 			return;
-		}
+
 		p = buff;
 
 		p += scnprintf(p, IW_CUSTOM_MAX - (p - buff), "ASSOCINFO(ReqIEs =");
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 2a366b4e3716..1f34cb2e367c 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -863,9 +863,8 @@ static int _netdev_open(struct net_device *pnetdev)
 			goto netdev_open_error;
 
 		status = rtw_start_drv_threads(padapter);
-		if (status == _FAIL) {
+		if (status == _FAIL)
 			goto netdev_open_error;
-		}
 
 		if (padapter->intf_start)
 			padapter->intf_start(padapter);
@@ -904,9 +903,8 @@ int netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
-	if (pwrctrlpriv->bInSuspend) {
+	if (pwrctrlpriv->bInSuspend)
 		return 0;
-	}
 
 	if (mutex_lock_interruptible(&(adapter_to_dvobj(padapter)->hw_init_mutex)))
 		return -1;
@@ -1179,21 +1177,19 @@ int rtw_suspend_common(struct adapter *padapter)
 	rtw_stop_cmd_thread(padapter);
 
 	/*  wait for the latest FW to remove this condition. */
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		hal_btcoex_SuspendNotify(padapter, 0);
-	} else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
+	else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 		hal_btcoex_SuspendNotify(padapter, 1);
-	}
 
 	rtw_ps_deny_cancel(padapter, PS_DENY_SUSPEND);
 
-	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
+	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 		rtw_suspend_normal(padapter);
-	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
+	else if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		rtw_suspend_normal(padapter);
-	} else {
+	else
 		rtw_suspend_normal(padapter);
-	}
 
 	DBG_871X_LEVEL(_drv_always_, "rtw suspend success in %d ms\n",
 		jiffies_to_msecs(jiffies - start_time));
@@ -1248,14 +1244,12 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 	netif_device_attach(pnetdev);
 	netif_carrier_on(pnetdev);
 
-	if (padapter->pid[1] != 0) {
+	if (padapter->pid[1] != 0)
 		rtw_signal_process(padapter->pid[1], SIGUSR2);
-	}
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 		if (rtw_chk_roam_flags(padapter, RTW_ROAM_ON_RESUME))
 			rtw_roaming(padapter, NULL);
-
 	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		rtw_ap_restore_network(padapter);
 	}
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index bb4835b64262..cd51430d4618 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -62,9 +62,8 @@ struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_L
 	pattrib = &prframe->u.hdr.attrib;
 
 	sub_skb = rtw_skb_alloc(nSubframe_Length + 12);
-	if (!sub_skb) {
+	if (!sub_skb)
 		return NULL;
-	}
 
 	skb_reserve(sub_skb, 12);
 	skb_put_data(sub_skb, (pdata + ETH_HLEN), nSubframe_Length);
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 99185fa73783..7010bdd0e69d 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -58,9 +58,8 @@ static void sd_sync_int_hdl(struct sdio_func *func)
 
 	psdpriv = sdio_get_drvdata(func);
 
-	if (!psdpriv->if1) {
+	if (!psdpriv->if1)
 		return;
-	}
 
 	rtw_sdio_set_irq_thd(psdpriv, current);
 	sd_int_hdl(psdpriv->if1);
@@ -390,9 +389,8 @@ static int rtw_drv_init(
 		goto exit;
 
 	if1 = rtw_sdio_if1_init(dvobj, id);
-	if (if1 == NULL) {
+	if (if1 == NULL)
 		goto free_dvobj;
-	}
 
 	/* dev_alloc_name && register_netdev */
 	status = rtw_drv_register_netdev(if1);
@@ -461,9 +459,8 @@ static int rtw_sdio_suspend(struct device *dev)
 	struct adapter *padapter = psdpriv->if1;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	if (padapter->bDriverStopped) {
+	if (padapter->bDriverStopped)
 		return 0;
-	}
 
 	if (pwrpriv->bInSuspend) {
 		pdbgpriv->dbg_suspend_error_cnt++;
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 6ece6daee499..5cedf775b6ef 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -40,9 +40,8 @@ u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return v;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -73,17 +72,15 @@ s32 _sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 
 	for (i = 0; i < cnt; i++) {
 		pdata[i] = sdio_readb(func, addr + i, &err);
-		if (err) {
+		if (err)
 			break;
-		}
 	}
 	return err;
 }
@@ -107,9 +104,8 @@ s32 sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -140,17 +136,15 @@ s32 _sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 
 	for (i = 0; i < cnt; i++) {
 		sdio_writeb(func, pdata[i], addr + i, &err);
-		if (err) {
+		if (err)
 			break;
-		}
 	}
 	return err;
 }
@@ -174,9 +168,8 @@ s32 sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -203,9 +196,8 @@ u8 sd_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return v;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -231,9 +223,8 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return v;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -284,9 +275,8 @@ void sd_write8(struct intf_hdl *pintfhdl, u32 addr, u8 v, s32 *err)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -310,9 +300,8 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -378,9 +367,8 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 
@@ -391,9 +379,8 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 		for (i = 0; i < cnt; i++) {
 			*(pbuf + i) = sdio_readb(func, addr + i, &err);
 
-			if (err) {
+			if (err)
 				break;
-			}
 		}
 		return err;
 	}
@@ -430,9 +417,9 @@ s32 sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
+
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
@@ -473,9 +460,8 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 /*	size = sdio_align_size(func, cnt); */
@@ -486,9 +472,8 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 
 		for (i = 0; i < cnt; i++) {
 			sdio_writeb(func, *(pbuf + i), addr + i, &err);
-			if (err) {
+			if (err)
 				break;
-			}
 		}
 
 		return err;
@@ -526,9 +511,8 @@ s32 sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 5e33b6c16157..639408eaf4df 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -112,9 +112,8 @@ static void rtw_check_xmit_resource(struct adapter *padapter, struct sk_buff *pk
 	queue = skb_get_queue_mapping(pkt);
 	if (padapter->registrypriv.wifi_spec) {
 		/* No free space for Tx, tx_worker is too slow */
-		if (pxmitpriv->hwxmits[queue].accnt > WMM_XMIT_THRESHOLD) {
+		if (pxmitpriv->hwxmits[queue].accnt > WMM_XMIT_THRESHOLD)
 			netif_stop_subqueue(padapter->pnetdev, queue);
-		}
 	} else {
 		if (pxmitpriv->free_xmitframe_cnt <= 4) {
 			if (!netif_tx_queue_stopped(netdev_get_tx_queue(padapter->pnetdev, queue)))
@@ -193,9 +192,8 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	s32 res = 0;
 
-	if (rtw_if_up(padapter) == false) {
+	if (rtw_if_up(padapter) == false)
 		goto drop_packet;
-	}
 
 	rtw_check_xmit_resource(padapter, pkt);
 
@@ -213,9 +211,8 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 	}
 
 	res = rtw_xmit(padapter, &pkt);
-	if (res < 0) {
+	if (res < 0)
 		goto drop_packet;
-	}
 
 	goto exit;
 
-- 
2.20.1

