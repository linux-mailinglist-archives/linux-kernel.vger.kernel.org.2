Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EE0356B6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbhDGLjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:39:49 -0400
Received: from smtp.uniroma2.it ([160.80.6.16]:42722 "EHLO smtp.uniroma2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234582AbhDGLjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:39:48 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Apr 2021 07:39:47 EDT
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 137BXSaY025813;
        Wed, 7 Apr 2021 13:33:33 +0200
Received: from localhost.localdomain (unknown [160.80.103.223])
        by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id A5F331200A8;
        Wed,  7 Apr 2021 13:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
        s=ed201904; t=1617795203; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFLvlBv2rnxQe/cn7S6pxFtDAf5FdbP5U7kkFlY9MiU=;
        b=fm0HC0e8GGywAnFS7Ktqj9iKq3hUxxYA1tX23RnvgdmLTg2QysUZpbl73tUbVH90y9I3Hz
        zt9KrLFJbtOyBoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
        t=1617795203; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFLvlBv2rnxQe/cn7S6pxFtDAf5FdbP5U7kkFlY9MiU=;
        b=sPVyKhPQCLWl2axtY8JxwHchRu8+zVRcyp639mASPBWryQkSGKPR9XXrrJ9/77BDxBpGrJ
        UTiWhsZebF0tunCCiF0ihnOAPE9PQp58qqKn8fFufbE39+Oqxn0nH1X9gPh+RIxCwiyVsz
        gQMzk5KbYP9Yp5nH5JJ7Omvq7RkI5UQDpeOWCwPTyyLj7B/ps5sr31ALcSVA8u3luKS1Ce
        jDrQlu8QbpVoXLWYgu9BxmZlRQ9Gwi1hgfT9ClM1t79Hhff/pXhdmF4EjBbzhUmHz3MSUR
        Mzjt2+cg99dYUsFgVbCzfVUQkfkfpNCrcaJq8Q8KarG+lv3SeJfcVB4mN08Tjw==
From:   Marco Faltelli <marco.faltelli@uniroma2.it>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Marco Faltelli <marco.faltelli@uniroma2.it>
Subject: [PATCH] kernel/time: Feedback reply for hr_sleep syscall, a fine-grained sleep service
Date:   Wed,  7 Apr 2021 11:32:11 +0000
Message-Id: <20210407113211.2398-1-marco.faltelli@uniroma2.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407112958.2350-1-marco.faltelli@uniroma2.it>
References: <20210407112958.2350-1-marco.faltelli@uniroma2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current sleep services (nanosleep) provide sleep periods very far from the expectations when scheuling microsecond-scale timers. On our testbed, using rdtscp() before and after a nanosleep() syscall to measure the effective elapsed time with a 1us timer, we got ~59us.
Even with larger timeout periods, the difference is still evident (e.g., with a 100us timer, we measured ~158us of elapsed time).
We believe that one of the reasons is the use of the timespec structure, that needs to be copied for user to kernel and then converted into a single-value representation.
In our work Metronome (https://dl.acm.org/doi/pdf/10.1145/3386367.3432730) we had the need for a precise microsecond-granularity sleep service, as nanosleep() was far from our needs, so we developed hr_sleep(), a new sleep service. Since the sleep periods needed in our case are small, we don't want our sleep service to re-schedule a timer in case of a signal interruption, so it just returns -EINTR to the user. The user must be aware that this is a best-effort sleep service, so the sleep period specified is an upper-bound of the effective elapsed time.
We believe this patch can be useful in applications where fine-grained granularity is requested for small sleep periods, and re-scheduling the timer in case of a signal is not mandatory.
In the paper previously linked, Section 3.1 provides more details about hr_sleep and Section 3.3 extensively evaluates hr_sleep() and compares it to nanosleep(). For a 1us timeout, hr_sleep() elapses ~3.8us in mean vs. the ~59us of nanosleep().
hr_sleep has been previously submitted at https://lore.kernel.org/lkml/20210115180733.5663-1-marco.faltelli@uniroma2.it/.
This commit answers to the previous feedback in https://lore.kernel.org/lkml/CALCETrWfnL=3M3nmmHs-a3si5JptSCtF6cEtHVtsDNwA5mHnRg@mail.gmail.com/ and applies the requested changes.

Signed-off-by: Marco Faltelli <marco.faltelli@uniroma2.it>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 kernel/time/hrtimer.c                  | 67 ++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7bf01cbe582f..85b14dfa40fb 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -364,6 +364,7 @@
 440	common	process_madvise		sys_process_madvise
 441	common	epoll_pwait2		sys_epoll_pwait2
 442	common	mount_setattr		sys_mount_setattr
+443	common	hr_sleep		sys_hr_sleep
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4a66725b1d4a..887c01392e08 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2006,6 +2006,73 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 }
 #endif
 
+
+
+#ifdef CONFIG_64BIT
+
+
+struct control_record {
+	struct task_struct *task;
+	int awake;
+	struct hrtimer hr_timer;
+};
+
+
+static enum hrtimer_restart hr_sleep_callback(struct hrtimer *timer)
+{
+	struct control_record *control;
+	struct task_struct *the_task;
+
+	control = (control_record *)container_of(timer, control_record, hr_timer);
+	control->awake = 1;
+	the_task = control->task;
+	wake_up_process(the_task);
+
+	return HRTIMER_NORESTART;
+}
+
+
+
+/**
+ * hr_sleep - a high-resolution sleep service for fine-grained timeouts
+ * @nanoseconds:	the requested sleep period in nanoseconds
+ *
+ * Returns:
+ * 0 when the sleep request successfully terminated
+ * -EINVAL if a sleep period < 0 is requested
+ * -EINTR if a signal interrupted the calling thread
+ */
+SYSCALL_DEFINE1(hr_sleep, long, nanoseconds)
+{
+	DECLARE_WAIT_QUEUE_HEAD(the_queue);
+	struct control_record control;
+	ktime_t ktime_interval;
+	struct restart_block *restart;
+
+	if (nanoseconds < 0)
+		return -EINVAL;
+
+	if (nanoseconds == 0)
+		return 0;
+
+	ktime_interval = ktime_set(0, nanoseconds);
+	hrtimer_init(&(control.hr_timer), CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	control.hr_timer.function = &hr_sleep_callback;
+	control.task = current;
+	control.awake = 0;
+	hrtimer_start(&(control.hr_timer), ktime_interval, HRTIMER_MODE_REL);
+	wait_event_interruptible(the_queue, control.awake == 1);
+	hrtimer_cancel(&(control.hr_timer));
+	if (control.awake == 0)
+		//We have been interrupted by a signal
+		return -EINTR;
+	return 0;
+
+}
+
+#endif
+
+
 /*
  * Functions related to boot-time initialization:
  */
-- 
2.25.1

