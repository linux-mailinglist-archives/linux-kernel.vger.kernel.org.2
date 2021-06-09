Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986093A0EB0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbhFII0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:26:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3811 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhFII0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:26:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0Klf72FbzWtNL;
        Wed,  9 Jun 2021 16:19:42 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 16:24:34 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 16:24:34 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next v2 1/2] staging: rtl8188eu: Use is_{zero/broadcast}_ether_addr() instead of memcmp()
Date:   Wed, 9 Jun 2021 16:56:49 +0800
Message-ID: <20210609085650.1269008-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code by using is_{zero/broadcast}_ether_addr() instead of
directly using memcmp() to determine if the ethernet address is all
zeros or broadcast address.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
v1->v2:
1. Add the benefit of this patch in changelog.
2. Change the subject line according to fabio's reminder.

 drivers/staging/rtl8188eu/core/rtw_mlme.c     |  4 ++--
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |  7 +++----
 drivers/staging/rtl8188eu/core/rtw_recv.c     | 11 ++++++-----
 drivers/staging/rtl8188eu/hal/odm.c           |  5 +++--
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index ba73ac5325e2..01bbfd29488f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -19,6 +19,7 @@
 #include <wlan_bssdef.h>
 #include <rtw_ioctl_set.h>
 #include <linux/vmalloc.h>
+#include <linux/etherdevice.h>
 
 extern const u8 MCS_rate_1R[16];
 
@@ -179,9 +180,8 @@ struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct list_head *phead, *plist;
 	struct wlan_network *pnetwork = NULL;
-	u8 zero_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 
-	if (!memcmp(zero_addr, addr, ETH_ALEN)) {
+	if (is_zero_ether_addr(addr)) {
 		pnetwork = NULL;
 		goto exit;
 	}
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index b4d81d3a856c..8c1bc04dd830 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -7,6 +7,7 @@
 #define _RTW_MLME_EXT_C_
 
 #include <linux/ieee80211.h>
+#include <linux/etherdevice.h>
 #include <asm/unaligned.h>
 
 #include <osdep_service.h>
@@ -4048,13 +4049,12 @@ static void _mgt_dispatcher(struct adapter *padapter,
 			    struct mlme_handler *ptable,
 			    struct recv_frame *precv_frame)
 {
-	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	u8 *pframe = precv_frame->pkt->data;
 
 	if (ptable->func) {
 		/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
 		if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
-		    memcmp(GetAddr1Ptr(pframe), bc_addr, ETH_ALEN))
+		    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))
 			return;
 		ptable->func(padapter, precv_frame);
 	}
@@ -4067,7 +4067,6 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 #ifdef CONFIG_88EU_AP_MODE
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 #endif
-	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	u8 *pframe = precv_frame->pkt->data;
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(pframe));
 
@@ -4085,7 +4084,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
 	if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
-	    memcmp(GetAddr1Ptr(pframe), bc_addr, ETH_ALEN))
+	    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))
 		return;
 
 	ptable = mlme_sta_tbl;
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index e79cfdd4bf90..cb0629fefbc5 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -15,6 +15,7 @@
 #include <mon.h>
 #include <wifi.h>
 #include <linux/vmalloc.h>
+#include <linux/etherdevice.h>
 #include <net/cfg80211.h>
 
 #define ETHERNET_HEADER_SIZE	14	/*  Ethernet Header Length */
@@ -651,8 +652,8 @@ static int sta2sta_data_frame(struct adapter *adapter,
 			goto exit;
 		}
 
-		if (!memcmp(pattrib->bssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
-		    !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
+		if (is_zero_ether_addr(pattrib->bssid) ||
+		    is_zero_ether_addr(mybssid) ||
 		    memcmp(pattrib->bssid, mybssid, ETH_ALEN)) {
 			ret = _FAIL;
 			goto exit;
@@ -734,9 +735,9 @@ static int ap2sta_data_frame(struct adapter *adapter,
 		}
 
 		/*  check BSSID */
-		if (!memcmp(pattrib->bssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
-		    !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
-		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
+		if (is_zero_ether_addr(pattrib->bssid) ||
+		    is_zero_ether_addr(mybssid) ||
+		    (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
 				 (" %s:  compare BSSID fail ; BSSID=%pM\n", __func__, (pattrib->bssid)));
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid=%pM\n", (mybssid)));
diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 8348e02b4c86..041ee2965add 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -5,6 +5,8 @@
  *
  ******************************************************************************/
 
+#include <linux/etherdevice.h>
+
 #include "odm_precomp.h"
 #include "phy.h"
 
@@ -893,7 +895,6 @@ void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
 	u8	sta_cnt = 0;
 	u32 PWDB_rssi[NUM_STA] = {0};/* 0~15]:MACID, [16~31]:PWDB_rssi */
 	struct sta_info *psta;
-	u8 bcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	if (!check_fwstate(&Adapter->mlmepriv, _FW_LINKED))
 		return;
@@ -902,7 +903,7 @@ void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
 		psta = pDM_Odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(psta) &&
 		    (psta->state & WIFI_ASOC_STATE) &&
-		    memcmp(psta->hwaddr, bcast_addr, ETH_ALEN) &&
+		    !is_broadcast_ether_addr(psta->hwaddr) &&
 		    memcmp(psta->hwaddr, myid(&Adapter->eeprompriv), ETH_ALEN)) {
 			if (psta->rssi_stat.UndecoratedSmoothedPWDB < tmpEntryMinPWDB)
 				tmpEntryMinPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
-- 
2.18.0.huawei.25

