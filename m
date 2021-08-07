Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478DE3E34B4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhHGKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbhHGKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47BEC06179B
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ec13so16896953edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVKrDrySQ626g+ZWAazaB+SotHhUYrhsB+vObm8/eL4=;
        b=LgdfMg6NMh7abPqkYhVUirCE8SkkCh5Vv1uH/CIDYsoDmLCAX5PWD0YRSYtG55dv61
         zTH1Piqa6k8GEtv9hK+MIkVo5Xho7GfM2iroiULaOywUOpKohI7Jq+AdAuzcr8JEpjg0
         khVSQNXMvDmptS4oZqby15V+dzPfHjv7gdPMHDGrkwzYQzobbIMIuYstJG06KclUuuPM
         fRaYYc8pfdwFmLhQIMizSdiloRUkjlwq29sGWwRZC0Rl+c0iZ787eLzAwR5jVvJbJuSV
         YF9JqBefoYyIem4nDgO0VsIUjcIMnXcAvEHryIZSewF84poofoRsBte/DzRl28l4BtZ/
         7Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVKrDrySQ626g+ZWAazaB+SotHhUYrhsB+vObm8/eL4=;
        b=KrWtFZgxkZe2W+95qeqmkcJUu2GevSbRSCCCskSNVuzIKNDVwXr0NAGN2tajy1i8YY
         5f8hARJSHGXZIS4NwGTjzj1+H6euA+D7mQgpWjs4yi0F6r5t6P1DVAqe4mrz9MnI1Oaf
         ZLY+ZNXgtFjfDkaMczJjtNWD6N8NadIucysDfNIZBil/lxPPSbuisId1IB3J30jbd+ow
         JGh8cDRUjaN+RrHjDK/tePcHAprTogo+y9AqMOJRVKhexADvIWYW+oaYF19/+R11w5qy
         8p5adNDAkwVO4+sdQJ7mB2vHoZO9AQgSvETNmk9DUpTSMxQ0RcJvkV2mii2/GL1SUOaX
         jFIA==
X-Gm-Message-State: AOAM532pR4+onzNEE18SCQyLxDlkeO+upSDrW+zqrbHUXLgDUdZCx1Hs
        9WaRyqxbNWi7RrVk+U/6fIg=
X-Google-Smtp-Source: ABdhPJyjKqcSII2sapWLSIWFBATf7dUexEUL7iRiCVvIXhC9RbapvCjkw8/7R+8BwVggbeZe1On47Q==
X-Received: by 2002:a05:6402:445:: with SMTP id p5mr18237351edw.208.1628331130444;
        Sat, 07 Aug 2021 03:12:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_wlan_util.c
Date:   Sat,  7 Aug 2021 12:11:07 +0200
Message-Id: <20210807101119.16085-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_wlan_util.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 70 ++++++++++----------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 21a3d0868214..e897920b7af1 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -107,7 +107,7 @@ u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int ratelen
 {
 	u8 network_type = 0;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeext->cur_channel > 14) {
 		if (pmlmeinfo->HT_enable)
@@ -411,7 +411,7 @@ int is_client_associated_to_ap(struct adapter *padapter)
 		return _FAIL;
 
 	pmlmeext = &padapter->mlmeextpriv;
-	pmlmeinfo = &(pmlmeext->mlmext_info);
+	pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE))
 		return true;
@@ -422,7 +422,7 @@ int is_client_associated_to_ap(struct adapter *padapter)
 int is_client_associated_to_ibss(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE))
 		return true;
@@ -434,7 +434,7 @@ int is_IBSS_empty(struct adapter *padapter)
 {
 	unsigned int i;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	for (i = IBSS_START_MAC_ID; i < NUM_STA; i++) {
 		if (pmlmeinfo->FW_sta_info[i].status == 1)
@@ -505,7 +505,7 @@ int allocate_fw_sta_entry(struct adapter *padapter)
 {
 	unsigned int mac_id;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	for (mac_id = IBSS_START_MAC_ID; mac_id < NUM_STA; mac_id++) {
 		if (pmlmeinfo->FW_sta_info[mac_id].status == 0) {
@@ -521,7 +521,7 @@ int allocate_fw_sta_entry(struct adapter *padapter)
 void flush_all_cam_entry(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_CAM_INVALID_ALL, NULL);
 
@@ -531,9 +531,9 @@ void flush_all_cam_entry(struct adapter *padapter)
 int WMM_param_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 {
 	/* struct registry_priv	*pregpriv = &padapter->registrypriv; */
-	struct mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmepriv->qospriv.qos_option == 0) {
 		pmlmeinfo->WMM_enable = 0;
@@ -541,7 +541,7 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 	}
 
 	pmlmeinfo->WMM_enable = 1;
-	memcpy(&(pmlmeinfo->WMM_param), (pIE->data + 6), sizeof(struct WMM_para_element));
+	memcpy(&pmlmeinfo->WMM_param, pIE->data + 6, sizeof(struct WMM_para_element));
 	return true;
 }
 
@@ -553,7 +553,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 	u32	acParm, i;
 	u32	edca[4], inx[4];
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 	struct registry_priv	*pregpriv = &padapter->registrypriv;
 
@@ -655,9 +655,9 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var
 	unsigned char	 new_bwmode;
 	unsigned char  new_ch_offset;
 	struct HT_info_element	 *pHT_info;
-	struct mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct ht_priv			*phtpriv = &pmlmepriv->htpriv;
 
@@ -706,7 +706,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var
 
 	if (pmlmeinfo->bwmode_updated) {
 		struct sta_info *psta;
-		struct wlan_bssid_ex	*cur_network = &(pmlmeinfo->network);
+		struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
 		struct sta_priv	*pstapriv = &padapter->stapriv;
 
 		/* set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode); */
@@ -734,7 +734,7 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 	u8	rf_type;
 	u8	max_AMPDU_len, min_MPDU_spacing;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv			*phtpriv = &pmlmepriv->htpriv;
 
@@ -780,7 +780,7 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv			*phtpriv = &pmlmepriv->htpriv;
 
@@ -794,7 +794,7 @@ void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 		return;
 
 	pmlmeinfo->HT_info_enable = 1;
-	memcpy(&(pmlmeinfo->HT_info), pIE->data, pIE->Length);
+	memcpy(&pmlmeinfo->HT_info, pIE->data, pIE->Length);
 }
 
 void HTOnAssocRsp(struct adapter *padapter)
@@ -803,7 +803,7 @@ void HTOnAssocRsp(struct adapter *padapter)
 	unsigned char		min_MPDU_spacing;
 	/* struct registry_priv	 *pregpriv = &padapter->registrypriv; */
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	DBG_88E("%s\n", __func__);
 
@@ -831,20 +831,20 @@ void HTOnAssocRsp(struct adapter *padapter)
 void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pIE->Length > 1)
 		return;
 
 	pmlmeinfo->ERP_enable = 1;
-	memcpy(&(pmlmeinfo->ERP_IE), pIE->data, pIE->Length);
+	memcpy(&pmlmeinfo->ERP_IE, pIE->data, pIE->Length);
 }
 
 void VCS_update(struct adapter *padapter, struct sta_info *psta)
 {
 	struct registry_priv	 *pregpriv = &padapter->registrypriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	switch (pregpriv->vrtl_carrier_sense) { /* 0:off 1:on 2:auto */
 	case 0: /* off */
@@ -883,7 +883,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	unsigned int		len;
 	unsigned char		*p;
 	unsigned short	val16, subtype;
-	struct wlan_network *cur_network = &(Adapter->mlmepriv.cur_network);
+	struct wlan_network *cur_network = &Adapter->mlmepriv.cur_network;
 	/* u8 wpa_ie[255], rsn_ie[255]; */
 	u16 wpa_len = 0, rsn_len = 0;
 	u8 encryp_protocol = 0;
@@ -1101,8 +1101,8 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 	u32 i;
 	struct ndis_802_11_var_ie *pIE;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
 
 	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
 		for (i = sizeof(struct ndis_802_11_fixed_ie); i < pmlmeinfo->network.IELength;) {
@@ -1168,8 +1168,8 @@ unsigned int is_ap_in_wep(struct adapter *padapter)
 	u32 i;
 	struct ndis_802_11_var_ie *pIE;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
 
 	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
 		for (i = sizeof(struct ndis_802_11_fixed_ie); i < pmlmeinfo->network.IELength;) {
@@ -1278,7 +1278,7 @@ int support_short_GI(struct adapter *padapter, struct HT_caps_element *pHT_caps)
 {
 	unsigned char					bit_offset;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (!(pmlmeinfo->HT_enable))
 		return _FAIL;
@@ -1429,7 +1429,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 void update_IOT_info(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	switch (pmlmeinfo->assoc_AP_vendor) {
 	case HT_IOT_PEER_MARVELL:
@@ -1458,7 +1458,7 @@ void update_IOT_info(struct adapter *padapter)
 void update_capinfo(struct adapter *Adapter, u16 updateCap)
 {
 	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	bool		ShortPreamble;
 
 	/*  Check preamble mode, 2005.01.06, by rcnjko. */
@@ -1506,8 +1506,8 @@ void update_wireless_mode(struct adapter *padapter)
 	int ratelen, network_type = 0;
 	u32 SIFS_Timer;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex	*cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
 	unsigned char		*rate = cur_network->SupportedRates;
 
 	ratelen = rtw_get_rateset_len(cur_network->SupportedRates);
@@ -1547,8 +1547,8 @@ void update_wireless_mode(struct adapter *padapter)
 
 void update_bmc_sta_support_rate(struct adapter *padapter, u32 mac_id)
 {
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeext->cur_wireless_mode & WIRELESS_11B) {
 		/*  Only B, B/G, and B/G/N AP could use CCK rate */
@@ -1563,8 +1563,8 @@ int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie, uint var_ie_l
 	unsigned int	ie_len;
 	struct ndis_802_11_var_ie *pIE;
 	int	supportRateNum = 0;
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pIE = (struct ndis_802_11_var_ie *)rtw_get_ie(pvar_ie, _SUPPORTEDRATES_IE_, &ie_len, var_ie_len);
 	if (!pIE)
@@ -1589,7 +1589,7 @@ void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct ADDBA_request	*preq = (struct ADDBA_request *)paddba_req;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	psta = rtw_get_stainfo(pstapriv, addr);
 
-- 
2.32.0

