Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF83A3EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhFKJJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:09:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4034 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbhFKJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:09:08 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G1Zbq2QQNzWspr;
        Fri, 11 Jun 2021 17:02:15 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:07:09 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 17:07:09 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 3/8] crypto: hisilicon/qm - merges the work initialization process into a single function
Date:   Fri, 11 Jun 2021 17:06:45 +0800
Message-ID: <1623402410-63906-4-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623402410-63906-1-git-send-email-yekai13@huawei.com>
References: <1623402410-63906-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merges the work initialization process into a single function from
qm initialization.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 171ddbb..9b8e09e 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -5337,6 +5337,16 @@ static int hisi_qm_pci_init(struct hisi_qm *qm)
 	return ret;
 }
 
+static void hisi_qm_init_work(struct hisi_qm *qm)
+{
+	INIT_WORK(&qm->work, qm_work_process);
+	if (qm->fun_type == QM_HW_PF)
+		INIT_WORK(&qm->rst_work, hisi_qm_controller_reset);
+
+	if (qm->ver > QM_HW_V2)
+		INIT_WORK(&qm->cmd_process, qm_cmd_process);
+}
+
 static int hisi_qp_alloc_memory(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
@@ -5452,13 +5462,7 @@ int hisi_qm_init(struct hisi_qm *qm)
 	if (ret)
 		goto err_alloc_uacce;
 
-	INIT_WORK(&qm->work, qm_work_process);
-	if (qm->fun_type == QM_HW_PF)
-		INIT_WORK(&qm->rst_work, hisi_qm_controller_reset);
-
-	if (qm->ver >= QM_HW_V3)
-		INIT_WORK(&qm->cmd_process, qm_cmd_process);
-
+	hisi_qm_init_work(qm);
 	qm_cmd_init(qm);
 	atomic_set(&qm->status.flags, QM_INIT);
 
-- 
2.7.4

