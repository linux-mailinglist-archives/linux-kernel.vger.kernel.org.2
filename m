Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458473221F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhBVWKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231411AbhBVWJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:09:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A89E664E41;
        Mon, 22 Feb 2021 22:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031728;
        bh=FDya88AugVrfqZoMO73A+PeUX0Qc1tdzMEBxZwrJw+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKHDQERDoqejFt7QRiWqDhfqMNQh0IW708L1/wHFxCC9FpsInbWHbPAAImdtwollT
         3O87NeKiglbO/JFTq6ftndBllgsyCfN1fGXsahPyenVnkUTQ+f+htNBhomckq9J7xJ
         4jJkQDQgWUzb72OXsLbYRS52oODhjn1jQHJOQnUQHiV0BAEOGbWmUPBNQ/RgC+eiTh
         EvaTB7EVSHD6KPJXzYc6lKs1PRNRElAjSXEb6kMEQin7pXvJ6N0c2iPn13sDMaBc2Y
         y1nwzv0W9s3af9IWfaIVOxP4PirwmFA3B+w4S9X97cTkRkkPIwFrKU4vfGi4DjwgzM
         9nCKWmZwlJYPg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/2] habanalabs: reset device in case of sync error
Date:   Tue, 23 Feb 2021 00:08:42 +0200
Message-Id: <20210222220842.9398-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222220842.9398-1-ogabbay@kernel.org>
References: <20210222220842.9398-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

As the F/wW is the first to detect out of sync event, a new event is
added to notify the driver on such event. In which case the driver
performs hard reset.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 18 +++++++++++++++
 drivers/misc/habanalabs/goya/goya.c           | 23 +++++++++++++++++++
 .../misc/habanalabs/include/common/cpucp_if.h |  9 ++++++++
 .../include/gaudi/gaudi_async_events.h        |  1 +
 .../include/goya/goya_async_events.h          |  1 +
 5 files changed, 52 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9152242778f5..c1f00237273c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7097,6 +7097,15 @@ static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 	}
 }
 
+static void gaudi_print_out_of_sync_info(struct hl_device *hdev,
+					struct cpucp_pkt_sync_err *sync_err)
+{
+	struct hl_hw_queue *q = &hdev->kernel_queues[GAUDI_QUEUE_ID_CPU_PQ];
+
+	dev_err(hdev->dev, "Out of sync with FW, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%u\n",
+			sync_err->pi, sync_err->ci, q->pi, atomic_read(&q->ci));
+}
+
 static int gaudi_soft_reset_late_init(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -7552,6 +7561,15 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 			event_type, cause);
 		break;
 
+	case GAUDI_EVENT_PKT_QUEUE_OUT_SYNC:
+		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
+		if (hdev->hard_reset_on_fw_events)
+			hl_device_reset(hdev, true, false);
+		else
+			hl_fw_unmask_irq(hdev, event_type);
+		break;
+
 	default:
 		dev_err(hdev->dev, "Received invalid H/W interrupt %d\n",
 				event_type);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ed566c52ccaa..a40c428fed94 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4401,6 +4401,8 @@ static const char *_goya_get_event_desc(u16 event_type)
 		return "THERMAL_ENV_S";
 	case GOYA_ASYNC_EVENT_ID_FIX_THERMAL_ENV_E:
 		return "THERMAL_ENV_E";
+	case GOYA_ASYNC_EVENT_PKT_QUEUE_OUT_SYNC:
+		return "QUEUE_OUT_OF_SYNC";
 	default:
 		return "N/A";
 	}
@@ -4483,6 +4485,9 @@ static void goya_get_event_desc(u16 event_type, char *desc, size_t size)
 		index = event_type - GOYA_ASYNC_EVENT_ID_DMA_BM_CH0;
 		snprintf(desc, size, _goya_get_event_desc(event_type), index);
 		break;
+	case GOYA_ASYNC_EVENT_PKT_QUEUE_OUT_SYNC:
+		snprintf(desc, size, _goya_get_event_desc(event_type));
+		break;
 	default:
 		snprintf(desc, size, _goya_get_event_desc(event_type));
 		break;
@@ -4534,6 +4539,15 @@ static void goya_print_mmu_error_info(struct hl_device *hdev)
 	}
 }
 
+static void goya_print_out_of_sync_info(struct hl_device *hdev,
+					struct cpucp_pkt_sync_err *sync_err)
+{
+	struct hl_hw_queue *q = &hdev->kernel_queues[GOYA_QUEUE_ID_CPU_PQ];
+
+	dev_err(hdev->dev, "Out of sync with FW, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%u\n",
+			sync_err->pi, sync_err->ci, q->pi, atomic_read(&q->ci));
+}
+
 static void goya_print_irq_info(struct hl_device *hdev, u16 event_type,
 				bool razwi)
 {
@@ -4754,6 +4768,15 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 		goya_unmask_irq(hdev, event_type);
 		break;
 
+	case GOYA_ASYNC_EVENT_PKT_QUEUE_OUT_SYNC:
+		goya_print_irq_info(hdev, event_type, false);
+		goya_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
+		if (hdev->hard_reset_on_fw_events)
+			hl_device_reset(hdev, true, false);
+		else
+			hl_fw_unmask_irq(hdev, event_type);
+		break;
+
 	default:
 		dev_err(hdev->dev, "Received invalid H/W interrupt %d\n",
 				event_type);
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index b77c1c16c32c..bf4e7900d8c8 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -28,6 +28,14 @@
 #define CPUCP_PKT_HBM_ECC_INFO_HBM_CH_SHIFT		6
 #define CPUCP_PKT_HBM_ECC_INFO_HBM_CH_MASK		0x000007C0
 
+/*
+ * info of the pkt queue pointers in the first async occurrence
+ */
+struct cpucp_pkt_sync_err {
+	__le32 pi;
+	__le32 ci;
+};
+
 struct hl_eq_hbm_ecc_data {
 	/* SERR counter */
 	__le32 sec_cnt;
@@ -77,6 +85,7 @@ struct hl_eq_entry {
 		struct hl_eq_ecc_data ecc_data;
 		struct hl_eq_hbm_ecc_data hbm_ecc_data;
 		struct hl_eq_sm_sei_data sm_sei_data;
+		struct cpucp_pkt_sync_err pkt_sync_err;
 		__le64 data[7];
 	};
 };
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
index 49335e8334b4..0a0fa57024f8 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
@@ -303,6 +303,7 @@ enum gaudi_async_event_id {
 	GAUDI_EVENT_NIC3_QP1 = 619,
 	GAUDI_EVENT_NIC4_QP0 = 620,
 	GAUDI_EVENT_NIC4_QP1 = 621,
+	GAUDI_EVENT_PKT_QUEUE_OUT_SYNC = 647,
 	GAUDI_EVENT_FIX_POWER_ENV_S = 658,
 	GAUDI_EVENT_FIX_POWER_ENV_E = 659,
 	GAUDI_EVENT_FIX_THERMAL_ENV_S = 660,
diff --git a/drivers/misc/habanalabs/include/goya/goya_async_events.h b/drivers/misc/habanalabs/include/goya/goya_async_events.h
index 5fb92362fc5f..09081401cb1d 100644
--- a/drivers/misc/habanalabs/include/goya/goya_async_events.h
+++ b/drivers/misc/habanalabs/include/goya/goya_async_events.h
@@ -188,6 +188,7 @@ enum goya_async_event_id {
 	GOYA_ASYNC_EVENT_ID_HALT_MACHINE = 485,
 	GOYA_ASYNC_EVENT_ID_INTS_REGISTER = 486,
 	GOYA_ASYNC_EVENT_ID_SOFT_RESET = 487,
+	GOYA_ASYNC_EVENT_PKT_QUEUE_OUT_SYNC = 506,
 	GOYA_ASYNC_EVENT_ID_FIX_POWER_ENV_S = 507,
 	GOYA_ASYNC_EVENT_ID_FIX_POWER_ENV_E = 508,
 	GOYA_ASYNC_EVENT_ID_FIX_THERMAL_ENV_S = 509,
-- 
2.25.1

