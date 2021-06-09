Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5D3A0EB1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhFII0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:26:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3812 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbhFII0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:26:38 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0Klq0M1czWsfj;
        Wed,  9 Jun 2021 16:19:51 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 16:24:43 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 16:24:42 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next v2 2/2] staging: rtl8188eu: Use eth_broadcast_addr() to assign broadcast address
Date:   Wed, 9 Jun 2021 16:56:50 +0800
Message-ID: <20210609085650.1269008-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20210609085650.1269008-1-liushixin2@huawei.com>
References: <20210609085650.1269008-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code by using eth_broadcast_addr() to assign broadcast
address and removing the unnecessary variable bc_addr.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
v1->v2:
1. Add the benefit of this patch in changelog.
2. Change the subject line according to fabio's reminder.

 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 8c1bc04dd830..119110a150b2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -315,7 +315,6 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
-	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
@@ -339,7 +338,7 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
-	ether_addr_copy(pwlanhdr->addr1, bc_addr);
+	eth_broadcast_addr(pwlanhdr->addr1);
 	ether_addr_copy(pwlanhdr->addr2, myid(&padapter->eeprompriv));
 	ether_addr_copy(pwlanhdr->addr3, cur_network->MacAddress);
 
@@ -605,7 +604,6 @@ static int issue_probereq(struct adapter *padapter,
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	int bssrate_len = 0;
-	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+%s\n", __func__));
 
@@ -633,8 +631,8 @@ static int issue_probereq(struct adapter *padapter,
 		ether_addr_copy(pwlanhdr->addr3, da);
 	} else {
 		/*	broadcast probe request frame */
-		ether_addr_copy(pwlanhdr->addr1, bc_addr);
-		ether_addr_copy(pwlanhdr->addr3, bc_addr);
+		eth_broadcast_addr(pwlanhdr->addr1);
+		eth_broadcast_addr(pwlanhdr->addr3);
 	}
 
 	ether_addr_copy(pwlanhdr->addr2, mac);
-- 
2.18.0.huawei.25

