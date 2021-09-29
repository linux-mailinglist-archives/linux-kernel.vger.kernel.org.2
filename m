Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0294241CC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346647AbhI2T25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346531AbhI2T2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:28:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F236CC061767
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:27:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dj4so13151240edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaIr8bS2XYiK8QFraQALJ3P6KYOZ0wQoxOaNHNAqnGM=;
        b=pGVhCU9uDa8oDMuN7X3tkISvfaDSiV5KyuP12aQrDWoshDt7dRcc1/LJVZeA1XibQX
         /xbzHIGEA/P8IZ+gR8PgfcCouupztM/+jObiUBzJCF51J9zs+kupHLiVf8h7N0JSLc+D
         8WUyQcoHX0vlsiWocDoT3jHE1v5VPIDXhHoRRPDXuNVJvfAy0Xee+5mhiF67vmr1Pk6V
         wAdFX+TyWGuVRd1pgqmUG00OJXzmJnwuEfHbfTGps5CyUtjBl6bepPeE/Ie1ifH9MUoi
         s5PIgRPs/cvHksypIDj4ZEi9p4AX3l54wKi7x+tZjfnS+xSur6KGakpy7jdDkCwA96iY
         t+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaIr8bS2XYiK8QFraQALJ3P6KYOZ0wQoxOaNHNAqnGM=;
        b=4caJWP3TNS+Un/StU4JswWwO/U+rDISm5XAw7oSCJ088Vx2RP0hj2wynLAz+HhRCbk
         uYvjArJ4kpLPsuAW+8G0eTN9k2/hyPRHaMVqR8CMMHzp9IdA2U/pkIfVdTuj7S+Y5lkT
         QhRfYe9OmjMMj4tLj4idCB0CqfmjHWCoILFtbKNmHYNP/OD4Nj9gV1Csmi/XY1R/F7N0
         onQ1ubJLuAKroibOaokP6gxgFo/56zFZVJtAc75DGTHjfLY0lXVQhx9V11GAO0OCXZ3u
         P/Mwu3LVkHSj8A6ZJ/e2EWaI5gdTddZu0zCLoU7I4iAhQd0zyu20z/mdSsJZJRHhQh1d
         ez/w==
X-Gm-Message-State: AOAM532hJ5Ue85mBnzsxAdg3bkP2KW6cySIM1AGgkyHnKhr7Ab3JpxiF
        d0tn1i5pOJZ+AEn8csXizw8=
X-Google-Smtp-Source: ABdhPJxXBhRh2E0NYLWf3ahWMrRQLMhNt6ysbHaAEKkrfLS3Num+Ns4DzxLj8evkC3yYL7SHGVJMTg==
X-Received: by 2002:a05:6402:1c8f:: with SMTP id cy15mr2015841edb.41.1632943626556;
        Wed, 29 Sep 2021 12:27:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::bfc8])
        by smtp.gmail.com with ESMTPSA id f10sm449019edu.70.2021.09.29.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:27:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/7] staging: r8188eu: remove GetHalDefVarHandler from struct hal_ops
Date:   Wed, 29 Sep 2021 21:26:52 +0200
Message-Id: <20210929192657.9569-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929192657.9569-1-straube.linux@gmail.com>
References: <20210929192657.9569-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove GetHalDefVarHandler from struct hal_ops and remove its wrapper
rtw_hal_get_def_var(). Call GetHalDefVar8188EUsb() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c       |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c      | 14 +++++++-------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  |  8 ++++----
 drivers/staging/r8188eu/core/rtw_recv.c      |  2 +-
 drivers/staging/r8188eu/hal/hal_intf.c       |  8 --------
 drivers/staging/r8188eu/hal/usb_halinit.c    | 13 ++-----------
 drivers/staging/r8188eu/include/hal_intf.h   |  8 +-------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  4 ++--
 8 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index e11aa5929180..e502c1bf6c7a 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1116,7 +1116,7 @@ u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
 	u8	support_ant_div;
 	u8	res = _SUCCESS;
 
-	rtw_hal_get_def_var(padapter, HAL_DEF_IS_SUPPORT_ANT_DIV, &support_ant_div);
+	GetHalDefVar8188EUsb(padapter, HAL_DEF_IS_SUPPORT_ANT_DIV, &support_ant_div);
 	if (!support_ant_div)
 		return res;
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index f1bc4b2e930d..91cf1161dc94 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -504,7 +504,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			/* If there are no more slots, expire the oldest */
 			pnetwork = oldest;
 
-			rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA, &target->PhyInfo.Optimum_antenna);
+			GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &target->PhyInfo.Optimum_antenna);
 			memcpy(&pnetwork->network, target,  get_wlan_bssid_ex_sz(target));
 			/*  variable initialize */
 			pnetwork->fixed = false;
@@ -527,7 +527,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
 			target->Length = bssid_ex_sz;
-			rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA, &target->PhyInfo.Optimum_antenna);
+			GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &target->PhyInfo.Optimum_antenna);
 			memcpy(&pnetwork->network, target, bssid_ex_sz);
 
 			pnetwork->last_scanned = jiffies;
@@ -1539,10 +1539,10 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		rtw_free_assoc_resources(adapter, 0);
 	}
 
-	rtw_hal_get_def_var(adapter, HAL_DEF_IS_SUPPORT_ANT_DIV, &(supp_ant_div));
+	GetHalDefVar8188EUsb(adapter, HAL_DEF_IS_SUPPORT_ANT_DIV, &supp_ant_div);
 	if (supp_ant_div) {
 		u8 cur_ant;
-		rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA, &(cur_ant));
+		GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &cur_ant);
 		DBG_88E("#### Opt_Ant_(%s), cur_Ant(%s)\n",
 			(2 == candidate->network.PhyInfo.Optimum_antenna) ? "A" : "B",
 			(2 == cur_ant) ? "A" : "B"
@@ -1923,15 +1923,15 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 						IEEE80211_HT_CAP_TX_STBC |
 						IEEE80211_HT_CAP_DSSSCCK40);
 
-		rtw_hal_get_def_var(padapter, HAL_DEF_RX_PACKET_OFFSET, &rx_packet_offset);
-		rtw_hal_get_def_var(padapter, HAL_DEF_MAX_RECVBUF_SZ, &max_recvbuf_sz);
+		GetHalDefVar8188EUsb(padapter, HAL_DEF_RX_PACKET_OFFSET, &rx_packet_offset);
+		GetHalDefVar8188EUsb(padapter, HAL_DEF_MAX_RECVBUF_SZ, &max_recvbuf_sz);
 
 		/*
 		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
 		AMPDU_para [4:2]:Min MPDU Start Spacing
 		*/
 
-		rtw_hal_get_def_var(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor);
+		GetHalDefVar8188EUsb(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor);
 		ht_capie.ampdu_params_info = (max_rx_ampdu_factor & 0x03);
 
 		if (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 905e7f0b83d1..3becd1002e74 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5807,7 +5807,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->ADDBA_req.dialog_token, &pattrib->pktlen);
 			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&status, &pattrib->pktlen);
 			BA_para_set = le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f;
-			rtw_hal_get_def_var(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor);
+			GetHalDefVar8188EUsb(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor);
 			switch (max_rx_ampdu_factor) {
 			case MAX_AMPDU_FACTOR_64K:
 				BA_para_set |= 0x1000; /* 64 buffer size */
@@ -6263,7 +6263,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	bssid->Rssi = precv_frame->attrib.phy_info.recvpower; /*  in dBM.raw data */
 	bssid->PhyInfo.SignalQuality = precv_frame->attrib.phy_info.SignalQuality;/* in percentage */
 	bssid->PhyInfo.SignalStrength = precv_frame->attrib.phy_info.SignalStrength;/* in percentage */
-	rtw_hal_get_def_var(padapter, HAL_DEF_CURRENT_ANTENNA,  &bssid->PhyInfo.Optimum_antenna);
+	GetHalDefVar8188EUsb(padapter, HAL_DEF_CURRENT_ANTENNA,  &bssid->PhyInfo.Optimum_antenna);
 
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
@@ -7154,9 +7154,9 @@ void _linked_rx_signal_strehgth_display(struct adapter *padapter)
 	else if ((pmlmeinfo->state & 0x03) == _HW_STATE_AP_)
 		mac_id = 2;
 
-	rtw_hal_get_def_var(padapter, HW_DEF_RA_INFO_DUMP, &mac_id);
+	GetHalDefVar8188EUsb(padapter, HW_DEF_RA_INFO_DUMP, &mac_id);
 
-	rtw_hal_get_def_var(padapter, HAL_DEF_UNDERCORATEDSMOOTHEDPWDB, &UndecoratedSmoothedPWDB);
+	GetHalDefVar8188EUsb(padapter, HAL_DEF_UNDERCORATEDSMOOTHEDPWDB, &UndecoratedSmoothedPWDB);
 	DBG_88E("UndecoratedSmoothedPWDB:%d\n", UndecoratedSmoothedPWDB);
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 5ac63bd6dd8e..7bbbe412a5cd 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1114,7 +1114,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	pattrib->order = GetOrder(ptr);
 
 	/* Dump rx packets */
-	rtw_hal_get_def_var(adapter, HAL_DEF_DBG_DUMP_RXPKT, &(bDumpRxPkt));
+	GetHalDefVar8188EUsb(adapter, HAL_DEF_DBG_DUMP_RXPKT, &bDumpRxPkt);
 	if (bDumpRxPkt == 1) {/* dump all rx packets */
 		int i;
 		DBG_88E("#############################\n");
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index c1e7e38f3d40..f72978e384ac 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -53,14 +53,6 @@ void rtw_hal_get_hwreg(struct adapter *adapt, u8 variable, u8 *val)
 		adapt->HalFunc.GetHwRegHandler(adapt, variable, val);
 }
 
-u8 rtw_hal_get_def_var(struct adapter *adapt,
-		       enum hal_def_variable var, void *val)
-{
-	if (adapt->HalFunc.GetHalDefVarHandler)
-		return adapt->HalFunc.GetHalDefVarHandler(adapt, var, val);
-	return _FAIL;
-}
-
 u32 rtw_hal_inirp_init(struct adapter *adapt)
 {
 	u32 rst = _FAIL;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 6eaf97f80e5e..cebad5590d15 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1863,16 +1863,8 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 }
 
-/*  */
-/*	Description: */
-/*		Query setting of specified variable. */
-/*  */
-static u8
-GetHalDefVar8188EUsb(
-		struct adapter *Adapter,
-		enum hal_def_variable eVariable,
-		void *pValue
-	)
+/* Query setting of specified variable. */
+u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
 {
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	u8 bResult = _SUCCESS;
@@ -2168,5 +2160,4 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 
 	halfunc->SetHwRegHandler = &SetHwReg8188EU;
 	halfunc->GetHwRegHandler = &GetHwReg8188EU;
-	halfunc->GetHalDefVarHandler = &GetHalDefVar8188EUsb;
 }
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 03dc593eb12c..22a52d2ed477 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -137,10 +137,6 @@ struct hal_ops {
 				   u8 *val);
 	void	(*GetHwRegHandler)(struct adapter *padapter, u8	variable,
 				   u8 *val);
-
-	u8	(*GetHalDefVarHandler)(struct adapter *padapter,
-				       enum hal_def_variable eVariable,
-				       void *pValue);
 };
 
 #define RF_CHANGE_BY_INIT	0
@@ -181,6 +177,7 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter,
 				struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt);
 
 u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
+u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
@@ -188,9 +185,6 @@ void rtw_hal_stop(struct adapter *padapter);
 void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 
-u8 rtw_hal_get_def_var(struct adapter *padapter,
-		       enum hal_def_variable eVariable, void *pValue);
-
 u32	rtw_hal_inirp_init(struct adapter *padapter);
 u32	rtw_hal_inirp_deinit(struct adapter *padapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 41ab38f9d876..dd47098ed1e5 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4082,7 +4082,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				u32 odm_flag;
 
 				if (0xf == extra_arg) {
-					rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
+					GetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
 					DBG_88E(" === DMFlag(0x%08x) ===\n", odm_flag);
 					DBG_88E("extra_arg = 0  - disable all dynamic func\n");
 					DBG_88E("extra_arg = 1  - disable DIG- BIT(0)\n");
@@ -4098,7 +4098,7 @@ static int rtw_dbg_port(struct net_device *dev,
 						extra_arg = 3  - turn on all dynamic func
 					*/
 					SetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &extra_arg);
-					rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
+					GetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
 					DBG_88E(" === DMFlag(0x%08x) ===\n", odm_flag);
 				}
 			}
-- 
2.33.0

