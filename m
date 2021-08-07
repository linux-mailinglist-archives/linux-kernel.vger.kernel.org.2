Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC073E34AC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhHGKOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhHGKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3CBC06179E
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f13so16790560edq.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVOasz5ogvcqX2HRjVYWSqUBzxunE9ZTA7v6FFffBJ0=;
        b=ZRluricIa1FPMe0ShS/Qg5pfVKpQZmcCojmrn/FhBmnT+dT6A+/xOijFHsESJqS9gZ
         PC8gsJxavAXKOPD9jI2pRumyjyPcsXsmuR3Hyof8pSPs9pNqUNHR+fXzAVU/+4Lblo0+
         lcPUNQorpElU/88JcRUjXgRkWLyfYqe1sj3ktu9cHbc+nF2pgnNRWJN33YCY/76XK7uj
         TuqK9yaJ6dxFRJBT1YDuHUHuDqO0wPzb88pGcc6A5vJ8KumwDjGwnvLkDDTRjy/swAZo
         qXz5BBQg65FKeXMrdr1YuvjIojw+k7J0B9liqsXh1FQ3KaLWHl9zfQtXnIGi19I0BJQu
         MTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVOasz5ogvcqX2HRjVYWSqUBzxunE9ZTA7v6FFffBJ0=;
        b=CW3kXuUckMcmMzSR+dJHF+ehLgQvHjZMKK8EaYViDZcYKxN/BAasQYvj7TaYJPesWk
         /0KWEa2PEqQHZMoEEpJ8/akRtr37x0Sy7drMWs/G9iid0KL/w9I28C9jR/6WeefZ1J3u
         Fj9n60/Nr5TysylNyUXWoL4RVEzvUJG6bX9Tffoi/Ns8tu4HA/3dC46EbsRhD6fW28d3
         kzfdNCtkFivP9zHoqWjv1ZKyCAt8WiXqVSWrvicVCxV3jfSJLSkZG3nlgjkkps6o6Rwi
         F1yfy1WnF/7fkBhctW58lKA/0kGbDT1X/T0US3Vbhx9UFjCqjG4iuHjQ8iw50cuEsQX7
         IAQQ==
X-Gm-Message-State: AOAM531v34jGeIaccEc0lAw5jL1l0A9Pd/Myikega85sMXbueMyYbVGn
        okiqQ/MSy9SaTYvHI0IsIC0=
X-Google-Smtp-Source: ABdhPJzyajIKV7Y+FjqoWYr1s2UookEj8auFQl4aSEDL1EYrgEZ+vfDtz4WKtL89LDMDnQE/36GBFQ==
X-Received: by 2002:aa7:d919:: with SMTP id a25mr1199981edr.386.1628331132196;
        Sat, 07 Aug 2021 03:12:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_p2p.c
Date:   Sat,  7 Aug 2021 12:11:09 +0200
Message-Id: <20210807101119.16085-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_p2p.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c | 78 +++++++++++++-------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index b4497444a7af..560e29fb9adf 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -118,8 +118,8 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	struct adapter *padapter = pwdinfo->padapter;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	unsigned char category = RTW_WLAN_CATEGORY_P2P;/* P2P action frame */
 	__be32	p2poui = cpu_to_be32(P2POUI);
 	u8	oui_subtype = P2P_GO_DISC_REQUEST;
@@ -140,7 +140,7 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
@@ -155,10 +155,10 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
 	/* Build P2P action frame header */
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &pattrib->pktlen);
 
 	/* there is no IE in this P2P action frame */
 
@@ -175,8 +175,8 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	struct adapter *padapter = pwdinfo->padapter;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	unsigned char category = RTW_WLAN_CATEGORY_PUBLIC;
 	u8			action = P2P_PUB_ACTION_ACTION;
 	__be32			p2poui = cpu_to_be32(P2POUI);
@@ -199,7 +199,7 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
@@ -214,11 +214,11 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
 	/* Build P2P public action frame header */
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &pattrib->pktlen);
 
 	/* Build P2P IE */
 	/*	P2P OUI */
@@ -253,8 +253,8 @@ static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr,
 	unsigned char					*pframe;
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -269,12 +269,12 @@ static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr,
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
@@ -283,11 +283,11 @@ static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr,
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &pattrib->pktlen);
 
 	wpsielen = 0;
 	/*	WPS OUI */
@@ -322,8 +322,8 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	struct adapter *padapter = pwdinfo->padapter;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	unsigned char category = RTW_WLAN_CATEGORY_P2P;/* P2P action frame */
 	__be32	p2poui = cpu_to_be32(P2POUI);
 	u8	oui_subtype = P2P_PRESENCE_RESPONSE;
@@ -346,7 +346,7 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
@@ -361,10 +361,10 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
 	/* Build P2P action frame header */
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &pattrib->pktlen);
 
 	/* Add P2P IE header */
 	/*	P2P OUI */
@@ -385,7 +385,7 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 
 	p2pielen += rtw_set_p2p_attr_content(&p2pie[p2pielen], P2P_ATTR_NOA, 2, noa_attr_content);
 
-	pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, p2pielen, p2pie, &(pattrib->pktlen));
+	pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, p2pielen, p2pie, &pattrib->pktlen);
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
@@ -1556,7 +1556,7 @@ void process_p2p_ps_ie(struct adapter *padapter, u8 *IEs, u32 IELength)
 	u8	noa_attr[MAX_P2P_IE_LEN] = { 0x00 };/*  NoA length should be n*(13) + 2 */
 	u32	attr_contentlen = 0;
 
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8	find_p2p = false, find_p2p_ps = false;
 	u8	noa_offset, noa_num, noa_index;
 
@@ -1636,7 +1636,7 @@ void process_p2p_ps_ie(struct adapter *padapter, u8 *IEs, u32 IELength)
 void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 {
 	struct pwrctrl_priv		*pwrpriv = &padapter->pwrctrlpriv;
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	/*  Pre action for p2p state */
 	switch (p2p_ps_state) {
@@ -1653,7 +1653,7 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 		if (padapter->pwrctrlpriv.bFwCurrentInPSMode) {
 			if (pwrpriv->smart_ps == 0) {
 				pwrpriv->smart_ps = 2;
-				rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&(padapter->pwrctrlpriv.pwr_mode)));
+				rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&padapter->pwrctrlpriv.pwr_mode));
 			}
 		}
 		break;
@@ -1665,7 +1665,7 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 				if (pwrpriv->smart_ps != 0) {
 					pwrpriv->smart_ps = 0;
 					DBG_88E("%s(): Enter CTW, change SmartPS\n", __func__);
-					rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&(padapter->pwrctrlpriv.pwr_mode)));
+					rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&padapter->pwrctrlpriv.pwr_mode));
 				}
 			}
 			rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_P2P_PS_OFFLOAD, (u8 *)(&p2p_ps_state));
@@ -1689,7 +1689,7 @@ u8 p2p_ps_wk_cmd(struct adapter *padapter, u8 p2p_ps_state, u8 enqueue)
 {
 	struct cmd_obj	*ph2c;
 	struct drvextra_cmd_parm	*pdrvextra_cmd_parm;
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
 	u8	res = _SUCCESS;
 
@@ -1938,7 +1938,7 @@ void init_wifidirect_info(struct adapter *padapter, enum P2P_ROLE role)
 int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 {
 	int ret = _SUCCESS;
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
 		/* leave IPS/Autosuspend */
-- 
2.32.0

