Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2A3A6721
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhFNMx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233804AbhFNMxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:53:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED602613DB;
        Mon, 14 Jun 2021 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623675077;
        bh=ZCyLQNKBL6qfNjmqZPGN2q1VeUEjRPXI8d8IwX2ibao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ju1vtDIASVv2o2096e9eMjhyjI1ygTyynNOts7wnjo7KATYprHWL4mkl8jEby2TjW
         pH6KI2ZWbg0o8qbZsp911gmbE8xR2pcr1RzxXw/sZ1PTFxrF6u5b9prn3VpsayRcvY
         2VPn4tJW4QpR+rghI46nZe3sFmWsiyfMYYeniBHuc6pX9pcKHF1XVLKeMvY06BtN2Z
         NSZ2MIk3fDDXqgyrgcawDtVBJFgvrRrP4553lr9EcoRIyM8MfHLR/V7EOZAKTN76Cz
         V13FapxggLouf0HNitjHk1WKWna+GXUjmqDJ+Ec0Pe07oLkVRF9JIgaHuVyw+c1rD2
         bMGUZw6mMWStA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 9/9] habanalabs/gaudi: print last QM PQEs on error
Date:   Mon, 14 Jun 2021 15:51:00 +0300
Message-Id: <20210614125100.17627-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614125100.17627-1-ogabbay@kernel.org>
References: <20210614125100.17627-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

In case QMAN has an error and stop_on_err is true, print specific
information of the "offending" command buffer batch.

If the error occurred on one of the higher CPs, the CQ pointer and size
will be printed along with (up to) last 8 PQEs of the stream.

If the error occurred in the lower CP, the CQ pointer and size will be
printed along with (up to) last 8 PQEs of ALL upper CPs as we have no
way to know which upper CP sent the job there.

This is done so higher SW levels will be able to debug their CS by
extracting the raw data of the offending command buffer batch and
examine those offline to detect the issue.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c  | 218 ++++++++++++++++++++-----
 drivers/misc/habanalabs/gaudi/gaudiP.h |   1 +
 2 files changed, 182 insertions(+), 37 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e66433d05616..a673e404f777 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7157,14 +7157,158 @@ static int gaudi_extract_ecc_info(struct hl_device *hdev,
 	return rc;
 }
 
+/*
+ * gaudi_queue_idx_dec - decrement queue index (pi/ci) and handle wrap
+ *
+ * @idx: the current pi/ci value
+ * @q_len: the queue length (power of 2)
+ *
+ * @return the cyclically decremented index
+ */
+static inline u32 gaudi_queue_idx_dec(u32 idx, u32 q_len)
+{
+	u32 mask = q_len - 1;
+
+	/*
+	 * modular decrement is equivalent to adding (queue_size -1)
+	 * later we take LSBs to make sure the value is in the
+	 * range [0, queue_len - 1]
+	 */
+	return (idx + q_len - 1) & mask;
+}
+
+/**
+ * gaudi_print_sw_config_stream_data - print SW config stream data
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @stream: the QMAN's stream
+ * @qman_base: base address of QMAN registers block
+ */
+static void gaudi_print_sw_config_stream_data(struct hl_device *hdev, u32 stream,
+						u64 qman_base)
+{
+	u64 cq_ptr_lo, cq_ptr_hi, cq_tsize, cq_ptr;
+	u32 cq_ptr_lo_off, size;
+
+	cq_ptr_lo_off = mmTPC0_QM_CQ_PTR_LO_1 - mmTPC0_QM_CQ_PTR_LO_0;
+
+	cq_ptr_lo = qman_base + (mmTPC0_QM_CQ_PTR_LO_0 - mmTPC0_QM_BASE) +
+						stream * cq_ptr_lo_off;
+	cq_ptr_hi = cq_ptr_lo +
+				(mmTPC0_QM_CQ_PTR_HI_0 - mmTPC0_QM_CQ_PTR_LO_0);
+	cq_tsize = cq_ptr_lo +
+				(mmTPC0_QM_CQ_TSIZE_0 - mmTPC0_QM_CQ_PTR_LO_0);
+
+	cq_ptr = (((u64) RREG32(cq_ptr_hi)) << 32) | RREG32(cq_ptr_lo);
+	size = RREG32(cq_tsize);
+	dev_info(hdev->dev, "stop on err: stream: %u, addr: %#llx, size: %x\n",
+							stream, cq_ptr, size);
+}
+
+/**
+ * gaudi_print_last_pqes_on_err - print last PQEs on error
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @qid_base: first QID of the QMAN (out of 4 streams)
+ * @stream: the QMAN's stream
+ * @qman_base: base address of QMAN registers block
+ * @pr_sw_conf: if true print the SW config stream data (CQ PTR and SIZE)
+ */
+static void gaudi_print_last_pqes_on_err(struct hl_device *hdev, u32 qid_base,
+						u32 stream, u64 qman_base,
+						bool pr_sw_conf)
+{
+	u32 ci, qm_ci_stream_off, queue_len;
+	struct hl_hw_queue *q;
+	u64 pq_ci;
+	int i;
+
+	q = &hdev->kernel_queues[qid_base + stream];
+
+	qm_ci_stream_off = mmTPC0_QM_PQ_CI_1 - mmTPC0_QM_PQ_CI_0;
+	pq_ci = qman_base + (mmTPC0_QM_PQ_CI_0 - mmTPC0_QM_BASE) +
+						stream * qm_ci_stream_off;
+
+	queue_len = (q->queue_type == QUEUE_TYPE_INT) ?
+					q->int_queue_len : HL_QUEUE_LENGTH;
+
+	hdev->asic_funcs->hw_queues_lock(hdev);
+
+	if (pr_sw_conf)
+		gaudi_print_sw_config_stream_data(hdev, stream, qman_base);
+
+	ci = RREG32(pq_ci);
+
+	/* we should start printing form ci -1 */
+	ci = gaudi_queue_idx_dec(ci, queue_len);
+
+	for (i = 0; i < PQ_FETCHER_CACHE_SIZE; i++) {
+		struct hl_bd *bd;
+		u64 addr;
+		u32 len;
+
+		bd = q->kernel_address;
+		bd += ci;
+
+		len = le32_to_cpu(bd->len);
+		/* len 0 means uninitialized entry- break */
+		if (!len)
+			break;
+
+		addr = le64_to_cpu(bd->ptr);
+
+		dev_info(hdev->dev, "stop on err PQE(stream %u): ci: %u, addr: %#llx, size: %x\n",
+							stream, ci, addr, len);
+
+		/* get previous ci, wrap if needed */
+		ci = gaudi_queue_idx_dec(ci, queue_len);
+	}
+
+	hdev->asic_funcs->hw_queues_unlock(hdev);
+}
+
+/**
+ * print_qman_data_on_err - extract QMAN data on error
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @qid_base: first QID of the QMAN (out of 4 streams)
+ * @stream: the QMAN's stream
+ * @qman_base: base address of QMAN registers block
+ *
+ * This function attempt to exatract as much data as possible on QMAN error.
+ * On upper CP print the SW config stream data and last 8 PQEs.
+ * On lower CP print SW config data and last PQEs of ALL 4 upper CPs
+ */
+static void print_qman_data_on_err(struct hl_device *hdev, u32 qid_base,
+						u32 stream, u64 qman_base)
+{
+	u32 i;
+
+	if (stream != QMAN_STREAMS) {
+		gaudi_print_last_pqes_on_err(hdev, qid_base, stream, qman_base,
+									true);
+		return;
+	}
+
+	gaudi_print_sw_config_stream_data(hdev, stream, qman_base);
+
+	for (i = 0; i < QMAN_STREAMS; i++)
+		gaudi_print_last_pqes_on_err(hdev, qid_base, i, qman_base,
+									false);
+}
+
 static void gaudi_handle_qman_err_generic(struct hl_device *hdev,
 					  const char *qm_name,
-					  u64 glbl_sts_addr,
-					  u64 arb_err_addr)
+					  u64 qman_base,
+					  u32 qid_base)
 {
 	u32 i, j, glbl_sts_val, arb_err_val, glbl_sts_clr_val;
+	u64 glbl_sts_addr, arb_err_addr;
 	char reg_desc[32];
 
+	glbl_sts_addr = qman_base + (mmTPC0_QM_GLBL_STS1_0 - mmTPC0_QM_BASE);
+	arb_err_addr = qman_base + (mmTPC0_QM_ARB_ERR_CAUSE - mmTPC0_QM_BASE);
+
 	/* Iterate through all stream GLBL_STS1 registers + Lower CP */
 	for (i = 0 ; i < QMAN_STREAMS + 1 ; i++) {
 		glbl_sts_clr_val = 0;
@@ -7191,6 +7335,8 @@ static void gaudi_handle_qman_err_generic(struct hl_device *hdev,
 		/* Write 1 clear errors */
 		if (!hdev->stop_on_err)
 			WREG32(glbl_sts_addr + 4 * i, glbl_sts_clr_val);
+		else
+			print_qman_data_on_err(hdev, qid_base, i, qman_base);
 	}
 
 	arb_err_val = RREG32(arb_err_addr);
@@ -7335,90 +7481,88 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 
 static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type)
 {
-	u64 glbl_sts_addr, arb_err_addr;
-	u8 index;
+	u64 qman_base;
 	char desc[32];
+	u32 qid_base;
+	u8 index;
 
 	switch (event_type) {
 	case GAUDI_EVENT_TPC0_QM ... GAUDI_EVENT_TPC7_QM:
 		index = event_type - GAUDI_EVENT_TPC0_QM;
-		glbl_sts_addr =
-			mmTPC0_QM_GLBL_STS1_0 + index * TPC_QMAN_OFFSET;
-		arb_err_addr =
-			mmTPC0_QM_ARB_ERR_CAUSE + index * TPC_QMAN_OFFSET;
+		qid_base = GAUDI_QUEUE_ID_TPC_0_0 + index * QMAN_STREAMS;
+		qman_base = mmTPC0_QM_BASE + index * TPC_QMAN_OFFSET;
 		snprintf(desc, ARRAY_SIZE(desc), "%s%d", "TPC_QM", index);
 		break;
 	case GAUDI_EVENT_MME0_QM ... GAUDI_EVENT_MME2_QM:
 		index = event_type - GAUDI_EVENT_MME0_QM;
-		glbl_sts_addr =
-			mmMME0_QM_GLBL_STS1_0 + index * MME_QMAN_OFFSET;
-		arb_err_addr =
-			mmMME0_QM_ARB_ERR_CAUSE + index * MME_QMAN_OFFSET;
+		qid_base = GAUDI_QUEUE_ID_MME_0_0 + index * QMAN_STREAMS;
+		qman_base = mmMME0_QM_BASE + index * MME_QMAN_OFFSET;
 		snprintf(desc, ARRAY_SIZE(desc), "%s%d", "MME_QM", index);
 		break;
 	case GAUDI_EVENT_DMA0_QM ... GAUDI_EVENT_DMA7_QM:
 		index = event_type - GAUDI_EVENT_DMA0_QM;
-		glbl_sts_addr =
-			mmDMA0_QM_GLBL_STS1_0 + index * DMA_QMAN_OFFSET;
-		arb_err_addr =
-			mmDMA0_QM_ARB_ERR_CAUSE + index * DMA_QMAN_OFFSET;
+		qid_base = GAUDI_QUEUE_ID_DMA_0_0 + index * QMAN_STREAMS;
+		/* skip GAUDI_QUEUE_ID_CPU_PQ if necessary */
+		if (index > 1)
+			qid_base++;
+		qman_base = mmDMA0_QM_BASE + index * DMA_QMAN_OFFSET;
 		snprintf(desc, ARRAY_SIZE(desc), "%s%d", "DMA_QM", index);
 		break;
 	case GAUDI_EVENT_NIC0_QM0:
-		glbl_sts_addr = mmNIC0_QM0_GLBL_STS1_0;
-		arb_err_addr = mmNIC0_QM0_ARB_ERR_CAUSE;
+		qid_base = GAUDI_QUEUE_ID_NIC_0_0;
+		qman_base = mmNIC0_QM0_BASE;
 		snprintf(desc, ARRAY_SIZE(desc), "NIC0_QM0");
 		break;
 	case GAUDI_EVENT_NIC0_QM1:
-		glbl_sts_addr = mmNIC0_QM1_GLBL_STS1_0;
-		arb_err_addr = mmNIC0_QM1_ARB_ERR_CAUSE;
+		qid_base = GAUDI_QUEUE_ID_NIC_1_0;
+		qman_base = mmNIC0_QM1_BASE;
 		snprintf(desc, ARRAY_SIZE(desc), "NIC0_QM1");
 		break;
 	case GAUDI_EVENT_NIC1_QM0:
-		glbl_sts_addr = mmNIC1_QM0_GLBL_STS1_0;
-		arb_err_addr = mmNIC1_QM0_ARB_ERR_CAUSE;
+		qid_base = GAUDI_QUEUE_ID_NIC_2_0;
+		qman_base = mmNIC1_QM0_BASE;
 		snprintf(desc, ARRAY_SIZE(desc), "NIC1_QM0");
 		break;
 	case GAUDI_EVENT_NIC1_QM1:
-		glbl_sts_addr = mmNIC1_QM1_GLBL_STS1_0;
-		arb_err_addr = mmNIC1_QM1_ARB_ERR_CAUSE;
+		qid_base = GAUDI_QUEUE_ID_NIC_3_0;
+		qman_base = mmNIC1_QM1_BASE;
 		snprintf(desc, ARRAY_SIZE(desc), "NIC1_QM1");
 		break;
 	case GAUDI_EVENT_NIC2_QM0:
-		glbl_sts_addr = mmNIC2_QM0_GLBL_STS1_0;
-		arb_err_addr = mmNIC2_QM0_ARB_ERR_CAUSE;
+		qid_base = GAUDI_QUEUE_ID_NIC_4_0;
+		qman_base = mmNIC2_QM0_BASE;
 		snprintf(desc, ARRAY_SIZE(desc), "NIC2_QM0");
 		break;
 	case GAUDI_EVENT_NIC2_QM1:
-		glbl_sts_addr = mmNIC2_QM1_GLBL_STS1_0;
-		arb_err_addr = mmNIC2_QM1_ARB_ERR_CAUSE;
+		qid_base = GAUDI_QUEUE_ID_NIC_5_0;
+		qman_base = mmNIC2_QM1_BASE;
 		snprintf(desc, ARRAY_SIZE(desc), "NIC2_QM1");
 		break;
 	case GAUDI_EVENT_NIC3_QM0:
-		glbl_sts_addr = mmNIC3_QM0_GLBL_STS1_0;
-		arb_err_addr = mmNIC3_QM0_ARB_ERR_CAUSE;
+		qid_base = GAUDI_QUEUE_ID_NIC_6_0;
+		qman_base = mmNIC3_QM0_BASE;
 		snprintf(desc, ARRAY_SIZE(desc), "NIC3_QM0");
 		break;
 	case GAUDI_EVENT_NIC3_QM1:
-		glbl_sts_addr = mmNIC3_QM1_GLBL_STS1_0;
-		arb_err_addr = mmNIC3_QM1_ARB_ERR_CAUSE;
+		qid_base = GAUDI_QUEUE_ID_NIC_7_0;
+		qman_base = mmNIC3_QM1_BASE;
 		snprintf(desc, ARRAY_SIZE(desc), "NIC3_QM1");
 		break;
 	case GAUDI_EVENT_NIC4_QM0:
-		glbl_sts_addr = mmNIC4_QM0_GLBL_STS1_0;
-		arb_err_addr = mmNIC4_QM0_ARB_ERR_CAUSE;
+		qid_base = GAUDI_QUEUE_ID_NIC_8_0;
+		qman_base = mmNIC4_QM0_BASE;
 		snprintf(desc, ARRAY_SIZE(desc), "NIC4_QM0");
 		break;
 	case GAUDI_EVENT_NIC4_QM1:
-		glbl_sts_addr = mmNIC4_QM1_GLBL_STS1_0;
-		arb_err_addr = mmNIC4_QM1_ARB_ERR_CAUSE;
+		qid_base = GAUDI_QUEUE_ID_NIC_9_0;
+		qman_base = mmNIC4_QM1_BASE;
 		snprintf(desc, ARRAY_SIZE(desc), "NIC4_QM1");
 		break;
 	default:
 		return;
 	}
 
-	gaudi_handle_qman_err_generic(hdev, desc, glbl_sts_addr, arb_err_addr);
+	gaudi_handle_qman_err_generic(hdev, desc, qman_base, qid_base);
 }
 
 static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 48637a6343bb..b23336af191e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -82,6 +82,7 @@
 					QMAN_STREAMS)
 
 #define QMAN_STREAMS		4
+#define PQ_FETCHER_CACHE_SIZE	8
 
 #define DMA_QMAN_OFFSET		(mmDMA1_QM_BASE - mmDMA0_QM_BASE)
 #define TPC_QMAN_OFFSET		(mmTPC1_QM_BASE - mmTPC0_QM_BASE)
-- 
2.25.1

