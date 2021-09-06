Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245F7402022
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245643AbhIFTEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245167AbhIFTD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:03:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A258DC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:02:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s25so10698492edw.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEkKMDZao1qnEO6WpzuCXGiPtoH4ChXtukbnEWoWLss=;
        b=bR37h2EFnvw2U8QrdFCaLCoIVC5e9j6bxICRql5idw5J0e8NakVxXLcQbJhYucnLt1
         CMZnJSZxAJ9Cp4+dKR0zKwA+4HfG+L/X212jyBCf+d203VaWFiFl+YneNSJ/og6Ko19b
         zUkd/w7Ti8fpFc3lTziIymIK/VVAB0RFDelAPO1qJjkZH2a89/1DOYfchZYfBLquAzlc
         hEFfkPTiwsNfy72DFWXeL+F5ih2CGto2KmiLLWtXBaVW/fbFML4gurrAz/yzXKf+dgDD
         aJYJGccYNW1yUZT6plU+T9j9UP5N9BOGiajPJ2XDfxXXaaeWwoYV89WUnX6rPPs0Qih+
         br4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEkKMDZao1qnEO6WpzuCXGiPtoH4ChXtukbnEWoWLss=;
        b=HcmdoGIloljk6prQserJzOQnLtaYBDiOca1cR2oNTXSJgihAAi/lO6xUGfvMHl5Kfi
         nkMPFj2EhfchiBYPLTP0WREnkrIb23i+lVj+jQ9pO/vrgY1FAdU+AIPD9e+XQDkZSiHo
         U4vkq3e1KCsDeXMaOC0+bopiMmOxm9WJwgU0IyCRTA7TpHKG50r0ntRS+RMCur7VBZm/
         qsw0o73kDOTOqpW4nSbwwJAEnPpWL4eUVI8NjKjfrTa5AWR3yzRhEWEn9dZ9t0eRiJI5
         zYaT1zBwv/l9TdSkTFc2hsssrdnv3NAU+JZKnxiWtJ4qJ75DsqGeHlo81QiWenDlRSIe
         m+rQ==
X-Gm-Message-State: AOAM531y4ys2E5vy0TitIH1kSMCIrLhqW0Dy0U5b+StKphpoUvO/ixtC
        v0B5Kr2lv8iZsW2ws7Rz0Xs=
X-Google-Smtp-Source: ABdhPJw8bJfkc8THDX5NCOpoMf2KBvXzdjZmXW4dCrC36PI+ghesnqqpO7nKUbCX3iwLCdVFYBUrRQ==
X-Received: by 2002:aa7:d3d6:: with SMTP id o22mr14481477edr.155.1630954969234;
        Mon, 06 Sep 2021 12:02:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 05/40] staging: r8188eu: remove SetHalODMVarHandler from hal_ops
Date:   Mon,  6 Sep 2021 21:01:48 +0200
Message-Id: <20210906190223.11396-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SetHalODMVarHandler from hal_ops and remove its wrapper
rtw_hal_set_odm_var(). Call rtl8188e_SetHalODMVar() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c           |  4 ++--
 drivers/staging/r8188eu/core/rtw_mlme.c         |  4 ++--
 drivers/staging/r8188eu/core/rtw_p2p.c          |  4 ++--
 drivers/staging/r8188eu/core/rtw_sta_mgt.c      |  2 +-
 drivers/staging/r8188eu/hal/hal_intf.c          |  9 ---------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  4 +---
 drivers/staging/r8188eu/include/hal_intf.h      | 10 ++--------
 7 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 1c07ad28b242..da8b5332b5e7 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -453,7 +453,7 @@ void update_bmc_sta(struct adapter *padapter)
 		init_rate = get_highest_rate_idx(tx_ra_bitmap & 0x0fffffff) & 0x3f;
 
 		/* ap mode */
-		rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
+		rtl8188e_SetHalODMVar(padapter, HAL_ODM_STA_INFO, psta, true);
 
 		{
 			u8 arg = 0;
@@ -505,7 +505,7 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 	DBG_88E("%s\n", __func__);
 
 	/* ap mode */
-	rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
+	rtl8188e_SetHalODMVar(padapter, HAL_ODM_STA_INFO, psta, true);
 
 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
 		psta->ieee8021x_blocked = true;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 37578638bb76..d330f58ab3ad 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -984,7 +984,7 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		psta->aid  = pnetwork->join_res;
 		psta->mac_id = 0;
 		/* sta mode */
-		rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
+		rtl8188e_SetHalODMVar(padapter, HAL_ODM_STA_INFO, psta, true);
 		/* security related */
 		if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 			padapter->securitypriv.binstallGrpkey = false;
@@ -1276,7 +1276,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	psta->mac_id = (uint)pstassoc->cam_id;
 	DBG_88E("%s\n", __func__);
 	/* for ad-hoc mode */
-	rtw_hal_set_odm_var(adapter, HAL_ODM_STA_INFO, psta, true);
+	rtl8188e_SetHalODMVar(adapter, HAL_ODM_STA_INFO, psta, true);
 	rtw_sta_media_status_rpt(adapter, psta, 1);
 	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
 		psta->dot118021XPrivacy = adapter->securitypriv.dot11PrivacyAlgrthm;
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index e2b6cf2386e0..3d237f276847 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1955,7 +1955,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 		/* Enable P2P function */
 		init_wifidirect_info(padapter, role);
 
-		rtw_hal_set_odm_var(padapter, HAL_ODM_P2P_STATE, NULL, true);
+		rtl8188e_SetHalODMVar(padapter, HAL_ODM_P2P_STATE, NULL, true);
 	} else if (role == P2P_ROLE_DISABLE) {
 		if (_FAIL == rtw_pwr_wakeup(padapter)) {
 			ret = _FAIL;
@@ -1974,7 +1974,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 			memset(&pwdinfo->rx_prov_disc_info, 0x00, sizeof(struct rx_provdisc_req_info));
 		}
 
-		rtw_hal_set_odm_var(padapter, HAL_ODM_P2P_STATE, NULL, false);
+		rtl8188e_SetHalODMVar(padapter, HAL_ODM_P2P_STATE, NULL, false);
 
 		/* Restore to initial setting. */
 		update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index c3600cb1790a..fc6484e403d0 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -320,7 +320,7 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	}
 
 	if (!(psta->state & WIFI_AP_STATE))
-		rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, false);
+		rtl8188e_SetHalODMVar(padapter, HAL_ODM_STA_INFO, psta, false);
 
 #ifdef CONFIG_88EU_AP_MODE
 
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index d467e734a699..4f893333cade 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -82,15 +82,6 @@ u8 rtw_hal_get_def_var(struct adapter *adapt,
 	return _FAIL;
 }
 
-void rtw_hal_set_odm_var(struct adapter *adapt,
-			 enum hal_odm_variable var, void *val1,
-			 bool set)
-{
-	if (adapt->HalFunc.SetHalODMVarHandler)
-		adapt->HalFunc.SetHalODMVarHandler(adapt, var,
-						      val1, set);
-}
-
 u32 rtw_hal_inirp_init(struct adapter *adapt)
 {
 	u32 rst = _FAIL;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 355878ec270d..bed89a1234bd 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1728,7 +1728,7 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 	MSG_88E("RF_Type is %x!!\n", pHalData->rf_type);
 }
 
-static void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
+void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
 	struct odm_dm_struct *podmpriv = &pHalData->odmpriv;
@@ -1816,8 +1816,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->sreset_linked_status_check  = &rtl8188e_sreset_linked_status_check;
 	pHalFunc->sreset_get_wifi_status  = &sreset_get_wifi_status;
 
-	pHalFunc->SetHalODMVarHandler = &rtl8188e_SetHalODMVar;
-
 	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
 
 	pHalFunc->hal_notch_filter = &hal_notch_filter_8188e;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 61f4a6bcb7dc..f6f0763e0ab3 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -162,10 +162,6 @@ struct hal_ops {
 				       enum hal_def_variable eVariable,
 				       void *pValue);
 
-	void	(*SetHalODMVarHandler)(struct adapter *padapter,
-				       enum hal_odm_variable eVariable,
-				       void *pValue1, bool bSet);
-
 	void	(*UpdateRAMaskHandler)(struct adapter *padapter,
 				       u32 mac_id, u8 rssi_level);
 	void	(*SetBeaconRelatedRegistersHandler)(struct adapter *padapter);
@@ -245,6 +241,8 @@ void rtl8188eu_set_hal_ops(struct adapter *padapter);
 void rtl8188eu_interface_configure(struct adapter *adapt);
 void ReadAdapterInfo8188EU(struct adapter *Adapter);
 void rtl8188eu_init_default_value(struct adapter *adapt);
+void rtl8188e_SetHalODMVar(struct adapter *Adapter,
+			   enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
 void	rtw_hal_free_data(struct adapter *padapter);
 
@@ -260,10 +258,6 @@ u8 rtw_hal_set_def_var(struct adapter *padapter,
 u8 rtw_hal_get_def_var(struct adapter *padapter,
 		       enum hal_def_variable eVariable, void *pValue);
 
-void rtw_hal_set_odm_var(struct adapter *padapter,
-			 enum hal_odm_variable eVariable, void *pValue1,
-			 bool bSet);
-
 u32	rtw_hal_inirp_init(struct adapter *padapter);
 u32	rtw_hal_inirp_deinit(struct adapter *padapter);
 
-- 
2.33.0

