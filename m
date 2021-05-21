Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120CA38CB87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbhEURI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237170AbhEURIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:08:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 114456023D
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621616818;
        bh=cszoJ5E8hkczMva+S/YMlVydpuwxLvi3qVOLe/VN2iA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Lb9WGnRjVz1Ahr/oH3gTibgy/iRazafW2l05n3ehWYv0sE3YFirhfsTXoA3KuLVmD
         E0j7HuiWBAN3NCTCAPtyDj38mPjgoY+0n/SfQ9/tcZ2apWRrxCt+12FEAnWuU4UMTh
         +8LqxZjhzKCIw3Jy21ZIL/AwD5eFx12SaFBRUQetezwNukYMIF7ZyAnqumyco5ymUf
         o08AWSoC/oBYdtCHnI0boNXSOZm7tkDR11GuAAJiQn3cM9/FAbSA7Tm4pAOM99fvgy
         Jb563vslDSYgUtORXIBnUZcG40lCSMv6NV+GgvTY1uRrcW6cdOYD2dN1YD0Y0b4lSP
         LowNrCDb6wutw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] habanalabs: check running index in eqe control
Date:   Fri, 21 May 2021 20:06:51 +0300
Message-Id: <20210521170653.4700-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521170653.4700-1-ogabbay@kernel.org>
References: <20210521170653.4700-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To harden the event queue mechanism, we add a running index to the
control header of the entry.

The firmware writes the index in each entry and the driver verifies
that the index of the current entry is larger by 1 of the index of
the previous entry.

In case it isn't, the driver will treat the entry as if it wasn't
valid (it won't process it but won't skip it).

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  |  9 ++++++-
 drivers/misc/habanalabs/common/habanalabs.h   |  7 ++++++
 drivers/misc/habanalabs/common/irq.c          | 24 ++++++++++++++++---
 .../misc/habanalabs/include/common/cpucp_if.h |  3 +++
 .../habanalabs/include/common/hl_boot_if.h    | 11 ++++++++-
 5 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index b00f763bcda6..17173020ff53 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -617,10 +617,17 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev,
 		goto out;
 	}
 
+	/* assume EQ code doesn't need to check eqe index */
+	hdev->event_queue.check_eqe_index = false;
+
 	/* Read FW application security bits again */
-	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid)
+	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid) {
 		hdev->asic_prop.fw_app_cpu_boot_dev_sts0 =
 						RREG32(sts_boot_dev_sts0_reg);
+		if (hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
+				CPU_BOOT_DEV_STS0_EQ_INDEX_EN)
+			hdev->event_queue.check_eqe_index = true;
+	}
 
 	if (hdev->asic_prop.fw_cpu_boot_dev_sts1_valid)
 		hdev->asic_prop.fw_app_cpu_boot_dev_sts1 =
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index a046180254c8..c3f41f0b609f 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -780,12 +780,19 @@ struct hl_user_pending_interrupt {
  * @kernel_address: holds the queue's kernel virtual address
  * @bus_address: holds the queue's DMA address
  * @ci: ci inside the queue
+ * @prev_eqe_index: the index of the previous event queue entry. The index of
+ *                  the current entry's index must be +1 of the previous one.
+ * @check_eqe_index: do we need to check the index of the current entry vs. the
+ *                   previous one. This is for backward compatibility with older
+ *                   firmwares
  */
 struct hl_eq {
 	struct hl_device	*hdev;
 	void			*kernel_address;
 	dma_addr_t		bus_address;
 	u32			ci;
+	u32			prev_eqe_index;
+	bool			check_eqe_index;
 };
 
 
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 27129868c711..39b14a933393 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -207,17 +207,33 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 	struct hl_eq_entry *eq_entry;
 	struct hl_eq_entry *eq_base;
 	struct hl_eqe_work *handle_eqe_work;
+	bool entry_ready;
+	u32 cur_eqe;
+	u16 cur_eqe_index;
 
 	eq_base = eq->kernel_address;
 
 	while (1) {
-		bool entry_ready =
-			((le32_to_cpu(eq_base[eq->ci].hdr.ctl) &
-				EQ_CTL_READY_MASK) >> EQ_CTL_READY_SHIFT);
+		cur_eqe = le32_to_cpu(eq_base[eq->ci].hdr.ctl);
+		entry_ready = !!FIELD_GET(EQ_CTL_READY_MASK, cur_eqe);
 
 		if (!entry_ready)
 			break;
 
+		cur_eqe_index = FIELD_GET(EQ_CTL_INDEX_MASK, cur_eqe);
+		if ((hdev->event_queue.check_eqe_index) &&
+				(((eq->prev_eqe_index + 1) & EQ_CTL_INDEX_MASK)
+							!= cur_eqe_index)) {
+			dev_dbg(hdev->dev,
+				"EQE 0x%x in queue is ready but index does not match %d!=%d",
+				eq_base[eq->ci].hdr.ctl,
+				((eq->prev_eqe_index + 1) & EQ_CTL_INDEX_MASK),
+				cur_eqe_index);
+			break;
+		}
+
+		eq->prev_eqe_index++;
+
 		eq_entry = &eq_base[eq->ci];
 
 		/*
@@ -341,6 +357,7 @@ int hl_eq_init(struct hl_device *hdev, struct hl_eq *q)
 	q->hdev = hdev;
 	q->kernel_address = p;
 	q->ci = 0;
+	q->prev_eqe_index = 0;
 
 	return 0;
 }
@@ -365,6 +382,7 @@ void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q)
 void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q)
 {
 	q->ci = 0;
+	q->prev_eqe_index = 0;
 
 	/*
 	 * It's not enough to just reset the PI/CI because the H/W may have
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 4f1123102968..c7da62243619 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -103,6 +103,9 @@ struct hl_eq_entry {
 #define EQ_CTL_EVENT_TYPE_SHIFT		16
 #define EQ_CTL_EVENT_TYPE_MASK		0x03FF0000
 
+#define EQ_CTL_INDEX_SHIFT		0
+#define EQ_CTL_INDEX_MASK		0x0000FFFF
+
 enum pq_init_status {
 	PQ_INIT_STATUS_NA = 0,
 	PQ_INIT_STATUS_READY_FOR_CP,
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 9266c44d8c6c..6d0c1ddb4304 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -195,7 +195,15 @@
  *					previleged entity. FW sets this status
  *					bit for host. If this bit is set then
  *					GIC can not be accessed from host.
- *					Initialized in: armcpd
+ *					Initialized in: linux
+ *
+ * CPU_BOOT_DEV_STS0_EQ_INDEX_EN	Event Queue (EQ) index is a running
+ *					index for each new event sent to host.
+ *					This is used as a method in host to
+ *					identify that the waiting event in
+ *					queue is actually a new event which
+ *					was not served before.
+ *					Initialized in: linux
  *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
@@ -226,6 +234,7 @@
 #define CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN		(1 << 17)
 #define CPU_BOOT_DEV_STS0_DYN_PLL_EN			(1 << 19)
 #define CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN		(1 << 20)
+#define CPU_BOOT_DEV_STS0_EQ_INDEX_EN			(1 << 21)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 #define CPU_BOOT_DEV_STS1_ENABLED			(1 << 31)
 
-- 
2.25.1

