Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CF9425149
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbhJGKm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbhJGKlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:41:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E058C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 03:39:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so17632397wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jm0hoPqe7Hbu/bsPpZxWG/15Yp25O5nqDMfQ5keBdq4=;
        b=S0cSdye2i0Qi+cP9/5HSEY9tt/9xmM/24YxgPxqqJ7eFX7XN9oiHHTVlCJeqMbbTb4
         TPfFljg2vc+8ffMYLmKqcaRgyO7PrWAMz9S+W/NsXMfBGreT6f4b89aRgmstLo8L0Nuk
         icpXXOM0+75tRLN/SyGqzVFNtUNKHuVuDIBufMOrwliabpp3pd28Gup9HkJ2aR1TpTiB
         pnLT0mfmYQQbqNgFaJ59rEoP7XN/WV31nDzg1t0LGZmJAMJ8h+YxiBK1Cla4OEJVuZdA
         eo6LWHS9egqBvvCnmP6jWR3PRcU8Sq8X0rR8A/naQI10iMK/R81LFJqI2NS+IlnHTptM
         n8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jm0hoPqe7Hbu/bsPpZxWG/15Yp25O5nqDMfQ5keBdq4=;
        b=kevQeOfW5gDJLkArwtmpp0jROV0TeQF4V38FrkzLRipmEsBfO0EQYVLKsBsNyoxRpE
         zyVh0J8iH2EstOPhWrMAUyRYOMxpTvV2Y1m46Y3O5zDpwU8OKGAxSJXZ/QyMm5tDmGA/
         /Fh+UKjvQq+4hLMXzcMu0klxmKBhob6BvUcajC3S/CCmuH7FYtEpXfWLYpwpK+e5i0+n
         9wmett1snsi1ZBQt+iboccapXSTFMIAtpEjtJMTHNG1krI3EdzEOoJQRoE3cJL+yL/0+
         dgyrE/D5nZ73czIlSArWBX32zwx55Vv0KoHwSrO/ImD6MZxdMQwv9m73nr9pDWCS/Bza
         xvzw==
X-Gm-Message-State: AOAM5304kL8eb7xsFZZZtH/NkINykspv0MPmmY1IcLzFZzvedQoVr3Bb
        dn06U3KmxSP9T815cUtik+U=
X-Google-Smtp-Source: ABdhPJyTwVmQldCu2Uh9lMOJvMpwP1pgnfvc4WriUE0ct5q4yMoM1bzqm2zB7wlGcjZ6T7EJ2JwDVw==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr4504547wry.364.1633603188765;
        Thu, 07 Oct 2021 03:39:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d0b])
        by smtp.gmail.com with ESMTPSA id n14sm10224853wms.0.2021.10.07.03.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:39:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: remove SetHwRegHandler from hal_ops
Date:   Thu,  7 Oct 2021 12:39:39 +0200
Message-Id: <20211007103943.8433-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007103943.8433-1-straube.linux@gmail.com>
References: <20211007103943.8433-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SetHwRegHandler from struct hal_ops and remove the wrapper
rtw_hal_set_hwreg(). Call SetHwReg8188EU() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c        |  8 +--
 drivers/staging/r8188eu/core/rtw_mlme.c       | 11 ++-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 69 ++++++++-----------
 drivers/staging/r8188eu/core/rtw_p2p.c        | 16 ++---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  4 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 42 +++++------
 drivers/staging/r8188eu/hal/hal_com.c         |  3 +-
 drivers/staging/r8188eu/hal/hal_intf.c        |  6 --
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  4 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  4 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  3 +-
 drivers/staging/r8188eu/include/hal_intf.h    |  5 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  2 +-
 14 files changed, 78 insertions(+), 101 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 26b96daea8db..66349fed31cf 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1003,12 +1003,12 @@ static void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 		mstatus = 1;/* connect */
 		/*  Reset LPS Setting */
 		padapter->pwrctrlpriv.LpsIdleCount = 0;
-		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_JOINBSSRPT, (u8 *)(&mstatus));
+		SetHwReg8188EU(padapter, HW_VAR_H2C_FW_JOINBSSRPT, (u8 *)(&mstatus));
 		break;
 	case LPS_CTRL_DISCONNECT:
 		mstatus = 0;/* disconnect */
 		LPS_Leave(padapter);
-		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_JOINBSSRPT, (u8 *)(&mstatus));
+		SetHwReg8188EU(padapter, HW_VAR_H2C_FW_JOINBSSRPT, (u8 *)(&mstatus));
 		break;
 	case LPS_CTRL_SPECIAL_PACKET:
 		/* DBG_88E("LPS_CTRL_SPECIAL_PACKET\n"); */
@@ -1068,7 +1068,7 @@ u8 rtw_lps_ctrl_wk_cmd(struct adapter *padapter, u8 lps_ctrl_type, u8 enqueue)
 
 static void rpt_timer_setting_wk_hdl(struct adapter *padapter, u16 min_time)
 {
-	rtw_hal_set_hwreg(padapter, HW_VAR_RPT_TIMER_SETTING, (u8 *)(&min_time));
+	SetHwReg8188EU(padapter, HW_VAR_RPT_TIMER_SETTING, (u8 *)(&min_time));
 }
 
 u8 rtw_rpt_timer_cfg_cmd(struct adapter *padapter, u16 min_time)
@@ -1105,7 +1105,7 @@ u8 rtw_rpt_timer_cfg_cmd(struct adapter *padapter, u16 min_time)
 
 static void antenna_select_wk_hdl(struct adapter *padapter, u8 antenna)
 {
-	rtw_hal_set_hwreg(padapter, HW_VAR_ANTENNA_DIVERSITY_SELECT, (u8 *)(&antenna));
+	SetHwReg8188EU(padapter, HW_VAR_ANTENNA_DIVERSITY_SELECT, (u8 *)(&antenna));
 }
 
 u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 91cf1161dc94..408c9f8c6f6d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1162,11 +1162,10 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta,
 		return;
 
 	macid = search_max_mac_id(adapter);
-	rtw_hal_set_hwreg(adapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&macid);
+	SetHwReg8188EU(adapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&macid);
 	/* MACID|OPMODE:1 connect */
 	media_status_rpt = (u16)((psta->mac_id << 8) | mstatus);
-	rtw_hal_set_hwreg(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT,
-			  (u8 *)&media_status_rpt);
+	SetHwReg8188EU(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status_rpt);
 }
 
 void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
@@ -1246,7 +1245,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 		u16 media_status;
 		media_status = (mac_id << 8) | 0; /*   MACID|OPMODE:0 means disconnect */
 		/* for STA, AP, ADHOC mode, report disconnect stauts to FW */
-		rtw_hal_set_hwreg(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
+		SetHwReg8188EU(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
@@ -1880,10 +1879,10 @@ void rtw_joinbss_reset(struct adapter *padapter)
 			threshold = 1;
 		else
 			threshold = 0;
-		rtw_hal_set_hwreg(padapter, HW_VAR_RXDMA_AGG_PG_TH, (u8 *)(&threshold));
+		SetHwReg8188EU(padapter, HW_VAR_RXDMA_AGG_PG_TH, (u8 *)(&threshold));
 	} else {
 		threshold = 1;
-		rtw_hal_set_hwreg(padapter, HW_VAR_RXDMA_AGG_PG_TH, (u8 *)(&threshold));
+		SetHwReg8188EU(padapter, HW_VAR_RXDMA_AGG_PG_TH, (u8 *)(&threshold));
 	}
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 3becd1002e74..3aa5d9a0d361 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6031,7 +6031,7 @@ unsigned int send_beacon(struct adapter *padapter)
 
 	u32 start = jiffies;
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_BCN_VALID, NULL);
+	SetHwReg8188EU(padapter, HW_VAR_BCN_VALID, NULL);
 	do {
 		issue_beacon(padapter, 100);
 		issue++;
@@ -6098,10 +6098,6 @@ void site_survey(struct adapter *padapter)
 	}
 
 	if (survey_channel != 0) {
-		/* PAUSE 4-AC Queue when site_survey */
-		/* rtw_hal_get_hwreg(padapter, HW_VAR_TXPAUSE, (u8 *)(&val8)); */
-		/* val8 |= 0x0f; */
-		/* rtw_hal_set_hwreg(padapter, HW_VAR_TXPAUSE, (u8 *)(&val8)); */
 		if (pmlmeext->sitesurvey_res.channel_idx == 0)
 			set_channel_bwmode(padapter, survey_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 		else
@@ -6151,7 +6147,7 @@ void site_survey(struct adapter *padapter)
 			pmlmeext->sitesurvey_res.state = SCAN_DISABLE;
 
 			initialgain = 0xff; /* restore RX GAIN */
-			rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
+			SetHwReg8188EU(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
 			/* turn on dynamic functions */
 			Restore_DM_Func_Flag(padapter);
 			/* Switch_DM_Func(padapter, DYNAMIC_FUNC_DIG|DYNAMIC_FUNC_HP|DYNAMIC_FUNC_SS, true); */
@@ -6181,15 +6177,11 @@ void site_survey(struct adapter *padapter)
 			else
 				set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode);
 
-			/* flush 4-AC Queue after site_survey */
-			/* val8 = 0; */
-			/* rtw_hal_set_hwreg(padapter, HW_VAR_TXPAUSE, (u8 *)(&val8)); */
-
 			/* config MSR */
 			Set_MSR(padapter, (pmlmeinfo->state & 0x3));
 
 			initialgain = 0xff; /* restore RX GAIN */
-			rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
+			SetHwReg8188EU(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
 			/* turn on dynamic functions */
 			Restore_DM_Func_Flag(padapter);
 			/* Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true); */
@@ -6198,7 +6190,7 @@ void site_survey(struct adapter *padapter)
 				issue_nulldata(padapter, NULL, 0, 3, 500);
 
 			val8 = 0; /* survey done */
-			rtw_hal_set_hwreg(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
+			SetHwReg8188EU(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
 
 			report_surveydone_event(padapter);
 
@@ -6391,7 +6383,7 @@ void start_create_ibss(struct adapter *padapter)
 	update_capinfo(padapter, caps);
 	if (caps & cap_IBSS) {/* adhoc master */
 		val8 = 0xcf;
-		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
+		SetHwReg8188EU(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
 		/* switch channel */
 		/* SelectChannel(padapter, pmlmeext->cur_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE); */
@@ -6408,9 +6400,9 @@ void start_create_ibss(struct adapter *padapter)
 			report_join_res(padapter, -1);
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		} else {
-			rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, padapter->registrypriv.dev_network.MacAddress);
+			SetHwReg8188EU(padapter, HW_VAR_BSSID, padapter->registrypriv.dev_network.MacAddress);
 			join_type = 0;
-			rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
+			SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
 			report_join_res(padapter, 1);
 			pmlmeinfo->state |= WIFI_FW_ASSOC_SUCCESS;
@@ -6447,7 +6439,7 @@ void start_clnt_join(struct adapter *padapter)
 
 		val8 = (pmlmeinfo->auth_algo == dot11AuthAlgrthm_8021X) ? 0xcc : 0xcf;
 
-		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
+		SetHwReg8188EU(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
 		/* switch channel */
 		set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode);
@@ -6464,7 +6456,7 @@ void start_clnt_join(struct adapter *padapter)
 		Set_MSR(padapter, WIFI_FW_ADHOC_STATE);
 
 		val8 = 0xcf;
-		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
+		SetHwReg8188EU(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
 		/* switch channel */
 		set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode);
@@ -7001,8 +6993,8 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 
 	if (join_res < 0) {
 		join_type = 1;
-		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
-		rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, null_addr);
+		SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
+		SetHwReg8188EU(padapter, HW_VAR_BSSID, null_addr);
 
 		/* restore to initial setting. */
 		update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
@@ -7026,10 +7018,10 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	/*  update IOT-releated issue */
 	update_IOT_info(padapter);
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, cur_network->SupportedRates);
+	SetHwReg8188EU(padapter, HW_VAR_BASIC_RATE, cur_network->SupportedRates);
 
 	/* BCN interval */
-	rtw_hal_set_hwreg(padapter, HW_VAR_BEACON_INTERVAL, (u8 *)(&pmlmeinfo->bcn_interval));
+	SetHwReg8188EU(padapter, HW_VAR_BEACON_INTERVAL, (u8 *)(&pmlmeinfo->bcn_interval));
 
 	/* udpate capability */
 	update_capinfo(padapter, pmlmeinfo->capability);
@@ -7050,13 +7042,13 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 
 		/* set per sta rate after updating HT cap. */
 		set_sta_rate(padapter, psta);
-		rtw_hal_set_hwreg(padapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&psta->mac_id);
+		SetHwReg8188EU(padapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&psta->mac_id);
 		media_status = (psta->mac_id << 8) | 1; /*   MACID|OPMODE: 1 means connect */
-		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
+		SetHwReg8188EU(padapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
 	}
 
 	join_type = 2;
-	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
+	SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
 		/*  correcting TSF */
@@ -7094,7 +7086,7 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 		}
 
 		join_type = 2;
-		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
+		SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 	}
 
 	pmlmeinfo->FW_sta_info[psta->mac_id].psta = psta;
@@ -7112,8 +7104,8 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (is_client_associated_to_ap(padapter) || is_IBSS_empty(padapter)) {
-		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_DISCONNECT, NULL);
-		rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, null_addr);
+		SetHwReg8188EU(padapter, HW_VAR_MLME_DISCONNECT, NULL);
+		SetHwReg8188EU(padapter, HW_VAR_BSSID, null_addr);
 
 		/* restore to initial setting. */
 		update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
@@ -7416,8 +7408,7 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
 		type = _HW_STATE_NOLINK_;
 	}
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_SET_OPMODE, (u8 *)(&type));
-	/* Set_NETYPE0_MSR(padapter, type); */
+	SetHwReg8188EU(padapter, HW_VAR_SET_OPMODE, (u8 *)(&type));
 
 	return H2C_SUCCESS;
 }
@@ -7455,10 +7446,6 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 		Save_DM_Func_Flag(padapter);
 		Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false);
 
-		/* config the initial gain under linking, need to write the BB registers */
-		/* initialgain = 0x1E; */
-		/* rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain)); */
-
 		/* cancel link timer */
 		_cancel_timer_ex(&pmlmeext->link_timer);
 
@@ -7505,7 +7492,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 		/* set MSR to nolink -> infra. mode */
 		Set_MSR(padapter, _HW_STATE_STATION_);
 
-		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_DISCONNECT, NULL);
+		SetHwReg8188EU(padapter, HW_VAR_MLME_DISCONNECT, NULL);
 	}
 
 	rtw_antenna_select_cmd(padapter, pparm->network.PhyInfo.Optimum_antenna, false);
@@ -7580,9 +7567,9 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	/* config the initial gain under linking, need to write the BB registers */
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pmlmeinfo->network.MacAddress);
+	SetHwReg8188EU(padapter, HW_VAR_BSSID, pmlmeinfo->network.MacAddress);
 	join_type = 0;
-	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
+	SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
 	/* cancel link timer */
 	_cancel_timer_ex(&pmlmeext->link_timer);
@@ -7603,8 +7590,8 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	if (is_client_associated_to_ap(padapter))
 		issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms / 100, 100);
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_DISCONNECT, NULL);
-	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, null_addr);
+	SetHwReg8188EU(padapter, HW_VAR_MLME_DISCONNECT, NULL);
+	SetHwReg8188EU(padapter, HW_VAR_BSSID, null_addr);
 
 	/* restore to initial setting. */
 	update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
@@ -7612,7 +7599,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)) {
 		/* Stop BCN */
 		val8 = 0;
-		rtw_hal_set_hwreg(padapter, HW_VAR_BCN_FUNC, (u8 *)(&val8));
+		SetHwReg8188EU(padapter, HW_VAR_BCN_FUNC, (u8 *)(&val8));
 	}
 
 	/* set MSR to no link state -> infra. mode */
@@ -7736,13 +7723,13 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 		else
 			initialgain = 0x28;
 
-		rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
+		SetHwReg8188EU(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
 
 		/* set MSR to no link state */
 		Set_MSR(padapter, _HW_STATE_NOLINK_);
 
 		val8 = 1; /* under site survey */
-		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
+		SetHwReg8188EU(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
 
 		pmlmeext->sitesurvey_res.state = SCAN_PROCESS;
 	}
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index dbcf8bd24e6a..b265b5e46851 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1485,7 +1485,7 @@ static void pre_tx_invitereq_handler(struct adapter *padapter)
 	u8	val8 = 1;
 
 	set_channel_bwmode(padapter, pwdinfo->invitereq_info.peer_ch, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
-	padapter->HalFunc.SetHwRegHandler(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
+	SetHwReg8188EU(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
 	issue_probereq_p2p(padapter, NULL);
 	_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
@@ -1497,7 +1497,7 @@ static void pre_tx_provdisc_handler(struct adapter *padapter)
 	u8	val8 = 1;
 
 	set_channel_bwmode(padapter, pwdinfo->tx_prov_disc_info.peer_channel_num[0], HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
-	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
+	SetHwReg8188EU(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
 	issue_probereq_p2p(padapter, NULL);
 	_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
@@ -1509,7 +1509,7 @@ static void pre_tx_negoreq_handler(struct adapter *padapter)
 	u8	val8 = 1;
 
 	set_channel_bwmode(padapter, pwdinfo->nego_req_info.peer_channel_num[0], HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
-	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
+	SetHwReg8188EU(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
 	issue_probereq_p2p(padapter, NULL);
 	_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
@@ -1634,7 +1634,7 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 	case P2P_PS_DISABLE:
 		pwdinfo->p2p_ps_state = p2p_ps_state;
 
-		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_P2P_PS_OFFLOAD, (u8 *)(&p2p_ps_state));
+		SetHwReg8188EU(padapter, HW_VAR_H2C_FW_P2P_PS_OFFLOAD, (u8 *)(&p2p_ps_state));
 
 		pwdinfo->noa_index = 0;
 		pwdinfo->ctwindow = 0;
@@ -1644,7 +1644,7 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 		if (padapter->pwrctrlpriv.bFwCurrentInPSMode) {
 			if (pwrpriv->smart_ps == 0) {
 				pwrpriv->smart_ps = 2;
-				rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&padapter->pwrctrlpriv.pwr_mode));
+				SetHwReg8188EU(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&padapter->pwrctrlpriv.pwr_mode));
 			}
 		}
 		break;
@@ -1656,10 +1656,10 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 				if (pwrpriv->smart_ps != 0) {
 					pwrpriv->smart_ps = 0;
 					DBG_88E("%s(): Enter CTW, change SmartPS\n", __func__);
-					rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&padapter->pwrctrlpriv.pwr_mode));
+					SetHwReg8188EU(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&padapter->pwrctrlpriv.pwr_mode));
 				}
 			}
-			rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_P2P_PS_OFFLOAD, (u8 *)(&p2p_ps_state));
+			SetHwReg8188EU(padapter, HW_VAR_H2C_FW_P2P_PS_OFFLOAD, (u8 *)(&p2p_ps_state));
 		}
 		break;
 	case P2P_PS_SCAN:
@@ -1667,7 +1667,7 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 	case P2P_PS_ALLSTASLEEP:
 		if (pwdinfo->p2p_ps_mode > P2P_PS_NONE) {
 			pwdinfo->p2p_ps_state = p2p_ps_state;
-			rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_P2P_PS_OFFLOAD, (u8 *)(&p2p_ps_state));
+			SetHwReg8188EU(padapter, HW_VAR_H2C_FW_P2P_PS_OFFLOAD, (u8 *)(&p2p_ps_state));
 		}
 		break;
 	default:
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index ca983ec9f9cf..20654f2df07a 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -212,7 +212,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 		if (pwdinfo->opp_ps == 0) {
 			DBG_88E("rtw_set_ps_mode: Leave 802.11 power save\n");
 			pwrpriv->pwr_mode = ps_mode;
-			rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
+			SetHwReg8188EU(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
 			pwrpriv->bFwCurrentInPSMode = false;
 		}
 	} else {
@@ -222,7 +222,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 			pwrpriv->pwr_mode = ps_mode;
 			pwrpriv->smart_ps = smart_ps;
 			pwrpriv->bcn_ant_mode = bcn_ant_mode;
-			rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
+			SetHwReg8188EU(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
 
 			/*  Set CTWindow after LPS */
 			if (pwdinfo->opp_ps == 1)
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 8db68cf1e11c..323f0ee1f8e6 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -266,27 +266,27 @@ void Save_DM_Func_Flag(struct adapter *padapter)
 {
 	u8	saveflag = true;
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
+	SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
 }
 
 void Restore_DM_Func_Flag(struct adapter *padapter)
 {
 	u8	saveflag = false;
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
+	SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
 }
 
 void Switch_DM_Func(struct adapter *padapter, u32 mode, u8 enable)
 {
 	if (enable)
-		rtw_hal_set_hwreg(padapter, HW_VAR_DM_FUNC_SET, (u8 *)(&mode));
+		SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_SET, (u8 *)(&mode));
 	else
-		rtw_hal_set_hwreg(padapter, HW_VAR_DM_FUNC_CLR, (u8 *)(&mode));
+		SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_CLR, (u8 *)(&mode));
 }
 
 static void Set_NETYPE0_MSR(struct adapter *padapter, u8 type)
 {
-	rtw_hal_set_hwreg(padapter, HW_VAR_MEDIA_STATUS, (u8 *)(&type));
+	SetHwReg8188EU(padapter, HW_VAR_MEDIA_STATUS, (u8 *)(&type));
 }
 
 void Set_MSR(struct adapter *padapter, u8 type)
@@ -429,7 +429,7 @@ unsigned int decide_wait_for_beacon_timeout(unsigned int bcn_interval)
 
 void invalidate_cam_all(struct adapter *padapter)
 {
-	rtw_hal_set_hwreg(padapter, HW_VAR_CAM_INVALID_ALL, NULL);
+	SetHwReg8188EU(padapter, HW_VAR_CAM_INVALID_ALL, NULL);
 }
 
 void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
@@ -457,7 +457,7 @@ void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
 		cam_val[0] = val;
 		cam_val[1] = addr + (unsigned int)j;
 
-		rtw_hal_set_hwreg(padapter, HW_VAR_CAM_WRITE, (u8 *)cam_val);
+		SetHwReg8188EU(padapter, HW_VAR_CAM_WRITE, (u8 *)cam_val);
 	}
 }
 
@@ -492,7 +492,7 @@ void flush_all_cam_entry(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_CAM_INVALID_ALL, NULL);
+	SetHwReg8188EU(padapter, HW_VAR_CAM_INVALID_ALL, NULL);
 
 	memset((u8 *)(pmlmeinfo->FW_sta_info), 0, sizeof(pmlmeinfo->FW_sta_info));
 }
@@ -553,21 +553,21 @@ void WMMOnAssocRsp(struct adapter *padapter)
 
 		switch (ACI) {
 		case 0x0:
-			rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_BE, (u8 *)(&acParm));
+			SetHwReg8188EU(padapter, HW_VAR_AC_PARAM_BE, (u8 *)(&acParm));
 			acm_mask |= (ACM ? BIT(1) : 0);
 			edca[XMIT_BE_QUEUE] = acParm;
 			break;
 		case 0x1:
-			rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_BK, (u8 *)(&acParm));
+			SetHwReg8188EU(padapter, HW_VAR_AC_PARAM_BK, (u8 *)(&acParm));
 			edca[XMIT_BK_QUEUE] = acParm;
 			break;
 		case 0x2:
-			rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_VI, (u8 *)(&acParm));
+			SetHwReg8188EU(padapter, HW_VAR_AC_PARAM_VI, (u8 *)(&acParm));
 			acm_mask |= (ACM ? BIT(2) : 0);
 			edca[XMIT_VI_QUEUE] = acParm;
 			break;
 		case 0x3:
-			rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_VO, (u8 *)(&acParm));
+			SetHwReg8188EU(padapter, HW_VAR_AC_PARAM_VO, (u8 *)(&acParm));
 			acm_mask |= (ACM ? BIT(3) : 0);
 			edca[XMIT_VO_QUEUE] = acParm;
 			break;
@@ -577,7 +577,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 	}
 
 	if (padapter->registrypriv.acm_method == 1)
-		rtw_hal_set_hwreg(padapter, HW_VAR_ACM_CTRL, (u8 *)(&acm_mask));
+		SetHwReg8188EU(padapter, HW_VAR_ACM_CTRL, (u8 *)(&acm_mask));
 	else
 		padapter->mlmepriv.acm_mask = acm_mask;
 
@@ -787,9 +787,9 @@ void HTOnAssocRsp(struct adapter *padapter)
 
 	min_MPDU_spacing = (pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c) >> 2;
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, (u8 *)(&min_MPDU_spacing));
+	SetHwReg8188EU(padapter, HW_VAR_AMPDU_MIN_SPACE, (u8 *)(&min_MPDU_spacing));
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, (u8 *)(&max_AMPDU_len));
+	SetHwReg8188EU(padapter, HW_VAR_AMPDU_FACTOR, (u8 *)(&max_AMPDU_len));
 }
 
 void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
@@ -1249,7 +1249,7 @@ void update_tx_basic_rate(struct adapter *padapter, u8 wirelessmode)
 	else
 		update_mgnt_tx_rate(padapter, IEEE80211_OFDM_RATE_6MB);
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, supported_rates);
+	SetHwReg8188EU(padapter, HW_VAR_BASIC_RATE, supported_rates);
 }
 
 unsigned char check_assoc_AP(u8 *pframe, uint len)
@@ -1366,13 +1366,13 @@ void update_capinfo(struct adapter *Adapter, u16 updateCap)
 		if (pmlmeinfo->preamble_mode != PREAMBLE_SHORT) { /*  PREAMBLE_LONG or PREAMBLE_AUTO */
 			ShortPreamble = true;
 			pmlmeinfo->preamble_mode = PREAMBLE_SHORT;
-			rtw_hal_set_hwreg(Adapter, HW_VAR_ACK_PREAMBLE, (u8 *)&ShortPreamble);
+			SetHwReg8188EU(Adapter, HW_VAR_ACK_PREAMBLE, (u8 *)&ShortPreamble);
 		}
 	} else { /*  Long Preamble */
 		if (pmlmeinfo->preamble_mode != PREAMBLE_LONG) {  /*  PREAMBLE_SHORT or PREAMBLE_AUTO */
 			ShortPreamble = false;
 			pmlmeinfo->preamble_mode = PREAMBLE_LONG;
-			rtw_hal_set_hwreg(Adapter, HW_VAR_ACK_PREAMBLE, (u8 *)&ShortPreamble);
+			SetHwReg8188EU(Adapter, HW_VAR_ACK_PREAMBLE, (u8 *)&ShortPreamble);
 		}
 	}
 
@@ -1394,7 +1394,7 @@ void update_capinfo(struct adapter *Adapter, u16 updateCap)
 		}
 	}
 
-	rtw_hal_set_hwreg(Adapter, HW_VAR_SLOT_TIME, &pmlmeinfo->slotTime);
+	SetHwReg8188EU(Adapter, HW_VAR_SLOT_TIME, &pmlmeinfo->slotTime);
 }
 
 void update_wireless_mode(struct adapter *padapter)
@@ -1430,7 +1430,7 @@ void update_wireless_mode(struct adapter *padapter)
 	SIFS_Timer = 0x0a0a0808;/* 0x0808 -> for CCK, 0x0a0a -> for OFDM */
 				/* change this value if having IOT issues. */
 
-	padapter->HalFunc.SetHwRegHandler(padapter, HW_VAR_RESP_SIFS,  (u8 *)&SIFS_Timer);
+	SetHwReg8188EU(padapter, HW_VAR_RESP_SIFS, (u8 *)&SIFS_Timer);
 
 	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
 		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
@@ -1512,7 +1512,7 @@ void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 
 void correct_TSF(struct adapter *padapter, struct mlme_ext_priv *pmlmeext)
 {
-	rtw_hal_set_hwreg(padapter, HW_VAR_CORRECT_TSF, NULL);
+	SetHwReg8188EU(padapter, HW_VAR_CORRECT_TSF, NULL);
 }
 
 void beacon_timing_control(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index 6031c25177f9..ba5d027d765f 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -281,8 +281,7 @@ bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
 
 void hal_init_macaddr(struct adapter *adapter)
 {
-	rtw_hal_set_hwreg(adapter, HW_VAR_MAC_ADDR,
-			  adapter->eeprompriv.mac_addr);
+	SetHwReg8188EU(adapter, HW_VAR_MAC_ADDR, adapter->eeprompriv.mac_addr);
 }
 
 /*
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 2e72848079e2..8caf67b594a7 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -41,12 +41,6 @@ uint rtw_hal_deinit(struct adapter *adapt)
 	return status;
 }
 
-void rtw_hal_set_hwreg(struct adapter *adapt, u8 variable, u8 *val)
-{
-	if (adapt->HalFunc.SetHwRegHandler)
-		adapt->HalFunc.SetHwRegHandler(adapt, variable, val);
-}
-
 void rtw_hal_get_hwreg(struct adapter *adapt, u8 variable, u8 *val)
 {
 	if (adapt->HalFunc.GetHwRegHandler)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 6450c2c32f8a..4dc3fae1a0cd 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -593,7 +593,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		haldata->RegFwHwTxQCtrl &= (~BIT(6));
 
 		/*  Clear beacon valid check bit. */
-		rtw_hal_set_hwreg(adapt, HW_VAR_BCN_VALID, NULL);
+		SetHwReg8188EU(adapt, HW_VAR_BCN_VALID, NULL);
 		DLBcnCount = 0;
 		poll = 0;
 		do {
@@ -638,7 +638,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 
 		/*  Update RSVD page location H2C to Fw. */
 		if (bcn_valid) {
-			rtw_hal_set_hwreg(adapt, HW_VAR_BCN_VALID, NULL);
+			SetHwReg8188EU(adapt, HW_VAR_BCN_VALID, NULL);
 			DBG_88E("Set RSVD page location to Fw.\n");
 		}
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index bb92bebc63bc..83744f6896d7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -845,7 +845,7 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 		pbuf[i] = efuseTbl[_offset + i];
 
 	/*  5. Calculate Efuse utilization. */
-	rtw_hal_set_hwreg(Adapter, HW_VAR_EFUSE_BYTES, (u8 *)&eFuse_Addr);
+	SetHwReg8188EU(Adapter, HW_VAR_EFUSE_BYTES, (u8 *)&eFuse_Addr);
 
 exit:
 	kfree(efuseTbl);
@@ -1131,7 +1131,7 @@ static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoT
 	if (bPseudoTest)
 		fakeEfuseUsedBytes = efuse_addr;
 	else
-		rtw_hal_set_hwreg(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
+		SetHwReg8188EU(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
 
 	return efuse_addr;
 }
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 83813388de24..dced9b74b9a4 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1277,7 +1277,7 @@ static void hw_var_set_bcn_func(struct adapter *Adapter, u8 variable, u8 *val)
 		rtw_write8(Adapter, bcn_ctrl_reg, rtw_read8(Adapter, bcn_ctrl_reg) & (~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
 }
 
-static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
+void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 {
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	struct dm_priv	*pdmpriv = &haldata->dmpriv;
@@ -2143,6 +2143,5 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->hal_init = &rtl8188eu_hal_init;
 	halfunc->hal_deinit = &rtl8188eu_hal_deinit;
 
-	halfunc->SetHwRegHandler = &SetHwReg8188EU;
 	halfunc->GetHwRegHandler = &GetHwReg8188EU;
 }
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 29ca90a86844..4447b81a6af8 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -125,8 +125,6 @@ struct hal_ops {
 	u32	(*hal_init)(struct adapter *padapter);
 	u32	(*hal_deinit)(struct adapter *padapter);
 
-	void	(*SetHwRegHandler)(struct adapter *padapter, u8	variable,
-				   u8 *val);
 	void	(*GetHwRegHandler)(struct adapter *padapter, u8	variable,
 				   u8 *val);
 };
@@ -173,10 +171,11 @@ u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable
 
 unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
 
+void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val);
+
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
-void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 
 void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index e8fadbfcb3a9..f5377b92412a 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3930,7 +3930,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				DBG_88E("(B)DMFlag = 0x%x, arg = 0x%x\n", ODMFlag, arg);
 				ODMFlag = (u32)(0x0f & arg);
 				DBG_88E("(A)DMFlag = 0x%x\n", ODMFlag);
-				rtw_hal_set_hwreg(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
+				SetHwReg8188EU(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
 			}
 			break;
 		case 0x07:
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index f34998204e44..1418c9c4916c 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -769,7 +769,7 @@ void rtw_ips_dev_unload(struct adapter *padapter)
 {
 	DBG_88E("====> %s...\n", __func__);
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_FIFO_CLEARN_UP, NULL);
+	SetHwReg8188EU(padapter, HW_VAR_FIFO_CLEARN_UP, NULL);
 
 	if (padapter->intf_stop)
 		padapter->intf_stop(padapter);
-- 
2.33.0

