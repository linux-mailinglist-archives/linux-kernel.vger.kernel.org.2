Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3976E3EE82F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbhHQINT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:13:19 -0400
Received: from mx21.baidu.com ([220.181.3.85]:37454 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239238AbhHQINK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:13:10 -0400
Received: from BC-Mail-Ex14.internal.baidu.com (unknown [172.31.51.54])
        by Forcepoint Email with ESMTPS id CDB4AD3F9AE67A2C1B08;
        Tue, 17 Aug 2021 16:12:11 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex14.internal.baidu.com (172.31.51.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 17 Aug 2021 16:12:11 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 17 Aug 2021 16:12:11 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <Larry.Finger@lwfinger.net>, <phil@philpotter.co.uk>,
        <gregkh@linuxfoundation.org>, <martin@kaiser.cx>,
        <insafonov@gmail.com>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH] staging: r8188eu: Remove LINUX_VERSION_CODE check
Date:   Tue, 17 Aug 2021 16:12:04 +0800
Message-ID: <20210817081204.2232-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex15.internal.baidu.com (172.31.51.55) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no need to check linux version, depending on the latest version

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c      |  5 ----
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 26 ++------------------
 drivers/staging/r8188eu/os_dep/rtw_android.c |  6 -----
 drivers/staging/r8188eu/os_dep/xmit_linux.c  |  6 -----
 4 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 5088b555f55d..ef9d5ad17632 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -3,7 +3,6 @@
 
 #define _RTW_MLME_C_
 
-#include <linux/version.h>
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
@@ -1499,11 +1498,7 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
 
 	rcu_read_lock();
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
 	if (rcu_dereference(adapter->pnetdev->rx_handler_data) &&
-#else
-	if (rcu_dereference(adapter->pnetdev->br_port) &&
-#endif
 	    (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_ADHOC_STATE) == true)) {
 		/*  expire NAT2.5 entry */
 		nat25_db_expire(adapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index cc7e54170948..a4e62cff97fa 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -12,7 +12,6 @@
 
 #include "../include/usb_osintf.h"
 #include "../include/rtw_br_ext.h"
-#include <linux/version.h>
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
@@ -637,19 +636,8 @@ static unsigned int rtw_classify8021d(struct sk_buff *skb)
 	return dscp >> 5;
 }
 
-static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5, 2, 0))
-			    ,struct net_device *sb_dev
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 19, 0))
-			    ,struct net_device *sb_dev
-                            ,select_queue_fallback_t fallback
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 14, 0))
-			    ,void *unused
-                            ,select_queue_fallback_t fallback
-#elif (LINUX_VERSION_CODE == KERNEL_VERSION(3, 13, 0))
-			    , void *accel
-#endif
-)
+static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
+			    struct net_device *sb_dev)
 {
 	struct adapter	*padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -706,15 +694,9 @@ int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname)
 	return 0;
 }
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,39)
 static const struct device_type wlan_type = {
 	.name = "wlan",
 };
-#else
-static struct device_type wlan_type = {
-	.name = "wlan",
-};
-#endif
 
 struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 {
@@ -992,11 +974,7 @@ void netdev_br_init(struct net_device *netdev)
 
 	rcu_read_lock();
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
 	if (rcu_dereference(adapter->pnetdev->rx_handler_data)) {
-#else
-	if (rcu_dereference(adapter->pnetdev->br_port)) {
-#endif
 		struct net_device *br_netdev;
 		struct net *devnet = NULL;
 
diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
index 414645d8121d..b222a085a322 100644
--- a/drivers/staging/r8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
@@ -4,7 +4,6 @@
 #include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
-#include <linux/version.h>
 #include "../include/rtw_android.h"
 #include "../include/osdep_service.h"
 #include "../include/rtw_debug.h"
@@ -64,13 +63,8 @@ int rtw_android_cmdstr_to_num(char *cmdstr)
 {
 	int cmd_num;
 	for (cmd_num=0; cmd_num < ANDROID_WIFI_CMD_MAX; cmd_num++)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 0, 0))
 		if (!strncasecmp(cmdstr, android_wifi_cmd_str[cmd_num],
 		    strlen(android_wifi_cmd_str[cmd_num])))
-#else
-		if (0 == strnicmp(cmdstr, android_wifi_cmd_str[cmd_num],
-		   strlen(android_wifi_cmd_str[cmd_num])))
-#endif
 			break;
 	return cmd_num;
 }
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 3a1b9d8988f2..69966c696130 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -3,7 +3,6 @@
 
 #define _XMIT_OSDEP_C_
 
-#include <linux/version.h>
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/if_ether.h"
@@ -108,7 +107,6 @@ void rtw_os_xmit_resource_free(struct adapter *padapter,
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
 {
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 35))
 	u16	queue;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
@@ -121,10 +119,6 @@ void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
 		if (__netif_subqueue_stopped(padapter->pnetdev, queue))
 			netif_wake_subqueue(padapter->pnetdev, queue);
 	}
-#else
-	if (netif_queue_stopped(padapter->pnetdev))
-		netif_wake_queue(padapter->pnetdev);
-#endif
 
 	dev_kfree_skb_any(pkt);
 }
-- 
2.25.1

