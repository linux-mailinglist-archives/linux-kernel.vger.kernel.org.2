Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5744F3E347B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhHGJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhHGJsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BBCC06179A
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b13so14337523wrs.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n4Npye1BANWKhSM6GhTszzmzOCtPoMPSDqIzoGc2WHA=;
        b=FplrmOx7dImmHNTSLDs0WiKkOu1yVPMfOB7IUFudU9842j9sfA+tjUQZXF76kGp+Xx
         9X9mASKyLIqlXNjZRjX7pDYelL5P1ugIXsp7FXEFtqKiNA6chA3lkp2b5CLB6OEqBFH2
         T5sFYSovB0ZL2b+Tm+g0y95mTHYQfMd2jqQZ0SBF9fU6zKMX8V6XDENAB+aasXPgInKn
         lddhNWa0+cgMb6M3Rckj+9jtgOC/5drcqHtXsivk3QpoBzid0os7RWEofNiOpEHyDMic
         bN/f+YOSX1d1cRHtSEt1nTTUpCFwZX0Od57YKwGloTJ+MuTq3XTItJ3RSP2lP98HH1jp
         +q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n4Npye1BANWKhSM6GhTszzmzOCtPoMPSDqIzoGc2WHA=;
        b=GSIyLaE9cqpE+qDMB9feV+exfXbTiCbLqQZ8a8l2QtERK4YG3OMi7/lGZ/5sswQ2xS
         Asfi+8FuP/lEC+w4u2JCAisYD/f6r+zjaEVkSFC06IpohiZaV3uJ1xqHxcQY9omZg1eU
         u8QGtgBl4jX3KLZ1qUDSK8rE7yaGX8HKsfGnKTu+cb6unSyh23uj1Wv14OpCD3JfvKo5
         PQ3KsZgDRc/xgIeCNjujwWwJuc+BHrh3KlXzwyB9L4ABQie6D6t6mmut5prwAdZkyXE3
         EWoHrNIqpVcZ0GH024DAFqEi4XAqCq+iXBcVKGc1M220wnimPnzQ8dUo2F5eLa51uMlC
         Vedg==
X-Gm-Message-State: AOAM531H5NkJRKincLqtr8pLK6bQWG5YREyt5GCYX2ZAzuwzKz2lyPEb
        hbZRhg6owFI+iSXeiikN4TzjlmaFoDc=
X-Google-Smtp-Source: ABdhPJye90ibrA33FdCL/RWis7ESQv6xe1/uWCtCftyR8faasLw/HNC0q5a66hUyF7tGYV0dCa8BhQ==
X-Received: by 2002:adf:f287:: with SMTP id k7mr14725063wro.206.1628329715328;
        Sat, 07 Aug 2021 02:48:35 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id r8sm1495012wrj.11.2021.08.07.02.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:35 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 15/21] staging: rtl8723bs: remove rf type branching (fourth patch)
Date:   Sat,  7 Aug 2021 11:48:07 +0200
Message-Id: <8ca2f788c42d81b9cb4dbc46e23c7549dc27d081.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all function calls to rtw_get_hw_reg made to
read HW_VAR_RF_TYPE and get value of rt_type, which
is always 1T1R. Clean up code on removal sites,
keeping 1T1R code unconditionally.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  8 +-
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 18 +----
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 73 +++++--------------
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  6 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 36 ++-------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 38 ++--------
 drivers/staging/rtl8723bs/hal/hal_com.c       |  8 +-
 drivers/staging/rtl8723bs/include/ieee80211.h |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 23 ++----
 9 files changed, 44 insertions(+), 168 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 69a55482e8a0..6064dd6a76b4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1034,7 +1034,6 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
-		u8 rf_type = 0;
 		u8 max_rx_ampdu_factor = 0;
 		struct ieee80211_ht_cap *pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 
@@ -1080,11 +1079,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 			IEEE80211_HT_CAP_AMPDU_FACTOR & max_rx_ampdu_factor
 		); /* set  Max Rx AMPDU size  to 64K */
 
-		rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-		if (rf_type == RF_1T1R) {
-			pht_cap->mcs.rx_mask[0] = 0xff;
-			pht_cap->mcs.rx_mask[1] = 0x0;
-		}
+		pht_cap->mcs.rx_mask[0] = 0xff;
+		pht_cap->mcs.rx_mask[1] = 0x0;
 
 		memcpy(&pmlmepriv->htpriv.ht_cap, p + 2, ie_len);
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 76ad1122f89f..5354fdd11c9b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -58,21 +58,11 @@ static void dump_4_rf_regs(struct adapter *adapter, int path, int offset)
 
 void rf_reg_dump(struct adapter *adapter)
 {
-	int i, path;
-	u8 rf_type = 0;
-	u8 path_nums = 0;
-
-	rtw_hal_get_hwreg(adapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-	if ((RF_1T2R == rf_type) || (RF_1T1R == rf_type))
-		path_nums = 1;
-	else
-		path_nums = 2;
+	int i, path = 0;
 
 	netdev_dbg(adapter->pnetdev, "======= RF REG =======\n");
 
-	for (path = 0; path < path_nums; path++) {
-		netdev_dbg(adapter->pnetdev, "RF_Path(%x)\n", path);
-		for (i = 0; i < 0x100; i++)
-			dump_4_rf_regs(adapter, path, i);
-	}
+	netdev_dbg(adapter->pnetdev, "RF_Path(%x)\n", path);
+	for (i = 0; i < 0x100; i++)
+		dump_4_rf_regs(adapter, path, i);
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 795eafb7d6ff..b449be537376 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1106,64 +1106,27 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 }
 
 /* show MCS rate, unit: 100Kbps */
-u16 rtw_mcs_rate(u8 rf_type, u8 bw_40MHz, u8 short_GI, unsigned char *MCS_rate)
+u16 rtw_mcs_rate(u8 bw_40MHz, u8 short_GI, unsigned char *MCS_rate)
 {
 	u16 max_rate = 0;
 
-	if (rf_type == RF_1T1R) {
-		if (MCS_rate[0] & BIT(7))
-			max_rate = (bw_40MHz) ? ((short_GI)?1500:1350):((short_GI)?722:650);
-		else if (MCS_rate[0] & BIT(6))
-			max_rate = (bw_40MHz) ? ((short_GI)?1350:1215):((short_GI)?650:585);
-		else if (MCS_rate[0] & BIT(5))
-			max_rate = (bw_40MHz) ? ((short_GI)?1200:1080):((short_GI)?578:520);
-		else if (MCS_rate[0] & BIT(4))
-			max_rate = (bw_40MHz) ? ((short_GI)?900:810):((short_GI)?433:390);
-		else if (MCS_rate[0] & BIT(3))
-			max_rate = (bw_40MHz) ? ((short_GI)?600:540):((short_GI)?289:260);
-		else if (MCS_rate[0] & BIT(2))
-			max_rate = (bw_40MHz) ? ((short_GI)?450:405):((short_GI)?217:195);
-		else if (MCS_rate[0] & BIT(1))
-			max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
-		else if (MCS_rate[0] & BIT(0))
-			max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
-	} else {
-		if (MCS_rate[1]) {
-			if (MCS_rate[1] & BIT(7))
-				max_rate = (bw_40MHz) ? ((short_GI)?3000:2700):((short_GI)?1444:1300);
-			else if (MCS_rate[1] & BIT(6))
-				max_rate = (bw_40MHz) ? ((short_GI)?2700:2430):((short_GI)?1300:1170);
-			else if (MCS_rate[1] & BIT(5))
-				max_rate = (bw_40MHz) ? ((short_GI)?2400:2160):((short_GI)?1156:1040);
-			else if (MCS_rate[1] & BIT(4))
-				max_rate = (bw_40MHz) ? ((short_GI)?1800:1620):((short_GI)?867:780);
-			else if (MCS_rate[1] & BIT(3))
-				max_rate = (bw_40MHz) ? ((short_GI)?1200:1080):((short_GI)?578:520);
-			else if (MCS_rate[1] & BIT(2))
-				max_rate = (bw_40MHz) ? ((short_GI)?900:810):((short_GI)?433:390);
-			else if (MCS_rate[1] & BIT(1))
-				max_rate = (bw_40MHz) ? ((short_GI)?600:540):((short_GI)?289:260);
-			else if (MCS_rate[1] & BIT(0))
-				max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
-		} else {
-			if (MCS_rate[0] & BIT(7))
-				max_rate = (bw_40MHz) ? ((short_GI)?1500:1350):((short_GI)?722:650);
-			else if (MCS_rate[0] & BIT(6))
-				max_rate = (bw_40MHz) ? ((short_GI)?1350:1215):((short_GI)?650:585);
-			else if (MCS_rate[0] & BIT(5))
-				max_rate = (bw_40MHz) ? ((short_GI)?1200:1080):((short_GI)?578:520);
-			else if (MCS_rate[0] & BIT(4))
-				max_rate = (bw_40MHz) ? ((short_GI)?900:810):((short_GI)?433:390);
-			else if (MCS_rate[0] & BIT(3))
-				max_rate = (bw_40MHz) ? ((short_GI)?600:540):((short_GI)?289:260);
-			else if (MCS_rate[0] & BIT(2))
-				max_rate = (bw_40MHz) ? ((short_GI)?450:405):((short_GI)?217:195);
-			else if (MCS_rate[0] & BIT(1))
-				max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
-			else if (MCS_rate[0] & BIT(0))
-				max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
-		}
-	}
+	if (MCS_rate[0] & BIT(7))
+		max_rate = (bw_40MHz) ? ((short_GI)?1500:1350):((short_GI)?722:650);
+	else if (MCS_rate[0] & BIT(6))
+		max_rate = (bw_40MHz) ? ((short_GI)?1350:1215):((short_GI)?650:585);
+	else if (MCS_rate[0] & BIT(5))
+		max_rate = (bw_40MHz) ? ((short_GI)?1200:1080):((short_GI)?578:520);
+	else if (MCS_rate[0] & BIT(4))
+		max_rate = (bw_40MHz) ? ((short_GI)?900:810):((short_GI)?433:390);
+	else if (MCS_rate[0] & BIT(3))
+		max_rate = (bw_40MHz) ? ((short_GI)?600:540):((short_GI)?289:260);
+	else if (MCS_rate[0] & BIT(2))
+		max_rate = (bw_40MHz) ? ((short_GI)?450:405):((short_GI)?217:195);
+	else if (MCS_rate[0] & BIT(1))
+		max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
+	else if (MCS_rate[0] & BIT(0))
+		max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
+
 	return max_rate;
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 0152491455a2..5f25cbf83723 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -541,7 +541,6 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 	struct wlan_bssid_ex	*pcur_bss = &pmlmepriv->cur_network.network;
 	struct sta_info *psta = NULL;
 	u8 short_GI = 0;
-	u8 rf_type = 0;
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) != true)
 		&& (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) != true))
@@ -554,10 +553,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 	short_GI = query_ra_short_GI(psta);
 
 	if (is_supported_ht(psta->wireless_mode)) {
-		rtw_hal_get_hwreg(adapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-
-		max_rate = rtw_mcs_rate(rf_type,
-					((psta->bw_mode == CHANNEL_WIDTH_40)?1:0),
+		max_rate = rtw_mcs_rate(psta->bw_mode == CHANNEL_WIDTH_40 ? 1 : 0,
 					short_GI,
 					psta->htpriv.ht_cap.mcs.rx_mask);
 	} else {
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 5ed13bf765d2..64961e394410 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2313,7 +2313,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	enum ieee80211_max_ampdu_length_exp max_rx_ampdu_factor;
 	unsigned char *p;
 	struct ieee80211_ht_cap ht_capie;
-	u8 cbw40_enable = 0, stbc_rx_enable = 0, rf_type = 0, operation_bw = 0;
+	u8 cbw40_enable = 0, stbc_rx_enable = 0, operation_bw = 0;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
@@ -2392,25 +2392,10 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	memcpy(ht_capie.mcs.rx_mask, pmlmeext->default_supported_mcs_set, 16);
 
 	/* update default supported_mcs_set */
-	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
+	if (stbc_rx_enable)
+		ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_1R);/* RX STBC One spatial stream */
 
-	switch (rf_type) {
-	case RF_1T1R:
-		if (stbc_rx_enable)
-			ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_1R);/* RX STBC One spatial stream */
-
-		set_mcs_rate_by_mask(ht_capie.mcs.rx_mask, MCS_RATE_1R);
-		break;
-
-	case RF_2T2R:
-	case RF_1T2R:
-	default:
-		if (stbc_rx_enable)
-			ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_2R);/* RX STBC two spatial stream */
-
-		set_mcs_rate_by_mask(ht_capie.mcs.rx_mask, MCS_RATE_2R);
-		break;
-	}
+	set_mcs_rate_by_mask(ht_capie.mcs.rx_mask, MCS_RATE_1R);
 
 	{
 		u32 rx_packet_offset, max_recvbuf_sz;
@@ -2510,24 +2495,13 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	    (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) &
 	      BIT(1)) && (pmlmeinfo->HT_info.infos[0] & BIT(2))) {
 		int i;
-		u8 rf_type;
-
-		rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 		/* update the MCS set */
 		for (i = 0; i < 16; i++)
 			pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= pmlmeext->default_supported_mcs_set[i];
 
 		/* update the MCS rates */
-		switch (rf_type) {
-		case RF_1T1R:
-		case RF_1T2R:
-			set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_1R);
-			break;
-		case RF_2T2R:
-		default:
-			set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R);
-		}
+		set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_1R);
 
 		/* switch to the 40M Hz mode according to the AP */
 		/* pmlmeext->cur_bwmode = CHANNEL_WIDTH_40; */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 170536986476..18ba846c0b7b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -46,16 +46,7 @@ static u8 rtw_basic_rate_ofdm[3] = {
 
 u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
 {
-	u8 raid, cur_rf_type, rf_type = RF_1T1R;
-
-	rtw_hal_get_hwreg(adapter, HW_VAR_RF_TYPE, (u8 *)(&cur_rf_type));
-
-	if (cur_rf_type == RF_1T1R) {
-		rf_type = RF_1T1R;
-	} else if (is_supported_ht(psta->wireless_mode)) {
-		if (psta->ra_mask & 0xfff00000)
-			rf_type = RF_2T2R;
-	}
+	u8 raid;
 
 	switch (psta->wireless_mode) {
 	case WIRELESS_11B:
@@ -69,23 +60,14 @@ u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
 		break;
 	case WIRELESS_11_24N:
 	case WIRELESS_11G_24N:
-		if (rf_type == RF_2T2R)
-			raid = RATEID_IDX_GN_N2SS;
-		else
-			raid = RATEID_IDX_GN_N1SS;
+		raid = RATEID_IDX_GN_N1SS;
 		break;
 	case WIRELESS_11B_24N:
 	case WIRELESS_11BG_24N:
 		if (psta->bw_mode == CHANNEL_WIDTH_20) {
-			if (rf_type == RF_2T2R)
-				raid = RATEID_IDX_BGN_20M_2SS_BN;
-			else
-				raid = RATEID_IDX_BGN_20M_1SS_BN;
+			raid = RATEID_IDX_BGN_20M_1SS_BN;
 		} else {
-			if (rf_type == RF_2T2R)
-				raid = RATEID_IDX_BGN_40M_2SS;
-			else
-				raid = RATEID_IDX_BGN_40M_1SS;
+			raid = RATEID_IDX_BGN_40M_1SS;
 		}
 		break;
 	default:
@@ -982,7 +964,6 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 {
 	unsigned int	i;
-	u8 rf_type;
 	u8 max_AMPDU_len, min_MPDU_spacing;
 	u8 cur_ldpc_cap = 0, cur_stbc_cap = 0;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -1018,22 +999,13 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 			pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para = max_AMPDU_len | min_MPDU_spacing;
 		}
 	}
-	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 	/* update the MCS set */
 	for (i = 0; i < 16; i++)
 		pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= pmlmeext->default_supported_mcs_set[i];
 
 	/* update the MCS rates */
-	switch (rf_type) {
-	case RF_1T1R:
-	case RF_1T2R:
-		set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_1R);
-		break;
-	case RF_2T2R:
-	default:
-		set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R);
-	}
+	set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_1R);
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		/*  Config STBC setting */
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 8964303a619f..909b37bcc897 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -545,7 +545,7 @@ u8 rtw_get_mgntframe_raid(struct adapter *adapter, unsigned char network_type)
 
 void rtw_hal_update_sta_rate_mask(struct adapter *padapter, struct sta_info *psta)
 {
-	u8 i, rf_type, limit;
+	u8 i, limit;
 	u32 tx_ra_bitmap;
 
 	if (!psta)
@@ -561,11 +561,7 @@ void rtw_hal_update_sta_rate_mask(struct adapter *padapter, struct sta_info *pst
 
 	/* n mode ra_bitmap */
 	if (psta->htpriv.ht_option) {
-		rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-		if (rf_type == RF_2T2R)
-			limit = 16; /*  2R */
-		else
-			limit = 8; /*   1R */
+		limit = 8; /*   1R */
 
 		for (i = 0; i < limit; i++) {
 			if (psta->htpriv.ht_cap.mcs.rx_mask[i/8] & BIT(i%8))
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 89851fa36830..d6236f5b069d 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -779,7 +779,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork);
 
 void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr);
 
-u16 rtw_mcs_rate(u8 rf_type, u8 bw_40MHz, u8 short_GI, unsigned char *MCS_rate);
+u16 rtw_mcs_rate(u8 bw_40MHz, u8 short_GI, unsigned char *MCS_rate);
 
 int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category, u8 *action);
 const char *action_public_str(u8 action);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 62eb64e447a4..499ac3a77512 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2755,7 +2755,7 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	return ret;
 }
 
-static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum nl80211_band band, u8 rf_type)
+static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum nl80211_band band)
 {
 
 #define MAX_BIT_RATE_40MHZ_MCS15	300	/* Mbps */
@@ -2788,34 +2788,23 @@ static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum
 	 *if BW_40 rx_mask[4]= 0x01;
 	 *highest supported RX rate
 	 */
-	if (rf_type == RF_1T1R) {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0x00;
-		ht_cap->mcs.rx_mask[4] = 0x01;
+	ht_cap->mcs.rx_mask[0] = 0xFF;
+	ht_cap->mcs.rx_mask[1] = 0x00;
+	ht_cap->mcs.rx_mask[4] = 0x01;
 
-		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS7);
-	} else if ((rf_type == RF_1T2R) || (rf_type == RF_2T2R)) {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0xFF;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-
-		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS15);
-	}
+	ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS7);
 }
 
 void rtw_cfg80211_init_wiphy(struct adapter *padapter)
 {
-	u8 rf_type;
 	struct ieee80211_supported_band *bands;
 	struct wireless_dev *pwdev = padapter->rtw_wdev;
 	struct wiphy *wiphy = pwdev->wiphy;
 
-	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-
 	{
 		bands = wiphy->bands[NL80211_BAND_2GHZ];
 		if (bands)
-			rtw_cfg80211_init_ht_capab(&bands->ht_cap, NL80211_BAND_2GHZ, rf_type);
+			rtw_cfg80211_init_ht_capab(&bands->ht_cap, NL80211_BAND_2GHZ);
 	}
 
 	/* copy mac_addr to wiphy */
-- 
2.20.1

