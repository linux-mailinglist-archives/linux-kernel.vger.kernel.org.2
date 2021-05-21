Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2CD38C446
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhEUKDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:03:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3468 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhEUKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:02:22 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fmhr1622czCvSg;
        Fri, 21 May 2021 17:58:09 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 18:00:52 +0800
Received: from huawei.com (10.67.165.24) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 21 May
 2021 18:00:52 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 2/2] crypto: hisilicon/qm - fix the process of VF's list adding
Date:   Fri, 21 May 2021 17:57:50 +0800
Message-ID: <1621591070-15652-3-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621591070-15652-1-git-send-email-yekai13@huawei.com>
References: <1621591070-15652-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Kunpeng 920 enabled the sva mode, the "qm alg register" process will
return directly. So the list of VF wasn't added to QM list.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index deb104e..c671f94 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4256,17 +4256,17 @@ int hisi_qm_alg_register(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
 	int flag = 0;
 	int ret = 0;
 
-	if (qm->ver <= QM_HW_V2 && qm->use_sva) {
-		dev_info(dev, "HW V2 not both use uacce sva mode and hardware crypto algs.\n");
-		return 0;
-	}
-
 	mutex_lock(&qm_list->lock);
 	if (list_empty(&qm_list->list))
 		flag = 1;
 	list_add_tail(&qm->list, &qm_list->list);
 	mutex_unlock(&qm_list->lock);
 
+	if (qm->ver <= QM_HW_V2 && qm->use_sva) {
+		dev_info(dev, "HW V2 not both use uacce sva mode and hardware crypto algs.\n");
+		return 0;
+	}
+
 	if (flag) {
 		ret = qm_list->register_to_crypto(qm);
 		if (ret) {
@@ -4291,13 +4291,13 @@ EXPORT_SYMBOL_GPL(hisi_qm_alg_register);
  */
 void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
 {
-	if (qm->ver <= QM_HW_V2 && qm->use_sva)
-		return;
-
 	mutex_lock(&qm_list->lock);
 	list_del(&qm->list);
 	mutex_unlock(&qm_list->lock);
 
+	if (qm->ver <= QM_HW_V2 && qm->use_sva)
+		return;
+
 	if (list_empty(&qm_list->list))
 		qm_list->unregister_from_crypto(qm);
 }
-- 
2.8.1

