Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF63E5488
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhHJHpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhHJHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:45:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E1FC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:45:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k4so12333243wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMD9lc87gLR9mUn618m2da6Xz9eP1IZPnQ6Y9giCJ60=;
        b=BSFNkPJACLhV7hLuaLowjcRt/sPZEm0/yQFPGUWVk8jdvEPPtc2D1knHwsLdyMpkou
         qNsxfp2wr87iUy6Vpi0872VvSZ0HE0BHAHUV8vC1aMkwrY8kVAdMCSFFaa/02CY12fbR
         jbxunqViKB9ISUtq+whCT38QMukoDYl2bxV8S8xACEv3NXdCiwtZGjz9R0EAUmkoQK7B
         JyCGcFjXGsrElkQ/RL4Z/QhnCeS4rgeCWpekkSM3AI4usUVZ9D4VLFbb62gW59rAVeMa
         M7LPKMH4SdT+U0Pl2e9cQhnKxtKOaFx7cJPx7ZnqzlP0T2562RiYH2xfky24+VET0PsC
         DA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMD9lc87gLR9mUn618m2da6Xz9eP1IZPnQ6Y9giCJ60=;
        b=SoxV0OQunpmotVbpbqt7mKcCZZeUnhgqbnbHyMGDwjpdzI4xmblqr+JMFJl+LHeJL4
         FFNf/Mvtkw1D6dWuA/jv/GyzPTZJx4exDKQVzIpj3T7y3nbKknI1dFwx5n0HAtJvekBU
         6dxzR93Gn7OX/9q2v87Hj3SEPrdd+znd+LfNGSzxOTibYEx2Ed788ppiHJ61PXKxEEQb
         7hJh52yK9zQdqeLC1SZ0IwAO2afPz+0lLpnFOuMKfL+ydmBYeNjC8dJ2LoG9LkHBOfYA
         Iz4PhUCFUGBCGhxnKI8oivM3NS5vJScexCfntbFovFQdDGZnX0ZfGgc7mLLQtSRSbKxq
         ZtzA==
X-Gm-Message-State: AOAM530e+vEXF1/XUNLSu2k6DokCXlxy7weQGKh8qxgT5Y1MqE/Z6Z4H
        /+f/IfvGdCxVLxfc7izCn4+egw==
X-Google-Smtp-Source: ABdhPJzdiSUv999rtG5HAGMcE0/1qlYDTiib5nym8IELAKkgpweMXGgK5t8noa6UEbiHUWkDT+fbhg==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr3093610wmq.26.1628581505690;
        Tue, 10 Aug 2021 00:45:05 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id y21sm1845450wma.38.2021.08.10.00.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:45:05 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: [PATCH] staging: r8188eu: remove rtw_ioctl function
Date:   Tue, 10 Aug 2021 08:45:04 +0100
Message-Id: <20210810074504.957-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_ioctl function from os_dep/ioctl_linux.c, its declaration
in include/osdep_intf.h, and finally its inclusion as the value of the
.ndo_do_ioctl member of struct net_device_ops rtw_netdev_ops in
os_dep/os_intfs.c.

The e-mail from Arnd Bergmann at:
https://lore.kernel.org/linux-next/CAK8P3a0WRMNmBmBDerZ0nWPdFZKALnxrj-uUFBkTP-MOtv48vg@mail.gmail.com
explains the justification for this approach. Essentially, changes from
net-next make the existing function and its use of SIOCDEVPRIVATE ioctls
unworkable without changes.

Functions called from rtw_ioctl that are now no longer accessible will
be cleaned up in further patches. Additionally, once these changes have
made their way downstream to the staging branch, we can modify and
reconnect rtw_android_priv_cmd via ndo_siocdevprivate in struct
net_device_ops.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/osdep_intf.h |  2 --
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 28 --------------------
 drivers/staging/r8188eu/os_dep/os_intfs.c    |  1 -
 3 files changed, 31 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index 1915c926faac..3ea60feee2db 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -48,8 +48,6 @@ u32 rtw_start_drv_threads(struct adapter *padapter);
 void rtw_stop_drv_threads (struct adapter *padapter);
 void rtw_cancel_all_timer(struct adapter *padapter);
 
-int rtw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
-
 int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname);
 struct net_device *rtw_init_netdev(struct adapter *padapter);
 u16 rtw_recv_select_queue(struct sk_buff *skb);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 34dce01e469c..beabbc84232f 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -8097,31 +8097,3 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 	kfree(output);
 	return err;
 }
-
-#include "../include/rtw_android.h"
-int rtw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-{
-	struct iwreq *wrq = (struct iwreq *)rq;
-	int ret = 0;
-
-	switch (cmd) {
-	case RTL_IOCTL_WPA_SUPPLICANT:
-		ret = wpa_supplicant_ioctl(dev, &wrq->u.data);
-		break;
-#ifdef CONFIG_88EU_AP_MODE
-	case RTL_IOCTL_HOSTAPD:
-		ret = rtw_hostapd_ioctl(dev, &wrq->u.data);
-		break;
-#endif /*  CONFIG_88EU_AP_MODE */
-	case SIOCDEVPRIVATE:
-		ret = rtw_ioctl_wext_private(dev, &wrq->u);
-		break;
-	case (SIOCDEVPRIVATE+1):
-		ret = rtw_android_priv_cmd(dev, rq, cmd);
-		break;
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-	return ret;
-}
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 935e35c82666..7d17c765205c 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -692,7 +692,6 @@ static const struct net_device_ops rtw_netdev_ops = {
 	.ndo_select_queue	= rtw_select_queue,
 	.ndo_set_mac_address = rtw_net_set_mac_address,
 	.ndo_get_stats = rtw_net_get_stats,
-	.ndo_do_ioctl = rtw_ioctl,
 };
 
 int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname)
-- 
2.31.1

