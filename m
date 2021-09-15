Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F1340C329
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhIOJ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:59:50 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:34322 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbhIOJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:59:24 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Sep 2021 02:58:06 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Sep 2021 02:58:04 -0700
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 15 Sep 2021 15:28:03 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id C0D9622353; Wed, 15 Sep 2021 15:28:01 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH 2/3] mtd: rawnand: qcom: Add sg list to handle status pipe request
Date:   Wed, 15 Sep 2021 15:27:30 +0530
Message-Id: <1631699851-12172-3-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From QPIC V2.0 onwards there is separate pipe to read status
for each code word while reading in enhanced mode. page scope
read and multi page read.

This sgl list will be use to handle the request via status pipe
during page scope and multi page read.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 42c6291..07448c4 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -213,6 +213,7 @@ nandc_set_reg(chip, reg,			\
 #define QPIC_PER_CW_CMD_ELEMENTS	32
 #define QPIC_PER_CW_CMD_SGL		32
 #define QPIC_PER_CW_DATA_SGL		8
+#define	QPIC_PER_CW_STS_SGL		8
 
 #define QPIC_NAND_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)
 
@@ -258,6 +259,7 @@ struct bam_transaction {
 	struct bam_cmd_element *bam_ce;
 	struct scatterlist *cmd_sgl;
 	struct scatterlist *data_sgl;
+	struct scatterlist *sts_sgl;
 	u32 bam_ce_pos;
 	u32 bam_ce_start;
 	u32 cmd_sgl_pos;
@@ -266,6 +268,8 @@ struct bam_transaction {
 	u32 tx_sgl_start;
 	u32 rx_sgl_pos;
 	u32 rx_sgl_start;
+	u32 sts_sgl_pos;
+	u32 sts_sgl_start;
 	bool wait_second_completion;
 	struct completion txn_done;
 	struct dma_async_tx_descriptor *last_data_desc;
@@ -508,6 +512,8 @@ alloc_bam_transaction(struct qcom_nand_controller *nandc)
 		((sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS) +
 		(sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL) +
 		(sizeof(*bam_txn->data_sgl) * QPIC_PER_CW_DATA_SGL));
+	if (nandc->props->qpic_v2)
+		bam_txn_size += (sizeof(*bam_txn->sts_sgl) * QPIC_PER_CW_STS_SGL);
 
 	bam_txn_buf = devm_kzalloc(nandc->dev, bam_txn_size, GFP_KERNEL);
 	if (!bam_txn_buf)
@@ -526,6 +532,12 @@ alloc_bam_transaction(struct qcom_nand_controller *nandc)
 
 	bam_txn->data_sgl = bam_txn_buf;
 
+	if (nandc->props->qpic_v2) {
+		bam_txn_buf +=
+			sizeof(*bam_txn->sts_sgl) * QPIC_PER_CW_STS_SGL * num_cw;
+		bam_txn->sts_sgl = bam_txn_buf;
+	}
+
 	init_completion(&bam_txn->txn_done);
 
 	return bam_txn;
@@ -554,6 +566,12 @@ static void clear_bam_transaction(struct qcom_nand_controller *nandc)
 		      QPIC_PER_CW_CMD_SGL);
 	sg_init_table(bam_txn->data_sgl, nandc->max_cwperpage *
 		      QPIC_PER_CW_DATA_SGL);
+	if (nandc->props->qpic_v2) {
+		bam_txn->sts_sgl_pos = 0;
+		bam_txn->sts_sgl_start = 0;
+		sg_init_table(bam_txn->sts_sgl, nandc->max_cwperpage *
+				QPIC_PER_CW_STS_SGL);
+	}
 
 	reinit_completion(&bam_txn->txn_done);
 }
@@ -808,6 +826,12 @@ static int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
 		bam_txn->tx_sgl_start = bam_txn->tx_sgl_pos;
 		dir_eng = DMA_MEM_TO_DEV;
 		desc->dir = DMA_TO_DEVICE;
+	} else if (nandc->props->qpic_v2 && chan == nandc->sts_chan) {
+		sgl = &bam_txn->sts_sgl[bam_txn->sts_sgl_start];
+		sgl_cnt = bam_txn->sts_sgl_pos - bam_txn->sts_sgl_start;
+		bam_txn->sts_sgl_start = bam_txn->sts_sgl_pos;
+		dir_eng = DMA_DEV_TO_MEM;
+		desc->dir = DMA_FROM_DEVICE;
 	} else {
 		sgl = &bam_txn->data_sgl[bam_txn->rx_sgl_start];
 		sgl_cnt = bam_txn->rx_sgl_pos - bam_txn->rx_sgl_start;
@@ -1394,6 +1418,14 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 			if (r)
 				return r;
 		}
+
+		if (nandc->props->qpic_v2) {
+			if (bam_txn->sts_sgl_pos > bam_txn->sts_sgl_start) {
+				r = prepare_bam_async_desc(nandc, nandc->sts_chan, 0);
+				if (r)
+					return r;
+			}
+		}
 	}
 
 	list_for_each_entry(desc, &nandc->desc_list, node)
@@ -1411,6 +1443,8 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 		dma_async_issue_pending(nandc->tx_chan);
 		dma_async_issue_pending(nandc->rx_chan);
 		dma_async_issue_pending(nandc->cmd_chan);
+		if (nandc->props->qpic_v2)
+			dma_async_issue_pending(nandc->sts_chan);
 
 		if (!wait_for_completion_timeout(&bam_txn->txn_done,
 						 QPIC_NAND_COMPLETION_TIMEOUT))
-- 
2.7.4

