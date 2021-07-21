Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92833D0FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbhGUM50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbhGUM5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E76C061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h2so2441987edt.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdqtuLSomM345oz0maqt9DgjIUDOYD5gAX6DgQ2CV/0=;
        b=nLT/JMF8N8fnKbBceVGlDwdWMPiS0PJiNRaXTWY9zNr473h6GGt7Hi7MVul8GcEZjL
         k+kuG9N55/gPNkOYHTD10JBH7bROhOo0GK1S2V9DXlwlpUTYr61WK5WXduGVMrr5OtGK
         +rhFAK9+Z0YZcRAw3mXpbk9eaXKEcONWxO2Cgd+LN+Lu1dSkqBm6dhgdk5+UK9BOI5ki
         0vlkPftFFJtwoGvlQHdQdHSRYZppPUZriZYKfmH9Ggvb0UijvPy8j0fwbON3UGi6IRLO
         UtFkcrahtoLMfVCUj01Bd0ER+HvM11kS3EhLgFJVIEkCwA7OvbnBtgqE8LKEmc/vtDhg
         XSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdqtuLSomM345oz0maqt9DgjIUDOYD5gAX6DgQ2CV/0=;
        b=bdvcjk8iGqwUPCP9sL2BVnyi+WohQeVg3nhgqKtZoPE4teeZIHgPyzcp5FAQ+AGwu9
         nBRB0hg6df+sTKDYUIdaqljGA910qRh9ETuPUxTwljdln5mG3ryqpc3u+UyUAlQPKWDH
         euO1rZxXfJS2kZHLDJwaQwT3agtoNAHx7l0LdtKtRgx8EbjKJCDo6mDhfkt4Jwo814a/
         81iRCDDLBgbKprpTYbdboVp1jkK3UJFay3FmS3XAoITx/nYSBhixwX0JP45TBr1dTMMS
         LEF1hUbHGNdNuIYZZX28ddx5JXQsF20EHag0J5/o2J7oEUrsMURNkpdBf57m5S/0MNl8
         71/A==
X-Gm-Message-State: AOAM532mp2uCdHLyGcIcB8luuA3qrxz+62QmV6kDKvcrOo+MDEgDBtrt
        5EcWQVg6/4Q8GBjcjdr5rB2JMwNLpKU=
X-Google-Smtp-Source: ABdhPJwJXtDoVlWcZsB47LNZGUsPcVtRTmpZdhlgZlTpfVc9BFQfbnfcxnWxXerHHoKdXvYv9LV6eQ==
X-Received: by 2002:aa7:d8c6:: with SMTP id k6mr48371354eds.374.1626874664472;
        Wed, 21 Jul 2021 06:37:44 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id d2sm8295749ejo.13.2021.07.21.06.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/16] staging: rtl8723bs: fix camel case in IE structures
Date:   Wed, 21 Jul 2021 15:37:20 +0200
Message-Id: <c1b36466fb5e17aa0dbbcdf6dfef3a82f9739c00.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case in IE structures all over the driver.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 20 ++++++-------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 28 +++++++++----------
 .../staging/rtl8723bs/include/wlan_bssdef.h   | 10 +++----
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5942e51b23b6..07986eeafe08 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1428,7 +1428,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	for (i = (6 + WLAN_HDR_A3_LEN); i < pkt_len;) {
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
 
-		switch (pIE->ElementID) {
+		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
 			if (!memcmp(pIE->data, WMM_PARA_OUI, 6))	/* WMM */
 				WMM_param_handler(padapter, pIE);
@@ -1450,7 +1450,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 			break;
 		}
 
-		i += (pIE->Length + 2);
+		i += (pIE->length + 2);
 	}
 
 	pmlmeinfo->state &= (~WIFI_FW_ASSOC_STATE);
@@ -2980,12 +2980,12 @@ void issue_assocreq(struct adapter *padapter)
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
 		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
 
-		switch (pIE->ElementID) {
+		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
 			if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
 					(!memcmp(pIE->data, WMM_OUI, 4)) ||
 					(!memcmp(pIE->data, WPS_OUI, 4))) {
-				vs_ie_length = pIE->Length;
+				vs_ie_length = pIE->length;
 				if ((!padapter->registrypriv.wifi_spec) && (!memcmp(pIE->data, WPS_OUI, 4))) {
 					/* Commented by Kurt 20110629
 					 * In some older APs, WPS handshake
@@ -3001,26 +3001,26 @@ void issue_assocreq(struct adapter *padapter)
 			break;
 
 		case WLAN_EID_RSN:
-			pframe = rtw_set_ie(pframe, WLAN_EID_RSN, pIE->Length, pIE->data, &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, WLAN_EID_RSN, pIE->length, pIE->data, &(pattrib->pktlen));
 			break;
 		case WLAN_EID_HT_CAPABILITY:
 			if (padapter->mlmepriv.htpriv.ht_option) {
 				if (!(is_ap_in_tkip(padapter))) {
 					memcpy(&(pmlmeinfo->HT_caps), pIE->data, sizeof(struct HT_caps_element));
-					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY, pIE->Length, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
+					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY, pIE->length, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
 				}
 			}
 			break;
 
 		case WLAN_EID_EXT_CAPABILITY:
 			if (padapter->mlmepriv.htpriv.ht_option)
-				pframe = rtw_set_ie(pframe, WLAN_EID_EXT_CAPABILITY, pIE->Length, pIE->data, &(pattrib->pktlen));
+				pframe = rtw_set_ie(pframe, WLAN_EID_EXT_CAPABILITY, pIE->length, pIE->data, &(pattrib->pktlen));
 			break;
 		default:
 			break;
 		}
 
-		i += (pIE->Length + 2);
+		i += (pIE->length + 2);
 	}
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
@@ -5411,7 +5411,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	for (i = _FIXED_IE_LENGTH_; i < pnetwork->ie_length;) {
 		pIE = (struct ndis_80211_var_ie *)(pnetwork->ies + i);
 
-		switch (pIE->ElementID) {
+		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:/* Get WMM IE. */
 			if (!memcmp(pIE->data, WMM_OUI, 4))
 				WMM_param_handler(padapter, pIE);
@@ -5457,7 +5457,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 			break;
 		}
 
-		i += (pIE->Length + 2);
+		i += (pIE->length + 2);
 	}
 
 	/* check channel, bandwidth, offset and switch */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index efd0cbbde389..2a2a8634beb7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -909,7 +909,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 	if (phtpriv->ht_option == false)
 		return;
 
-	if (pIE->Length > sizeof(struct HT_info_element))
+	if (pIE->length > sizeof(struct HT_info_element))
 		return;
 
 	pHT_info = (struct HT_info_element *)pIE->data;
@@ -1001,7 +1001,7 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	pmlmeinfo->HT_caps_enable = 1;
 
-	for (i = 0; i < (pIE->Length); i++) {
+	for (i = 0; i < (pIE->length); i++) {
 		if (i != 2) {
 			/* Commented by Albert 2010/07/12 */
 			/* Got the endian issue here. */
@@ -1075,11 +1075,11 @@ void HT_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	if (phtpriv->ht_option == false)
 		return;
 
-	if (pIE->Length > sizeof(struct HT_info_element))
+	if (pIE->length > sizeof(struct HT_info_element))
 		return;
 
 	pmlmeinfo->HT_info_enable = 1;
-	memcpy(&(pmlmeinfo->HT_info), pIE->data, pIE->Length);
+	memcpy(&(pmlmeinfo->HT_info), pIE->data, pIE->length);
 }
 
 void HTOnAssocRsp(struct adapter *padapter)
@@ -1117,11 +1117,11 @@ void ERP_IE_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	if (pIE->Length > 1)
+	if (pIE->length > 1)
 		return;
 
 	pmlmeinfo->ERP_enable = 1;
-	memcpy(&(pmlmeinfo->ERP_IE), pIE->data, pIE->Length);
+	memcpy(&(pmlmeinfo->ERP_IE), pIE->data, pIE->length);
 }
 
 void VCS_update(struct adapter *padapter, struct sta_info *psta)
@@ -1369,10 +1369,10 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 	for (i = 0; i < len;) {
 		pIE = (struct ndis_80211_var_ie *)(pframe + (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN) + i);
 
-		switch (pIE->ElementID) {
+		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
 			/* to update WMM parameter set while receiving beacon */
-			if (!memcmp(pIE->data, WMM_PARA_OUI, 6) && pIE->Length == WLAN_WMM_LEN)	/* WMM */
+			if (!memcmp(pIE->data, WMM_PARA_OUI, 6) && pIE->length == WLAN_WMM_LEN)	/* WMM */
 				if (WMM_param_handler(padapter, pIE))
 					report_wmm_edca_update(padapter);
 
@@ -1392,7 +1392,7 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 			break;
 		}
 
-		i += (pIE->Length + 2);
+		i += (pIE->length + 2);
 	}
 }
 
@@ -1408,7 +1408,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 		for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
 			pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
 
-			switch (pIE->ElementID) {
+			switch (pIE->element_id) {
 			case WLAN_EID_VENDOR_SPECIFIC:
 				if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
 					return true;
@@ -1424,7 +1424,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 				break;
 			}
 
-			i += (pIE->Length + 2);
+			i += (pIE->length + 2);
 		}
 
 		return false;
@@ -1480,7 +1480,7 @@ static u32 get_realtek_assoc_AP_vender(struct ndis_80211_var_ie *pIE)
 {
 	u32 Vender = HT_IOT_PEER_REALTEK;
 
-	if (pIE->Length >= 5) {
+	if (pIE->length >= 5) {
 		if (pIE->data[4] == 1)
 			/* if (pIE->data[5] & RT_HT_CAP_USE_LONG_PREAMBLE) */
 			/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_LONG_PREAMBLE; */
@@ -1511,7 +1511,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < len;) {
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
 
-		switch (pIE->ElementID) {
+		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
 			if ((!memcmp(pIE->data, ARTHEROS_OUI1, 3)) || (!memcmp(pIE->data, ARTHEROS_OUI2, 3)))
 				return HT_IOT_PEER_ATHEROS;
@@ -1536,7 +1536,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 			break;
 		}
 
-		i += (pIE->Length + 2);
+		i += (pIE->length + 2);
 	}
 
 	return HT_IOT_PEER_UNKNOWN;
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index 8c9d78c35650..1915b524fd2d 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -52,14 +52,14 @@ enum ndis_802_11_network_infrastructure {
 };
 
 struct ndis_802_11_fix_ie {
-	u8  Timestamp[8];
-	u16  BeaconInterval;
-	u16  Capabilities;
+	u8  time_stamp[8];
+	u16  beacon_interval;
+	u16  capabilities;
 };
 
 struct ndis_80211_var_ie {
-	u8  ElementID;
-	u8  Length;
+	u8  element_id;
+	u8  length;
 	u8  data[];
 };
 
-- 
2.20.1

