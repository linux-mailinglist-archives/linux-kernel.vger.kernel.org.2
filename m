Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5365C3221FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhBVWLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhBVWJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:09:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 355CA64E05;
        Mon, 22 Feb 2021 22:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031749;
        bh=Rm5GX9fGnQuta6mvuoyY3Z4oHE/AtyelerkX+KqPF44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXxx0zy2XoeLSH4xGZ6FSrSEZBn5PqC02viwYthyXhjCXTm7hXQFVnnrTd5yWQBlL
         aE+LXqPhFLmhvFtf8pDo4XGp3FDHKjAUhVWh66a4wAVIwFCgMpkX0qXo5jHYWND/lr
         9WVUb0SlxD49PPKU5IrJrav3Hxs7v3jncXvV0hhZq6UIo26auFKOJMprAc7U3llIIo
         MetfNyzQNIXI1I2vWftg6I0fUvJPSDYZQvadduDc11htenVZCkxXE8WlQ+ml0HwXS9
         BudNlkRy4I7El4UVsemAeme23CO32+A+oq8Ex4p5btpmbrB7LTgczxeRmOqL6dflh4
         U1q1Xk03o8+1w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/3] habanalabs: wait for interrupt support
Date:   Tue, 23 Feb 2021 00:09:02 +0200
Message-Id: <20210222220903.9487-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222220903.9487-1-ogabbay@kernel.org>
References: <20210222220903.9487-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to support command submissions from user space, the driver
need to add support for user interrupt completions. The driver will
allow multiple user threads to wait for an interrupt and perform
a comparison with a given user address once interrupt expires.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 213 +++++++++++++++++-
 drivers/misc/habanalabs/common/device.c       |  44 ++--
 drivers/misc/habanalabs/common/habanalabs.h   |  28 ++-
 .../misc/habanalabs/common/habanalabs_ioctl.c |   2 +-
 drivers/misc/habanalabs/common/irq.c          |  22 +-
 include/uapi/misc/habanalabs.h                |  42 +++-
 6 files changed, 322 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 7bd4a03b3429..138cb77420bd 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -778,6 +778,44 @@ void hl_pending_cb_list_flush(struct hl_ctx *ctx)
 	}
 }
 
+static void
+wake_pending_user_interrupt_threads(struct hl_user_interrupt *interrupt)
+{
+	struct hl_user_pending_interrupt *pend;
+
+	spin_lock(&interrupt->wait_list_lock);
+	list_for_each_entry(pend, &interrupt->wait_list_head, wait_list_node) {
+		pend->fence.error = -EIO;
+		complete_all(&pend->fence.completion);
+	}
+	spin_unlock(&interrupt->wait_list_lock);
+}
+
+void hl_release_pending_user_interrupts(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_user_interrupt *interrupt;
+	int i;
+
+	if (!prop->user_interrupt_count)
+		return;
+
+	/* We iterate through the user interrupt requests and waking up all
+	 * user threads waiting for interrupt completion. We iterate the
+	 * list under a lock, this is why all user threads, once awake,
+	 * will wait on the same lock and will release the waiting object upon
+	 * unlock.
+	 */
+
+	for (i = 0 ; i < prop->user_interrupt_count ; i++) {
+		interrupt = &hdev->user_interrupt[i];
+		wake_pending_user_interrupt_threads(interrupt);
+	}
+
+	interrupt = &hdev->common_user_interrupt;
+	wake_pending_user_interrupt_threads(interrupt);
+}
+
 static void job_wq_completion(struct work_struct *work)
 {
 	struct hl_cs_job *job = container_of(work, struct hl_cs_job,
@@ -1818,7 +1856,7 @@ static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	return rc;
 }
 
-int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
+static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	union hl_wait_cs_args *args = data;
@@ -1873,3 +1911,176 @@ int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	return 0;
 }
+
+static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
+				u32 timeout_us, u64 user_address,
+				u32 target_value, u16 interrupt_offset,
+				enum hl_cs_wait_status *status)
+{
+	struct hl_user_pending_interrupt *pend;
+	struct hl_user_interrupt *interrupt;
+	unsigned long timeout;
+	long completion_rc;
+	u32 completion_value;
+	int rc = 0;
+
+	if (timeout_us == MAX_SCHEDULE_TIMEOUT)
+		timeout = timeout_us;
+	else
+		timeout = usecs_to_jiffies(timeout_us);
+
+	hl_ctx_get(hdev, ctx);
+
+	pend = kmalloc(sizeof(*pend), GFP_ATOMIC);
+	if (!pend) {
+		hl_ctx_put(ctx);
+		return -ENOMEM;
+	}
+
+	hl_fence_init(&pend->fence, ULONG_MAX);
+
+	if (interrupt_offset == HL_COMMON_USER_INTERRUPT_ID)
+		interrupt = &hdev->common_user_interrupt;
+	else
+		interrupt = &hdev->user_interrupt[interrupt_offset];
+
+	spin_lock(&interrupt->wait_list_lock);
+	if (!hl_device_operational(hdev, NULL)) {
+		rc = -EPERM;
+		goto unlock_and_free_fence;
+	}
+
+	if (copy_from_user(&completion_value, (void *) user_address, 4)) {
+		dev_err(hdev->dev,
+			"Failed to copy completion value from user\n");
+		rc = -EFAULT;
+		goto unlock_and_free_fence;
+	}
+
+	if (completion_value >= target_value)
+		*status = CS_WAIT_STATUS_COMPLETED;
+	else
+		*status = CS_WAIT_STATUS_BUSY;
+
+	if (!timeout_us || (*status == CS_WAIT_STATUS_COMPLETED))
+		goto unlock_and_free_fence;
+
+	/* Add pending user interrupt to relevant list for the interrupt
+	 * handler to monitor
+	 */
+	list_add_tail(&pend->wait_list_node, &interrupt->wait_list_head);
+	spin_unlock(&interrupt->wait_list_lock);
+
+wait_again:
+	/* Wait for interrupt handler to signal completion */
+	completion_rc =
+		wait_for_completion_interruptible_timeout(
+				&pend->fence.completion, timeout);
+
+	/* If timeout did not expire we need to perform the comparison.
+	 * If comparison fails, keep waiting until timeout expires
+	 */
+	if (completion_rc > 0) {
+		if (copy_from_user(&completion_value,
+				(void *) user_address, 4)) {
+			dev_err(hdev->dev,
+				"Failed to copy completion value from user\n");
+			rc = -EFAULT;
+			goto remove_pending_user_interrupt;
+		}
+
+		if (completion_value >= target_value) {
+			*status = CS_WAIT_STATUS_COMPLETED;
+		} else {
+			timeout -= jiffies_to_usecs(completion_rc);
+			goto wait_again;
+		}
+	} else {
+		*status = CS_WAIT_STATUS_BUSY;
+	}
+
+remove_pending_user_interrupt:
+	spin_lock(&interrupt->wait_list_lock);
+	list_del(&pend->wait_list_node);
+
+unlock_and_free_fence:
+	spin_unlock(&interrupt->wait_list_lock);
+	kfree(pend);
+	hl_ctx_put(ctx);
+
+	return rc;
+}
+
+static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
+{
+	u16 interrupt_id, interrupt_offset, first_interrupt, last_interrupt;
+	struct hl_device *hdev = hpriv->hdev;
+	struct asic_fixed_properties *prop;
+	union hl_wait_cs_args *args = data;
+	enum hl_cs_wait_status status;
+	int rc;
+
+	prop = &hdev->asic_prop;
+
+	if (!prop->user_interrupt_count) {
+		dev_err(hdev->dev, "no user interrupts allowed");
+		return -EPERM;
+	}
+
+	interrupt_id =
+		FIELD_GET(HL_WAIT_CS_FLAGS_INTERRUPT_MASK, args->in.flags);
+
+	first_interrupt = prop->first_available_user_msix_interrupt;
+	last_interrupt = prop->first_available_user_msix_interrupt +
+						prop->user_interrupt_count - 1;
+
+	if ((interrupt_id < first_interrupt || interrupt_id > last_interrupt) &&
+			interrupt_id != HL_COMMON_USER_INTERRUPT_ID) {
+		dev_err(hdev->dev, "invalid user interrupt %u", interrupt_id);
+		return -EINVAL;
+	}
+
+	if (interrupt_id == HL_COMMON_USER_INTERRUPT_ID)
+		interrupt_offset = HL_COMMON_USER_INTERRUPT_ID;
+	else
+		interrupt_offset = interrupt_id - first_interrupt;
+
+	rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx,
+				args->in.interrupt_timeout_us, args->in.addr,
+				args->in.target, interrupt_offset, &status);
+
+	memset(args, 0, sizeof(*args));
+
+	if (rc) {
+		dev_err_ratelimited(hdev->dev,
+			"interrupt_wait_ioctl failed (%d)\n", rc);
+
+		return rc;
+	}
+
+	switch (status) {
+	case CS_WAIT_STATUS_COMPLETED:
+		args->out.status = HL_WAIT_CS_STATUS_COMPLETED;
+		break;
+	case CS_WAIT_STATUS_BUSY:
+	default:
+		args->out.status = HL_WAIT_CS_STATUS_BUSY;
+		break;
+	}
+
+	return 0;
+}
+
+int hl_wait_ioctl(struct hl_fpriv *hpriv, void *data)
+{
+	union hl_wait_cs_args *args = data;
+	u32 flags = args->in.flags;
+	int rc;
+
+	if (flags & HL_WAIT_CS_FLAGS_INTERRUPT)
+		rc = hl_interrupt_wait_ioctl(hpriv, data);
+	else
+		rc = hl_cs_wait_ioctl(hpriv, data);
+
+	return rc;
+}
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 06395c79f07d..b4321144379c 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -98,6 +98,11 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	struct hl_fpriv *hpriv = filp->private_data;
 	struct hl_device *hdev = hpriv->hdev;
 
+	/* Each pending user interrupt holds the user's context, hence we
+	 * must release them all before calling hl_ctx_mgr_fini().
+	 */
+	hl_release_pending_user_interrupts(hpriv->hdev);
+
 	hl_cb_mgr_fini(hdev, &hpriv->cb_mgr);
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
 
@@ -1009,6 +1014,11 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	/* Go over all the queues, release all CS and their jobs */
 	hl_cs_rollback_all(hdev);
 
+	/* Release all pending user interrupts, each pending user interrupt
+	 * holds a reference to user context
+	 */
+	hl_release_pending_user_interrupts(hdev);
+
 kill_processes:
 	if (hard_reset) {
 		/* Kill processes here after CS rollback. This is because the
@@ -1262,13 +1272,26 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (rc)
 		goto free_dev_ctrl;
 
+	user_interrupt_cnt = hdev->asic_prop.user_interrupt_count;
+
+	if (user_interrupt_cnt) {
+		hdev->user_interrupt = kcalloc(user_interrupt_cnt,
+				sizeof(*hdev->user_interrupt),
+				GFP_KERNEL);
+
+		if (!hdev->user_interrupt) {
+			rc = -ENOMEM;
+			goto early_fini;
+		}
+	}
+
 	/*
 	 * Start calling ASIC initialization. First S/W then H/W and finally
 	 * late init
 	 */
 	rc = hdev->asic_funcs->sw_init(hdev);
 	if (rc)
-		goto early_fini;
+		goto user_interrupts_fini;
 
 	/*
 	 * Initialize the H/W queues. Must be done before hw_init, because
@@ -1312,19 +1335,6 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		hdev->completion_queue[i].cq_idx = i;
 	}
 
-	user_interrupt_cnt = hdev->asic_prop.user_interrupt_count;
-
-	if (user_interrupt_cnt) {
-		hdev->user_interrupt = kcalloc(user_interrupt_cnt,
-				sizeof(*hdev->user_interrupt),
-				GFP_KERNEL);
-
-		if (!hdev->user_interrupt) {
-			rc = -ENOMEM;
-			goto cq_fini;
-		}
-	}
-
 	/*
 	 * Initialize the event queue. Must be done before hw_init,
 	 * because there the address of the event queue is being
@@ -1333,7 +1343,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	rc = hl_eq_init(hdev, &hdev->event_queue);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize event queue\n");
-		goto user_interrupts_fini;
+		goto cq_fini;
 	}
 
 	/* MMU S/W must be initialized before kernel context is created */
@@ -1471,8 +1481,6 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	hl_mmu_fini(hdev);
 eq_fini:
 	hl_eq_fini(hdev, &hdev->event_queue);
-user_interrupts_fini:
-	kfree(hdev->user_interrupt);
 cq_fini:
 	for (i = 0 ; i < cq_ready_cnt ; i++)
 		hl_cq_fini(hdev, &hdev->completion_queue[i]);
@@ -1481,6 +1489,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	hl_hw_queues_destroy(hdev);
 sw_fini:
 	hdev->asic_funcs->sw_fini(hdev);
+user_interrupts_fini:
+	kfree(hdev->user_interrupt);
 early_fini:
 	device_early_fini(hdev);
 free_dev_ctrl:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index bb6cb88d7257..ee94953f9ea2 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -63,6 +63,8 @@
 
 #define HL_IDLE_BUSY_TS_ARR_SIZE	4096
 
+#define HL_COMMON_USER_INTERRUPT_ID	0xFFF
+
 /* Memory */
 #define MEM_HASH_TABLE_BITS		7 /* 1 << 7 buckets */
 
@@ -694,13 +696,28 @@ struct hl_cq {
 /**
  * struct hl_user_interrupt - holds user interrupt information
  * @hdev: pointer to the device structure
+ * @wait_list_head: head to the list of user threads pending on this interrupt
+ * @wait_list_lock: protects wait_list_head
  * @interrupt_id: msix interrupt id
  */
 struct hl_user_interrupt {
 	struct hl_device	*hdev;
+	struct list_head	wait_list_head;
+	spinlock_t		wait_list_lock;
 	u32			interrupt_id;
 };
 
+/**
+ * struct hl_user_pending_interrupt - holds a context to a user thread
+ *                                    pending on an interrupt
+ * @wait_list_node: node in the list of user threads pending on an interrupt
+ * @fence: hl fence object for interrupt completion
+ */
+struct hl_user_pending_interrupt {
+	struct list_head	wait_list_node;
+	struct hl_fence		fence;
+};
+
 /**
  * struct hl_eq - describes the event queue (single one per device)
  * @hdev: pointer to the device structure
@@ -1833,7 +1850,12 @@ struct hl_mmu_funcs {
  * @asic_name: ASIC specific name.
  * @asic_type: ASIC specific type.
  * @completion_queue: array of hl_cq.
- * @user_interrupt: array of hl_user_interrupt.
+ * @user_interrupt: array of hl_user_interrupt. upon the corresponding user
+ *                  interrupt, driver will monitor the list of fences
+ *                  registered to this interrupt.
+ * @common_user_interrupt: common user interrupt for all user interrupts.
+ *                         upon any user interrupt, driver will monitor the
+ *                         list of fences registered to this common structure.
  * @cq_wq: work queues of completion queues for executing work in process
  *         context.
  * @eq_wq: work queue of event queue for executing work in process context.
@@ -1951,6 +1973,7 @@ struct hl_device {
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
 	struct hl_user_interrupt	*user_interrupt;
+	struct hl_user_interrupt	common_user_interrupt;
 	struct workqueue_struct		**cq_wq;
 	struct workqueue_struct		*eq_wq;
 	struct hl_ctx			*kernel_ctx;
@@ -2351,6 +2374,7 @@ int hl_set_voltage(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
 int hl_set_current(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
+void hl_release_pending_user_interrupts(struct hl_device *hdev);
 
 #ifdef CONFIG_DEBUG_FS
 
@@ -2451,7 +2475,7 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg);
 int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data);
 int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data);
-int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data);
+int hl_wait_ioctl(struct hl_fpriv *hpriv, void *data);
 int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data);
 
 #endif /* HABANALABSP_H_ */
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 03af61cecd37..95a0b144604d 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -594,7 +594,7 @@ static const struct hl_ioctl_desc hl_ioctls[] = {
 	HL_IOCTL_DEF(HL_IOCTL_INFO, hl_info_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_CB, hl_cb_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_CS, hl_cs_ioctl),
-	HL_IOCTL_DEF(HL_IOCTL_WAIT_CS, hl_cs_wait_ioctl),
+	HL_IOCTL_DEF(HL_IOCTL_WAIT_CS, hl_wait_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_MEMORY, hl_mem_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_DEBUG, hl_debug_ioctl)
 };
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index e112da51b1c8..92c32d090b26 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -137,6 +137,17 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void handle_user_cq(struct hl_device *hdev,
+			struct hl_user_interrupt *user_cq)
+{
+	struct hl_user_pending_interrupt *pend;
+
+	spin_lock(&user_cq->wait_list_lock);
+	list_for_each_entry(pend, &user_cq->wait_list_head, wait_list_node)
+		complete_all(&pend->fence.completion);
+	spin_unlock(&user_cq->wait_list_lock);
+}
+
 /**
  * hl_irq_handler_user_cq - irq handler for user completion queues
  *
@@ -148,11 +159,16 @@ irqreturn_t hl_irq_handler_user_cq(int irq, void *arg)
 {
 	struct hl_user_interrupt *user_cq = arg;
 	struct hl_device *hdev = user_cq->hdev;
-	u32 interrupt_id = user_cq->interrupt_id;
 
-	dev_info(hdev->dev,
+	dev_dbg(hdev->dev,
 		"got user completion interrupt id %u",
-		interrupt_id);
+		user_cq->interrupt_id);
+
+	/* Handle user cq interrupts registered on all interrupts */
+	handle_user_cq(hdev, &hdev->common_user_interrupt);
+
+	/* Handle user cq interrupts registered on this specific interrupt */
+	handle_user_cq(hdev, user_cq);
 
 	return IRQ_HANDLED;
 }
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 5a86b521a450..05c7cf4e727e 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -682,14 +682,46 @@ union hl_cs_args {
 	struct hl_cs_out out;
 };
 
+#define HL_WAIT_CS_FLAGS_INTERRUPT	0x2
+#define HL_WAIT_CS_FLAGS_INTERRUPT_MASK 0xFFF00000
+
 struct hl_wait_cs_in {
-	/* Command submission sequence number */
-	__u64 seq;
-	/* Absolute timeout to wait in microseconds */
-	__u64 timeout_us;
+	union {
+		struct {
+			/* Command submission sequence number */
+			__u64 seq;
+			/* Absolute timeout to wait for command submission
+			 * in microseconds
+			 */
+			__u64 timeout_us;
+		};
+
+		struct {
+			/* User address for completion comparison.
+			 * upon interrupt, driver will compare the value pointed
+			 * by this address with the supplied target value.
+			 * in order not to perform any comparison, set address
+			 * to all 1s.
+			 * Relevant only when HL_WAIT_CS_FLAGS_INTERRUPT is set
+			 */
+			__u64 addr;
+			/* Target value for completion comparison */
+			__u32 target;
+			/* Absolute timeout to wait for interrupt
+			 * in microseconds
+			 */
+			__u32 interrupt_timeout_us;
+		};
+	};
+
 	/* Context ID - Currently not in use */
 	__u32 ctx_id;
-	__u32 pad;
+	/* HL_WAIT_CS_FLAGS_*
+	 * If HL_WAIT_CS_FLAGS_INTERRUPT is set, this field should include
+	 * interrupt id according to HL_WAIT_CS_FLAGS_INTERRUPT_MASK, in order
+	 * not to specify an interrupt id ,set mask to all 1s.
+	 */
+	__u32 flags;
 };
 
 #define HL_WAIT_CS_STATUS_COMPLETED	0
-- 
2.25.1

