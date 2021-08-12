Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CCE3E9B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhHLAZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhHLAZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:25:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F41C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:25:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id z20so7867301ejf.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSmvfE1EQxyYoaORrKju+Ci0T36UtVX6WsM/Zgd7HnY=;
        b=AL7eRwch1KOuSkyA1UAx+pcdbwir5vI+9M9+BdqHsJkF0Va+Y4U22jsTvRKQVRCHpP
         hBoy6Y04Asrl5HMNH2rnW39Wp1ZrZhGHCyYU79ZcyDTI39z3sDY4u/BEzU43/7A9jBJY
         aS1bgoGl84ptbAyh2Heah2WBaai1UeIbTAS08ENkwgXzhuaLGsaKEo701MPmOOky+vrO
         L6ynlqqQN10lsSfYQlcadc40SAVFIYkFhOiII6fWE7OlAkFDJwaoERdqhVLQNjJ1f39A
         BH5haA4zPYtpgr2qQcmkhclFD9leheqc+13aGCIt7z2D11nJXIrU08Av6qQiNidaw40R
         JzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSmvfE1EQxyYoaORrKju+Ci0T36UtVX6WsM/Zgd7HnY=;
        b=IIDhbcSyE82Egp5YMI7q80DWgTs5jhbcA8qhpy2fOZkAumQtNKR03nuNg97ZYL8DiM
         BDTmXmIAIrLWjDvOCZ096CoqpB9YcWkci3RuyduH/mklbz/fkTIEQ36JzDPO9uDwGyiA
         5Cs17wNOh2nGVO3/JkqAFaUudiieGkR5T39x3H5myw8ULBluQJMwuiR3Vdx9kH9Q42W1
         VZVHR9Ntdsv8onP9UOXyA1H8oxWYyd1CTCnhbfJlCRnhPmo5MhISe/F3/U/4U1a7eMLD
         NROg+R8qIsRiRSLb0DB16mHOL/dTfXLlhosNaRwPQc1KCoGTDYIEcD7wTBANQKmqFiJr
         Mgew==
X-Gm-Message-State: AOAM532ONWrK3MoRMOVlflR8HHwFftgf9qpUb0rF6HLdTKsx9kZ9Wxq2
        O+IkPHBSTAcy1nVTwlMdAQQ=
X-Google-Smtp-Source: ABdhPJy5Q2cRmUbWuKH4HP+kI6qQwhXciRoXpDisdbHRcuNW48gLvsNBoKcC20jWJ3QLiQfO0odcYA==
X-Received: by 2002:a17:906:76da:: with SMTP id q26mr1105312ejn.402.1628727927282;
        Wed, 11 Aug 2021 17:25:27 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id l20sm265048ejb.23.2021.08.11.17.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 17:25:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: Remove all 5GHz network types
Date:   Thu, 12 Aug 2021 02:25:17 +0200
Message-Id: <20210812002519.23678-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812002519.23678-1-fmdefrancesco@gmail.com>
References: <20210812002519.23678-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all 5Ghz network types. r8188eu works on
802.11bgn standards and on 2.4Ghz band.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c         | 13 ++---------
 drivers/staging/r8188eu/core/rtw_ieee80211.c  | 19 +++------------
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       | 10 --------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  2 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 15 ++----------
 drivers/staging/r8188eu/hal/odm.c             |  1 -
 drivers/staging/r8188eu/include/ieee80211.h   | 23 ++-----------------
 drivers/staging/r8188eu/include/wifi.h        |  2 +-
 drivers/staging/r8188eu/include/wlan_bssdef.h |  2 +-
 10 files changed, 13 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 3f23c1a25419..bc4c6dbd5aa3 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -460,11 +460,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 	}
 
 	if (pcur_network->Configuration.DSConfig > 14) {
-		/*  5G band */
-		if (tx_ra_bitmap & 0xffff000)
-			sta_band |= WIRELESS_11_5N | WIRELESS_11A;
-		else
-			sta_band |= WIRELESS_11A;
+		sta_band |= WIRELESS_INVALID;
 	} else {
 		if (tx_ra_bitmap & 0xffff000)
 			sta_band |= WIRELESS_11_24N | WIRELESS_11G | WIRELESS_11B;
@@ -547,9 +543,7 @@ void update_bmc_sta(struct adapter *padapter)
 		}
 
 		if (pcur_network->Configuration.DSConfig > 14) {
-			/* force to A mode. 5G doesn't support CCK rates */
-			network_type = WIRELESS_11A;
-			tx_ra_bitmap = 0x150; /*  6, 12, 24 Mbps */
+			network_type = WIRELESS_INVALID;
 		} else {
 			/* force to b mode */
 			network_type = WIRELESS_11B;
@@ -1050,9 +1044,6 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	case WIRELESS_11BG_24N:
 		pbss_network->NetworkTypeInUse = Ndis802_11OFDM24;
 		break;
-	case WIRELESS_11A:
-		pbss_network->NetworkTypeInUse = Ndis802_11OFDM5;
-		break;
 	default:
 		pbss_network->NetworkTypeInUse = Ndis802_11OFDM24;
 		break;
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 55d2b8f90d91..0c7231cefdda 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -98,10 +98,7 @@ uint	rtw_is_cckratesonly_included(u8 *rate)
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
 {
 	if (channel > 14) {
-		if ((rtw_is_cckrates_included(rate)) == true)
-			return WIRELESS_INVALID;
-		else
-			return WIRELESS_11A;
+		return WIRELESS_INVALID;
 	} else {  /*  could be pure B, pure G, or B/G */
 		if ((rtw_is_cckratesonly_included(rate)) == true)
 			return WIRELESS_11B;
@@ -328,9 +325,6 @@ void rtw_set_supported_rate(u8 *SupportedRates, uint mode)
 		memcpy(SupportedRates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
 		break;
 	case WIRELESS_11G:
-	case WIRELESS_11A:
-	case WIRELESS_11_5N:
-	case WIRELESS_11A_5N:/* Todo: no basic rate for ofdm ? */
 		memcpy(SupportedRates, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
 		break;
 	case WIRELESS_11BG:
@@ -393,16 +387,9 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	ie = rtw_set_ie(ie, _SSID_IE_, pdev_network->Ssid.SsidLength, pdev_network->Ssid.Ssid, &sz);
 
 	/* supported rates */
-	if (pregistrypriv->wireless_mode == WIRELESS_11ABGN) {
-		if (pdev_network->Configuration.DSConfig > 14)
-			wireless_mode = WIRELESS_11A_5N;
-		else
-			wireless_mode = WIRELESS_11BG_24N;
-	} else {
-		wireless_mode = pregistrypriv->wireless_mode;
-	}
+	wireless_mode = pregistrypriv->wireless_mode;
 
-		rtw_set_supported_rate(pdev_network->SupportedRates, wireless_mode);
+	rtw_set_supported_rate(pdev_network->SupportedRates, wireless_mode);
 
 	rateLen = rtw_get_rateset_len(pdev_network->SupportedRates);
 
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 37e8b076be93..8b2f5ace1d86 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -795,7 +795,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 	    (!check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)))
 		return 0;
 
-	if (pmlmeext->cur_wireless_mode & (WIRELESS_11_24N|WIRELESS_11_5N)) {
+	if (pmlmeext->cur_wireless_mode & (WIRELESS_11_24N)) {
 		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength-12);
 		if (p && ht_ielen > 0) {
 			pht_capie = (struct ieee80211_ht_cap *)(p+2);
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d688f2427b03..ae7fd24798c3 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1916,16 +1916,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	case WIRELESS_11BG_24N:
 		pdev_network->NetworkTypeInUse = (Ndis802_11OFDM24);
 		break;
-	case WIRELESS_11A:
-	case WIRELESS_11A_5N:
-		pdev_network->NetworkTypeInUse = (Ndis802_11OFDM5);
-		break;
-	case WIRELESS_11ABGN:
-		if (pregistrypriv->channel > 14)
-			pdev_network->NetworkTypeInUse = (Ndis802_11OFDM5);
-		else
-			pdev_network->NetworkTypeInUse = (Ndis802_11OFDM24);
-		break;
 	default:
 		/*  TODO */
 		break;
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 9b3ea8a31508..3c518a7cd64f 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1950,7 +1950,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 		/*	Added by Albert 2011/03/22 */
 		/*	In the P2P mode, the driver should not support the b mode. */
 		/*	So, the Tx packet shouldn't use the CCK rate */
-		update_tx_basic_rate(padapter, WIRELESS_11AGN);
+		update_tx_basic_rate(padapter, (WIRELESS_11G | WIRELESS_11_24N));
 
 		/* Enable P2P function */
 		init_wifidirect_info(padapter, role);
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index e897920b7af1..b9ef671bbc8a 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -78,7 +78,6 @@ unsigned char networktype_to_raid(unsigned char network_type)
 	case WIRELESS_11B:
 		raid = RATR_INX_WIRELESS_B;
 		break;
-	case WIRELESS_11A:
 	case WIRELESS_11G:
 		raid = RATR_INX_WIRELESS_G;
 		break;
@@ -86,10 +85,8 @@ unsigned char networktype_to_raid(unsigned char network_type)
 		raid = RATR_INX_WIRELESS_GB;
 		break;
 	case WIRELESS_11_24N:
-	case WIRELESS_11_5N:
 		raid = RATR_INX_WIRELESS_N;
 		break;
-	case WIRELESS_11A_5N:
 	case WIRELESS_11G_24N:
 		raid = RATR_INX_WIRELESS_NG;
 		break;
@@ -110,10 +107,7 @@ u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int ratelen
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeext->cur_channel > 14) {
-		if (pmlmeinfo->HT_enable)
-			network_type = WIRELESS_11_5N;
-
-		network_type |= WIRELESS_11A;
+		network_type |= WIRELESS_INVALID;
 	} else {
 		if (pmlmeinfo->HT_enable)
 			network_type = WIRELESS_11_24N;
@@ -1490,8 +1484,6 @@ void update_capinfo(struct adapter *Adapter, u16 updateCap)
 				if (pmlmeinfo->slotTime != NON_SHORT_SLOT_TIME)
 					pmlmeinfo->slotTime = NON_SHORT_SLOT_TIME;
 			}
-		} else if (pmlmeext->cur_wireless_mode & (WIRELESS_11A | WIRELESS_11_5N)) {
-			pmlmeinfo->slotTime = SHORT_SLOT_TIME;
 		} else {
 			/* B Mode */
 			pmlmeinfo->slotTime = NON_SHORT_SLOT_TIME;
@@ -1516,10 +1508,7 @@ void update_wireless_mode(struct adapter *padapter)
 		pmlmeinfo->HT_enable = 1;
 
 	if (pmlmeext->cur_channel > 14) {
-		if (pmlmeinfo->HT_enable)
-			network_type = WIRELESS_11_5N;
-
-		network_type |= WIRELESS_11A;
+		network_type |= WIRELESS_INVALID;
 	} else {
 		if (pmlmeinfo->HT_enable)
 			network_type = WIRELESS_11_24N;
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 53198bf92c0f..2fd20339460f 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1136,7 +1136,6 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 		break;
 	default:
 		/* case WIRELESS_11_24N: */
-		/* case WIRELESS_11_5N: */
 		if (pDM_Odm->RFType == RF_1T2R)
 			rate_bitmap = 0x000fffff;
 		else
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 4dfa817175e7..bc5b030e9c40 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -145,53 +145,34 @@ enum NETWORK_TYPE {
 	/* Sub-Element */
 	WIRELESS_11B = BIT(0), /* tx:cck only, rx:cck only, hw: cck */
 	WIRELESS_11G = BIT(1), /* tx:ofdm only, rx:ofdm & cck, hw:cck & ofdm*/
-	WIRELESS_11A = BIT(2), /* tx:ofdm only, rx: ofdm only, hw:ofdm only */
 	WIRELESS_11_24N = BIT(3), /* tx:MCS only, rx:MCS & cck, hw:MCS & cck */
-	WIRELESS_11_5N = BIT(4), /* tx:MCS only, rx:MCS & ofdm, hw:ofdm only */
-	WIRELESS_AC		= BIT(6),
 
 	/* Combination */
 	/*  tx: cck & ofdm, rx: cck & ofdm & MCS, hw: cck & ofdm */
 	WIRELESS_11BG = (WIRELESS_11B | WIRELESS_11G),
 	/*  tx: ofdm & MCS, rx: ofdm & cck & MCS, hw: cck & ofdm */
 	WIRELESS_11G_24N = (WIRELESS_11G | WIRELESS_11_24N),
-	/*  tx: ofdm & MCS, rx: ofdm & MCS, hw: ofdm only */
-	WIRELESS_11A_5N = (WIRELESS_11A | WIRELESS_11_5N),
 	/*  tx: ofdm & cck & MCS, rx: ofdm & cck & MCS, hw: ofdm & cck */
 	WIRELESS_11BG_24N = (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N),
-	/*  tx: ofdm & MCS, rx: ofdm & MCS, hw: ofdm only */
-	WIRELESS_11AGN = (WIRELESS_11A | WIRELESS_11G | WIRELESS_11_24N |
-			  WIRELESS_11_5N),
-	WIRELESS_11ABGN = (WIRELESS_11A | WIRELESS_11B | WIRELESS_11G |
-			   WIRELESS_11_24N | WIRELESS_11_5N),
 };
 
 #define SUPPORTED_24G_NETTYPE_MSK				\
 	 (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N)
-#define SUPPORTED_5G_NETTYPE_MSK				\
-	 (WIRELESS_11A | WIRELESS_11_5N)
 
 #define IsSupported24G(NetType)					\
 	((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
-#define IsSupported5G(NetType)					\
-	((NetType) & SUPPORTED_5G_NETTYPE_MSK ? true : false)
 
 #define IsEnableHWCCK(NetType)					\
 	IsSupported24G(NetType)
-#define IsEnableHWOFDM(NetType)					\
-	((NetType) & (WIRELESS_11G | WIRELESS_11_24N |		\
-	 SUPPORTED_5G_NETTYPE_MSK) ? true : false)
 
 #define IsSupportedRxCCK(NetType) IsEnableHWCCK(NetType)
-#define IsSupportedRxOFDM(NetType) IsEnableHWOFDM(NetType)
-#define IsSupportedRxMCS(NetType) IsEnableHWOFDM(NetType)
 
 #define IsSupportedTxCCK(NetType)				\
 	((NetType) & (WIRELESS_11B) ? true : false)
 #define IsSupportedTxOFDM(NetType)				\
-	((NetType) & (WIRELESS_11G|WIRELESS_11A) ? true : false)
+	((NetType) & (WIRELESS_11G) ? true : false)
 #define IsSupportedTxMCS(NetType)				\
-	((NetType) & (WIRELESS_11_24N|WIRELESS_11_5N) ? true : false)
+	((NetType) & (WIRELESS_11_24N) ? true : false)
 
 struct ieee_param {
 	u32 cmd;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 65fc677bf4eb..f4212c4f4ada 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -464,7 +464,7 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 #define _PRE_ALLOCMICHDR_		6
 
 #define _SIFSTIME_				\
-	((priv->pmib->dot11BssType.net_work_type & WIRELESS_11A) ? 16 : 10)
+	(priv->pmib->dot11BssType.net_work_type = 10)
 #define _ACKCTSLNG_		14	/* 14 bytes long, including crclng */
 #define _CRCLNG_		4
 
diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
index bada3e168c42..99ca097b8edd 100644
--- a/drivers/staging/r8188eu/include/wlan_bssdef.h
+++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
@@ -254,7 +254,7 @@ static inline uint get_wlan_bssid_ex_sz(struct wlan_bssid_ex *bss)
 
 struct	wlan_network {
 	struct list_head list;
-	int	network_type;	/* refer to ieee80211.h for WIRELESS_11A/B/G */
+	int	network_type;	/* refer to ieee80211.h for WIRELESS_11B/G */
 	int	fixed;		/*  set fixed when not to be removed
 				 *  in site-surveying */
 	unsigned long	last_scanned; /* timestamp for the network */
-- 
2.32.0

