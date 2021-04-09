Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B50359330
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhDIDmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:42:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28542 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233015AbhDIDmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:42:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617939747; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=pp3bNOivjPJ2gf4Peoo6Ry3Ij3pYzlxJClwWXp0q6mQ=; b=unJQEM4o+iY9FRjBcZjGTWSeNEUchUs9vJzQQio59reBqfYJwrQolKCVlPeTO+1AXM3hu48T
 Z9thB0Z+YQLqY5LYdmZOeng+W2E0D1P0ZD4/ZaIFIfc86XBHOzBrqx2/5HAkYaHSXpaaaJHd
 9Lsqh5z2DE8sovBMDoz1HQuPypA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 606fcd228166b7eff740a7a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Apr 2021 03:42:26
 GMT
Sender: hangl=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61526C43465; Fri,  9 Apr 2021 03:42:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hangl-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hangl)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0ECF4C433CA;
        Fri,  9 Apr 2021 03:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0ECF4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hangl@codeaurora.org
From:   Hang Lu <hangl@codeaurora.org>
To:     tkjos@google.com, gregkh@linuxfoundation.org
Cc:     tkjos@android.com, maco@android.com, arve@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, Hang Lu <hangl@codeaurora.org>
Subject: [PATCH v4] binder: tell userspace to dump current backtrace when detected oneway spamming
Date:   Fri,  9 Apr 2021 11:40:57 +0800
Message-Id: <1617939657-14044-1-git-send-email-hangl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAHRSSEyTDZTWMrWe+H4awCOBrf+AZd-TEqi3gZONZxYYQSWB5Q@mail.gmail.com>
References: <CAHRSSEyTDZTWMrWe+H4awCOBrf+AZd-TEqi3gZONZxYYQSWB5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When async binder buffer got exhausted, some normal oneway transactions
will also be discarded and may cause system or application failures. By
that time, the binder debug information we dump may not be relevant to
the root cause. And this issue is difficult to debug if without the
backtrace of the thread sending spam.

This change will send BR_ONEWAY_SPAM_SUSPECT to userspace when oneway
spamming is detected, request to dump current backtrace. Oneway spamming
will be reported only once when exceeding the threshold (target process
dips below 80% of its oneway space, and current process is responsible for
either more than 50 transactions, or more than 50% of the oneway space).
And the detection will restart when the async buffer has returned to a
healthy state.

Signed-off-by: Hang Lu <hangl@codeaurora.org>
---
v4: add missing BR_FROZEN_REPLY in binder_return_strings and change the size of binder_stats.br array

v3: add BR_ONEWAY_SPAM_SUSPECT to binder_return_strings

v2: make the detection on/off switch to be per-proc

 drivers/android/binder.c            | 30 ++++++++++++++++++++++++++----
 drivers/android/binder_alloc.c      | 15 ++++++++++++---
 drivers/android/binder_alloc.h      |  8 +++++++-
 drivers/android/binder_internal.h   |  6 +++++-
 include/uapi/linux/android/binder.h |  8 ++++++++
 5 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e1a484a..63d2c43 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3020,7 +3020,10 @@ static void binder_transaction(struct binder_proc *proc,
 			goto err_bad_object_type;
 		}
 	}
-	tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
+	if (t->buffer->oneway_spam_suspect)
+		tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
+	else
+		tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
 	t->work.type = BINDER_WORK_TRANSACTION;
 
 	if (reply) {
@@ -3893,9 +3896,14 @@ static int binder_thread_read(struct binder_proc *proc,
 
 			binder_stat_br(proc, thread, cmd);
 		} break;
-		case BINDER_WORK_TRANSACTION_COMPLETE: {
+		case BINDER_WORK_TRANSACTION_COMPLETE:
+		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT: {
+			if (proc->oneway_spam_detection_enabled &&
+				   w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
+				cmd = BR_ONEWAY_SPAM_SUSPECT;
+			else
+				cmd = BR_TRANSACTION_COMPLETE;
 			binder_inner_proc_unlock(proc);
-			cmd = BR_TRANSACTION_COMPLETE;
 			kfree(w);
 			binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
 			if (put_user(cmd, (uint32_t __user *)ptr))
@@ -4897,6 +4905,18 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	}
+	case BINDER_ENABLE_ONEWAY_SPAM_DETECTION: {
+		uint32_t enable;
+
+		if (copy_from_user(&enable, ubuf, sizeof(enable))) {
+			ret = -EINVAL;
+			goto err;
+		}
+		binder_inner_proc_lock(proc);
+		proc->oneway_spam_detection_enabled = (bool)enable;
+		binder_inner_proc_unlock(proc);
+		break;
+	}
 	default:
 		ret = -EINVAL;
 		goto err;
@@ -5559,7 +5579,9 @@ static const char * const binder_return_strings[] = {
 	"BR_FINISHED",
 	"BR_DEAD_BINDER",
 	"BR_CLEAR_DEATH_NOTIFICATION_DONE",
-	"BR_FAILED_REPLY"
+	"BR_FAILED_REPLY",
+	"BR_FROZEN_REPLY",
+	"BR_ONEWAY_SPAM_SUSPECT",
 };
 
 static const char * const binder_command_strings[] = {
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 7caf74a..340515f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -338,7 +338,7 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
 	return vma;
 }
 
-static void debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
+static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
 {
 	/*
 	 * Find the amount and size of buffers allocated by the current caller;
@@ -366,13 +366,19 @@ static void debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
 
 	/*
 	 * Warn if this pid has more than 50 transactions, or more than 50% of
-	 * async space (which is 25% of total buffer size).
+	 * async space (which is 25% of total buffer size). Oneway spam is only
+	 * detected when the threshold is exceeded.
 	 */
 	if (num_buffers > 50 || total_alloc_size > alloc->buffer_size / 4) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 			     "%d: pid %d spamming oneway? %zd buffers allocated for a total size of %zd\n",
 			      alloc->pid, pid, num_buffers, total_alloc_size);
+		if (!alloc->oneway_spam_detected) {
+			alloc->oneway_spam_detected = true;
+			return true;
+		}
 	}
+	return false;
 }
 
 static struct binder_buffer *binder_alloc_new_buf_locked(
@@ -525,6 +531,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	buffer->async_transaction = is_async;
 	buffer->extra_buffers_size = extra_buffers_size;
 	buffer->pid = pid;
+	buffer->oneway_spam_suspect = false;
 	if (is_async) {
 		alloc->free_async_space -= size + sizeof(struct binder_buffer);
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
@@ -536,7 +543,9 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			 * of async space left (which is less than 10% of total
 			 * buffer size).
 			 */
-			debug_low_async_space_locked(alloc, pid);
+			buffer->oneway_spam_suspect = debug_low_async_space_locked(alloc, pid);
+		} else {
+			alloc->oneway_spam_detected = false;
 		}
 	}
 	return buffer;
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 6e8e001..7dea57a 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -26,6 +26,8 @@ struct binder_transaction;
  * @clear_on_free:      %true if buffer must be zeroed after use
  * @allow_user_free:    %true if user is allowed to free buffer
  * @async_transaction:  %true if buffer is in use for an async txn
+ * @oneway_spam_suspect: %true if total async allocate size just exceed
+ * spamming detect threshold
  * @debug_id:           unique ID for debugging
  * @transaction:        pointer to associated struct binder_transaction
  * @target_node:        struct binder_node associated with this buffer
@@ -45,7 +47,8 @@ struct binder_buffer {
 	unsigned clear_on_free:1;
 	unsigned allow_user_free:1;
 	unsigned async_transaction:1;
-	unsigned debug_id:28;
+	unsigned oneway_spam_suspect:1;
+	unsigned debug_id:27;
 
 	struct binder_transaction *transaction;
 
@@ -87,6 +90,8 @@ struct binder_lru_page {
  * @buffer_size:        size of address space specified via mmap
  * @pid:                pid for associated binder_proc (invariant after init)
  * @pages_high:         high watermark of offset in @pages
+ * @oneway_spam_detected: %true if oneway spam detection fired, clear that
+ * flag once the async buffer has returned to a healthy state
  *
  * Bookkeeping structure for per-proc address space management for binder
  * buffers. It is normally initialized during binder_init() and binder_mmap()
@@ -107,6 +112,7 @@ struct binder_alloc {
 	uint32_t buffer_free;
 	int pid;
 	size_t pages_high;
+	bool oneway_spam_detected;
 };
 
 #ifdef CONFIG_ANDROID_BINDER_IPC_SELFTEST
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 2872a7d..810c0b8 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -155,7 +155,7 @@ enum binder_stat_types {
 };
 
 struct binder_stats {
-	atomic_t br[_IOC_NR(BR_FAILED_REPLY) + 1];
+	atomic_t br[_IOC_NR(BR_ONEWAY_SPAM_SUSPECT) + 1];
 	atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
 	atomic_t obj_created[BINDER_STAT_COUNT];
 	atomic_t obj_deleted[BINDER_STAT_COUNT];
@@ -174,6 +174,7 @@ struct binder_work {
 	enum binder_work_type {
 		BINDER_WORK_TRANSACTION = 1,
 		BINDER_WORK_TRANSACTION_COMPLETE,
+		BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT,
 		BINDER_WORK_RETURN_ERROR,
 		BINDER_WORK_NODE,
 		BINDER_WORK_DEAD_BINDER,
@@ -409,6 +410,8 @@ struct binder_ref {
  * @outer_lock:           no nesting under innor or node lock
  *                        Lock order: 1) outer, 2) node, 3) inner
  * @binderfs_entry:       process-specific binderfs log file
+ * @oneway_spam_detection_enabled: process enabled oneway spam detection
+ *                        or not
  *
  * Bookkeeping structure for binder processes
  */
@@ -444,6 +447,7 @@ struct binder_proc {
 	spinlock_t inner_lock;
 	spinlock_t outer_lock;
 	struct dentry *binderfs_entry;
+	bool oneway_spam_detection_enabled;
 };
 
 /**
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 156070d..20e435f 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -241,6 +241,7 @@ struct binder_frozen_status_info {
 #define BINDER_SET_CONTEXT_MGR_EXT	_IOW('b', 13, struct flat_binder_object)
 #define BINDER_FREEZE			_IOW('b', 14, struct binder_freeze_info)
 #define BINDER_GET_FROZEN_INFO		_IOWR('b', 15, struct binder_frozen_status_info)
+#define BINDER_ENABLE_ONEWAY_SPAM_DETECTION	_IOW('b', 16, __u32)
 
 /*
  * NOTE: Two special error codes you should check for when calling
@@ -428,6 +429,13 @@ enum binder_driver_return_protocol {
 	 * The target of the last transaction (either a bcTRANSACTION or
 	 * a bcATTEMPT_ACQUIRE) is frozen.  No parameters.
 	 */
+
+	BR_ONEWAY_SPAM_SUSPECT = _IO('r', 19),
+	/*
+	 * Current process sent too many oneway calls to target, and the last
+	 * asynchronous transaction makes the allocated async buffer size exceed
+	 * detection threshold.  No parameters.
+	 */
 };
 
 enum binder_driver_command_protocol {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

