Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6893DEF5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbhHCNxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbhHCNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:52:53 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED96C061798
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:52:41 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q6so28184771oiw.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cC2q33lrH6N0jhLuoE0F8z8ghqf+pJeZHl10xxCK8gk=;
        b=MLvoejCHia3iDTcg5jgKmHoUBItqKC0Pnnf4XK47CKD8AYr2ZsuR0ajHr3jBU6MuZ3
         bZhZZ8OcdlaS7l2MoesMsJQZ2epN4BERBy26aVL5q8gBDCCxyLuPH2xK+lz11g3ViOEE
         fwlbuYpimV6gGoZgl2OsEamn4xSJ8TnW09pr1rg/vU/1ZNePd3HdtmJocJBrnixZzgmd
         fiKYurkS6yf38vJYXFaIjt+S08cFl5CdYNcHLnFh/Q4mEnx8zeQbx9+a3JCRBpsaRhj7
         tMpvBWFLCT4dS+5YCUU/fcHl7XhVdbYqyABVnJaA7mLPSNGeCB/3U2esAVcvBz1Nb1+O
         HGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cC2q33lrH6N0jhLuoE0F8z8ghqf+pJeZHl10xxCK8gk=;
        b=uBlXRi/B2uOPt/Am1B7V/wmRbqB4YHEbvH0FES3I6GQ3Ncp3Rig5+GLiB5c/9a336H
         /ejRL92oJSJU5PA/ydWUG61b6zjvzxSKzNsembpNaGBUW1a2b7kn7SE3T4cQ9f6Nws+L
         6VW0jMW40RFg/rbXADLrqHsODSRNk+9KOgEPKx9g2r9un4Sc0qEVzl2nhazFLz71j+Fi
         o0+TSzwklcYRolLDoJ6G5HeBthW5kUhDJAtQR8g68O/7JTtUM2j69zLQusanQ5js3YOc
         6G8tbAw6CgHWpWRNJLMtP1Cq4LtDlhIWnpQRhKw/SE6Q6ev/feJRLnRRNOK8JrgX0L1j
         acWQ==
X-Gm-Message-State: AOAM532dLOjbfp0xJQabxz0zcpbD5Sq0iYdK8KADsKI1jSjG/ml+pN0U
        YP+PXa9FtCU4YSF7sy5UYcg=
X-Google-Smtp-Source: ABdhPJwlyBq70Ao6oyPChqGwM65eNKXxvnLvdsI4OPQsccgZhfjC7EY/7gY2w5A130uKf3TSjjgnQg==
X-Received: by 2002:aca:6704:: with SMTP id z4mr14390493oix.89.1627998760902;
        Tue, 03 Aug 2021 06:52:40 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com. [2603:8090:2005:39b3::1010])
        by smtp.gmail.com with ESMTPSA id y26sm2504106otq.23.2021.08.03.06.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:52:40 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 04/10] staging: r8188eu: Remove 4 empty routines from os_sep/service.c
Date:   Tue,  3 Aug 2021 08:52:17 -0500
Message-Id: <20210803135223.12543-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
References: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Routines rtw_suspend_lock_init(), rtw_suspend_lock_uninit(),
rtw_lock_suspend(), and rtw_unlock_suspend() do not conti=ain any code.
Simplify by removing them.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/include/osdep_service.h |  5 -----
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 16 ----------------
 drivers/staging/r8188eu/os_dep/rtw_android.c    |  2 --
 drivers/staging/r8188eu/os_dep/usb_intf.c       |  4 ----
 4 files changed, 27 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index c70bbca29ccb..39c7c5534b55 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -322,11 +322,6 @@ static inline u32 bitshift(u32 bitmask)
 /*  limitation of path length */
 #define PATH_LENGTH_MAX PATH_MAX
 
-void rtw_suspend_lock_init(void);
-void rtw_suspend_lock_uninit(void);
-void rtw_lock_suspend(void);
-void rtw_unlock_suspend(void);
-
 struct rtw_netdev_priv_indicator {
 	void *priv;
 	u32 sizeof_priv;
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index f44b7dea95ed..b1ccd620baab 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -167,22 +167,6 @@ void rtw_yield_os(void)
 
 #define RTW_SUSPEND_LOCK_NAME "rtw_wifi"
 
-inline void rtw_suspend_lock_init(void)
-{
-}
-
-inline void rtw_suspend_lock_uninit(void)
-{
-}
-
-inline void rtw_lock_suspend(void)
-{
-}
-
-inline void rtw_unlock_suspend(void)
-{
-}
-
 static const struct device_type wlan_type = {
 	.name = "wlan",
 };
diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
index 2b9e719e2a51..b55c86131dc7 100644
--- a/drivers/staging/r8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
@@ -147,7 +147,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 	int bytes_written = 0;
 	struct android_wifi_priv_cmd priv_cmd;
 
-	rtw_lock_suspend();
 	if (!ifr->ifr_data) {
 		ret = -EINVAL;
 		goto exit;
@@ -279,7 +278,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 		ret = bytes_written;
 	}
 exit:
-	rtw_unlock_suspend();
 	kfree(command);
 	return ret;
 }
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 2c372c9ad7e7..18151b09c84f 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -818,8 +818,6 @@ static int __init rtw_drv_entry(void)
 
 	DBG_88E(DRV_NAME " driver version=%s\n", DRIVERVERSION);
 
-	rtw_suspend_lock_init();
-
 	_rtw_mutex_init(&usb_drv->hw_init_mutex);
 
 	usb_drv->drv_registered = true;
@@ -831,8 +829,6 @@ static void __exit rtw_drv_halt(void)
 	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("+rtw_drv_halt\n"));
 	DBG_88E("+rtw_drv_halt\n");
 
-	rtw_suspend_lock_uninit();
-
 	usb_drv->drv_registered = false;
 	usb_deregister(&usb_drv->usbdrv);
 
-- 
2.32.0

