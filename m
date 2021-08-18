Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996363EFEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbhHRIKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbhHRIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:10:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFEAC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:10:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bq25so3209556ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZAZzwwcx70AYZ5vUsC7kCLYme5CHKv/ByB7IjGm7EM=;
        b=kfvBxzSdYUuRBuxvdzmKvwRYfJV5L0wCVDN99ULoa3zPGDFIHHwTdaTSxgmQhcKZHF
         /Qgwgxpry2sIOohGCSGPXGhLBpnWDk2ZQpkaOrn+E/CS4S3+P3TumqwXruo/ZJApCPEg
         VfJnFX8IdAD5g4RxkPK6o4N6E/UA3zaJPdl6tD/ww6FjsZlUFl5M6WTNoT4B4kt98Vrc
         KUzHyfXUntw7p8sbk4GJBoiq1fKnwV5xKMRDL98NXenwxKcoawwiGErp5kecTNGtAp9w
         axRrfN7h2/1IcbeuNzGvGO8J4/XHqqkDbQrkByU/FRzp9RkD3KX/eMJJ2myMKHwVsCTy
         PPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZAZzwwcx70AYZ5vUsC7kCLYme5CHKv/ByB7IjGm7EM=;
        b=Pby8yHc1JQHZmHUUFEHaAMnQAw6cQ7j/Y9PuB+jw55YXRMmQhItgH5yMUdE/WahoJd
         8siw9iYcqZw5hC6JdWVXfiV6RohcKZmaBHHz09ivShYPDh6QKaLBbFzWl3EPRmhFh371
         eq3wQChkkABYF85PM9cpGyF7n8cohihnqQ9DREYMjyBghK3owfpo7MLRpx1jJ0smC63a
         xvcY3TrWpI4vmnFavK7hw56IqWMVUC5V5HrFqAK9gtrSrxDaMXZrqDPRpNkxX2A80dG/
         53qwTvHEAa+blrrs0Xg5cbW60C+p47CB6QRV9wL07iLz9M5KUan1BunIvADF40gFZBGj
         hlMQ==
X-Gm-Message-State: AOAM531nJHVM+0tWW+wLMdUa9V21WkLBCrNbdtjsFcsHV0BIIRZrdnhh
        PplYza0w36qz0KoDHOOKGH4=
X-Google-Smtp-Source: ABdhPJwxM2VfwoghrKSwDUn2MyquWIm7miRk442S9+IQ+jGIt53N9HujL9DgRqBecLq7qDIc7l6vAA==
X-Received: by 2002:a17:906:f298:: with SMTP id gu24mr8554912ejb.334.1629274215884;
        Wed, 18 Aug 2021 01:10:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id j22sm1667945ejt.11.2021.08.18.01.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 01:10:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: clean up comparsions to false
Date:   Wed, 18 Aug 2021 10:08:54 +0200
Message-Id: <20210818080854.15847-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818080854.15847-1-straube.linux@gmail.com>
References: <20210818080854.15847-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up comparsions to false.

x == false -> !x

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c          |  4 ++--
 drivers/staging/r8188eu/core/rtw_ioctl_set.c    |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c         | 12 ++++++------
 drivers/staging/r8188eu/core/rtw_mp.c           |  4 ++--
 drivers/staging/r8188eu/core/rtw_pwrctrl.c      | 14 +++++++-------
 drivers/staging/r8188eu/core/rtw_recv.c         |  4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c    |  2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c         |  4 ++--
 drivers/staging/r8188eu/hal/odm.c               |  6 +++---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_mp.c       |  2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c       |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    |  8 ++++----
 drivers/staging/r8188eu/os_dep/xmit_linux.c     |  2 +-
 14 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index a65138674bc3..a68776f5e67b 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1870,13 +1870,13 @@ static s32 c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h
 		if (c2h_evt_read(adapter, buf) == _SUCCESS) {
 			c2h_evt = (struct c2h_evt_hdr *)buf;
 
-			if (filter && filter(c2h_evt->id) == false)
+			if (filter && !filter(c2h_evt->id))
 				goto exit;
 
 			ret = rtw_hal_c2h_handler(adapter, c2h_evt);
 		}
 	} else {
-		if (filter && filter(c2h_evt->id) == false)
+		if (filter && !filter(c2h_evt->id))
 			goto exit;
 
 		ret = rtw_hal_c2h_handler(adapter, c2h_evt);
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index a10b855250df..c187de78b4ac 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -156,7 +156,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)
+			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
 		} else {
 			rtw_disassoc_cmd(padapter, 0, true);
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 25e8f131ce18..8384cdc75dfb 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -298,7 +298,7 @@ int rtw_if_up(struct adapter *padapter)
 	int res;
 
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
-	    (check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false))
+	    !check_fwstate(&padapter->mlmepriv, _FW_LINKED))
 		res = false;
 	else
 		res =  true;
@@ -709,7 +709,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 	}
 
 	/*  lock pmlmepriv->lock when you accessing network_q */
-	if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == false) {
+	if (!check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 		if (pnetwork->Ssid.Ssid[0] == 0)
 			pnetwork->Ssid.SsidLength = 0;
 		rtw_add_network(adapter, pnetwork);
@@ -749,7 +749,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	if (pmlmepriv->to_join) {
 		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
+			if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
 				if (rtw_select_and_join_from_scanned_queue(pmlmepriv) == _SUCCESS) {
@@ -1253,7 +1253,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
 	struct wlan_network	*ptarget_wlan = NULL;
 
-	if (rtw_access_ctrl(adapter, pstassoc->macaddr) == false)
+	if (!rtw_access_ctrl(adapter, pstassoc->macaddr))
 		return;
 
 #if defined(CONFIG_88EU_AP_MODE)
@@ -1543,12 +1543,12 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 			goto exit;
 	}
 
-	if (rtw_is_desired_network(adapter, competitor)  == false)
+	if (!rtw_is_desired_network(adapter, competitor))
 		goto exit;
 
 	if (rtw_to_roaming(adapter) > 0) {
 		if (rtw_get_passing_time_ms((u32)competitor->last_scanned) >= RTW_SCAN_RESULT_EXPIRE ||
-		    is_same_ess(&competitor->network, &pmlmepriv->cur_network.network) == false)
+		    !is_same_ess(&competitor->network, &pmlmepriv->cur_network.network))
 			goto exit;
 	}
 
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index bba97afcf404..07d9245fa05f 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -421,7 +421,7 @@ void mp_stop_test(struct adapter *padapter)
 	if (pmppriv->mode == MP_ON) {
 		pmppriv->bSetTxPower = 0;
 		spin_lock_bh(&pmlmepriv->lock);
-		if (check_fwstate(pmlmepriv, WIFI_MP_STATE) == false)
+		if (!check_fwstate(pmlmepriv, WIFI_MP_STATE))
 			goto end_of_mp_stop_test;
 
 		/* 3 1. disconnect psudo AdHoc */
@@ -866,7 +866,7 @@ u32 mp_query_psd(struct adapter *pAdapter, u8 *data)
 	if (!netif_running(pAdapter->pnetdev))
 		return 0;
 
-	if (check_fwstate(&pAdapter->mlmepriv, WIFI_MP_STATE) == false)
+	if (!check_fwstate(&pAdapter->mlmepriv, WIFI_MP_STATE))
 		return 0;
 
 	if (strlen(data) == 0) { /* default value */
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 34e4c3339b56..c3897b29121c 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -256,15 +256,15 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 	if (delta_time < LPS_DELAY_TIME)
 		return false;
 
-	if ((check_fwstate(pmlmepriv, _FW_LINKED) == false) ||
-	    (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) ||
-	    (check_fwstate(pmlmepriv, WIFI_AP_STATE)) ||
-	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) ||
-	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)))
+	if (!check_fwstate(pmlmepriv, _FW_LINKED) ||
+	    check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) ||
+	    check_fwstate(pmlmepriv, WIFI_AP_STATE) ||
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE))
 		return false;
 	if (pwrpriv->bInSuspend)
 		return false;
-	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) && (padapter->securitypriv.binstallGrpkey == false)) {
+	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && !padapter->securitypriv.binstallGrpkey) {
 		DBG_88E("Group handshake still in progress !!!\n");
 		return false;
 	}
@@ -365,7 +365,7 @@ void LPS_Enter(struct adapter *padapter)
 {
 	struct pwrctrl_priv	*pwrpriv = &padapter->pwrctrlpriv;
 
-	if (PS_RDY_CHECK(padapter) == false)
+	if (!PS_RDY_CHECK(padapter))
 		return;
 
 	if (pwrpriv->bLeisurePs) {
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 89de409a8460..0e137aee0aa4 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1873,7 +1873,7 @@ static int recv_func_prehandle(struct adapter *padapter, struct recv_frame *rfra
 		else
 			padapter->mppriv.rx_pktcount++;
 
-		if (check_fwstate(pmlmepriv, WIFI_MP_LPBK_STATE) == false) {
+		if (!check_fwstate(pmlmepriv, WIFI_MP_LPBK_STATE)) {
 			ret = _FAIL;
 			rtw_free_recvframe(rframe, pfree_recv_queue);/* free this recv_frame */
 			goto exit;
@@ -2035,7 +2035,7 @@ void rtw_signal_stat_timer_hdl(struct timer_list *t)
 		}
 
 		/* update value of signal_strength, rssi, signal_qual */
-		if (check_fwstate(&adapter->mlmepriv, _FW_UNDER_SURVEY) == false) {
+		if (!check_fwstate(&adapter->mlmepriv, _FW_UNDER_SURVEY)) {
 			tmp_s = (avg_signal_strength + (_alpha - 1) * recvpriv->signal_strength);
 			if (tmp_s % _alpha)
 				tmp_s = tmp_s / _alpha + 1;
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index b8fe465c4819..0cc53781c442 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -893,7 +893,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	unsigned short	ht_cap_info;
 	unsigned char	ht_info_infos_0;
 
-	if (is_client_associated_to_ap(Adapter) == false)
+	if (!is_client_associated_to_ap(Adapter))
 		return true;
 
 	len = packet_len - sizeof(struct rtw_ieee80211_hdr_3addr);
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4acc376aa413..cdfcf94e4986 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1794,7 +1794,7 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	spin_unlock_bh(&pxmitpriv->lock);
 #endif
 
-	if (rtw_hal_xmit(padapter, pxmitframe) == false)
+	if (!rtw_hal_xmit(padapter, pxmitframe))
 		return 1;
 
 	return 0;
@@ -1811,7 +1811,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int bmcst = IS_MCAST(pattrib->ra);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == false)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 	    return ret;
 
 	if (pattrib->psta)
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index b5d9bafcb613..c1449fab3a95 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -606,7 +606,7 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 		return;
 
 	/* add by Neil Chen to avoid PSD is processing */
-	if (pDM_Odm->bDMInitialGainEnable == false)
+	if (!pDM_Odm->bDMInitialGainEnable)
 		return;
 
 	if (pDM_Odm->SupportICType == ODM_RTL8192D) {
@@ -1342,8 +1342,8 @@ static void FindMinimumRSSI(struct adapter *pAdapter)
 	struct mlme_priv	*pmlmepriv = &pAdapter->mlmepriv;
 
 	/* 1 1.Determine the minimum RSSI */
-	if ((check_fwstate(pmlmepriv, _FW_LINKED) == false) &&
-	    (pdmpriv->EntryMinUndecoratedSmoothedPWDB == 0))
+	if (!check_fwstate(pmlmepriv, _FW_LINKED) &&
+	    pdmpriv->EntryMinUndecoratedSmoothedPWDB == 0)
 		pdmpriv->MinUndecoratedPWDBForDM = 0;
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) /*  Default port */
 		pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index e27d8966498a..78e58f9150f3 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1262,7 +1262,7 @@ static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *
 								bDataEmpty = false;
 						}
 					}
-					if (bDataEmpty == false) {
+					if (!bDataEmpty) {
 						ReadState = PG_STATE_DATA;
 					} else {/* read next header */
 						efuse_addr = efuse_addr + (word_cnts * 2) + 1;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index 7d412b10e6c3..fc13db705511 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -511,7 +511,7 @@ s32 Hal_SetThermalMeter(struct adapter *pAdapter, u8 target_ther)
 	if (!netif_running(pAdapter->pnetdev))
 		return _FAIL;
 
-	if (check_fwstate(&pAdapter->mlmepriv, WIFI_MP_STATE) == false)
+	if (!check_fwstate(&pAdapter->mlmepriv, WIFI_MP_STATE))
 		return _FAIL;
 
 	target_ther &= 0xff;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 2e0af691310a..2cd835cb90f6 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1065,7 +1065,7 @@ static unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 	/* issue Rx irp to receive data */
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		if (_read_port(pintfhdl, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf) == false) {
+		if (!_read_port(pintfhdl, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf)) {
 			status = _FAIL;
 			goto exit;
 		}
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 7480c4710d7e..c0e66c194952 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -820,7 +820,7 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 		ret = -EINVAL;
 		goto exit;
 	}
-	if (rtw_set_802_11_infrastructure_mode(padapter, networkType) == false) {
+	if (!rtw_set_802_11_infrastructure_mode(padapter, networkType)) {
 		ret = -EPERM;
 		goto exit;
 	}
@@ -1088,7 +1088,7 @@ static int rtw_wx_set_wap(struct net_device *dev,
 
 	rtw_set_802_11_authentication_mode(padapter, authmode);
 	/* set_802_11_encryption_mode(padapter, padapter->securitypriv.ndisencryptstatus); */
-	if (rtw_set_802_11_bssid(padapter, temp->sa_data) == false) {
+	if (!rtw_set_802_11_bssid(padapter, temp->sa_data)) {
 		ret = -1;
 		goto exit;
 	}
@@ -1461,7 +1461,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		}
 		spin_unlock_bh(&queue->lock);
 		rtw_set_802_11_authentication_mode(padapter, authmode);
-		if (rtw_set_802_11_ssid(padapter, &ndis_ssid) == false) {
+		if (!rtw_set_802_11_ssid(padapter, &ndis_ssid)) {
 			ret = -1;
 			goto exit;
 		}
@@ -1797,7 +1797,7 @@ static int rtw_wx_set_enc(struct net_device *dev,
 
 	memcpy(wep.KeyMaterial, keybuf, wep.KeyLength);
 
-	if (rtw_set_802_11_add_wep(padapter, &wep) == false) {
+	if (!rtw_set_802_11_add_wep(padapter, &wep)) {
 		if (rf_on == pwrpriv->rf_pwrstate)
 			ret = -EOPNOTSUPP;
 		goto exit;
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 30a5da986967..28466ea6e1dc 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -222,7 +222,7 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev)
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	s32 res = 0;
 
-	if (rtw_if_up(padapter) == false)
+	if (!rtw_if_up(padapter))
 		goto drop_packet;
 
 	rtw_check_xmit_resource(padapter, pkt);
-- 
2.32.0

