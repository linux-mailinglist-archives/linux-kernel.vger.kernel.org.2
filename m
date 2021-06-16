Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C363A94C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhFPILJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:11:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7330 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhFPILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:11:04 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G4d5P1s7Lz6yFc;
        Wed, 16 Jun 2021 16:04:57 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 16:08:53 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 16:08:53 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH -next 2/3] staging: rtl8723bs: core: use eth_broadcast_addr() to assign broadcast address
Date:   Wed, 16 Jun 2021 16:12:42 +0800
Message-ID: <20210616081243.2511663-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616081243.2511663-1-yangyingliang@huawei.com>
References: <20210616081243.2511663-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using eth_broadcast_addr() to assign broadcast address instead
of copying from an array that contains the all-ones broadcast
address.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 0f50c2576356..4df3cba97f42 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2218,7 +2218,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
-	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -2240,7 +2239,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	fctrl = &(pwlanhdr->frame_control);
 	*(fctrl) = 0;
 
-	memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
+	eth_broadcast_addr(pwlanhdr->addr1);
 	memcpy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
 
@@ -2564,7 +2563,6 @@ static int _issue_probereq(struct adapter *padapter,
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	int	bssrate_len = 0;
-	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -2591,8 +2589,8 @@ static int _issue_probereq(struct adapter *padapter,
 		memcpy(pwlanhdr->addr3, da, ETH_ALEN);
 	} else {
 		/* 	broadcast probe request frame */
-		memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
-		memcpy(pwlanhdr->addr3, bc_addr, ETH_ALEN);
+		eth_broadcast_addr(pwlanhdr->addr1);
+		eth_broadcast_addr(pwlanhdr->addr3);
 	}
 
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
-- 
2.25.1

