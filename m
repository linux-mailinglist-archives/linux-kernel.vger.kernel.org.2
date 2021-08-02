Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7847C3DE005
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhHBT1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhHBT1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:27:46 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844A3C061760
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 12:27:36 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y18so25392051oiv.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XM/dnX169PdY58T0DXTOLgUFEaH+mFEvPtUrP7yg8OE=;
        b=cDuM8EXAx45jgxniMu4ZYiJ/trC6m25RgeQ7W90n8QvX1gqicv5FE+XAaEAPlKkVRF
         MlOylSQwXvp6VTdJwo8yTpU+p8k3WsrISuSNdIkKtB7/qJiK9XApQJMevMF0y2ED8mow
         AW3al0gWXmn2Mvrp0EqAvjLc9xq26VMW5QcmqACRQ6YR3IS0IozS1ybMdALTKduIPYMy
         Qx+23WtSXeJ95KuAKA1llUV1Wk80FbIVjJXxX8u8mcLoGOZsMp6wxigyjChYs45ctaXa
         80q8yu01jsYmStgF9IChcBVNSBAVMj4zfnoEL8A9ZREoWRpyCIlLKwpCeTe2ivpEQGYD
         GWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XM/dnX169PdY58T0DXTOLgUFEaH+mFEvPtUrP7yg8OE=;
        b=t/eJmqhe34Ht7nXzw1k1BNYkgNfFmqQ7/nMAhNsCl+T2VuDFC2AmLTsPHqUhRVhWz5
         RlyzgxMKxtJ1CZM1jB1HiLZ8jxlyCJ5SoWibS5aZcJlP759gz0WaiJz9YInGROPLQwBw
         LMjDTRNxonjqGFOh1vhvV3g6/1N1nyvB5yG5ZnfNKjuiWGjVYq0ZZwPO68C3R91Am/86
         +km7ci6xDyrIbt7DFF+B4O+nFAqTf9iEbgnAlqwrKkuRlPXXbpFnquLo5hH+JLr8CSxm
         8U3RWY+DpaWCsYSB4tTYgM1b81vRcp/RHC49ALCWZJ7uxlSYBWib38vzec9tyrbi0Fww
         HEgA==
X-Gm-Message-State: AOAM533T50pRhicBdaGqvLtbOQYJGNrYeihVCLxaChGEcJlgKNeXt8iE
        t+xHqLfAHe9+AsfWE0CNuso=
X-Google-Smtp-Source: ABdhPJyu98p88CYpj4V8X5T0ZEwsPohKuxgXlzRrFSK97OIdfyZnar3ViFLG3YN62HHBrPbKY7zP5A==
X-Received: by 2002:aca:c346:: with SMTP id t67mr432588oif.124.1627932455960;
        Mon, 02 Aug 2021 12:27:35 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id i188sm1981035oih.7.2021.08.02.12.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 12:27:35 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 4/6] staging: r8188eu: Remove 4 empty routines from os_sep/service.c
Date:   Mon,  2 Aug 2021 14:27:19 -0500
Message-Id: <20210802192721.23110-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
References: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
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
v2 - no change
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

