Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA14A3DDC22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhHBPQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbhHBPQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:16:13 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E98C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:16:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y18so24484968oiv.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TBpnCIXwU2CChXycW4WIiEUATkBsKbYaqJr0e/5SPM=;
        b=upbDQIuvQsHjMcDQrMd+G5VKtJFnh36fIVHDxMKtESheOrGaBxdgVwycpKm5bK4dmZ
         Ci6oZ0V9ruyJMwne2tMmpEQUCogbbytIarkjLKMLeF+mOppi4t2TTTM57fy+e9iOokBk
         YaGY0WbU8/s/AR+aR5n0WZqgEH8v/nIrOO+Ry9mZ2fCO+wOi82jx6auJypb+GjtAhKae
         RuQyE5bHyx4bmBYAdgOhnH/SaDd2u29gL8ngbTEb7rZjwtLN8QZAyhWeUyTc7yunwqWA
         N2kDe1QNWCgruMvI8suNdbXA9Z2zNn/HAurwcSz8fRNn6rzdzsSand3rKL5KRFrK4gTk
         PO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6TBpnCIXwU2CChXycW4WIiEUATkBsKbYaqJr0e/5SPM=;
        b=PlmFAIzKk91+8WpFb0nhZsGFFRaOaji36+gV7o9bMGH0NHWG7uDnWQpaXbftfHM7t0
         jBJSJINgtntgRNNN3r0XYymmQ94DxStLJJyCK/o2EUr1rLYDYTwQs8JkOPyVoSk05+op
         BEx6HcStU19qpMN11hIe2529gxw2rM6Fi6GCnlxlrjHiqXnqLnhtCKiDscRVT+965c89
         UMyaGjjYBKFNH4q7xXuKH9RcyRuPL8NH4k0/yIcjQVyIxDfTnzyiiOBueBEowuWj6MK6
         /JShZ+bykzm5mcPF+sUhHLjXzwg/Je+JcEmuCH9vjqwxY7s63VWTxsKE8YdPzYXTfBG3
         HkwA==
X-Gm-Message-State: AOAM530xH5hrV93f0mVcACTJEjyYzFJ2fjMXPozbAnPQRVYShVrzO9gp
        DBI2yjNePfG2jBmX3MRJISsWAUQjaIE=
X-Google-Smtp-Source: ABdhPJx1EeOppFVrjJJv0doaSjoRmyxoZHtUXUYe9AX5E0W5Us12XHS8iKCQuXt4/PHSk+Kz8gKAjw==
X-Received: by 2002:a05:6808:218f:: with SMTP id be15mr11236268oib.75.1627917363010;
        Mon, 02 Aug 2021 08:16:03 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id w16sm1807034oiv.15.2021.08.02.08.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:16:02 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/6] staging: r8188eu: Remove 4 empty routines from os_sep/service.c
Date:   Mon,  2 Aug 2021 10:15:44 -0500
Message-Id: <20210802151546.31797-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802151546.31797-1-Larry.Finger@lwfinger.net>
References: <20210802151546.31797-1-Larry.Finger@lwfinger.net>
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
index fd7716b6de2a..23aef493b601 100644
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
index 8cf84cad5094..869efcd5531a 100644
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

