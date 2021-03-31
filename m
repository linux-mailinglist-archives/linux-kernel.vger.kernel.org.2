Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3234B506
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 08:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhC0HcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 03:32:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14159 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhC0Hba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 03:31:30 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6r785sVMzndkV;
        Sat, 27 Mar 2021 15:28:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 15:31:20 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH v2 2/4] crypto: hisilicon/zip - add comments for 'hisi_zip_sqe'
Date:   Sat, 27 Mar 2021 15:28:46 +0800
Message-ID: <1616830128-46827-3-git-send-email-shenyang39@huawei.com>
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

Some fields of 'hisi_zip_sqe' are unused, and some fields have misc
utilities. So add comments for used fields and make others unnamed.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip.h        | 45 ++++++++++++++++++++++---------
 drivers/crypto/hisilicon/zip/zip_crypto.c |  4 +--
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index 9ed7461..b4d3e03 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -33,31 +33,50 @@ struct hisi_zip_sqe {
 	u32 consumed;
 	u32 produced;
 	u32 comp_data_length;
+	/*
+	 * status: 0~7 bits
+	 * rsvd: 8~31 bits
+	 */
 	u32 dw3;
 	u32 input_data_length;
-	u32 lba_l;
-	u32 lba_h;
+	u32 dw5;
+	u32 dw6;
+	/*
+	 * in_sge_data_offset: 0~23 bits
+	 * rsvd: 24~27 bits
+	 * sqe_type: 29~31 bits
+	 */
 	u32 dw7;
+	/*
+	 * out_sge_data_offset: 0~23 bits
+	 * rsvd: 24~31 bits
+	 */
 	u32 dw8;
+	/*
+	 * request_type: 0~7 bits
+	 * buffer_type: 8~11 bits
+	 * rsvd: 13~31 bits
+	 */
 	u32 dw9;
 	u32 dw10;
-	u32 priv_info;
+	u32 dw11;
 	u32 dw12;
-	u32 tag;
+	/* tag: in sqe type 0 */
+	u32 dw13;
 	u32 dest_avail_out;
-	u32 rsvd0;
-	u32 comp_head_addr_l;
-	u32 comp_head_addr_h;
+	u32 dw15;
+	u32 dw16;
+	u32 dw17;
 	u32 source_addr_l;
 	u32 source_addr_h;
 	u32 dest_addr_l;
 	u32 dest_addr_h;
-	u32 stream_ctx_addr_l;
-	u32 stream_ctx_addr_h;
-	u32 cipher_key1_addr_l;
-	u32 cipher_key1_addr_h;
-	u32 cipher_key2_addr_l;
-	u32 cipher_key2_addr_h;
+	u32 dw22;
+	u32 dw23;
+	u32 dw24;
+	u32 dw25;
+	u32 dw26;
+	u32 dw27;
 	u32 rsvd1[4];
 };
 
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 989b273..3bc2148 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -253,7 +253,7 @@ static void hisi_zip_config_buf_type(struct hisi_zip_sqe *sqe, u8 buf_type)
 
 static void hisi_zip_config_tag(struct hisi_zip_sqe *sqe, u32 tag)
 {
-	sqe->tag = tag;
+	sqe->dw13 = tag;
 }
 
 static void hisi_zip_fill_sqe(struct hisi_zip_sqe *sqe, u8 req_type,
@@ -339,7 +339,7 @@ static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
 	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
 	struct device *dev = &qp->qm->pdev->dev;
 	struct hisi_zip_sqe *sqe = data;
-	struct hisi_zip_req *req = req_q->q + sqe->tag;
+	struct hisi_zip_req *req = req_q->q + sqe->dw13;
 	struct acomp_req *acomp_req = req->req;
 	u32 status, dlen, head_size;
 	int err = 0;
-- 
2.8.1

