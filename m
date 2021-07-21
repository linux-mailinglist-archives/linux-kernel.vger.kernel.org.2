Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100183D0FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbhGUNAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhGUM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920C9C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w14so2418495edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2qzbzilDbF9lWYMpB1u3RoHGpflvnv7ZEgi6L+uTk+M=;
        b=WOQOvRsStjd8k/exBgDrbW/GR9QG2EfuciMIxuKodkSKi3AAFsX/3cvqXNHfymJNzs
         JP3gbUnQIIG4cXmntX6ZJ/JoRoduGRerbn5W3yVwTdKswNmAg4ivyvPoqyVl0wXyc6ds
         JAJ910pUnraRe0eUFaCzAjIKrD/L4sp/e/uilaMfBlCTyTSrZHUGU4D5SArnEMiq1NL0
         oV19BeFNLMfAamoV+E+TYxEED2NRPPPAPptBr2XsqKjycPbTDV6Ph0KTJGKnZUJfAj0v
         nTZ0LKx9mChr9MgWPJR81l5kbuLGbG3JhIS7O9N0aO/r98n6mfibeC2fGbw1Yk9M88IO
         XWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2qzbzilDbF9lWYMpB1u3RoHGpflvnv7ZEgi6L+uTk+M=;
        b=YwdyXxuqPHE/A04M3Rb857Oc1kDfin1cmovANX56tWsX5NLRxBscPTWBhMldb0M2iG
         No/nFGCEG7fYtyOuxH8SZ/cCv1Wsj6TepWwhS8yAPj2e8nSxhvfrJUf1dA/CoCJ5QJGF
         J4tCg/OUIvtDkcDYjrvty0wqBngzgOSNmEVH3PQbzZwC1rGT92g8/a3VdarR2M/ZcOD/
         LDtOjrfoHt5AxRcnwURK/Whyfv7BsZQCBf2X/mNgFhMCvOIXQsMiRqFGr/sSHZA1W49P
         xzzAVdZzWva76HjBIxKiqhoz92zOEEr+k2CA858IrcBbk6OrwJudakaNl3lLTQAflE6Z
         nNtA==
X-Gm-Message-State: AOAM531mr3JhHSbRrCWKGfQQOyY7+QYKoAn4py/NBHA7czF1ES6Sl8Pp
        Dk3ijGIIgJA53aCBu1DAvkFUxs9sW6c=
X-Google-Smtp-Source: ABdhPJxXd4xM5KkRpcoLgdW3NdRxPdU5315RqIw/qV5OEv7vZjFurJR3uEf//QuiVBt3puZOTw4qEw==
X-Received: by 2002:a05:6402:b8a:: with SMTP id cf10mr48277687edb.61.1626874656191;
        Wed, 21 Jul 2021 06:37:36 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id p18sm10673531edu.8.2021.07.21.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:35 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/16] staging: rtl8723bs: fix camel case in struct wlan_bssid_ex
Date:   Wed, 21 Jul 2021 15:37:14 +0200
Message-Id: <561065e95ff38f0dbedf030c3acf0498396a1759.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case in struct wlan_bssid_ex.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 124 ++++-----
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  50 ++--
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  52 ++--
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  12 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 216 +++++++--------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 248 +++++++++---------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  58 ++--
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |   2 +-
 drivers/staging/rtl8723bs/hal/hal_com.c       |   2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  22 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h  |   6 +-
 .../staging/rtl8723bs/include/wlan_bssdef.h   |  30 +--
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  64 ++---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 104 ++++----
 14 files changed, 495 insertions(+), 495 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index da67adde2ebd..6adefdbb7407 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -56,7 +56,7 @@ static void update_BCNTIM(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
-	unsigned char *pie = pnetwork_mlmeext->IEs;
+	unsigned char *pie = pnetwork_mlmeext->ies;
 
 	/* update TIM IE */
 	u8 *p, *dst_ie, *premainder_ie = NULL, *pbackup_remainder_ie = NULL;
@@ -68,7 +68,7 @@ static void update_BCNTIM(struct adapter *padapter)
 	p = rtw_get_ie(pie + _FIXED_IE_LENGTH_,
 		       WLAN_EID_TIM,
 		       &tim_ielen,
-		       pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_
+		       pnetwork_mlmeext->ie_length - _FIXED_IE_LENGTH_
 	);
 	if (p && tim_ielen > 0) {
 		tim_ielen += 2;
@@ -77,7 +77,7 @@ static void update_BCNTIM(struct adapter *padapter)
 
 		tim_ie_offset = (signed int)(p - pie);
 
-		remainder_ielen = pnetwork_mlmeext->IELength - tim_ie_offset - tim_ielen;
+		remainder_ielen = pnetwork_mlmeext->ie_length - tim_ie_offset - tim_ielen;
 
 		/* append TIM IE from dst_ie offset */
 		dst_ie = p;
@@ -91,7 +91,7 @@ static void update_BCNTIM(struct adapter *padapter)
 		p = rtw_get_ie(pie + _BEACON_IE_OFFSET_,
 			       WLAN_EID_SSID,
 			       &tmp_len,
-			       (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
+			       (pnetwork_mlmeext->ie_length - _BEACON_IE_OFFSET_)
 		);
 		if (p)
 			offset += tmp_len + 2;
@@ -99,7 +99,7 @@ static void update_BCNTIM(struct adapter *padapter)
 		/*  get supported rates len */
 		p = rtw_get_ie(pie + _BEACON_IE_OFFSET_,
 			       WLAN_EID_SUPP_RATES, &tmp_len,
-			       (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
+			       (pnetwork_mlmeext->ie_length - _BEACON_IE_OFFSET_)
 		);
 		if (p)
 			offset += tmp_len + 2;
@@ -109,7 +109,7 @@ static void update_BCNTIM(struct adapter *padapter)
 
 		premainder_ie = pie + offset;
 
-		remainder_ielen = pnetwork_mlmeext->IELength - offset - tim_ielen;
+		remainder_ielen = pnetwork_mlmeext->ie_length - offset - tim_ielen;
 
 		/* append TIM IE from offset */
 		dst_ie = pie + offset;
@@ -161,7 +161,7 @@ static void update_BCNTIM(struct adapter *padapter)
 	}
 
 	offset =  (uint)(dst_ie - pie);
-	pnetwork_mlmeext->IELength = offset + remainder_ielen;
+	pnetwork_mlmeext->ie_length = offset + remainder_ielen;
 }
 
 static u8 chk_sta_is_alive(struct sta_info *psta)
@@ -340,7 +340,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 
 	shortGIrate = query_ra_short_GI(psta);
 
-	if (pcur_network->Configuration.DSConfig > 14) {
+	if (pcur_network->configuration.DSConfig > 14) {
 		sta_band |= WIRELESS_INVALID;
 	} else {
 		if (tx_ra_bitmap & 0xffff000)
@@ -397,16 +397,16 @@ void update_bmc_sta(struct adapter *padapter)
 		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
 
 		/* prepare for add_RATid */
-		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->SupportedRates);
-		network_type = rtw_check_network_type((u8 *)&pcur_network->SupportedRates,
+		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
+		network_type = rtw_check_network_type((u8 *)&pcur_network->supported_rates,
 						      supportRateNum,
-						      pcur_network->Configuration.DSConfig
+						      pcur_network->configuration.DSConfig
 		);
 		if (is_supported_tx_cck(network_type)) {
 			network_type = WIRELESS_11B;
 		} else if (network_type == WIRELESS_INVALID) { /*  error handling */
 
-			if (pcur_network->Configuration.DSConfig > 14)
+			if (pcur_network->configuration.DSConfig > 14)
 				network_type = WIRELESS_INVALID;
 			else
 				network_type = WIRELESS_11B;
@@ -572,8 +572,8 @@ static void update_ap_info(struct adapter *padapter, struct sta_info *psta)
 
 	psta->wireless_mode = pmlmeext->cur_wireless_mode;
 
-	psta->bssratelen = rtw_get_rateset_len(pnetwork->SupportedRates);
-	memcpy(psta->bssrateset, pnetwork->SupportedRates, psta->bssratelen);
+	psta->bssratelen = rtw_get_rateset_len(pnetwork->supported_rates);
+	memcpy(psta->bssrateset, pnetwork->supported_rates, psta->bssratelen);
 
 	/* HT related cap */
 	if (phtpriv_ap->ht_option) {
@@ -656,16 +656,16 @@ void start_bss_network(struct adapter *padapter)
 	struct HT_info_element *pht_info = NULL;
 	u8 cbw40_enable = 0;
 
-	bcn_interval = (u16)pnetwork->Configuration.BeaconPeriod;
-	cur_channel = pnetwork->Configuration.DSConfig;
+	bcn_interval = (u16)pnetwork->configuration.BeaconPeriod;
+	cur_channel = pnetwork->configuration.DSConfig;
 	cur_bwmode = CHANNEL_WIDTH_20;
 	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	/* check if there is wps ie, */
 	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
 	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
-	if (!rtw_get_wps_ie(pnetwork->IEs + _FIXED_IE_LENGTH_,
-			    pnetwork->IELength - _FIXED_IE_LENGTH_, NULL, NULL))
+	if (!rtw_get_wps_ie(pnetwork->ies + _FIXED_IE_LENGTH_,
+			    pnetwork->ie_length - _FIXED_IE_LENGTH_, NULL, NULL))
 		pmlmeext->bstart_bss = true;
 
 	/* todo: update wmm, ht cap */
@@ -694,7 +694,7 @@ void start_bss_network(struct adapter *padapter)
 	Set_MSR(padapter, _HW_STATE_AP_);
 
 	/* Set BSSID REG */
-	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pnetwork->MacAddress);
+	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pnetwork->mac_address);
 
 	/* Set EDCA param reg */
 	acparm = 0x002F3217; /*  VO */
@@ -734,10 +734,10 @@ void start_bss_network(struct adapter *padapter)
 	}
 
 	/* set channel, bwmode */
-	p = rtw_get_ie((pnetwork->IEs + sizeof(struct ndis_802_11_fix_ie)),
+	p = rtw_get_ie((pnetwork->ies + sizeof(struct ndis_802_11_fix_ie)),
 		       WLAN_EID_HT_OPERATION,
 		       &ie_len,
-		       (pnetwork->IELength - sizeof(struct ndis_802_11_fix_ie))
+		       (pnetwork->ie_length - sizeof(struct ndis_802_11_fix_ie))
 	);
 	if (p && ie_len) {
 		pht_info = (struct HT_info_element *)(p + 2);
@@ -780,14 +780,14 @@ void start_bss_network(struct adapter *padapter)
 	pmlmeext->cur_wireless_mode = pmlmepriv->cur_network.network_type;
 
 	/* let pnetwork_mlmeext == pnetwork_mlme. */
-	memcpy(pnetwork_mlmeext, pnetwork, pnetwork->Length);
+	memcpy(pnetwork_mlmeext, pnetwork, pnetwork->length);
 
 	/* update cur_wireless_mode */
 	update_wireless_mode(padapter);
 
 	/* update RRSR after set channel and bandwidth */
-	UpdateBrateTbl(padapter, pnetwork->SupportedRates);
-	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->SupportedRates);
+	UpdateBrateTbl(padapter, pnetwork->supported_rates);
+	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->supported_rates);
 
 	/* update capability after cur_wireless_mode updated */
 	update_capinfo(
@@ -827,7 +827,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_bssid_ex
 		*pbss_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
-	u8 *ie = pbss_network->IEs;
+	u8 *ie = pbss_network->ies;
 
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return _FAIL;
@@ -835,23 +835,23 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	if (len < 0 || len > MAX_IE_SZ)
 		return _FAIL;
 
-	pbss_network->IELength = len;
+	pbss_network->ie_length = len;
 
 	memset(ie, 0, MAX_IE_SZ);
 
-	memcpy(ie, pbuf, pbss_network->IELength);
+	memcpy(ie, pbuf, pbss_network->ie_length);
 
-	if (pbss_network->InfrastructureMode != Ndis802_11APMode)
+	if (pbss_network->infrastructure_mode != Ndis802_11APMode)
 		return _FAIL;
 
-	pbss_network->Rssi = 0;
+	pbss_network->rssi = 0;
 
-	memcpy(pbss_network->MacAddress, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pbss_network->mac_address, myid(&(padapter->eeprompriv)), ETH_ALEN);
 
 	/* beacon interval */
 	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
-	/* pbss_network->Configuration.BeaconPeriod = le16_to_cpu(*(unsigned short*)p); */
-	pbss_network->Configuration.BeaconPeriod = get_unaligned_le16(p);
+	/* pbss_network->configuration.BeaconPeriod = le16_to_cpu(*(unsigned short*)p); */
+	pbss_network->configuration.BeaconPeriod = get_unaligned_le16(p);
 
 	/* capability */
 	/* cap = *(unsigned short *)rtw_get_capability_from_ie(ie); */
@@ -863,26 +863,26 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_SSID,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
-		memset(&pbss_network->Ssid, 0, sizeof(struct ndis_802_11_ssid));
-		memcpy(pbss_network->Ssid.Ssid, (p + 2), ie_len);
-		pbss_network->Ssid.SsidLength = ie_len;
+		memset(&pbss_network->ssid, 0, sizeof(struct ndis_802_11_ssid));
+		memcpy(pbss_network->ssid.Ssid, (p + 2), ie_len);
+		pbss_network->ssid.SsidLength = ie_len;
 	}
 
 	/* channel */
 	channel = 0;
-	pbss_network->Configuration.Length = 0;
+	pbss_network->configuration.Length = 0;
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_DS_PARAMS, &ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		channel = *(p + 2);
 
-	pbss_network->Configuration.DSConfig = channel;
+	pbss_network->configuration.DSConfig = channel;
 
 	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
 	/*  get supported rates */
@@ -890,7 +890,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_SUPP_RATES,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p !=  NULL) {
 		memcpy(supportRate, p + 2, ie_len);
@@ -902,7 +902,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_EXT_SUPP_RATES,
 		&ie_len,
-		pbss_network->IELength - _BEACON_IE_OFFSET_
+		pbss_network->ie_length - _BEACON_IE_OFFSET_
 	);
 	if (p !=  NULL) {
 		memcpy(supportRate + supportRateNum, p + 2, ie_len);
@@ -911,23 +911,23 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	network_type = rtw_check_network_type(supportRate, supportRateNum, channel);
 
-	rtw_set_supported_rate(pbss_network->SupportedRates, network_type);
+	rtw_set_supported_rate(pbss_network->supported_rates, network_type);
 
 	/* parsing ERP_IE */
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_ERP_INFO,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		ERP_IE_handler(padapter, (struct ndis_80211_var_ie *)p);
 
 	/* update privacy/security */
 	if (cap & BIT(4))
-		pbss_network->Privacy = 1;
+		pbss_network->privacy = 1;
 	else
-		pbss_network->Privacy = 0;
+		pbss_network->privacy = 0;
 
 	psecuritypriv->wpa_psk = 0;
 
@@ -939,7 +939,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_RSN,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
 		if (rtw_parse_wpa2_ie(
@@ -969,7 +969,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 			p,
 			WLAN_EID_VENDOR_SPECIFIC,
 			&ie_len,
-			(pbss_network->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2))
+			(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
 		);
 		if ((p) && (!memcmp(p + 2, OUI1, 4))) {
 			if (rtw_parse_wpa_ie(
@@ -1005,7 +1005,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 				p,
 				WLAN_EID_VENDOR_SPECIFIC,
 				&ie_len,
-				(pbss_network->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2))
+				(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
 			);
 			if ((p) && !memcmp(p + 2, WMM_PARA_IE, 6)) {
 				pmlmepriv->qospriv.qos_option = 1;
@@ -1032,7 +1032,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_HT_CAPABILITY,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
 		u8 rf_type = 0;
@@ -1095,23 +1095,23 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_HT_OPERATION,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		pHT_info_ie = p;
 
 	switch (network_type) {
 	case WIRELESS_11B:
-		pbss_network->NetworkTypeInUse = Ndis802_11DS;
+		pbss_network->network_type_in_use = Ndis802_11DS;
 		break;
 	case WIRELESS_11G:
 	case WIRELESS_11BG:
 	case WIRELESS_11G_24N:
 	case WIRELESS_11BG_24N:
-		pbss_network->NetworkTypeInUse = Ndis802_11OFDM24;
+		pbss_network->network_type_in_use = Ndis802_11OFDM24;
 		break;
 	default:
-		pbss_network->NetworkTypeInUse = Ndis802_11OFDM24;
+		pbss_network->network_type_in_use = Ndis802_11OFDM24;
 		break;
 	}
 
@@ -1138,7 +1138,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		HT_info_handler(padapter, (struct ndis_80211_var_ie *)pHT_info_ie);
 	}
 
-	pbss_network->Length = get_wlan_bssid_ex_sz(
+	pbss_network->length = get_wlan_bssid_ex_sz(
 		(struct wlan_bssid_ex  *)pbss_network
 	);
 
@@ -1147,9 +1147,9 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	rtw_startbss_cmd(padapter, RTW_CMDF_WAIT_ACK);
 
 	/* alloc sta_info for ap itself */
-	psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->MacAddress);
+	psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->mac_address);
 	if (!psta) {
-		psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->MacAddress);
+		psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->mac_address);
 		if (psta == NULL)
 			return _FAIL;
 	}
@@ -1405,7 +1405,7 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
-	unsigned char *p, *ie = pnetwork->IEs;
+	unsigned char *p, *ie = pnetwork->ies;
 	u32 len = 0;
 
 	if (!pmlmeinfo->ERP_enable)
@@ -1416,7 +1416,7 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 		ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_ERP_INFO,
 		&len,
-		(pnetwork->IELength - _BEACON_IE_OFFSET_)
+		(pnetwork->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && len > 0) {
 		struct ndis_80211_var_ie *pIE = (struct ndis_80211_var_ie *)p;
@@ -1469,8 +1469,8 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
-	unsigned char *ie = pnetwork->IEs;
-	u32 ielen = pnetwork->IELength;
+	unsigned char *ie = pnetwork->ies;
+	u32 ielen = pnetwork->ie_length;
 
 	pwps_ie = rtw_get_wps_ie(
 		ie + _FIXED_IE_LENGTH_,
@@ -1506,8 +1506,8 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 		if (pbackup_remainder_ie)
 			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
 
-		/* update IELength */
-		pnetwork->IELength = wps_offset + (wps_ielen + 2) + remainder_ielen;
+		/* update ie_length */
+		pnetwork->ie_length = wps_offset + (wps_ielen + 2) + remainder_ielen;
 	}
 
 	kfree(pbackup_remainder_ie);
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 04956ccf485c..865b42699335 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -656,7 +656,7 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 	pcmd->rsp = NULL;
 	pcmd->rspsz = 0;
 
-	pdev_network->Length = pcmd->cmdsz;
+	pdev_network->length = pcmd->cmdsz;
 
 	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
 
@@ -722,7 +722,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct ht_priv 		*phtpriv = &pmlmepriv->htpriv;
-	enum ndis_802_11_network_infrastructure ndis_network_mode = pnetwork->network.InfrastructureMode;
+	enum ndis_802_11_network_infrastructure ndis_network_mode = pnetwork->network.infrastructure_mode;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u32 tmp_len;
@@ -733,7 +733,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 		res = _FAIL;
 		goto exit;
 	}
-	/* for IEs is fix buf size */
+	/* for ies is fix buf size */
 	t_len = sizeof(struct wlan_bssid_ex);
 
 
@@ -762,32 +762,32 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	memcpy(psecnetwork, &pnetwork->network, get_wlan_bssid_ex_sz(&pnetwork->network));
 
-	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->IELength;
+	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->ie_length;
 
-	if ((psecnetwork->IELength-12) < (256-1))
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], psecnetwork->IELength-12);
+	if ((psecnetwork->ie_length-12) < (256-1))
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], psecnetwork->ie_length-12);
 	else
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], (256-1));
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], (256-1));
 
-	psecnetwork->IELength = 0;
+	psecnetwork->ie_length = 0;
 	/*  Added by Albert 2009/02/18 */
 	/*  If the driver wants to use the bssid to create the connection. */
 	/*  If not,  we have to copy the connecting AP's MAC address to it so that */
 	/*  the driver just has the bssid information for PMKIDList searching. */
 
 	if (pmlmepriv->assoc_by_bssid == false)
-		memcpy(&pmlmepriv->assoc_bssid[0], &pnetwork->network.MacAddress[0], ETH_ALEN);
+		memcpy(&pmlmepriv->assoc_bssid[0], &pnetwork->network.mac_address[0], ETH_ALEN);
 
-	psecnetwork->IELength = rtw_restruct_sec_ie(padapter, &pnetwork->network.IEs[0], &psecnetwork->IEs[0], pnetwork->network.IELength);
+	psecnetwork->ie_length = rtw_restruct_sec_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0], pnetwork->network.ie_length);
 
 
 	pqospriv->qos_option = 0;
 
 	if (pregistrypriv->wmm_enable) {
-		tmp_len = rtw_restruct_wmm_ie(padapter, &pnetwork->network.IEs[0], &psecnetwork->IEs[0], pnetwork->network.IELength, psecnetwork->IELength);
+		tmp_len = rtw_restruct_wmm_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0], pnetwork->network.ie_length, psecnetwork->ie_length);
 
-		if (psecnetwork->IELength != tmp_len) {
-			psecnetwork->IELength = tmp_len;
+		if (psecnetwork->ie_length != tmp_len) {
+			psecnetwork->ie_length = tmp_len;
 			pqospriv->qos_option = 1; /* There is WMM IE in this corresp. beacon */
 		} else {
 			pqospriv->qos_option = 0;/* There is no WMM IE in this corresp. beacon */
@@ -795,7 +795,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	}
 
 	phtpriv->ht_option = false;
-	ptmp = rtw_get_ie(&pnetwork->network.IEs[12], WLAN_EID_HT_CAPABILITY, &tmp_len, pnetwork->network.IELength-12);
+	ptmp = rtw_get_ie(&pnetwork->network.ies[12], WLAN_EID_HT_CAPABILITY, &tmp_len, pnetwork->network.ie_length-12);
 	if (pregistrypriv->ht_enable && ptmp && tmp_len > 0) {
 		/* 	Added by Albert 2010/06/23 */
 		/* 	For the WEP mode, we will use the bg mode to do the connection to avoid some IOT issue. */
@@ -805,18 +805,18 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 			(padapter->securitypriv.dot11PrivacyAlgrthm != _TKIP_)) {
 			rtw_ht_use_default_setting(padapter);
 
-			rtw_build_wmm_ie_ht(padapter, &psecnetwork->IEs[12], &psecnetwork->IELength);
+			rtw_build_wmm_ie_ht(padapter, &psecnetwork->ies[12], &psecnetwork->ie_length);
 
 			/* rtw_restructure_ht_ie */
-			rtw_restructure_ht_ie(padapter, &pnetwork->network.IEs[12], &psecnetwork->IEs[0],
-									pnetwork->network.IELength-12, &psecnetwork->IELength,
-									pnetwork->network.Configuration.DSConfig);
+			rtw_restructure_ht_ie(padapter, &pnetwork->network.ies[12], &psecnetwork->ies[0],
+									pnetwork->network.ie_length-12, &psecnetwork->ie_length,
+									pnetwork->network.configuration.DSConfig);
 		}
 	}
 
-	rtw_append_exented_cap(padapter, &psecnetwork->IEs[0], &psecnetwork->IELength);
+	rtw_append_exented_cap(padapter, &psecnetwork->ies[0], &psecnetwork->ie_length);
 
-	pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->network.IEs, pnetwork->network.IELength);
+	pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->network.ies, pnetwork->network.ie_length);
 
 	pcmd->cmdsz = get_wlan_bssid_ex_sz(psecnetwork);/* get cmdsz before endian conversion */
 
@@ -1973,9 +1973,9 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
+		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->mac_address);
 		if (!psta) {
-			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
+			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->mac_address);
 			if (!psta)
 				goto createbss_cmd_fail;
 		}
@@ -1995,8 +1995,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 			list_add_tail(&(pwlan->list), &pmlmepriv->scanned_queue.queue);
 		}
 
-		pnetwork->Length = get_wlan_bssid_ex_sz(pnetwork);
-		memcpy(&(pwlan->network), pnetwork, pnetwork->Length);
+		pnetwork->length = get_wlan_bssid_ex_sz(pnetwork);
+		memcpy(&(pwlan->network), pnetwork, pnetwork->length);
 		/* pwlan->fixed = true; */
 
 		/* list_add_tail(&(pwlan->list), &pmlmepriv->scanned_queue.queue); */
@@ -2005,7 +2005,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		memcpy(&tgt_network->network, pnetwork, (get_wlan_bssid_ex_sz(pnetwork)));
 
 		/*  reset DSConfig */
-		/* tgt_network->network.Configuration.DSConfig = (u32)rtw_ch2freq(pnetwork->Configuration.DSConfig); */
+		/* tgt_network->network.configuration.DSConfig = (u32)rtw_ch2freq(pnetwork->configuration.DSConfig); */
 
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 0f0fcd9dc652..fb15c9531ba8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -253,25 +253,25 @@ int rtw_ies_remove_ie(u8 *ies, uint *ies_len, uint offset, u8 eid, u8 *oui, u8 o
 	return ret;
 }
 
-void rtw_set_supported_rate(u8 *SupportedRates, uint mode)
+void rtw_set_supported_rate(u8 *supported_rates, uint mode)
 {
-	memset(SupportedRates, 0, NDIS_802_11_LENGTH_RATES_EX);
+	memset(supported_rates, 0, NDIS_802_11_LENGTH_RATES_EX);
 
 	switch (mode) {
 	case WIRELESS_11B:
-		memcpy(SupportedRates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
+		memcpy(supported_rates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
 		break;
 
 	case WIRELESS_11G:
-		memcpy(SupportedRates, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
+		memcpy(supported_rates, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
 		break;
 
 	case WIRELESS_11BG:
 	case WIRELESS_11G_24N:
 	case WIRELESS_11_24N:
 	case WIRELESS_11BG_24N:
-		memcpy(SupportedRates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
-		memcpy(SupportedRates + IEEE80211_CCK_RATE_LEN, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
+		memcpy(supported_rates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
+		memcpy(supported_rates + IEEE80211_CCK_RATE_LEN, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
 		break;
 	}
 }
@@ -291,14 +291,14 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	u8 wireless_mode;
 	int	sz = 0, rateLen;
 	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
-	u8 *ie = pdev_network->IEs;
+	u8 *ie = pdev_network->ies;
 
 	/* timestamp will be inserted by hardware */
 	sz += 8;
 	ie += sz;
 
 	/* beacon interval : 2bytes */
-	*(__le16 *)ie = cpu_to_le16((u16)pdev_network->Configuration.BeaconPeriod);/* BCN_INTERVAL; */
+	*(__le16 *)ie = cpu_to_le16((u16)pdev_network->configuration.BeaconPeriod);/* BCN_INTERVAL; */
 	sz += 2;
 	ie += 2;
 
@@ -310,38 +310,38 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	if (pregistrypriv->preamble == PREAMBLE_SHORT)
 		*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE);
 
-	if (pdev_network->Privacy)
+	if (pdev_network->privacy)
 		*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 
 	sz += 2;
 	ie += 2;
 
 	/* SSID */
-	ie = rtw_set_ie(ie, WLAN_EID_SSID, pdev_network->Ssid.SsidLength, pdev_network->Ssid.Ssid, &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_SSID, pdev_network->ssid.SsidLength, pdev_network->ssid.Ssid, &sz);
 
 	/* supported rates */
 	wireless_mode = pregistrypriv->wireless_mode;
 
-	rtw_set_supported_rate(pdev_network->SupportedRates, wireless_mode);
+	rtw_set_supported_rate(pdev_network->supported_rates, wireless_mode);
 
-	rateLen = rtw_get_rateset_len(pdev_network->SupportedRates);
+	rateLen = rtw_get_rateset_len(pdev_network->supported_rates);
 
 	if (rateLen > 8) {
-		ie = rtw_set_ie(ie, WLAN_EID_SUPP_RATES, 8, pdev_network->SupportedRates, &sz);
-		/* ie = rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pdev_network->SupportedRates + 8), &sz); */
+		ie = rtw_set_ie(ie, WLAN_EID_SUPP_RATES, 8, pdev_network->supported_rates, &sz);
+		/* ie = rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pdev_network->supported_rates + 8), &sz); */
 	} else {
-		ie = rtw_set_ie(ie, WLAN_EID_SUPP_RATES, rateLen, pdev_network->SupportedRates, &sz);
+		ie = rtw_set_ie(ie, WLAN_EID_SUPP_RATES, rateLen, pdev_network->supported_rates, &sz);
 	}
 
 	/* DS parameter set */
-	ie = rtw_set_ie(ie, WLAN_EID_DS_PARAMS, 1, (u8 *)&(pdev_network->Configuration.DSConfig), &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_DS_PARAMS, 1, (u8 *)&(pdev_network->configuration.DSConfig), &sz);
 
 	/* IBSS Parameter Set */
 
-	ie = rtw_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2, (u8 *)&(pdev_network->Configuration.ATIMWindow), &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2, (u8 *)&(pdev_network->configuration.ATIMWindow), &sz);
 
 	if (rateLen > 8) {
-		ie = rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pdev_network->SupportedRates + 8), &sz);
+		ie = rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pdev_network->supported_rates + 8), &sz);
 	}
 
 	/* HT Cap. */
@@ -350,7 +350,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 		/* todo: */
 	}
 
-	/* pdev_network->IELength =  sz; update IELength */
+	/* pdev_network->ie_length =  sz; update ie_length */
 
 	/* return _SUCCESS; */
 
@@ -1030,7 +1030,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	int group_cipher = 0, pairwise_cipher = 0, is8021x = 0;
 	int ret = _FAIL;
 
-	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+	pbuf = rtw_get_wpa_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 
 	if (pbuf && (wpa_ielen > 0)) {
 		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
@@ -1040,7 +1040,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 			ret = _SUCCESS;
 		}
 	} else {
-		pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+		pbuf = rtw_get_wpa2_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 
 		if (pbuf && (wpa_ielen > 0)) {
 			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
@@ -1067,15 +1067,15 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	unsigned char 	*p;
 	__le16 le_cap;
 
-	memcpy((u8 *)&le_cap, rtw_get_capability_from_ie(pnetwork->network.IEs), 2);
+	memcpy((u8 *)&le_cap, rtw_get_capability_from_ie(pnetwork->network.ies), 2);
 	cap = le16_to_cpu(le_cap);
 	if (cap & WLAN_CAPABILITY_PRIVACY) {
 		bencrypt = 1;
-		pnetwork->network.Privacy = 1;
+		pnetwork->network.privacy = 1;
 	} else {
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
-	rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
+	rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, NULL, &rsn_len, NULL, &wpa_len);
 
 	if (rsn_len > 0) {
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
@@ -1089,7 +1089,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 
 	/* get bwmode and ch_offset */
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, pnetwork->network.IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 			pnetwork->BcnInfo.ht_cap_info = le16_to_cpu(pht_cap->cap_info);
@@ -1097,7 +1097,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 			pnetwork->BcnInfo.ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, pnetwork->network.IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_info = (struct HT_info_element *)(p + 2);
 			pnetwork->BcnInfo.ht_info_infos_0 = pht_info->infos[0];
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index fcbbdbe5448b..662e63f764cd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -93,9 +93,9 @@ u8 rtw_do_join(struct adapter *padapter)
 
 				pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
-				pibss = padapter->registrypriv.dev_network.MacAddress;
+				pibss = padapter->registrypriv.dev_network.mac_address;
 
-				memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+				memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 				rtw_update_registrypriv_dev_network(padapter);
 
@@ -158,7 +158,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 		goto release_mlme_lock;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
-		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
+		if (!memcmp(&pmlmepriv->cur_network.network.mac_address, bssid, ETH_ALEN)) {
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)
 				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
 		} else {
@@ -354,7 +354,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct	wlan_network	*cur_network = &pmlmepriv->cur_network;
-	enum ndis_802_11_network_infrastructure *pold_state = &(cur_network->network.InfrastructureMode);
+	enum ndis_802_11_network_infrastructure *pold_state = &(cur_network->network.infrastructure_mode);
 
 	if (*pold_state != networktype) {
 		if (*pold_state == Ndis802_11APMode) {
@@ -562,8 +562,8 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 					short_GI,
 					psta->htpriv.ht_cap.mcs.rx_mask);
 	} else {
-		while ((pcur_bss->SupportedRates[i] != 0) && (pcur_bss->SupportedRates[i] != 0xFF)) {
-			rate = pcur_bss->SupportedRates[i]&0x7F;
+		while ((pcur_bss->supported_rates[i] != 0) && (pcur_bss->supported_rates[i] != 0xFF)) {
+			rate = pcur_bss->supported_rates[i]&0x7F;
 			if (rate > max_rate)
 				max_rate = rate;
 			i++;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 2dd75e007239..c994f6335bdc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -23,7 +23,7 @@ int	rtw_init_mlme_priv(struct adapter *padapter)
 	pmlmepriv->pscanned = NULL;
 	pmlmepriv->fw_state = WIFI_STATION_STATE; /*  Must sync with rtw_wdev_alloc() */
 	/*  wdev->iftype = NL80211_IFTYPE_STATION */
-	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
+	pmlmepriv->cur_network.network.infrastructure_mode = Ndis802_11AutoUnknown;
 	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
 
 	spin_lock_init(&pmlmepriv->lock);
@@ -245,7 +245,7 @@ struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 	list_for_each(plist, phead) {
 		pnetwork = list_entry(plist, struct wlan_network, list);
 
-		if (!memcmp(addr, pnetwork->network.MacAddress, ETH_ALEN))
+		if (!memcmp(addr, pnetwork->network.mac_address, ETH_ALEN))
 			break;
 	}
 
@@ -313,7 +313,7 @@ u16 rtw_get_capability(struct wlan_bssid_ex *bss)
 {
 	__le16	val;
 
-	memcpy((u8 *)&val, rtw_get_capability_from_ie(bss->IEs), 2);
+	memcpy((u8 *)&val, rtw_get_capability_from_ie(bss->ies), 2);
 
 	return le16_to_cpu(val);
 }
@@ -363,10 +363,10 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	if ((psecuritypriv->dot11PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.Privacy == 0))
+		    (pnetwork->network.privacy == 0))
 		ret = false;
 	else if ((psecuritypriv->dot11PrivacyAlgrthm == _NO_PRIVACY_) &&
-		 (pnetwork->network.Privacy == 1))
+		 (pnetwork->network.privacy == 1))
 		ret = false;
 	else
 		ret = true;
@@ -377,8 +377,8 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 
 inline int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
 {
-	return (a->Ssid.SsidLength == b->Ssid.SsidLength)
-		&&  !memcmp(a->Ssid.Ssid, b->Ssid.Ssid, a->Ssid.SsidLength);
+	return (a->ssid.SsidLength == b->ssid.SsidLength)
+		&&  !memcmp(a->ssid.Ssid, b->ssid.Ssid, a->ssid.SsidLength);
 }
 
 int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 feature)
@@ -389,16 +389,16 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 	if (rtw_bug_check(dst, src, &s_cap, &d_cap) == false)
 			return false;
 
-	memcpy((u8 *)&tmps, rtw_get_capability_from_ie(src->IEs), 2);
-	memcpy((u8 *)&tmpd, rtw_get_capability_from_ie(dst->IEs), 2);
+	memcpy((u8 *)&tmps, rtw_get_capability_from_ie(src->ies), 2);
+	memcpy((u8 *)&tmpd, rtw_get_capability_from_ie(dst->ies), 2);
 
 	s_cap = le16_to_cpu(tmps);
 	d_cap = le16_to_cpu(tmpd);
 
-	return (src->Ssid.SsidLength == dst->Ssid.SsidLength) &&
-		/* 	(src->Configuration.DSConfig == dst->Configuration.DSConfig) && */
-			((!memcmp(src->MacAddress, dst->MacAddress, ETH_ALEN))) &&
-			((!memcmp(src->Ssid.Ssid, dst->Ssid.Ssid, src->Ssid.SsidLength))) &&
+	return (src->ssid.SsidLength == dst->ssid.SsidLength) &&
+		/* 	(src->configuration.DSConfig == dst->configuration.DSConfig) && */
+			((!memcmp(src->mac_address, dst->mac_address, ETH_ALEN))) &&
+			((!memcmp(src->ssid.Ssid, dst->ssid.Ssid, src->ssid.SsidLength))) &&
 			((s_cap & WLAN_CAPABILITY_IBSS) ==
 			(d_cap & WLAN_CAPABILITY_IBSS)) &&
 			((s_cap & WLAN_CAPABILITY_ESS) ==
@@ -450,9 +450,9 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	struct adapter *padapter, bool update_ie)
 {
-	long rssi_ori = dst->Rssi;
+	long rssi_ori = dst->rssi;
 
-	u8 sq_smp = src->PhyInfo.SignalQuality;
+	u8 sq_smp = src->phy_info.SignalQuality;
 
 	u8 ss_final;
 	u8 sq_final;
@@ -465,19 +465,19 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 		sq_final = padapter->recvpriv.signal_qual;
 		/* the rssi value here is undecorated, and will be used for antenna diversity */
 		if (sq_smp != 101) /* from the right channel */
-			rssi_final = (src->Rssi+dst->Rssi*4)/5;
+			rssi_final = (src->rssi+dst->rssi*4)/5;
 		else
 			rssi_final = rssi_ori;
 	} else {
 		if (sq_smp != 101) { /* from the right channel */
-			ss_final = ((u32)(src->PhyInfo.SignalStrength)+(u32)(dst->PhyInfo.SignalStrength)*4)/5;
-			sq_final = ((u32)(src->PhyInfo.SignalQuality)+(u32)(dst->PhyInfo.SignalQuality)*4)/5;
-			rssi_final = (src->Rssi+dst->Rssi*4)/5;
+			ss_final = ((u32)(src->phy_info.SignalStrength)+(u32)(dst->phy_info.SignalStrength)*4)/5;
+			sq_final = ((u32)(src->phy_info.SignalQuality)+(u32)(dst->phy_info.SignalQuality)*4)/5;
+			rssi_final = (src->rssi+dst->rssi*4)/5;
 		} else {
 			/* bss info not receiving from the right channel, use the original RX signal infos */
-			ss_final = dst->PhyInfo.SignalStrength;
-			sq_final = dst->PhyInfo.SignalQuality;
-			rssi_final = dst->Rssi;
+			ss_final = dst->phy_info.SignalStrength;
+			sq_final = dst->phy_info.SignalQuality;
+			rssi_final = dst->rssi;
 		}
 
 	}
@@ -488,9 +488,9 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 		memcpy((u8 *)dst, (u8 *)src, get_wlan_bssid_ex_sz(src));
 	}
 
-	dst->PhyInfo.SignalStrength = ss_final;
-	dst->PhyInfo.SignalQuality = sq_final;
-	dst->Rssi = rssi_final;
+	dst->phy_info.SignalStrength = ss_final;
+	dst->phy_info.SignalQuality = sq_final;
+	dst->rssi = rssi_final;
 }
 
 static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
@@ -503,11 +503,11 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 		&(pmlmepriv->cur_network.network));
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&(pmlmepriv->cur_network.network), pnetwork, 0))) {
-		/* if (pmlmepriv->cur_network.network.IELength<= pnetwork->IELength) */
+		/* if (pmlmepriv->cur_network.network.ie_length<= pnetwork->ie_length) */
 		{
 			update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
-			rtw_update_protection(adapter, (pmlmepriv->cur_network.network.IEs) + sizeof(struct ndis_802_11_fix_ie),
-									pmlmepriv->cur_network.network.IELength);
+			rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
+									pmlmepriv->cur_network.network.ie_length);
 		}
 	}
 }
@@ -568,8 +568,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			pnetwork->join_res = 0;
 
 			/* bss info not receiving from the right channel */
-			if (pnetwork->network.PhyInfo.SignalQuality == 101)
-				pnetwork->network.PhyInfo.SignalQuality = 0;
+			if (pnetwork->network.phy_info.SignalQuality == 101)
+				pnetwork->network.phy_info.SignalQuality = 0;
 		} else {
 			/* Otherwise just pull from the free list */
 
@@ -579,14 +579,14 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 				goto exit;
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
-			target->Length = bssid_ex_sz;
+			target->length = bssid_ex_sz;
 			memcpy(&(pnetwork->network), target, bssid_ex_sz);
 
 			pnetwork->last_scanned = jiffies;
 
 			/* bss info not receiving from the right channel */
-			if (pnetwork->network.PhyInfo.SignalQuality == 101)
-				pnetwork->network.PhyInfo.SignalQuality = 0;
+			if (pnetwork->network.phy_info.SignalQuality == 101)
+				pnetwork->network.phy_info.SignalQuality = 0;
 
 			list_add_tail(&(pnetwork->list), &(queue->queue));
 
@@ -601,7 +601,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 		pnetwork->last_scanned = jiffies;
 
 		/* target.Reserved[0]== 1, means that scanned network is a bcn frame. */
-		if ((pnetwork->network.IELength > target->IELength) && (target->Reserved[0] == 1))
+		if ((pnetwork->network.ie_length > target->ie_length) && (target->Reserved[0] == 1))
 			update_ie = false;
 
 		/*  probe resp(3) > beacon(1) > probe req(2) */
@@ -654,10 +654,10 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	int bselected = true;
 
 	desired_encmode = psecuritypriv->ndisencryptstatus;
-	privacy = pnetwork->network.Privacy;
+	privacy = pnetwork->network.privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
+		if (rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
 			return false;
@@ -671,7 +671,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	    bselected = false;
 
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
-			p = rtw_get_ie(pnetwork->network.IEs + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.IELength - _BEACON_IE_OFFSET_));
+			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
 			if (p && ie_len > 0)
 				bselected = true;
 			else
@@ -683,7 +683,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 		bselected = false;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
-		if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
+		if (pnetwork->network.infrastructure_mode != pmlmepriv->cur_network.network.infrastructure_mode)
 			bselected = false;
 	}
 
@@ -711,14 +711,14 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  update IBSS_network 's timestamp */
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) {
-		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress), pnetwork->MacAddress, ETH_ALEN)) {
+		if (!memcmp(&(pmlmepriv->cur_network.network.mac_address), pnetwork->mac_address, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
-			memcpy(pmlmepriv->cur_network.network.IEs, pnetwork->IEs, 8);
+			memcpy(pmlmepriv->cur_network.network.ies, pnetwork->ies, 8);
 			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
-			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->MacAddress);
+			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->mac_address);
 			if (ibss_wlan) {
-				memcpy(ibss_wlan->network.IEs, pnetwork->IEs, 8);
+				memcpy(ibss_wlan->network.ies, pnetwork->ies, 8);
 				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 				goto exit;
 			}
@@ -728,8 +728,8 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  lock pmlmepriv->lock when you accessing network_q */
 	if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == false) {
-		if (pnetwork->Ssid.Ssid[0] == 0)
-			pnetwork->Ssid.SsidLength = 0;
+		if (pnetwork->ssid.Ssid[0] == 0)
+			pnetwork->ssid.SsidLength = 0;
 		rtw_add_network(adapter, pnetwork);
 	}
 
@@ -766,12 +766,12 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				} else {
 					u8 ret = _SUCCESS;
 					struct wlan_bssid_ex    *pdev_network = &(adapter->registrypriv.dev_network);
-					u8 *pibss = adapter->registrypriv.dev_network.MacAddress;
+					u8 *pibss = adapter->registrypriv.dev_network.mac_address;
 
 					/* pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;because don't set assoc_timer */
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-					memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+					memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 					rtw_update_registrypriv_dev_network(adapter);
 					rtw_generate_random_ibss(pibss);
@@ -818,7 +818,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
 				&& check_fwstate(pmlmepriv, _FW_LINKED)) {
 				if (rtw_select_roaming_candidate(pmlmepriv) == _SUCCESS) {
-					receive_disconnect(adapter, pmlmepriv->cur_network.network.MacAddress
+					receive_disconnect(adapter, pmlmepriv->cur_network.network.mac_address
 						, WLAN_REASON_ACTIVE_ROAM);
 				}
 			}
@@ -882,7 +882,7 @@ static void find_network(struct adapter *adapter)
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
-	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
+	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
 	if (pwlan)
 		pwlan->fixed = false;
 
@@ -905,7 +905,7 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
-		psta = rtw_get_stainfo(&adapter->stapriv, tgt_network->network.MacAddress);
+		psta = rtw_get_stainfo(&adapter->stapriv, tgt_network->network.mac_address);
 		spin_lock_bh(&(pstapriv->sta_hash_lock));
 		rtw_free_stainfo(adapter,  psta);
 
@@ -1025,9 +1025,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
-	psta = rtw_get_stainfo(pstapriv, pnetwork->network.MacAddress);
+	psta = rtw_get_stainfo(pstapriv, pnetwork->network.mac_address);
 	if (!psta)
-		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.MacAddress);
+		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.mac_address);
 
 	if (psta) { /* update ptarget_sta */
 
@@ -1036,8 +1036,8 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		update_sta_info(padapter, psta);
 
 		/* update station supportRate */
-		psta->bssratelen = rtw_get_rateset_len(pnetwork->network.SupportedRates);
-		memcpy(psta->bssrateset, pnetwork->network.SupportedRates, psta->bssratelen);
+		psta->bssratelen = rtw_get_rateset_len(pnetwork->network.supported_rates);
+		memcpy(psta->bssrateset, pnetwork->network.supported_rates, psta->bssratelen);
 		rtw_hal_update_sta_rate_mask(padapter, psta);
 
 		psta->wireless_mode = pmlmeext->cur_wireless_mode;
@@ -1111,24 +1111,24 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 
 	/*  why not use ptarget_wlan?? */
-	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
-	/*  some IEs in pnetwork is wrong, so we should use ptarget_wlan IEs */
-	cur_network->network.IELength = ptarget_wlan->network.IELength;
-	memcpy(&cur_network->network.IEs[0], &ptarget_wlan->network.IEs[0], MAX_IE_SZ);
+	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.length);
+	/*  some ies in pnetwork is wrong, so we should use ptarget_wlan ies */
+	cur_network->network.ie_length = ptarget_wlan->network.ie_length;
+	memcpy(&cur_network->network.ies[0], &ptarget_wlan->network.ies[0], MAX_IE_SZ);
 
 	cur_network->aid = pnetwork->join_res;
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
-	padapter->recvpriv.signal_strength = ptarget_wlan->network.PhyInfo.SignalStrength;
-	padapter->recvpriv.signal_qual = ptarget_wlan->network.PhyInfo.SignalQuality;
-	/* the ptarget_wlan->network.Rssi is raw data, we use ptarget_wlan->network.PhyInfo.SignalStrength instead (has scaled) */
-	padapter->recvpriv.rssi = translate_percentage_to_dbm(ptarget_wlan->network.PhyInfo.SignalStrength);
+	padapter->recvpriv.signal_strength = ptarget_wlan->network.phy_info.SignalStrength;
+	padapter->recvpriv.signal_qual = ptarget_wlan->network.phy_info.SignalQuality;
+	/* the ptarget_wlan->network.rssi is raw data, we use ptarget_wlan->network.phy_info.SignalStrength instead (has scaled) */
+	padapter->recvpriv.rssi = translate_percentage_to_dbm(ptarget_wlan->network.phy_info.SignalStrength);
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
 	/* update fw_state will clr _FW_UNDER_LINKING here indirectly */
-	switch (pnetwork->network.InfrastructureMode) {
+	switch (pnetwork->network.infrastructure_mode) {
 	case Ndis802_11Infrastructure:
 
 			if (pmlmepriv->fw_state&WIFI_UNDER_WPS)
@@ -1145,10 +1145,10 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 			break;
 	}
 
-	rtw_update_protection(padapter, (cur_network->network.IEs) + sizeof(struct ndis_802_11_fix_ie),
-									(cur_network->network.IELength));
+	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
+									(cur_network->network.ie_length));
 
-	rtw_update_ht_cap(padapter, cur_network->network.IEs, cur_network->network.IELength, (u8) cur_network->network.Configuration.DSConfig);
+	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.DSConfig);
 }
 
 /* Notes: the function could be > passive_level (the same context as Rx tasklet) */
@@ -1172,10 +1172,10 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 
 	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
 
-	the_same_macaddr = !memcmp(pnetwork->network.MacAddress, cur_network->network.MacAddress, ETH_ALEN);
+	the_same_macaddr = !memcmp(pnetwork->network.mac_address, cur_network->network.mac_address, ETH_ALEN);
 
-	pnetwork->network.Length = get_wlan_bssid_ex_sz(&pnetwork->network);
-	if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex))
+	pnetwork->network.length = get_wlan_bssid_ex_sz(&pnetwork->network);
+	if (pnetwork->network.length > sizeof(struct wlan_bssid_ex))
 		return;
 
 	spin_lock_bh(&pmlmepriv->lock);
@@ -1190,17 +1190,17 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			/* s1. find ptarget_wlan */
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				if (the_same_macaddr) {
-					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.MacAddress);
+					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.mac_address);
 				} else {
-					pcur_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.MacAddress);
+					pcur_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.mac_address);
 					if (pcur_wlan)
 						pcur_wlan->fixed = false;
 
-					pcur_sta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
+					pcur_sta = rtw_get_stainfo(pstapriv, cur_network->network.mac_address);
 					if (pcur_sta)
 						rtw_free_stainfo(adapter,  pcur_sta);
 
-					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.MacAddress);
+					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.mac_address);
 					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 						if (ptarget_wlan)
 							ptarget_wlan->fixed = true;
@@ -1390,7 +1390,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 		if (adapter->stapriv.asoc_sta_count == 2) {
 			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
-			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.MacAddress);
+			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.mac_address);
 			pmlmepriv->cur_network_scanned = ptarget_wlan;
 			if (ptarget_wlan)
 				ptarget_wlan->fixed = true;
@@ -1470,7 +1470,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 		/*  remove the network entry in scanned_queue */
-		pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
+		pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
 		if (pwlan) {
 			pwlan->fixed = false;
 			rtw_free_network_nolock(adapter, pwlan);
@@ -1491,7 +1491,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 			/* free old ibss network */
 			/* pwlan = rtw_find_network(&pmlmepriv->scanned_queue, pstadel->macaddr); */
-			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
+			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
 			if (pwlan) {
 				pwlan->fixed = false;
 				rtw_free_network_nolock(adapter, pwlan);
@@ -1499,11 +1499,11 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 			/* re-create ibss */
 			pdev_network = &(adapter->registrypriv.dev_network);
-			pibss = adapter->registrypriv.dev_network.MacAddress;
+			pibss = adapter->registrypriv.dev_network.mac_address;
 
 			memcpy(pdev_network, &tgt_network->network, get_wlan_bssid_ex_sz(&tgt_network->network));
 
-			memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+			memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 			rtw_update_registrypriv_dev_network(adapter);
 
@@ -1722,7 +1722,7 @@ static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 
 	/* got specific addr to roam */
 	if (!is_zero_mac_addr(mlme->roam_tgt_addr)) {
-		if (!memcmp(mlme->roam_tgt_addr, competitor->network.MacAddress, ETH_ALEN))
+		if (!memcmp(mlme->roam_tgt_addr, competitor->network.mac_address, ETH_ALEN))
 			goto update;
 		else
 			goto exit;
@@ -1730,10 +1730,10 @@ static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 	if (jiffies_to_msecs(jiffies - competitor->last_scanned) >= mlme->roam_scanr_exp_ms)
 		goto exit;
 
-	if (competitor->network.Rssi - mlme->cur_network_scanned->network.Rssi < mlme->roam_rssi_diff_th)
+	if (competitor->network.rssi - mlme->cur_network_scanned->network.rssi < mlme->roam_rssi_diff_th)
 		goto exit;
 
-	if (*candidate && (*candidate)->network.Rssi >= competitor->network.Rssi)
+	if (*candidate && (*candidate)->network.rssi >= competitor->network.rssi)
 		goto exit;
 
 update:
@@ -1775,7 +1775,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 	} else {
 		mlme->roam_network = candidate;
 
-		if (!memcmp(candidate->network.MacAddress, mlme->roam_tgt_addr, ETH_ALEN))
+		if (!memcmp(candidate->network.mac_address, mlme->roam_tgt_addr, ETH_ALEN))
 			eth_zero_addr(mlme->roam_tgt_addr);
 	}
 
@@ -1799,14 +1799,14 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 
 	/* check bssid, if needed */
 	if (mlme->assoc_by_bssid) {
-		if (memcmp(competitor->network.MacAddress, mlme->assoc_bssid, ETH_ALEN))
+		if (memcmp(competitor->network.mac_address, mlme->assoc_bssid, ETH_ALEN))
 			goto exit;
 	}
 
 	/* check ssid, if needed */
 	if (mlme->assoc_ssid.Ssid[0] && mlme->assoc_ssid.SsidLength) {
-		if (competitor->network.Ssid.SsidLength != mlme->assoc_ssid.SsidLength
-			|| memcmp(competitor->network.Ssid.Ssid, mlme->assoc_ssid.Ssid, mlme->assoc_ssid.SsidLength)
+		if (competitor->network.ssid.SsidLength != mlme->assoc_ssid.SsidLength
+			|| memcmp(competitor->network.ssid.Ssid, mlme->assoc_ssid.Ssid, mlme->assoc_ssid.SsidLength)
 		)
 			goto exit;
 	}
@@ -1821,7 +1821,7 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 			goto exit;
 	}
 
-	if (*candidate == NULL || (*candidate)->network.Rssi < competitor->network.Rssi) {
+	if (*candidate == NULL || (*candidate)->network.rssi < competitor->network.rssi) {
 		*candidate = competitor;
 		updated = true;
 	}
@@ -2001,7 +2001,7 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 	return res;
 }
 
-/* adjust IEs for rtw_joinbss_cmd in WMM */
+/* adjust ies for rtw_joinbss_cmd in WMM */
 int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_len, uint initial_out_len)
 {
 	unsigned	int ielength = 0;
@@ -2148,16 +2148,16 @@ void rtw_init_registrypriv_dev_network(struct adapter *adapter)
 	struct wlan_bssid_ex    *pdev_network = &pregistrypriv->dev_network;
 	u8 *myhwaddr = myid(peepriv);
 
-	memcpy(pdev_network->MacAddress, myhwaddr, ETH_ALEN);
+	memcpy(pdev_network->mac_address, myhwaddr, ETH_ALEN);
 
-	memcpy(&pdev_network->Ssid, &pregistrypriv->ssid, sizeof(struct ndis_802_11_ssid));
+	memcpy(&pdev_network->ssid, &pregistrypriv->ssid, sizeof(struct ndis_802_11_ssid));
 
-	pdev_network->Configuration.Length = sizeof(struct ndis_802_11_conf);
-	pdev_network->Configuration.BeaconPeriod = 100;
-	pdev_network->Configuration.FHConfig.Length = 0;
-	pdev_network->Configuration.FHConfig.HopPattern = 0;
-	pdev_network->Configuration.FHConfig.HopSet = 0;
-	pdev_network->Configuration.FHConfig.DwellTime = 0;
+	pdev_network->configuration.Length = sizeof(struct ndis_802_11_conf);
+	pdev_network->configuration.BeaconPeriod = 100;
+	pdev_network->configuration.FHConfig.Length = 0;
+	pdev_network->configuration.FHConfig.HopPattern = 0;
+	pdev_network->configuration.FHConfig.HopSet = 0;
+	pdev_network->configuration.FHConfig.DwellTime = 0;
 }
 
 void rtw_update_registrypriv_dev_network(struct adapter *adapter)
@@ -2169,45 +2169,45 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
 	/* struct	xmit_priv *pxmitpriv = &adapter->xmitpriv; */
 
-	pdev_network->Privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ; /*  adhoc no 802.1x */
+	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ; /*  adhoc no 802.1x */
 
-	pdev_network->Rssi = 0;
+	pdev_network->rssi = 0;
 
 	switch (pregistrypriv->wireless_mode) {
 	case WIRELESS_11B:
-		pdev_network->NetworkTypeInUse = (Ndis802_11DS);
+		pdev_network->network_type_in_use = (Ndis802_11DS);
 		break;
 	case WIRELESS_11G:
 	case WIRELESS_11BG:
 	case WIRELESS_11_24N:
 	case WIRELESS_11G_24N:
 	case WIRELESS_11BG_24N:
-		pdev_network->NetworkTypeInUse = (Ndis802_11OFDM24);
+		pdev_network->network_type_in_use = (Ndis802_11OFDM24);
 		break;
 	default:
 		/*  TODO */
 		break;
 	}
 
-	pdev_network->Configuration.DSConfig = (pregistrypriv->channel);
+	pdev_network->configuration.DSConfig = (pregistrypriv->channel);
 
-	if (cur_network->network.InfrastructureMode == Ndis802_11IBSS)
-		pdev_network->Configuration.ATIMWindow = (0);
+	if (cur_network->network.infrastructure_mode == Ndis802_11IBSS)
+		pdev_network->configuration.ATIMWindow = (0);
 
-	pdev_network->InfrastructureMode = (cur_network->network.InfrastructureMode);
+	pdev_network->infrastructure_mode = (cur_network->network.infrastructure_mode);
 
 	/*  1. Supported rates */
 	/*  2. IE */
 
-	/* rtw_set_supported_rate(pdev_network->SupportedRates, pregistrypriv->wireless_mode) ;  will be called in rtw_generate_ie */
+	/* rtw_set_supported_rate(pdev_network->supported_rates, pregistrypriv->wireless_mode) ;  will be called in rtw_generate_ie */
 	sz = rtw_generate_ie(pregistrypriv);
 
-	pdev_network->IELength = sz;
+	pdev_network->ie_length = sz;
 
-	pdev_network->Length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pdev_network);
+	pdev_network->length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pdev_network);
 
-	/* notes: translate IELength & Length after assign the Length to cmdsz in createbss_cmd(); */
-	/* pdev_network->IELength = cpu_to_le32(sz); */
+	/* notes: translate ie_length & length after assign the length to cmdsz in createbss_cmd(); */
+	/* pdev_network->ie_length = cpu_to_le32(sz); */
 }
 
 void rtw_get_encrypt_decrypt_from_registrypriv(struct adapter *adapter)
@@ -2648,7 +2648,7 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	int do_join_r;
 
 	if (0 < rtw_to_roam(padapter)) {
-		memcpy(&pmlmepriv->assoc_ssid, &cur_network->network.Ssid, sizeof(struct ndis_802_11_ssid));
+		memcpy(&pmlmepriv->assoc_ssid, &cur_network->network.ssid, sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 2df8ed649519..e22301c01f40 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -538,7 +538,7 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 		if (is_valid_p2p_probereq)
 			goto _issue_probersp;
 
-		if ((ielen != 0 && false == !memcmp((void *)(p+2), (void *)cur->Ssid.Ssid, cur->Ssid.SsidLength))
+		if ((ielen != 0 && false == !memcmp((void *)(p+2), (void *)cur->ssid.Ssid, cur->ssid.SsidLength))
 			|| (ielen == 0 && pmlmeinfo->hidden_ssid_mode)
 		)
 			return _SUCCESS;
@@ -634,7 +634,7 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 					netdev_dbg(padapter->pnetdev,
 						   "ap has changed, disconnect now\n ");
 					receive_disconnect(padapter,
-							   pmlmeinfo->network.MacAddress, 0);
+							   pmlmeinfo->network.mac_address, 0);
 					return _SUCCESS;
 				}
 				/* update WMM, ERP in the beacon */
@@ -1022,10 +1022,10 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		goto OnAssocReqFail;
 	} else {
 		/*  check if ssid match */
-		if (memcmp((void *)(p+2), cur->Ssid.Ssid, cur->Ssid.SsidLength))
+		if (memcmp((void *)(p+2), cur->ssid.Ssid, cur->ssid.SsidLength))
 			status = WLAN_STATUS_CHALLENGE_FAIL;
 
-		if (ie_len != cur->Ssid.SsidLength)
+		if (ie_len != cur->ssid.SsidLength)
 			status = WLAN_STATUS_CHALLENGE_FAIL;
 	}
 
@@ -1457,7 +1457,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	pmlmeinfo->state |= WIFI_FW_ASSOC_SUCCESS;
 
 	/* Update Basic Rate Table for spec, 2010-12-28 , by thomas */
-	UpdateBrateTbl(padapter, pmlmeinfo->network.SupportedRates);
+	UpdateBrateTbl(padapter, pmlmeinfo->network.supported_rates);
 
 report_assoc_result:
 	if (res > 0) {
@@ -2181,12 +2181,12 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 		{
 			int len_diff;
 
-			memcpy(pframe, cur_network->IEs, cur_network->IELength);
+			memcpy(pframe, cur_network->ies, cur_network->ie_length);
 			len_diff = update_hidden_ssid(pframe+_BEACON_IE_OFFSET_,
-						      cur_network->IELength-_BEACON_IE_OFFSET_,
+						      cur_network->ie_length-_BEACON_IE_OFFSET_,
 						      pmlmeinfo->hidden_ssid_mode);
-			pframe += (cur_network->IELength+len_diff);
-			pattrib->pktlen += (cur_network->IELength+len_diff);
+			pframe += (cur_network->ie_length+len_diff);
+			pattrib->pktlen += (cur_network->ie_length+len_diff);
 		}
 
 		{
@@ -2217,34 +2217,34 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	/*  beacon interval: 2 bytes */
 
-	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pattrib->pktlen += 2;
 
 	/*  capability info: 2 bytes */
 
-	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pattrib->pktlen += 2;
 
 	/*  SSID */
-	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->ssid.SsidLength, cur_network->ssid.Ssid, &pattrib->pktlen);
 
 	/*  supported rates... */
-	rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
-	pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pattrib->pktlen);
+	rate_len = rtw_get_rateset_len(cur_network->supported_rates);
+	pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->supported_rates, &pattrib->pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->configuration.DSConfig), &pattrib->pktlen);
 
 	/* if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) */
 	{
 		u8 erpinfo = 0;
 		u32 ATIMWindow;
 		/*  IBSS Parameter Set... */
-		/* ATIMWindow = cur->Configuration.ATIMWindow; */
+		/* ATIMWindow = cur->configuration.ATIMWindow; */
 		ATIMWindow = 0;
 		pframe = rtw_set_ie(pframe, WLAN_EID_IBSS_PARAMS, 2, (unsigned char *)(&ATIMWindow), &pattrib->pktlen);
 
@@ -2255,7 +2255,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	/*  EXTERNDED SUPPORTED RATE */
 	if (rate_len > 8) {
-		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->SupportedRates + 8), &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->supported_rates + 8), &pattrib->pktlen);
 	}
 
 
@@ -2314,7 +2314,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	mac = myid(&(padapter->eeprompriv));
-	bssid = cur_network->MacAddress;
+	bssid = cur_network->mac_address;
 
 	fctrl = &(pwlanhdr->frame_control);
 	*(fctrl) = 0;
@@ -2331,24 +2331,24 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	pframe += pattrib->hdrlen;
 
 
-	if (cur_network->IELength > MAX_IE_SZ)
+	if (cur_network->ie_length > MAX_IE_SZ)
 		return;
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
-		pwps_ie = rtw_get_wps_ie(cur_network->IEs+_FIXED_IE_LENGTH_, cur_network->IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
+		pwps_ie = rtw_get_wps_ie(cur_network->ies+_FIXED_IE_LENGTH_, cur_network->ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 		/* inerset & update wps_probe_resp_ie */
 		if (pmlmepriv->wps_probe_resp_ie && pwps_ie && wps_ielen > 0) {
 			uint wps_offset, remainder_ielen;
 			u8 *premainder_ie;
 
-			wps_offset = (uint)(pwps_ie - cur_network->IEs);
+			wps_offset = (uint)(pwps_ie - cur_network->ies);
 
 			premainder_ie = pwps_ie + wps_ielen;
 
-			remainder_ielen = cur_network->IELength - wps_offset - wps_ielen;
+			remainder_ielen = cur_network->ie_length - wps_offset - wps_ielen;
 
-			memcpy(pframe, cur_network->IEs, wps_offset);
+			memcpy(pframe, cur_network->ies, wps_offset);
 			pframe += wps_offset;
 			pattrib->pktlen += wps_offset;
 
@@ -2365,12 +2365,12 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 				pattrib->pktlen += remainder_ielen;
 			}
 		} else {
-			memcpy(pframe, cur_network->IEs, cur_network->IELength);
-			pframe += cur_network->IELength;
-			pattrib->pktlen += cur_network->IELength;
+			memcpy(pframe, cur_network->ies, cur_network->ie_length);
+			pframe += cur_network->ie_length;
+			pattrib->pktlen += cur_network->ie_length;
 		}
 
-		/* retrieve SSID IE from cur_network->Ssid */
+		/* retrieve SSID IE from cur_network->ssid */
 		{
 			u8 *ssid_ie;
 			signed int ssid_ielen;
@@ -2385,9 +2385,9 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 			ssid_ie = rtw_get_ie(ies+_FIXED_IE_LENGTH_, WLAN_EID_SSID, &ssid_ielen,
 				(pframe-ies)-_FIXED_IE_LENGTH_);
 
-			ssid_ielen_diff = cur_network->Ssid.SsidLength - ssid_ielen;
+			ssid_ielen_diff = cur_network->ssid.SsidLength - ssid_ielen;
 
-			if (ssid_ie &&  cur_network->Ssid.SsidLength) {
+			if (ssid_ie &&  cur_network->ssid.SsidLength) {
 				uint remainder_ielen;
 				u8 *remainder_ie;
 
@@ -2403,8 +2403,8 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 				memcpy(buf, remainder_ie, remainder_ielen);
 				memcpy(remainder_ie+ssid_ielen_diff, buf, remainder_ielen);
-				*(ssid_ie+1) = cur_network->Ssid.SsidLength;
-				memcpy(ssid_ie+2, cur_network->Ssid.Ssid, cur_network->Ssid.SsidLength);
+				*(ssid_ie+1) = cur_network->ssid.SsidLength;
+				memcpy(ssid_ie+2, cur_network->ssid.Ssid, cur_network->ssid.SsidLength);
 
 				pframe += ssid_ielen_diff;
 				pattrib->pktlen += ssid_ielen_diff;
@@ -2418,14 +2418,14 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 		/*  beacon interval: 2 bytes */
 
-		memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->IEs)), 2);
+		memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->ies)), 2);
 
 		pframe += 2;
 		pattrib->pktlen += 2;
 
 		/*  capability info: 2 bytes */
 
-		memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->IEs)), 2);
+		memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->ies)), 2);
 
 		pframe += 2;
 		pattrib->pktlen += 2;
@@ -2433,20 +2433,20 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		/* below for ad-hoc mode */
 
 		/*  SSID */
-		pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->ssid.SsidLength, cur_network->ssid.Ssid, &pattrib->pktlen);
 
 		/*  supported rates... */
-		rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
-		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pattrib->pktlen);
+		rate_len = rtw_get_rateset_len(cur_network->supported_rates);
+		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->supported_rates, &pattrib->pktlen);
 
 		/*  DS parameter set */
-		pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->configuration.DSConfig), &pattrib->pktlen);
 
 		if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 			u8 erpinfo = 0;
 			u32 ATIMWindow;
 			/*  IBSS Parameter Set... */
-			/* ATIMWindow = cur->Configuration.ATIMWindow; */
+			/* ATIMWindow = cur->configuration.ATIMWindow; */
 			ATIMWindow = 0;
 			pframe = rtw_set_ie(pframe, WLAN_EID_IBSS_PARAMS, 2, (unsigned char *)(&ATIMWindow), &pattrib->pktlen);
 
@@ -2457,7 +2457,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 		/*  EXTERNDED SUPPORTED RATE */
 		if (rate_len > 8) {
-			pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->SupportedRates + 8), &pattrib->pktlen);
+			pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->supported_rates + 8), &pattrib->pktlen);
 		}
 
 
@@ -2748,7 +2748,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
-	u8 *ie = pnetwork->IEs;
+	u8 *ie = pnetwork->ies;
 	__le16 lestatus, le_tmp;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -2807,7 +2807,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 
 		/* FILL HT CAP INFO IE */
 		/* p = hostapd_eid_ht_capabilities_info(hapd, p); */
-		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, WLAN_EID_HT_CAPABILITY, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_));
+		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, WLAN_EID_HT_CAPABILITY, &ie_len, (pnetwork->ie_length - _BEACON_IE_OFFSET_));
 		if (pbuf && ie_len > 0) {
 			memcpy(pframe, pbuf, ie_len+2);
 			pframe += (ie_len+2);
@@ -2816,7 +2816,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 
 		/* FILL HT ADD INFO IE */
 		/* p = hostapd_eid_ht_operation(hapd, p); */
-		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, WLAN_EID_HT_OPERATION, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_));
+		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, WLAN_EID_HT_OPERATION, &ie_len, (pnetwork->ie_length - _BEACON_IE_OFFSET_));
 		if (pbuf && ie_len > 0) {
 			memcpy(pframe, pbuf, ie_len+2);
 			pframe += (ie_len+2);
@@ -2831,7 +2831,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 		unsigned char WMM_PARA_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 
 		for (pbuf = ie + _BEACON_IE_OFFSET_; ; pbuf += (ie_len + 2)) {
-			pbuf = rtw_get_ie(pbuf, WLAN_EID_VENDOR_SPECIFIC, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2)));
+			pbuf = rtw_get_ie(pbuf, WLAN_EID_VENDOR_SPECIFIC, &ie_len, (pnetwork->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2)));
 			if (pbuf && !memcmp(pbuf+2, WMM_PARA_IE, 6)) {
 				memcpy(pframe, pbuf, ie_len+2);
 				pframe += (ie_len+2);
@@ -2910,7 +2910,7 @@ void issue_assocreq(struct adapter *padapter)
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	/* caps */
-	memcpy(pframe, rtw_get_capability_from_ie(pmlmeinfo->network.IEs), 2);
+	memcpy(pframe, rtw_get_capability_from_ie(pmlmeinfo->network.ies), 2);
 
 	pframe += 2;
 	pattrib->pktlen += 2;
@@ -2923,7 +2923,7 @@ void issue_assocreq(struct adapter *padapter)
 	pattrib->pktlen += 2;
 
 	/* SSID */
-	pframe = rtw_set_ie(pframe, WLAN_EID_SSID,  pmlmeinfo->network.Ssid.SsidLength, pmlmeinfo->network.Ssid.Ssid, &(pattrib->pktlen));
+	pframe = rtw_set_ie(pframe, WLAN_EID_SSID,  pmlmeinfo->network.ssid.SsidLength, pmlmeinfo->network.ssid.Ssid, &(pattrib->pktlen));
 
 	/* supported rate & extended supported rate */
 
@@ -2938,27 +2938,27 @@ void issue_assocreq(struct adapter *padapter)
 	/*  */
 
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
-		if (pmlmeinfo->network.SupportedRates[i] == 0)
+		if (pmlmeinfo->network.supported_rates[i] == 0)
 			break;
 	}
 
 
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
-		if (pmlmeinfo->network.SupportedRates[i] == 0)
+		if (pmlmeinfo->network.supported_rates[i] == 0)
 			break;
 
 
 		/*  Check if the AP's supported rates are also supported by STA. */
 		for (j = 0; j < sta_bssrate_len; j++) {
 			 /*  Avoid the proprietary data rate (22Mbps) of Handlink WSG-4000 AP */
-			if ((pmlmeinfo->network.SupportedRates[i] | IEEE80211_BASIC_RATE_MASK)
+			if ((pmlmeinfo->network.supported_rates[i] | IEEE80211_BASIC_RATE_MASK)
 					== (sta_bssrate[j] | IEEE80211_BASIC_RATE_MASK))
 				break;
 		}
 
 		if (j != sta_bssrate_len)
 			/*  the rate is supported by STA */
-			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
+			bssrate[index++] = pmlmeinfo->network.supported_rates[i];
 	}
 
 	bssrate_len = index;
@@ -2977,8 +2977,8 @@ void issue_assocreq(struct adapter *padapter)
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, bssrate_len, bssrate, &(pattrib->pktlen));
 
 	/* vendor specific IE, such as WPA, WMM, WPS */
-	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.IELength;) {
-		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.IEs + i);
+	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
 
 		switch (pIE->ElementID) {
 		case WLAN_EID_VENDOR_SPECIFIC:
@@ -3540,7 +3540,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			le_tmp = cpu_to_le16(BA_timeout_value);
 			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&(le_tmp)), &(pattrib->pktlen));
 
-			/* if ((psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.MacAddress)) != NULL) */
+			/* if ((psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.mac_address)) != NULL) */
 			psta = rtw_get_stainfo(pstapriv, raddr);
 			if (psta) {
 				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07]&0xfff) + 1;
@@ -3705,13 +3705,13 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 
 			pbss_network = (struct wlan_bssid_ex *)&pnetwork->network;
 
-			p = rtw_get_ie(pbss_network->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, pbss_network->IELength - _FIXED_IE_LENGTH_);
+			p = rtw_get_ie(pbss_network->ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, pbss_network->ie_length - _FIXED_IE_LENGTH_);
 			if ((p == NULL) || (len == 0)) {/* non-HT */
 
-				if (pbss_network->Configuration.DSConfig <= 0)
+				if (pbss_network->configuration.DSConfig <= 0)
 					continue;
 
-				ICS[0][pbss_network->Configuration.DSConfig] = 1;
+				ICS[0][pbss_network->configuration.DSConfig] = 1;
 
 				if (ICS[0][0] == 0)
 					ICS[0][0] = 1;
@@ -3987,19 +3987,19 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 		}
 	}
 
-	bssid->Length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
+	bssid->length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
 
 	/* below is to copy the information element */
-	bssid->IELength = len;
-	memcpy(bssid->IEs, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->IELength);
+	bssid->ie_length = len;
+	memcpy(bssid->ies, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->ie_length);
 
 	/* get the signal strength */
-	bssid->Rssi = precv_frame->u.hdr.attrib.phy_info.RecvSignalPower; /*  in dBM.raw data */
-	bssid->PhyInfo.SignalQuality = precv_frame->u.hdr.attrib.phy_info.SignalQuality;/* in percentage */
-	bssid->PhyInfo.SignalStrength = precv_frame->u.hdr.attrib.phy_info.SignalStrength;/* in percentage */
+	bssid->rssi = precv_frame->u.hdr.attrib.phy_info.RecvSignalPower; /*  in dBM.raw data */
+	bssid->phy_info.SignalQuality = precv_frame->u.hdr.attrib.phy_info.SignalQuality;/* in percentage */
+	bssid->phy_info.SignalStrength = precv_frame->u.hdr.attrib.phy_info.SignalStrength;/* in percentage */
 
 	/*  checking SSID */
-	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_SSID, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_SSID, &len, bssid->ie_length - ie_offset);
 	if (!p)
 		return _FAIL;
 
@@ -4007,83 +4007,83 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 		if (len > NDIS_802_11_LENGTH_SSID)
 			return _FAIL;
 
-		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
-		bssid->Ssid.SsidLength = *(p + 1);
+		memcpy(bssid->ssid.Ssid, (p + 2), *(p + 1));
+		bssid->ssid.SsidLength = *(p + 1);
 	} else
-		bssid->Ssid.SsidLength = 0;
+		bssid->ssid.SsidLength = 0;
 
-	memset(bssid->SupportedRates, 0, NDIS_802_11_LENGTH_RATES_EX);
+	memset(bssid->supported_rates, 0, NDIS_802_11_LENGTH_RATES_EX);
 
 	/* checking rate info... */
 	i = 0;
-	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_SUPP_RATES, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_SUPP_RATES, &len, bssid->ie_length - ie_offset);
 	if (p) {
 		if (len > NDIS_802_11_LENGTH_RATES_EX)
 			return _FAIL;
 
-		memcpy(bssid->SupportedRates, (p + 2), len);
+		memcpy(bssid->supported_rates, (p + 2), len);
 		i = len;
 	}
 
-	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_EXT_SUPP_RATES, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_EXT_SUPP_RATES, &len, bssid->ie_length - ie_offset);
 	if (p) {
 		if (len > (NDIS_802_11_LENGTH_RATES_EX-i))
 			return _FAIL;
 
-		memcpy(bssid->SupportedRates + i, (p + 2), len);
+		memcpy(bssid->supported_rates + i, (p + 2), len);
 	}
 
-	bssid->NetworkTypeInUse = Ndis802_11OFDM24;
+	bssid->network_type_in_use = Ndis802_11OFDM24;
 
-	if (bssid->IELength < 12)
+	if (bssid->ie_length < 12)
 		return _FAIL;
 
 	/*  Checking for DSConfig */
-	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_DS_PARAMS, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_DS_PARAMS, &len, bssid->ie_length - ie_offset);
 
-	bssid->Configuration.DSConfig = 0;
-	bssid->Configuration.Length = 0;
+	bssid->configuration.DSConfig = 0;
+	bssid->configuration.Length = 0;
 
 	if (p) {
-		bssid->Configuration.DSConfig = *(p + 2);
+		bssid->configuration.DSConfig = *(p + 2);
 	} else {
 		/*  In 5G, some ap do not have DSSET IE */
 		/*  checking HT info for channel */
-		p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_HT_OPERATION, &len, bssid->IELength - ie_offset);
+		p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_HT_OPERATION, &len, bssid->ie_length - ie_offset);
 		if (p) {
 			struct HT_info_element *HT_info = (struct HT_info_element *)(p + 2);
 
-			bssid->Configuration.DSConfig = HT_info->primary_channel;
+			bssid->configuration.DSConfig = HT_info->primary_channel;
 		} else { /*  use current channel */
-			bssid->Configuration.DSConfig = rtw_get_oper_ch(padapter);
+			bssid->configuration.DSConfig = rtw_get_oper_ch(padapter);
 		}
 	}
 
-	memcpy(&le32_tmp, rtw_get_beacon_interval_from_ie(bssid->IEs), 2);
-	bssid->Configuration.BeaconPeriod = le32_to_cpu(le32_tmp);
+	memcpy(&le32_tmp, rtw_get_beacon_interval_from_ie(bssid->ies), 2);
+	bssid->configuration.BeaconPeriod = le32_to_cpu(le32_tmp);
 
 	val16 = rtw_get_capability((struct wlan_bssid_ex *)bssid);
 
 	if (val16 & BIT(0)) {
-		bssid->InfrastructureMode = Ndis802_11Infrastructure;
-		memcpy(bssid->MacAddress, GetAddr2Ptr(pframe), ETH_ALEN);
+		bssid->infrastructure_mode = Ndis802_11Infrastructure;
+		memcpy(bssid->mac_address, GetAddr2Ptr(pframe), ETH_ALEN);
 	} else {
-		bssid->InfrastructureMode = Ndis802_11IBSS;
-		memcpy(bssid->MacAddress, GetAddr3Ptr(pframe), ETH_ALEN);
+		bssid->infrastructure_mode = Ndis802_11IBSS;
+		memcpy(bssid->mac_address, GetAddr3Ptr(pframe), ETH_ALEN);
 	}
 
 	if (val16 & BIT(4))
-		bssid->Privacy = 1;
+		bssid->privacy = 1;
 	else
-		bssid->Privacy = 0;
+		bssid->privacy = 0;
 
-	bssid->Configuration.ATIMWindow = 0;
+	bssid->configuration.ATIMWindow = 0;
 
 	/* 20/40 BSS Coexistence check */
 	if ((pregistrypriv->wifi_spec == 1) && (false == pmlmeinfo->bwmode_updated)) {
 		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-		p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_HT_CAPABILITY, &len, bssid->IELength - ie_offset);
+		p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_HT_CAPABILITY, &len, bssid->ie_length - ie_offset);
 		if (p && len > 0) {
 			struct HT_caps_element	*pHT_caps;
 
@@ -4096,8 +4096,8 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	}
 
 	/*  mark bss info receiving from nearby channel as SignalQuality 101 */
-	if (bssid->Configuration.DSConfig != rtw_get_oper_ch(padapter))
-		bssid->PhyInfo.SignalQuality = 101;
+	if (bssid->configuration.DSConfig != rtw_get_oper_ch(padapter))
+		bssid->phy_info.SignalQuality = 101;
 
 	return _SUCCESS;
 }
@@ -4111,7 +4111,7 @@ void start_create_ibss(struct adapter *padapter)
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 
-	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
+	pmlmeext->cur_channel = (u8)pnetwork->configuration.DSConfig;
 	pmlmeinfo->bcn_interval = get_beacon_interval(pnetwork);
 
 	/* update wireless mode */
@@ -4141,7 +4141,7 @@ void start_create_ibss(struct adapter *padapter)
 			report_join_res(padapter, -1);
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		} else {
-			rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, padapter->registrypriv.dev_network.MacAddress);
+			rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, padapter->registrypriv.dev_network.mac_address);
 			join_type = 0;
 			rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
@@ -4187,7 +4187,7 @@ void start_clnt_join(struct adapter *padapter)
 		/* 	For the Win8 P2P connection, it will be hard to have a successful connection if this Wi-Fi doesn't connect to it. */
 		{
 				/* To avoid connecting to AP fail during resume process, change retry count from 5 to 1 */
-				issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, 1, 100);
+				issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, 1, 100);
 		}
 
 		/* here wait for receiving the beacon to start auth */
@@ -4302,7 +4302,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 		u8 noc; /*  number of channel */
 		u8 j, k;
 
-		ie = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_COUNTRY, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+		ie = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, WLAN_EID_COUNTRY, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 		if (!ie)
 			return;
 		if (len < 6)
@@ -4409,7 +4409,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 	}
 
 	/*  If channel is used by AP, set channel scan type to active */
-	channel = bssid->Configuration.DSConfig;
+	channel = bssid->configuration.DSConfig;
 	chplan_new = pmlmeext->channel_set;
 	i = 0;
 	while ((i < MAX_CHANNEL_NUM) && (chplan_new[i].ChannelNum != 0)) {
@@ -4866,7 +4866,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	/*  update IOT-related issue */
 	update_IOT_info(padapter);
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, cur_network->SupportedRates);
+	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, cur_network->supported_rates);
 
 	/* BCN interval */
 	rtw_hal_set_hwreg(padapter, HW_VAR_BEACON_INTERVAL, (u8 *)(&pmlmeinfo->bcn_interval));
@@ -4883,7 +4883,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	/* Set cur_channel&cur_bwmode&cur_ch_offset */
 	set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode);
 
-	psta = rtw_get_stainfo(pstapriv, cur_network->MacAddress);
+	psta = rtw_get_stainfo(pstapriv, cur_network->mac_address);
 	if (psta) { /* only for infra. mode */
 
 		pmlmeinfo->FW_sta_info[psta->mac_id].psta = psta;
@@ -5047,7 +5047,7 @@ void linked_status_chk(struct adapter *padapter)
 		/*  Marked by Kurt 20130715 */
 		/*  For WiDi 3.5 and latered on, they don't ask WiDi sink to do roaming, so we could not check rx limit that strictly. */
 		/*  todo: To check why we under miracast session, rx_chk would be false */
-		psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.MacAddress);
+		psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.mac_address);
 		if (psta) {
 			if (chk_ap_is_alive(padapter, psta) == false)
 				rx_chk = _FAIL;
@@ -5058,9 +5058,9 @@ void linked_status_chk(struct adapter *padapter)
 			{
 				if (rx_chk != _SUCCESS) {
 					if (pmlmeext->retry == 0) {
-						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
-						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
-						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
+						issue_probereq_ex(padapter, &pmlmeinfo->network.ssid, pmlmeinfo->network.mac_address, 0, 0, 0, 0);
+						issue_probereq_ex(padapter, &pmlmeinfo->network.ssid, pmlmeinfo->network.mac_address, 0, 0, 0, 0);
+						issue_probereq_ex(padapter, &pmlmeinfo->network.ssid, pmlmeinfo->network.mac_address, 0, 0, 0, 0);
 					}
 				}
 
@@ -5075,7 +5075,7 @@ void linked_status_chk(struct adapter *padapter)
 					netdev_dbg(padapter->pnetdev,
 						   FUNC_ADPT_FMT " disconnect or roaming\n",
 						   FUNC_ADPT_ARG(padapter));
-					receive_disconnect(padapter, pmlmeinfo->network.MacAddress
+					receive_disconnect(padapter, pmlmeinfo->network.mac_address
 						, WLAN_REASON_EXPIRATION_CHK);
 					return;
 				}
@@ -5090,7 +5090,7 @@ void linked_status_chk(struct adapter *padapter)
 				pmlmeinfo->link_count = 0;
 			}
 
-		} /* end of if ((psta = rtw_get_stainfo(pstapriv, passoc_res->network.MacAddress)) != NULL) */
+		} /* end of if ((psta = rtw_get_stainfo(pstapriv, passoc_res->network.mac_address)) != NULL) */
 	} else if (is_client_associated_to_ibss(padapter)) {
 		/* linked IBSS mode */
 		/* for each assoc list entry to check the rx pkt counter */
@@ -5301,7 +5301,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 	}
 
 	/* below is for ad-hoc master */
-	if (pparm->network.InfrastructureMode == Ndis802_11IBSS) {
+	if (pparm->network.infrastructure_mode == Ndis802_11IBSS) {
 		rtw_joinbss_reset(padapter);
 
 		pmlmeext->cur_bwmode = CHANNEL_WIDTH_20;
@@ -5328,13 +5328,13 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 		/* clear CAM */
 		flush_all_cam_entry(padapter);
 
-		memcpy(pnetwork, pbuf, FIELD_OFFSET(struct wlan_bssid_ex, IELength));
-		pnetwork->IELength = ((struct wlan_bssid_ex *)pbuf)->IELength;
+		memcpy(pnetwork, pbuf, FIELD_OFFSET(struct wlan_bssid_ex, ie_length));
+		pnetwork->ie_length = ((struct wlan_bssid_ex *)pbuf)->ie_length;
 
-		if (pnetwork->IELength > MAX_IE_SZ)/* Check pbuf->IELength */
+		if (pnetwork->ie_length > MAX_IE_SZ)/* Check pbuf->ie_length */
 			return H2C_PARAMETERS_ERROR;
 
-		memcpy(pnetwork->IEs, ((struct wlan_bssid_ex *)pbuf)->IEs, pnetwork->IELength);
+		memcpy(pnetwork->ies, ((struct wlan_bssid_ex *)pbuf)->ies, pnetwork->ie_length);
 
 		start_create_ibss(padapter);
 
@@ -5361,7 +5361,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	/* check already connecting to AP or not */
 	if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
 		if (pmlmeinfo->state & WIFI_FW_STATION_STATE) {
-			issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, 1, 100);
+			issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, 1, 100);
 		}
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 
@@ -5393,23 +5393,23 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	/* pmlmeinfo->assoc_AP_vendor = HT_IOT_PEER_MAX; */
 	pmlmeinfo->VHT_enable = 0;
 
-	memcpy(pnetwork, pbuf, FIELD_OFFSET(struct wlan_bssid_ex, IELength));
-	pnetwork->IELength = ((struct wlan_bssid_ex *)pbuf)->IELength;
+	memcpy(pnetwork, pbuf, FIELD_OFFSET(struct wlan_bssid_ex, ie_length));
+	pnetwork->ie_length = ((struct wlan_bssid_ex *)pbuf)->ie_length;
 
-	if (pnetwork->IELength > MAX_IE_SZ)/* Check pbuf->IELength */
+	if (pnetwork->ie_length > MAX_IE_SZ)/* Check pbuf->ie_length */
 		return H2C_PARAMETERS_ERROR;
 
-	memcpy(pnetwork->IEs, ((struct wlan_bssid_ex *)pbuf)->IEs, pnetwork->IELength);
+	memcpy(pnetwork->ies, ((struct wlan_bssid_ex *)pbuf)->ies, pnetwork->ie_length);
 
-	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
+	pmlmeext->cur_channel = (u8)pnetwork->configuration.DSConfig;
 	pmlmeinfo->bcn_interval = get_beacon_interval(pnetwork);
 
 	/* Check AP vendor to move rtw_joinbss_cmd() */
-	/* pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->IEs, pnetwork->IELength); */
+	/* pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->ies, pnetwork->ie_length); */
 
 	/* sizeof(struct ndis_802_11_fix_ie) */
-	for (i = _FIXED_IE_LENGTH_; i < pnetwork->IELength;) {
-		pIE = (struct ndis_80211_var_ie *)(pnetwork->IEs + i);
+	for (i = _FIXED_IE_LENGTH_; i < pnetwork->ie_length;) {
+		pIE = (struct ndis_80211_var_ie *)(pnetwork->ies + i);
 
 		switch (pIE->ElementID) {
 		case WLAN_EID_VENDOR_SPECIFIC:/* Get WMM IE. */
@@ -5428,7 +5428,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 			{
 				struct HT_info_element *pht_info = (struct HT_info_element *)(pIE->data);
 
-				if (pnetwork->Configuration.DSConfig <= 14) {
+				if (pnetwork->configuration.DSConfig <= 14) {
 					if ((pregpriv->bw_mode & 0x0f) > CHANNEL_WIDTH_20)
 						cbw40_enable = 1;
 				}
@@ -5473,7 +5473,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	/* initialgain = 0x1E; */
 	/* rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain)); */
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pmlmeinfo->network.MacAddress);
+	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pmlmeinfo->network.mac_address);
 	join_type = 0;
 	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 	rtw_hal_set_hwreg(padapter, HW_VAR_DO_IQK, NULL);
@@ -5498,7 +5498,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	u8 val8;
 
 	if (is_client_associated_to_ap(padapter)) {
-			issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
+			issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
 	}
 
 	if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
@@ -5819,10 +5819,10 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 
 	memcpy(&(ptxBeacon_parm->network), &(pmlmeinfo->network), sizeof(struct wlan_bssid_ex));
 
-	len_diff = update_hidden_ssid(ptxBeacon_parm->network.IEs+_BEACON_IE_OFFSET_,
-				      ptxBeacon_parm->network.IELength-_BEACON_IE_OFFSET_,
+	len_diff = update_hidden_ssid(ptxBeacon_parm->network.ies+_BEACON_IE_OFFSET_,
+				      ptxBeacon_parm->network.ie_length-_BEACON_IE_OFFSET_,
 				      pmlmeinfo->hidden_ssid_mode);
-	ptxBeacon_parm->network.IELength += len_diff;
+	ptxBeacon_parm->network.ie_length += len_diff;
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, ptxBeacon_parm, GEN_CMD_CODE(_TX_Beacon));
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 08f9ba9bf7ff..dfdeec2d0763 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -390,14 +390,14 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 
 inline u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork)
 {
-	return pnetwork->MacAddress;
+	return pnetwork->mac_address;
 }
 
 u16 get_beacon_interval(struct wlan_bssid_ex *bss)
 {
 	__le16 val;
 
-	memcpy((unsigned char *)&val, rtw_get_beacon_interval_from_ie(bss->IEs), 2);
+	memcpy((unsigned char *)&val, rtw_get_beacon_interval_from_ie(bss->ies), 2);
 
 	return le16_to_cpu(val);
 }
@@ -964,7 +964,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 		/* set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode); */
 
 		/* update ap's stainfo */
-		psta = rtw_get_stainfo(pstapriv, cur_network->MacAddress);
+		psta = rtw_get_stainfo(pstapriv, cur_network->mac_address);
 		if (psta) {
 			struct ht_priv *phtpriv_sta = &psta->htpriv;
 
@@ -1208,7 +1208,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	if (len > MAX_IE_SZ)
 		return _FAIL;
 
-	if (memcmp(cur_network->network.MacAddress, pbssid, 6))
+	if (memcmp(cur_network->network.mac_address, pbssid, 6))
 		return true;
 
 	bssid = rtw_zmalloc(sizeof(struct wlan_bssid_ex));
@@ -1225,15 +1225,15 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	if (subtype == WIFI_BEACON)
 		bssid->Reserved[0] = 1;
 
-	bssid->Length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
+	bssid->length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
 
 	/* below is to copy the information element */
-	bssid->IELength = len;
-	memcpy(bssid->IEs, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->IELength);
+	bssid->ie_length = len;
+	memcpy(bssid->ies, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->ie_length);
 
 	/* check bw and channel offset */
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 		pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 		ht_cap_info = le16_to_cpu(pht_cap->cap_info);
@@ -1241,7 +1241,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 		pht_info = (struct HT_info_element *)(p + 2);
 		ht_info_infos_0 = pht_info->infos[0];
@@ -1260,12 +1260,12 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	/* Checking for channel */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_DS_PARAMS, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, WLAN_EID_DS_PARAMS, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 	if (p) {
 		bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
-		rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION,
-			   &len, bssid->IELength - _FIXED_IE_LENGTH_);
+		rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION,
+			   &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 		if (pht_info)
 			bcn_channel = pht_info->primary_channel;
 		else /* we don't find channel IE, so don't check it */
@@ -1277,52 +1277,52 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 
 	/* checking SSID */
 	ssid_len = 0;
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_SSID, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, WLAN_EID_SSID, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 	if (p) {
 		ssid_len = *(p + 1);
 		if (ssid_len > NDIS_802_11_LENGTH_SSID)
 			ssid_len = 0;
 	}
-	memcpy(bssid->Ssid.Ssid, (p + 2), ssid_len);
-	bssid->Ssid.SsidLength = ssid_len;
+	memcpy(bssid->ssid.Ssid, (p + 2), ssid_len);
+	bssid->ssid.SsidLength = ssid_len;
 
-	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
-			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength)
-		if (bssid->Ssid.Ssid[0] != '\0' &&
-		    bssid->Ssid.SsidLength != 0) /* not hidden ssid */
+	if (memcmp(bssid->ssid.Ssid, cur_network->network.ssid.Ssid, 32) ||
+			bssid->ssid.SsidLength != cur_network->network.ssid.SsidLength)
+		if (bssid->ssid.Ssid[0] != '\0' &&
+		    bssid->ssid.SsidLength != 0) /* not hidden ssid */
 			goto _mismatch;
 
 	/* check encryption info */
 	val16 = rtw_get_capability((struct wlan_bssid_ex *)bssid);
 
 	if (val16 & BIT(4))
-		bssid->Privacy = 1;
+		bssid->privacy = 1;
 	else
-		bssid->Privacy = 0;
+		bssid->privacy = 0;
 
-	if (cur_network->network.Privacy != bssid->Privacy)
+	if (cur_network->network.privacy != bssid->privacy)
 		goto _mismatch;
 
-	rtw_get_sec_ie(bssid->IEs, bssid->IELength, NULL, &rsn_len, NULL, &wpa_len);
+	rtw_get_sec_ie(bssid->ies, bssid->ie_length, NULL, &rsn_len, NULL, &wpa_len);
 
 	if (rsn_len > 0)
 		encryp_protocol = ENCRYP_PROTOCOL_WPA2;
 	else if (wpa_len > 0)
 		encryp_protocol = ENCRYP_PROTOCOL_WPA;
 	else
-		if (bssid->Privacy)
+		if (bssid->privacy)
 			encryp_protocol = ENCRYP_PROTOCOL_WEP;
 
 	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol)
 		goto _mismatch;
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
-		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
+		pbuf = rtw_get_wpa_ie(&bssid->ies[12], &wpa_ielen, bssid->ie_length-12);
 		if (pbuf && (wpa_ielen > 0)) {
 			rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher,
 					 &pairwise_cipher, &is_8021x);
 		} else {
-			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
+			pbuf = rtw_get_wpa2_ie(&bssid->ies[12], &wpa_ielen, bssid->ie_length-12);
 
 			if (pbuf && (wpa_ielen > 0))
 				rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher,
@@ -1405,8 +1405,8 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
 
 	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
-		for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.IELength;) {
-			pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.IEs + i);
+		for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+			pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
 
 			switch (pIE->ElementID) {
 			case WLAN_EID_VENDOR_SPECIFIC:
@@ -1629,7 +1629,7 @@ void update_wireless_mode(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
-	unsigned char *rate = cur_network->SupportedRates;
+	unsigned char *rate = cur_network->supported_rates;
 
 	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable))
 		pmlmeinfo->HT_enable = 1;
diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 8ec8f283893b..472005537b1b 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -580,7 +580,7 @@ static u8 halbtcoutsrc_Set(void *pBtcContext, u8 setType, void *pInBuf)
 			struct wlan_bssid_ex *cur_network;
 
 			cur_network = &padapter->mlmeextpriv.mlmext_info.network;
-			psta = rtw_get_stainfo(&padapter->stapriv, cur_network->MacAddress);
+			psta = rtw_get_stainfo(&padapter->stapriv, cur_network->mac_address);
 			rtw_hal_update_ra_mask(psta, 0);
 		}
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 4a112989899a..0df2b9b61cf8 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -923,7 +923,7 @@ u8 GetHalDefVar(
 
 			pmlmepriv = &adapter->mlmepriv;
 			pstapriv = &adapter->stapriv;
-			psta = rtw_get_stainfo(pstapriv, pmlmepriv->cur_network.network.MacAddress);
+			psta = rtw_get_stainfo(pstapriv, pmlmepriv->cur_network.network.mac_address);
 			if (psta)
 				*((int *)value) = psta->rssi_stat.UndecoratedSmoothedPWDB;
 		}
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 2b7077bb52df..772760f34fd8 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -136,20 +136,20 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	pktlen += 8;
 
 	/*  beacon interval: 2 bytes */
-	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pktlen += 2;
 
 	/*  capability info: 2 bytes */
-	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pktlen += 2;
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
-		pktlen += cur_network->IELength - sizeof(struct ndis_802_11_fix_ie);
-		memcpy(pframe, cur_network->IEs+sizeof(struct ndis_802_11_fix_ie), pktlen);
+		pktlen += cur_network->ie_length - sizeof(struct ndis_802_11_fix_ie);
+		memcpy(pframe, cur_network->ies+sizeof(struct ndis_802_11_fix_ie), pktlen);
 
 		goto _ConstructBeacon;
 	}
@@ -157,19 +157,19 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	/* below for ad-hoc mode */
 
 	/*  SSID */
-	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->ssid.SsidLength, cur_network->ssid.Ssid, &pktlen);
 
 	/*  supported rates... */
-	rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
-	pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pktlen);
+	rate_len = rtw_get_rateset_len(cur_network->supported_rates);
+	pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->supported_rates, &pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->configuration.DSConfig), &pktlen);
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 		u32 ATIMWindow;
 		/*  IBSS Parameter Set... */
-		/* ATIMWindow = cur->Configuration.ATIMWindow; */
+		/* ATIMWindow = cur->configuration.ATIMWindow; */
 		ATIMWindow = 0;
 		pframe = rtw_set_ie(pframe, WLAN_EID_IBSS_PARAMS, 2, (unsigned char *)(&ATIMWindow), &pktlen);
 	}
@@ -180,7 +180,7 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 
 	/*  EXTERNDED SUPPORTED RATE */
 	if (rate_len > 8)
-		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->SupportedRates + 8), &pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->supported_rates + 8), &pktlen);
 
 
 	/* todo:HT for adhoc */
@@ -247,7 +247,7 @@ static void ConstructNullFunctionData(
 	if (bForcePowerSave)
 		SetPwrMgt(fctrl);
 
-	switch (cur_network->network.InfrastructureMode) {
+	switch (cur_network->network.infrastructure_mode) {
 	case Ndis802_11Infrastructure:
 		SetToDs(fctrl);
 		memcpy(pwlanhdr->addr1, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index 5deb73fe3885..c94fa7d8d5a9 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -445,9 +445,9 @@ extern signed int rtw_set_key(struct adapter *adapter, struct security_priv *pse
 extern signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv);
 
 static inline u8 *get_bssid(struct mlme_priv *pmlmepriv)
-{	/* if sta_mode:pmlmepriv->cur_network.network.MacAddress => bssid */
-	/*  if adhoc_mode:pmlmepriv->cur_network.network.MacAddress => ibss mac address */
-	return pmlmepriv->cur_network.network.MacAddress;
+{	/* if sta_mode:pmlmepriv->cur_network.network.mac_address => bssid */
+	/*  if adhoc_mode:pmlmepriv->cur_network.network.mac_address => ibss mac address */
+	return pmlmepriv->cur_network.network.mac_address;
 }
 
 static inline signed int check_fwstate(struct mlme_priv *pmlmepriv, signed int state)
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index a45990bed80c..891bd2fca652 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -75,9 +75,9 @@ struct ndis_80211_var_ie {
  * sizeof (NDIS_802_11_MAC_ADDRESS) + 2 +
  * sizeof (struct ndis_802_11_ssid) + sizeof (u32) +
  * sizeof (long) + sizeof (enum ndis_802_11_network_type) +
- * sizeof (struct ndis_802_11_conf) + sizeof (NDIS_802_11_RATES_EX) + IELength
+ * sizeof (struct ndis_802_11_conf) + sizeof (NDIS_802_11_RATES_EX) + ie_length
  *
- * Except for IELength, all other fields are fixed length. Therefore, we can
+ * Except for ie_length, all other fields are fixed length. Therefore, we can
  * define a macro to present the partial sum.
  */
 enum ndis_802_11_authentication_mode {
@@ -174,24 +174,24 @@ struct wlan_bcn_info {
 *   struct wlan_bssid_ex and get_wlan_bssid_ex_sz()
 */
 struct wlan_bssid_ex {
-	u32  Length;
-	NDIS_802_11_MAC_ADDRESS  MacAddress;
+	u32  length;
+	NDIS_802_11_MAC_ADDRESS  mac_address;
 	u8  Reserved[2];/* 0]: IS beacon frame */
-	struct ndis_802_11_ssid  Ssid;
-	u32  Privacy;
-	long  Rssi;/* in dBM, raw data , get from PHY) */
-	enum ndis_802_11_network_type  NetworkTypeInUse;
-	struct ndis_802_11_conf  Configuration;
-	enum ndis_802_11_network_infrastructure  InfrastructureMode;
-	NDIS_802_11_RATES_EX  SupportedRates;
-	struct wlan_phy_info PhyInfo;
-	u32  IELength;
-	u8  IEs[MAX_IE_SZ];	/* timestamp, beacon interval, and capability information) */
+	struct ndis_802_11_ssid  ssid;
+	u32  privacy;
+	long  rssi;/* in dBM, raw data , get from PHY) */
+	enum ndis_802_11_network_type  network_type_in_use;
+	struct ndis_802_11_conf  configuration;
+	enum ndis_802_11_network_infrastructure  infrastructure_mode;
+	NDIS_802_11_RATES_EX  supported_rates;
+	struct wlan_phy_info phy_info;
+	u32  ie_length;
+	u8  ies[MAX_IE_SZ];	/* timestamp, beacon interval, and capability information) */
 } __packed;
 
 static inline uint get_wlan_bssid_ex_sz(struct wlan_bssid_ex *bss)
 {
-	return (sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + bss->IELength);
+	return (sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + bss->ie_length);
 }
 
 struct	wlan_network {
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 368e575c24af..015f68553164 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -231,14 +231,14 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	struct wiphy *wiphy = wdev->wiphy;
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
-	bssinf_len = pnetwork->network.IELength + sizeof(struct ieee80211_hdr_3addr);
+	bssinf_len = pnetwork->network.ie_length + sizeof(struct ieee80211_hdr_3addr);
 	if (bssinf_len > MAX_BSSINFO_LEN)
 		goto exit;
 
 	{
 		u16 wapi_len = 0;
 
-		if (rtw_get_wapi_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &wapi_len) > 0)
+		if (rtw_get_wapi_ie(pnetwork->network.ies, pnetwork->network.ie_length, NULL, &wapi_len) > 0)
 		{
 			if (wapi_len > 0)
 				goto exit;
@@ -250,13 +250,13 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	if (adapter_wdev_data(padapter)->scan_request)
 	{
 		u8 *psr = NULL, sr = 0;
-		struct ndis_802_11_ssid *pssid = &pnetwork->network.Ssid;
+		struct ndis_802_11_ssid *pssid = &pnetwork->network.ssid;
 		struct cfg80211_scan_request *request = adapter_wdev_data(padapter)->scan_request;
 		struct cfg80211_ssid *ssids = request->ssids;
 		u32 wpsielen = 0;
 		u8 *wpsie = NULL;
 
-		wpsie = rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wpsielen);
+		wpsie = rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wpsielen);
 
 		if (wpsie && wpsielen > 0)
 			psr = rtw_get_wps_attr_content(wpsie,  wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
@@ -278,7 +278,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	/* spin_unlock_bh(&pwdev_priv->scan_req_lock); */
 
 
-	channel = pnetwork->network.Configuration.DSConfig;
+	channel = pnetwork->network.configuration.DSConfig;
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
 
 	notify_channel = ieee80211_get_channel(wiphy, freq);
@@ -290,7 +290,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		is_same_network(&pmlmepriv->cur_network.network, &pnetwork->network, 0)) {
 		notify_signal = 100*translate_percentage_to_dbm(padapter->recvpriv.signal_strength);/* dbm */
 	} else {
-		notify_signal = 100*translate_percentage_to_dbm(pnetwork->network.PhyInfo.SignalStrength);/* dbm */
+		notify_signal = 100*translate_percentage_to_dbm(pnetwork->network.phy_info.SignalStrength);/* dbm */
 	}
 
 	buf = kzalloc(MAX_BSSINFO_LEN, GFP_ATOMIC);
@@ -313,15 +313,15 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		SetFrameSubType(pbuf, WIFI_PROBERSP);
 	}
 
-	memcpy(pwlanhdr->addr2, pnetwork->network.MacAddress, ETH_ALEN);
-	memcpy(pwlanhdr->addr3, pnetwork->network.MacAddress, ETH_ALEN);
+	memcpy(pwlanhdr->addr2, pnetwork->network.mac_address, ETH_ALEN);
+	memcpy(pwlanhdr->addr3, pnetwork->network.mac_address, ETH_ALEN);
 
 
 	pbuf += sizeof(struct ieee80211_hdr_3addr);
 	len = sizeof(struct ieee80211_hdr_3addr);
 
-	memcpy(pbuf, pnetwork->network.IEs, pnetwork->network.IELength);
-	len += pnetwork->network.IELength;
+	memcpy(pbuf, pnetwork->network.ies, pnetwork->network.ie_length);
+	len += pnetwork->network.ie_length;
 
 	*((__le64 *)pbuf) = cpu_to_le64(notify_timestamp);
 
@@ -355,12 +355,12 @@ int rtw_cfg80211_check_bss(struct adapter *padapter)
 	if (!(pnetwork) || !(padapter->rtw_wdev))
 		return false;
 
-	freq = rtw_ieee80211_channel_to_frequency(pnetwork->Configuration.DSConfig, NL80211_BAND_2GHZ);
+	freq = rtw_ieee80211_channel_to_frequency(pnetwork->configuration.DSConfig, NL80211_BAND_2GHZ);
 
 	notify_channel = ieee80211_get_channel(padapter->rtw_wdev->wiphy, freq);
 	bss = cfg80211_get_bss(padapter->rtw_wdev->wiphy, notify_channel,
-			pnetwork->MacAddress, pnetwork->Ssid.Ssid,
-			pnetwork->Ssid.SsidLength,
+			pnetwork->mac_address, pnetwork->ssid.Ssid,
+			pnetwork->ssid.SsidLength,
 			WLAN_CAPABILITY_ESS, WLAN_CAPABILITY_ESS);
 
 	cfg80211_put_bss(padapter->rtw_wdev->wiphy, bss);
@@ -374,7 +374,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 	struct wireless_dev *pwdev = padapter->rtw_wdev;
 	struct wiphy *wiphy = pwdev->wiphy;
-	int freq = (int)cur_network->network.Configuration.DSConfig;
+	int freq = (int)cur_network->network.configuration.DSConfig;
 	struct ieee80211_channel *chan;
 
 	if (pwdev->iftype != NL80211_IFTYPE_ADHOC)
@@ -398,8 +398,8 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 				rtw_warn_on(1);
 				return;
 			}
-			if (!memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
-				&& !memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
+			if (!memcmp(&(scanned->network.ssid), &(pnetwork->ssid), sizeof(struct ndis_802_11_ssid))
+				&& !memcmp(scanned->network.mac_address, pnetwork->mac_address, sizeof(NDIS_802_11_MAC_ADDRESS))
 			)
 				rtw_cfg80211_inform_bss(padapter, scanned);
 			else
@@ -413,7 +413,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 	}
 	/* notify cfg80211 that device joined an IBSS */
 	chan = ieee80211_get_channel(wiphy, freq);
-	cfg80211_ibss_joined(padapter->pnetdev, cur_network->network.MacAddress, chan, GFP_ATOMIC);
+	cfg80211_ibss_joined(padapter->pnetdev, cur_network->network.mac_address, chan, GFP_ATOMIC);
 }
 
 void rtw_cfg80211_indicate_connect(struct adapter *padapter)
@@ -440,8 +440,8 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 			goto check_bss;
 		}
 
-		if (!memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
-			&& !memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
+		if (!memcmp(scanned->network.mac_address, pnetwork->mac_address, sizeof(NDIS_802_11_MAC_ADDRESS))
+			&& !memcmp(&(scanned->network.ssid), &(pnetwork->ssid), sizeof(struct ndis_802_11_ssid))
 		)
 			rtw_cfg80211_inform_bss(padapter, scanned);
 		else
@@ -458,7 +458,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		struct wiphy *wiphy = pwdev->wiphy;
 		struct ieee80211_channel *notify_channel;
 		u32 freq;
-		u16 channel = cur_network->network.Configuration.DSConfig;
+		u16 channel = cur_network->network.configuration.DSConfig;
 		struct cfg80211_roam_info roam_info = {};
 
 		freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
@@ -466,7 +466,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		notify_channel = ieee80211_get_channel(wiphy, freq);
 
 		roam_info.channel = notify_channel;
-		roam_info.bssid = cur_network->network.MacAddress;
+		roam_info.bssid = cur_network->network.mac_address;
 		roam_info.req_ie =
 			pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2;
 		roam_info.req_ie_len =
@@ -479,7 +479,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 	}
 	else
 	{
-		cfg80211_connect_result(padapter->pnetdev, cur_network->network.MacAddress
+		cfg80211_connect_result(padapter->pnetdev, cur_network->network.mac_address
 			, pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2
 			, pmlmepriv->assoc_req_len-sizeof(struct ieee80211_hdr_3addr)-2
 			, pmlmepriv->assoc_rsp+sizeof(struct ieee80211_hdr_3addr)+6
@@ -1113,7 +1113,7 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	{
 		struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 
-		if (memcmp((u8 *)mac, cur_network->network.MacAddress, ETH_ALEN)) {
+		if (memcmp((u8 *)mac, cur_network->network.mac_address, ETH_ALEN)) {
 			ret = -ENOENT;
 			goto exit;
 		}
@@ -1241,8 +1241,8 @@ void rtw_cfg80211_unlink_bss(struct adapter *padapter, struct wlan_network *pnet
 	struct wlan_bssid_ex *select_network = &pnetwork->network;
 
 	bss = cfg80211_get_bss(wiphy, NULL/*notify_channel*/,
-		select_network->MacAddress, select_network->Ssid.Ssid,
-		select_network->Ssid.SsidLength, 0/*WLAN_CAPABILITY_ESS*/,
+		select_network->mac_address, select_network->ssid.Ssid,
+		select_network->ssid.SsidLength, 0/*WLAN_CAPABILITY_ESS*/,
 		0/*WLAN_CAPABILITY_ESS*/);
 
 	if (bss) {
@@ -1266,8 +1266,8 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
-		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.Configuration.DSConfig) >= 0
-			&& true == rtw_validate_ssid(&(pnetwork->network.Ssid))
+		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.configuration.DSConfig) >= 0
+			&& true == rtw_validate_ssid(&(pnetwork->network.ssid))
 		)
 		{
 			/* ev =translate_scan(padapter, a, pnetwork, ev, stop); */
@@ -2435,7 +2435,7 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
 	/* check wps ie if inclued */
 	rtw_get_wps_ie(pbuf + _FIXED_IE_LENGTH_, len - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
-	/* pbss_network->IEs will not include p2p_ie, wfd ie */
+	/* pbss_network->ies will not include p2p_ie, wfd ie */
 	rtw_ies_remove_ie(pbuf, &len, _BEACON_IE_OFFSET_, WLAN_EID_VENDOR_SPECIFIC, P2P_OUI, 4);
 	rtw_ies_remove_ie(pbuf, &len, _BEACON_IE_OFFSET_, WLAN_EID_VENDOR_SPECIFIC, WFD_OUI, 4);
 
@@ -2466,10 +2466,10 @@ static int cfg80211_rtw_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 		struct wlan_bssid_ex *pbss_network = &adapter->mlmepriv.cur_network.network;
 		struct wlan_bssid_ex *pbss_network_ext = &adapter->mlmeextpriv.mlmext_info.network;
 
-		memcpy(pbss_network->Ssid.Ssid, (void *)settings->ssid, settings->ssid_len);
-		pbss_network->Ssid.SsidLength = settings->ssid_len;
-		memcpy(pbss_network_ext->Ssid.Ssid, (void *)settings->ssid, settings->ssid_len);
-		pbss_network_ext->Ssid.SsidLength = settings->ssid_len;
+		memcpy(pbss_network->ssid.Ssid, (void *)settings->ssid, settings->ssid_len);
+		pbss_network->ssid.SsidLength = settings->ssid_len;
+		memcpy(pbss_network_ext->ssid.Ssid, (void *)settings->ssid, settings->ssid_len);
+		pbss_network_ext->ssid.SsidLength = settings->ssid_len;
 	}
 
 	return ret;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 060cdd7b2925..bda02f4f74db 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -54,9 +54,9 @@ void rtw_indicate_wx_assoc_event(struct adapter *padapter)
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)
-		memcpy(wrqu.ap_addr.sa_data, pnetwork->MacAddress, ETH_ALEN);
+		memcpy(wrqu.ap_addr.sa_data, pnetwork->mac_address, ETH_ALEN);
 	else
-		memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress, ETH_ALEN);
+		memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.mac_address, ETH_ALEN);
 
 	netdev_dbg(padapter->pnetdev, "assoc success\n");
 }
@@ -92,20 +92,20 @@ static char *translate_scan(struct adapter *padapter,
 	iwe.cmd = SIOCGIWAP;
 	iwe.u.ap_addr.sa_family = ARPHRD_ETHER;
 
-	memcpy(iwe.u.ap_addr.sa_data, pnetwork->network.MacAddress, ETH_ALEN);
+	memcpy(iwe.u.ap_addr.sa_data, pnetwork->network.mac_address, ETH_ALEN);
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_ADDR_LEN);
 
 	/* Add the ESSID */
 	iwe.cmd = SIOCGIWESSID;
 	iwe.u.data.flags = 1;
-	iwe.u.data.length = min((u16)pnetwork->network.Ssid.SsidLength, (u16)32);
-	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
+	iwe.u.data.length = min((u16)pnetwork->network.ssid.SsidLength, (u16)32);
+	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.Ssid);
 
 	/* parsing HT_CAP_IE */
 	if (pnetwork->network.Reserved[0] == 2) { /*  Probe Request */
-		p = rtw_get_ie(&pnetwork->network.IEs[0], WLAN_EID_HT_CAPABILITY, &ht_ielen, pnetwork->network.IELength);
+		p = rtw_get_ie(&pnetwork->network.ies[0], WLAN_EID_HT_CAPABILITY, &ht_ielen, pnetwork->network.ie_length);
 	} else {
-		p = rtw_get_ie(&pnetwork->network.IEs[12], WLAN_EID_HT_CAPABILITY, &ht_ielen, pnetwork->network.IELength-12);
+		p = rtw_get_ie(&pnetwork->network.ies[12], WLAN_EID_HT_CAPABILITY, &ht_ielen, pnetwork->network.ie_length-12);
 	}
 	if (p && ht_ielen > 0) {
 		struct ieee80211_ht_cap *pht_capie;
@@ -118,18 +118,18 @@ static char *translate_scan(struct adapter *padapter,
 
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
-	if (rtw_is_cckratesonly_included((u8 *)&pnetwork->network.SupportedRates)) {
+	if (rtw_is_cckratesonly_included((u8 *)&pnetwork->network.supported_rates)) {
 		if (ht_cap)
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bn");
 		else
 		snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11b");
-	} else if (rtw_is_cckrates_included((u8 *)&pnetwork->network.SupportedRates)) {
+	} else if (rtw_is_cckrates_included((u8 *)&pnetwork->network.supported_rates)) {
 		if (ht_cap)
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bgn");
 		else
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bg");
 	} else {
-		if (pnetwork->network.Configuration.DSConfig <= 14) {
+		if (pnetwork->network.configuration.DSConfig <= 14) {
 			if (ht_cap)
 				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
 			else
@@ -146,7 +146,7 @@ static char *translate_scan(struct adapter *padapter,
 		__le16 le_tmp;
 
 	        iwe.cmd = SIOCGIWMODE;
-		memcpy((u8 *)&le_tmp, rtw_get_capability_from_ie(pnetwork->network.IEs), 2);
+		memcpy((u8 *)&le_tmp, rtw_get_capability_from_ie(pnetwork->network.ies), 2);
 		cap = le16_to_cpu(le_tmp);
 	}
 
@@ -159,14 +159,14 @@ static char *translate_scan(struct adapter *padapter,
 		start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_UINT_LEN);
 	}
 
-	if (pnetwork->network.Configuration.DSConfig < 1)
-		pnetwork->network.Configuration.DSConfig = 1;
+	if (pnetwork->network.configuration.DSConfig < 1)
+		pnetwork->network.configuration.DSConfig = 1;
 
 	 /* Add frequency/channel */
 	iwe.cmd = SIOCGIWFREQ;
-	iwe.u.freq.m = rtw_ch2freq(pnetwork->network.Configuration.DSConfig) * 100000;
+	iwe.u.freq.m = rtw_ch2freq(pnetwork->network.configuration.DSConfig) * 100000;
 	iwe.u.freq.e = 1;
-	iwe.u.freq.i = pnetwork->network.Configuration.DSConfig;
+	iwe.u.freq.i = pnetwork->network.configuration.DSConfig;
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_FREQ_LEN);
 
 	/* Add encryption capability */
@@ -176,7 +176,7 @@ static char *translate_scan(struct adapter *padapter,
 	else
 		iwe.u.data.flags = IW_ENCODE_DISABLED;
 	iwe.u.data.length = 0;
-	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
+	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.Ssid);
 
 	/*Add basic and extended rates */
 	max_rate = 0;
@@ -185,8 +185,8 @@ static char *translate_scan(struct adapter *padapter,
 		return start;
 	p = custom;
 	p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom), " Rates (Mb/s): ");
-	while (pnetwork->network.SupportedRates[i] != 0) {
-		rate = pnetwork->network.SupportedRates[i]&0x7F;
+	while (pnetwork->network.supported_rates[i] != 0) {
+		rate = pnetwork->network.supported_rates[i]&0x7F;
 		if (rate > max_rate)
 			max_rate = rate;
 		p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
@@ -216,7 +216,7 @@ static char *translate_scan(struct adapter *padapter,
 		u8 wpa_ie[255], rsn_ie[255];
 		u16 wpa_len = 0, rsn_len = 0;
 		u8 *p;
-		rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
+		rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
 
 		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_ATOMIC);
 		if (!buf)
@@ -272,14 +272,14 @@ static char *translate_scan(struct adapter *padapter,
 		uint wps_ielen = 0;
 
 		u8 *ie_ptr;
-		total_ielen = pnetwork->network.IELength - ie_offset;
+		total_ielen = pnetwork->network.ie_length - ie_offset;
 
 		if (pnetwork->network.Reserved[0] == 2) { /*  Probe Request */
-			ie_ptr = pnetwork->network.IEs;
-			total_ielen = pnetwork->network.IELength;
+			ie_ptr = pnetwork->network.ies;
+			total_ielen = pnetwork->network.ie_length;
 		} else {    /*  Beacon or Probe Respones */
-			ie_ptr = pnetwork->network.IEs + _FIXED_IE_LENGTH_;
-			total_ielen = pnetwork->network.IELength - _FIXED_IE_LENGTH_;
+			ie_ptr = pnetwork->network.ies + _FIXED_IE_LENGTH_;
+			total_ielen = pnetwork->network.ie_length - _FIXED_IE_LENGTH_;
 		}
 
 		while (cnt < total_ielen) {
@@ -303,8 +303,8 @@ static char *translate_scan(struct adapter *padapter,
 		ss = padapter->recvpriv.signal_strength;
 		sq = padapter->recvpriv.signal_qual;
 	} else {
-		ss = pnetwork->network.PhyInfo.SignalStrength;
-		sq = pnetwork->network.PhyInfo.SignalQuality;
+		ss = pnetwork->network.phy_info.SignalStrength;
+		sq = pnetwork->network.phy_info.SignalQuality;
 	}
 
 
@@ -683,11 +683,11 @@ static int rtw_wx_get_name(struct net_device *dev,
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
 		/* parsing HT_CAP_IE */
-		p = rtw_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY, &ht_ielen, pcur_bss->IELength-12);
+		p = rtw_get_ie(&pcur_bss->ies[12], WLAN_EID_HT_CAPABILITY, &ht_ielen, pcur_bss->ie_length-12);
 		if (p && ht_ielen > 0)
 			ht_cap = true;
 
-		prates = &pcur_bss->SupportedRates;
+		prates = &pcur_bss->supported_rates;
 
 		if (rtw_is_cckratesonly_included((u8 *)prates)) {
 			if (ht_cap)
@@ -700,7 +700,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bg");
 		} else {
-			if (pcur_bss->Configuration.DSConfig <= 14) {
+			if (pcur_bss->configuration.DSConfig <= 14) {
 				if (ht_cap)
 					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
 				else
@@ -708,7 +708,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 			}
 		}
 	} else {
-		/* prates = &padapter->registrypriv.dev_network.SupportedRates; */
+		/* prates = &padapter->registrypriv.dev_network.supported_rates; */
 		/* snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11g"); */
 		snprintf(wrqu->name, IFNAMSIZ, "unassociated");
 	}
@@ -731,10 +731,10 @@ static int rtw_wx_get_freq(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
-		/* wrqu->freq.m = ieee80211_wlan_frequencies[pcur_bss->Configuration.DSConfig-1] * 100000; */
-		wrqu->freq.m = rtw_ch2freq(pcur_bss->Configuration.DSConfig) * 100000;
+		/* wrqu->freq.m = ieee80211_wlan_frequencies[pcur_bss->configuration.DSConfig-1] * 100000; */
+		wrqu->freq.m = rtw_ch2freq(pcur_bss->configuration.DSConfig) * 100000;
 		wrqu->freq.e = 1;
-		wrqu->freq.i = pcur_bss->Configuration.DSConfig;
+		wrqu->freq.i = pcur_bss->configuration.DSConfig;
 
 	} else {
 		wrqu->freq.m = rtw_ch2freq(padapter->mlmeextpriv.cur_channel) * 100000;
@@ -1044,12 +1044,12 @@ static int rtw_wx_set_wap(struct net_device *dev,
 		pnetwork = list_entry(pmlmepriv->pscanned,
 				      struct wlan_network, list);
 
-		dst_bssid = pnetwork->network.MacAddress;
+		dst_bssid = pnetwork->network.mac_address;
 
 		src_bssid = temp->sa_data;
 
 		if ((!memcmp(dst_bssid, src_bssid, ETH_ALEN))) {
-			if (!rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.InfrastructureMode)) {
+			if (!rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.infrastructure_mode)) {
 				ret = -1;
 				spin_unlock_bh(&queue->lock);
 				goto exit;
@@ -1090,7 +1090,7 @@ static int rtw_wx_get_wap(struct net_device *dev,
 	if  (((check_fwstate(pmlmepriv, _FW_LINKED)) == true) ||
 			((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) ||
 			((check_fwstate(pmlmepriv, WIFI_AP_STATE)) == true)) {
-		memcpy(wrqu->ap_addr.sa_data, pcur_bss->MacAddress, ETH_ALEN);
+		memcpy(wrqu->ap_addr.sa_data, pcur_bss->mac_address, ETH_ALEN);
 	} else {
 		eth_zero_addr(wrqu->ap_addr.sa_data);
 	}
@@ -1290,8 +1290,8 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
-		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.Configuration.DSConfig) >= 0
-			&& true == rtw_validate_ssid(&(pnetwork->network.Ssid))) {
+		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.configuration.DSConfig) >= 0
+			&& true == rtw_validate_ssid(&(pnetwork->network.ssid))) {
 
 			ev = translate_scan(padapter, a, pnetwork, ev, stop);
 		}
@@ -1365,16 +1365,16 @@ static int rtw_wx_set_essid(struct net_device *dev,
 			pnetwork = list_entry(pmlmepriv->pscanned,
 					      struct wlan_network, list);
 
-			dst_ssid = pnetwork->network.Ssid.Ssid;
+			dst_ssid = pnetwork->network.ssid.Ssid;
 
 			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength)) &&
-				(pnetwork->network.Ssid.SsidLength == ndis_ssid.SsidLength)) {
+				(pnetwork->network.ssid.SsidLength == ndis_ssid.SsidLength)) {
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
-					if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
+					if (pnetwork->network.infrastructure_mode != pmlmepriv->cur_network.network.infrastructure_mode)
 						continue;
 				}
 
-				if (rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.InfrastructureMode) == false) {
+				if (rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.infrastructure_mode) == false) {
 					ret = -1;
 					spin_unlock_bh(&queue->lock);
 					goto exit;
@@ -1410,11 +1410,11 @@ static int rtw_wx_get_essid(struct net_device *dev,
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) ||
 	      (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
-		len = pcur_bss->Ssid.SsidLength;
+		len = pcur_bss->ssid.SsidLength;
 
 		wrqu->essid.length = len;
 
-		memcpy(extra, pcur_bss->Ssid.Ssid, len);
+		memcpy(extra, pcur_bss->ssid.Ssid, len);
 
 		wrqu->essid.flags = 1;
 	} else {
@@ -2229,15 +2229,15 @@ static int rtw_get_ap_info(struct net_device *dev,
 		}
 
 
-		if (!memcmp(bssid, pnetwork->network.MacAddress, ETH_ALEN)) { /* BSSID match, then check if supporting wpa/wpa2 */
+		if (!memcmp(bssid, pnetwork->network.mac_address, ETH_ALEN)) { /* BSSID match, then check if supporting wpa/wpa2 */
 
-			pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+			pbuf = rtw_get_wpa_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 			if (pbuf && (wpa_ielen > 0)) {
 				pdata->flags = 1;
 				break;
 			}
 
-			pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+			pbuf = rtw_get_wpa2_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 			if (pbuf && (wpa_ielen > 0)) {
 				pdata->flags = 2;
 				break;
@@ -2473,7 +2473,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			}
 			break;
 		case 0x7a:
-			receive_disconnect(padapter, pmlmeinfo->network.MacAddress
+			receive_disconnect(padapter, pmlmeinfo->network.mac_address
 				, WLAN_REASON_EXPIRATION_CHK);
 			break;
 		case 0x7F:
@@ -3530,10 +3530,10 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 		memcpy(ssid, ssid_ie+2, ssid_len);
 		ssid[ssid_len] = 0x0;
 
-		memcpy(pbss_network->Ssid.Ssid, (void *)ssid, ssid_len);
-		pbss_network->Ssid.SsidLength = ssid_len;
-		memcpy(pbss_network_ext->Ssid.Ssid, (void *)ssid, ssid_len);
-		pbss_network_ext->Ssid.SsidLength = ssid_len;
+		memcpy(pbss_network->ssid.Ssid, (void *)ssid, ssid_len);
+		pbss_network->ssid.SsidLength = ssid_len;
+		memcpy(pbss_network_ext->ssid.Ssid, (void *)ssid, ssid_len);
+		pbss_network_ext->ssid.SsidLength = ssid_len;
 	}
 
 	return ret;
-- 
2.20.1

