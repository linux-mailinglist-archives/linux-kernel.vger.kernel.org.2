Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6CA3E9AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 23:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhHKV64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 17:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhHKV6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 17:58:52 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD08FC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 14:58:27 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bj40so6888798oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afyPncd90M62Cj1CTg8IRor0GSMGilnz6em/dIaZyUc=;
        b=jn0sgsjP7NNZD5nA6L6y8hMp/fVUrtBDNLNAuRwODBRXt0lEuWrxMUB9LhOUmO9evH
         j2SwGZaCN/tCJCzLluxt5vmMffLJkI5GPoBF7YaUWd/Uqtt0ASN0vN90HKMkT7+8o6aA
         Hcg8tWTB2RN/jHUVjnwOsP0XENe1EbDdrIbpKuHVnD3hXhLCsUUbepVnF5rBj7u++jnz
         +sZfcOZaHJyTIvib23gVAsItgPV2u+iYstO7nSonx9pGBQsFpi7RPWw7LznS2FwpNNSv
         p49B/bOy4j0WaeqgZD5qTCs0gEU/PqqQfdWz1gOWJ+XlunsaHY4Cn6AmezASHMlcCo6K
         lo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=afyPncd90M62Cj1CTg8IRor0GSMGilnz6em/dIaZyUc=;
        b=IsYN2GTk71fry9mDdpjwg7W1jozTOs/DwfJF/GC7gW8qOT0j60PcwoBmWqidTKtrq0
         tJyzP/lyg0IDEH/oqfBQgehVvtx1sEmqpbZ7+5bPtcrPi3/bdRCcEF2dZrAkbRq0kbhH
         OX/Op+WBlfg2Gov3sYYKnYQVnC+PBMCcrSIeoa9DtOXutpMc5SLtM3/dtt0f1JZWaZ8g
         zIH1T1e+LzreTHWWaW5JDosCP9FfFZnB6D1LX5m2MJ/ZobMLIKHvtdiuBs4HTkTSErR3
         8P2OfzNpiNhZPvGdFcPELuH37256RORlmylPnlc4Raq6js0kvkNezIOrRbsrsmbZ6EdS
         1/gA==
X-Gm-Message-State: AOAM53183/vt2T+TFrIcXXYnPa7B7MxIgl02KZvhO+8biMAMbiUv1Smk
        rJOog9tSjKoPES6RVBLnNko9+tdX2Us=
X-Google-Smtp-Source: ABdhPJwzPT5sArV3At5gV+/pGU3suDhsKhMWCvUXn6PIT0gtn+6KKz8wr84+V7XLI+a41AZmDExG7A==
X-Received: by 2002:a05:6808:a02:: with SMTP id n2mr798317oij.21.1628719107132;
        Wed, 11 Aug 2021 14:58:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id u126sm105852ooa.23.2021.08.11.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:58:26 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/3] staging: r8188eu: Fix smatch warnings in os_dep/*.c
Date:   Wed, 11 Aug 2021 16:58:06 -0500
Message-Id: <20210811215806.20426-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811215806.20426-1-Larry.Finger@lwfinger.net>
References: <20210811215806.20426-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch shows the following:

drivers/staging/r8188eu/os_dep/ioctl_linux.c:1478 rtw_wx_set_essid() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:1479 rtw_wx_set_essid() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:1481 rtw_wx_set_essid() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:1555 rtw_wx_set_rate() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:2596 rtw_wps_start() warn: variable dereferenced before check 'pdata' (see line 2590)
drivers/staging/r8188eu/os_dep/ioctl_linux.c:2790 rtw_p2p_profilefound() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:4846 rtw_set_encryption() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:5628 rtw_mp_efuse_get() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7251 rtw_mp_set() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7255 rtw_mp_set() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7310 rtw_mp_get() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7345 rtw_mp_get() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7349 rtw_mp_get() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/mlme_linux.c:106 rtw_os_indicate_disconnect() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/os_intfs.c:1118 ips_netdrv_open() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/osdep_service.c:37 rtw_atoi() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/recv_linux.c:65 rtw_os_recvbuf_resource_free() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/usb_intf.c:338 rtw_hw_suspend() warn: variable dereferenced before check 'padapter' (see line 327)
drivers/staging/r8188eu/os_dep/usb_intf.c:381 rtw_hw_suspend() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/usb_intf.c:394 rtw_hw_resume() warn: variable dereferenced before check 'padapter' (see line 391)
drivers/staging/r8188eu/os_dep/usb_intf.c:506 rtw_resume() warn: inconsistent indenting

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  28 +++--
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   3 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |   2 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c   |   8 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 117 +++++++++---------
 6 files changed, 78 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index e15d1634a2ea..032b5fee0c53 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1475,8 +1475,8 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		src_ssid = ndis_ssid.Ssid;
 
 		spin_lock_bh(&queue->lock);
-	       phead = get_list_head(queue);
-	      pmlmepriv->pscanned = phead->next;
+		phead = get_list_head(queue);
+		pmlmepriv->pscanned = phead->next;
 
 		while (phead != pmlmepriv->pscanned) {
 			pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
@@ -1552,7 +1552,7 @@ static int rtw_wx_set_rate(struct net_device *dev,
 	u32	target_rate = wrqu->bitrate.value;
 	u32	fixed = wrqu->bitrate.fixed;
 	u32	ratevalue = 0;
-	 u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
+	u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
 
 	if (target_rate == -1) {
 		ratevalue = 11;
@@ -2587,13 +2587,15 @@ static int rtw_wps_start(struct net_device *dev,
 	struct iw_point *pdata = &wrqu->data;
 	u32   u32wps_start = 0;
 
+	if (!pdata)
+		return -EINVAL;
 	ret = copy_from_user((void *)&u32wps_start, pdata->pointer, 4);
 	if (ret) {
 		ret = -EINVAL;
 		goto exit;
 	}
 
-	if (padapter->bDriverStopped || !pdata) {
+	if (padapter->bDriverStopped) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -2787,8 +2789,8 @@ static int rtw_p2p_profilefound(struct net_device *dev,
 	DBG_88E("[%s] In value = %s, len = %d\n", __func__, extra, wrqu->data.length - 1);
 
 	/*	The upper application should pass the SSID to driver by using this rtw_p2p_profilefound function. */
-		if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
-			if (extra[0] == '0') {
+	if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
+		if (extra[0] == '0') {
 			/*	Remove all the profile information of wifidirect_info structure. */
 			memset(&pwdinfo->profileinfo[0], 0x00, sizeof(struct profile_info) * P2P_MAX_PERSISTENT_GROUP_NUM);
 			pwdinfo->profileindex = 0;
@@ -4843,7 +4845,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
 			/* psecuritypriv->dot11PrivacyKeyIndex = keyid", but can rtw_set_key to cam */
 
-		      memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->KeyMaterial, pwep->KeyLength);
+			memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->KeyMaterial, pwep->KeyLength);
 
 			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->KeyLength;
 
@@ -5625,7 +5627,7 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 	if (strcmp(tmp[0], "status") == 0) {
 		sprintf(extra, "Load File efuse =%s, Load File MAC =%s", (pEEPROM->bloadfile_fail_flag ? "FAIL" : "OK"), (pEEPROM->bloadmac_fail_flag ? "FAIL" : "OK"));
 
-		  goto exit;
+		goto exit;
 	} else if (strcmp(tmp[0], "filemap") == 0) {
 		mapLen = EFUSE_MAP_SIZE;
 
@@ -7248,11 +7250,11 @@ static int rtw_mp_set(struct net_device *dev,
 	case MP_START:
 		DBG_88E("set case mp_start\n");
 		rtw_mp_start(dev, info, wrqu, extra);
-		 break;
+		break;
 	case MP_STOP:
 		DBG_88E("set case mp_stop\n");
 		rtw_mp_stop(dev, info, wrqu, extra);
-		 break;
+		break;
 	case MP_BANDWIDTH:
 		DBG_88E("set case mp_bandwidth\n");
 		rtw_mp_bandwidth(dev, info, wrqu, extra);
@@ -7307,7 +7309,7 @@ static int rtw_mp_get(struct net_device *dev,
 	case READ_REG:
 		DBG_88E("mp_get  READ_REG\n");
 		rtw_mp_read_reg(dev, info, wrqu, extra);
-		 break;
+		break;
 	case READ_RF:
 		DBG_88E("mp_get  READ_RF\n");
 		rtw_mp_read_rf(dev, info, wrqu, extra);
@@ -7342,11 +7344,11 @@ static int rtw_mp_get(struct net_device *dev,
 	case EFUSE_GET:
 		DBG_88E("efuse get EFUSE_GET\n");
 		rtw_mp_efuse_get(dev, info, wdata, extra);
-		 break;
+		break;
 	case MP_DUMP:
 		DBG_88E("set case MP_DUMP\n");
 		rtw_mp_dump(dev, info, wrqu, extra);
-		 break;
+		break;
 	case MP_PSD:
 		DBG_88E("set case MP_PSD\n");
 		rtw_mp_psd(dev, info, wrqu, extra);
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index 259628cbf020..be9166f2b524 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -103,8 +103,7 @@ void rtw_os_indicate_disconnect(struct adapter *adapter)
 
 	netif_carrier_off(adapter->pnetdev); /*  Do it first for tx broadcast pkt after disconnection issue! */
 	rtw_indicate_wx_disassoc_event(adapter);
-	 rtw_reset_securitypriv(adapter);
-
+	rtw_reset_securitypriv(adapter);
 }
 
 void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 38d3283dbac3..7e896f631236 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -1115,7 +1115,7 @@ static int  ips_netdrv_open(struct adapter *padapter)
 	rtw_set_pwr_state_check_timer(&padapter->pwrctrlpriv);
 	_set_timer(&padapter->mlmepriv.dynamic_chk_timer, 5000);
 
-	 return _SUCCESS;
+	return _SUCCESS;
 
 netdev_open_error:
 	DBG_88E("-ips_netdrv_open - drv_open failure, bup =%d\n", padapter->bup);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 910da0f0004a..77b571377e3e 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -34,7 +34,7 @@ u32 rtw_atoi(u8 *s)
 	}
 	if (flag == 1)
 		num = num * -1;
-	 return num;
+	return num;
 }
 
 inline u8 *_rtw_vmalloc(u32 sz)
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index e0fbc5751391..da73fc5c1286 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -15,14 +15,14 @@
 
 /* init os related resource in struct recv_priv */
 int rtw_os_recv_resource_init(struct recv_priv *precvpriv,
-			      struct adapter *padapter)
+		struct adapter *padapter)
 {
 	return _SUCCESS;
 }
 
 /* alloc os related resource in struct recv_frame */
 int rtw_os_recv_resource_alloc(struct adapter *padapter,
-			       struct recv_frame *precvframe)
+		struct recv_frame *precvframe)
 {
 	precvframe->pkt_newalloc = NULL;
 	precvframe->pkt = NULL;
@@ -36,7 +36,7 @@ void rtw_os_recv_resource_free(struct recv_priv *precvpriv)
 
 /* alloc os related resource in struct recv_buf */
 int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
-				  struct recv_buf *precvbuf)
+		struct recv_buf *precvbuf)
 {
 	int res = _SUCCESS;
 
@@ -61,7 +61,7 @@ int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 int rtw_os_recvbuf_resource_free(struct adapter *padapter,
 				 struct recv_buf *precvbuf)
 {
-		usb_free_urb(precvbuf->purb);
+	usb_free_urb(precvbuf->purb);
 	return _SUCCESS;
 }
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 8f1e33d2fff7..c16390b6b023 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -327,6 +327,8 @@ int rtw_hw_suspend(struct adapter *padapter)
 	struct net_device *pnetdev = padapter->pnetdev;
 
 
+	if (!padapter)
+		goto error_exit;
 	if ((!padapter->bup) || (padapter->bDriverStopped) ||
 	    (padapter->bSurpriseRemoved)) {
 		DBG_88E("padapter->bup=%d bDriverStopped=%d bSurpriseRemoved = %d\n",
@@ -335,50 +337,46 @@ int rtw_hw_suspend(struct adapter *padapter)
 		goto error_exit;
 	}
 
-	if (padapter) { /* system suspend */
-		LeaveAllPowerSaveMode(padapter);
+	LeaveAllPowerSaveMode(padapter);
 
-		DBG_88E("==> rtw_hw_suspend\n");
-		_enter_pwrlock(&pwrpriv->lock);
-		pwrpriv->bips_processing = true;
-		/* s1. */
-		if (pnetdev) {
-			netif_carrier_off(pnetdev);
-			rtw_netif_stop_queue(pnetdev);
-		}
+	DBG_88E("==> rtw_hw_suspend\n");
+	_enter_pwrlock(&pwrpriv->lock);
+	pwrpriv->bips_processing = true;
+	/* s1. */
+	if (pnetdev) {
+		netif_carrier_off(pnetdev);
+		rtw_netif_stop_queue(pnetdev);
+	}
 
-		/* s2. */
-		rtw_disassoc_cmd(padapter, 500, false);
+	/* s2. */
+	rtw_disassoc_cmd(padapter, 500, false);
 
-		/* s2-2.  indicate disconnect to os */
-		{
-			struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	/* s2-2.  indicate disconnect to os */
+	{
+		struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				_clr_fwstate_(pmlmepriv, _FW_LINKED);
+		if (check_fwstate(pmlmepriv, _FW_LINKED)) {
+			_clr_fwstate_(pmlmepriv, _FW_LINKED);
 
-				rtw_led_control(padapter, LED_CTL_NO_LINK);
+			rtw_led_control(padapter, LED_CTL_NO_LINK);
 
-				rtw_os_indicate_disconnect(padapter);
+			rtw_os_indicate_disconnect(padapter);
 
-				/* donnot enqueue cmd */
-				rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_DISCONNECT, 0);
-			}
+			/* donnot enqueue cmd */
+			rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_DISCONNECT, 0);
 		}
-		/* s2-3. */
-		rtw_free_assoc_resources(padapter, 1);
+	}
+	/* s2-3. */
+	rtw_free_assoc_resources(padapter, 1);
 
-		/* s2-4. */
-		rtw_free_network_queue(padapter, true);
-		rtw_ips_dev_unload(padapter);
-		pwrpriv->rf_pwrstate = rf_off;
-		pwrpriv->bips_processing = false;
+	/* s2-4. */
+	rtw_free_network_queue(padapter, true);
+	rtw_ips_dev_unload(padapter);
+	pwrpriv->rf_pwrstate = rf_off;
+	pwrpriv->bips_processing = false;
 
-		_exit_pwrlock(&pwrpriv->lock);
-	} else {
-		goto error_exit;
-	}
-		return 0;
+	_exit_pwrlock(&pwrpriv->lock);
+	return 0;
 
 error_exit:
 	DBG_88E("%s, failed\n", __func__);
@@ -387,40 +385,37 @@ int rtw_hw_suspend(struct adapter *padapter)
 
 int rtw_hw_resume(struct adapter *padapter)
 {
-	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
+	struct pwrctrl_priv *pwrpriv;
 	struct net_device *pnetdev = padapter->pnetdev;
 
+	if (!padapter)
+		goto error_exit;
+	pwrpriv = &padapter->pwrctrlpriv;
+	DBG_88E("==> rtw_hw_resume\n");
+	_enter_pwrlock(&pwrpriv->lock);
+	pwrpriv->bips_processing = true;
+	rtw_reset_drv_sw(padapter);
 
-	if (padapter) { /* system resume */
-		DBG_88E("==> rtw_hw_resume\n");
-		_enter_pwrlock(&pwrpriv->lock);
-		pwrpriv->bips_processing = true;
-		rtw_reset_drv_sw(padapter);
-
-		if (pm_netdev_open(pnetdev, false) != 0) {
-			_exit_pwrlock(&pwrpriv->lock);
-			goto error_exit;
-		}
-
-		netif_device_attach(pnetdev);
-		netif_carrier_on(pnetdev);
+	if (pm_netdev_open(pnetdev, false) != 0) {
+		_exit_pwrlock(&pwrpriv->lock);
+		goto error_exit;
+	}
 
-		if (!netif_queue_stopped(pnetdev))
-			netif_start_queue(pnetdev);
-		else
-			netif_wake_queue(pnetdev);
+	netif_device_attach(pnetdev);
+	netif_carrier_on(pnetdev);
 
-		pwrpriv->bkeepfwalive = false;
-		pwrpriv->brfoffbyhw = false;
+	if (!netif_queue_stopped(pnetdev))
+		netif_start_queue(pnetdev);
+	else
+		netif_wake_queue(pnetdev);
 
-		pwrpriv->rf_pwrstate = rf_on;
-		pwrpriv->bips_processing = false;
+	pwrpriv->bkeepfwalive = false;
+	pwrpriv->brfoffbyhw = false;
 
-		_exit_pwrlock(&pwrpriv->lock);
-	} else {
-		goto error_exit;
-	}
+	pwrpriv->rf_pwrstate = rf_on;
+	pwrpriv->bips_processing = false;
 
+	_exit_pwrlock(&pwrpriv->lock);
 
 	return 0;
 error_exit:
@@ -503,7 +498,7 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
 	struct adapter *padapter = dvobj->if1;
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	 int ret = 0;
+	int ret = 0;
 
 	if (pwrpriv->bInternalAutoSuspend)
 		ret = rtw_resume_process(padapter);
-- 
2.32.0

