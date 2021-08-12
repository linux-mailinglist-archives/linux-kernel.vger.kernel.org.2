Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D5C3EA5A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhHLN14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhHLN1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:27:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77317C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:27:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id z20so11588660ejf.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1XyyEYLOje8+rMvka9FNoicpg3HUjRni4R1G0+vh+4=;
        b=RaXKoLf97je3BYHTr6WL752pU+3dr3DId3m89eB0vFkbYb5ywkUZcBzm1c5QoZCUwb
         NhVFS659FYLCpZR9hS3iLmPVLZyzGyRvByjt6aQr/hpd4mIrUAxaHYEd7KBgU15qrMU4
         l+zUyAwEouR9DIeNxRSsEFMNl4R4nVOC2yeYSjKOchRYfjK6ornu+JLGEw3zqCwBaB/+
         wWkVpOG40kDAJplv8FP5SQlMHTsqBLAFAMnVQ+orFBuiyfXtnpR51nyEoA2ZK0bE7ua2
         NFN5xOIHjuvQbCEqsvszc06+ry7ES+Y3fWYua+M3tugqiTui95y/1kOWLvFsRdPI1TzJ
         muDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1XyyEYLOje8+rMvka9FNoicpg3HUjRni4R1G0+vh+4=;
        b=rna1XGm93zQV1kk+YSE33GOCoSjx8cVMjvsO3SVpKWwVP2uSumqaqt12FcKj9rypiv
         4uIWix/3k+S6CX03nQc8rxx07JaJm2VV1TEAn8HjYBwEi2f4Yk2CIC7u6kPOgel8whhp
         IRifehmKRj1yM+3mzH7Spw+ACV0cno4WWfU+O7P743XFVLUxw6Wkc6kkrudZHE7qXOLm
         jzJi2c5nlaVzhq6DRu5FirRG0RMJmGkUlj6xq36V7PlTMBM3UZtGvSrm+PiUmt3yzlVC
         LQKnE42PZWBegJjmYHIDee4ZdqVgck9+yjtM7gl8+tN2vH3jYr2xd1LM/2V7S0aHZpzf
         TScQ==
X-Gm-Message-State: AOAM531az/K4P7ajTWrtzB2ur4QxkeXJpFxLkdX5HhYeLXU/4zPV30Bs
        wLTWEUyf/W+AgV7QJ9EuT88wb39wnnA=
X-Google-Smtp-Source: ABdhPJyULvIDilpcBpjZfeXM47eXHz0AftsFblB4I9GyYW8U8jQL7puMffzOwBSX4pyuVdzEPnvfLQ==
X-Received: by 2002:a17:907:35d0:: with SMTP id ap16mr3667669ejc.456.1628774847517;
        Thu, 12 Aug 2021 06:27:27 -0700 (PDT)
Received: from agape ([5.171.80.192])
        by smtp.gmail.com with ESMTPSA id p5sm809860ejl.73.2021.08.12.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 06:27:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove cfg80211 residuals
Date:   Thu, 12 Aug 2021 15:27:25 +0200
Message-Id: <20210812132725.18404-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove cfg80211 implementation residuals:
an headeer file and build condition in Kconfig
file.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
Dear Greg and Larry,
I thought that cfg80211 had been implemented.
Should we add a TODO file telling developers to
do it in the near future? Is that a condition
for mainlining r8188eu? If so please drop this
patch and sorry for noise.

 drivers/staging/r8188eu/Kconfig               |  2 +-
 .../staging/r8188eu/include/ioctl_cfg80211.h  | 91 -------------------
 drivers/staging/r8188eu/os_dep/rtw_android.c  |  1 -
 3 files changed, 1 insertion(+), 93 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/ioctl_cfg80211.h

diff --git a/drivers/staging/r8188eu/Kconfig b/drivers/staging/r8188eu/Kconfig
index dc1719d3f2e4..beb768416ab9 100644
--- a/drivers/staging/r8188eu/Kconfig
+++ b/drivers/staging/r8188eu/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config R8188EU
 	tristate "Realtek RTL8188EU Wireless LAN NIC driver"
-	depends on WLAN && USB && CFG80211
+	depends on WLAN && USB
 	depends on m
 	select WIRELESS_EXT
 	select WEXT_PRIV
diff --git a/drivers/staging/r8188eu/include/ioctl_cfg80211.h b/drivers/staging/r8188eu/include/ioctl_cfg80211.h
deleted file mode 100644
index e22481050ef8..000000000000
--- a/drivers/staging/r8188eu/include/ioctl_cfg80211.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. i*/
-
-#ifndef __IOCTL_CFG80211_H__
-#define __IOCTL_CFG80211_H__
-
-struct rtw_wdev_invit_info {
-	u8 token;
-	u8 flags;
-	u8 status;
-	u8 req_op_ch;
-	u8 rsp_op_ch;
-};
-
-#define rtw_wdev_invit_info_init(invit_info) \
-	do { \
-		(invit_info)->token = 0; \
-		(invit_info)->flags = 0x00; \
-		(invit_info)->status = 0xff; \
-		(invit_info)->req_op_ch = 0; \
-		(invit_info)->rsp_op_ch = 0; \
-	} while (0)
-
-struct rtw_wdev_priv {
-	struct wireless_dev *rtw_wdev;
-
-	struct adapter *padapter;
-
-	struct cfg80211_scan_request *scan_request;
-	spinlock_t scan_req_lock;
-
-	struct net_device *pmon_ndev;/* for monitor interface */
-	char ifname_mon[IFNAMSIZ + 1]; /* name of monitor interface */
-
-	u8 p2p_enabled;
-
-	u8 provdisc_req_issued;
-
-	struct rtw_wdev_invit_info invit_info;
-
-	u8 bandroid_scan;
-	bool block;
-	bool power_mgmt;
-};
-
-#define wdev_to_priv(w) ((struct rtw_wdev_priv *)(wdev_priv(w)))
-
-#define wiphy_to_wdev(x)				\
-((struct wireless_dev *)(((struct rtw_wdev_priv *)wiphy_priv(x))->rtw_wdev))
-
-int rtw_wdev_alloc(struct adapter *padapter, struct device *dev);
-void rtw_wdev_free(struct wireless_dev *wdev);
-void rtw_wdev_unregister(struct wireless_dev *wdev);
-
-void rtw_cfg80211_init_wiphy(struct adapter *padapter);
-
-void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter);
-
-void rtw_cfg80211_indicate_connect(struct adapter *padapter);
-void rtw_cfg80211_indicate_disconnect(struct adapter *padapter);
-void rtw_cfg80211_indicate_scan_done(struct rtw_wdev_priv *pwdev_priv,
-				     bool aborted);
-
-#ifdef CONFIG_88EU_AP_MODE
-void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter,
-				     u8 *pmgmt_frame, uint frame_len);
-void rtw_cfg80211_indicate_sta_disassoc(struct adapter *padapter,
-					unsigned char *da,
-					unsigned short reason);
-#endif /* CONFIG_88EU_AP_MODE */
-
-void rtw_cfg80211_issue_p2p_provision_request(struct adapter *padapter,
-					      const u8 *buf, size_t len);
-void rtw_cfg80211_rx_p2p_action_public(struct adapter *padapter,
-				       u8 *pmgmt_frame, uint frame_len);
-void rtw_cfg80211_rx_action_p2p(struct adapter *padapter, u8 *pmgmt_frame,
-				uint frame_len);
-void rtw_cfg80211_rx_action(struct adapter *adapter, u8 *frame,
-			    uint frame_len, const char *msg);
-
-int rtw_cfg80211_set_mgnt_wpsp2pie(struct net_device *net,
-				   char *buf, int len, int type);
-
-bool rtw_cfg80211_pwr_mgmt(struct adapter *adapter);
-
-#define rtw_cfg80211_rx_mgmt(dev, freq, sig_dbm, buf, len, gfp)		\
-	cfg80211_rx_mgmt(dev, freq, sig_dbm, buf, len, gfp)
-#define rtw_cfg80211_send_rx_assoc(dev, bss, buf, len)			\
-	cfg80211_send_rx_assoc(dev, bss, buf, len)
-
-#endif /* __IOCTL_CFG80211_H__ */
diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
index d666feb87a7a..7c5e5c8007e3 100644
--- a/drivers/staging/r8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
@@ -7,7 +7,6 @@
 #include "../include/rtw_android.h"
 #include "../include/osdep_service.h"
 #include "../include/rtw_debug.h"
-#include "../include/ioctl_cfg80211.h"
 #include "../include/rtw_ioctl_set.h"
 
 static const char *android_wifi_cmd_str[ANDROID_WIFI_CMD_MAX] = {
-- 
2.20.1

