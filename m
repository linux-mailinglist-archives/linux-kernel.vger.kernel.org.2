Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF3C34B507
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 08:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhC0HcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 03:32:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14160 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhC0Hba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 03:31:30 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6r7863TCzndlD;
        Sat, 27 Mar 2021 15:28:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 15:31:20 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH v2 1/4] crypto: hisilicon/zip - adjust functions location
Date:   Sat, 27 Mar 2021 15:28:45 +0800
Message-ID: <1616830128-46827-2-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616830128-46827-1-git-send-email-shenyang39@huawei.com>
References: <1616830128-46827-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes nothing about functions except location in order to make
code logic clearly.

This adjustment follows three principles:
1.The called functions are listed in order above the calling functions.
2.The paired functions are next to each other.
3.Logically similar functions are placed in the same area. Here, we use
the callback of 'acomp_alg' as the basis for dividing areas.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 564 +++++++++++++++---------------
 1 file changed, 282 insertions(+), 282 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 41f6966..989b273 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -119,6 +119,129 @@ static u16 sgl_sge_nr = HZIP_SGL_SGE_NR;
 module_param_cb(sgl_sge_nr, &sgl_sge_nr_ops, &sgl_sge_nr, 0444);
 MODULE_PARM_DESC(sgl_sge_nr, "Number of sge in sgl(1-255)");
 
+static u16 get_extra_field_size(const u8 *start)
+{
+	return *((u16 *)start) + GZIP_HEAD_FEXTRA_XLEN;
+}
+
+static u32 get_name_field_size(const u8 *start)
+{
+	return strlen(start) + 1;
+}
+
+static u32 get_comment_field_size(const u8 *start)
+{
+	return strlen(start) + 1;
+}
+
+static u32 __get_gzip_head_size(const u8 *src)
+{
+	u8 head_flg = *(src + GZIP_HEAD_FLG_SHIFT);
+	u32 size = GZIP_HEAD_FEXTRA_SHIFT;
+
+	if (head_flg & GZIP_HEAD_FEXTRA_BIT)
+		size += get_extra_field_size(src + size);
+	if (head_flg & GZIP_HEAD_FNAME_BIT)
+		size += get_name_field_size(src + size);
+	if (head_flg & GZIP_HEAD_FCOMMENT_BIT)
+		size += get_comment_field_size(src + size);
+	if (head_flg & GZIP_HEAD_FHCRC_BIT)
+		size += GZIP_HEAD_FHCRC_SIZE;
+
+	return size;
+}
+
+static size_t __maybe_unused get_gzip_head_size(struct scatterlist *sgl)
+{
+	char buf[HZIP_GZIP_HEAD_BUF];
+
+	sg_copy_to_buffer(sgl, sg_nents(sgl), buf, sizeof(buf));
+
+	return __get_gzip_head_size(buf);
+}
+
+static int add_comp_head(struct scatterlist *dst, u8 req_type)
+{
+	int head_size = TO_HEAD_SIZE(req_type);
+	const u8 *head = TO_HEAD(req_type);
+	int ret;
+
+	ret = sg_copy_from_buffer(dst, sg_nents(dst), head, head_size);
+	if (ret != head_size) {
+		pr_err("the head size of buffer is wrong (%d)!\n", ret);
+		return -ENOMEM;
+	}
+
+	return head_size;
+}
+
+static int get_comp_head_size(struct acomp_req *acomp_req, u8 req_type)
+{
+	if (!acomp_req->src || !acomp_req->slen)
+		return -EINVAL;
+
+	if (req_type == HZIP_ALG_TYPE_GZIP &&
+	    acomp_req->slen < GZIP_HEAD_FEXTRA_SHIFT)
+		return -EINVAL;
+
+	switch (req_type) {
+	case HZIP_ALG_TYPE_ZLIB:
+		return TO_HEAD_SIZE(HZIP_ALG_TYPE_ZLIB);
+	case HZIP_ALG_TYPE_GZIP:
+		return TO_HEAD_SIZE(HZIP_ALG_TYPE_GZIP);
+	default:
+		pr_err("request type does not support!\n");
+		return -EINVAL;
+	}
+}
+
+static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
+						struct hisi_zip_qp_ctx *qp_ctx,
+						size_t head_size, bool is_comp)
+{
+	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
+	struct hisi_zip_req *q = req_q->q;
+	struct hisi_zip_req *req_cache;
+	int req_id;
+
+	write_lock(&req_q->req_lock);
+
+	req_id = find_first_zero_bit(req_q->req_bitmap, req_q->size);
+	if (req_id >= req_q->size) {
+		write_unlock(&req_q->req_lock);
+		dev_dbg(&qp_ctx->qp->qm->pdev->dev, "req cache is full!\n");
+		return ERR_PTR(-EAGAIN);
+	}
+	set_bit(req_id, req_q->req_bitmap);
+
+	req_cache = q + req_id;
+	req_cache->req_id = req_id;
+	req_cache->req = req;
+
+	if (is_comp) {
+		req_cache->sskip = 0;
+		req_cache->dskip = head_size;
+	} else {
+		req_cache->sskip = head_size;
+		req_cache->dskip = 0;
+	}
+
+	write_unlock(&req_q->req_lock);
+
+	return req_cache;
+}
+
+static void hisi_zip_remove_req(struct hisi_zip_qp_ctx *qp_ctx,
+				struct hisi_zip_req *req)
+{
+	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
+
+	write_lock(&req_q->req_lock);
+	clear_bit(req->req_id, req_q->req_bitmap);
+	memset(req, 0, sizeof(struct hisi_zip_req));
+	write_unlock(&req_q->req_lock);
+}
+
 static void hisi_zip_config_buf_type(struct hisi_zip_sqe *sqe, u8 buf_type)
 {
 	u32 val;
@@ -150,6 +273,159 @@ static void hisi_zip_fill_sqe(struct hisi_zip_sqe *sqe, u8 req_type,
 	sqe->dest_addr_h = upper_32_bits(d_addr);
 }
 
+static int hisi_zip_do_work(struct hisi_zip_req *req,
+			    struct hisi_zip_qp_ctx *qp_ctx)
+{
+	struct hisi_acc_sgl_pool *pool = qp_ctx->sgl_pool;
+	struct hisi_zip_dfx *dfx = &qp_ctx->zip_dev->dfx;
+	struct acomp_req *a_req = req->req;
+	struct hisi_qp *qp = qp_ctx->qp;
+	struct device *dev = &qp->qm->pdev->dev;
+	struct hisi_zip_sqe zip_sqe;
+	dma_addr_t input, output;
+	int ret;
+
+	if (!a_req->src || !a_req->slen || !a_req->dst || !a_req->dlen)
+		return -EINVAL;
+
+	req->hw_src = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->src, pool,
+						    req->req_id << 1, &input);
+	if (IS_ERR(req->hw_src)) {
+		dev_err(dev, "failed to map the src buffer to hw sgl (%ld)!\n",
+			PTR_ERR(req->hw_src));
+		return PTR_ERR(req->hw_src);
+	}
+	req->dma_src = input;
+
+	req->hw_dst = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->dst, pool,
+						    (req->req_id << 1) + 1,
+						    &output);
+	if (IS_ERR(req->hw_dst)) {
+		ret = PTR_ERR(req->hw_dst);
+		dev_err(dev, "failed to map the dst buffer to hw slg (%d)!\n",
+			ret);
+		goto err_unmap_input;
+	}
+	req->dma_dst = output;
+
+	hisi_zip_fill_sqe(&zip_sqe, qp->req_type, input, output, a_req->slen,
+			  a_req->dlen, req->sskip, req->dskip);
+	hisi_zip_config_buf_type(&zip_sqe, HZIP_SGL);
+	hisi_zip_config_tag(&zip_sqe, req->req_id);
+
+	/* send command to start a task */
+	atomic64_inc(&dfx->send_cnt);
+	ret = hisi_qp_send(qp, &zip_sqe);
+	if (ret < 0) {
+		atomic64_inc(&dfx->send_busy_cnt);
+		ret = -EAGAIN;
+		dev_dbg_ratelimited(dev, "failed to send request!\n");
+		goto err_unmap_output;
+	}
+
+	return -EINPROGRESS;
+
+err_unmap_output:
+	hisi_acc_sg_buf_unmap(dev, a_req->dst, req->hw_dst);
+err_unmap_input:
+	hisi_acc_sg_buf_unmap(dev, a_req->src, req->hw_src);
+	return ret;
+}
+
+static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
+{
+	struct hisi_zip_qp_ctx *qp_ctx = qp->qp_ctx;
+	struct hisi_zip_dfx *dfx = &qp_ctx->zip_dev->dfx;
+	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
+	struct device *dev = &qp->qm->pdev->dev;
+	struct hisi_zip_sqe *sqe = data;
+	struct hisi_zip_req *req = req_q->q + sqe->tag;
+	struct acomp_req *acomp_req = req->req;
+	u32 status, dlen, head_size;
+	int err = 0;
+
+	atomic64_inc(&dfx->recv_cnt);
+	status = sqe->dw3 & HZIP_BD_STATUS_M;
+	if (status != 0 && status != HZIP_NC_ERR) {
+		dev_err(dev, "%scompress fail in qp%u: %u, output: %u\n",
+			(qp->alg_type == 0) ? "" : "de", qp->qp_id, status,
+			sqe->produced);
+		atomic64_inc(&dfx->err_bd_cnt);
+		err = -EIO;
+	}
+	dlen = sqe->produced;
+
+	hisi_acc_sg_buf_unmap(dev, acomp_req->src, req->hw_src);
+	hisi_acc_sg_buf_unmap(dev, acomp_req->dst, req->hw_dst);
+
+	head_size = (qp->alg_type == 0) ? TO_HEAD_SIZE(qp->req_type) : 0;
+	acomp_req->dlen = dlen + head_size;
+
+	if (acomp_req->base.complete)
+		acomp_request_complete(acomp_req, err);
+
+	hisi_zip_remove_req(qp_ctx, req);
+}
+
+static int hisi_zip_acompress(struct acomp_req *acomp_req)
+{
+	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(acomp_req->base.tfm);
+	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_COMP];
+	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
+	struct hisi_zip_req *req;
+	int head_size;
+	int ret;
+
+	/* let's output compression head now */
+	head_size = add_comp_head(acomp_req->dst, qp_ctx->qp->req_type);
+	if (head_size < 0) {
+		dev_err_ratelimited(dev, "failed to add comp head (%d)!\n",
+				    head_size);
+		return head_size;
+	}
+
+	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, true);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = hisi_zip_do_work(req, qp_ctx);
+	if (ret != -EINPROGRESS) {
+		dev_info_ratelimited(dev, "failed to do compress (%d)!\n", ret);
+		hisi_zip_remove_req(qp_ctx, req);
+	}
+
+	return ret;
+}
+
+static int hisi_zip_adecompress(struct acomp_req *acomp_req)
+{
+	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(acomp_req->base.tfm);
+	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_DECOMP];
+	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
+	struct hisi_zip_req *req;
+	int head_size, ret;
+
+	head_size = get_comp_head_size(acomp_req, qp_ctx->qp->req_type);
+	if (head_size < 0) {
+		dev_err_ratelimited(dev, "failed to get comp head size (%d)!\n",
+				    head_size);
+		return head_size;
+	}
+
+	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, false);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = hisi_zip_do_work(req, qp_ctx);
+	if (ret != -EINPROGRESS) {
+		dev_info_ratelimited(dev, "failed to do decompress (%d)!\n",
+				     ret);
+		hisi_zip_remove_req(qp_ctx, req);
+	}
+
+	return ret;
+}
+
 static int hisi_zip_start_qp(struct hisi_qp *qp, struct hisi_zip_qp_ctx *ctx,
 			     int alg_type, int req_type)
 {
@@ -207,46 +483,14 @@ static int hisi_zip_ctx_init(struct hisi_zip_ctx *hisi_zip_ctx, u8 req_type, int
 	}
 
 	return 0;
-}
-
-static void hisi_zip_ctx_exit(struct hisi_zip_ctx *hisi_zip_ctx)
-{
-	int i;
-
-	for (i = 1; i >= 0; i--)
-		hisi_zip_release_qp(&hisi_zip_ctx->qp_ctx[i]);
-}
-
-static u16 get_extra_field_size(const u8 *start)
-{
-	return *((u16 *)start) + GZIP_HEAD_FEXTRA_XLEN;
-}
-
-static u32 get_name_field_size(const u8 *start)
-{
-	return strlen(start) + 1;
-}
-
-static u32 get_comment_field_size(const u8 *start)
-{
-	return strlen(start) + 1;
-}
-
-static u32 __get_gzip_head_size(const u8 *src)
-{
-	u8 head_flg = *(src + GZIP_HEAD_FLG_SHIFT);
-	u32 size = GZIP_HEAD_FEXTRA_SHIFT;
+}
 
-	if (head_flg & GZIP_HEAD_FEXTRA_BIT)
-		size += get_extra_field_size(src + size);
-	if (head_flg & GZIP_HEAD_FNAME_BIT)
-		size += get_name_field_size(src + size);
-	if (head_flg & GZIP_HEAD_FCOMMENT_BIT)
-		size += get_comment_field_size(src + size);
-	if (head_flg & GZIP_HEAD_FHCRC_BIT)
-		size += GZIP_HEAD_FHCRC_SIZE;
+static void hisi_zip_ctx_exit(struct hisi_zip_ctx *hisi_zip_ctx)
+{
+	int i;
 
-	return size;
+	for (i = 1; i >= 0; i--)
+		hisi_zip_release_qp(&hisi_zip_ctx->qp_ctx[i]);
 }
 
 static int hisi_zip_create_req_q(struct hisi_zip_ctx *ctx)
@@ -336,52 +580,6 @@ static void hisi_zip_release_sgl_pool(struct hisi_zip_ctx *ctx)
 				       ctx->qp_ctx[i].sgl_pool);
 }
 
-static void hisi_zip_remove_req(struct hisi_zip_qp_ctx *qp_ctx,
-				struct hisi_zip_req *req)
-{
-	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
-
-	write_lock(&req_q->req_lock);
-	clear_bit(req->req_id, req_q->req_bitmap);
-	memset(req, 0, sizeof(struct hisi_zip_req));
-	write_unlock(&req_q->req_lock);
-}
-
-static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
-{
-	struct hisi_zip_sqe *sqe = data;
-	struct hisi_zip_qp_ctx *qp_ctx = qp->qp_ctx;
-	struct hisi_zip_dfx *dfx = &qp_ctx->zip_dev->dfx;
-	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
-	struct hisi_zip_req *req = req_q->q + sqe->tag;
-	struct acomp_req *acomp_req = req->req;
-	struct device *dev = &qp->qm->pdev->dev;
-	u32 status, dlen, head_size;
-	int err = 0;
-
-	atomic64_inc(&dfx->recv_cnt);
-	status = sqe->dw3 & HZIP_BD_STATUS_M;
-	if (status != 0 && status != HZIP_NC_ERR) {
-		dev_err(dev, "%scompress fail in qp%u: %u, output: %u\n",
-			(qp->alg_type == 0) ? "" : "de", qp->qp_id, status,
-			sqe->produced);
-		atomic64_inc(&dfx->err_bd_cnt);
-		err = -EIO;
-	}
-	dlen = sqe->produced;
-
-	hisi_acc_sg_buf_unmap(dev, acomp_req->src, req->hw_src);
-	hisi_acc_sg_buf_unmap(dev, acomp_req->dst, req->hw_dst);
-
-	head_size = (qp->alg_type == 0) ? TO_HEAD_SIZE(qp->req_type) : 0;
-	acomp_req->dlen = dlen + head_size;
-
-	if (acomp_req->base.complete)
-		acomp_request_complete(acomp_req, err);
-
-	hisi_zip_remove_req(qp_ctx, req);
-}
-
 static void hisi_zip_set_acomp_cb(struct hisi_zip_ctx *ctx,
 				  void (*fn)(struct hisi_qp *, void *))
 {
@@ -439,204 +637,6 @@ static void hisi_zip_acomp_exit(struct crypto_acomp *tfm)
 	hisi_zip_ctx_exit(ctx);
 }
 
-static int add_comp_head(struct scatterlist *dst, u8 req_type)
-{
-	int head_size = TO_HEAD_SIZE(req_type);
-	const u8 *head = TO_HEAD(req_type);
-	int ret;
-
-	ret = sg_copy_from_buffer(dst, sg_nents(dst), head, head_size);
-	if (ret != head_size) {
-		pr_err("the head size of buffer is wrong (%d)!\n", ret);
-		return -ENOMEM;
-	}
-
-	return head_size;
-}
-
-static size_t __maybe_unused get_gzip_head_size(struct scatterlist *sgl)
-{
-	char buf[HZIP_GZIP_HEAD_BUF];
-
-	sg_copy_to_buffer(sgl, sg_nents(sgl), buf, sizeof(buf));
-
-	return __get_gzip_head_size(buf);
-}
-
-static int  get_comp_head_size(struct acomp_req *acomp_req, u8 req_type)
-{
-	if (!acomp_req->src || !acomp_req->slen)
-		return -EINVAL;
-
-	if ((req_type == HZIP_ALG_TYPE_GZIP) &&
-	    (acomp_req->slen < GZIP_HEAD_FEXTRA_SHIFT))
-		return -EINVAL;
-
-	switch (req_type) {
-	case HZIP_ALG_TYPE_ZLIB:
-		return TO_HEAD_SIZE(HZIP_ALG_TYPE_ZLIB);
-	case HZIP_ALG_TYPE_GZIP:
-		return TO_HEAD_SIZE(HZIP_ALG_TYPE_GZIP);
-	default:
-		pr_err("request type does not support!\n");
-		return -EINVAL;
-	}
-}
-
-static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
-						struct hisi_zip_qp_ctx *qp_ctx,
-						size_t head_size, bool is_comp)
-{
-	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
-	struct hisi_zip_req *q = req_q->q;
-	struct hisi_zip_req *req_cache;
-	int req_id;
-
-	write_lock(&req_q->req_lock);
-
-	req_id = find_first_zero_bit(req_q->req_bitmap, req_q->size);
-	if (req_id >= req_q->size) {
-		write_unlock(&req_q->req_lock);
-		dev_dbg(&qp_ctx->qp->qm->pdev->dev, "req cache is full!\n");
-		return ERR_PTR(-EAGAIN);
-	}
-	set_bit(req_id, req_q->req_bitmap);
-
-	req_cache = q + req_id;
-	req_cache->req_id = req_id;
-	req_cache->req = req;
-
-	if (is_comp) {
-		req_cache->sskip = 0;
-		req_cache->dskip = head_size;
-	} else {
-		req_cache->sskip = head_size;
-		req_cache->dskip = 0;
-	}
-
-	write_unlock(&req_q->req_lock);
-
-	return req_cache;
-}
-
-static int hisi_zip_do_work(struct hisi_zip_req *req,
-			    struct hisi_zip_qp_ctx *qp_ctx)
-{
-	struct acomp_req *a_req = req->req;
-	struct hisi_qp *qp = qp_ctx->qp;
-	struct device *dev = &qp->qm->pdev->dev;
-	struct hisi_acc_sgl_pool *pool = qp_ctx->sgl_pool;
-	struct hisi_zip_dfx *dfx = &qp_ctx->zip_dev->dfx;
-	struct hisi_zip_sqe zip_sqe;
-	dma_addr_t input, output;
-	int ret;
-
-	if (!a_req->src || !a_req->slen || !a_req->dst || !a_req->dlen)
-		return -EINVAL;
-
-	req->hw_src = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->src, pool,
-						    req->req_id << 1, &input);
-	if (IS_ERR(req->hw_src)) {
-		dev_err(dev, "failed to map the src buffer to hw sgl (%ld)!\n",
-			PTR_ERR(req->hw_src));
-		return PTR_ERR(req->hw_src);
-	}
-	req->dma_src = input;
-
-	req->hw_dst = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->dst, pool,
-						    (req->req_id << 1) + 1,
-						    &output);
-	if (IS_ERR(req->hw_dst)) {
-		ret = PTR_ERR(req->hw_dst);
-		dev_err(dev, "failed to map the dst buffer to hw slg (%d)!\n",
-			ret);
-		goto err_unmap_input;
-	}
-	req->dma_dst = output;
-
-	hisi_zip_fill_sqe(&zip_sqe, qp->req_type, input, output, a_req->slen,
-			  a_req->dlen, req->sskip, req->dskip);
-	hisi_zip_config_buf_type(&zip_sqe, HZIP_SGL);
-	hisi_zip_config_tag(&zip_sqe, req->req_id);
-
-	/* send command to start a task */
-	atomic64_inc(&dfx->send_cnt);
-	ret = hisi_qp_send(qp, &zip_sqe);
-	if (ret < 0) {
-		atomic64_inc(&dfx->send_busy_cnt);
-		ret = -EAGAIN;
-		dev_dbg_ratelimited(dev, "failed to send request!\n");
-		goto err_unmap_output;
-	}
-
-	return -EINPROGRESS;
-
-err_unmap_output:
-	hisi_acc_sg_buf_unmap(dev, a_req->dst, req->hw_dst);
-err_unmap_input:
-	hisi_acc_sg_buf_unmap(dev, a_req->src, req->hw_src);
-	return ret;
-}
-
-static int hisi_zip_acompress(struct acomp_req *acomp_req)
-{
-	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(acomp_req->base.tfm);
-	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_COMP];
-	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
-	struct hisi_zip_req *req;
-	int head_size;
-	int ret;
-
-	/* let's output compression head now */
-	head_size = add_comp_head(acomp_req->dst, qp_ctx->qp->req_type);
-	if (head_size < 0) {
-		dev_err_ratelimited(dev, "failed to add comp head (%d)!\n",
-				    head_size);
-		return head_size;
-	}
-
-	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, true);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	ret = hisi_zip_do_work(req, qp_ctx);
-	if (ret != -EINPROGRESS) {
-		dev_info_ratelimited(dev, "failed to do compress (%d)!\n", ret);
-		hisi_zip_remove_req(qp_ctx, req);
-	}
-
-	return ret;
-}
-
-static int hisi_zip_adecompress(struct acomp_req *acomp_req)
-{
-	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(acomp_req->base.tfm);
-	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_DECOMP];
-	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
-	struct hisi_zip_req *req;
-	int head_size, ret;
-
-	head_size = get_comp_head_size(acomp_req, qp_ctx->qp->req_type);
-	if (head_size < 0) {
-		dev_err_ratelimited(dev, "failed to get comp head size (%d)!\n",
-				    head_size);
-		return head_size;
-	}
-
-	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, false);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	ret = hisi_zip_do_work(req, qp_ctx);
-	if (ret != -EINPROGRESS) {
-		dev_info_ratelimited(dev, "failed to do decompress (%d)!\n",
-				     ret);
-		hisi_zip_remove_req(qp_ctx, req);
-	}
-
-	return ret;
-}
-
 static struct acomp_alg hisi_zip_acomp_zlib = {
 	.init			= hisi_zip_acomp_init,
 	.exit			= hisi_zip_acomp_exit,
-- 
2.8.1

