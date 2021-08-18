Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31713EFEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhHRIKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbhHRIKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:10:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9866BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:10:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i22so1766156edq.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUWz51AT/2to6UAAVqgFxaRV7ru4tu3zZoWuwrojBPQ=;
        b=t33pDQV5knDv0BENzYyA3XReYUUfXVbkHspfQ+v+44WbOaL9yVWno4VvkZoedrFaQA
         402K9XqlKqPb3IBeIqxtS2WmPwQThx0G15OzLqDPESbtgDdeq5R9clcaoWPGQ6MVwIk5
         dAm639dvqswjzKt5IauyhY2nZ2I4fgKCFka5vopSbh47/pLnSeD8ZnbBMxQq3fSFfRMh
         SLmy9atFoIJ3VD9n2j/jQ9jMQfsmkogfBcMT87vH7OP/QiCONHyKouVMC4PIiqseGODi
         F6mllXVAwSuUO5sHrhi8kCQDUuHZSoShapjP0ED9eUbQOo2uAexpirwYhTCyBKIO2w1a
         zX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUWz51AT/2to6UAAVqgFxaRV7ru4tu3zZoWuwrojBPQ=;
        b=iInFQPQf6EcFE2lYpM6HCjsFJahn5h+cXt2Q58HGpjDtTx1dKL2KujzL0P7ZurX8PG
         QuZR1xQwnjKYYw3AmEdkG3gYtarf2TF8jlzh6rw57iOgedQjgh+HVFxPR9xxhIZiAW6v
         e+OhgzwD5mwxCVLGe5uknc3EIsGcQ6iKksCGE+Dnk4e89+a3qwZZOVCLx3Fraj0Ue9Ss
         uAechY5uqzI9y/h48QGOSG5V2B3ZhSDpNxeQkO3RUeZnDon2munHyqluQjsYxKQjMc2x
         dg/zImDC8B1xh4kWvdf5NRP1Pnli0JuD7oOkq/BjVnlDwFB94AvDhX4Fh0PgSxD5nGbv
         6m/Q==
X-Gm-Message-State: AOAM530JkJvHsBLMw2kHk8J7pJyp405qmjMXQ6cwwyAz52fV7Cilfb/s
        nUfx+ZBsFMet9tb4ONsfCd8=
X-Google-Smtp-Source: ABdhPJxrx+iSwk5J18ijUxPwTcXOpooVKF5jaC/cqTFkoQAqZKviL4i/7n24vDxoinlTB9vBVa4MBA==
X-Received: by 2002:a05:6402:22c7:: with SMTP id dm7mr8825126edb.105.1629274215112;
        Wed, 18 Aug 2021 01:10:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id j22sm1667945ejt.11.2021.08.18.01.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 01:10:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: clean up comparsions to true
Date:   Wed, 18 Aug 2021 10:08:53 +0200
Message-Id: <20210818080854.15847-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up comparsions to true.

x == true -> x

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c       | 16 ++++++-------
 drivers/staging/r8188eu/core/rtw_ieee80211.c |  4 ++--
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 22 +++++++++---------
 drivers/staging/r8188eu/core/rtw_mlme.c      | 24 ++++++++++----------
 drivers/staging/r8188eu/core/rtw_mp.c        |  4 ++--
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c  |  4 ++--
 drivers/staging/r8188eu/core/rtw_recv.c      | 22 +++++++++---------
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 10 ++++----
 drivers/staging/r8188eu/core/rtw_xmit.c      |  4 ++--
 drivers/staging/r8188eu/hal/hal_intf.c       |  2 +-
 drivers/staging/r8188eu/hal/odm.c            |  2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c |  2 +-
 drivers/staging/r8188eu/include/rtw_mlme.h   |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 16 ++++++-------
 14 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 7c640c8148f6..a65138674bc3 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -401,11 +401,11 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	struct cmd_priv		*pcmdpriv = &padapter->cmdpriv;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SCAN, 1);
 	}
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 		p2p_ps_wk_cmd(padapter, P2P_PS_SCAN, 1);
 	}
 
@@ -1495,7 +1495,7 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
 	pmlmepriv = &padapter->mlmepriv;
 
 #ifdef CONFIG_88EU_AP_MODE
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		expire_timeout_chk(padapter);
 #endif
 
@@ -1513,13 +1513,13 @@ static void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8	mstatus;
 
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
-	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true))
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE))
 		return;
 
 	switch (lps_ctrl_type) {
 	case LPS_CTRL_SCAN:
-		if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
+		if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 			/* connect */
 			LPS_Leave(padapter);
 		}
@@ -1920,7 +1920,7 @@ static void c2h_wk_callback(struct work_struct *work)
 			continue;
 		}
 
-		if (ccx_id_filter(c2h_evt->id) == true) {
+		if (ccx_id_filter(c2h_evt->id)) {
 			/* Handle CCX report here */
 			rtw_hal_c2h_handler(adapter, c2h_evt);
 			kfree(c2h_evt);
@@ -2124,7 +2124,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	if ((check_fwstate(pmlmepriv, WIFI_MP_STATE) == true) && (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true))
+	if (check_fwstate(pmlmepriv, WIFI_MP_STATE) && check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
 	set_fwstate(pmlmepriv, _FW_LINKED);
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index add97664510c..b3a74198596a 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -100,9 +100,9 @@ int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
 	if (channel > 14) {
 		return WIRELESS_INVALID;
 	} else {  /*  could be pure B, pure G, or B/G */
-		if ((rtw_is_cckratesonly_included(rate)) == true)
+		if (rtw_is_cckratesonly_included(rate))
 			return WIRELESS_11B;
-		else if ((rtw_is_cckrates_included(rate)) == true)
+		else if (rtw_is_cckrates_included(rate))
 			return	WIRELESS_11BG;
 		else
 			return WIRELESS_11G;
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index edfea5ad8259..a10b855250df 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -84,7 +84,7 @@ u8 rtw_do_join(struct adapter *padapter)
 			pmlmepriv->to_join = false;
 			_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 		} else {
-			if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
+			if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 				/*  submit createbss_cmd to change to a ADHOC_MASTER */
 
 				/* pmlmepriv->lock has been acquired by caller... */
@@ -149,7 +149,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	DBG_88E("Set BSSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true)
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		goto handle_tkip_countermeasure;
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 		goto release_mlme_lock;
@@ -161,7 +161,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 		} else {
 			rtw_disassoc_cmd(padapter, 0, true);
 
-			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
+			if (check_fwstate(pmlmepriv, _FW_LINKED))
 				rtw_indicate_disconnect(padapter);
 
 			rtw_free_assoc_resources(padapter, 1);
@@ -222,9 +222,9 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	DBG_88E("Set SSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true) {
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		goto handle_tkip_countermeasure;
-	} else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true) {
+	} else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 		goto release_mlme_lock;
 	}
 
@@ -236,12 +236,12 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 					/* if in WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE, create bss or rejoin again */
 					rtw_disassoc_cmd(padapter, 0, true);
 
-					if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
+					if (check_fwstate(pmlmepriv, _FW_LINKED))
 						rtw_indicate_disconnect(padapter);
 
 					rtw_free_assoc_resources(padapter, 1);
 
-					if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) {
+					if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 						_clr_fwstate_(pmlmepriv, WIFI_ADHOC_MASTER_STATE);
 						set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
 					}
@@ -254,12 +254,12 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 		} else {
 			rtw_disassoc_cmd(padapter, 0, true);
 
-			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
+			if (check_fwstate(pmlmepriv, _FW_LINKED))
 				rtw_indicate_disconnect(padapter);
 
 			rtw_free_assoc_resources(padapter, 1);
 
-			if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) {
+			if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 				_clr_fwstate_(pmlmepriv, WIFI_ADHOC_MASTER_STATE);
 				set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
 			}
@@ -283,7 +283,7 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	memcpy(&pmlmepriv->assoc_ssid, ssid, sizeof(struct ndis_802_11_ssid));
 	pmlmepriv->assoc_by_bssid = false;
 
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true) {
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		pmlmepriv->to_join = true;
 	} else {
 		status = rtw_do_join(padapter);
@@ -326,7 +326,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 			rtw_free_assoc_resources(padapter, 1);
 
 		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
-			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
+			if (check_fwstate(pmlmepriv, _FW_LINKED))
 				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have chked whether  issue dis-assoc_cmd or not */
 	       }
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index c0685965b436..25e8f131ce18 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -509,8 +509,8 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 {
 	struct	mlme_priv	*pmlmepriv = &adapter->mlmepriv;
 
-	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) &&
-	    (is_same_network(&pmlmepriv->cur_network.network, pnetwork))) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED) &&
+	    is_same_network(&pmlmepriv->cur_network.network, pnetwork)) {
 		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
 		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.IEs) + sizeof(struct ndis_802_11_fixed_ie),
 				      pmlmepriv->cur_network.network.IELength);
@@ -670,7 +670,7 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 		bselected = false;
 	}
 
-	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
 			bselected = false;
 	}
@@ -692,7 +692,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	/*  update IBSS_network 's timestamp */
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
@@ -806,7 +806,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	spin_unlock_bh(&pmlmepriv->lock);
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
+	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		p2p_ps_wk_cmd(adapter, P2P_PS_SCAN_DONE, 0);
 
 	rtw_os_xmit_schedule(adapter);
@@ -1128,14 +1128,14 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 					}
 
 					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.MacAddress);
-					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 						if (ptarget_wlan)
 							ptarget_wlan->fixed = true;
 					}
 				}
 			} else {
 				ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.MacAddress);
-				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 					if (ptarget_wlan)
 						ptarget_wlan->fixed = true;
 				}
@@ -1150,7 +1150,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			}
 
 			/* s3. find ptarget_sta & update ptarget_sta after update cur_network only for station mode */
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (!ptarget_sta) {
 					spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
@@ -1159,7 +1159,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			}
 
 			/* s4. indicate connect */
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				pmlmepriv->cur_network_scanned = ptarget_wlan;
 				rtw_indicate_connect(adapter);
 			}
@@ -1177,7 +1177,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		rtw_reset_securitypriv(adapter);
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 
-		if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == true)
+		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 	} else { /* if join_res < 0 (join fails), then try again */
 		_set_timer(&pmlmepriv->assoc_timer, 1);
@@ -1500,7 +1500,7 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
 	rcu_read_lock();
 
 	if (rcu_dereference(adapter->pnetdev->rx_handler_data) &&
-	    (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_ADHOC_STATE) == true)) {
+	    check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_ADHOC_STATE)) {
 		/*  expire NAT2.5 entry */
 		nat25_db_expire(adapter);
 
@@ -1611,7 +1611,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	}
 
 	/*  check for situation of  _FW_LINKED */
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 		DBG_88E("%s: _FW_LINKED while ask_for_joinbss!!!\n", __func__);
 
 		rtw_disassoc_cmd(adapter, 0, true);
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 8c044d3bb61a..bba97afcf404 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -361,11 +361,11 @@ s32 mp_start_test(struct adapter *padapter)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	if (check_fwstate(pmlmepriv, WIFI_MP_STATE) == true)
+	if (check_fwstate(pmlmepriv, WIFI_MP_STATE))
 		goto end_of_mp_start_test;
 
 	/* init mp_start_test status */
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 		rtw_disassoc_cmd(padapter, 500, true);
 		rtw_indicate_disconnect(padapter);
 		rtw_free_assoc_resources(padapter, 1);
diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index 36091eac0e0f..c85f8e467337 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -974,14 +974,14 @@ int rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl(struct oid_par_priv *poid_par_priv)
 
 	if (poid_par_priv->type_of_oid == QUERY_OID) {
 		Efuse_PowerSwitch(Adapter, false, true);
-		if (Efuse_PgPacketRead(Adapter, ppgpkt->offset, ppgpkt->data, false) == true)
+		if (Efuse_PgPacketRead(Adapter, ppgpkt->offset, ppgpkt->data, false))
 			*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 		else
 			status = NDIS_STATUS_FAILURE;
 		Efuse_PowerSwitch(Adapter, false, false);
 	} else {
 		Efuse_PowerSwitch(Adapter, true, true);
-		if (Efuse_PgPacketWrite(Adapter, ppgpkt->offset, ppgpkt->word_en, ppgpkt->data, false) == true)
+		if (Efuse_PgPacketWrite(Adapter, ppgpkt->offset, ppgpkt->word_en, ppgpkt->data, false))
 			*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 		else
 			status = NDIS_STATUS_FAILURE;
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index c28e0204d18b..89de409a8460 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -361,7 +361,7 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 			if (bmic_err) {
 				/*  double check key_index for some timing issue , */
 				/*  cannot compare with psecuritypriv->dot118021XGrpKeyid also cause timing issue */
-				if ((IS_MCAST(prxattrib->ra) == true)  && (prxattrib->key_index != pmlmeinfo->key_index))
+				if (IS_MCAST(prxattrib->ra) && prxattrib->key_index != pmlmeinfo->key_index)
 					brpt_micerror = false;
 
 				if ((prxattrib->bdecrypted) && (brpt_micerror)) {
@@ -652,8 +652,8 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 	u8 *sta_addr = NULL;
 	int bmcast = IS_MCAST(pattrib->dst);
 
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) ||
-	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
 			ret = _FAIL;
@@ -715,7 +715,7 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 
 	if (!*psta) {
 		if (adapter->registrypriv.mp_mode == 1) {
-			if (check_fwstate(pmlmepriv, WIFI_MP_STATE) == true)
+			if (check_fwstate(pmlmepriv, WIFI_MP_STATE))
 				adapter->mppriv.rx_pktloss++;
 		}
 		ret = _FAIL;
@@ -741,9 +741,9 @@ static int ap2sta_data_frame(
 	u8 *myhwaddr = myid(&adapter->eeprompriv);
 	int bmcast = IS_MCAST(pattrib->dst);
 
-	if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) &&
-	    (check_fwstate(pmlmepriv, _FW_LINKED) == true ||
-	    check_fwstate(pmlmepriv, _FW_UNDER_LINKING))) {
+	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
+	    (check_fwstate(pmlmepriv, _FW_LINKED) ||
+	     check_fwstate(pmlmepriv, _FW_UNDER_LINKING))) {
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
 			ret = _FAIL;
@@ -788,8 +788,8 @@ static int ap2sta_data_frame(
 			ret = RTW_RX_HANDLED;
 			goto exit;
 		}
-	} else if ((check_fwstate(pmlmepriv, WIFI_MP_STATE) == true) &&
-		   (check_fwstate(pmlmepriv, _FW_LINKED) == true)) {
+	} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE) &&
+		   check_fwstate(pmlmepriv, _FW_LINKED)) {
 		memcpy(pattrib->dst, GetAddr1Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->src, GetAddr2Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->bssid, GetAddr3Ptr(ptr), ETH_ALEN);
@@ -837,7 +837,7 @@ static int sta2ap_data_frame(struct adapter *adapter,
 	unsigned char *mybssid  = get_bssid(pmlmepriv);
 	int ret = _SUCCESS;
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		/* For AP mode, RA = BSSID, TX = STA(SRC_ADDR), A3 = DST_ADDR */
 		if (memcmp(pattrib->bssid, mybssid, ETH_ALEN)) {
 			ret = _FAIL;
@@ -1817,7 +1817,7 @@ void rtw_reordering_ctrl_timeout_handler(void *pcontext)
 
 	spin_lock_bh(&ppending_recvframe_queue->lock);
 
-	if (recv_indicatepkts_in_order(padapter, preorder_ctrl, true) == true)
+	if (recv_indicatepkts_in_order(padapter, preorder_ctrl, true))
 		_set_timer(&preorder_ctrl->reordering_ctrl_timer, REORDER_WAIT_TIME);
 
 	spin_unlock_bh(&ppending_recvframe_queue->lock);
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 96f03e84b7e5..b8fe465c4819 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -112,9 +112,9 @@ u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int ratelen
 		if (pmlmeinfo->HT_enable)
 			network_type = WIRELESS_11_24N;
 
-		if ((cckratesonly_included(rate, ratelen)) == true)
+		if (cckratesonly_included(rate, ratelen))
 			network_type |= WIRELESS_11B;
-		else if ((cckrates_included(rate, ratelen)) == true)
+		else if (cckrates_included(rate, ratelen))
 			network_type |= WIRELESS_11BG;
 		else
 			network_type |= WIRELESS_11G;
@@ -202,7 +202,7 @@ static unsigned int ratetbl2rateset(struct adapter *padapter, unsigned char *rat
 		default:
 			rate = ratetbl_val_2wifirate(rate);
 
-			if (is_basicrate(padapter, rate) == true)
+			if (is_basicrate(padapter, rate))
 				rate |= IEEE80211_BASIC_RATE_MASK;
 
 			rateset[len] = rate;
@@ -1513,9 +1513,9 @@ void update_wireless_mode(struct adapter *padapter)
 		if (pmlmeinfo->HT_enable)
 			network_type = WIRELESS_11_24N;
 
-		if ((cckratesonly_included(rate, ratelen)) == true)
+		if (cckratesonly_included(rate, ratelen))
 			network_type |= WIRELESS_11B;
-		else if ((cckrates_included(rate, ratelen)) == true)
+		else if (cckrates_included(rate, ratelen))
 			network_type |= WIRELESS_11BG;
 		else
 			network_type |= WIRELESS_11G;
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 41723525074d..4acc376aa413 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -490,7 +490,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		if (!psta) { /*  if we cannot get psta => drrp the pkt */
 			res = _FAIL;
 			goto exit;
-		} else if ((check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) && (!(psta->state & _FW_LINKED))) {
+		} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE) && !(psta->state & _FW_LINKED)) {
 			res = _FAIL;
 			goto exit;
 		}
@@ -2154,7 +2154,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 
 		pxmitframe->attrib.triggered = 1;
 
-		if (rtw_hal_xmit(padapter, pxmitframe) == true)
+		if (rtw_hal_xmit(padapter, pxmitframe))
 			rtw_os_xmit_complete(padapter, pxmitframe);
 
 		if ((psta->sleepq_ac_len == 0) && (!psta->has_legacy_ac) && (wmmps_ac)) {
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 3937b65db5cc..47af081bafcd 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -250,7 +250,7 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
 	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 #ifdef CONFIG_88EU_AP_MODE
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &adapt->stapriv;
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index babe37e4be8b..b5d9bafcb613 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1345,7 +1345,7 @@ static void FindMinimumRSSI(struct adapter *pAdapter)
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == false) &&
 	    (pdmpriv->EntryMinUndecoratedSmoothedPWDB == 0))
 		pdmpriv->MinUndecoratedPWDBForDM = 0;
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true)	/*  Default port */
+	if (check_fwstate(pmlmepriv, _FW_LINKED)) /*  Default port */
 		pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
 	else /*  associated entry pwdb */
 		pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 8c9a651d4f44..50c4b9382761 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -626,7 +626,7 @@ static s32 pre_xmitframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 	if (rtw_txframes_sta_ac_pending(adapt, pattrib) > 0)
 		goto enqueue;
 
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true)
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING))
 		goto enqueue;
 
 	pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 11a2e176ccf7..bbb41471472d 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -516,7 +516,7 @@ static inline void _clr_fwstate_(struct mlme_priv *pmlmepriv, int state)
 static inline void clr_fwstate(struct mlme_priv *pmlmepriv, int state)
 {
 	spin_lock_bh(&pmlmepriv->lock);
-	if (check_fwstate(pmlmepriv, state) == true)
+	if (check_fwstate(pmlmepriv, state))
 		pmlmepriv->fw_state ^= state;
 	spin_unlock_bh(&pmlmepriv->lock);
 }
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 8478c0f5f285..7480c4710d7e 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -374,7 +374,7 @@ static char *translate_scan(struct adapter *padapter,
 	iwe.cmd = IWEVQUAL;
 	iwe.u.qual.updated = IW_QUAL_QUAL_UPDATED | IW_QUAL_LEVEL_UPDATED | IW_QUAL_NOISE_INVALID;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true &&
+	if (check_fwstate(pmlmepriv, _FW_LINKED) &&
 	    is_same_network(&pmlmepriv->cur_network.network, &pnetwork->network)) {
 		ss = padapter->recvpriv.signal_strength;
 		sq = padapter->recvpriv.signal_qual;
@@ -718,7 +718,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX *prates = NULL;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE) == true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		/* parsing HT_CAP_IE */
 		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength - 12);
 		if (p && ht_ielen > 0)
@@ -726,12 +726,12 @@ static int rtw_wx_get_name(struct net_device *dev,
 
 		prates = &pcur_bss->SupportedRates;
 
-		if (rtw_is_cckratesonly_included((u8 *)prates) == true) {
+		if (rtw_is_cckratesonly_included((u8 *)prates)) {
 			if (ht_cap)
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bn");
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11b");
-		} else if ((rtw_is_cckrates_included((u8 *)prates)) == true) {
+		} else if (rtw_is_cckrates_included((u8 *)prates)) {
 			if (ht_cap)
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bgn");
 			else
@@ -1112,9 +1112,9 @@ static int rtw_wx_get_wap(struct net_device *dev,
 
 	memset(wrqu->ap_addr.sa_data, 0, ETH_ALEN);
 
-	if (((check_fwstate(pmlmepriv, _FW_LINKED)) == true) ||
-	    ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) ||
-	    ((check_fwstate(pmlmepriv, WIFI_AP_STATE)) == true))
+	if (check_fwstate(pmlmepriv, _FW_LINKED) ||
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
+	    check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		memcpy(wrqu->ap_addr.sa_data, pcur_bss->MacAddress, ETH_ALEN);
 	else
 		memset(wrqu->ap_addr.sa_data, 0, ETH_ALEN);
@@ -1445,7 +1445,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength)) &&
 			    (pnetwork->network.Ssid.SsidLength == ndis_ssid.SsidLength)) {
 
-				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
+				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 					if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
 						continue;
 				}
-- 
2.32.0

