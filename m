Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010A837F48F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhEMI7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:59:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:47035 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232274AbhEMI7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:59:19 -0400
IronPort-SDR: iFx5R0FRydYcIObflD9eECkyw6X7IKs52CATTVRknCPBKZVc3ufLs/Yv/i/qzA+Jptq9NGRp3V
 YNiWGpBJEzOg==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032242"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032242"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:08 -0700
IronPort-SDR: ymejRcmLPhV9prK0XPK009m8VrXdso5fEYPVfd0ZPH4Y2RzAytBEQcIceLW7/GCk/t45+O8czq
 HKmKGn5TL6uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928254"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:05 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 03/15] misc: nnpi: Manage and schedule messages to device
Date:   Thu, 13 May 2021 11:57:13 +0300
Message-Id: <20210513085725.45528-4-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a msg_scheduler object for each NNP-I device. Each object
manages multiple command queues - one for driver initiated commands
(called "cmdq"), and the rest for commands coming from user-space. A
kernel thread in the msg_scheduler schedules sending the commands from
these queues to the NNP-I device by using the cmdq_write_mesg function of
the NNP-I device driver ops.

The msg_scheduler object allows multiple user-mode applications to put
messages into the queue without blocking or waiting on a lock. It's
created on device creation and destroyed on device removal.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/misc/intel-nnpi/Makefile        |   2 +-
 drivers/misc/intel-nnpi/device.c        |  20 ++
 drivers/misc/intel-nnpi/device.h        |   9 +
 drivers/misc/intel-nnpi/msg_scheduler.c | 319 ++++++++++++++++++++++++++++++++
 drivers/misc/intel-nnpi/msg_scheduler.h | 153 +++++++++++++++
 drivers/misc/intel-nnpi/nnp_pcie.c      | 153 +++++++++++++++
 6 files changed, 655 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/intel-nnpi/msg_scheduler.c
 create mode 100644 drivers/misc/intel-nnpi/msg_scheduler.h

diff --git a/drivers/misc/intel-nnpi/Makefile b/drivers/misc/intel-nnpi/Makefile
index 84b7528..43f09c0 100644
--- a/drivers/misc/intel-nnpi/Makefile
+++ b/drivers/misc/intel-nnpi/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_INTEL_NNPI) := intel_nnpi.o intel_nnpi_pcie.o
 
-intel_nnpi-y := device.o
+intel_nnpi-y := device.o msg_scheduler.o
 
 intel_nnpi_pcie-y := nnp_pcie.o
 
diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
index 3d80e95..60c5a94 100644
--- a/drivers/misc/intel-nnpi/device.c
+++ b/drivers/misc/intel-nnpi/device.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 
 #include "device.h"
+#include "msg_scheduler.h"
 
 static DEFINE_IDA(dev_ida);
 
@@ -45,7 +46,25 @@ int nnpdev_init(struct nnp_device *nnpdev, struct device *dev,
 	nnpdev->dev = dev;
 	nnpdev->ops = ops;
 
+	nnpdev->cmdq_sched = nnp_msched_create(nnpdev);
+	if (!nnpdev->cmdq_sched) {
+		ret = -ENOMEM;
+		goto err_ida;
+	}
+
+	nnpdev->cmdq = nnp_msched_queue_create(nnpdev->cmdq_sched);
+	if (!nnpdev->cmdq) {
+		ret = -ENOMEM;
+		goto err_msg_sched;
+	}
+
 	return 0;
+
+err_msg_sched:
+	nnp_msched_destroy(nnpdev->cmdq_sched);
+err_ida:
+	ida_simple_remove(&dev_ida, nnpdev->id);
+	return ret;
 }
 EXPORT_SYMBOL(nnpdev_init);
 
@@ -75,6 +94,7 @@ void nnpdev_destroy(struct nnp_device *nnpdev)
 {
 	dev_dbg(nnpdev->dev, "Destroying NNP-I device\n");
 
+	nnp_msched_destroy(nnpdev->cmdq_sched);
 	ida_simple_remove(&dev_ida, nnpdev->id);
 }
 EXPORT_SYMBOL(nnpdev_destroy);
diff --git a/drivers/misc/intel-nnpi/device.h b/drivers/misc/intel-nnpi/device.h
index 4ff7aa9..7d7ef60 100644
--- a/drivers/misc/intel-nnpi/device.h
+++ b/drivers/misc/intel-nnpi/device.h
@@ -11,20 +11,29 @@
  * @ops: device operations implemented by the underlying device driver
  * @dev: pointer to struct device representing the NNP-I card.
  * @id: NNP-I device number
+ * @cmdq_sched: message scheduler thread which schedules and serializes command
+ *              submissions to the device's command queue.
+ * @cmdq: input queue to @cmdq_sched used to schedule driver internal commands
+ *        to be sent to the device.
  */
 struct nnp_device {
 	const struct nnp_device_ops *ops;
 	struct device               *dev;
 	int                         id;
+
+	struct nnp_msched       *cmdq_sched;
+	struct nnp_msched_queue *cmdq;
 };
 
 /**
  * struct nnp_device_ops - operations implemented by underlying device driver
  * @cmdq_flush: empties the device command queue, discarding all queued
  *              commands.
+ * @cmdq_write_mesg: inserts a command message to the card's command queue.
  */
 struct nnp_device_ops {
 	int (*cmdq_flush)(struct nnp_device *hw_dev);
+	int (*cmdq_write_mesg)(struct nnp_device *nnpdev, u64 *msg, u32 size);
 };
 
 /*
diff --git a/drivers/misc/intel-nnpi/msg_scheduler.c b/drivers/misc/intel-nnpi/msg_scheduler.c
new file mode 100644
index 0000000..c018630
--- /dev/null
+++ b/drivers/misc/intel-nnpi/msg_scheduler.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+/*
+ * message scheduler implementation.
+ *
+ * That implements a scheduler object which is used to serialize
+ * command submission to an NNP-I device.
+ * It manages a list of message queues which hold command messages
+ * to be submitted to the card.
+ * It also implements a kernel thread which schedules draining
+ * the message queues in round-robin fashion.
+ *
+ * An instance of this object is created for each NNP-I device.
+ * A message queue is created for each user created channel as well
+ * as one message queue which is used by the kernel driver itself.
+ */
+
+#include <linux/err.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "device.h"
+#include "msg_scheduler.h"
+
+/**
+ * struct msg_entry - struct to hold a single command message
+ * @msg: command message payload
+ * @size: size in 64-bit words
+ * @node: node to be included in list of command messages.
+ */
+struct msg_entry {
+	u64              msg[MSG_SCHED_MAX_MSG_SIZE];
+	unsigned int     size;
+	struct list_head node;
+};
+
+/**
+ * do_sched() - fetch and write a message from one message queue.
+ * @sched: the scheduler
+ * @q: the queue to handle
+ *
+ * This function is called from the main scheduler thread to handle single
+ * message queue. It fetches one message from the queue and send it to the
+ * NNP-I device.
+ *
+ * The function should be called when the scheduler mutex is held to prevent
+ * the queue from being destroyed.
+ */
+static void do_sched(struct nnp_msched *sched, struct nnp_msched_queue *q)
+{
+	struct nnp_device *nnpdev = sched->nnpdev;
+	struct msg_entry *msg;
+	unsigned int left_msgs;
+
+	lockdep_assert_held(&sched->mutex);
+
+	/* Fetch one message from the queue */
+	spin_lock(&q->list_lock);
+	if (list_empty(&q->msgs)) {
+		spin_unlock(&q->list_lock);
+		return;
+	}
+
+	msg = list_first_entry(&q->msgs, struct msg_entry, node);
+	list_del(&msg->node);
+	q->msgs_num--;
+	left_msgs = q->msgs_num;
+	spin_lock(&sched->total_msgs_lock);
+	sched->total_msgs--;
+	spin_unlock(&sched->total_msgs_lock);
+	spin_unlock(&q->list_lock);
+
+	/*
+	 * Write the fetched message out.
+	 * Note that cmdq_write_mesg function may sleep.
+	 */
+	nnpdev->ops->cmdq_write_mesg(nnpdev, msg->msg, msg->size);
+
+	kmem_cache_free(sched->slab_cache_ptr, msg);
+
+	/*
+	 * Wake any waiting sync thread if the queue just
+	 * became empty
+	 */
+	if (!left_msgs)
+		wake_up_all(&q->sync_waitq);
+}
+
+/**
+ * msg_sched_thread() - the main function of the scheduler thread.
+ * @data: pointer to the msg scheduler object.
+ *
+ * This is the main function of the scheduler kernel thread.
+ * It loops in round-robin fashion on all queues, pulls one message
+ * each time and send it to the NNP-I device.
+ * For each application created channel, a different queue of
+ * command messages is allocated. This thread schedules and serializes
+ * accesses to the NNP-I device's command queue.
+ *
+ * Return: 0 when thread is stopped
+ */
+static int msg_sched_thread(void *data)
+{
+	struct nnp_msched *dev_sched = data;
+	struct nnp_msched_queue *q;
+	bool need_sched;
+
+	while (!kthread_should_stop()) {
+		mutex_lock(&dev_sched->mutex);
+		list_for_each_entry(q, &dev_sched->queues, node)
+			do_sched(dev_sched, q);
+
+		/*
+		 * Wait for new messages to be available in some queue
+		 * if no messages are known to exist
+		 */
+		spin_lock(&dev_sched->total_msgs_lock);
+		set_current_state(TASK_INTERRUPTIBLE);
+		need_sched = !dev_sched->total_msgs;
+		spin_unlock(&dev_sched->total_msgs_lock);
+		mutex_unlock(&dev_sched->mutex);
+		if (need_sched)
+			schedule();
+		set_current_state(TASK_RUNNING);
+	}
+
+	return 0;
+}
+
+struct nnp_msched_queue *nnp_msched_queue_create(struct nnp_msched *scheduler)
+{
+	struct nnp_msched_queue *queue;
+
+	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
+	if (!queue)
+		return NULL;
+
+	INIT_LIST_HEAD(&queue->msgs);
+	spin_lock_init(&queue->list_lock);
+	queue->msgs_num = 0;
+	queue->scheduler = scheduler;
+	init_waitqueue_head(&queue->sync_waitq);
+
+	mutex_lock(&scheduler->mutex);
+	list_add_tail(&queue->node, &scheduler->queues);
+	mutex_unlock(&scheduler->mutex);
+
+	return queue;
+}
+
+int nnp_msched_queue_destroy(struct nnp_msched_queue *queue)
+{
+	struct msg_entry *msg;
+
+	/* detach the queue from list of scheduled queues */
+	mutex_lock(&queue->scheduler->mutex);
+	list_del(&queue->node);
+	mutex_unlock(&queue->scheduler->mutex);
+
+	/* destroy all the messages of the queue */
+	spin_lock(&queue->list_lock);
+	while (!list_empty(&queue->msgs)) {
+		msg = list_first_entry(&queue->msgs, struct msg_entry, node);
+		list_del(&msg->node);
+		kmem_cache_free(queue->scheduler->slab_cache_ptr, msg);
+	}
+	spin_unlock(&queue->list_lock);
+
+	kfree(queue);
+
+	return 0;
+}
+
+static inline bool is_queue_empty(struct nnp_msched_queue *queue)
+{
+	bool ret;
+
+	spin_lock(&queue->list_lock);
+	ret = list_empty(&queue->msgs);
+	spin_unlock(&queue->list_lock);
+
+	return ret;
+}
+
+int nnp_msched_queue_sync(struct nnp_msched_queue *queue)
+{
+	int ret;
+
+	/* Wait for the queue to be empty */
+	ret = wait_event_interruptible(queue->sync_waitq, is_queue_empty(queue));
+
+	return ret;
+}
+
+int nnp_msched_queue_add_msg(struct nnp_msched_queue *queue, u64 *msg,
+			     unsigned int size)
+{
+	unsigned int i;
+	struct msg_entry *m;
+	bool throttled;
+
+	if (size > MSG_SCHED_MAX_MSG_SIZE)
+		return -EINVAL;
+
+	m = kmem_cache_alloc(queue->scheduler->slab_cache_ptr, GFP_KERNEL);
+	if (!m)
+		return -ENOMEM;
+
+	for (i = 0; i < size; i++)
+		m->msg[i] = msg[i];
+
+	m->size = size;
+
+	spin_lock(&queue->list_lock);
+	throttled = queue->throttled;
+	if (!throttled) {
+		list_add_tail(&m->node, &queue->msgs);
+		queue->msgs_num++;
+		spin_lock(&queue->scheduler->total_msgs_lock);
+		queue->scheduler->total_msgs++;
+		spin_unlock(&queue->scheduler->total_msgs_lock);
+	}
+	spin_unlock(&queue->list_lock);
+
+	/* if queue flagged as throttled - silently ignore the message */
+	if (throttled) {
+		kmem_cache_free(queue->scheduler->slab_cache_ptr, m);
+		return 0;
+	}
+
+	wake_up_process(queue->scheduler->thread);
+
+	return 0;
+}
+
+struct nnp_msched *nnp_msched_create(struct nnp_device *nnpdev)
+{
+	struct nnp_msched *dev_sched;
+
+	dev_sched = kzalloc(sizeof(*dev_sched), GFP_KERNEL);
+	if (!dev_sched)
+		return NULL;
+
+	dev_sched->slab_cache_ptr = kmem_cache_create("msg_sched_slab",
+						      sizeof(struct msg_entry),
+						      0, 0, NULL);
+	if (!dev_sched->slab_cache_ptr) {
+		kfree(dev_sched);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&dev_sched->queues);
+
+	spin_lock_init(&dev_sched->total_msgs_lock);
+	mutex_init(&dev_sched->mutex);
+	dev_sched->nnpdev = nnpdev;
+
+	dev_sched->thread = kthread_run(msg_sched_thread, dev_sched,
+					"msg_sched_thread");
+	if (!dev_sched->thread) {
+		kmem_cache_destroy(dev_sched->slab_cache_ptr);
+		kfree(dev_sched);
+		return NULL;
+	}
+
+	return dev_sched;
+}
+
+void nnp_msched_destroy(struct nnp_msched *sched)
+{
+	struct nnp_msched_queue *q, *tmp;
+
+	nnp_msched_throttle_all(sched);
+
+	kthread_stop(sched->thread);
+
+	mutex_lock(&sched->mutex);
+	list_for_each_entry_safe(q, tmp, &sched->queues, node) {
+		/* destroy the queue */
+		list_del(&q->node);
+		kfree(q);
+	}
+	mutex_unlock(&sched->mutex);
+
+	kmem_cache_destroy(sched->slab_cache_ptr);
+
+	kfree(sched);
+}
+
+void nnp_msched_throttle_all(struct nnp_msched *sched)
+{
+	struct nnp_msched_queue *q;
+	struct msg_entry *msg, *tmp;
+
+	/*
+	 * For each queue:
+	 * 1) throttle the queue, so that no more messages will be inserted
+	 * 2) delete all existing messages
+	 */
+	mutex_lock(&sched->mutex);
+	list_for_each_entry(q, &sched->queues, node) {
+		spin_lock(&q->list_lock);
+		q->throttled = true;
+		list_for_each_entry_safe(msg, tmp, &q->msgs, node) {
+			list_del(&msg->node);
+			kmem_cache_free(sched->slab_cache_ptr, msg);
+		}
+		q->msgs_num = 0;
+		spin_unlock(&q->list_lock);
+		wake_up_all(&q->sync_waitq);
+	}
+	mutex_unlock(&sched->mutex);
+}
diff --git a/drivers/misc/intel-nnpi/msg_scheduler.h b/drivers/misc/intel-nnpi/msg_scheduler.h
new file mode 100644
index 0000000..c8033f2
--- /dev/null
+++ b/drivers/misc/intel-nnpi/msg_scheduler.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2019-2021 Intel Corporation */
+
+#ifndef _NNP_MSGF_SCHEDULER_H
+#define _NNP_MSGF_SCHEDULER_H
+
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#define MSG_SCHED_MAX_MSG_SIZE 3  /* maximum command message size, i qwords */
+
+/**
+ * struct nnp_msched - structure for msg scheduler object
+ * @thread: kernel thread which schedules message writes to device
+ * @nnpdev: the device the scheduler writes to
+ * @queues: list of message queues to schedule from
+ * @total_msgs_lock: protects accesses to @total_msgs
+ * @mutex: protects modifications to @queues
+ * @total_msgs: total count of messages in all queues yet to be written.
+ * @slab_cache_ptr: used to allocate entries in msg queue list.
+ *
+ * We have one msg scheduler object allocated for each NNP-I device,
+ * It manages a list of command message queues and a kernel thread
+ * which schedules sending the command messages to the device in a
+ * round-robin fashion.
+ */
+struct nnp_msched {
+	struct task_struct *thread;
+	struct nnp_device  *nnpdev;
+	struct list_head   queues;
+	spinlock_t         total_msgs_lock;
+	struct mutex       mutex;
+	unsigned int       total_msgs;
+	struct kmem_cache  *slab_cache_ptr;
+};
+
+/**
+ * struct nnp_msched_queue - structure to hold one list of command messages
+ * @scheduler: the scheduler object this queue belongs to
+ * @node: node of this element in @queues in msg_sched
+ * @msgs: list of command messages
+ * @sync_waitq: waitq used for waiting until queue becomes empty
+ * @throttled: if true, all messages in the queue should be discarded and no new
+ *             messages can be added to it until it will become un-throttled.
+ * @msgs_num: number of messages in the queue
+ * @list_lock: protects @msgs
+ *
+ * This structure holds a list of command messages to be queued for submission
+ * to the device. Each application holding a channel for command submissions
+ * has its own command message queue.
+ */
+struct nnp_msched_queue {
+	struct nnp_msched *scheduler;
+	struct list_head  node;
+	struct list_head  msgs;
+	wait_queue_head_t sync_waitq;
+	bool              throttled;
+	unsigned int      msgs_num;
+	spinlock_t        list_lock;
+};
+
+/**
+ * nnp_msched_create() - creates msg scheduler object
+ * @nnpdev: the device this scheduler writes messages to.
+ *
+ * This function creates a message scheduler object which can hold
+ * multiple message queues and a scheduling thread which pop messages
+ * from the different queues and synchronously sends them down to the device
+ * for transmission.
+ *
+ * Return: pointer to allocated scheduler object or NULL on failure
+ */
+struct nnp_msched *nnp_msched_create(struct nnp_device *nnpdev);
+
+/**
+ * nnp_msched_destroy() - destroys a msg scheduler object
+ * @sched: pointer to msg scheduler object
+ *
+ * This function will wait for the scheduler thread to complete
+ * and destroys the scheduler object as well as all messages and message
+ * queues.
+ * NOTE: caller must make sure that no new queues and messages will be added
+ * to this scheduler object while this function is in progress! There is no
+ * mutex to protect this, should be handled by the caller.
+ */
+void nnp_msched_destroy(struct nnp_msched *sched);
+
+/**
+ * nnp_msched_throttle_all() - Remove all messages and throttle all queues
+ * @sched: pointer to msg scheduler object
+ *
+ * This function removes all messages from all queues and marks all queues
+ * as throttled. No new messages can be added to a throttled queue until it
+ * becomes unthrottled.
+ *
+ * This function is called before the device is reset in order to stop sending
+ * any more messages to the device. When the reset is complete, the message
+ * queues are unthrottled. This is done to make sure that no messages generated
+ * before the reset will be sent to the device, also after the reset completes.
+ */
+void nnp_msched_throttle_all(struct nnp_msched *sched);
+
+/**
+ * nnp_msched_queue_create() - create a queue of messages handled by scheduler
+ * @scheduler: the msg scheduler object
+ *
+ * Return: pointer to msg scheduler queue object, NULL on failure.
+ */
+struct nnp_msched_queue *nnp_msched_queue_create(struct nnp_msched *scheduler);
+
+/**
+ * nnp_msched_queue_destroy() - destroy a message queue object
+ * @queue: the message queue object to be destroyed.
+ *
+ * This function destroys a message queue object, if the queue is not empty
+ * and still contains messages, the messages will be discarded and not sent to
+ * the device.
+ *
+ * Return: 0 on success.
+ */
+int nnp_msched_queue_destroy(struct nnp_msched_queue *queue);
+
+/**
+ * nnp_msched_queue_sync() - wait for message queue to be empty
+ * @queue: the message queue object
+ *
+ * Return: 0 on success, error value otherwise.
+ */
+int nnp_msched_queue_sync(struct nnp_msched_queue *queue);
+
+/**
+ * nnp_msched_queue_add_msg() - adds a message packet to a message queue
+ * @queue: the message queue object
+ * @msg: pointer to message content
+ * @size: size of message in 64-bit units
+ *
+ * This function adds a message to the queue. The message will be sent
+ * once the scheduler thread drains it from the queue.
+ *
+ * Return: 0 on success, error value otherwise
+ */
+int nnp_msched_queue_add_msg(struct nnp_msched_queue *queue, u64 *msg,
+			     unsigned int size);
+
+/*
+ * Utility macro for calling nnp_msched_queue_add_msg by passing u64 array
+ * object which forms the message.
+ */
+#define nnp_msched_queue_msg(q, m) \
+	nnp_msched_queue_add_msg((q), (u64 *)&(m), sizeof((m)) / sizeof(u64))
+
+#endif /* _NNP_MSGF_SCHEDULER_H */
diff --git a/drivers/misc/intel-nnpi/nnp_pcie.c b/drivers/misc/intel-nnpi/nnp_pcie.c
index 88280d1..7aa9074 100644
--- a/drivers/misc/intel-nnpi/nnp_pcie.c
+++ b/drivers/misc/intel-nnpi/nnp_pcie.c
@@ -38,10 +38,14 @@
  *                    queue.
  * @card_doorbell_val: card's doorbell register value, updated when doorbell
  *                     interrupt is received.
+ * @cmdq_free_slots: number of slots in the device's command queue which is known
+ *                   to be available.
+ * @cmdq_lock: protects @cmdq_free_slots calculation.
  * @card_status: Last device interrupt status register, updated in interrupt
  *               handler.
  * @cmd_read_update_count: number of times the device has updated its read
  *                         pointer to the device command queue.
+ * @removing: true if device remove is in progress.
  */
 struct nnp_pci {
 	struct nnp_device nnpdev;
@@ -55,8 +59,12 @@ struct nnp_pci {
 	wait_queue_head_t card_status_wait;
 	u32             card_doorbell_val;
 
+	u32             cmdq_free_slots;
+	spinlock_t      cmdq_lock;
+
 	u32             card_status;
 	u32             cmd_read_update_count;
+	bool            removing;
 };
 
 #define NNP_DRIVER_NAME  "nnp_pcie"
@@ -228,6 +236,135 @@ static void nnp_free_interrupts(struct nnp_pci *nnp_pci, struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
+/**
+ * nnp_cmdq_write_mesg_nowait() - tries to write full message to command queue
+ * @nnp_pci: the device
+ * @msg: pointer to the command message
+ * @size: size of the command message in qwords
+ * @read_update_count: returns current cmd_read_update_count value,
+ *                     valid only if function returns -EAGAIN.
+ *
+ * Return:
+ * * 0: Success, command has been written
+ * * -EAGAIN: command queue does not have room for the entire command
+ *            message.
+ *            read_update_count returns the current value of
+ *            cmd_read_update_count counter which increments when the device
+ *            advance its command queue read pointer. The caller may wait
+ *            for this counter to be advanced past this point before calling
+ *            this function again to re-try the write.
+ * * -ENODEV: device remove is in progress.
+ */
+static int nnp_cmdq_write_mesg_nowait(struct nnp_pci *nnp_pci, u64 *msg,
+				      u32 size, u32 *read_update_count)
+{
+	u32 cmd_iosf_control;
+	u32 read_pointer, write_pointer;
+	int i;
+
+	if (nnp_pci->removing)
+		return -ENODEV;
+
+	if (!size)
+		return 0;
+
+	spin_lock(&nnp_pci->cmdq_lock);
+
+	if (nnp_pci->cmdq_free_slots < size) {
+		/* read command fifo pointers and compute free slots in fifo */
+		spin_lock(&nnp_pci->lock);
+		cmd_iosf_control = nnp_mmio_read(nnp_pci, ELBI_COMMAND_IOSF_CONTROL);
+		read_pointer = FIELD_GET(CMDQ_READ_PTR_MASK, cmd_iosf_control);
+		write_pointer =
+			FIELD_GET(CMDQ_WRITE_PTR_MASK, cmd_iosf_control);
+
+		nnp_pci->cmdq_free_slots = ELBI_COMMAND_FIFO_DEPTH -
+					   (write_pointer - read_pointer);
+
+		if (nnp_pci->cmdq_free_slots < size) {
+			*read_update_count = nnp_pci->cmd_read_update_count;
+			spin_unlock(&nnp_pci->lock);
+			spin_unlock(&nnp_pci->cmdq_lock);
+			return -EAGAIN;
+		}
+		spin_unlock(&nnp_pci->lock);
+	}
+
+	/* Write all but the last qword without generating msi on card */
+	for (i = 0; i < size - 1; i++)
+		nnp_mmio_write_8b(nnp_pci, ELBI_COMMAND_WRITE_WO_MSI_LOW, msg[i]);
+
+	/* Write last qword with generating interrupt on card */
+	nnp_mmio_write_8b(nnp_pci, ELBI_COMMAND_WRITE_W_MSI_LOW, msg[i]);
+
+	nnp_pci->cmdq_free_slots -= size;
+
+	spin_unlock(&nnp_pci->cmdq_lock);
+
+	return 0;
+}
+
+/**
+ * check_read_count() - check if device has read commands from command FIFO
+ * @nnp_pci: the device
+ * @count: last known 'cmd_read_update_count' value
+ *
+ * cmd_read_update_count is advanced on each interrupt received because the
+ * device has advanced its read pointer into the command FIFO.
+ * This function checks the current cmd_read_update_count against @count and
+ * returns true if it is different. This is used to check if the device has
+ * freed some entries in the command FIFO after it became full.
+ *
+ * Return: true if current device read update count has been advanced
+ */
+static bool check_read_count(struct nnp_pci *nnp_pci, u32 count)
+{
+	bool ret;
+
+	spin_lock(&nnp_pci->lock);
+	ret = (count != nnp_pci->cmd_read_update_count);
+	spin_unlock(&nnp_pci->lock);
+
+	return ret;
+}
+
+/**
+ * nnp_cmdq_write_mesg() - writes a command message to device's command queue
+ * @nnpdev: the device handle
+ * @msg: The command message to write
+ * @size: size of the command message in qwords
+ *
+ * Return:
+ * * 0: Success, command has been written
+ * * -ENODEV: device remove is in progress.
+ */
+static int nnp_cmdq_write_mesg(struct nnp_device *nnpdev, u64 *msg, u32 size)
+{
+	int rc;
+	u32 rcnt = 0;
+	struct nnp_pci *nnp_pci = container_of(nnpdev, struct nnp_pci, nnpdev);
+
+	do {
+		rc = nnp_cmdq_write_mesg_nowait(nnp_pci, msg, size, &rcnt);
+		if (rc != -EAGAIN)
+			break;
+
+		rc = wait_event_interruptible(nnp_pci->card_status_wait,
+					      check_read_count(nnp_pci, rcnt) ||
+					      nnp_pci->removing);
+		if (!rc && nnp_pci->removing) {
+			rc = -ENODEV;
+			break;
+		}
+	} while (!rc);
+
+	if (rc)
+		dev_dbg(&nnp_pci->pdev->dev,
+			"Failed to write message size %u rc=%d!\n", size, rc);
+
+	return rc;
+}
+
 static int nnp_cmdq_flush(struct nnp_device *nnpdev)
 {
 	struct nnp_pci *nnp_pci = container_of(nnpdev, struct nnp_pci, nnpdev);
@@ -240,6 +377,7 @@ static int nnp_cmdq_flush(struct nnp_device *nnpdev)
 
 static struct nnp_device_ops nnp_device_ops = {
 	.cmdq_flush = nnp_cmdq_flush,
+	.cmdq_write_mesg = nnp_cmdq_write_mesg,
 };
 
 static void set_host_boot_state(struct nnp_pci *nnp_pci, int boot_state)
@@ -271,6 +409,7 @@ static int nnp_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	init_waitqueue_head(&nnp_pci->card_status_wait);
 	spin_lock_init(&nnp_pci->lock);
+	spin_lock_init(&nnp_pci->cmdq_lock);
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
@@ -328,6 +467,20 @@ static void nnp_remove(struct pci_dev *pdev)
 	nnp_free_interrupts(nnp_pci, nnp_pci->pdev);
 
 	/*
+	 * Flag that the device is being removed and wake any possible
+	 * thread waiting on the card's command queue.
+	 * During the remove flow, we want to immediately fail any thread
+	 * that is using the device without waiting for pending device
+	 * requests to complete. We rather give precedance to device
+	 * removal over waiting for all pending requests to finish.
+	 * When we set the host boot state to "NOT_READY" in the doorbell
+	 * register, the card will cleanup any state, so this "hard remove"
+	 * is not an issue for next time the device will get inserted.
+	 */
+	nnp_pci->removing = true;
+	wake_up_all(&nnp_pci->card_status_wait);
+
+	/*
 	 * Inform card that host driver is down.
 	 * This will also clear any state on the card so that
 	 * if card is inserted again, it will be in a good, clear
-- 
1.8.3.1

