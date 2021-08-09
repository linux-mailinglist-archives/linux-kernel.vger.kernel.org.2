Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53BC3E4A43
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhHIQva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbhHIQvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:51:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5420C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:50:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h14so22287574wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/FzLrj4rI4GK91rr4qKyXz/LW70yQOp1JV4Z8ChknM=;
        b=Gkxvyw6hDtyTtzcIYcrOTbX2jn1kSN8jWsZg56bR0cfLYsej6EPvvT0hraS6o1gQb1
         EqWOMoLZiHfllLwahit4YWKhsjo49NFuVp/S/2xHngvkEbmLeUyVT7Q6tQoFYWxCVUjD
         oZaXbclJ6dTtI1pGEL1pnvsfjTqMe6eTzGQSETwhUDSrJ/GvxnXqkMVW+gZTjZiPHMZd
         3z24kc0305f+tSKkQ1IL2jlLQE79rXFkSRjRwz94FDK4YxUkazs0LoTQRnZn1+pNekJ5
         yV2nNjNBPRXI8t+wme66PZ1FS3PR3UeA4hFrnrz/gA09ygqGMqFDMjhAIc0/4A/JkNT+
         cXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/FzLrj4rI4GK91rr4qKyXz/LW70yQOp1JV4Z8ChknM=;
        b=uiSElG260jBbci4jctjpJ63FSJe5glKyBLfzxhuvIlEQDjDSzxUKCRJuo+HGtUXycH
         xvMNvpjQDVAWQV7Xr5GzILmQBSTIp6Q8SHhzPUu0kahj7Em4VtM44sasNRE+Pxir5914
         qKspSR25cBjJQJ54V1ZDWEoaYTGmF9hXY50Pholm6Ac0qdUZA7/JxgCkyE4pJf5SK/WM
         /7zaz5KW6GEhaK+issdnJS0FPsJvxg1ppYt8z0ev7S5ffQbFfFfKWIT+mdv8BijMgere
         4YxmIvRTcYT5GljKfTtQWGDiKOEnCkgj3/pOxoRdNH2eN2qYbRVy3EFv1do0v/G2p9yw
         PUWw==
X-Gm-Message-State: AOAM530fwO6xqRciEFHb0RPX4eToUMszwvEQZS/brozQbaztDwTpo8Jk
        mtcSDiSUlUKx15TVvKEJgek=
X-Google-Smtp-Source: ABdhPJxJoTgZOfhcr90a+fSeInQstGV//El9M7N4AiQaFAw2uBmRLnsIS2R82sis0M99UIkVRGVCMQ==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr26344054wrp.157.1628527848952;
        Mon, 09 Aug 2021 09:50:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::996b])
        by smtp.gmail.com with ESMTPSA id q5sm20484469wrx.33.2021.08.09.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 09:50:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 03/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_mlme_ext.c
Date:   Mon,  9 Aug 2021 18:49:53 +0200
Message-Id: <20210809165007.23204-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809165007.23204-1-straube.linux@gmail.com>
References: <20210809165007.23204-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_mlme_ext.c.
Most of them reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 586 ++++++++++----------
 1 file changed, 293 insertions(+), 293 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 40f7ef78a733..967c7574215a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -193,7 +193,7 @@ int init_hw_mlme_ext(struct adapter *padapter)
 static void init_mlme_ext_priv_value(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	unsigned char	mixed_datarate[NumRates] = {
 		_1M_RATE_, _2M_RATE_, _5M_RATE_, _11M_RATE_, _6M_RATE_,
 		_9M_RATE_, _12M_RATE_, _18M_RATE_, _24M_RATE_, _36M_RATE_,
@@ -354,8 +354,8 @@ int	init_mlme_ext_priv(struct adapter *padapter)
 	int	res = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pmlmeext->padapter = padapter;
 
@@ -508,14 +508,14 @@ unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame
 	unsigned char	*p;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *cur = &(pmlmeinfo->network);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur = &pmlmeinfo->network;
 	u8 *pframe = precv_frame->rx_data;
 	uint len = precv_frame->len;
 	u8 is_valid_p2p_probereq = false;
 
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8 wifi_test_chk_rate = 1;
 
 	if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE) &&
@@ -638,7 +638,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 	int cam_idx;
 	struct sta_info	*psta;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv	*pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->rx_data;
@@ -657,8 +657,8 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 			pbss = kmalloc(sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
 			if (pbss) {
 				if (collect_bss_info(padapter, precv_frame, pbss) == _SUCCESS) {
-					update_network(&(pmlmepriv->cur_network.network), pbss, padapter, true);
-					rtw_get_bcn_info(&(pmlmepriv->cur_network));
+					update_network(&pmlmepriv->cur_network.network, pbss, padapter, true);
+					rtw_get_bcn_info(&pmlmepriv->cur_network);
 				}
 				kfree(pbss);
 			}
@@ -736,7 +736,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	struct	sta_priv *pstapriv = &padapter->stapriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->rx_data;
 	uint len = precv_frame->len;
 
@@ -902,14 +902,14 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 	unsigned char	*p;
 	unsigned int	go2asoc = 0;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->rx_data;
 	uint pkt_len = precv_frame->len;
 
 	DBG_88E("%s\n", __func__);
 
 	/* check A1 matches or not */
-	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
+	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
 
 	if (!(pmlmeinfo->state & WIFI_FW_AUTH_STATE))
@@ -987,13 +987,13 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *cur = &(pmlmeinfo->network);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur = &pmlmeinfo->network;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->rx_data;
 	uint pkt_len = precv_frame->len;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8 p2p_status_code = P2P_STATUS_SUCCESS;
 	u8 *p2pie;
 	u32 p2pielen = 0;
@@ -1440,7 +1440,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	struct ndis_802_11_var_ie *pIE;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	/* struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network); */
 	u8 *pframe = precv_frame->rx_data;
 	uint pkt_len = precv_frame->len;
@@ -1448,7 +1448,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	DBG_88E("%s\n", __func__);
 
 	/* check A1 matches or not */
-	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
+	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
 
 	if (!(pmlmeinfo->state & (WIFI_FW_AUTH_SUCCESS | WIFI_FW_ASSOC_STATE)))
@@ -1526,10 +1526,10 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	unsigned short	reason;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->rx_data;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
 
 	/* check A3 */
@@ -1606,10 +1606,10 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 	u16 reason;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->rx_data;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
 
 	/* check A3 */
@@ -1726,11 +1726,11 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	unsigned char		category, action;
 	unsigned short	tid, status, reason_code = 0;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->rx_data;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	/* check RA matches or not */
-	if (memcmp(myid(&(padapter->eeprompriv)), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
+	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
 		return _SUCCESS;
 
 	DBG_88E("%s\n", __func__);
@@ -1755,8 +1755,8 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 		DBG_88E("%s, action=%d\n", __func__, action);
 		switch (action) {
 		case RTW_WLAN_ACTION_ADDBA_REQ: /* ADDBA request */
-			memcpy(&(pmlmeinfo->ADDBA_req), &(frame_body[2]), sizeof(struct ADDBA_request));
-			process_addba_req(padapter, (u8 *)&(pmlmeinfo->ADDBA_req), addr);
+			memcpy(&pmlmeinfo->ADDBA_req, &frame_body[2], sizeof(struct ADDBA_request));
+			process_addba_req(padapter, (u8 *)&pmlmeinfo->ADDBA_req, addr);
 
 			if (pmlmeinfo->bAcceptAddbaReq)
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_ADDBA_RESP, 0);
@@ -1823,9 +1823,9 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	unsigned char *pframe;
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -1841,12 +1841,12 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
-	memcpy(pwlanhdr->addr3, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy(pwlanhdr->addr3, myid(&padapter->eeprompriv), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -1855,12 +1855,12 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&p2poui, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &oui_subtype, &pattrib->pktlen);
 	pwdinfo->negotiation_dialog_token = 1;	/*	Initialize the dialog value */
-	pframe = rtw_set_fixed_ie(pframe, 1, &pwdinfo->negotiation_dialog_token, &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &pwdinfo->negotiation_dialog_token, &pattrib->pktlen);
 
 	/*	WPS Section */
 	wpsielen = 0;
@@ -2159,9 +2159,9 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	unsigned char					*pframe;
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -2177,12 +2177,12 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
-	memcpy(pwlanhdr->addr3, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy(pwlanhdr->addr3, myid(&padapter->eeprompriv), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -2191,12 +2191,12 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&p2poui, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &oui_subtype, &pattrib->pktlen);
 	pwdinfo->negotiation_dialog_token = frame_body[7];	/*	The Dialog Token of provisioning discovery request frame. */
-	pframe = rtw_set_fixed_ie(pframe, 1, &(pwdinfo->negotiation_dialog_token), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &pwdinfo->negotiation_dialog_token, &pattrib->pktlen);
 
 	/*	Commented by Albert 20110328 */
 	/*	Try to get the device password ID from the WPS IE of group negotiation request frame */
@@ -2517,9 +2517,9 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	unsigned char					*pframe;
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -2535,12 +2535,12 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
-	memcpy(pwlanhdr->addr3, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy(pwlanhdr->addr3, myid(&padapter->eeprompriv), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -2549,11 +2549,11 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(pwdinfo->negotiation_dialog_token), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&p2poui, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &oui_subtype, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &pwdinfo->negotiation_dialog_token, &pattrib->pktlen);
 
 	/*	P2P IE Section. */
 
@@ -2680,9 +2680,9 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 	unsigned char					*pframe;
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -2697,11 +2697,11 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, raddr,  ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -2711,11 +2711,11 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&p2poui, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &oui_subtype, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &dialogToken, &pattrib->pktlen);
 
 	/*	P2P IE Section. */
 
@@ -2926,9 +2926,9 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 	unsigned char					*pframe;
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -2943,11 +2943,11 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, raddr,  ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -2957,11 +2957,11 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&p2poui, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &oui_subtype, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &dialogToken, &pattrib->pktlen);
 
 	/*	P2P IE Section. */
 
@@ -3117,9 +3117,9 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	unsigned char					*pframe;
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -3135,11 +3135,11 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, pdev_raddr, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, pdev_raddr, ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -3149,11 +3149,11 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&p2poui, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &oui_subtype, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &dialogToken, &pattrib->pktlen);
 
 	p2pielen = build_prov_disc_request_p2p_ie(pwdinfo, pframe, pssid, ussidlen, pdev_raddr);
 
@@ -3224,11 +3224,11 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	unsigned char					*mac;
-	struct xmit_priv	*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	u16 beacon_interval = 100;
 	u16 capInfo = 0;
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8 wpsie[255] = { 0x00 };
 	u32					wpsielen = 0, p2pielen = 0;
 
@@ -3245,9 +3245,9 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	mac = myid(&(padapter->eeprompriv));
+	mac = myid(&padapter->eeprompriv);
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
@@ -3470,13 +3470,13 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	unsigned char			*mac;
-	struct xmit_priv		*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8 wpsie[255] = { 0x00 }, p2pie[255] = { 0x00 };
 	u16 wpsielen = 0, p2pielen = 0;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -3491,9 +3491,9 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	mac = myid(&(padapter->eeprompriv));
+	mac = myid(&padapter->eeprompriv);
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	if (da) {
@@ -3520,9 +3520,9 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	pattrib->pktlen = sizeof (struct rtw_ieee80211_hdr_3addr);
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_PROVISION_DIS_REQ))
-		pframe = rtw_set_ie(pframe, _SSID_IE_, pwdinfo->tx_prov_disc_info.ssid.SsidLength, pwdinfo->tx_prov_disc_info.ssid.Ssid, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SSID_IE_, pwdinfo->tx_prov_disc_info.ssid.SsidLength, pwdinfo->tx_prov_disc_info.ssid.Ssid, &pattrib->pktlen);
 	else
-		pframe = rtw_set_ie(pframe, _SSID_IE_, P2P_WILDCARD_SSID_LEN, pwdinfo->p2p_wildcard_ssid, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SSID_IE_, P2P_WILDCARD_SSID_LEN, pwdinfo->p2p_wildcard_ssid, &pattrib->pktlen);
 
 	/*	Use the OFDM rate in the P2P probe request frame. (6(B), 9(B), 12(B), 24(B), 36, 48, 54) */
 	pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, pwdinfo->support_rate, &pattrib->pktlen);
@@ -3793,7 +3793,7 @@ int issue_probereq_p2p_ex(struct adapter *adapter, u8 *da, int try_cnt, int wait
 static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 {
 	struct adapter *adapter = recv_frame->adapter;
-	struct mlme_ext_priv *mlmeext = &(adapter->mlmeextpriv);
+	struct mlme_ext_priv *mlmeext = &adapter->mlmeextpriv;
 	u8 *frame = recv_frame->rx_data;
 	u16 seq_ctrl = ((recv_frame->attrib.seq_num&0xffff) << 4) |
 		(recv_frame->attrib.frag_num & 0xf);
@@ -3832,7 +3832,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	uint len = precv_frame->len;
 	u8 *p2p_ie;
 	u32	p2p_ielen;
-	struct	wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct	wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8	result = P2P_STATUS_SUCCESS;
 	u8	empty_addr[ETH_ALEN] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 #endif /* CONFIG_88EU_P2P */
@@ -4151,7 +4151,7 @@ unsigned int on_action_public(struct adapter *padapter, struct recv_frame *precv
 	u8 category, action;
 
 	/* check RA matches or not */
-	if (memcmp(myid(&(padapter->eeprompriv)), GetAddr1Ptr(pframe), ETH_ALEN))
+	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe), ETH_ALEN))
 		goto exit;
 
 	category = frame_body[0];
@@ -4189,12 +4189,12 @@ unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fra
 	u8 category, OUI_Subtype;
 	u8 *pframe = precv_frame->rx_data;
 	uint len = precv_frame->len;
-	struct	wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct	wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	DBG_88E("%s\n", __func__);
 
 	/* check RA matches or not */
-	if (memcmp(myid(&(padapter->eeprompriv)), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
+	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
 		return _SUCCESS;
 
 	frame_body = (unsigned char *)(pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
@@ -4283,7 +4283,7 @@ Following are some TX fuctions for WiFi MLME
 
 void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 {
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 
 	pmlmeext->tx_rate = rate;
 	DBG_88E("%s(): rate = %x\n", __func__, rate);
@@ -4291,7 +4291,7 @@ void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 
 void update_mgntframe_attrib(struct adapter *padapter, struct pkt_attrib *pattrib)
 {
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 
 	memset((u8 *)(pattrib), 0, sizeof(struct pkt_attrib));
 
@@ -4414,14 +4414,14 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct rtw_ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned int	rate_len;
-	struct xmit_priv	*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
+	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
 	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -4443,11 +4443,11 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
@@ -4592,7 +4592,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pattrib->pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&cur_network->Configuration.DSConfig, &pattrib->pktlen);
 
 	{
 		u8 erpinfo = 0;
@@ -4639,18 +4639,18 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	unsigned char					*mac, *bssid;
-	struct xmit_priv	*pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 #if defined (CONFIG_88EU_AP_MODE)
 	u8 *pwps_ie;
 	uint wps_ielen;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 #endif /* if defined (CONFIG_88EU_AP_MODE) */
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
 	unsigned int	rate_len;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -4668,10 +4668,10 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	mac = myid(&(padapter->eeprompriv));
+	mac = myid(&padapter->eeprompriv);
 	bssid = cur_network->MacAddress;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
@@ -4755,7 +4755,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pattrib->pktlen);
 
 		/*  DS parameter set */
-		pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&cur_network->Configuration.DSConfig, &pattrib->pktlen);
 
 		if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 			u8 erpinfo = 0;
@@ -4800,9 +4800,9 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	__le16 *fctrl;
 	unsigned char			*mac;
 	unsigned char			bssrate[NumRates];
-	struct xmit_priv		*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	int	bssrate_len = 0;
 	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
@@ -4819,9 +4819,9 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	mac = myid(&(padapter->eeprompriv));
+	mac = myid(&padapter->eeprompriv);
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	if (da) {
@@ -4844,17 +4844,17 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	pattrib->pktlen = sizeof (struct rtw_ieee80211_hdr_3addr);
 
 	if (pssid)
-		pframe = rtw_set_ie(pframe, _SSID_IE_, pssid->SsidLength, pssid->Ssid, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SSID_IE_, pssid->SsidLength, pssid->Ssid, &pattrib->pktlen);
 	else
-		pframe = rtw_set_ie(pframe, _SSID_IE_, 0, NULL, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SSID_IE_, 0, NULL, &pattrib->pktlen);
 
 	get_rate_set(padapter, bssrate, &bssrate_len);
 
 	if (bssrate_len > 8) {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, bssrate, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, bssrate, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, bssrate_len - 8, bssrate + 8, &pattrib->pktlen);
 	} else {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &pattrib->pktlen);
 	}
 
 	/* add wps_ie for wps2.0 */
@@ -4935,9 +4935,9 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	__le16 le_val16;
 #endif
 	int use_shared_key = 0;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -4952,7 +4952,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -4966,8 +4966,8 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 #ifdef CONFIG_88EU_AP_MODE
 
 		memcpy(pwlanhdr->addr1, psta->hwaddr, ETH_ALEN);
-		memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
-		memcpy(pwlanhdr->addr3, myid(&(padapter->eeprompriv)), ETH_ALEN);
+		memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
+		memcpy(pwlanhdr->addr3, myid(&padapter->eeprompriv), ETH_ALEN);
 
 		/*  setting auth algo number */
 		val16 = (u16)psta->authalg;
@@ -4982,21 +4982,21 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 			le_val16 = 0;
 		}
 
-		pframe = rtw_set_fixed_ie(pframe, _AUTH_ALGM_NUM_, (unsigned char *)&le_val16, &(pattrib->pktlen));
+		pframe = rtw_set_fixed_ie(pframe, _AUTH_ALGM_NUM_, (unsigned char *)&le_val16, &pattrib->pktlen);
 
 		/*  setting auth seq number */
 		val16 = (u16)psta->auth_seq;
 		le_val16 = cpu_to_le16(val16);
-		pframe = rtw_set_fixed_ie(pframe, _AUTH_SEQ_NUM_, (unsigned char *)&le_val16, &(pattrib->pktlen));
+		pframe = rtw_set_fixed_ie(pframe, _AUTH_SEQ_NUM_, (unsigned char *)&le_val16, &pattrib->pktlen);
 
 		/*  setting status code... */
 		val16 = status;
 		le_val16 = cpu_to_le16(val16);
-		pframe = rtw_set_fixed_ie(pframe, _STATUS_CODE_, (unsigned char *)&le_val16, &(pattrib->pktlen));
+		pframe = rtw_set_fixed_ie(pframe, _STATUS_CODE_, (unsigned char *)&le_val16, &pattrib->pktlen);
 
 		/*  added challenging text... */
 		if ((psta->auth_seq == 2) && (psta->state & WIFI_FW_AUTH_STATE) && (use_shared_key == 1))
-			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, psta->chg_txt, &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, psta->chg_txt, &pattrib->pktlen);
 #endif
 	} else {
 		__le32 le_tmp32;
@@ -5014,26 +5014,26 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 		if ((pmlmeinfo->auth_seq == 3) && (pmlmeinfo->state & WIFI_FW_AUTH_STATE) && (use_shared_key == 1)) {
 			val32 = ((pmlmeinfo->iv++) | (pmlmeinfo->key_index << 30));
 			le_tmp32 = cpu_to_le32(val32);
-			pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&le_tmp32, &(pattrib->pktlen));
+			pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&le_tmp32, &pattrib->pktlen);
 
 			pattrib->iv_len = 4;
 		}
 
 		le_tmp16 = cpu_to_le16(val16);
-		pframe = rtw_set_fixed_ie(pframe, _AUTH_ALGM_NUM_, (unsigned char *)&le_tmp16, &(pattrib->pktlen));
+		pframe = rtw_set_fixed_ie(pframe, _AUTH_ALGM_NUM_, (unsigned char *)&le_tmp16, &pattrib->pktlen);
 
 		/*  setting auth seq number */
 		val16 = pmlmeinfo->auth_seq;
 		le_tmp16 = cpu_to_le16(val16);
-		pframe = rtw_set_fixed_ie(pframe, _AUTH_SEQ_NUM_, (unsigned char *)&le_tmp16, &(pattrib->pktlen));
+		pframe = rtw_set_fixed_ie(pframe, _AUTH_SEQ_NUM_, (unsigned char *)&le_tmp16, &pattrib->pktlen);
 
 		/*  setting status code... */
 		le_tmp16 = cpu_to_le16(status);
-		pframe = rtw_set_fixed_ie(pframe, _STATUS_CODE_, (unsigned char *)&le_tmp16, &(pattrib->pktlen));
+		pframe = rtw_set_fixed_ie(pframe, _STATUS_CODE_, (unsigned char *)&le_tmp16, &pattrib->pktlen);
 
 		/*  then checking to see if sending challenging text... */
 		if ((pmlmeinfo->auth_seq == 3) && (pmlmeinfo->state & WIFI_FW_AUTH_STATE) && (use_shared_key == 1)) {
-			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, pmlmeinfo->chg_txt, &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, pmlmeinfo->chg_txt, &pattrib->pktlen);
 
 			SetPrivacy(fctrl);
 
@@ -5063,15 +5063,15 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	unsigned char	*pbuf, *pframe;
 	unsigned short val;
 	__le16 *fctrl;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	u8 *ie = pnetwork->IEs;
 	__le16 lestatus, leval;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
 
 	DBG_88E("%s\n", __func__);
@@ -5089,12 +5089,12 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy((void *)GetAddr1Ptr(pwlanhdr), pstat->hwaddr, ETH_ALEN);
-	memcpy((void *)GetAddr2Ptr(pwlanhdr), myid(&(padapter->eeprompriv)), ETH_ALEN);
-	memcpy((void *)GetAddr3Ptr(pwlanhdr), get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+	memcpy((void *)GetAddr2Ptr(pwlanhdr), myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy((void *)GetAddr3Ptr(pwlanhdr), get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -5110,19 +5110,19 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	/* capability */
 	val = *(unsigned short *)rtw_get_capability_from_ie(ie);
 
-	pframe = rtw_set_fixed_ie(pframe, _CAPABILITY_, (unsigned char *)&val, &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, _CAPABILITY_, (unsigned char *)&val, &pattrib->pktlen);
 
 	lestatus = cpu_to_le16(status);
-	pframe = rtw_set_fixed_ie(pframe, _STATUS_CODE_, (unsigned char *)&lestatus, &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, _STATUS_CODE_, (unsigned char *)&lestatus, &pattrib->pktlen);
 
 	leval = cpu_to_le16(pstat->aid | BIT(14) | BIT(15));
-	pframe = rtw_set_fixed_ie(pframe, _ASOC_ID_, (unsigned char *)&leval, &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, _ASOC_ID_, (unsigned char *)&leval, &pattrib->pktlen);
 
 	if (pstat->bssratelen <= 8) {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, pstat->bssratelen, pstat->bssrateset, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, pstat->bssratelen, pstat->bssrateset, &pattrib->pktlen);
 	} else {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, pstat->bssrateset, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (pstat->bssratelen-8), pstat->bssrateset+8, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, pstat->bssrateset, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, pstat->bssratelen-8, pstat->bssrateset+8, &pattrib->pktlen);
 	}
 
 	if ((pstat->flags & WLAN_STA_HT) && (pmlmepriv->htpriv.ht_option)) {
@@ -5165,7 +5165,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	}
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
-		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &pattrib->pktlen);
 
 	/* add WPS IE ie for wps 2.0 */
 	if (pmlmepriv->wps_assoc_resp_ie && pmlmepriv->wps_assoc_resp_ie_len > 0) {
@@ -5203,13 +5203,13 @@ void issue_assocreq(struct adapter *padapter)
 	unsigned char	rf_type, bssrate[NumRates], sta_bssrate[NumRates];
 	struct ndis_802_11_var_ie *pIE;
 	struct registry_priv	*pregpriv = &padapter->registrypriv;
-	struct xmit_priv		*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	int	bssrate_len = 0, sta_bssrate_len = 0;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8 p2pie[255] = { 0x00 };
 	u16 p2pielen = 0;
 #endif /* CONFIG_88EU_P2P */
@@ -5226,11 +5226,11 @@ void issue_assocreq(struct adapter *padapter)
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
-	memcpy(pwlanhdr->addr1, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
-	memcpy(pwlanhdr->addr3, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+	memcpy(pwlanhdr->addr1, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -5254,7 +5254,7 @@ void issue_assocreq(struct adapter *padapter)
 	pattrib->pktlen += 2;
 
 	/* SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_,  pmlmeinfo->network.Ssid.SsidLength, pmlmeinfo->network.Ssid.Ssid, &(pattrib->pktlen));
+	pframe = rtw_set_ie(pframe, _SSID_IE_,  pmlmeinfo->network.Ssid.SsidLength, pmlmeinfo->network.Ssid.Ssid, &pattrib->pktlen);
 
 	/* supported rate & extended supported rate */
 
@@ -5301,22 +5301,22 @@ void issue_assocreq(struct adapter *padapter)
 	}
 
 	if (bssrate_len > 8) {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, bssrate, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, bssrate, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, bssrate_len - 8, bssrate + 8, &pattrib->pktlen);
 	} else {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &pattrib->pktlen);
 	}
 
 	/* RSN */
 	p = rtw_get_ie((pmlmeinfo->network.IEs + sizeof(struct ndis_802_11_fixed_ie)), _RSN_IE_2_, &ie_len, (pmlmeinfo->network.IELength - sizeof(struct ndis_802_11_fixed_ie)));
 	if (p)
-		pframe = rtw_set_ie(pframe, _RSN_IE_2_, ie_len, (p + 2), &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _RSN_IE_2_, ie_len, p + 2, &pattrib->pktlen);
 
 	/* HT caps */
 	if (padapter->mlmepriv.htpriv.ht_option) {
 		p = rtw_get_ie((pmlmeinfo->network.IEs + sizeof(struct ndis_802_11_fixed_ie)), _HT_CAPABILITY_IE_, &ie_len, (pmlmeinfo->network.IELength - sizeof(struct ndis_802_11_fixed_ie)));
 		if (p && !is_ap_in_tkip(padapter)) {
-			memcpy(&(pmlmeinfo->HT_caps), (p + 2), sizeof(struct HT_caps_element));
+			memcpy(&pmlmeinfo->HT_caps, p + 2, sizeof(struct HT_caps_element));
 
 			/* to disable 40M Hz support while gd_bw_40MHz_en = 0 */
 			if (pregpriv->cbw40_enable == 0)
@@ -5346,7 +5346,7 @@ void issue_assocreq(struct adapter *padapter)
 				memcpy(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_rate_2R, 16);
 				break;
 			}
-			pframe = rtw_set_ie(pframe, _HT_CAPABILITY_IE_, ie_len, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, _HT_CAPABILITY_IE_, ie_len, (u8 *)(&pmlmeinfo->HT_caps), &pattrib->pktlen);
 		}
 	}
 
@@ -5366,7 +5366,7 @@ void issue_assocreq(struct adapter *padapter)
 					if (!memcmp(pIE->data, WPS_OUI, 4))
 						pIE->Length = 14;
 				}
-				pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, pIE->Length, pIE->data, &(pattrib->pktlen));
+				pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, pIE->Length, pIE->data, &pattrib->pktlen);
 			}
 			break;
 		default:
@@ -5376,7 +5376,7 @@ void issue_assocreq(struct adapter *padapter)
 	}
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
-		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &pattrib->pktlen);
 
 #ifdef CONFIG_88EU_P2P
 
@@ -5537,9 +5537,9 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	if (!padapter)
 		goto exit;
 
-	pxmitpriv = &(padapter->xmitpriv);
-	pmlmeext = &(padapter->mlmeextpriv);
-	pmlmeinfo = &(pmlmeext->mlmext_info);
+	pxmitpriv = &padapter->xmitpriv;
+	pmlmeext = &padapter->mlmeextpriv;
+	pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -5555,7 +5555,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)
@@ -5567,8 +5567,8 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 		SetPwrMgt(fctrl);
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
-	memcpy(pwlanhdr->addr3, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -5597,12 +5597,12 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 	int ret;
 	int i = 0;
 	u32 start = jiffies;
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	/* da == NULL, assum it's null data for sta to ap*/
 	if (!da)
-		da = get_my_bssid(&(pmlmeinfo->network));
+		da = get_my_bssid(&pmlmeinfo->network);
 
 	do {
 		ret = _issue_nulldata(padapter, da, power_mode, wait_ms > 0 ? true : false);
@@ -5645,9 +5645,9 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	unsigned short *qc;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	DBG_88E("%s\n", __func__);
 
@@ -5670,7 +5670,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)
@@ -5690,8 +5690,8 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	SetAckpolicy(qc, pattrib->ack_policy);
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
-	memcpy(pwlanhdr->addr3, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -5720,12 +5720,12 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 	int ret;
 	int i = 0;
 	u32 start = jiffies;
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	/* da == NULL, assum it's null data for sta to ap*/
 	if (!da)
-		da = get_my_bssid(&(pmlmeinfo->network));
+		da = get_my_bssid(&pmlmeinfo->network);
 
 	do {
 		ret = _issue_qos_nulldata(padapter, da, tid, wait_ms > 0 ? true : false);
@@ -5765,13 +5765,13 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 	unsigned char					*pframe;
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	int ret = _FAIL;
 	__le16 le_tmp;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
 
 #ifdef CONFIG_88EU_P2P
@@ -5795,12 +5795,12 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
-	memcpy(pwlanhdr->addr3, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -5810,7 +5810,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
 	le_tmp = cpu_to_le16(reason);
-	pframe = rtw_set_fixed_ie(pframe, _RSON_CODE_, (unsigned char *)&le_tmp, &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, _RSON_CODE_, (unsigned char *)&le_tmp, &pattrib->pktlen);
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
@@ -5876,8 +5876,8 @@ void issue_action_spct_ch_switch (struct adapter *padapter, u8 *ra, u8 new_ch, u
 	unsigned char				*pframe;
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 
 	DBG_88E(FUNC_NDEV_FMT" ra =%pM, ch:%u, offset:%u\n",
 		FUNC_NDEV_ARG(padapter->pnetdev), ra, new_ch, ch_offset);
@@ -5895,11 +5895,11 @@ void issue_action_spct_ch_switch (struct adapter *padapter, u8 *ra, u8 new_ch, u
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, ra, ETH_ALEN); /* RA */
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN); /* TA */
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN); /* TA */
 	memcpy(pwlanhdr->addr3, ra, ETH_ALEN); /* DA = RA */
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -5915,12 +5915,12 @@ void issue_action_spct_ch_switch (struct adapter *padapter, u8 *ra, u8 new_ch, u
 		category = RTW_WLAN_CATEGORY_SPECTRUM_MGMT;
 		action = RTW_WLAN_ACTION_SPCT_CHL_SWITCH;
 
-		pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-		pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
+		pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+		pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
 	}
 
-	pframe = rtw_set_ie_ch_switch (pframe, &(pattrib->pktlen), 0, new_ch, 0);
-	pframe = rtw_set_ie_secondary_ch_offset(pframe, &(pattrib->pktlen),
+	pframe = rtw_set_ie_ch_switch (pframe, &pattrib->pktlen, 0, new_ch, 0);
+	pframe = rtw_set_ie_secondary_ch_offset(pframe, &pattrib->pktlen,
 		hal_ch_offset_to_secondary_ch_offset(ch_offset));
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
@@ -5943,9 +5943,9 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	u8 *pframe;
 	struct rtw_ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct sta_info *psta;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct registry_priv *pregpriv = &padapter->registrypriv;
@@ -5965,13 +5965,13 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	/* memcpy(pwlanhdr->addr1, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN); */
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
-	memcpy(pwlanhdr->addr3, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -5980,8 +5980,8 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &pattrib->pktlen);
 
 	if (category == 3) {
 		switch (action) {
@@ -5989,15 +5989,15 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			do {
 				pmlmeinfo->dialogToken++;
 			} while (pmlmeinfo->dialogToken == 0);
-			pframe = rtw_set_fixed_ie(pframe, 1, &(pmlmeinfo->dialogToken), &(pattrib->pktlen));
+			pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->dialogToken, &pattrib->pktlen);
 
 			BA_para_set = (0x1002 | ((status & 0xf) << 2)); /* immediate ack & 64 buffer size */
 			le_tmp = cpu_to_le16(BA_para_set);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&(le_tmp)), &(pattrib->pktlen));
+			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
 
 			BA_timeout_value = 5000;/*  5ms */
 			le_tmp = cpu_to_le16(BA_timeout_value);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&(le_tmp)), &(pattrib->pktlen));
+			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
 
 			psta = rtw_get_stainfo(pstapriv, raddr);
 			if (psta) {
@@ -6010,11 +6010,11 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 				BA_starting_seqctrl = start_seq << 4;
 			}
 			le_tmp = cpu_to_le16(BA_starting_seqctrl);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&(le_tmp)), &(pattrib->pktlen));
+			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
 			break;
 		case 1: /* ADDBA rsp */
-			pframe = rtw_set_fixed_ie(pframe, 1, &(pmlmeinfo->ADDBA_req.dialog_token), &(pattrib->pktlen));
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&status), &(pattrib->pktlen));
+			pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->ADDBA_req.dialog_token, &pattrib->pktlen);
+			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&status, &pattrib->pktlen);
 			BA_para_set = le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f;
 			rtw_hal_get_def_var(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor);
 			switch (max_rx_ampdu_factor) {
@@ -6041,17 +6041,17 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 				BA_para_set = BA_para_set | BIT(0);
 			le_tmp = cpu_to_le16(BA_para_set);
 
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&(le_tmp)), &(pattrib->pktlen));
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&(pmlmeinfo->ADDBA_req.BA_timeout_value)), &(pattrib->pktlen));
+			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
+			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&pmlmeinfo->ADDBA_req.BA_timeout_value, &pattrib->pktlen);
 			break;
 		case 2:/* DELBA */
 			BA_para_set = (status & 0x1F) << 3;
 			le_tmp = cpu_to_le16(BA_para_set);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&(le_tmp)), &(pattrib->pktlen));
+			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
 
 			reason_code = 37;/* Requested from peer STA as it does not want to use the mechanism */
 			le_tmp = cpu_to_le16(reason_code);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&(le_tmp)), &(pattrib->pktlen));
+			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
 			break;
 		default:
 			break;
@@ -6073,11 +6073,11 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	struct	wlan_network	*pnetwork = NULL;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	u8 InfoContent[16] = {0};
 	u8 ICS[8][15];
 	if ((pmlmepriv->num_FortyMHzIntolerant == 0) || (pmlmepriv->num_sta_no_ht == 0))
@@ -6104,12 +6104,12 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
-	memcpy(pwlanhdr->addr1, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
-	memcpy(pwlanhdr->addr3, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+	memcpy(pwlanhdr->addr1, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -6118,8 +6118,8 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
 
 	/*  */
 	if (pmlmepriv->num_FortyMHzIntolerant > 0) {
@@ -6127,7 +6127,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 
 		iedata |= BIT(2);/* 20 MHz BSS Width Request */
 
-		pframe = rtw_set_ie(pframe, EID_BSSCoexistence,  1, &iedata, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, EID_BSSCoexistence,  1, &iedata, &pattrib->pktlen);
 	}
 
 	/*  */
@@ -6182,7 +6182,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 					}
 				}
 
-				pframe = rtw_set_ie(pframe, EID_BSSIntolerantChlReport, k, InfoContent, &(pattrib->pktlen));
+				pframe = rtw_set_ie(pframe, EID_BSSIntolerantChlReport, k, InfoContent, &pattrib->pktlen);
 			}
 		}
 	}
@@ -6198,7 +6198,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	struct sta_info *psta = NULL;
 	/* struct recv_reorder_ctrl *preorder_ctrl; */
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u16 tid;
 
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
@@ -6276,11 +6276,11 @@ void site_survey(struct adapter *padapter)
 	unsigned char		survey_channel = 0, val8;
 	enum rt_scan_type ScanType = SCAN_PASSIVE;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u32 initialgain = 0;
 
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	if ((pwdinfo->rx_invitereq_info.scan_op_ch_only) || (pwdinfo->p2p_info.scan_op_ch_only)) {
 		if (pwdinfo->rx_invitereq_info.scan_op_ch_only) {
@@ -6334,9 +6334,9 @@ void site_survey(struct adapter *padapter)
 				for (i = 0; i < RTW_SSID_SCAN_AMOUNT; i++) {
 					if (pmlmeext->sitesurvey_res.ssid[i].SsidLength) {
 						/* todo: to issue two probe req??? */
-						issue_probereq(padapter, &(pmlmeext->sitesurvey_res.ssid[i]), NULL);
+						issue_probereq(padapter, &pmlmeext->sitesurvey_res.ssid[i], NULL);
 						/* msleep(SURVEY_TO>>1); */
-						issue_probereq(padapter, &(pmlmeext->sitesurvey_res.ssid[i]), NULL);
+						issue_probereq(padapter, &pmlmeext->sitesurvey_res.ssid[i], NULL);
 					}
 				}
 
@@ -6448,7 +6448,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	u8 ie_offset;
 	struct registry_priv	*pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	__le32 le32_tmp;
 
 	len = packet_len - sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -6602,8 +6602,8 @@ void start_create_ibss(struct adapter *padapter)
 	u8 val8;
 	u8 join_type;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
 	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
 	pmlmeinfo->bcn_interval = get_beacon_interval(pnetwork);
 
@@ -6653,8 +6653,8 @@ void start_clnt_join(struct adapter *padapter)
 	unsigned short	caps;
 	u8 val8;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
 	int beacon_timeout;
 
 	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
@@ -6706,7 +6706,7 @@ void start_clnt_join(struct adapter *padapter)
 void start_clnt_auth(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	_cancel_timer_ex(&pmlmeext->link_timer);
 
@@ -6724,7 +6724,7 @@ void start_clnt_auth(struct adapter *padapter)
 	/*  issue deauth before issuing auth to deal with the situation */
 	/*	Commented by Albert 2012/07/21 */
 	/*	For the Win8 P2P connection, it will be hard to have a successful connection if this Wi-Fi doesn't connect to it. */
-	issue_deauth(padapter, (&(pmlmeinfo->network))->MacAddress, WLAN_REASON_DEAUTH_LEAVING);
+	issue_deauth(padapter, (&pmlmeinfo->network)->MacAddress, WLAN_REASON_DEAUTH_LEAVING);
 
 	DBG_88E_LEVEL(_drv_info_, "start auth\n");
 	issue_auth(padapter, NULL, 0);
@@ -6735,7 +6735,7 @@ void start_clnt_auth(struct adapter *padapter)
 void start_clnt_assoc(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	_cancel_timer_ex(&pmlmeext->link_timer);
 
@@ -6750,7 +6750,7 @@ void start_clnt_assoc(struct adapter *padapter)
 unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr, unsigned short reason)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	/* check A3 */
 	if (!(!memcmp(MacAddr, get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
@@ -7033,7 +7033,7 @@ void report_join_res(struct adapter *padapter, int res)
 	struct joinbss_event		*pjoinbss_evt;
 	struct C2HEvent_Header	*pc2h_evt_hdr;
 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
@@ -7062,7 +7062,7 @@ void report_join_res(struct adapter *padapter, int res)
 	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	pjoinbss_evt = (struct joinbss_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
-	memcpy((unsigned char *)(&(pjoinbss_evt->network.network)), &(pmlmeinfo->network), sizeof(struct wlan_bssid_ex));
+	memcpy((unsigned char *)(&pjoinbss_evt->network.network), &pmlmeinfo->network, sizeof(struct wlan_bssid_ex));
 	pjoinbss_evt->network.join_res	= res;
 	pjoinbss_evt->network.aid = res;
 
@@ -7111,7 +7111,7 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	pdel_sta_evt = (struct stadel_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
-	memcpy((unsigned char *)(&(pdel_sta_evt->macaddr)), MacAddr, ETH_ALEN);
+	memcpy((unsigned char *)(&pdel_sta_evt->macaddr), MacAddr, ETH_ALEN);
 	memcpy((unsigned char *)(pdel_sta_evt->rsvd), (unsigned char *)(&reason), 2);
 
 	psta = rtw_get_stainfo(&padapter->stapriv, MacAddr);
@@ -7163,7 +7163,7 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	padd_sta_evt = (struct stassoc_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
-	memcpy((unsigned char *)(&(padd_sta_evt->macaddr)), MacAddr, ETH_ALEN);
+	memcpy((unsigned char *)(&padd_sta_evt->macaddr), MacAddr, ETH_ALEN);
 	padd_sta_evt->cam_id = cam_idx;
 
 	DBG_88E("report_add_sta_event: add STA\n");
@@ -7180,9 +7180,9 @@ Following are the event callback functions
 /* for sta/adhoc mode */
 void update_sta_info(struct adapter *padapter, struct sta_info *psta)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	/* ERP */
 	VCS_update(padapter, psta);
@@ -7193,7 +7193,7 @@ void update_sta_info(struct adapter *padapter, struct sta_info *psta)
 
 		psta->htpriv.ampdu_enable = pmlmepriv->htpriv.ampdu_enable;
 
-		if (support_short_GI(padapter, &(pmlmeinfo->HT_caps)))
+		if (support_short_GI(padapter, &pmlmeinfo->HT_caps))
 			psta->htpriv.sgi = true;
 
 		psta->qos_option = true;
@@ -7222,8 +7222,8 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 {
 	struct sta_info		*psta, *psta_bmc;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 	struct sta_priv		*pstapriv = &padapter->stapriv;
 	u8 join_type;
 	u16 media_status;
@@ -7300,8 +7300,8 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 
 void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *psta)
 {
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 join_type;
 
 	DBG_88E("%s\n", __func__);
@@ -7338,7 +7338,7 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 void mlmeext_sta_del_event_callback(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (is_client_associated_to_ap(padapter) || is_IBSS_empty(padapter)) {
 		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_DISCONNECT, NULL);
@@ -7374,7 +7374,7 @@ void _linked_rx_signal_strehgth_display(struct adapter *padapter);
 void _linked_rx_signal_strehgth_display(struct adapter *padapter)
 {
 	struct mlme_ext_priv    *pmlmeext = &padapter->mlmeextpriv;
-      struct mlme_ext_info    *pmlmeinfo = &(pmlmeext->mlmext_info);
+      struct mlme_ext_info    *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 mac_id;
 	int UndecoratedSmoothedPWDB;
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE)
@@ -7408,9 +7408,9 @@ void linked_status_chk(struct adapter *padapter)
 {
 	u32	i;
 	struct sta_info		*psta;
-	struct xmit_priv		*pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct sta_priv		*pstapriv = &padapter->stapriv;
 
 	if (padapter->bRxRSSIDisplay)
@@ -7529,7 +7529,7 @@ void survey_timer_hdl(struct adapter *padapter)
 	struct cmd_priv					*pcmdpriv = &padapter->cmdpriv;
 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 #endif
 
 	/* issue rtw_sitesurvey_cmd */
@@ -7579,7 +7579,7 @@ void survey_timer_hdl(struct adapter *padapter)
 void link_timer_hdl(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
 		DBG_88E("link_timer_hdl:no beacon while connecting\n");
@@ -7635,7 +7635,7 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	u8 type;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct setopmode_parm *psetop = (struct setopmode_parm *)pbuf;
 
 	if (psetop->mode == Ndis802_11APMode) {
@@ -7660,8 +7660,8 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
 u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
 	struct joinbss_parm *pparm = (struct joinbss_parm *)pbuf;
 	/* u32	initialgain; */
 
@@ -7723,8 +7723,8 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	struct ndis_802_11_var_ie *pIE;
 	struct registry_priv	*pregpriv = &padapter->registrypriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
 	struct joinbss_parm	*pparm = (struct joinbss_parm *)pbuf;
 	u32 i;
 
@@ -7834,8 +7834,8 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	struct disconnect_parm *param = (struct disconnect_parm *)pbuf;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
 	u8 val8;
 
 	if (is_client_associated_to_ap(padapter))
@@ -8002,7 +8002,7 @@ u8 setauth_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	struct setauth_parm		*pparm = (struct setauth_parm *)pbuf;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pparm->mode < 4)
 		pmlmeinfo->auth_algo = pparm->mode;
@@ -8014,7 +8014,7 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 	unsigned short				ctrl;
 	struct setkey_parm		*pparm = (struct setkey_parm *)pbuf;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	unsigned char					null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
 	/* main tx key for wep. */
@@ -8036,7 +8036,7 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 	u16 ctrl = 0;
 	u8 cam_id;/* cam_entry */
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct set_stakey_parm	*pparm = (struct set_stakey_parm *)pbuf;
 
 	/* cam_entry: */
@@ -8107,7 +8107,7 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	struct addBaReq_parm	*pparm = (struct addBaReq_parm *)pbuf;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, pparm->addr);
 
@@ -8128,9 +8128,9 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 {
 	struct cmd_obj	*ph2c;
 	struct Tx_Beacon_param	*ptxBeacon_parm;
-	struct cmd_priv	*pcmdpriv = &(padapter->cmdpriv);
+	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 res = _SUCCESS;
 	int len_diff = 0;
 
@@ -8147,7 +8147,7 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 		goto exit;
 	}
 
-	memcpy(&(ptxBeacon_parm->network), &(pmlmeinfo->network), sizeof(struct wlan_bssid_ex));
+	memcpy(&ptxBeacon_parm->network, &pmlmeinfo->network, sizeof(struct wlan_bssid_ex));
 
 	len_diff = update_hidden_ssid(ptxBeacon_parm->network.IEs+_BEACON_IE_OFFSET_,
 				      ptxBeacon_parm->network.IELength-_BEACON_IE_OFFSET_,
@@ -8169,7 +8169,7 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	u16 evt_sz;
 	uint	*peventbuf;
 	void (*event_callback)(struct adapter *dev, u8 *pbuf);
-	struct evt_priv *pevt_priv = &(padapter->evtpriv);
+	struct evt_priv *pevt_priv = &padapter->evtpriv;
 
 	peventbuf = (uint *)pbuf;
 	evt_sz = (u16)(*peventbuf&0xffff);
-- 
2.32.0

