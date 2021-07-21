Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199873D0FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbhGUNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbhGUM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3120BC0613DF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t3so2422858edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q+8kfco6Sx5RnpXGm/HAFJeuFF+eOcheQOuZccM+kuk=;
        b=D9OoS/QGcjoNiwu/SxD0G9arugxH/ee+BacLin95OIvGuRQYMhoYszg0vacavIb51N
         re+jrUYO30emXIl+am/5ahzRCBKJa69dZjue9Lat9YrGEr7/dFuRr13ry19eOwXbmo+W
         kShcMzUOMARqhTma+C/3sMyU25eDuGJq+rPlyMZ6bh7aGjk4NKNYirWgqCps+epeelUm
         nnEDRlyQteW7axhtpnzZndMhnfpZ+CNpe4tNnypqpJLRTHcc46c2oJMT0D7hheJqftU7
         X5asUe1Lgm1GG1eNgr28e1K9aH73VyGzCmozlMKyLaFLzjF+lvDLF5fQ0elDoMDnFXvO
         Jt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+8kfco6Sx5RnpXGm/HAFJeuFF+eOcheQOuZccM+kuk=;
        b=sMkeiAU4Xwya4ttRrJe1xSbL1i75dbgiFVNGE57hDTTxkkU2yHAPRRV8nXbKRxFjmZ
         RZRtXSHFmG+4/7adpqe3/LAehkBs4vBtKD6bG7MuVhqhEtSkdPSxzerpLzJI0kuVzMLR
         vPtiXNsX+3k6qJHkshoqyiMNJDLvkiIdoLPnC2uOUmi50Uoagds6NBb1HiPu/O5uP5HC
         zFL/jfSykNuoFrM8ovPmI/9vfwTWvDqeFu/j851t/RrVeVx77rzqANMabTIYTQQaZ2jg
         Eq1ZXxAVs9+pa4kDf1KJPJHZcCvot7NavQ53qSOMR1lHzybMsgcTkegh054QSQvTJ8DQ
         FGTA==
X-Gm-Message-State: AOAM533wZiZYLZCZLplbIK7S2HqcmT7wemGMLfkZR9oy3u9NP9F3Rkzq
        RnjPk4GRQqs7CizxNt4Xg2bqODmDvcA=
X-Google-Smtp-Source: ABdhPJy9U+wXpWXrnJzkf039nqmRTpW8Un3eOGvvAnSVIWkXt0UGQWMrkWQtNPbPu20Jn1eycLN17w==
X-Received: by 2002:a05:6402:48f:: with SMTP id k15mr47923985edv.262.1626874657593;
        Wed, 21 Jul 2021 06:37:37 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id ba25sm10714141edb.1.2021.07.21.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] staging: rtl8723bs: fix camel case in struct ndis_802_11_conf
Date:   Wed, 21 Jul 2021 15:37:15 +0200
Message-Id: <90317df66de1476515bf46477ac097a73f35cf81.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case in struct ndis_802_11_conf

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 18 +++++-----
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  6 ++--
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  6 ++--
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 20 +++++------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 34 +++++++++----------
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  2 +-
 .../staging/rtl8723bs/include/wlan_bssdef.h   | 10 +++---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 10 +++---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 20 +++++------
 9 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 6adefdbb7407..f821863c845d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -340,7 +340,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 
 	shortGIrate = query_ra_short_GI(psta);
 
-	if (pcur_network->configuration.DSConfig > 14) {
+	if (pcur_network->configuration.ds_config > 14) {
 		sta_band |= WIRELESS_INVALID;
 	} else {
 		if (tx_ra_bitmap & 0xffff000)
@@ -400,13 +400,13 @@ void update_bmc_sta(struct adapter *padapter)
 		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
 		network_type = rtw_check_network_type((u8 *)&pcur_network->supported_rates,
 						      supportRateNum,
-						      pcur_network->configuration.DSConfig
+						      pcur_network->configuration.ds_config
 		);
 		if (is_supported_tx_cck(network_type)) {
 			network_type = WIRELESS_11B;
 		} else if (network_type == WIRELESS_INVALID) { /*  error handling */
 
-			if (pcur_network->configuration.DSConfig > 14)
+			if (pcur_network->configuration.ds_config > 14)
 				network_type = WIRELESS_INVALID;
 			else
 				network_type = WIRELESS_11B;
@@ -656,8 +656,8 @@ void start_bss_network(struct adapter *padapter)
 	struct HT_info_element *pht_info = NULL;
 	u8 cbw40_enable = 0;
 
-	bcn_interval = (u16)pnetwork->configuration.BeaconPeriod;
-	cur_channel = pnetwork->configuration.DSConfig;
+	bcn_interval = (u16)pnetwork->configuration.beacon_period;
+	cur_channel = pnetwork->configuration.ds_config;
 	cur_bwmode = CHANNEL_WIDTH_20;
 	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
@@ -850,8 +850,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	/* beacon interval */
 	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
-	/* pbss_network->configuration.BeaconPeriod = le16_to_cpu(*(unsigned short*)p); */
-	pbss_network->configuration.BeaconPeriod = get_unaligned_le16(p);
+	/* pbss_network->configuration.beacon_period = le16_to_cpu(*(unsigned short*)p); */
+	pbss_network->configuration.beacon_period = get_unaligned_le16(p);
 
 	/* capability */
 	/* cap = *(unsigned short *)rtw_get_capability_from_ie(ie); */
@@ -873,7 +873,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	/* channel */
 	channel = 0;
-	pbss_network->configuration.Length = 0;
+	pbss_network->configuration.length = 0;
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_DS_PARAMS, &ie_len,
@@ -882,7 +882,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	if (p && ie_len > 0)
 		channel = *(p + 2);
 
-	pbss_network->configuration.DSConfig = channel;
+	pbss_network->configuration.ds_config = channel;
 
 	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
 	/*  get supported rates */
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 865b42699335..33d8ca8be08e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -810,7 +810,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 			/* rtw_restructure_ht_ie */
 			rtw_restructure_ht_ie(padapter, &pnetwork->network.ies[12], &psecnetwork->ies[0],
 									pnetwork->network.ie_length-12, &psecnetwork->ie_length,
-									pnetwork->network.configuration.DSConfig);
+									pnetwork->network.configuration.ds_config);
 		}
 	}
 
@@ -2004,8 +2004,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		/*  copy pdev_network information to	pmlmepriv->cur_network */
 		memcpy(&tgt_network->network, pnetwork, (get_wlan_bssid_ex_sz(pnetwork)));
 
-		/*  reset DSConfig */
-		/* tgt_network->network.configuration.DSConfig = (u32)rtw_ch2freq(pnetwork->configuration.DSConfig); */
+		/*  reset ds_config */
+		/* tgt_network->network.configuration.ds_config = (u32)rtw_ch2freq(pnetwork->configuration.ds_config); */
 
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index fb15c9531ba8..b133c3738dc9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -298,7 +298,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	ie += sz;
 
 	/* beacon interval : 2bytes */
-	*(__le16 *)ie = cpu_to_le16((u16)pdev_network->configuration.BeaconPeriod);/* BCN_INTERVAL; */
+	*(__le16 *)ie = cpu_to_le16((u16)pdev_network->configuration.beacon_period);/* BCN_INTERVAL; */
 	sz += 2;
 	ie += 2;
 
@@ -334,11 +334,11 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	}
 
 	/* DS parameter set */
-	ie = rtw_set_ie(ie, WLAN_EID_DS_PARAMS, 1, (u8 *)&(pdev_network->configuration.DSConfig), &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_DS_PARAMS, 1, (u8 *)&(pdev_network->configuration.ds_config), &sz);
 
 	/* IBSS Parameter Set */
 
-	ie = rtw_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2, (u8 *)&(pdev_network->configuration.ATIMWindow), &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2, (u8 *)&(pdev_network->configuration.atim_window), &sz);
 
 	if (rateLen > 8) {
 		ie = rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pdev_network->supported_rates + 8), &sz);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index c994f6335bdc..f189cd6c11ac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -396,7 +396,7 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 	d_cap = le16_to_cpu(tmpd);
 
 	return (src->ssid.SsidLength == dst->ssid.SsidLength) &&
-		/* 	(src->configuration.DSConfig == dst->configuration.DSConfig) && */
+		/* 	(src->configuration.ds_config == dst->configuration.ds_config) && */
 			((!memcmp(src->mac_address, dst->mac_address, ETH_ALEN))) &&
 			((!memcmp(src->ssid.Ssid, dst->ssid.Ssid, src->ssid.SsidLength))) &&
 			((s_cap & WLAN_CAPABILITY_IBSS) ==
@@ -1148,7 +1148,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
 									(cur_network->network.ie_length));
 
-	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.DSConfig);
+	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.ds_config);
 }
 
 /* Notes: the function could be > passive_level (the same context as Rx tasklet) */
@@ -2152,12 +2152,12 @@ void rtw_init_registrypriv_dev_network(struct adapter *adapter)
 
 	memcpy(&pdev_network->ssid, &pregistrypriv->ssid, sizeof(struct ndis_802_11_ssid));
 
-	pdev_network->configuration.Length = sizeof(struct ndis_802_11_conf);
-	pdev_network->configuration.BeaconPeriod = 100;
-	pdev_network->configuration.FHConfig.Length = 0;
-	pdev_network->configuration.FHConfig.HopPattern = 0;
-	pdev_network->configuration.FHConfig.HopSet = 0;
-	pdev_network->configuration.FHConfig.DwellTime = 0;
+	pdev_network->configuration.length = sizeof(struct ndis_802_11_conf);
+	pdev_network->configuration.beacon_period = 100;
+	pdev_network->configuration.fh_config.Length = 0;
+	pdev_network->configuration.fh_config.HopPattern = 0;
+	pdev_network->configuration.fh_config.HopSet = 0;
+	pdev_network->configuration.fh_config.DwellTime = 0;
 }
 
 void rtw_update_registrypriv_dev_network(struct adapter *adapter)
@@ -2189,10 +2189,10 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 		break;
 	}
 
-	pdev_network->configuration.DSConfig = (pregistrypriv->channel);
+	pdev_network->configuration.ds_config = (pregistrypriv->channel);
 
 	if (cur_network->network.infrastructure_mode == Ndis802_11IBSS)
-		pdev_network->configuration.ATIMWindow = (0);
+		pdev_network->configuration.atim_window = (0);
 
 	pdev_network->infrastructure_mode = (cur_network->network.infrastructure_mode);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index e22301c01f40..537b60f7b7db 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2237,7 +2237,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->supported_rates, &pattrib->pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->configuration.DSConfig), &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->configuration.ds_config), &pattrib->pktlen);
 
 	/* if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) */
 	{
@@ -2440,7 +2440,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->supported_rates, &pattrib->pktlen);
 
 		/*  DS parameter set */
-		pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->configuration.DSConfig), &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->configuration.ds_config), &pattrib->pktlen);
 
 		if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 			u8 erpinfo = 0;
@@ -3708,10 +3708,10 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 			p = rtw_get_ie(pbss_network->ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, pbss_network->ie_length - _FIXED_IE_LENGTH_);
 			if ((p == NULL) || (len == 0)) {/* non-HT */
 
-				if (pbss_network->configuration.DSConfig <= 0)
+				if (pbss_network->configuration.ds_config <= 0)
 					continue;
 
-				ICS[0][pbss_network->configuration.DSConfig] = 1;
+				ICS[0][pbss_network->configuration.ds_config] = 1;
 
 				if (ICS[0][0] == 0)
 					ICS[0][0] = 1;
@@ -4038,14 +4038,14 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	if (bssid->ie_length < 12)
 		return _FAIL;
 
-	/*  Checking for DSConfig */
+	/*  Checking for ds_config */
 	p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_DS_PARAMS, &len, bssid->ie_length - ie_offset);
 
-	bssid->configuration.DSConfig = 0;
-	bssid->configuration.Length = 0;
+	bssid->configuration.ds_config = 0;
+	bssid->configuration.length = 0;
 
 	if (p) {
-		bssid->configuration.DSConfig = *(p + 2);
+		bssid->configuration.ds_config = *(p + 2);
 	} else {
 		/*  In 5G, some ap do not have DSSET IE */
 		/*  checking HT info for channel */
@@ -4053,14 +4053,14 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 		if (p) {
 			struct HT_info_element *HT_info = (struct HT_info_element *)(p + 2);
 
-			bssid->configuration.DSConfig = HT_info->primary_channel;
+			bssid->configuration.ds_config = HT_info->primary_channel;
 		} else { /*  use current channel */
-			bssid->configuration.DSConfig = rtw_get_oper_ch(padapter);
+			bssid->configuration.ds_config = rtw_get_oper_ch(padapter);
 		}
 	}
 
 	memcpy(&le32_tmp, rtw_get_beacon_interval_from_ie(bssid->ies), 2);
-	bssid->configuration.BeaconPeriod = le32_to_cpu(le32_tmp);
+	bssid->configuration.beacon_period = le32_to_cpu(le32_tmp);
 
 	val16 = rtw_get_capability((struct wlan_bssid_ex *)bssid);
 
@@ -4077,7 +4077,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	else
 		bssid->privacy = 0;
 
-	bssid->configuration.ATIMWindow = 0;
+	bssid->configuration.atim_window = 0;
 
 	/* 20/40 BSS Coexistence check */
 	if ((pregistrypriv->wifi_spec == 1) && (false == pmlmeinfo->bwmode_updated)) {
@@ -4096,7 +4096,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	}
 
 	/*  mark bss info receiving from nearby channel as SignalQuality 101 */
-	if (bssid->configuration.DSConfig != rtw_get_oper_ch(padapter))
+	if (bssid->configuration.ds_config != rtw_get_oper_ch(padapter))
 		bssid->phy_info.SignalQuality = 101;
 
 	return _SUCCESS;
@@ -4111,7 +4111,7 @@ void start_create_ibss(struct adapter *padapter)
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 
-	pmlmeext->cur_channel = (u8)pnetwork->configuration.DSConfig;
+	pmlmeext->cur_channel = (u8)pnetwork->configuration.ds_config;
 	pmlmeinfo->bcn_interval = get_beacon_interval(pnetwork);
 
 	/* update wireless mode */
@@ -4409,7 +4409,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 	}
 
 	/*  If channel is used by AP, set channel scan type to active */
-	channel = bssid->configuration.DSConfig;
+	channel = bssid->configuration.ds_config;
 	chplan_new = pmlmeext->channel_set;
 	i = 0;
 	while ((i < MAX_CHANNEL_NUM) && (chplan_new[i].ChannelNum != 0)) {
@@ -5401,7 +5401,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	memcpy(pnetwork->ies, ((struct wlan_bssid_ex *)pbuf)->ies, pnetwork->ie_length);
 
-	pmlmeext->cur_channel = (u8)pnetwork->configuration.DSConfig;
+	pmlmeext->cur_channel = (u8)pnetwork->configuration.ds_config;
 	pmlmeinfo->bcn_interval = get_beacon_interval(pnetwork);
 
 	/* Check AP vendor to move rtw_joinbss_cmd() */
@@ -5428,7 +5428,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 			{
 				struct HT_info_element *pht_info = (struct HT_info_element *)(pIE->data);
 
-				if (pnetwork->configuration.DSConfig <= 14) {
+				if (pnetwork->configuration.ds_config <= 14) {
 					if ((pregpriv->bw_mode & 0x0f) > CHANNEL_WIDTH_20)
 						cbw40_enable = 1;
 				}
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 772760f34fd8..2e68ed841f6d 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -164,7 +164,7 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->supported_rates, &pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->configuration.DSConfig), &pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->configuration.ds_config), &pktlen);
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 		u32 ATIMWindow;
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index 891bd2fca652..6bdda580cef5 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -44,11 +44,11 @@ struct ndis_802_11_conf_fh {
 	ODI Handler will convert the channel number to freq. number.
 */
 struct ndis_802_11_conf {
-	u32 Length;             /*  Length of structure */
-	u32 BeaconPeriod;       /*  units are Kusec */
-	u32 ATIMWindow;         /*  units are Kusec */
-	u32 DSConfig;           /*  Frequency, units are kHz */
-	struct ndis_802_11_conf_fh    FHConfig;
+	u32 length;             /*  Length of structure */
+	u32 beacon_period;       /*  units are Kusec */
+	u32 atim_window;         /*  units are Kusec */
+	u32 ds_config;           /*  Frequency, units are kHz */
+	struct ndis_802_11_conf_fh    fh_config;
 };
 
 enum ndis_802_11_network_infrastructure {
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 015f68553164..4e6eba240161 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -278,7 +278,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	/* spin_unlock_bh(&pwdev_priv->scan_req_lock); */
 
 
-	channel = pnetwork->network.configuration.DSConfig;
+	channel = pnetwork->network.configuration.ds_config;
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
 
 	notify_channel = ieee80211_get_channel(wiphy, freq);
@@ -355,7 +355,7 @@ int rtw_cfg80211_check_bss(struct adapter *padapter)
 	if (!(pnetwork) || !(padapter->rtw_wdev))
 		return false;
 
-	freq = rtw_ieee80211_channel_to_frequency(pnetwork->configuration.DSConfig, NL80211_BAND_2GHZ);
+	freq = rtw_ieee80211_channel_to_frequency(pnetwork->configuration.ds_config, NL80211_BAND_2GHZ);
 
 	notify_channel = ieee80211_get_channel(padapter->rtw_wdev->wiphy, freq);
 	bss = cfg80211_get_bss(padapter->rtw_wdev->wiphy, notify_channel,
@@ -374,7 +374,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 	struct wireless_dev *pwdev = padapter->rtw_wdev;
 	struct wiphy *wiphy = pwdev->wiphy;
-	int freq = (int)cur_network->network.configuration.DSConfig;
+	int freq = (int)cur_network->network.configuration.ds_config;
 	struct ieee80211_channel *chan;
 
 	if (pwdev->iftype != NL80211_IFTYPE_ADHOC)
@@ -458,7 +458,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		struct wiphy *wiphy = pwdev->wiphy;
 		struct ieee80211_channel *notify_channel;
 		u32 freq;
-		u16 channel = cur_network->network.configuration.DSConfig;
+		u16 channel = cur_network->network.configuration.ds_config;
 		struct cfg80211_roam_info roam_info = {};
 
 		freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
@@ -1266,7 +1266,7 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
-		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.configuration.DSConfig) >= 0
+		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.configuration.ds_config) >= 0
 			&& true == rtw_validate_ssid(&(pnetwork->network.ssid))
 		)
 		{
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index bda02f4f74db..f3e447023a2d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -129,7 +129,7 @@ static char *translate_scan(struct adapter *padapter,
 		else
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bg");
 	} else {
-		if (pnetwork->network.configuration.DSConfig <= 14) {
+		if (pnetwork->network.configuration.ds_config <= 14) {
 			if (ht_cap)
 				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
 			else
@@ -159,14 +159,14 @@ static char *translate_scan(struct adapter *padapter,
 		start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_UINT_LEN);
 	}
 
-	if (pnetwork->network.configuration.DSConfig < 1)
-		pnetwork->network.configuration.DSConfig = 1;
+	if (pnetwork->network.configuration.ds_config < 1)
+		pnetwork->network.configuration.ds_config = 1;
 
 	 /* Add frequency/channel */
 	iwe.cmd = SIOCGIWFREQ;
-	iwe.u.freq.m = rtw_ch2freq(pnetwork->network.configuration.DSConfig) * 100000;
+	iwe.u.freq.m = rtw_ch2freq(pnetwork->network.configuration.ds_config) * 100000;
 	iwe.u.freq.e = 1;
-	iwe.u.freq.i = pnetwork->network.configuration.DSConfig;
+	iwe.u.freq.i = pnetwork->network.configuration.ds_config;
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_FREQ_LEN);
 
 	/* Add encryption capability */
@@ -700,7 +700,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bg");
 		} else {
-			if (pcur_bss->configuration.DSConfig <= 14) {
+			if (pcur_bss->configuration.ds_config <= 14) {
 				if (ht_cap)
 					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
 				else
@@ -731,10 +731,10 @@ static int rtw_wx_get_freq(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
-		/* wrqu->freq.m = ieee80211_wlan_frequencies[pcur_bss->configuration.DSConfig-1] * 100000; */
-		wrqu->freq.m = rtw_ch2freq(pcur_bss->configuration.DSConfig) * 100000;
+		/* wrqu->freq.m = ieee80211_wlan_frequencies[pcur_bss->configuration.ds_config-1] * 100000; */
+		wrqu->freq.m = rtw_ch2freq(pcur_bss->configuration.ds_config) * 100000;
 		wrqu->freq.e = 1;
-		wrqu->freq.i = pcur_bss->configuration.DSConfig;
+		wrqu->freq.i = pcur_bss->configuration.ds_config;
 
 	} else {
 		wrqu->freq.m = rtw_ch2freq(padapter->mlmeextpriv.cur_channel) * 100000;
@@ -1290,7 +1290,7 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
-		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.configuration.DSConfig) >= 0
+		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.configuration.ds_config) >= 0
 			&& true == rtw_validate_ssid(&(pnetwork->network.ssid))) {
 
 			ev = translate_scan(padapter, a, pnetwork, ev, stop);
-- 
2.20.1

