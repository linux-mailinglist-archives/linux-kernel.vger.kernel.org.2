Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCDF3E4A44
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhHIQvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhHIQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:51:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0079C06179C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:50:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m12so22303401wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yc/zvEne6V1Zbokf9xCHfLSphUIKSvnSGafJZJO/S/4=;
        b=Yn85veAwYeNUXJUn9d/TzO7ybZvv9Y3VDaIJAa7RJgghvEy0KylQMzJuEWxO7AiuKd
         Gv+4L2AdRkPJDHwdy3UA8lzFhdvQA4lq5cUAGtJm3mL4r0sSZZST05uoMQWoqxNZWNpn
         AAwaVnIVRifoZK3Ndrt/Xk9npanGZmUrW4/itFy2zXdHWr1Fl5J/f+2IEn/iLeNi+pyM
         eZDgEtC3OufUHWxKqjRaYfiAuYQVY4wUx+N+gGRXiUqwQiS+moe5NxXNvBdLfcoVa+Z5
         flQN2jbploL4klEbL4FKhYZKMJCdPNaP+S/ZiuBPoPbYoJWhamx/CB1AUa5B3OX933nx
         Q3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yc/zvEne6V1Zbokf9xCHfLSphUIKSvnSGafJZJO/S/4=;
        b=KxVQqtqMstW/ITnCbfOoS9HsrJtcaaQpPA/ipwu+hzrABE+ybjWH0391pz2ZLpfv9A
         u+xWSYfyMMAmOwujo8Rnirp3IWddtEHqLF8PbRRlyF56d9ACdzXkMsCDJ14mI5jDacHo
         X6rtADy07IJc/+WWMYxf3WTYOAHUBGR05Ay+DmzJ413q9IZ4vo+EgzMd87QmZtgP0tO6
         Bprpm7jJTnCXk+ehyvbTcR2rJCLKZnIr0dKs4/r7BeWt8WO/Az/kITgYylBoRZavhV3c
         8dwmRD/+PCG6uDtshvjNw2qfryRahAu9Ys+8slQCcfUJZv5Iji7x1pb8EGVwFYweDXvs
         KPGA==
X-Gm-Message-State: AOAM531OtM8bXJd76sMiBFdGyDESvU8ccWTV/ptaWZVC4tdaCu3mGG7N
        prcTmzNklE41TA/dMxXL+H+hR/S1l1M=
X-Google-Smtp-Source: ABdhPJxZgxd0NFPBwml4cOSAQ0ou7T6M2hFYWxfszBbdpQR0hl0pFymAt69IB/8pkP1fiHEHb2LMMg==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr25733092wro.287.1628527852568;
        Mon, 09 Aug 2021 09:50:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::996b])
        by smtp.gmail.com with ESMTPSA id q5sm20484469wrx.33.2021.08.09.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 09:50:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 07/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_p2p.c
Date:   Mon,  9 Aug 2021 18:49:57 +0200
Message-Id: <20210809165007.23204-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809165007.23204-1-straube.linux@gmail.com>
References: <20210809165007.23204-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_p2p.c.
Most of them reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c | 78 +++++++++++++-------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index b4497444a7af..9b3ea8a31508 100644
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
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&p2poui, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &oui_subtype, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &dialogToken, &pattrib->pktlen);
 
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
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&p2poui, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &oui_subtype, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &dialogToken, &pattrib->pktlen);
 
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
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&p2poui, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &oui_subtype, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &dialogToken, &pattrib->pktlen);
 
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
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&p2poui, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &oui_subtype, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &dialogToken, &pattrib->pktlen);
 
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

