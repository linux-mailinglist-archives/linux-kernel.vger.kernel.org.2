Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7D73E9C12
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhHLBxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbhHLBxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:53:22 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302EC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:52:58 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so3066224otn.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjxSQtrwpyJejUKfPD8s8btBOseLhgLnD8k0kvqF8YI=;
        b=CxwKf/MErx/zL4SXGFilSNDFimHoeZ/2NTfzRFrQ13RWfqUw7HAxCJqsLIRdemIx5M
         r7FZ5NAkFSihrLT41VA+mYiq0Y59fq7DTWqf9DamUBKTwJoz0xD1bCfYK43Kq6StthOA
         xyOuQ/x52BDVgKo+KIbrig0CM8ANGOAGTmyqh8OO/s7wzJFKaITYln+zRS78uaNGeFxO
         7cP0k6fh5fQiHTwpxUJGHhlAsk9ZYp7ZPqNk4B6CZ+Zjr/LVrPamWuP/pNWPA2TaSgiN
         OU8RF9VeGEhheKL5TgkudYV0POaT+9sellOz1f1mUMb/rlsqKkFkRLix74v95jPks7qt
         Er/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RjxSQtrwpyJejUKfPD8s8btBOseLhgLnD8k0kvqF8YI=;
        b=D3tN18TLY7Jn5YUAn76V3v7O3Wie3cJZjywa7DnXYcjARgtXIWjcalxmoO0hj+zW7e
         Xck+R0yPHzgzh2rzXJaDXW37y0sBnejC7MK6UJW32s5pKKmoek17dKNBig+4pQNhRosR
         bq27SG2KkZjADzTUD9rQPv/8Ma5EQdMKfNccfFEL2KvkrLebu0elyYV5vnQEDFaqlVwP
         1V05tKw/FoEIjri0e/OJP4RwLtmFr7qtg0TEQIAik2BByFap0ho2A11yyX1fkw+VqFxB
         fxwYOjKB9jnHW0TdvN03lNjlqLokty7j4UkEdU5bxwl100Betu2OrqNCA8dF60kZzR/f
         +NKg==
X-Gm-Message-State: AOAM531pPYV6hTHrCQy/F33DmcKEkbp3apUQco8pPvASWD4T8SzSk0j5
        G3JEgGJXWJDVcF/FLnm5kjqoskx6cZM=
X-Google-Smtp-Source: ABdhPJyHjAS9A4AIeppuHuMXBjRw72DgHAR4fWpq1pe4jY1X26AJhklx5jF3TMwHzjmdjxymMXscog==
X-Received: by 2002:a9d:4f11:: with SMTP id d17mr1538519otl.32.1628733177560;
        Wed, 11 Aug 2021 18:52:57 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id q21sm305718otn.61.2021.08.11.18.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 18:52:57 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 3/3] staging: r8188eu: Fix smatch warnings in os_dep/*.c
Date:   Wed, 11 Aug 2021 20:52:32 -0500
Message-Id: <20210812015232.23784-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812015232.23784-1-Larry.Finger@lwfinger.net>
References: <20210812015232.23784-1-Larry.Finger@lwfinger.net>
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
v2 - patch respun due to conflicts
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  26 ++--
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   3 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |   2 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c   |   8 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 117 +++++++++---------
 6 files changed, 77 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 84486ba6193d..d059b738b348 100644
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
@@ -4657,7 +4659,7 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 	if (strcmp(tmp[0], "status") == 0) {
 		sprintf(extra, "Load File efuse =%s, Load File MAC =%s", (pEEPROM->bloadfile_fail_flag ? "FAIL" : "OK"), (pEEPROM->bloadmac_fail_flag ? "FAIL" : "OK"));
 
-		  goto exit;
+		goto exit;
 	} else if (strcmp(tmp[0], "filemap") == 0) {
 		mapLen = EFUSE_MAP_SIZE;
 
@@ -6280,11 +6282,11 @@ static int rtw_mp_set(struct net_device *dev,
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
@@ -6339,7 +6341,7 @@ static int rtw_mp_get(struct net_device *dev,
 	case READ_REG:
 		DBG_88E("mp_get  READ_REG\n");
 		rtw_mp_read_reg(dev, info, wrqu, extra);
-		 break;
+		break;
 	case READ_RF:
 		DBG_88E("mp_get  READ_RF\n");
 		rtw_mp_read_rf(dev, info, wrqu, extra);
@@ -6374,11 +6376,11 @@ static int rtw_mp_get(struct net_device *dev,
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
index 1eb53cf8bccb..cc7e54170948 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -1114,7 +1114,7 @@ static int  ips_netdrv_open(struct adapter *padapter)
 	rtw_set_pwr_state_check_timer(&padapter->pwrctrlpriv);
 	_set_timer(&padapter->mlmepriv.dynamic_chk_timer, 5000);
 
-	 return _SUCCESS;
+	return _SUCCESS;
 
 netdev_open_error:
 	DBG_88E("-ips_netdrv_open - drv_open failure, bup =%d\n", padapter->bup);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 9ea4e1a7c45f..c8a15959cff3 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -33,7 +33,7 @@ u32 rtw_atoi(u8 *s)
 	}
 	if (flag == 1)
 		num = num * -1;
-	 return num;
+	return num;
 }
 
 inline u8 *_rtw_vmalloc(u32 sz)
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 74d76b2baebb..1fb01f135741 100644
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
index 6e4bf623f788..a462cb6f3005 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -326,6 +326,8 @@ int rtw_hw_suspend(struct adapter *padapter)
 	struct net_device *pnetdev = padapter->pnetdev;
 
 
+	if (!padapter)
+		goto error_exit;
 	if ((!padapter->bup) || (padapter->bDriverStopped) ||
 	    (padapter->bSurpriseRemoved)) {
 		DBG_88E("padapter->bup=%d bDriverStopped=%d bSurpriseRemoved = %d\n",
@@ -334,50 +336,46 @@ int rtw_hw_suspend(struct adapter *padapter)
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
@@ -386,40 +384,37 @@ int rtw_hw_suspend(struct adapter *padapter)
 
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
@@ -502,7 +497,7 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
 	struct adapter *padapter = dvobj->if1;
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	 int ret = 0;
+	int ret = 0;
 
 	if (pwrpriv->bInternalAutoSuspend)
 		ret = rtw_resume_process(padapter);
-- 
2.32.0

