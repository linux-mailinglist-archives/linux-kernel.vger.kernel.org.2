Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432823221FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhBVWKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:10:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhBVWJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:09:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2BC064DE9;
        Mon, 22 Feb 2021 22:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031747;
        bh=q1C3XxsdS/yAKJQS70PydxKPASK41p5x9h6IXKh484U=;
        h=From:To:Cc:Subject:Date:From;
        b=bdqEN1dCLMCTxnpn5Y9RHBaUtnHUsMjEpcgpCGbKH+0LeVz6C/sj1/s6tQuhLyPzd
         9Rw6NKquk6MKuPo2s9NtLX+PdWTmVkb0JM5QvYrxl/jq5I1qGNIdkIIIUhqpQkpuQw
         0jFgNSDCci/7k9xo8uGQnIBYT9aIZm2fFCRPNlJOvOYm9LlL+dNn+LFTcZzJQZkfCx
         Wh1yUQUoZKuQ989iLWT+NQAhF5GTfhJiY4IH6QhYh8Mw2gC4MjJuexe3Isy9+cLyZR
         XdzVhKyFDjcvARQW2g2v8E8z/2TRNPklv2ITsgA/VWyJKGdoOHI1Kj2+BFgvVSIlLS
         UVdmG2EdRLYYQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/3] habanalabs: enable all IRQs for user interrupt support
Date:   Tue, 23 Feb 2021 00:09:01 +0200
Message-Id: <20210222220903.9487-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to support user interrupts, driver must enable all MSI-X
interrupts for any case user will trigger them. We differentiate
between a valid user interrupt and a non valid one.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 20 +++++++++--
 drivers/misc/habanalabs/common/habanalabs.h | 16 +++++++++
 drivers/misc/habanalabs/common/irq.c        | 40 +++++++++++++++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 6948a1c54083..06395c79f07d 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1223,7 +1223,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
  */
 int hl_device_init(struct hl_device *hdev, struct class *hclass)
 {
-	int i, rc, cq_cnt, cq_ready_cnt;
+	int i, rc, cq_cnt, user_interrupt_cnt, cq_ready_cnt;
 	char *name;
 	bool add_cdev_sysfs_on_err = false;
 
@@ -1312,6 +1312,19 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		hdev->completion_queue[i].cq_idx = i;
 	}
 
+	user_interrupt_cnt = hdev->asic_prop.user_interrupt_count;
+
+	if (user_interrupt_cnt) {
+		hdev->user_interrupt = kcalloc(user_interrupt_cnt,
+				sizeof(*hdev->user_interrupt),
+				GFP_KERNEL);
+
+		if (!hdev->user_interrupt) {
+			rc = -ENOMEM;
+			goto cq_fini;
+		}
+	}
+
 	/*
 	 * Initialize the event queue. Must be done before hw_init,
 	 * because there the address of the event queue is being
@@ -1320,7 +1333,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	rc = hl_eq_init(hdev, &hdev->event_queue);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize event queue\n");
-		goto cq_fini;
+		goto user_interrupts_fini;
 	}
 
 	/* MMU S/W must be initialized before kernel context is created */
@@ -1458,6 +1471,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	hl_mmu_fini(hdev);
 eq_fini:
 	hl_eq_fini(hdev, &hdev->event_queue);
+user_interrupts_fini:
+	kfree(hdev->user_interrupt);
 cq_fini:
 	for (i = 0 ; i < cq_ready_cnt ; i++)
 		hl_cq_fini(hdev, &hdev->completion_queue[i]);
@@ -1595,6 +1610,7 @@ void hl_device_fini(struct hl_device *hdev)
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		hl_cq_fini(hdev, &hdev->completion_queue[i]);
 	kfree(hdev->completion_queue);
+	kfree(hdev->user_interrupt);
 
 	hl_hw_queues_destroy(hdev);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 046bb44f70f9..bb6cb88d7257 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -412,6 +412,7 @@ struct hl_mmu_properties {
  * @first_available_user_msix_interrupt: first available msix interrupt
  *                                       reserved for the user
  * @first_available_cq: first available CQ for the user.
+ * @user_interrupt_count: number of user interrupts.
  * @tpc_enabled_mask: which TPCs are enabled.
  * @completion_queues_count: number of completion queues.
  * @fw_security_disabled: true if security measures are disabled in firmware,
@@ -475,6 +476,7 @@ struct asic_fixed_properties {
 	u16				first_available_user_mon[HL_MAX_DCORES];
 	u16				first_available_user_msix_interrupt;
 	u16				first_available_cq[HL_MAX_DCORES];
+	u16				user_interrupt_count;
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
 	u8				fw_security_disabled;
@@ -689,6 +691,16 @@ struct hl_cq {
 	atomic_t		free_slots_cnt;
 };
 
+/**
+ * struct hl_user_interrupt - holds user interrupt information
+ * @hdev: pointer to the device structure
+ * @interrupt_id: msix interrupt id
+ */
+struct hl_user_interrupt {
+	struct hl_device	*hdev;
+	u32			interrupt_id;
+};
+
 /**
  * struct hl_eq - describes the event queue (single one per device)
  * @hdev: pointer to the device structure
@@ -1821,6 +1833,7 @@ struct hl_mmu_funcs {
  * @asic_name: ASIC specific name.
  * @asic_type: ASIC specific type.
  * @completion_queue: array of hl_cq.
+ * @user_interrupt: array of hl_user_interrupt.
  * @cq_wq: work queues of completion queues for executing work in process
  *         context.
  * @eq_wq: work queue of event queue for executing work in process context.
@@ -1937,6 +1950,7 @@ struct hl_device {
 	char				status[HL_DEV_STS_MAX][HL_STR_MAX];
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
+	struct hl_user_interrupt	*user_interrupt;
 	struct workqueue_struct		**cq_wq;
 	struct workqueue_struct		*eq_wq;
 	struct hl_ctx			*kernel_ctx;
@@ -2158,6 +2172,8 @@ void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q);
 void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q);
 irqreturn_t hl_irq_handler_cq(int irq, void *arg);
 irqreturn_t hl_irq_handler_eq(int irq, void *arg);
+irqreturn_t hl_irq_handler_user_cq(int irq, void *arg);
+irqreturn_t hl_irq_handler_default(int irq, void *arg);
 u32 hl_cq_inc_ptr(u32 ptr);
 
 int hl_asid_init(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index de53fb5f978a..e112da51b1c8 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -137,6 +137,46 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+/**
+ * hl_irq_handler_user_cq - irq handler for user completion queues
+ *
+ * @irq: irq number
+ * @arg: pointer to user interrupt structure
+ *
+ */
+irqreturn_t hl_irq_handler_user_cq(int irq, void *arg)
+{
+	struct hl_user_interrupt *user_cq = arg;
+	struct hl_device *hdev = user_cq->hdev;
+	u32 interrupt_id = user_cq->interrupt_id;
+
+	dev_info(hdev->dev,
+		"got user completion interrupt id %u",
+		interrupt_id);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * hl_irq_handler_default - default irq handler
+ *
+ * @irq: irq number
+ * @arg: pointer to user interrupt structure
+ *
+ */
+irqreturn_t hl_irq_handler_default(int irq, void *arg)
+{
+	struct hl_user_interrupt *user_interrupt = arg;
+	struct hl_device *hdev = user_interrupt->hdev;
+	u32 interrupt_id = user_interrupt->interrupt_id;
+
+	dev_err(hdev->dev,
+		"got invalid user interrupt %u",
+		interrupt_id);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * hl_irq_handler_eq - irq handler for event queue
  *
-- 
2.25.1

