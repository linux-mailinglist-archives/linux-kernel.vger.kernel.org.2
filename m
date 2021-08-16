Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217F33EDA5B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhHPP77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbhHPP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:59:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6554C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso2640762wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3H3j6UjtB5ptVMptuAkOd92kZZ/Jh1ArquSKwjHAMc=;
        b=iWBCSZBwvcI+AUzpxU+yO/ibb62xgHiSMNvuhC4JkfjqIZ7vFf4Oyo9vniM2JylC4g
         ayJILyLbF7SB/QP223cZv637/BHPpv0yvXwGCWi5P+aEPQ6wcAgWxkFGI67kkfv0ygpn
         Im9QHDphl1jOrILZ2aImpiGuUCtDy56MIbk0c5/paVgoqGsdPkSWfpMWg/SAYwCvXsha
         Z/VVJ4OiOjg60Lf7a0fzuOe4a7M9YMq8KJMQ6qX55CF/+ImhmaHuLtuy1NZ+7kwox1Ty
         DUq5cxZAG+NsxBSdD2HIyhMPuv9NPm4rKDSlGpfQtlYYBtEGF8+vVSNGxZsxsI7aFZ1o
         3V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3H3j6UjtB5ptVMptuAkOd92kZZ/Jh1ArquSKwjHAMc=;
        b=hGwIRP+7b396fO3TNRIYUJhLJDloWKcJopVMl3dKzhJwpMZpL68XU5qMSoewajhAO7
         7Eyvw3m3qRq606ZgMSfu1a35OTbKE/EUjYOSZP3Mh96398JmEF3DXMRMB+3lmcoXSYSG
         YpsG+WKYrBv//qJRvi4LPXw6L0/MHB6fF0pHYMqEyU9qm8QsLtTYAOxGxuzKrN6xhnbR
         RMLIPNqBthF1pXE/mYB0m156oQkgm/8WitDWQE/560F6i/Z3YBy4C+FOuBKYmZGoVbdI
         vPVPRqvEI1+7MCsCd0FZajGHQK5k3NUJdjXl5Y5dSt5XMpOmcZ4UjGwRw6zpoMseuS9z
         lFLw==
X-Gm-Message-State: AOAM531M7Gn5JuzzMNcYCN1gb8D5eTK+Mv9y4llXodXbXpfsPHMbGfBN
        HccW/m3qBchlTNeydcn4uBc=
X-Google-Smtp-Source: ABdhPJyxhBBTZ8KxBad1AhczrfAdPq1eXCooaFTDzFSbagLG5RVJqgUe/XbKn8Snud6GhwwmtuikSA==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr15941071wmi.177.1629129561474;
        Mon, 16 Aug 2021 08:59:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/23] staging: r8188eu: clean up spacing style issues in core/rtw_cmd.c
Date:   Mon, 16 Aug 2021 17:57:59 +0200
Message-Id: <20210816155818.24005-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_cmd.c reported by checkpatch.

CHECK: spaces preferred around that ...
CHECK: No space is necessary after a cast
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 65ca4a2895f8..7c640c8148f6 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -16,7 +16,7 @@ Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
 No irqsave is necessary.
 */
 
-int	_rtw_init_cmd_priv (struct	cmd_priv *pcmdpriv)
+int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 	int res = _SUCCESS;
 
@@ -38,7 +38,7 @@ int	_rtw_init_cmd_priv (struct	cmd_priv *pcmdpriv)
 		goto exit;
 	}
 
-	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((size_t)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ-1));
+	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((size_t)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ - 1));
 
 	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);
 
@@ -69,7 +69,7 @@ int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
 
 	_init_workitem(&pevtpriv->c2h_wk, c2h_wk_callback, NULL);
 	pevtpriv->c2h_wk_alive = false;
-	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN+1);
+	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN + 1);
 
 	return res;
 }
@@ -87,7 +87,7 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 	}
 }
 
-void _rtw_free_cmd_priv (struct	cmd_priv *pcmdpriv)
+void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 
 	if (pcmdpriv) {
@@ -149,12 +149,12 @@ u32	rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 	u32	res;
 
-	res = _rtw_init_cmd_priv (pcmdpriv);
+	res = _rtw_init_cmd_priv(pcmdpriv);
 
 	return res;
 }
 
-u32	rtw_init_evt_priv (struct	evt_priv *pevtpriv)
+u32 rtw_init_evt_priv(struct evt_priv *pevtpriv)
 {
 	int	res;
 
@@ -801,7 +801,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	t_len = sizeof(struct wlan_bssid_ex);
 
 	/* for hidden ap to set fw_state here */
-	if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_ADHOC_STATE)) {
+	if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_ADHOC_STATE)) {
 		switch (ndis_network_mode) {
 		case Ndis802_11IBSS:
 			set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
@@ -832,8 +832,8 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->IELength;
 
-	if (psecnetwork->IELength-12 < 255) {
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], psecnetwork->IELength-12);
+	if (psecnetwork->IELength - 12 < 255) {
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], psecnetwork->IELength - 12);
 	} else {
 		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], 255);
 	}
@@ -1010,7 +1010,7 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key)
 	memcpy(psetstakey_para->addr, sta->hwaddr, ETH_ALEN);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
-		psetstakey_para->algorithm = (unsigned char) psecuritypriv->dot11PrivacyAlgrthm;
+		psetstakey_para->algorithm = (unsigned char)psecuritypriv->dot11PrivacyAlgrthm;
 	else
 		GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false);
 
-- 
2.32.0

