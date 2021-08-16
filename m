Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30D73EDA61
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhHPQAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbhHPQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC060C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso2641127wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CwK14XhtNhJfxr0nQXR7R5W7bF6KMrmLfgORYDyN9jE=;
        b=LvLzYHzdwrqrW4gEW/iM++ZbthGQ6RfDRM3FsdfClfVYte2TqxrNWZcOi3Hu8CFlMT
         8fpYxExwuh/bvPWruDMLTvWvFeO/qsAQYPxr9ByCIJcA2cdYyywsJF9ocY9qpQoXkIsr
         Wv/bTkRh23lUaftUWjKd2T4qVIJc1r4GDov2IzKcvSCsP+Bg3EewoMsgYXfdZNErOgt5
         i6PHUK4p/01UED6GrGlIvz1wDg798JaJbJmSrEEfIsSecwnvJbmha7Va9VYalKgT+ho4
         mNxc6Z+h9BG8F0B0zDBoS0GV5bCZRq7TIFr2SthKNk387wKPxFTm0p8qVliaPxLHbi7d
         vEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CwK14XhtNhJfxr0nQXR7R5W7bF6KMrmLfgORYDyN9jE=;
        b=NmlwCE7S0BS5GJrcHIAztgVMIxP4uZ9NrSOcG/z6eus4PWAkoVeQY/UVHlPDPnGPL9
         eHm3V+pec/VdmXICYfZAwFAkCnhlERfBRHHubbRFNyWT5Z+KSSfPRLwbX0AVJgx5h1+x
         1v2YXLZr95C5VeFRQovqKE/RGivC2Vp+zNCloP2vXa+kaULb4OqYT6jhWjeFK8vxld+i
         lMZxPMoDnup77HLqzjewPgYMdxyCcNbT7y10cO/4h7u9i71BSzKoIw/Or3SbBZ4D8Ln2
         WAc7hgihzbBdrV9Kj3sW9QHbqnwfeZlb2hBgM13RKY4xZkJ/L61oOAWTg1XoyGLgfwn8
         mTTQ==
X-Gm-Message-State: AOAM533+uSlnk0/BpYJgO0qQNOiAt+4AL3EZn0HoZ1Gol4ZjHPd+J1sW
        SoIH4Vr5VTwDUntduNAVeh4G5SYKcP4=
X-Google-Smtp-Source: ABdhPJz5h3rJyq4t9mYuYPdPj4fhnkaZl9ViaVv333otJ0ilO5wi5sYqBRaWGgtE0r5CyserpBdDQw==
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr15481229wmj.81.1629129571446;
        Mon, 16 Aug 2021 08:59:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/23] staging: r8188eu: clean up spacing style issues in core/rtw_mlme.c
Date:   Mon, 16 Aug 2021 17:58:05 +0200
Message-Id: <20210816155818.24005-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_mlme.c reported by checkpatch.

CHECK: spaces preferred around that ...
CHECK: No space is necessary after a cast
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 80 ++++++++++++-------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d5ef5783f4ad..c0685965b436 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -31,7 +31,7 @@ u8 rtw_to_roaming(struct adapter *adapter)
 	return adapter->mlmepriv.to_roaming;
 }
 
-int	_rtw_init_mlme_priv (struct adapter *padapter)
+int _rtw_init_mlme_priv(struct adapter *padapter)
 {
 	int	i;
 	u8	*pbuf;
@@ -85,11 +85,11 @@ int	_rtw_init_mlme_priv (struct adapter *padapter)
 	return res;
 }
 
-static void rtw_mfree_mlme_priv_lock (struct mlme_priv *pmlmepriv)
+static void rtw_mfree_mlme_priv_lock(struct mlme_priv *pmlmepriv)
 {
 }
 
-#if defined (CONFIG_88EU_AP_MODE)
+#if defined(CONFIG_88EU_AP_MODE)
 static void rtw_free_mlme_ie_data(u8 **ppie, u32 *plen)
 {
 	kfree(*ppie);
@@ -118,13 +118,13 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
 }
 #endif
 
-void _rtw_free_mlme_priv (struct mlme_priv *pmlmepriv)
+void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
 
 	rtw_free_mlme_priv_ie_data(pmlmepriv);
 
 	if (pmlmepriv) {
-		rtw_mfree_mlme_priv_lock (pmlmepriv);
+		rtw_mfree_mlme_priv_lock(pmlmepriv);
 
 		vfree(pmlmepriv->free_bss_buf);
 	}
@@ -215,7 +215,7 @@ void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)))
 		lifetime = 1;
 	if (!isfreeall) {
-		delta_time = (curr_time - pnetwork->last_scanned)/HZ;
+		delta_time = (curr_time - pnetwork->last_scanned) / HZ;
 		if (delta_time < lifetime)/*  unit:sec */
 			return;
 	}
@@ -314,8 +314,8 @@ void rtw_generate_random_ibss(u8 *pibss)
 	pibss[1] = 0x11;
 	pibss[2] = 0x87;
 	pibss[3] = (u8)(curtime & 0xff);/* p[0]; */
-	pibss[4] = (u8)((curtime>>8) & 0xff);/* p[1]; */
-	pibss[5] = (u8)((curtime>>16) & 0xff);/* p[2]; */
+	pibss[4] = (u8)((curtime >> 8) & 0xff);/* p[1]; */
+	pibss[5] = (u8)((curtime >> 16) & 0xff);/* p[2]; */
 }
 
 u8 *rtw_get_capability_from_ie(u8 *ie)
@@ -342,7 +342,7 @@ u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
 	return ie + 8;
 }
 
-int	rtw_init_mlme_priv (struct adapter *padapter)/* struct	mlme_priv *pmlmepriv) */
+int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv) */
 {
 	int	res;
 
@@ -351,9 +351,9 @@ int	rtw_init_mlme_priv (struct adapter *padapter)/* struct	mlme_priv *pmlmepriv)
 	return res;
 }
 
-void rtw_free_mlme_priv (struct mlme_priv *pmlmepriv)
+void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-	_rtw_free_mlme_priv (pmlmepriv);
+	_rtw_free_mlme_priv(pmlmepriv);
 }
 
 static struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
@@ -642,7 +642,7 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 	privacy = pnetwork->network.Privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
+		if (rtw_get_wps_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, pnetwork->network.IELength - _FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
 			return false;
@@ -1061,8 +1061,8 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	/* update fw_state will clr _FW_UNDER_LINKING here indirectly */
 	switch (pnetwork->network.InfrastructureMode) {
 	case Ndis802_11Infrastructure:
-		if (pmlmepriv->fw_state&WIFI_UNDER_WPS)
-			pmlmepriv->fw_state = WIFI_STATION_STATE|WIFI_UNDER_WPS;
+		if (pmlmepriv->fw_state & WIFI_UNDER_WPS)
+			pmlmepriv->fw_state = WIFI_STATION_STATE | WIFI_UNDER_WPS;
 		else
 			pmlmepriv->fw_state = WIFI_STATION_STATE;
 		break;
@@ -1201,7 +1201,7 @@ void rtw_joinbss_event_callback(struct adapter *adapter, u8 *pbuf)
 static u8 search_max_mac_id(struct adapter *padapter)
 {
 	u8 mac_id;
-#if defined (CONFIG_88EU_AP_MODE)
+#if defined(CONFIG_88EU_AP_MODE)
 	u8 aid;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
@@ -1209,17 +1209,17 @@ static u8 search_max_mac_id(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-#if defined (CONFIG_88EU_AP_MODE)
+#if defined(CONFIG_88EU_AP_MODE)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		for (aid = (pstapriv->max_num_sta); aid > 0; aid--) {
-			if (pstapriv->sta_aid[aid-1])
+			if (pstapriv->sta_aid[aid - 1])
 				break;
 		}
 		mac_id = aid + 1;
 	} else
 #endif
 	{/* adhoc  id =  31~2 */
-		for (mac_id = (NUM_STA-1); mac_id >= IBSS_START_MAC_ID; mac_id--) {
+		for (mac_id = (NUM_STA - 1); mac_id >= IBSS_START_MAC_ID; mac_id--) {
 			if (pmlmeinfo->FW_sta_info[mac_id].status == 1)
 				break;
 		}
@@ -1240,7 +1240,7 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta,
 	macid = search_max_mac_id(adapter);
 	rtw_hal_set_hwreg(adapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&macid);
 	/* MACID|OPMODE:1 connect */
-	media_status_rpt = (u16)((psta->mac_id<<8) | mstatus);
+	media_status_rpt = (u16)((psta->mac_id << 8) | mstatus);
 	rtw_hal_set_hwreg(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT,
 			  (u8 *)&media_status_rpt);
 }
@@ -1256,7 +1256,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	if (rtw_access_ctrl(adapter, pstassoc->macaddr) == false)
 		return;
 
-#if defined (CONFIG_88EU_AP_MODE)
+#if defined(CONFIG_88EU_AP_MODE)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
 		if (psta)
@@ -1322,7 +1322,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 	if (mac_id >= 0) {
 		u16 media_status;
-		media_status = (mac_id<<8)|0; /*   MACID|OPMODE:0 means disconnect */
+		media_status = (mac_id << 8) | 0; /*   MACID|OPMODE:0 means disconnect */
 		/* for STA, AP, ADHOC mode, report disconnect stauts to FW */
 		rtw_hal_set_hwreg(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
 	}
@@ -1500,7 +1500,7 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
 	rcu_read_lock();
 
 	if (rcu_dereference(adapter->pnetdev->rx_handler_data) &&
-	    (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_ADHOC_STATE) == true)) {
+	    (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_ADHOC_STATE) == true)) {
 		/*  expire NAT2.5 entry */
 		nat25_db_expire(adapter);
 
@@ -1747,7 +1747,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) {
+		if (in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 && in_ie[i + 3] == 0x50  && in_ie[i + 4] == 0xF2 && in_ie[i + 5] == 0x02 && i + 5 < in_len) {
 			/* WMM element ID and OUI */
 			/* Append WMM IE to the last index of out_ie */
 
@@ -1760,7 +1760,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			out_ie[initial_out_len + 8] = 0x00;
 			break;
 		}
-		i += (in_ie[i+1]+2); /*  to the next IE element */
+		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 	return ielength;
 }
@@ -1846,13 +1846,13 @@ int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 		authmode = _WPA2_IE_ID_;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		memcpy(out_ie+ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
+		memcpy(out_ie + ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
 
 		ielength += psecuritypriv->wps_ie_len;
 	} else if ((authmode == _WPA_IE_ID_) || (authmode == _WPA2_IE_ID_)) {
 		/* copy RSN or SSN */
-		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1]+2);
-		ielength += psecuritypriv->supplicant_ie[1]+2;
+		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1] + 2);
+		ielength += psecuritypriv->supplicant_ie[1] + 2;
 		rtw_report_sec_ie(adapter, authmode, psecuritypriv->supplicant_ie);
 	}
 
@@ -1982,12 +1982,12 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 
 	phtpriv->ht_option = false;
 
-	p = rtw_get_ie(in_ie+12, _HT_CAPABILITY_IE_, &ielen, in_len-12);
+	p = rtw_get_ie(in_ie + 12, _HT_CAPABILITY_IE_, &ielen, in_len - 12);
 
 	if (p && ielen > 0) {
 		if (pqospriv->qos_option == 0) {
 			out_len = *pout_len;
-			rtw_set_ie(out_ie+out_len, _VENDOR_SPECIFIC_IE_,
+			rtw_set_ie(out_ie + out_len, _VENDOR_SPECIFIC_IE_,
 				   _WMM_IE_Length_, WMM_IE, pout_len);
 
 			pqospriv->qos_option = 1;
@@ -2012,22 +2012,22 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		*/
 
 		rtw_hal_get_def_var(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor);
-		ht_capie.ampdu_params_info = (max_rx_ampdu_factor&0x03);
+		ht_capie.ampdu_params_info = (max_rx_ampdu_factor & 0x03);
 
 		if (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
 			ht_capie.ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_DENSITY & (0x07 << 2));
 		else
 			ht_capie.ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
 
-		rtw_set_ie(out_ie+out_len, _HT_CAPABILITY_IE_,
+		rtw_set_ie(out_ie + out_len, _HT_CAPABILITY_IE_,
 			   sizeof(struct ieee80211_ht_cap), (unsigned char *)&ht_capie, pout_len);
 
 		phtpriv->ht_option = true;
 
-		p = rtw_get_ie(in_ie+12, _HT_ADD_INFO_IE_, &ielen, in_len-12);
+		p = rtw_get_ie(in_ie + 12, _HT_ADD_INFO_IE_, &ielen, in_len - 12);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
 			out_len = *pout_len;
-			rtw_set_ie(out_ie+out_len, _HT_ADD_INFO_IE_, ielen, p+2, pout_len);
+			rtw_set_ie(out_ie + out_len, _HT_ADD_INFO_IE_, ielen, p + 2, pout_len);
 		}
 	}
 	return phtpriv->ht_option;
@@ -2065,15 +2065,15 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 
 	/* check Max Rx A-MPDU Size */
 	len = 0;
-	p = rtw_get_ie(pie+sizeof(struct ndis_802_11_fixed_ie), _HT_CAPABILITY_IE_, &len, ie_len-sizeof(struct ndis_802_11_fixed_ie));
+	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fixed_ie), _HT_CAPABILITY_IE_, &len, ie_len - sizeof(struct ndis_802_11_fixed_ie));
 	if (p && len > 0) {
-		pht_capie = (struct ieee80211_ht_cap *)(p+2);
+		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		max_ampdu_sz = (pht_capie->ampdu_params_info & IEEE80211_HT_AMPDU_PARM_FACTOR);
-		max_ampdu_sz = 1 << (max_ampdu_sz+3); /*  max_ampdu_sz (kbytes); */
+		max_ampdu_sz = 1 << (max_ampdu_sz + 3); /*  max_ampdu_sz (kbytes); */
 		phtpriv->rx_ampdu_maxlen = max_ampdu_sz;
 	}
 	len = 0;
-	p = rtw_get_ie(pie+sizeof(struct ndis_802_11_fixed_ie), _HT_ADD_INFO_IE_, &len, ie_len-sizeof(struct ndis_802_11_fixed_ie));
+	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fixed_ie), _HT_ADD_INFO_IE_, &len, ie_len - sizeof(struct ndis_802_11_fixed_ie));
 
 	/* update cur_bwmode & cur_ch_offset */
 	if ((pregistrypriv->cbw40_enable) &&
@@ -2140,13 +2140,13 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 	phtpriv = &psta->htpriv;
 
 	if ((phtpriv->ht_option) && (phtpriv->ampdu_enable)) {
-		issued = (phtpriv->agg_enable_bitmap>>priority)&0x1;
-		issued |= (phtpriv->candidate_tid_bitmap>>priority)&0x1;
+		issued = (phtpriv->agg_enable_bitmap >> priority) & 0x1;
+		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
 		if (0 == issued) {
 			DBG_88E("rtw_issue_addbareq_cmd, p=%d\n", priority);
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
-			rtw_addbareq_cmd(padapter, (u8) priority, pattrib->ra);
+			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
 	}
 }
-- 
2.32.0

