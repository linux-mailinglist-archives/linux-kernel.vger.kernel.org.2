Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A3E410C33
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhISPjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 11:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhISPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 11:39:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8E7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x6so24077881wrv.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0L295XzzxicSis3hHCbuoGaSPBpD9P4eB6cONLB2TYg=;
        b=lKnHCSrRAIWRVSpG+wiziA7LxKpEpRjpRB7bUdAqVxJOFHrDZuEuwcYGXaU/o5ry4j
         rJeXNy4beb9WqURPrTj2eOH1PK3JRnoMvrJCXpp2Rtt2aXsYLPOpnCfFki/pFuMkT6ol
         L9ouIWHrlWlqDVMcMeSL1xtFKMBI6ZuRE72RRijtU4qPgwFhjF8Wn8U8Kq3tvh5kmG1H
         kGetskgZ9FdRzlutWLp5Wb73Gx+WgB5BpEFGKcOvy3Gsseon3FLczIRwKBSkvaQZz51I
         ZvUu7lQ6VDH2iQ/atYJezZaZMz3c7gAdXxeRe394VRnHkPG77GLdDrUcAN8FvlxVu++6
         /toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0L295XzzxicSis3hHCbuoGaSPBpD9P4eB6cONLB2TYg=;
        b=sNoJt8QzcJtFPxXsC/wD4qrPpJ6rvJlSBy2C66sVYUy2FeAQIP/yo6BBSx2SlGuPOF
         peQ/OA1JkwzLpcj5+Mt9pzCOfYvtyAwruWQpB/SknkY/TShaKS+Au4P07oU8b7iG8sjw
         +6meWLnVjhHpWNHitKKSC2qdftZplIXMYyjfDxqL4GTl5ZZzTpOZ+5CGQzQma/nTv5Uz
         rRp3A41DoCZIngVMqn4hZQJdCu+hg8HOrwdb/uiPN/xb1n64sW9tf7IW9G+SXezhwfpe
         TPvN2xqXPGYU9s8r2smKKFI+fbSmP7j/Ye3ynB0+pFUOiGgDNucr7fcudPVD5qrIi7Qz
         mD2A==
X-Gm-Message-State: AOAM533bM6jHAjB620G2vArHdKu41kOH5qtmu1wdYARlJwwn9kHvD1lw
        B5ngJ9egkUpkxzoEsL9UQSw=
X-Google-Smtp-Source: ABdhPJx2jHrro6D8QtzONzME8dd44hO4JS6h/F8Fq2cqdjkyrUXQTplxerguqviKu1y8eMEyNMsjyw==
X-Received: by 2002:a5d:5246:: with SMTP id k6mr23077202wrc.431.1632065861762;
        Sun, 19 Sep 2021 08:37:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id l15sm16614501wme.42.2021.09.19.08.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 08:37:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: r8188eu: remove rtw_check_beacon_data()
Date:   Sun, 19 Sep 2021 17:36:58 +0200
Message-Id: <20210919153659.20826-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919153659.20826-1-straube.linux@gmail.com>
References: <20210919153659.20826-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_check_beacon_data() is not used, remove it.
It is the only user of start_bss_network() which is the only user
of update_hw_ht_param(). Remove these two functions as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c    | 428 -----------------------
 drivers/staging/r8188eu/include/rtw_ap.h |   1 -
 2 files changed, 429 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 4f4ec4528016..49858adf486e 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -557,434 +557,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 	spin_unlock_bh(&psta->lock);
 }
 
-static void update_hw_ht_param(struct adapter *padapter)
-{
-	unsigned char		max_AMPDU_len;
-	unsigned char		min_MPDU_spacing;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-
-	DBG_88E("%s\n", __func__);
-
-	/* handle A-MPDU parameter field */
-	/*
-		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
-		AMPDU_para [4:2]:Min MPDU Start Spacing
-	*/
-	max_AMPDU_len = pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x03;
-
-	min_MPDU_spacing = (pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c) >> 2;
-
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, (u8 *)(&min_MPDU_spacing));
-
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, (u8 *)(&max_AMPDU_len));
-
-	/*  */
-	/*  Config SM Power Save setting */
-	/*  */
-	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & 0x0C) >> 2;
-	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		DBG_88E("%s(): WLAN_HT_CAP_SM_PS_STATIC\n", __func__);
-}
-
-static void start_bss_network(struct adapter *padapter, u8 *pbuf)
-{
-	u8 *p;
-	u8 val8, cur_channel, cur_bwmode, cur_ch_offset;
-	u16 bcn_interval;
-	u32	acparm;
-	int	ie_len;
-	struct registry_priv	 *pregpriv = &padapter->registrypriv;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
-	struct HT_info_element *pht_info = NULL;
-	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
-
-	bcn_interval = (u16)pnetwork->Configuration.BeaconPeriod;
-	cur_channel = pnetwork->Configuration.DSConfig;
-	cur_bwmode = HT_CHANNEL_WIDTH_20;
-	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
-
-	/* check if there is wps ie, */
-	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
-	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
-	if (!rtw_get_wps_ie(pnetwork->IEs + _FIXED_IE_LENGTH_, pnetwork->IELength - _FIXED_IE_LENGTH_, NULL, NULL))
-		pmlmeext->bstart_bss = true;
-
-	/* todo: update wmm, ht cap */
-	if (pmlmepriv->qospriv.qos_option)
-		pmlmeinfo->WMM_enable = true;
-	if (pmlmepriv->htpriv.ht_option) {
-		pmlmeinfo->WMM_enable = true;
-		pmlmeinfo->HT_enable = true;
-
-		update_hw_ht_param(padapter);
-	}
-
-	if (pmlmepriv->cur_network.join_res != true) { /* setting only at  first time */
-		/* WEP Key will be set before this function, do not clear CAM. */
-		if ((psecuritypriv->dot11PrivacyAlgrthm != _WEP40_) &&
-		    (psecuritypriv->dot11PrivacyAlgrthm != _WEP104_))
-			flush_all_cam_entry(padapter);	/* clear CAM */
-	}
-
-	/* set MSR to AP_Mode */
-	Set_MSR(padapter, _HW_STATE_AP_);
-
-	/* Set BSSID REG */
-	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pnetwork->MacAddress);
-
-	/* Set EDCA param reg */
-	acparm = 0x002F3217; /*  VO */
-	rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_VO, (u8 *)(&acparm));
-	acparm = 0x005E4317; /*  VI */
-	rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_VI, (u8 *)(&acparm));
-	acparm = 0x005ea42b;
-	rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_BE, (u8 *)(&acparm));
-	acparm = 0x0000A444; /*  BK */
-	rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_BK, (u8 *)(&acparm));
-
-	/* Set Security */
-	val8 = (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) ? 0xcc : 0xcf;
-	rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
-
-	/* Beacon Control related register */
-	rtw_hal_set_hwreg(padapter, HW_VAR_BEACON_INTERVAL, (u8 *)(&bcn_interval));
-
-	UpdateBrateTbl(padapter, pnetwork->SupportedRates);
-	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->SupportedRates);
-
-	if (!pmlmepriv->cur_network.join_res) { /* setting only at  first time */
-		/* turn on all dynamic functions */
-		Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
-	}
-	/* set channel, bwmode */
-	p = rtw_get_ie((pnetwork->IEs + sizeof(struct ndis_802_11_fixed_ie)), _HT_ADD_INFO_IE_, &ie_len, (pnetwork->IELength - sizeof(struct ndis_802_11_fixed_ie)));
-	if (p && ie_len) {
-		pht_info = (struct HT_info_element *)(p + 2);
-
-		if ((pregpriv->cbw40_enable) &&	 (pht_info->infos[0] & BIT(2))) {
-			/* switch to the 40M Hz mode */
-			cur_bwmode = HT_CHANNEL_WIDTH_40;
-			switch (pht_info->infos[0] & 0x3) {
-			case 1:
-				cur_ch_offset = HAL_PRIME_CHNL_OFFSET_LOWER;
-				break;
-			case 3:
-				cur_ch_offset = HAL_PRIME_CHNL_OFFSET_UPPER;
-				break;
-			default:
-				cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
-				break;
-			}
-		}
-	}
-	/* TODO: need to judge the phy parameters on concurrent mode for single phy */
-	set_channel_bwmode(padapter, cur_channel, cur_ch_offset, cur_bwmode);
-
-	DBG_88E("CH =%d, BW =%d, offset =%d\n", cur_channel, cur_bwmode, cur_ch_offset);
-
-	/*  */
-	pmlmeext->cur_channel = cur_channel;
-	pmlmeext->cur_bwmode = cur_bwmode;
-	pmlmeext->cur_ch_offset = cur_ch_offset;
-	pmlmeext->cur_wireless_mode = pmlmepriv->cur_network.network_type;
-
-	/* update cur_wireless_mode */
-	update_wireless_mode(padapter);
-
-	/* udpate capability after cur_wireless_mode updated */
-	update_capinfo(padapter, rtw_get_capability((struct wlan_bssid_ex *)pnetwork));
-
-	/* let pnetwork_mlmeext == pnetwork_mlme. */
-	memcpy(pnetwork_mlmeext, pnetwork, pnetwork->Length);
-
-	memcpy(pwdinfo->p2p_group_ssid, pnetwork->Ssid.Ssid, pnetwork->Ssid.SsidLength);
-	pwdinfo->p2p_group_ssid_len = pnetwork->Ssid.SsidLength;
-
-	if (pmlmeext->bstart_bss) {
-		update_beacon(padapter, _TIM_IE_, NULL, false);
-
-		/* issue beacon frame */
-		if (send_beacon(padapter) == _FAIL)
-			DBG_88E("issue_beacon, fail!\n");
-	}
-
-	/* update bc/mc sta_info */
-	update_bmc_sta(padapter);
-}
-
-int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
-{
-	int ret = _SUCCESS;
-	u8 *p;
-	u8 *pHT_caps_ie = NULL;
-	u8 *pHT_info_ie = NULL;
-	struct sta_info *psta = NULL;
-	u16 cap, ht_cap = false;
-	uint ie_len = 0;
-	int group_cipher, pairwise_cipher;
-	u8	channel, network_type, supportRate[NDIS_802_11_LENGTH_RATES_EX];
-	int supportRateNum = 0;
-	u8 OUI1[] = {0x00, 0x50, 0xf2, 0x01};
-	u8 WMM_PARA_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
-	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct wlan_bssid_ex *pbss_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
-	u8 *ie = pbss_network->IEs;
-
-	/* SSID */
-	/* Supported rates */
-	/* DS Params */
-	/* WLAN_EID_COUNTRY */
-	/* ERP Information element */
-	/* Extended supported rates */
-	/* WPA/WPA2 */
-	/* Wi-Fi Wireless Multimedia Extensions */
-	/* ht_capab, ht_oper */
-	/* WPS IE */
-
-	DBG_88E("%s, len =%d\n", __func__, len);
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return _FAIL;
-
-	if (len > MAX_IE_SZ)
-		return _FAIL;
-
-	pbss_network->IELength = len;
-
-	memset(ie, 0, MAX_IE_SZ);
-
-	memcpy(ie, pbuf, pbss_network->IELength);
-
-	if (pbss_network->InfrastructureMode != Ndis802_11APMode)
-		return _FAIL;
-
-	pbss_network->Rssi = 0;
-
-	memcpy(pbss_network->MacAddress, myid(&padapter->eeprompriv), ETH_ALEN);
-
-	/* beacon interval */
-	p = rtw_get_beacon_interval_from_ie(ie);/* 8: TimeStamp, 2: Beacon Interval 2:Capability */
-	pbss_network->Configuration.BeaconPeriod = get_unaligned_le16(p);
-
-	/* capability */
-	cap = get_unaligned_le16(ie);
-
-	/* SSID */
-	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _SSID_IE_, &ie_len, (pbss_network->IELength - _BEACON_IE_OFFSET_));
-	if (p && ie_len > 0) {
-		memset(&pbss_network->Ssid, 0, sizeof(struct ndis_802_11_ssid));
-		memcpy(pbss_network->Ssid.Ssid, (p + 2), ie_len);
-		pbss_network->Ssid.SsidLength = ie_len;
-	}
-
-	/* channel */
-	channel = 0;
-	pbss_network->Configuration.Length = 0;
-	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _DSSET_IE_, &ie_len, (pbss_network->IELength - _BEACON_IE_OFFSET_));
-	if (p && ie_len > 0)
-		channel = *(p + 2);
-
-	pbss_network->Configuration.DSConfig = channel;
-
-	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
-	/*  get supported rates */
-	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _SUPPORTEDRATES_IE_, &ie_len, (pbss_network->IELength - _BEACON_IE_OFFSET_));
-	if (p) {
-		memcpy(supportRate, p + 2, ie_len);
-		supportRateNum = ie_len;
-	}
-
-	/* get ext_supported rates */
-	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _EXT_SUPPORTEDRATES_IE_, &ie_len, pbss_network->IELength - _BEACON_IE_OFFSET_);
-	if (p) {
-		memcpy(supportRate + supportRateNum, p + 2, ie_len);
-		supportRateNum += ie_len;
-	}
-
-	network_type = rtw_check_network_type(supportRate, supportRateNum, channel);
-
-	rtw_set_supported_rate(pbss_network->SupportedRates, network_type);
-
-	/* parsing ERP_IE */
-	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _ERPINFO_IE_, &ie_len, (pbss_network->IELength - _BEACON_IE_OFFSET_));
-	if (p && ie_len > 0)
-		ERP_IE_handler(padapter, (struct ndis_802_11_var_ie *)p);
-
-	/* update privacy/security */
-	if (cap & BIT(4))
-		pbss_network->Privacy = 1;
-	else
-		pbss_network->Privacy = 0;
-
-	psecuritypriv->wpa_psk = 0;
-
-	/* wpa2 */
-	group_cipher = 0;
-	pairwise_cipher = 0;
-	psecuritypriv->wpa2_group_cipher = _NO_PRIVACY_;
-	psecuritypriv->wpa2_pairwise_cipher = _NO_PRIVACY_;
-	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _RSN_IE_2_, &ie_len, (pbss_network->IELength - _BEACON_IE_OFFSET_));
-	if (p && ie_len > 0) {
-		if (rtw_parse_wpa2_ie(p, ie_len + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
-			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
-
-			psecuritypriv->dot8021xalg = 1;/* psk,  todo:802.1x */
-			psecuritypriv->wpa_psk |= BIT(1);
-
-			psecuritypriv->wpa2_group_cipher = group_cipher;
-			psecuritypriv->wpa2_pairwise_cipher = pairwise_cipher;
-		}
-	}
-	/* wpa */
-	ie_len = 0;
-	group_cipher = 0;
-	pairwise_cipher = 0;
-	psecuritypriv->wpa_group_cipher = _NO_PRIVACY_;
-	psecuritypriv->wpa_pairwise_cipher = _NO_PRIVACY_;
-	for (p = ie + _BEACON_IE_OFFSET_;; p += (ie_len + 2)) {
-		p = rtw_get_ie(p, _SSN_IE_1_, &ie_len,
-			       (pbss_network->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2)));
-		if ((p) && (!memcmp(p + 2, OUI1, 4))) {
-			if (rtw_parse_wpa_ie(p, ie_len + 2, &group_cipher,
-					     &pairwise_cipher, NULL) == _SUCCESS) {
-				psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
-
-				psecuritypriv->dot8021xalg = 1;/* psk,  todo:802.1x */
-
-				psecuritypriv->wpa_psk |= BIT(0);
-
-				psecuritypriv->wpa_group_cipher = group_cipher;
-				psecuritypriv->wpa_pairwise_cipher = pairwise_cipher;
-			}
-			break;
-		}
-		if (!p || ie_len == 0)
-			break;
-	}
-
-	/* wmm */
-	ie_len = 0;
-	pmlmepriv->qospriv.qos_option = 0;
-	if (pregistrypriv->wmm_enable) {
-		for (p = ie + _BEACON_IE_OFFSET_;; p += (ie_len + 2)) {
-			p = rtw_get_ie(p, _VENDOR_SPECIFIC_IE_, &ie_len,
-				       (pbss_network->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2)));
-			if ((p) && !memcmp(p + 2, WMM_PARA_IE, 6)) {
-				pmlmepriv->qospriv.qos_option = 1;
-
-				*(p + 8) |= BIT(7);/* QoS Info, support U-APSD */
-
-				/* disable all ACM bits since the WMM admission control is not supported */
-				*(p + 10) &= ~BIT(4); /* BE */
-				*(p + 14) &= ~BIT(4); /* BK */
-				*(p + 18) &= ~BIT(4); /* VI */
-				*(p + 22) &= ~BIT(4); /* VO */
-				break;
-			}
-
-			if (!p || ie_len == 0)
-				break;
-		}
-	}
-	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _HT_CAPABILITY_IE_, &ie_len,
-		       (pbss_network->IELength - _BEACON_IE_OFFSET_));
-	if (p && ie_len > 0) {
-		u8 rf_type;
-		struct ieee80211_ht_cap *pht_cap = (struct ieee80211_ht_cap *)(p + 2);
-
-		pHT_caps_ie = p;
-		ht_cap = true;
-		network_type |= WIRELESS_11_24N;
-
-		rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-
-		if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
-		    (psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP))
-			pht_cap->ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_DENSITY & (0x07 << 2));
-		else
-			pht_cap->ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
-
-		/* set  Max Rx AMPDU size  to 64K */
-		pht_cap->ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_FACTOR & 0x03);
-
-		if (rf_type == RF_1T1R) {
-			pht_cap->mcs.rx_mask[0] = 0xff;
-			pht_cap->mcs.rx_mask[1] = 0x0;
-		}
-		memcpy(&pmlmepriv->htpriv.ht_cap, p + 2, ie_len);
-	}
-
-	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _HT_ADD_INFO_IE_, &ie_len,
-		       (pbss_network->IELength - _BEACON_IE_OFFSET_));
-	if (p && ie_len > 0)
-		pHT_info_ie = p;
-	switch (network_type) {
-	case WIRELESS_11B:
-		pbss_network->NetworkTypeInUse = Ndis802_11DS;
-		break;
-	case WIRELESS_11G:
-	case WIRELESS_11BG:
-	case WIRELESS_11G_24N:
-	case WIRELESS_11BG_24N:
-		pbss_network->NetworkTypeInUse = Ndis802_11OFDM24;
-		break;
-	default:
-		pbss_network->NetworkTypeInUse = Ndis802_11OFDM24;
-		break;
-	}
-
-	pmlmepriv->cur_network.network_type = network_type;
-
-	pmlmepriv->htpriv.ht_option = false;
-
-	if ((psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
-	    (psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_TKIP)) {
-		/* todo: */
-		/* ht_cap = false; */
-	}
-
-	/* ht_cap */
-	if (pregistrypriv->ht_enable && ht_cap) {
-		pmlmepriv->htpriv.ht_option = true;
-		pmlmepriv->qospriv.qos_option = 1;
-
-		if (pregistrypriv->ampdu_enable == 1)
-			pmlmepriv->htpriv.ampdu_enable = true;
-		HT_caps_handler(padapter, (struct ndis_802_11_var_ie *)pHT_caps_ie);
-
-		HT_info_handler(padapter, (struct ndis_802_11_var_ie *)pHT_info_ie);
-	}
-
-	pbss_network->Length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pbss_network);
-
-	/* issue beacon to start bss network */
-	start_bss_network(padapter, (u8 *)pbss_network);
-
-	/* alloc sta_info for ap itself */
-	psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->MacAddress);
-	if (!psta) {
-		psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->MacAddress);
-		if (!psta)
-			return _FAIL;
-	}
-
-	/* fix bug of flush_cam_entry at STOP AP mode */
-	psta->state |= WIFI_AP_STATE;
-	rtw_indicate_connect(padapter);
-	pmlmepriv->cur_network.join_res = true;/* for check if already set beacon */
-	return ret;
-}
-
 void rtw_set_macaddr_acl(struct adapter *padapter, int mode)
 {
 	struct sta_priv *pstapriv = &padapter->stapriv;
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
index dac091443ba1..134a9a8143b2 100644
--- a/drivers/staging/r8188eu/include/rtw_ap.h
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -20,7 +20,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta,
 	       u8 rssi_level);
 void expire_timeout_chk(struct adapter *padapter);
 void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta);
-int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len);
 void rtw_ap_restore_network(struct adapter *padapter);
 void rtw_set_macaddr_acl(struct adapter *padapter, int mode);
 
-- 
2.33.0

