Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CF13894DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhESR73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230164AbhESR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621447088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AgEGA/K5K+QktGBC6c0MipgQhGlt0bBl5EEaP58uqPM=;
        b=CQvzqSFx742BScwm+c+aCoK9CfR0TJvgnhCPI/isqAtZMWce5r+BCLHFaOeqYd52rfqoxI
        g4okg11ZOkW7m44OCKt5mWOentkmkLX1vZ6imBEcVL66qpl3fx8BgX9J7lDRYJ/FHdURzl
        L+bInPXtKrBNs5iWqY2AiiwWEKy0bUg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-tsL-5xVkN7aYpXWlxVFb6w-1; Wed, 19 May 2021 13:58:07 -0400
X-MC-Unique: tsL-5xVkN7aYpXWlxVFb6w-1
Received: by mail-wm1-f69.google.com with SMTP id l15-20020a1ced0f0000b029017140e7436dso863144wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgEGA/K5K+QktGBC6c0MipgQhGlt0bBl5EEaP58uqPM=;
        b=bWoPp90hUEu+4sZf0o4wTtdcmkAc8SLSb/zSMbPK/2uIU0E4AGY+Ez0B0KsaYVJyc9
         WEflSaxS6b4tbQBqTRDF5XyyN47/uwHVYgxiXIJXEY9nZwnmO42dYPdRFjgnJPvbJ3pm
         Z9rP0tdUrK6w3eFbk9cOpSTN4mMVmg14Uc+mlqHuDqCk4PGp1YJIhElY2z8yUin8M4ID
         l8WiG9FEyMLGggIeR7ESma+kpPGtL1uNOMbLngORwrHNuQ99x8B+yWFAB0HDwWBI4Xqp
         K8TQblLgiPHWxYEUjoVTRNCjOgbIhT3F+QLTNqKA/BeLWlcNgCr4vEkfff6vTokrVN5S
         gneA==
X-Gm-Message-State: AOAM532YndpfvWXsBEZPCXg3fGcJsL7UweIr7vr7C/AyxIXGTNkCCpc9
        WsddaV9ZmsM5UhOmCMVCNw6MH5MdmbmO5/0ED45FmuaY1IhfUDwH6TeF/hrhi4+ltARhIkZBsJG
        bCKZjSYUzUj3VEm3WpEMSe/g5
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr420143wmj.157.1621447085680;
        Wed, 19 May 2021 10:58:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcZsttxJjsHCGUVTEbdmnDCyG4Bdoa7mlTANG5CpMneKillIBlqKFBErwc/EJ9OaappoLhrQ==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr420126wmj.157.1621447085417;
        Wed, 19 May 2021 10:58:05 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1c02:2700:ca67:ddac:104e:9b35])
        by smtp.gmail.com with ESMTPSA id r2sm102138wrv.39.2021.05.19.10.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 10:58:05 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     rostedt@goodmis.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, corbet@lwn.net, mtosatti@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [RFC] trace: Add option for polling ring buffers
Date:   Wed, 19 May 2021 19:57:55 +0200
Message-Id: <20210519175755.670876-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To minimize trace's effect on isolated CPUs. That is, CPUs were only a
handful or a single, process are allowed to run. Introduce a new trace
option: 'poll-rb'.

This option changes the heuristic used to wait for data on trace
buffers. The default one, based on wait queues, will trigger an IPI[1]
on the CPU responsible for new data, which will take care of waking up
the trace gathering process (generally trace-cmd). Whereas with
'poll-rb' we will poll (as in busy-wait) the ring buffers from the trace
gathering process, releasing the CPUs writing trace data from doing any
wakeup work.

This wakeup work, although negligible in the vast majority of workloads,
may cause unwarranted latencies on systems running trace on isolated
CPUs. This is made worse on PREEMPT_RT kernels, as they defer the IPI
handling into a kernel thread, forcing unwarranted context switches on
otherwise extremely busy CPUs.

To illustrate this, tracing with PREEMPT_RT=y on an isolated CPU with a
single process pinned to it (NO_HZ_FULL=y, and plenty more isolation
options enabled). I see:
  - 50-100us latency spikes with the default trace-cmd options
  - 14-10us latency spikes with 'poll-rb'
  - 11-8us latency spikes with no tracing at all

The obvious drawback of 'poll-rb' is putting more pressure on the
housekeeping CPUs. Wasting cycles. Hence the notice in the documentation
discouraging its use in general.

[1] The IPI, in this case, an irq_work, is needed since trace might run
in NMI context. Which is not suitable for wake-ups.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 Documentation/trace/ftrace.rst | 10 +++++
 include/linux/ring_buffer.h    |  2 +-
 kernel/trace/ring_buffer.c     | 76 +++++++++++++++++++---------------
 kernel/trace/trace.c           |  2 +-
 kernel/trace/trace.h           |  1 +
 5 files changed, 55 insertions(+), 36 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 62c98e9bbdd9..224ed8652101 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1248,6 +1248,16 @@ Here are the available options:
 	with the "nop" tracer is the same as just enabling the
 	"branch" tracer.
 
+  poll-rb
+        Use polling instead of waiting for new data in ringbuffers. The wait
+        heuristic will trigger IPIs on the CPU resposible for new data, which
+        can generate false positives when tracing low latency workloads (or the
+        IPIs themselves). This is made worse on PREEMPT_RT kernels, as they
+        defer the IPI handling into a kernel thread, forcing unwarranted
+        context switches on otherwise extremely busy processes.
+
+        When in doubt don't enable this, it'll just waste cpu cycles.
+
 .. tip:: Some tracers have their own options. They only appear in this
        file when the tracer is active. They always appear in the
        options directory.
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index dac53fd3afea..b492061d369b 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -98,7 +98,7 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 	__ring_buffer_alloc((size), (flags), &__key);	\
 })
 
-int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
+int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full, bool poll);
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2c0ee6484990..7840489623b2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -892,14 +892,17 @@ static void rb_wake_up_waiters(struct irq_work *work)
  * @buffer: buffer to wait on
  * @cpu: the cpu buffer to wait on
  * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
+ * @poll: don't use wait queues, poll the ring buffer
  *
  * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
  * as data is added to any of the @buffer's cpu buffers. Otherwise
  * it will wait for data to be added to a specific cpu buffer.
  */
-int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
+int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full, bool poll)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
+	struct wait_queue_head *wq_head;
+	bool *waiters_pending;
 	DEFINE_WAIT(wait);
 	struct rb_irq_work *work;
 	int ret = 0;
@@ -920,37 +923,41 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 		work = &cpu_buffer->irq_work;
 	}
 
+	if (full) {
+		wq_head = &work->full_waiters;
+		waiters_pending = &work->full_waiters_pending;
+	} else {
+		wq_head = &work->waiters;
+		waiters_pending = &work->waiters_pending;
+	}
 
 	while (true) {
-		if (full)
-			prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
-		else
-			prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
+		if (!poll) {
+			prepare_to_wait(wq_head, &wait, TASK_INTERRUPTIBLE);
 
-		/*
-		 * The events can happen in critical sections where
-		 * checking a work queue can cause deadlocks.
-		 * After adding a task to the queue, this flag is set
-		 * only to notify events to try to wake up the queue
-		 * using irq_work.
-		 *
-		 * We don't clear it even if the buffer is no longer
-		 * empty. The flag only causes the next event to run
-		 * irq_work to do the work queue wake up. The worse
-		 * that can happen if we race with !trace_empty() is that
-		 * an event will cause an irq_work to try to wake up
-		 * an empty queue.
-		 *
-		 * There's no reason to protect this flag either, as
-		 * the work queue and irq_work logic will do the necessary
-		 * synchronization for the wake ups. The only thing
-		 * that is necessary is that the wake up happens after
-		 * a task has been queued. It's OK for spurious wake ups.
-		 */
-		if (full)
-			work->full_waiters_pending = true;
-		else
-			work->waiters_pending = true;
+			/*
+			 * The events can happen in critical sections where
+			 * checking a work queue can cause deadlocks.  After
+			 * adding a task to the queue, this flag is set only to
+			 * notify events to try to wake up the queue using
+			 * irq_work.
+			 *
+			 * We don't clear it even if the buffer is no longer
+			 * empty. The flag only causes the next event to run
+			 * irq_work to do the work queue wake up. The worse
+			 * that can happen if we race with !trace_empty() is
+			 * that an event will cause an irq_work to try to wake
+			 * up an empty queue.
+			 *
+			 * There's no reason to protect this flag either, as
+			 * the work queue and irq_work logic will do the
+			 * necessary synchronization for the wake ups. The only
+			 * thing that is necessary is that the wake up happens
+			 * after a task has been queued. It's OK for spurious
+			 * wake ups.
+			 */
+			*waiters_pending = true;
+		}
 
 		if (signal_pending(current)) {
 			ret = -EINTR;
@@ -983,13 +990,14 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 				break;
 		}
 
-		schedule();
+		if (!poll)
+			schedule();
+		else
+			schedule_timeout_interruptible(1);
 	}
 
-	if (full)
-		finish_wait(&work->full_waiters, &wait);
-	else
-		finish_wait(&work->waiters, &wait);
+	if (!poll)
+		finish_wait(wq_head, &wait);
 
 	return ret;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c4e702133e8..8408b0f50519 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1887,7 +1887,7 @@ static int wait_on_pipe(struct trace_iterator *iter, int full)
 		return 0;
 
 	return ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file,
-				full);
+				full, iter->tr->trace_flags & TRACE_ITER_POLL_RB);
 }
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index cd80d046c7a5..045bef803549 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1198,6 +1198,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(EVENT_FORK,		"event-fork"),		\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
+		C(POLL_RB,		"poll-rb"),		\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
-- 
2.31.1

