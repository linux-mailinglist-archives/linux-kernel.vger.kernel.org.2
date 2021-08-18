Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C03F3EF85A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhHRDGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhHRDGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:06:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE10C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:06:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w6so904582plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cQ/w5RG3C2hIi0CgETW1FqT7GA9cZi7ZMnUujllEppk=;
        b=bVKU4VG183sZaacdvgNqQkVpJ5HK39LGBlZjy1tM8DOMnJlSz8m8pn5YmBFApgi+Gc
         3cvdpuqF/q0F1DpyWtTKyCqJT+0XjfDqOa/kqgAnVsze27XyHrJKIIjdkY3G2gK6vTdm
         iCx1n6N5tv9IrmWxI3SzFHFP07yFjKQrkiGPnkkxA8VKFr4O3pVhEpCeOhoObfngd6QP
         QMZ9tELaaiNmV2XdwHfVySiwSLNhpQZxW3dbHSY7aPJ+zeztcr71Xtb6J+AdGZn3clz8
         kuSxxR9/WtrVGDu8UY+6oX/m2d8YxX4bgNPpziiGK4erM3TJQlUA77UK2Yrq/JSBWpzM
         kG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cQ/w5RG3C2hIi0CgETW1FqT7GA9cZi7ZMnUujllEppk=;
        b=BbXaAQilrf55hl6RcOBd8IARnuEHdQq4jnipXULVHZDwjlWdMCjbJORkZbt7CbHcTE
         XqUQLGX+ym4YfI6Sg6d7lG7FyZlMcB3SQwlk3rxTVuDofvFEhyRWPCcrE3K6BtZPbCQ3
         FxITVZ5KPnX+gXMG8hDldgKBG7plGLSUkno/9UcG0W5PGWqrioFVif58ZIyxi9yjuNUZ
         /daYhF6qpIIlcqxyv9omGKFxzOXyZWLv7bIS1XGbvf4k2biNV3fQkE/wPU2jGF2nDrIa
         wdUY3T0/uFhnNxZm+39xChGc5DxtnjGA0vpdKWKiAsXWHZxEnFoW6xq4MraL7oCCGyYb
         BeqA==
X-Gm-Message-State: AOAM532QXaqx42Rla0SWeweiIGRE2mIKNbx4w63K4hDqClJ2aRO5fCHS
        QTdkId6JENW83f22NywQtfvvXw==
X-Google-Smtp-Source: ABdhPJzHgcwJ8OU1B0tB+wFlIKuZBwEXydmU+5+jGBlx89g8eYGpNhq2Cz17xxn53uqpy5CZshjnFg==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr6874190pjj.165.1629255966070;
        Tue, 17 Aug 2021 20:06:06 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n13sm3853989pff.164.2021.08.17.20.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 20:06:05 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Olivier Langlois <olivier@trillion01.com>,
        Tony Battersby <tonyb@cybernetics.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] kernel: make TIF_NOTIFY_SIGNAL and core dumps co-exist
Message-ID: <76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk>
Date:   Tue, 17 Aug 2021 21:06:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_work being added with notify == TWA_SIGNAL will utilize
TIF_NOTIFY_SIGNAL for signaling the targeted task that work is available.
If this happens while a task is going through a core dump, it'll
potentially disturb and truncate the dump as a signal interruption.

Have task_work_add() with notify == TWA_SIGNAL check if a task has been
signaled for a core dump, and refuse to add the work if that is the case.
When a core dump is invoked, explicitly check for TIF_NOTIFY_SIGNAL and
run any pending task_work if that is set. This is similar to how an
exiting task will not get new task_work added, and we return the same
error for the core dump case. As we return success or failure from
task_work_add(), the caller has to be prepared to handle this case
already.

Currently this manifests itself in that io_uring tasks that end up using
task_work will experience truncated core dumps.

Reported-by: Tony Battersby <tonyb@cybernetics.com>
Reported-by: Olivier Langlois <olivier@trillion01.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/coredump.c b/fs/coredump.c
index 07afb5ddb1c4..ca7c1ee44ada 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -602,6 +602,14 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		.mm_flags = mm->flags,
 	};
 
+	/*
+	 * task_work_add() will refuse to add work after PF_SIGNALED has
+	 * been set, ensure that we flush any pending TIF_NOTIFY_SIGNAL work
+	 * if any was queued before that.
+	 */
+	if (test_thread_flag(TIF_NOTIFY_SIGNAL))
+		tracehook_notify_signal();
+
 	audit_core_dumps(siginfo->si_signo);
 
 	binfmt = mm->binfmt;
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 1698fbe6f0e1..1ab28904adc4 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -41,6 +41,12 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		head = READ_ONCE(task->task_works);
 		if (unlikely(head == &work_exited))
 			return -ESRCH;
+		/*
+		 * TIF_NOTIFY_SIGNAL notifications will interfere with
+		 * a core dump in progress, reject them.
+		 */
+		if (notify == TWA_SIGNAL && (task->flags & PF_SIGNALED))
+			return -ESRCH;
 		work->next = head;
 	} while (cmpxchg(&task->task_works, head, work) != head);

-- 
Jens Axboe

