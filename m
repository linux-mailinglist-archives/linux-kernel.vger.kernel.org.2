Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4B3E1A15
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhHERJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbhHERJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:09:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E0C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 10:09:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso6866202ybq.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+zx+R/aH4qWZGyHwkR7SYHeyFa/mTVIB2xoTRcOL2kA=;
        b=X15w+hbY202HoRF2BgKV3TBwnxFPKHmSRGo/2/e2OazC8uosEGVOuMtTJ7K174GU7M
         D5q/EkjLW+LFcLEoOU1vGdktpk/6jBrc5xiF8KGLF7n4hAk+3ns+2p+mHOzjhdvfbNFW
         xZr2RaRnDl9QvEXzqUCY2lCyXbYuboWR/f/rURbhmljhhQ2jYEehy98BYIe96/oMvbYp
         XUWxoX6vFc568Z1Hv7aPodzf9B8VyxoT6xAEPNBShApOwPWx7ob6KuLXZtCNjOykyRbc
         hXuuGNvCpl0VitcwSc1J6/gnC3rjzkFzhy1f+b+OjwwoMxh+TN5YuehviRQb4N1CoKzu
         DKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+zx+R/aH4qWZGyHwkR7SYHeyFa/mTVIB2xoTRcOL2kA=;
        b=jVEzCoem4GhE9cQWHf/cee8y3Iq4O7TO2EcRuKh3eJoEc5otxawN9CTRQxRAf4x2OD
         4q80JWmbu8ZFR97zePhegAIa/LinMbfF3lDpqOf+w+tJqWt30dHmVnrVZIL/luNktxT+
         lnNgZZ4+CkbZSf1O9neRRpV82VtU5Lku0DMwRFbqsIhLJ9OYYgTQpLteWA6GRMjRq7EA
         BsRvfh84zxOIcD62EyYuUZZvC4zHrQpLAEESp26JFQMybGegC7ddEgIqolwZHZD1N2pj
         0LLStxApMAZO9amEgJhGqtNJTHcfoMKDRKJ3J0gYwvXTkL7CTfyj5Z4+gpSwQ/sLmP8t
         aoOw==
X-Gm-Message-State: AOAM533a4lrTkTVv8oQMGrTeWjnTEp0j24jO1/eKYnEni8RtYwAeZgAJ
        XNi2Hz/eexn2h79Wc8RP4WrADWzuG+4=
X-Google-Smtp-Source: ABdhPJx0EeQxp7X7u3YJ02gccOazao9ljKDcwhBexeAx/YYHjWfxyBmLkqV4o6hkTPQ++gsLYD6uurwPeRc=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:bc94:77da:4200:8d37])
 (user=surenb job=sendgmr) by 2002:a25:4fc4:: with SMTP id d187mr7092225ybb.245.1628183343179;
 Thu, 05 Aug 2021 10:09:03 -0700 (PDT)
Date:   Thu,  5 Aug 2021 10:08:58 -0700
Message-Id: <20210805170859.2389276-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v7 1/2] mm: introduce process_mrelease system call
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In modern systems it's not unusual to have a system component monitoring
memory conditions of the system and tasked with keeping system memory
pressure under control. One way to accomplish that is to kill
non-essential processes to free up memory for more important ones.
Examples of this are Facebook's OOM killer daemon called oomd and
Android's low memory killer daemon called lmkd.
For such system component it's important to be able to free memory
quickly and efficiently. Unfortunately the time process takes to free
up its memory after receiving a SIGKILL might vary based on the state
of the process (uninterruptible sleep), size and OPP level of the core
the process is running. A mechanism to free resources of the target
process in a more predictable way would improve system's ability to
control its memory pressure.
Introduce process_mrelease system call that releases memory of a dying
process from the context of the caller. This way the memory is freed in
a more controllable way with CPU affinity and priority of the caller.
The workload of freeing the memory will also be charged to the caller.
The operation is allowed only on a dying process.

After previous discussions [1, 2, 3] the decision was made [4] to introduce
a dedicated system call to cover this use case.

The API is as follows,

          int process_mrelease(int pidfd, unsigned int flags);

        DESCRIPTION
          The process_mrelease() system call is used to free the memory of
          an exiting process.

          The pidfd selects the process referred to by the PID file
          descriptor.
          (See pidfd_open(2) for further information)

          The flags argument is reserved for future use; currently, this
          argument must be specified as 0.

        RETURN VALUE
          On success, process_mrelease() returns 0. On error, -1 is
          returned and errno is set to indicate the error.

        ERRORS
          EBADF  pidfd is not a valid PID file descriptor.

          EAGAIN Failed to release part of the address space.

          EINTR  The call was interrupted by a signal; see signal(7).

          EINVAL flags is not 0.

          EINVAL The memory of the task cannot be released because the
                 process is not exiting, the address space is shared
                 with another live process or there is a core dump in
                 progress.

          ENOSYS This system call is not supported, for example, without
                 MMU support built into Linux.

          ESRCH  The target process does not exist (i.e., it has terminated
                 and been waited on).

[1] https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
[2] https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
[3] https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
[4] https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
changes in v7:
- Fixed pidfd_open misspelling, per Andrew Morton
- Fixed wrong task pinning after find_lock_task_mm() issue, per Michal Hocko
- Moved MMF_OOM_SKIP check before task_will_free_mem(), per Michal Hocko

 mm/oom_kill.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c729a4c4a1ac..a4d917b43c73 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -28,6 +28,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/debug.h>
 #include <linux/swap.h>
+#include <linux/syscalls.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 #include <linux/cpuset.h>
@@ -1141,3 +1142,75 @@ void pagefault_out_of_memory(void)
 	out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
 }
+
+SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
+{
+#ifdef CONFIG_MMU
+	struct mm_struct *mm = NULL;
+	struct task_struct *task;
+	struct task_struct *p;
+	unsigned int f_flags;
+	struct pid *pid;
+	long ret = 0;
+
+	if (flags)
+		return -EINVAL;
+
+	pid = pidfd_get_pid(pidfd, &f_flags);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task) {
+		ret = -ESRCH;
+		goto put_pid;
+	}
+
+	/*
+	 * If the task is dying and in the process of releasing its memory
+	 * then get its mm.
+	 */
+	p = find_lock_task_mm(task);
+	if (!p) {
+		ret = -ESRCH;
+		goto put_pid;
+	}
+	if (task != p) {
+		get_task_struct(p);
+		put_task_struct(task);
+		task = p;
+	}
+
+	/* If the work has been done already, just exit with success */
+	if (test_bit(MMF_OOM_SKIP, &task->mm->flags))
+		goto put_task;
+
+	if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
+		mm = task->mm;
+		mmget(mm);
+	}
+	task_unlock(task);
+	if (!mm) {
+		ret = -EINVAL;
+		goto put_task;
+	}
+
+	if (mmap_read_lock_killable(mm)) {
+		ret = -EINTR;
+		goto put_mm;
+	}
+	if (!__oom_reap_task_mm(mm))
+		ret = -EAGAIN;
+	mmap_read_unlock(mm);
+
+put_mm:
+	mmput(mm);
+put_task:
+	put_task_struct(task);
+put_pid:
+	put_pid(pid);
+	return ret;
+#else
+	return -ENOSYS;
+#endif /* CONFIG_MMU */
+}
-- 
2.32.0.554.ge1b32706d8-goog

