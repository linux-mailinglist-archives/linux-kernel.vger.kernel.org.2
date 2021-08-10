Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC483E5A56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbhHJMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 08:47:46 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13261 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238711AbhHJMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:47:40 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GkXlV6G2kz1CVJV;
        Tue, 10 Aug 2021 20:47:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 20:47:16 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 10 Aug
 2021 20:47:16 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <Larry.Finger@lwfinger.net>, <phil@philpotter.co.uk>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH -next] staging: r8188eu: Use GFP_ATOMIC under spin lock
Date:   Tue, 10 Aug 2021 20:53:14 +0800
Message-ID: <20210810125314.2182112-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A spin lock is taken in __nat25_db_network_insert() and
update_BCNTIM() is called under spin lock so we should
use GFP_ATOMIC in both place.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c     | 2 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index ad37f1f02ee2..0586e4a4cbcb 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -98,7 +98,7 @@ static void update_BCNTIM(struct adapter *padapter)
 		}
 
 		if (remainder_ielen > 0) {
-			pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_KERNEL);
+			pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_ATOMIC);
 			if (pbackup_remainder_ie && premainder_ie)
 				memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 28f0452d6ccb..e3ff059ce224 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -394,7 +394,7 @@ static void __nat25_db_network_insert(struct adapter *priv,
 		}
 		db = db->next_hash;
 	}
-	db = kmalloc(sizeof(*db), GFP_KERNEL);
+	db = kmalloc(sizeof(*db), GFP_ATOMIC);
 	if (!db) {
 		spin_unlock_bh(&priv->br_ext_lock);
 		return;
-- 
2.25.1

