Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709343A72E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhFOATb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:19:31 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:38404 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhFOATU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:19:20 -0400
Received: by mail-qt1-f175.google.com with SMTP id o19so9960154qtp.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETntBOsYPD8kWgF9cIpwHsDS07x8y52XE6FVL5T2U6s=;
        b=GHh6JWku0T4klrWBbdW3qu/6SnCb500ZAVlXeneSjeYiCkkD6nhKUXKl7W2MonsPgd
         4sD+CQQMmHUFjorb/k7+pW8kR+ZgzVV4641U6WZYT8JS1XJ4xEJhmnM0KnZshQ1SGlBh
         6tySkdBS/nqoAw3S+qAVS3Fe+5JrapJ1BGKJoJO2leVhK3Vb6j1XwMeRWpLrycUoUuvb
         Lx0UYDqDBtS9qYjfa2/bBZH5imQQ/2S20a7zmUSG1XRRmGYH9BKIqZyqN0fXrwDIshxi
         96Yp6bfZGSnxVQ1tp9dgs4WfD1La1lKrIiA7DsdFW2MprgRErV4lg8gejI6p/hMYPBsZ
         ygIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETntBOsYPD8kWgF9cIpwHsDS07x8y52XE6FVL5T2U6s=;
        b=giW+XQbgVTLURoq/Iq7BnvVQIT/DoQ42/LGvp30jPjjTbdeTA3BwYqrWp9SVPAgDDe
         wwu7+O4lZg/mAIS1apQzbt/m9Lpt0ypjEiUdFbrdoLsIVD/+G4GdGGv4WE0lVzrOkovJ
         4Ocq3B0yPV3dJw3ylge8x6S+ZSstQpz4pYbISk8bT6WxU4pk5iXHJUugoO1xDteuV4/w
         jV62/rt5F/Zot3osIrO1B+Ncvx9snRDE8P9WeeMR/OO0gIU6RMPhHB275BNgnj3bqyu4
         i1rwWpeUxf3GuBZiBVgSFPukKOG3a3/qh1l2R28CHiO7IS1ySkpwp4+uMXPomZa40Kz3
         wQ+A==
X-Gm-Message-State: AOAM533S3gLcvdwBGUuHmi5yct6OmfN68Q21+jvwElNGHF0CQeyKeYMG
        RtfmIc+KO99KPSgFlgyFQ1r81Q==
X-Google-Smtp-Source: ABdhPJyfNjE1uJVHZJii7OHbEUMEniOxiS/9yZEmul36Gzx81mfCqmv2A9lwEy1Bk1ndyEXk/9XrFA==
X-Received: by 2002:ac8:12ca:: with SMTP id b10mr18701324qtj.108.1623716163978;
        Mon, 14 Jun 2021 17:16:03 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:16:03 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 13/28] staging: rtl8188eu: remove all DBG_88E calls from os_dep/os_intfs.c
Date:   Tue, 15 Jun 2021 01:14:52 +0100
Message-Id: <20210615001507.1171-14-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from os_dep/os_intfs.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself. Also remove variable declarations for variables which now go
unused as a result of this change with os_dep/os_intfs.c

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 26 ---------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 870148020e61..70e9161a429e 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -310,7 +310,6 @@ struct net_device *rtw_init_netdev(void)
 	pnetdev->dev.type = &wlan_type;
 	padapter = netdev_priv(pnetdev);
 	padapter->pnetdev = pnetdev;
-	DBG_88E("register rtw_netdev_ops to netdev_ops\n");
 	pnetdev->netdev_ops = &rtw_netdev_ops;
 	pnetdev->watchdog_timeo = HZ * 3; /* 3 second timeout */
 	pnetdev->wireless_handlers = (struct iw_handler_def *)&rtw_handlers_def;
@@ -439,19 +438,16 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	}
 
 	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
-		DBG_88E("Can't _rtw_init_xmit_priv\n");
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
-		DBG_88E("Can't _rtw_init_recv_priv\n");
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
-		DBG_88E("Can't _rtw_init_sta_priv\n");
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -530,7 +526,6 @@ static int _netdev_open(struct net_device *pnetdev)
 	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+88eu_drv - dev_open\n"));
-	DBG_88E("+88eu_drv - drv_open, bup =%d\n", padapter->bup);
 
 	if (pwrctrlpriv->ps_flag) {
 		padapter->net_closed = false;
@@ -580,7 +575,6 @@ static int _netdev_open(struct net_device *pnetdev)
 
 netdev_open_normal_process:
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-88eu_drv - dev_open\n"));
-	DBG_88E("-88eu_drv - drv_open, bup =%d\n", padapter->bup);
 	return 0;
 
 netdev_open_error:
@@ -588,7 +582,6 @@ static int _netdev_open(struct net_device *pnetdev)
 	netif_carrier_off(pnetdev);
 	netif_tx_stop_all_queues(pnetdev);
 	RT_TRACE(_module_os_intfs_c_, _drv_err_, ("-88eu_drv - dev_open, fail!\n"));
-	DBG_88E("-88eu_drv - drv_open fail, bup =%d\n", padapter->bup);
 	return -1;
 }
 
@@ -609,7 +602,6 @@ int  ips_netdrv_open(struct adapter *padapter)
 	int status = _SUCCESS;
 
 	padapter->net_closed = false;
-	DBG_88E("===> %s.........\n", __func__);
 
 	padapter->bDriverStopped = false;
 	padapter->bSurpriseRemoved = false;
@@ -629,47 +621,33 @@ int  ips_netdrv_open(struct adapter *padapter)
 	return _SUCCESS;
 
 netdev_open_error:
-	DBG_88E("-%s - drv_open failure, bup =%d\n", __func__, padapter->bup);
-
 	return _FAIL;
 }
 
 int rtw_ips_pwr_up(struct adapter *padapter)
 {
 	int result;
-	unsigned long start_time = jiffies;
 
-	DBG_88E("===>  %s..............\n", __func__);
 	rtw_reset_drv_sw(padapter);
 
 	result = ips_netdrv_open(padapter);
 
 	led_control_8188eu(padapter, LED_CTL_NO_LINK);
 
-	DBG_88E("<===  %s.............. in %dms\n", __func__,
-		jiffies_to_msecs(jiffies - start_time));
 	return result;
 }
 
 void rtw_ips_pwr_down(struct adapter *padapter)
 {
-	unsigned long start_time = jiffies;
-
-	DBG_88E("===> %s...................\n", __func__);
-
 	padapter->net_closed = true;
 
 	led_control_8188eu(padapter, LED_CTL_POWER_OFF);
 
 	rtw_ips_dev_unload(padapter);
-	DBG_88E("<=== %s..................... in %dms\n", __func__,
-		jiffies_to_msecs(jiffies - start_time));
 }
 
 void rtw_ips_dev_unload(struct adapter *padapter)
 {
-	DBG_88E("====> %s...\n", __func__);
-
 	rtw_hal_set_hwreg(padapter, HW_VAR_FIFO_CLEARN_UP, NULL);
 
 	usb_intf_stop(padapter);
@@ -692,9 +670,6 @@ static int netdev_close(struct net_device *pnetdev)
 	padapter->net_closed = true;
 
 	if (padapter->pwrctrlpriv.rf_pwrstate == rf_on) {
-		DBG_88E("(2)88eu_drv - drv_close, bup =%d, hw_init_completed =%d\n",
-			padapter->bup, padapter->hw_init_completed);
-
 		/* s1. */
 		if (pnetdev) {
 			if (!rtw_netif_queue_stopped(pnetdev))
@@ -715,6 +690,5 @@ static int netdev_close(struct net_device *pnetdev)
 	}
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-88eu_drv - drv_close\n"));
-	DBG_88E("-88eu_drv - drv_close, bup =%d\n", padapter->bup);
 	return 0;
 }
-- 
2.30.2

