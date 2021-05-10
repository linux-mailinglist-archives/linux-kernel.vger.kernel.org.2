Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D307377F13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhEJJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:11:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2746 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhEJJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:11:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FdwCZ5ZHzzqV1W;
        Mon, 10 May 2021 17:06:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 17:09:48 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] crypto: hisilicon/hpre - use 'GENMASK' to generate mask value
Date:   Mon, 10 May 2021 17:06:49 +0800
Message-ID: <1620637611-41643-7-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1620637611-41643-1-git-send-email-tanghui20@huawei.com>
References: <1620637611-41643-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'GENMASK' to generate mask value, just make the code clearer.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 6 +++---
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 8 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 3a3af82..fb8e9c0 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -326,9 +326,9 @@ static int hpre_alg_res_post_hf(struct hpre_ctx *ctx, struct hpre_sqe *sqe,
 
 #define HPRE_NO_HW_ERR		0
 #define HPRE_HW_TASK_DONE	3
-#define HREE_HW_ERR_MASK	0x7ff
-#define HREE_SQE_DONE_MASK	0x3
-#define HREE_ALG_TYPE_MASK	0x1f
+#define HREE_HW_ERR_MASK	GENMASK(10, 0)
+#define HREE_SQE_DONE_MASK	GENMASK(1, 0)
+#define HREE_ALG_TYPE_MASK	GENMASK(4, 0)
 	id = (int)le16_to_cpu(sqe->tag);
 	req = ctx->req_list[id];
 	hpre_rm_req_from_ctx(req);
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 1e7d1fb..b94185a 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -36,7 +36,7 @@
 #define HPRE_INT_MASK			0x301400
 #define HPRE_INT_STATUS			0x301800
 #define HPRE_CORE_INT_ENABLE		0
-#define HPRE_CORE_INT_DISABLE		0x003fffff
+#define HPRE_CORE_INT_DISABLE		GENMASK(21, 0)
 #define HPRE_RDCHN_INI_ST		0x301a00
 #define HPRE_CLSTR_BASE			0x302000
 #define HPRE_CORE_EN_OFFSET		0x04
@@ -75,6 +75,12 @@
 #define HPRE_BD_USR_MASK		0x3
 #define HPRE_CLUSTER_CORE_MASK_V2	0xf
 #define HPRE_CLUSTER_CORE_MASK_V3	0xff
+#define HPRE_QM_USR_CFG_MASK		GENMASK(31, 1)
+#define HPRE_QM_AXI_CFG_MASK		GENMASK(15, 0)
+#define HPRE_QM_VFG_AX_MASK		GENMASK(7, 0)
+#define HPRE_BD_USR_MASK		GENMASK(1, 0)
+#define HPRE_CLUSTER_CORE_MASK_V2	GENMASK(3, 0)
+#define HPRE_CLUSTER_CORE_MASK_V3	GENMASK(7, 0)
 
 #define HPRE_AM_OOO_SHUTDOWN_ENB	0x301044
 #define HPRE_AM_OOO_SHUTDOWN_ENABLE	BIT(0)
-- 
2.8.1

