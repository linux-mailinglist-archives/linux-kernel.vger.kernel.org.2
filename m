Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A22D3EDA58
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhHPP7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhHPP7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:59:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC4DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k8so5392767wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auaNiHBbkvciWRL0Ys2lQjc2Qyb+3X9ZZNT6i89S+EU=;
        b=Mx63Gr6C4MvWx8bmlx1/b8Dssm1J0UEJ7bzhP1vE/uHHoEIi6sI/zoJrRHVRGr1jFk
         aTDVPw66P1rh6YjlVQ6rP4KZscggZC2eYvJ6oE+qv8PSt8nDcMHBZnqD7CeQ2ckgbkb0
         3dP1Q3lgRSWpa6FQFdZb9r5wYzuW059ZwnbKxM6UUMd2OFo6EGtcW2AbvjQHQcXIGflf
         0WRFnVPTPXwyohXa4PfZfkWi/QCEWRa2L8e1R8ZJG+BMQOuum/XrawIqDoFsBIzLyPmq
         iBv4e0EieZX0hxUzgXnNKqMy8DBdHgNwCH17N3oCDadnvW0VIWueHNhtBYMuuQinucaF
         Z5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auaNiHBbkvciWRL0Ys2lQjc2Qyb+3X9ZZNT6i89S+EU=;
        b=HvMFt5MSfH2isGgw9gVQymMN7DUFEy28f6UkvCzRQ4ML9vCpyLb5HhU5+Z34W++ETB
         okkj8j00rNm6C6Hr77GvJtT6RrQmTVuI7F0ZQpQ4hkZ/BTOucKZtb1TS5lN9w0skK8Ev
         +JeY8scoW6E9PlW5IPY+A3GH3gufmllCwuZNPsExOrmfDlbSk97MXZYiQIMEafoUumpL
         YqYNZ1I26fItzWnFZlPKPwPPg4s9tl+ioJqSErvxBJ8Ad2T1rMn+fEyIoX8qsaOpkgrr
         //efCtFb1fjexWFjDBbLe+hNL4TIvORgMKBFBTFynYTwjueWryo/RlNScqBDvQsZrUZ3
         tVoA==
X-Gm-Message-State: AOAM532Y/N+r8oWL1keSP9pPUo5aIHkmYP20xBaxfxvsavVf4EgtpmU1
        xh3ja/IIsK7A0LfDqcYkZ+B2gCtm7aY=
X-Google-Smtp-Source: ABdhPJwFQ+VvTj1Hra5zTpEKAFykuUzG38ZYCgXzr6g/EbNY7gKzFpqCxLoXvPiewD0T6wnMCsoAhA==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr7740552wrt.96.1629129557764;
        Mon, 16 Aug 2021 08:59:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/23] staging: r8188eu: add spaces around operators in core/rtw_ap.c
Date:   Mon, 16 Aug 2021 17:57:56 +0200
Message-Id: <20210816155818.24005-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces around operators in core/rtw_ap.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 88 +++++++++++++--------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index f1b519d20989..8ef0586b753f 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -69,7 +69,7 @@ static void update_BCNTIM(struct adapter *padapter)
 		p = rtw_get_ie(pie + _FIXED_IE_LENGTH_, _TIM_IE_, &tim_ielen, pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_);
 		if (p && tim_ielen > 0) {
 			tim_ielen += 2;
-			premainder_ie = p+tim_ielen;
+			premainder_ie = p + tim_ielen;
 			tim_ie_offset = (int)(p - pie);
 			remainder_ielen = pnetwork_mlmeext->IELength - tim_ie_offset - tim_ielen;
 			/* append TIM IE from dst_ie offset */
@@ -84,7 +84,7 @@ static void update_BCNTIM(struct adapter *padapter)
 			/*  get supported rates len */
 			p = rtw_get_ie(pie + _BEACON_IE_OFFSET_, _SUPPORTEDRATES_IE_, &tmp_len, (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_));
 			if (p)
-				offset += tmp_len+2;
+				offset += tmp_len + 2;
 
 			/* DS Parameter Set IE, len = 3 */
 			offset += 3;
@@ -104,7 +104,7 @@ static void update_BCNTIM(struct adapter *padapter)
 		}
 		*dst_ie++ = _TIM_IE_;
 
-		if ((pstapriv->tim_bitmap&0xff00) && (pstapriv->tim_bitmap&0x00fc))
+		if ((pstapriv->tim_bitmap & 0xff00) && (pstapriv->tim_bitmap & 0x00fc))
 			tim_ielen = 5;
 		else
 			tim_ielen = 4;
@@ -114,7 +114,7 @@ static void update_BCNTIM(struct adapter *padapter)
 		*dst_ie++ = 0;/* DTIM count */
 		*dst_ie++ = 1;/* DTIM period */
 
-		if (pstapriv->tim_bitmap&BIT(0))/* for bc/mc frames */
+		if (pstapriv->tim_bitmap & BIT(0))/* for bc/mc frames */
 			*dst_ie++ = BIT(0);/* bitmap ctrl */
 		else
 			*dst_ie++ = 0;
@@ -167,7 +167,7 @@ void rtw_add_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork, u8
 	if (p && ielen > 0) {
 		ielen += 2;
 
-		premainder_ie = p+ielen;
+		premainder_ie = p + ielen;
 
 		ie_offset = (int)(p - pie);
 
@@ -176,7 +176,7 @@ void rtw_add_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork, u8
 		if (bmatch)
 			dst_ie = p;
 		else
-			dst_ie = (p+ielen);
+			dst_ie = (p + ielen);
 	}
 
 	if (remainder_ielen > 0) {
@@ -214,7 +214,7 @@ void rtw_remove_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork,
 	if (p && ielen > 0) {
 		ielen += 2;
 
-		premainder_ie = p+ielen;
+		premainder_ie = p + ielen;
 
 		ie_offset = (int)(p - pie);
 
@@ -355,8 +355,8 @@ void	expire_timeout_chk(struct adapter *padapter)
 			updated = ap_free_sta(padapter, psta, true, WLAN_REASON_DEAUTH_LEAVING);
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
-			if (psta->sleepq_len > (NR_XMITFRAME/pstapriv->asoc_list_cnt) &&
-			    padapter->xmitpriv.free_xmitframe_cnt < (NR_XMITFRAME/pstapriv->asoc_list_cnt/2)) {
+			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
+			    padapter->xmitpriv.free_xmitframe_cnt < (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2)) {
 				DBG_88E("%s sta:%pM, sleepq_len:%u, free_xmitframe_cnt:%u, asoc_list_cnt:%u, clear sleep_q\n", __func__,
 					(psta->hwaddr), psta->sleepq_len,
 					padapter->xmitpriv.free_xmitframe_cnt,
@@ -440,7 +440,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 	/* b/g mode ra_bitmap */
 	for (i = 0; i < sizeof(psta->bssrateset); i++) {
 		if (psta->bssrateset[i])
-			tx_ra_bitmap |= rtw_get_bit_value_from_ieee_value(psta->bssrateset[i]&0x7f);
+			tx_ra_bitmap |= rtw_get_bit_value_from_ieee_value(psta->bssrateset[i] & 0x7f);
 	}
 	/* n mode ra_bitmap */
 	if (psta_ht->ht_option) {
@@ -451,8 +451,8 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 			limit = 8;/*   1R */
 
 		for (i = 0; i < limit; i++) {
-			if (psta_ht->ht_cap.mcs.rx_mask[i/8] & BIT(i%8))
-				tx_ra_bitmap |= BIT(i+12);
+			if (psta_ht->ht_cap.mcs.rx_mask[i / 8] & BIT(i % 8))
+				tx_ra_bitmap |= BIT(i + 12);
 		}
 
 		/* max short GI rate */
@@ -473,19 +473,19 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 	psta->wireless_mode = sta_band;
 
 	raid = networktype_to_raid(sta_band);
-	init_rate = get_highest_rate_idx(tx_ra_bitmap&0x0fffffff)&0x3f;
+	init_rate = get_highest_rate_idx(tx_ra_bitmap & 0x0fffffff) & 0x3f;
 
 	if (psta->aid < NUM_STA) {
 		u8 arg = 0;
 
-		arg = psta->mac_id&0x1f;
+		arg = psta->mac_id & 0x1f;
 
 		arg |= BIT(7);/* support entry 2~31 */
 
 		if (shortGIrate)
 			arg |= BIT(5);
 
-		tx_ra_bitmap |= ((raid<<28)&0xf0000000);
+		tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
 
 		DBG_88E("%s => mac_id:%d , raid:%d , bitmap = 0x%x, arg = 0x%x\n",
 			__func__, psta->mac_id, raid, tx_ra_bitmap, arg);
@@ -539,7 +539,7 @@ void update_bmc_sta(struct adapter *padapter)
 		/* b/g mode ra_bitmap */
 		for (i = 0; i < supportRateNum; i++) {
 			if (psta->bssrateset[i])
-				tx_ra_bitmap |= rtw_get_bit_value_from_ieee_value(psta->bssrateset[i]&0x7f);
+				tx_ra_bitmap |= rtw_get_bit_value_from_ieee_value(psta->bssrateset[i] & 0x7f);
 		}
 
 		if (pcur_network->Configuration.DSConfig > 14) {
@@ -551,7 +551,7 @@ void update_bmc_sta(struct adapter *padapter)
 		}
 
 		raid = networktype_to_raid(network_type);
-		init_rate = get_highest_rate_idx(tx_ra_bitmap&0x0fffffff)&0x3f;
+		init_rate = get_highest_rate_idx(tx_ra_bitmap & 0x0fffffff) & 0x3f;
 
 		/* ap mode */
 		rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
@@ -559,9 +559,9 @@ void update_bmc_sta(struct adapter *padapter)
 		{
 			u8 arg = 0;
 
-			arg = psta->mac_id&0x1f;
+			arg = psta->mac_id & 0x1f;
 			arg |= BIT(7);
-			tx_ra_bitmap |= ((raid<<28)&0xf0000000);
+			tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
 			DBG_88E("update_bmc_sta, mask = 0x%x, arg = 0x%x\n", tx_ra_bitmap, arg);
 
 			/* bitmap[0:27] = tx_rate_bitmap */
@@ -602,7 +602,7 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 	u16 sta_cap_info;
 	u16 ap_cap_info;
 
-	psta->mac_id = psta->aid+1;
+	psta->mac_id = psta->aid + 1;
 	DBG_88E("%s\n", __func__);
 
 	/* ap mode */
@@ -716,7 +716,7 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	/* check if there is wps ie, */
 	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
 	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
-	if (!rtw_get_wps_ie(pnetwork->IEs+_FIXED_IE_LENGTH_, pnetwork->IELength-_FIXED_IE_LENGTH_, NULL, NULL))
+	if (!rtw_get_wps_ie(pnetwork->IEs + _FIXED_IE_LENGTH_, pnetwork->IELength - _FIXED_IE_LENGTH_, NULL, NULL))
 		pmlmeext->bstart_bss = true;
 
 	/* todo: update wmm, ht cap */
@@ -769,7 +769,7 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	/* set channel, bwmode */
 	p = rtw_get_ie((pnetwork->IEs + sizeof(struct ndis_802_11_fixed_ie)), _HT_ADD_INFO_IE_, &ie_len, (pnetwork->IELength - sizeof(struct ndis_802_11_fixed_ie)));
 	if (p && ie_len) {
-		pht_info = (struct HT_info_element *)(p+2);
+		pht_info = (struct HT_info_element *)(p + 2);
 
 		if ((pregpriv->cbw40_enable) &&	 (pht_info->infos[0] & BIT(2))) {
 			/* switch to the 40M Hz mode */
@@ -904,14 +904,14 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/*  get supported rates */
 	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _SUPPORTEDRATES_IE_, &ie_len, (pbss_network->IELength - _BEACON_IE_OFFSET_));
 	if (p) {
-		memcpy(supportRate, p+2, ie_len);
+		memcpy(supportRate, p + 2, ie_len);
 		supportRateNum = ie_len;
 	}
 
 	/* get ext_supported rates */
 	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _EXT_SUPPORTEDRATES_IE_, &ie_len, pbss_network->IELength - _BEACON_IE_OFFSET_);
 	if (p) {
-		memcpy(supportRate+supportRateNum, p+2, ie_len);
+		memcpy(supportRate + supportRateNum, p + 2, ie_len);
 		supportRateNum += ie_len;
 	}
 
@@ -939,7 +939,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	psecuritypriv->wpa2_pairwise_cipher = _NO_PRIVACY_;
 	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _RSN_IE_2_, &ie_len, (pbss_network->IELength - _BEACON_IE_OFFSET_));
 	if (p && ie_len > 0) {
-		if (rtw_parse_wpa2_ie(p, ie_len+2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
+		if (rtw_parse_wpa2_ie(p, ie_len + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 
 			psecuritypriv->dot8021xalg = 1;/* psk,  todo:802.1x */
@@ -958,8 +958,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	for (p = ie + _BEACON_IE_OFFSET_;; p += (ie_len + 2)) {
 		p = rtw_get_ie(p, _SSN_IE_1_, &ie_len,
 			       (pbss_network->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2)));
-		if ((p) && (!memcmp(p+2, OUI1, 4))) {
-			if (rtw_parse_wpa_ie(p, ie_len+2, &group_cipher,
+		if ((p) && (!memcmp(p + 2, OUI1, 4))) {
+			if (rtw_parse_wpa_ie(p, ie_len + 2, &group_cipher,
 					     &pairwise_cipher, NULL) == _SUCCESS) {
 				psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 
@@ -983,10 +983,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		for (p = ie + _BEACON_IE_OFFSET_;; p += (ie_len + 2)) {
 			p = rtw_get_ie(p, _VENDOR_SPECIFIC_IE_, &ie_len,
 				       (pbss_network->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2)));
-			if ((p) && !memcmp(p+2, WMM_PARA_IE, 6)) {
+			if ((p) && !memcmp(p + 2, WMM_PARA_IE, 6)) {
 				pmlmepriv->qospriv.qos_option = 1;
 
-				*(p+8) |= BIT(7);/* QoS Info, support U-APSD */
+				*(p + 8) |= BIT(7);/* QoS Info, support U-APSD */
 
 				/* disable all ACM bits since the WMM admission control is not supported */
 				*(p + 10) &= ~BIT(4); /* BE */
@@ -1005,7 +1005,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		       (pbss_network->IELength - _BEACON_IE_OFFSET_));
 	if (p && ie_len > 0) {
 		u8 rf_type;
-		struct ieee80211_ht_cap *pht_cap = (struct ieee80211_ht_cap *)(p+2);
+		struct ieee80211_ht_cap *pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 
 		pHT_caps_ie = p;
 		ht_cap = true;
@@ -1026,7 +1026,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 			pht_cap->mcs.rx_mask[0] = 0xff;
 			pht_cap->mcs.rx_mask[1] = 0x0;
 		}
-		memcpy(&pmlmepriv->htpriv.ht_cap, p+2, ie_len);
+		memcpy(&pmlmepriv->htpriv.ht_cap, p + 2, ie_len);
 	}
 
 	/* parsing HT_INFO_IE */
@@ -1113,7 +1113,7 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 
 	DBG_88E("%s(acl_num =%d) =%pM\n", __func__, pacl_list->num, (addr));
 
-	if ((NUM_ACL-1) < pacl_list->num)
+	if ((NUM_ACL - 1) < pacl_list->num)
 		return -1;
 
 	spin_lock_bh(&pacl_node_q->lock);
@@ -1229,9 +1229,9 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 		struct ndis_802_11_var_ie *pIE = (struct ndis_802_11_var_ie *)p;
 
 		if (pmlmepriv->num_sta_non_erp == 1)
-			pIE->data[0] |= RTW_ERP_INFO_NON_ERP_PRESENT|RTW_ERP_INFO_USE_PROTECTION;
+			pIE->data[0] |= RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION;
 		else
-			pIE->data[0] &= ~(RTW_ERP_INFO_NON_ERP_PRESENT|RTW_ERP_INFO_USE_PROTECTION);
+			pIE->data[0] &= ~(RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION);
 
 		if (pmlmepriv->num_sta_no_short_preamble > 0)
 			pIE->data[0] |= RTW_ERP_INFO_BARKER_PREAMBLE_MODE;
@@ -1281,12 +1281,12 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 
 	DBG_88E("%s\n", __func__);
 
-	pwps_ie = rtw_get_wps_ie(ie+_FIXED_IE_LENGTH_, ielen-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
+	pwps_ie = rtw_get_wps_ie(ie + _FIXED_IE_LENGTH_, ielen - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 	if (!pwps_ie || wps_ielen == 0)
 		return;
 
-	wps_offset = (uint)(pwps_ie-ie);
+	wps_offset = (uint)(pwps_ie - ie);
 
 	premainder_ie = pwps_ie + wps_ielen;
 
@@ -1303,15 +1303,15 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 		return;
 
 	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
-	if ((wps_offset+wps_ielen+2+remainder_ielen) <= MAX_IE_SZ) {
-		memcpy(pwps_ie, pwps_ie_src, wps_ielen+2);
-		pwps_ie += (wps_ielen+2);
+	if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
+		memcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);
+		pwps_ie += (wps_ielen + 2);
 
 		if (pbackup_remainder_ie)
 			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
 
 		/* update IELength */
-		pnetwork->IELength = wps_offset + (wps_ielen+2) + remainder_ielen;
+		pnetwork->IELength = wps_offset + (wps_ielen + 2) + remainder_ielen;
 	}
 
 	if (pbackup_remainder_ie)
@@ -1744,7 +1744,7 @@ int rtw_ap_inform_ch_switch(struct adapter *padapter, u8 new_ch, u8 ch_offset)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return ret;
 
 	DBG_88E(FUNC_NDEV_FMT" with ch:%u, offset:%u\n",
@@ -1781,7 +1781,7 @@ int rtw_sta_flush(struct adapter *padapter)
 
 	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
 
-	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return ret;
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
@@ -1815,7 +1815,7 @@ void sta_info_update(struct adapter *padapter, struct sta_info *psta)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	/* update wmm cap. */
-	if (WLAN_STA_WME&flags)
+	if (WLAN_STA_WME & flags)
 		psta->qos_option = 1;
 	else
 		psta->qos_option = 0;
@@ -1824,7 +1824,7 @@ void sta_info_update(struct adapter *padapter, struct sta_info *psta)
 		psta->qos_option = 0;
 
 	/* update 802.11n ht cap. */
-	if (WLAN_STA_HT&flags) {
+	if (WLAN_STA_HT & flags) {
 		psta->htpriv.ht_option = true;
 		psta->qos_option = 1;
 	} else {
-- 
2.32.0

