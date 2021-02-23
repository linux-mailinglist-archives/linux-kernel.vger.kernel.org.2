Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9B322642
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhBWHO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:14:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12939 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhBWHN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:13:27 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dl9Fl083ZzjQQN;
        Tue, 23 Feb 2021 15:11:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Feb 2021 15:12:33 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <tudor.ambarus@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 2/7] crypto: hisilicon/hpre - add algorithm type
Date:   Tue, 23 Feb 2021 15:10:14 +0800
Message-ID: <1614064219-40701-3-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614064219-40701-1-git-send-email-yumeng18@huawei.com>
References: <1614064219-40701-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Algorithm type is brought in to get hardware HPRE queue
to support different algorithms.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre.h        | 10 +++++++++-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 12 ++++++------
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 11 +++++++++--
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index cc50f23..02193e1 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -10,6 +10,14 @@
 #define HPRE_PF_DEF_Q_NUM		64
 #define HPRE_PF_DEF_Q_BASE		0
 
+/*
+ * type used in qm sqc DW6.
+ * 0 - Algorithm which has been supported in V2, like RSA, DH and so on;
+ * 1 - ECC algorithm in V3.
+ */
+#define HPRE_V2_ALG_TYPE	0
+#define HPRE_V3_ECC_ALG_TYPE	1
+
 enum {
 	HPRE_CLUSTER0,
 	HPRE_CLUSTER1,
@@ -92,7 +100,7 @@ struct hpre_sqe {
 	__le32 rsvd1[_HPRE_SQE_ALIGN_EXT];
 };
 
-struct hisi_qp *hpre_create_qp(void);
+struct hisi_qp *hpre_create_qp(u8 type);
 int hpre_algs_register(struct hisi_qm *qm);
 void hpre_algs_unregister(struct hisi_qm *qm);
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index d89b2f5..712bea9 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -152,12 +152,12 @@ static void hpre_rm_req_from_ctx(struct hpre_asym_request *hpre_req)
 	}
 }
 
-static struct hisi_qp *hpre_get_qp_and_start(void)
+static struct hisi_qp *hpre_get_qp_and_start(u8 type)
 {
 	struct hisi_qp *qp;
 	int ret;
 
-	qp = hpre_create_qp();
+	qp = hpre_create_qp(type);
 	if (!qp) {
 		pr_err("Can not create hpre qp!\n");
 		return ERR_PTR(-ENODEV);
@@ -422,11 +422,11 @@ static void hpre_alg_cb(struct hisi_qp *qp, void *resp)
 	req->cb(ctx, resp);
 }
 
-static int hpre_ctx_init(struct hpre_ctx *ctx)
+static int hpre_ctx_init(struct hpre_ctx *ctx, u8 type)
 {
 	struct hisi_qp *qp;
 
-	qp = hpre_get_qp_and_start();
+	qp = hpre_get_qp_and_start(type);
 	if (IS_ERR(qp))
 		return PTR_ERR(qp);
 
@@ -674,7 +674,7 @@ static int hpre_dh_init_tfm(struct crypto_kpp *tfm)
 {
 	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
 
-	return hpre_ctx_init(ctx);
+	return hpre_ctx_init(ctx, HPRE_V2_ALG_TYPE);
 }
 
 static void hpre_dh_exit_tfm(struct crypto_kpp *tfm)
@@ -1100,7 +1100,7 @@ static int hpre_rsa_init_tfm(struct crypto_akcipher *tfm)
 		return PTR_ERR(ctx->rsa.soft_tfm);
 	}
 
-	ret = hpre_ctx_init(ctx);
+	ret = hpre_ctx_init(ctx, HPRE_V2_ALG_TYPE);
 	if (ret)
 		crypto_free_akcipher(ctx->rsa.soft_tfm);
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index e7a2c70..76f0a87 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -226,13 +226,20 @@ static u32 vfs_num;
 module_param_cb(vfs_num, &vfs_num_ops, &vfs_num, 0444);
 MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63), 0(default)");
 
-struct hisi_qp *hpre_create_qp(void)
+struct hisi_qp *hpre_create_qp(u8 type)
 {
 	int node = cpu_to_node(smp_processor_id());
 	struct hisi_qp *qp = NULL;
 	int ret;
 
-	ret = hisi_qm_alloc_qps_node(&hpre_devices, 1, 0, node, &qp);
+	if (type != HPRE_V2_ALG_TYPE && type != HPRE_V3_ECC_ALG_TYPE)
+		return NULL;
+
+	/*
+	 * type: 0 - RSA/DH. algorithm supported in V2,
+	 *       1 - ECC algorithm in V3.
+	 */
+	ret = hisi_qm_alloc_qps_node(&hpre_devices, 1, type, node, &qp);
 	if (!ret)
 		return qp;
 
-- 
2.8.1

