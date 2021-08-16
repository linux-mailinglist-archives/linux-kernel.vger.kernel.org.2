Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB83EDA62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhHPQAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbhHPQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240BCC061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so6172449wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ny9pYBRFdmJOmolsNufUj6wFEhT5RtROOwaqbehN35E=;
        b=hQH2u6INDtAVL7oYF7QdA2TFOq8WGTuYBWEek1VDWWR+SO+3vFYb4QVsFNvRrAp/Rr
         dHdRGU0m0LOCucjaXENaWQU6GBqyVxXUEE6tbW6GiujNd/4GGSKRVvOA+p8deIvLiOF/
         qxLnrbtrpVgwyNJm3vCHlaBv+6E41KgMBJ8gTG9b9Tsl1i8zuZz3GScSTTdKo3j5xC7p
         zZj8TmEZWjcueWsRjdFkDjkzCg9HhtxegdEqact5RnX2oy4hAfsXcRIibh1ZOEVjtO0m
         a/FlUSnP5mqGNcLwyccwIose36q2B973UNjMakXzMkaRsOUoCzlEkA4ivh0hTHsBY4wx
         Q7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ny9pYBRFdmJOmolsNufUj6wFEhT5RtROOwaqbehN35E=;
        b=hlZ84PwIHJBhV/qQyhABjDGQHC8/X1KfI899vkcQO0CsBEyYHlt82eRsFIGDu7sMQR
         ++m0w6dX03w3ltw2AXMETQkFHYjApcGoGKJ6vTsbuTUg66ImeivgvbewNzL953Ed54iC
         sSg9kyhzCSeBOVY+A3S8JsT5ojDp45awUxSQshbccikThVvmY7DPyxN0cdbzyztbN9Iu
         EK2TTPgTpBVlY42KDXUsYya7CU6ny/w2DRXgWMREIFxrtmiYi0gkn9bUvGY0CAbVKc5Z
         ECAdI3N5UxsQ0dfzUg0CYSh3QI/eXgfhNC5pTWwKoGCFeRd0HHOQFfCmSz8omjdzXVrl
         jEcw==
X-Gm-Message-State: AOAM532FCxlM7csO59qUdswCtfvYKhq87JQrD4m4shhmeuxqhxOMxtcZ
        l84f8yuItqmOlvjvhg/SjLw=
X-Google-Smtp-Source: ABdhPJzWwRsoo0fUd5bErFqZg9S+wVSokdRSCRPjABbReIPmqmHteme0GqAXzcOkTYW3aRgxg4Xh9g==
X-Received: by 2002:a05:600c:1c28:: with SMTP id j40mr15829934wms.104.1629129573540;
        Mon, 16 Aug 2021 08:59:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/23] staging: r8188eu: clean up spacing style issues in core/rtw_mlme_ext.c
Date:   Mon, 16 Aug 2021 17:58:06 +0200
Message-Id: <20210816155818.24005-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_mlme_ext.c reported by
checkpatch.

CHECK: spaces preferred around that ...
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 236 ++++++++++----------
 1 file changed, 118 insertions(+), 118 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 61b239651e1a..f6ee72d5af09 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -553,7 +553,7 @@ unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame
 		return _SUCCESS;
 
 	if (!check_fwstate(pmlmepriv, _FW_LINKED) &&
-	    !check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE|WIFI_AP_STATE))
+	    !check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE))
 		return _SUCCESS;
 
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _PROBEREQ_IE_OFFSET_, _SSID_IE_, (int *)&ielen,
@@ -564,7 +564,7 @@ unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame
 		if (is_valid_p2p_probereq)
 			goto _issue_probersp;
 
-		if ((ielen != 0 && memcmp((void *)(p+2), (void *)cur->Ssid.Ssid, cur->Ssid.SsidLength)) ||
+		if ((ielen != 0 && memcmp((void *)(p + 2), (void *)cur->Ssid.Ssid, cur->Ssid.SsidLength)) ||
 		    (ielen == 0 && pmlmeinfo->hidden_ssid_mode))
 			return _SUCCESS;
 
@@ -662,7 +662,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 			}
 
 			/* check the vendor of the assoc AP */
-			pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pframe+sizeof(struct rtw_ieee80211_hdr_3addr), len-sizeof(struct rtw_ieee80211_hdr_3addr));
+			pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pframe + sizeof(struct rtw_ieee80211_hdr_3addr), len - sizeof(struct rtw_ieee80211_hdr_3addr));
 
 			/* update TSF Value */
 			update_TSF(pmlmeext, pframe, len);
@@ -673,7 +673,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 			return _SUCCESS;
 		}
 
-		if (((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
+		if (((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
 			psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 			if (psta) {
 				ret = rtw_check_bcn_info(padapter, pframe, len);
@@ -688,7 +688,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 					update_beacon_info(padapter, pframe, len, psta);
 				process_p2p_ps_ie(padapter, (pframe + WLAN_HDR_A3_LEN), (len - WLAN_HDR_A3_LEN));
 			}
-		} else if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+		} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 			psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 			if (psta) {
 				/* update WMM, ERP in the beacon */
@@ -738,7 +738,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	u8 *pframe = precv_frame->rx_data;
 	uint len = precv_frame->len;
 
-	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
 	DBG_88E("+OnAuth\n");
@@ -808,7 +808,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	if ((pstat->auth_seq + 1) != seq) {
 		DBG_88E("(1)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-			seq, pstat->auth_seq+1);
+			seq, pstat->auth_seq + 1);
 		status = _STATS_OUT_OF_AUTH_SEQ_;
 		goto auth_fail;
 	}
@@ -821,7 +821,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			pstat->authalg = algorithm;
 		} else {
 			DBG_88E("(2)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-				seq, pstat->auth_seq+1);
+				seq, pstat->auth_seq + 1);
 			status = _STATS_OUT_OF_AUTH_SEQ_;
 			goto auth_fail;
 		}
@@ -858,7 +858,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			}
 		} else {
 			DBG_88E("(3)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-				seq, pstat->auth_seq+1);
+				seq, pstat->auth_seq + 1);
 			status = _STATS_OUT_OF_AUTH_SEQ_;
 			goto auth_fail;
 		}
@@ -997,7 +997,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	u32 p2pielen = 0;
 #endif /* CONFIG_88EU_P2P */
 
-	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
 	frame_type = GetFrameSubType(pframe);
@@ -1062,7 +1062,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		status = _STATS_FAILURE_;
 	} else {
 		/*  check if ssid match */
-		if (memcmp((void *)(p+2), cur->Ssid.Ssid, cur->Ssid.SsidLength))
+		if (memcmp((void *)(p + 2), cur->Ssid.Ssid, cur->Ssid.SsidLength))
 			status = _STATS_FAILURE_;
 
 		if (ie_len != cur->Ssid.SsidLength)
@@ -1083,14 +1083,14 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		status = _STATS_FAILURE_;
 		goto OnAssocReqFail;
 	} else {
-		memcpy(supportRate, p+2, ie_len);
+		memcpy(supportRate, p + 2, ie_len);
 		supportRateNum = ie_len;
 
 		p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _EXT_SUPPORTEDRATES_IE_, &ie_len,
 				pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 		if (p) {
 			if (supportRateNum <= sizeof(supportRate)) {
-				memcpy(supportRate+supportRateNum, p+2, ie_len);
+				memcpy(supportRate + supportRateNum, p + 2, ie_len);
 				supportRateNum += ie_len;
 			}
 		}
@@ -1118,12 +1118,12 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		wpa_ie = elems.rsn_ie;
 		wpa_ie_len = elems.rsn_ie_len;
 
-		if (rtw_parse_wpa2_ie(wpa_ie-2, wpa_ie_len+2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
+		if (rtw_parse_wpa2_ie(wpa_ie - 2, wpa_ie_len + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			pstat->dot8021xalg = 1;/* psk,  todo:802.1x */
 			pstat->wpa_psk |= BIT(1);
 
-			pstat->wpa2_group_cipher = group_cipher&psecuritypriv->wpa2_group_cipher;
-			pstat->wpa2_pairwise_cipher = pairwise_cipher&psecuritypriv->wpa2_pairwise_cipher;
+			pstat->wpa2_group_cipher = group_cipher & psecuritypriv->wpa2_group_cipher;
+			pstat->wpa2_pairwise_cipher = pairwise_cipher & psecuritypriv->wpa2_pairwise_cipher;
 
 			if (!pstat->wpa2_group_cipher)
 				status = WLAN_STATUS_GROUP_CIPHER_NOT_VALID;
@@ -1139,12 +1139,12 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		wpa_ie = elems.wpa_ie;
 		wpa_ie_len = elems.wpa_ie_len;
 
-		if (rtw_parse_wpa_ie(wpa_ie-2, wpa_ie_len+2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
+		if (rtw_parse_wpa_ie(wpa_ie - 2, wpa_ie_len + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			pstat->dot8021xalg = 1;/* psk,  todo:802.1x */
 			pstat->wpa_psk |= BIT(0);
 
-			pstat->wpa_group_cipher = group_cipher&psecuritypriv->wpa_group_cipher;
-			pstat->wpa_pairwise_cipher = pairwise_cipher&psecuritypriv->wpa_pairwise_cipher;
+			pstat->wpa_group_cipher = group_cipher & psecuritypriv->wpa_group_cipher;
+			pstat->wpa_pairwise_cipher = pairwise_cipher & psecuritypriv->wpa_pairwise_cipher;
 
 			if (!pstat->wpa_group_cipher)
 				status = WLAN_STATUS_GROUP_CIPHER_NOT_VALID;
@@ -1181,7 +1181,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 		/*  AP support WPA/RSN, and sta is going to do WPS, but AP is not ready */
 		/*  that the selected registrar of AP is _FLASE */
-		if ((psecuritypriv->wpa_psk > 0) && (pstat->flags & (WLAN_STA_WPS|WLAN_STA_MAYBE_WPS))) {
+		if ((psecuritypriv->wpa_psk > 0) && (pstat->flags & (WLAN_STA_WPS | WLAN_STA_MAYBE_WPS))) {
 			if (pmlmepriv->wps_beacon_ie) {
 				u8 selected_registrar = 0;
 
@@ -1215,10 +1215,10 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 			pstat->flags |= WLAN_STA_WPS;
 			copy_len = 0;
 		} else {
-			copy_len = ((wpa_ie_len+2) > sizeof(pstat->wpa_ie)) ? (sizeof(pstat->wpa_ie)) : (wpa_ie_len+2);
+			copy_len = ((wpa_ie_len + 2) > sizeof(pstat->wpa_ie)) ? (sizeof(pstat->wpa_ie)) : (wpa_ie_len + 2);
 		}
 		if (copy_len > 0)
-			memcpy(pstat->wpa_ie, wpa_ie-2, copy_len);
+			memcpy(pstat->wpa_ie, wpa_ie - 2, copy_len);
 	}
 	/*  check if there is WMM IE & support WWM-PS */
 	pstat->flags &= ~WLAN_STA_WME;
@@ -1234,37 +1234,37 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		for (;;) {
 			p = rtw_get_ie(p, _VENDOR_SPECIFIC_IE_, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 			if (p) {
-				if (!memcmp(p+2, WMM_IE, 6)) {
+				if (!memcmp(p + 2, WMM_IE, 6)) {
 					pstat->flags |= WLAN_STA_WME;
 
 					pstat->qos_option = 1;
-					pstat->qos_info = *(p+8);
+					pstat->qos_info = *(p + 8);
 
-					pstat->max_sp_len = (pstat->qos_info>>5)&0x3;
+					pstat->max_sp_len = (pstat->qos_info >> 5) & 0x3;
 
-					if ((pstat->qos_info&0xf) != 0xf)
+					if ((pstat->qos_info & 0xf) != 0xf)
 						pstat->has_legacy_ac = true;
 					else
 						pstat->has_legacy_ac = false;
 
-					if (pstat->qos_info&0xf) {
-						if (pstat->qos_info&BIT(0))
-							pstat->uapsd_vo = BIT(0)|BIT(1);
+					if (pstat->qos_info & 0xf) {
+						if (pstat->qos_info & BIT(0))
+							pstat->uapsd_vo = BIT(0) | BIT(1);
 						else
 							pstat->uapsd_vo = 0;
 
-						if (pstat->qos_info&BIT(1))
-							pstat->uapsd_vi = BIT(0)|BIT(1);
+						if (pstat->qos_info & BIT(1))
+							pstat->uapsd_vi = BIT(0) | BIT(1);
 						else
 							pstat->uapsd_vi = 0;
 
-						if (pstat->qos_info&BIT(2))
-							pstat->uapsd_bk = BIT(0)|BIT(1);
+						if (pstat->qos_info & BIT(2))
+							pstat->uapsd_bk = BIT(0) | BIT(1);
 						else
 							pstat->uapsd_bk = 0;
 
-						if (pstat->qos_info&BIT(3))
-							pstat->uapsd_be = BIT(0)|BIT(1);
+						if (pstat->qos_info & BIT(3))
+							pstat->uapsd_be = BIT(0) | BIT(1);
 						else
 							pstat->uapsd_be = 0;
 					}
@@ -1288,14 +1288,14 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	} else {
 		pstat->flags &= ~WLAN_STA_HT;
 	}
-	if ((!pmlmepriv->htpriv.ht_option) && (pstat->flags&WLAN_STA_HT)) {
+	if ((!pmlmepriv->htpriv.ht_option) && (pstat->flags & WLAN_STA_HT)) {
 		status = _STATS_FAILURE_;
 		goto OnAssocReqFail;
 	}
 
 	if ((pstat->flags & WLAN_STA_HT) &&
-	    ((pstat->wpa2_pairwise_cipher&WPA_CIPHER_TKIP) ||
-	    (pstat->wpa_pairwise_cipher&WPA_CIPHER_TKIP))) {
+	    ((pstat->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
+	    (pstat->wpa_pairwise_cipher & WPA_CIPHER_TKIP))) {
 		DBG_88E("HT: %pM tried to "
 			"use TKIP with HT association\n", pstat->hwaddr);
 
@@ -1473,7 +1473,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	pmlmeinfo->slotTime = (pmlmeinfo->capability & BIT(10)) ? 9 : 20;
 
 	/* AID */
-	pmlmeinfo->aid = (int)(le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 4))&0x3fff);
+	pmlmeinfo->aid = (int)(le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 4)) & 0x3fff);
 	res = pmlmeinfo->aid;
 
 	/* following are moved to join event callback function */
@@ -1733,7 +1733,7 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 
 	DBG_88E("%s\n", __func__);
 
-	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		if (!(pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS))
 			return _SUCCESS;
 
@@ -3515,8 +3515,8 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_PROBEREQ);
 
-	pframe += sizeof (struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof (struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_PROVISION_DIS_REQ))
 		pframe = rtw_set_ie(pframe, _SSID_IE_, pwdinfo->tx_prov_disc_info.ssid.SsidLength, pwdinfo->tx_prov_disc_info.ssid.Ssid, &pattrib->pktlen);
@@ -3794,7 +3794,7 @@ static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 	struct adapter *adapter = recv_frame->adapter;
 	struct mlme_ext_priv *mlmeext = &adapter->mlmeextpriv;
 	u8 *frame = recv_frame->rx_data;
-	u16 seq_ctrl = ((recv_frame->attrib.seq_num&0xffff) << 4) |
+	u16 seq_ctrl = ((recv_frame->attrib.seq_num & 0xffff) << 4) |
 		(recv_frame->attrib.frag_num & 0xf);
 
 	if (GetRetry(frame)) {
@@ -4237,7 +4237,7 @@ unsigned int OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	category = frame_body[0];
 
-	for (i = 0; i < sizeof(OnAction_tbl)/sizeof(struct action_handler); i++) {
+	for (i = 0; i < sizeof(OnAction_tbl) / sizeof(struct action_handler); i++) {
 		ptable = &OnAction_tbl[i];
 		if (category == ptable->num)
 			ptable->func(padapter, precv_frame);
@@ -4389,7 +4389,7 @@ static int update_hidden_ssid(u8 *ies, u32 ies_len, u8 hidden_ssid_mode)
 			remain_len = ies_len - (next_ie - ies);
 
 			ssid_ie[1] = 0;
-			memcpy(ssid_ie+2, next_ie, remain_len);
+			memcpy(ssid_ie + 2, next_ie, remain_len);
 			len_diff -= ssid_len_ori;
 
 			break;
@@ -4428,7 +4428,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 		DBG_88E("%s, alloc mgnt frame fail\n", __func__);
 		return;
 	}
-#if defined (CONFIG_88EU_AP_MODE)
+#if defined(CONFIG_88EU_AP_MODE)
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
 #endif /* if defined (CONFIG_88EU_AP_MODE) */
 
@@ -4454,14 +4454,14 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	SetFrameSubType(pframe, WIFI_BEACON);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof (struct rtw_ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 #ifdef CONFIG_88EU_P2P
 		/*  for P2P : Primary Device Type & Device Name */
 		u32 wpsielen = 0, insert_len = 0;
 		u8 *wpsie = NULL;
-		wpsie = rtw_get_wps_ie(cur_network->IEs+_FIXED_IE_LENGTH_, cur_network->IELength-_FIXED_IE_LENGTH_, NULL, &wpsielen);
+		wpsie = rtw_get_wps_ie(cur_network->IEs + _FIXED_IE_LENGTH_, cur_network->IELength - _FIXED_IE_LENGTH_, NULL, &wpsielen);
 
 		if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO) && wpsie && wpsielen > 0) {
 			uint wps_offset, remainder_ielen;
@@ -4471,7 +4471,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 			premainder_ie = wpsie + wpsielen;
 			remainder_ielen = cur_network->IELength - wps_offset - wpsielen;
 			pframe_wscie = pframe + wps_offset;
-			memcpy(pframe, cur_network->IEs, wps_offset+wpsielen);
+			memcpy(pframe, cur_network->IEs, wps_offset + wpsielen);
 			pframe += (wps_offset + wpsielen);
 			pattrib->pktlen += (wps_offset + wpsielen);
 
@@ -4512,7 +4512,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 			insert_len += pwdinfo->device_name_len;
 
 			/* update wsc ie length */
-			*(pframe_wscie+1) = (wpsielen-2) + insert_len;
+			*(pframe_wscie + 1) = (wpsielen - 2) + insert_len;
 
 			/* pframe move to end */
 			pframe += insert_len;
@@ -4528,20 +4528,20 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 			int len_diff;
 			memcpy(pframe, cur_network->IEs, cur_network->IELength);
 			len_diff = update_hidden_ssid(
-				pframe+_BEACON_IE_OFFSET_
-				, cur_network->IELength-_BEACON_IE_OFFSET_
+				pframe + _BEACON_IE_OFFSET_
+				, cur_network->IELength - _BEACON_IE_OFFSET_
 				, pmlmeinfo->hidden_ssid_mode
 			);
-			pframe += (cur_network->IELength+len_diff);
-			pattrib->pktlen += (cur_network->IELength+len_diff);
+			pframe += (cur_network->IELength + len_diff);
+			pattrib->pktlen += (cur_network->IELength + len_diff);
 		}
 
 		{
 			u8 *wps_ie;
 			uint wps_ielen;
 			u8 sr = 0;
-			wps_ie = rtw_get_wps_ie(pmgntframe->buf_addr+TXDESC_OFFSET+sizeof (struct rtw_ieee80211_hdr_3addr)+_BEACON_IE_OFFSET_,
-				pattrib->pktlen-sizeof (struct rtw_ieee80211_hdr_3addr)-_BEACON_IE_OFFSET_, NULL, &wps_ielen);
+			wps_ie = rtw_get_wps_ie(pmgntframe->buf_addr + TXDESC_OFFSET + sizeof(struct rtw_ieee80211_hdr_3addr) + _BEACON_IE_OFFSET_,
+				pattrib->pktlen - sizeof(struct rtw_ieee80211_hdr_3addr) - _BEACON_IE_OFFSET_, NULL, &wps_ielen);
 			if (wps_ie && wps_ielen > 0)
 				rtw_get_wps_attr_content(wps_ie,  wps_ielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
 			if (sr != 0)
@@ -4610,7 +4610,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	/* todo:HT for adhoc */
 _issue_bcn:
 
-#if defined (CONFIG_88EU_AP_MODE)
+#if defined(CONFIG_88EU_AP_MODE)
 	pmlmepriv->update_bcn = false;
 
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
@@ -4639,7 +4639,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	__le16 *fctrl;
 	unsigned char					*mac, *bssid;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
-#if defined (CONFIG_88EU_AP_MODE)
+#if defined(CONFIG_88EU_AP_MODE)
 	u8 *pwps_ie;
 	uint wps_ielen;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -4688,8 +4688,8 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		return;
 
 #if defined(CONFIG_88EU_AP_MODE)
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
-		pwps_ie = rtw_get_wps_ie(cur_network->IEs+_FIXED_IE_LENGTH_, cur_network->IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
+		pwps_ie = rtw_get_wps_ie(cur_network->IEs + _FIXED_IE_LENGTH_, cur_network->IELength - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 		/* inerset & update wps_probe_resp_ie */
 		if (pmlmepriv->wps_probe_resp_ie && pwps_ie && wps_ielen > 0) {
@@ -4707,13 +4707,13 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 			pattrib->pktlen += wps_offset;
 
 			wps_ielen = (uint)pmlmepriv->wps_probe_resp_ie[1];/* to get ie data len */
-			if ((wps_offset+wps_ielen+2) <= MAX_IE_SZ) {
-				memcpy(pframe, pmlmepriv->wps_probe_resp_ie, wps_ielen+2);
-				pframe += wps_ielen+2;
-				pattrib->pktlen += wps_ielen+2;
+			if ((wps_offset + wps_ielen + 2) <= MAX_IE_SZ) {
+				memcpy(pframe, pmlmepriv->wps_probe_resp_ie, wps_ielen + 2);
+				pframe += wps_ielen + 2;
+				pattrib->pktlen += wps_ielen + 2;
 			}
 
-			if ((wps_offset+wps_ielen+2+remainder_ielen) <= MAX_IE_SZ) {
+			if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
 				memcpy(pframe, premainder_ie, remainder_ielen);
 				pframe += remainder_ielen;
 				pattrib->pktlen += remainder_ielen;
@@ -4756,7 +4756,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		/*  DS parameter set */
 		pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&cur_network->Configuration.DSConfig, &pattrib->pktlen);
 
-		if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+		if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 			u8 erpinfo = 0;
 			u32 ATIMWindow;
 			/*  IBSS Parameter Set... */
@@ -4839,8 +4839,8 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_PROBEREQ);
 
-	pframe += sizeof (struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof (struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
 	if (pssid)
 		pframe = rtw_set_ie(pframe, _SSID_IE_, pssid->SsidLength, pssid->Ssid, &pattrib->pktlen);
@@ -5121,7 +5121,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, pstat->bssratelen, pstat->bssrateset, &pattrib->pktlen);
 	} else {
 		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, pstat->bssrateset, &pattrib->pktlen);
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, pstat->bssratelen-8, pstat->bssrateset+8, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, pstat->bssratelen - 8, pstat->bssrateset + 8, &pattrib->pktlen);
 	}
 
 	if ((pstat->flags & WLAN_STA_HT) && (pmlmepriv->htpriv.ht_option)) {
@@ -5130,17 +5130,17 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 		/* FILL HT CAP INFO IE */
 		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _HT_CAPABILITY_IE_, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_));
 		if (pbuf && ie_len > 0) {
-			memcpy(pframe, pbuf, ie_len+2);
-			pframe += (ie_len+2);
-			pattrib->pktlen += (ie_len+2);
+			memcpy(pframe, pbuf, ie_len + 2);
+			pframe += (ie_len + 2);
+			pattrib->pktlen += (ie_len + 2);
 		}
 
 		/* FILL HT ADD INFO IE */
 		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _HT_ADD_INFO_IE_, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_));
 		if (pbuf && ie_len > 0) {
-			memcpy(pframe, pbuf, ie_len+2);
-			pframe += (ie_len+2);
-			pattrib->pktlen += (ie_len+2);
+			memcpy(pframe, pbuf, ie_len + 2);
+			pframe += (ie_len + 2);
+			pattrib->pktlen += (ie_len + 2);
 		}
 	}
 
@@ -5151,10 +5151,10 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 
 		for (pbuf = ie + _BEACON_IE_OFFSET_;; pbuf += (ie_len + 2)) {
 			pbuf = rtw_get_ie(pbuf, _VENDOR_SPECIFIC_IE_, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2)));
-			if (pbuf && !memcmp(pbuf+2, WMM_PARA_IE, 6)) {
-				memcpy(pframe, pbuf, ie_len+2);
-				pframe += (ie_len+2);
-				pattrib->pktlen += (ie_len+2);
+			if (pbuf && !memcmp(pbuf + 2, WMM_PARA_IE, 6)) {
+				memcpy(pframe, pbuf, ie_len + 2);
+				pframe += (ie_len + 2);
+				pattrib->pktlen += (ie_len + 2);
 				break;
 			}
 
@@ -5276,8 +5276,8 @@ void issue_assocreq(struct adapter *padapter)
 		/*  Check if the AP's supported rates are also supported by STA. */
 		for (j = 0; j < sta_bssrate_len; j++) {
 			 /*  Avoid the proprietary data rate (22Mbps) of Handlink WSG-4000 AP */
-			if ((pmlmeinfo->network.SupportedRates[i]|IEEE80211_BASIC_RATE_MASK)
-					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK))
+			if ((pmlmeinfo->network.SupportedRates[i] | IEEE80211_BASIC_RATE_MASK)
+					== (sta_bssrate[j] | IEEE80211_BASIC_RATE_MASK))
 				break;
 		}
 
@@ -5557,9 +5557,9 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)
 		SetFrDs(fctrl);
-	else if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE)
+	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
 		SetToDs(fctrl);
 
 	if (power_mode)
@@ -5672,9 +5672,9 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)
 		SetFrDs(fctrl);
-	else if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE)
+	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
 		SetToDs(fctrl);
 
 	if (pattrib->mdata)
@@ -5868,7 +5868,7 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 	return ret;
 }
 
-void issue_action_spct_ch_switch (struct adapter *padapter, u8 *ra, u8 new_ch, u8 ch_offset)
+void issue_action_spct_ch_switch(struct adapter *padapter, u8 *ra, u8 new_ch, u8 ch_offset)
 {
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
@@ -5918,7 +5918,7 @@ void issue_action_spct_ch_switch (struct adapter *padapter, u8 *ra, u8 new_ch, u
 		pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
 	}
 
-	pframe = rtw_set_ie_ch_switch (pframe, &pattrib->pktlen, 0, new_ch, 0);
+	pframe = rtw_set_ie_ch_switch(pframe, &pattrib->pktlen, 0, new_ch, 0);
 	pframe = rtw_set_ie_secondary_ch_offset(pframe, &pattrib->pktlen,
 		hal_ch_offset_to_secondary_ch_offset(ch_offset));
 
@@ -6000,7 +6000,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 
 			psta = rtw_get_stainfo(pstapriv, raddr);
 			if (psta) {
-				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07]&0xfff) + 1;
+				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07] & 0xfff) + 1;
 
 				DBG_88E("BA_starting_seqctrl=%d for TID=%d\n", start_seq, status & 0x07);
 
@@ -6200,7 +6200,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u16 tid;
 
-	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		if (!(pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS))
 			return _SUCCESS;
 
@@ -6212,7 +6212,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
 				DBG_88E("rx agg disable tid(%d)\n", tid);
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
+				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
 			}
@@ -6221,7 +6221,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
 				DBG_88E("tx agg disable tid(%d)\n", tid);
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
+				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			}
@@ -6247,7 +6247,7 @@ unsigned int send_beacon(struct adapter *padapter)
 			yield();
 			rtw_hal_get_hwreg(padapter, HW_VAR_BCN_VALID, (u8 *)(&bxmitok));
 			poll++;
-		} while ((poll%10) != 0 && !bxmitok && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
+		} while ((poll % 10) != 0 && !bxmitok && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
 	} while (!bxmitok && issue < 100 && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
@@ -6522,7 +6522,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 
 	p = rtw_get_ie(bssid->IEs + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
-		if (len > (NDIS_802_11_LENGTH_RATES_EX-i)) {
+		if (len > (NDIS_802_11_LENGTH_RATES_EX - i)) {
 			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
 			return _FAIL;
 		}
@@ -6582,7 +6582,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 			struct HT_caps_element	*pHT_caps;
 			pHT_caps = (struct HT_caps_element *)(p + 2);
 
-			if (le16_to_cpu(pHT_caps->u.HT_cap_element.HT_caps_info)&BIT(14))
+			if (le16_to_cpu(pHT_caps->u.HT_cap_element.HT_caps_info) & BIT(14))
 				pmlmepriv->num_FortyMHzIntolerant++;
 		} else {
 			pmlmepriv->num_sta_no_ht++;
@@ -6612,7 +6612,7 @@ void start_create_ibss(struct adapter *padapter)
 	/* udpate capability */
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
-	if (caps&cap_IBSS) {/* adhoc master */
+	if (caps & cap_IBSS) {/* adhoc master */
 		val8 = 0xcf;
 		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
@@ -6665,7 +6665,7 @@ void start_clnt_join(struct adapter *padapter)
 	/* udpate capability */
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
-	if (caps&cap_ESS) {
+	if (caps & cap_ESS) {
 		Set_MSR(padapter, WIFI_FW_STATION_STATE);
 
 		val8 = (pmlmeinfo->auth_algo == dot11AuthAlgrthm_8021X) ? 0xcc : 0xcf;
@@ -6680,10 +6680,10 @@ void start_clnt_join(struct adapter *padapter)
 		beacon_timeout = decide_wait_for_beacon_timeout(pmlmeinfo->bcn_interval);
 		set_link_timer(pmlmeext, beacon_timeout);
 		_set_timer(&padapter->mlmepriv.assoc_timer,
-			   (REAUTH_TO * REAUTH_LIMIT) + (REASSOC_TO*REASSOC_LIMIT) + beacon_timeout);
+			   (REAUTH_TO * REAUTH_LIMIT) + (REASSOC_TO * REASSOC_LIMIT) + beacon_timeout);
 
 		pmlmeinfo->state = WIFI_FW_AUTH_NULL | WIFI_FW_STATION_STATE;
-	} else if (caps&cap_IBSS) { /* adhoc client */
+	} else if (caps & cap_IBSS) { /* adhoc client */
 		Set_MSR(padapter, WIFI_FW_ADHOC_STATE);
 
 		val8 = 0xcf;
@@ -6757,7 +6757,7 @@ unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr
 
 	DBG_88E("%s\n", __func__);
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
 			report_del_sta_event(padapter, MacAddr, reason);
@@ -7233,7 +7233,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 		goto exit_mlmeext_joinbss_event_callback;
 	}
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		/* for bc/mc */
 		psta_bmc = rtw_get_bcmc_stainfo(padapter);
 		if (psta_bmc) {
@@ -7274,14 +7274,14 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 		/* set per sta rate after updating HT cap. */
 		set_sta_rate(padapter, psta);
 		rtw_hal_set_hwreg(padapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&psta->mac_id);
-		media_status = (psta->mac_id<<8)|1; /*   MACID|OPMODE: 1 means connect */
+		media_status = (psta->mac_id << 8) | 1; /*   MACID|OPMODE: 1 means connect */
 		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
 	}
 
 	join_type = 2;
 	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
 		/*  correcting TSF */
 		correct_TSF(padapter, pmlmeext);
 	}
@@ -7300,7 +7300,7 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 
 	DBG_88E("%s\n", __func__);
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {/* adhoc master or sta_count>1 */
 			/* nothing to do */
 		} else { /* adhoc client */
@@ -7372,9 +7372,9 @@ void _linked_rx_signal_strehgth_display(struct adapter *padapter)
 	u8 mac_id;
 	int UndecoratedSmoothedPWDB;
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE)
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
 		mac_id = 0;
-	else if ((pmlmeinfo->state&0x03) == _HW_STATE_AP_)
+	else if ((pmlmeinfo->state & 0x03) == _HW_STATE_AP_)
 		mac_id = 2;
 
 	rtw_hal_get_def_var(padapter, HW_DEF_RA_INFO_DUMP, &mac_id);
@@ -7637,7 +7637,7 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
 		pmlmeinfo->state = WIFI_FW_AP_STATE;
 		type = _HW_STATE_AP_;
 	} else if (psetop->mode == Ndis802_11Infrastructure) {
-		pmlmeinfo->state &= ~(BIT(0)|BIT(1));/*  clear state */
+		pmlmeinfo->state &= ~(BIT(0) | BIT(1));/*  clear state */
 		pmlmeinfo->state |= WIFI_FW_STATION_STATE;/* set to	STATION_STATE */
 		type = _HW_STATE_STATION_;
 	} else if (psetop->mode == Ndis802_11IBSS) {
@@ -7834,7 +7834,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	u8 val8;
 
 	if (is_client_associated_to_ap(padapter))
-		issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
+		issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms / 100, 100);
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_DISCONNECT, NULL);
 	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, null_addr);
@@ -7842,7 +7842,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	/* restore to initial setting. */
 	update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
 
-	if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
+	if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)) {
 		/* Stop BCN */
 		val8 = 0;
 		rtw_hal_set_hwreg(padapter, HW_VAR_BCN_FUNC, (u8 *)(&val8));
@@ -7876,7 +7876,7 @@ static int rtw_scan_ch_decision(struct adapter *padapter, struct rtw_ieee80211_c
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 
 	/* clear out first */
-	memset(out, 0, sizeof(struct rtw_ieee80211_channel)*out_num);
+	memset(out, 0, sizeof(struct rtw_ieee80211_channel) * out_num);
 
 	/* acquire channels from in */
 	j = 0;
@@ -8051,7 +8051,7 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 
 	DBG_88E_LEVEL(_drv_info_, "set pairwise key to hw: alg:%d(WEP40-1 WEP104-5 TKIP-2 AES-4) camid:%d\n",
 		      pparm->algorithm, cam_id);
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
@@ -8066,7 +8066,7 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 
 			DBG_88E("r871x_set_stakey_hdl(): enc_algorithm=%d\n", pparm->algorithm);
 
-			if ((psta->mac_id < 1) || (psta->mac_id > (NUM_STA-4))) {
+			if ((psta->mac_id < 1) || (psta->mac_id > (NUM_STA - 4))) {
 				DBG_88E("r871x_set_stakey_hdl():set_stakey failed, mac_id(aid)=%d\n", psta->mac_id);
 				return H2C_REJECTED;
 			}
@@ -8110,7 +8110,7 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 		return	H2C_SUCCESS;
 
 	if (((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && (pmlmeinfo->HT_enable)) ||
-	    ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
+	    ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)) {
 		issue_action_BA(padapter, pparm->addr, RTW_WLAN_ACTION_ADDBA_REQ, (u16)pparm->tid);
 		_set_timer(&psta->addba_retry_timer, ADDBA_TO);
 	} else {
@@ -8144,8 +8144,8 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 
 	memcpy(&ptxBeacon_parm->network, &pmlmeinfo->network, sizeof(struct wlan_bssid_ex));
 
-	len_diff = update_hidden_ssid(ptxBeacon_parm->network.IEs+_BEACON_IE_OFFSET_,
-				      ptxBeacon_parm->network.IELength-_BEACON_IE_OFFSET_,
+	len_diff = update_hidden_ssid(ptxBeacon_parm->network.IEs + _BEACON_IE_OFFSET_,
+				      ptxBeacon_parm->network.IELength - _BEACON_IE_OFFSET_,
 				      pmlmeinfo->hidden_ssid_mode);
 	ptxBeacon_parm->network.IELength += len_diff;
 
@@ -8167,8 +8167,8 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	struct evt_priv *pevt_priv = &padapter->evtpriv;
 
 	peventbuf = (uint *)pbuf;
-	evt_sz = (u16)(*peventbuf&0xffff);
-	evt_code = (u8)((*peventbuf>>16)&0xff);
+	evt_sz = (u16)(*peventbuf & 0xffff);
+	evt_code = (u8)((*peventbuf >> 16) & 0xff);
 
 	/*  checking if event code is valid */
 	if (evt_code >= MAX_C2HEVT)
@@ -8220,7 +8220,7 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 		if (!psta_bmc)
 			return H2C_SUCCESS;
 
-		if ((pstapriv->tim_bitmap&BIT(0)) && (psta_bmc->sleepq_len > 0)) {
+		if ((pstapriv->tim_bitmap & BIT(0)) && (psta_bmc->sleepq_len > 0)) {
 			msleep(10);/*  10ms, ATIM(HIQ) Windows */
 			spin_lock_bh(&psta_bmc->sleep_q.lock);
 
-- 
2.32.0

