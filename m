Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C376A3416A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 08:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhCSHdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 03:33:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13996 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhCSHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:32:56 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F1wYB02k6zrYTH;
        Fri, 19 Mar 2021 15:30:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 15:32:39 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 3/4] crypto: hisilicon/zip - initialize operations about 'sqe' in 'acomp_alg.init'
Date:   Fri, 19 Mar 2021 15:33:06 +0800
Message-ID: <1616139187-63425-4-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616139187-63425-1-git-send-email-shenyang39@huawei.com>
References: <1616139187-63425-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operations about 'sqe' are different on some hardwares. Add a struct
'hisi_zip_sqe_ops' to describe the operations in a hardware. And choose the
'ops' in 'hisi_zip_acomp_init' according to the hardware.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 141 +++++++++++++++++++++++-------
 1 file changed, 110 insertions(+), 31 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 3bc2148..85dcf6a 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -10,6 +10,7 @@
 #define HZIP_BD_STATUS_M			GENMASK(7, 0)
 /* hisi_zip_sqe dw7 */
 #define HZIP_IN_SGE_DATA_OFFSET_M		GENMASK(23, 0)
+#define HZIP_SQE_TYPE_M				GENMASK(31, 28)
 /* hisi_zip_sqe dw8 */
 #define HZIP_OUT_SGE_DATA_OFFSET_M		GENMASK(23, 0)
 /* hisi_zip_sqe dw9 */
@@ -91,8 +92,22 @@ struct hisi_zip_qp_ctx {
 	struct hisi_zip_ctx *ctx;
 };
 
+struct hisi_zip_sqe_ops {
+	u8 sqe_type;
+	void (*fill_addr)(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req);
+	void (*fill_buf_size)(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req);
+	void (*fill_buf_type)(struct hisi_zip_sqe *sqe, u8 buf_type);
+	void (*fill_req_type)(struct hisi_zip_sqe *sqe, u8 req_type);
+	void (*fill_tag)(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req);
+	void (*fill_sqe_type)(struct hisi_zip_sqe *sqe, u8 sqe_type);
+	u32 (*get_tag)(struct hisi_zip_sqe *sqe);
+	u32 (*get_status)(struct hisi_zip_sqe *sqe);
+	u32 (*get_dstlen)(struct hisi_zip_sqe *sqe);
+};
+
 struct hisi_zip_ctx {
 	struct hisi_zip_qp_ctx qp_ctx[HZIP_CTX_Q_NUM];
+	const struct hisi_zip_sqe_ops *ops;
 };
 
 static int sgl_sge_nr_set(const char *val, const struct kernel_param *kp)
@@ -242,35 +257,69 @@ static void hisi_zip_remove_req(struct hisi_zip_qp_ctx *qp_ctx,
 	write_unlock(&req_q->req_lock);
 }
 
-static void hisi_zip_config_buf_type(struct hisi_zip_sqe *sqe, u8 buf_type)
+static void hisi_zip_fill_addr(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req)
+{
+	sqe->source_addr_l = lower_32_bits(req->dma_src);
+	sqe->source_addr_h = upper_32_bits(req->dma_src);
+	sqe->dest_addr_l = lower_32_bits(req->dma_dst);
+	sqe->dest_addr_h = upper_32_bits(req->dma_dst);
+}
+
+static void hisi_zip_fill_buf_size(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req)
+{
+	struct acomp_req *a_req = req->req;
+
+	sqe->input_data_length = a_req->slen - req->sskip;
+	sqe->dest_avail_out = a_req->dlen - req->dskip;
+	sqe->dw7 = FIELD_PREP(HZIP_IN_SGE_DATA_OFFSET_M, req->sskip);
+	sqe->dw8 = FIELD_PREP(HZIP_OUT_SGE_DATA_OFFSET_M, req->dskip);
+}
+
+static void hisi_zip_fill_buf_type(struct hisi_zip_sqe *sqe, u8 buf_type)
 {
 	u32 val;
 
-	val = (sqe->dw9) & ~HZIP_BUF_TYPE_M;
+	val = sqe->dw9 & ~HZIP_BUF_TYPE_M;
 	val |= FIELD_PREP(HZIP_BUF_TYPE_M, buf_type);
 	sqe->dw9 = val;
 }
 
-static void hisi_zip_config_tag(struct hisi_zip_sqe *sqe, u32 tag)
+static void hisi_zip_fill_req_type(struct hisi_zip_sqe *sqe, u8 req_type)
 {
-	sqe->dw13 = tag;
+	u32 val;
+
+	val = sqe->dw9 & ~HZIP_REQ_TYPE_M;
+	val |= FIELD_PREP(HZIP_REQ_TYPE_M, req_type);
+	sqe->dw9 = val;
 }
 
-static void hisi_zip_fill_sqe(struct hisi_zip_sqe *sqe, u8 req_type,
-			      dma_addr_t s_addr, dma_addr_t d_addr, u32 slen,
-			      u32 dlen, u32 sskip, u32 dskip)
+static void hisi_zip_fill_tag_v1(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req)
 {
+	sqe->dw13 = req->req_id;
+}
+
+static void hisi_zip_fill_sqe_type(struct hisi_zip_sqe *sqe, u8 sqe_type)
+{
+	u32 val;
+
+	val = sqe->dw7 & ~HZIP_SQE_TYPE_M;
+	val |= FIELD_PREP(HZIP_SQE_TYPE_M, sqe_type);
+	sqe->dw7 = val;
+}
+
+static void hisi_zip_fill_sqe(struct hisi_zip_ctx *ctx, struct hisi_zip_sqe *sqe,
+			      u8 req_type, struct hisi_zip_req *req)
+{
+	const struct hisi_zip_sqe_ops *ops = ctx->ops;
+
 	memset(sqe, 0, sizeof(struct hisi_zip_sqe));
 
-	sqe->input_data_length = slen - sskip;
-	sqe->dw7 = FIELD_PREP(HZIP_IN_SGE_DATA_OFFSET_M, sskip);
-	sqe->dw8 = FIELD_PREP(HZIP_OUT_SGE_DATA_OFFSET_M, dskip);
-	sqe->dw9 = FIELD_PREP(HZIP_REQ_TYPE_M, req_type);
-	sqe->dest_avail_out = dlen - dskip;
-	sqe->source_addr_l = lower_32_bits(s_addr);
-	sqe->source_addr_h = upper_32_bits(s_addr);
-	sqe->dest_addr_l = lower_32_bits(d_addr);
-	sqe->dest_addr_h = upper_32_bits(d_addr);
+	ops->fill_addr(sqe, req);
+	ops->fill_buf_size(sqe, req);
+	ops->fill_buf_type(sqe, HZIP_SGL);
+	ops->fill_req_type(sqe, req_type);
+	ops->fill_tag(sqe, req);
+	ops->fill_sqe_type(sqe, ops->sqe_type);
 }
 
 static int hisi_zip_do_work(struct hisi_zip_req *req,
@@ -282,36 +331,30 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 	struct hisi_qp *qp = qp_ctx->qp;
 	struct device *dev = &qp->qm->pdev->dev;
 	struct hisi_zip_sqe zip_sqe;
-	dma_addr_t input, output;
 	int ret;
 
 	if (!a_req->src || !a_req->slen || !a_req->dst || !a_req->dlen)
 		return -EINVAL;
 
 	req->hw_src = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->src, pool,
-						    req->req_id << 1, &input);
+						    req->req_id << 1, &req->dma_src);
 	if (IS_ERR(req->hw_src)) {
 		dev_err(dev, "failed to map the src buffer to hw sgl (%ld)!\n",
 			PTR_ERR(req->hw_src));
 		return PTR_ERR(req->hw_src);
 	}
-	req->dma_src = input;
 
 	req->hw_dst = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->dst, pool,
 						    (req->req_id << 1) + 1,
-						    &output);
+						    &req->dma_dst);
 	if (IS_ERR(req->hw_dst)) {
 		ret = PTR_ERR(req->hw_dst);
 		dev_err(dev, "failed to map the dst buffer to hw slg (%d)!\n",
 			ret);
 		goto err_unmap_input;
 	}
-	req->dma_dst = output;
 
-	hisi_zip_fill_sqe(&zip_sqe, qp->req_type, input, output, a_req->slen,
-			  a_req->dlen, req->sskip, req->dskip);
-	hisi_zip_config_buf_type(&zip_sqe, HZIP_SGL);
-	hisi_zip_config_tag(&zip_sqe, req->req_id);
+	hisi_zip_fill_sqe(qp_ctx->ctx, &zip_sqe, qp->req_type, req);
 
 	/* send command to start a task */
 	atomic64_inc(&dfx->send_cnt);
@@ -332,20 +375,37 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 	return ret;
 }
 
+static u32 hisi_zip_get_tag_v1(struct hisi_zip_sqe *sqe)
+{
+	return sqe->dw13;
+}
+
+static u32 hisi_zip_get_status(struct hisi_zip_sqe *sqe)
+{
+	return sqe->dw3 & HZIP_BD_STATUS_M;
+}
+
+static u32 hisi_zip_get_dstlen(struct hisi_zip_sqe *sqe)
+{
+	return sqe->produced;
+}
+
 static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
 {
 	struct hisi_zip_qp_ctx *qp_ctx = qp->qp_ctx;
+	const struct hisi_zip_sqe_ops *ops = qp_ctx->ctx->ops;
 	struct hisi_zip_dfx *dfx = &qp_ctx->zip_dev->dfx;
 	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
 	struct device *dev = &qp->qm->pdev->dev;
 	struct hisi_zip_sqe *sqe = data;
-	struct hisi_zip_req *req = req_q->q + sqe->dw13;
+	u32 tag = ops->get_tag(sqe);
+	struct hisi_zip_req *req = req_q->q + tag;
 	struct acomp_req *acomp_req = req->req;
 	u32 status, dlen, head_size;
 	int err = 0;
 
 	atomic64_inc(&dfx->recv_cnt);
-	status = sqe->dw3 & HZIP_BD_STATUS_M;
+	status = ops->get_status(sqe);
 	if (status != 0 && status != HZIP_NC_ERR) {
 		dev_err(dev, "%scompress fail in qp%u: %u, output: %u\n",
 			(qp->alg_type == 0) ? "" : "de", qp->qp_id, status,
@@ -353,7 +413,8 @@ static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
 		atomic64_inc(&dfx->err_bd_cnt);
 		err = -EIO;
 	}
-	dlen = sqe->produced;
+
+	dlen = ops->get_dstlen(sqe);
 
 	hisi_acc_sg_buf_unmap(dev, acomp_req->src, req->hw_src);
 	hisi_acc_sg_buf_unmap(dev, acomp_req->dst, req->hw_dst);
@@ -453,9 +514,23 @@ static void hisi_zip_release_qp(struct hisi_zip_qp_ctx *ctx)
 	hisi_qm_release_qp(ctx->qp);
 }
 
+const struct hisi_zip_sqe_ops hisi_zip_ops_v1 = {
+	.sqe_type		= 0,
+	.fill_addr		= hisi_zip_fill_addr,
+	.fill_buf_size		= hisi_zip_fill_buf_size,
+	.fill_buf_type		= hisi_zip_fill_buf_type,
+	.fill_req_type		= hisi_zip_fill_req_type,
+	.fill_tag		= hisi_zip_fill_tag_v1,
+	.fill_sqe_type		= hisi_zip_fill_sqe_type,
+	.get_tag		= hisi_zip_get_tag_v1,
+	.get_status		= hisi_zip_get_status,
+	.get_dstlen		= hisi_zip_get_dstlen,
+};
+
 static int hisi_zip_ctx_init(struct hisi_zip_ctx *hisi_zip_ctx, u8 req_type, int node)
 {
 	struct hisi_qp *qps[HZIP_CTX_Q_NUM] = { NULL };
+	struct hisi_zip_qp_ctx *qp_ctx;
 	struct hisi_zip *hisi_zip;
 	int ret, i, j;
 
@@ -469,8 +544,9 @@ static int hisi_zip_ctx_init(struct hisi_zip_ctx *hisi_zip_ctx, u8 req_type, int
 
 	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
 		/* alg_type = 0 for compress, 1 for decompress in hw sqe */
-		ret = hisi_zip_start_qp(qps[i], &hisi_zip_ctx->qp_ctx[i], i,
-					req_type);
+		qp_ctx = &hisi_zip_ctx->qp_ctx[i];
+		qp_ctx->ctx = hisi_zip_ctx;
+		ret = hisi_zip_start_qp(qps[i], qp_ctx, i, req_type);
 		if (ret) {
 			for (j = i - 1; j >= 0; j--)
 				hisi_qm_stop_qp(hisi_zip_ctx->qp_ctx[j].qp);
@@ -479,9 +555,12 @@ static int hisi_zip_ctx_init(struct hisi_zip_ctx *hisi_zip_ctx, u8 req_type, int
 			return ret;
 		}
 
-		hisi_zip_ctx->qp_ctx[i].zip_dev = hisi_zip;
+		qp_ctx->zip_dev = hisi_zip;
 	}
 
+	if (hisi_zip->qm.ver < QM_HW_V3)
+		hisi_zip_ctx->ops = &hisi_zip_ops_v1;
+
 	return 0;
 }
 
-- 
2.7.4

