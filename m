Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249483FA366
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 05:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhH1Dlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 23:41:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9376 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhH1Dln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 23:41:43 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GxMh84Bz1z8tJC;
        Sat, 28 Aug 2021 11:36:40 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 28 Aug 2021 11:40:51 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 28 Aug
 2021 11:40:51 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 1/2] crypto: hisilicon/qm - fix the uacce mmap failed
Date:   Sat, 28 Aug 2021 11:39:38 +0800
Message-ID: <1630121979-53760-2-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630121979-53760-1-git-send-email-yekai13@huawei.com>
References: <1630121979-53760-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate an extra memory page for qp. This extra page is
used to set the device or qp status. But this page not
be used currently. Meanwhile it leads to dus size not equal
to mmap size as using uacce sva mode, and cause the app task
broken.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 369562d..2bd25bf 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3122,8 +3122,10 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 	else
 		mmio_page_nr = qm->db_interval / PAGE_SIZE;
 
+	/* Add one more page for device or qp status */
 	dus_page_nr = (PAGE_SIZE - 1 + qm->sqe_size * QM_Q_DEPTH +
-		       sizeof(struct qm_cqe) * QM_Q_DEPTH) >> PAGE_SHIFT;
+		       sizeof(struct qm_cqe) * QM_Q_DEPTH  + PAGE_SIZE) >>
+					 PAGE_SHIFT;
 
 	uacce->qf_pg_num[UACCE_QFRT_MMIO] = mmio_page_nr;
 	uacce->qf_pg_num[UACCE_QFRT_DUS]  = dus_page_nr;
-- 
2.7.4

