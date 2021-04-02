Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF5352A33
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 13:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhDBLZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 07:25:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15470 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBLZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 07:25:09 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBd2X1VRgzyNh0;
        Fri,  2 Apr 2021 19:23:00 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 19:25:00 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2] crypto: hisilicon/qm - delete redundant code
Date:   Fri, 2 Apr 2021 19:22:30 +0800
Message-ID: <1617362550-23630-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "qdma" is a structure variable instead of actual data. This
structure doesn't need to be zerod, The memset is useless and redundant.
So delete it.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
Changes v1 -> v2:
 Re-edit the description.

 drivers/crypto/hisilicon/qm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 13cb421..88a6c6f 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -2527,7 +2527,6 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 		hisi_qm_cache_wb(qm);
 		dma_free_coherent(dev, qm->qdma.size,
 				  qm->qdma.va, qm->qdma.dma);
-		memset(&qm->qdma, 0, sizeof(qm->qdma));
 	}
 
 	qm_irq_unregister(qm);
-- 
2.8.1

