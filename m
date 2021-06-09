Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867113A187C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbhFIPGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238198AbhFIPFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:05:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AF8A613BC;
        Wed,  9 Jun 2021 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623251030;
        bh=vaE+FddgClLJ25K1KHB3A5GF27jyOTjefTyyycBpqY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=klx8xJxRDLEL5Y30LsnoIlKv9UthCeqZpVQm8sea2lQ6gFCNbKkkJf9syRhRSSQHi
         a5VbpZTObZDlo/TIXezTuLxCjXOnwS06ki4ZMhpk9UP5vH4j6tqEI+lQcMGGpANRuQ
         4M3bFL7heWbMoe8e6M+BvRYWNBdv3CUL+BU7UhqXzDQR1eD7fux+RpqPr5zgPAvezf
         WN0mPa7pzLtxDbzBU5KHl8U46fqsNvu9ebB7zYihv2Xrlio6ZndcjS78gJG5r7hrvA
         jBdrUVv+wyRbXFr+dJWrCULGT/gtc5RuSONOxgbrSzujFoLgDbqufu/I1hsxl0ecR8
         ixIiLha8fcBYw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 3/7] habanalabs: report EQ fault during heartbeat
Date:   Wed,  9 Jun 2021 18:03:39 +0300
Message-Id: <20210609150343.4712-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609150343.4712-1-ogabbay@kernel.org>
References: <20210609150343.4712-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

In case we have EQ fault we would like to know about it.
For this, a status bitmask was added in which EQ_FAULT bit is
set by FW in case of EQ fault.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  |  8 +++++++-
 .../misc/habanalabs/include/common/cpucp_if.h | 20 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 9412e6707906..d5a3c786d4c9 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -362,7 +362,7 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 
 int hl_fw_send_heartbeat(struct hl_device *hdev)
 {
-	struct cpucp_packet hb_pkt = {};
+	struct cpucp_packet hb_pkt = {0};
 	u64 result;
 	int rc;
 
@@ -374,7 +374,13 @@ int hl_fw_send_heartbeat(struct hl_device *hdev)
 						sizeof(hb_pkt), 0, &result);
 
 	if ((rc) || (result != CPUCP_PACKET_FENCE_VAL))
+		return -EIO;
+
+	if (le32_to_cpu(hb_pkt.status_mask) &
+					CPUCP_PKT_HB_STATUS_EQ_FAULT_MASK) {
+		dev_warn(hdev->dev, "FW reported EQ fault during heartbeat\n");
 		rc = -EIO;
+	}
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index d4dc189a6c92..80b1d5a9d9f1 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -404,6 +404,20 @@ enum cpucp_packet_id {
 #define CPUCP_PKT_RES_PLL_OUT3_SHIFT	48
 #define CPUCP_PKT_RES_PLL_OUT3_MASK	0xFFFF000000000000ull
 
+#define CPUCP_PKT_VAL_PFC_IN1_SHIFT	0
+#define CPUCP_PKT_VAL_PFC_IN1_MASK	0x0000000000000001ull
+#define CPUCP_PKT_VAL_PFC_IN2_SHIFT	1
+#define CPUCP_PKT_VAL_PFC_IN2_MASK	0x000000000000001Eull
+
+#define CPUCP_PKT_VAL_LPBK_IN1_SHIFT	0
+#define CPUCP_PKT_VAL_LPBK_IN1_MASK	0x0000000000000001ull
+#define CPUCP_PKT_VAL_LPBK_IN2_SHIFT	1
+#define CPUCP_PKT_VAL_LPBK_IN2_MASK	0x000000000000001Eull
+
+/* heartbeat status bits */
+#define CPUCP_PKT_HB_STATUS_EQ_FAULT_SHIFT		0
+#define CPUCP_PKT_HB_STATUS_EQ_FAULT_MASK		0x00000001
+
 struct cpucp_packet {
 	union {
 		__le64 value;	/* For SET packets */
@@ -445,6 +459,12 @@ struct cpucp_packet {
 
 		/* For get CpuCP info/EEPROM data/NIC info */
 		__le32 data_max_size;
+
+		/*
+		 * For any general status bitmask. Shall be used whenever the
+		 * result cannot be used to hold general purpose data.
+		 */
+		__le32 status_mask;
 	};
 
 	__le32 reserved;
-- 
2.25.1

