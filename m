Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6324B3DF730
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhHCWEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhHCWEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:04:07 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478D7C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 15:03:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u11-20020ad45aab0000b029033e289c093aso193296qvg.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=637ibQFbQ3sB8g1PtLDmK+JRBA/i5kGxHHIuHA5O2LE=;
        b=h75/dxJA7xiuzpPTOXcC/CgCjqwjUyhKB28mP/SOgaZrZdQEMSFPCE3r0QaoKEHveK
         CIzLPxoJJeMeEZrelZSQ2VS6kQfTzKYEDQ7ReRbPSJuAsZPi3zRHceIEkdgFP/Gvs1/+
         6KLgwZPyC+QR0Yenm1tOgE9uLtH5K9As4/UnnitiMiyA7cmrrqFYeNusfuXahby8Z5/y
         0g8+pQbsAWPx+JuYLF2uELUIS09xxpRSGmD1mAsa8PFM82vRN9Yl2HMTedo4L9KUqEni
         +RYe/VP45kXDtwDlyZKpkVGHUcl6OmmQnSg6aCQJQfDH9rNw+NLbmvJKQVpjDDM+/Od/
         Brrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=637ibQFbQ3sB8g1PtLDmK+JRBA/i5kGxHHIuHA5O2LE=;
        b=sPwftAhfO48o92bdEVqCNF0287Hw2VHENXepvtn99/6x7lAxOTobycAEGlPKzm6VzY
         49lGgIaB1feUqMu20nnPtIXhrYRMswdTn+vJVTjPv9fxLSNRVfogyF12PLevspEoj3/Q
         wBzDMOgAfT+7nDBExGAu9ANuPyvsaOvXQacSaFN0UUYWTKlpRPUY3b502udzpfLD4uGT
         tzoj+/8TOuZa1pf7hNYrnE7kQ89j9KFzCXKUEoJb4QmvwhXnj9h+WHV9snrg0KNZmhkv
         w+tqIxYELOMKcpYSzexp2Y/uG1SMssW3rRQiy9cjZMEzD/uH+MWwsxTaq14OKzn5j2i4
         brBQ==
X-Gm-Message-State: AOAM533Za6s0OajE4gtFTvfEXIwv2vlm0ubFoiajdNSD7nOodeeyb3a0
        6rAILD0dU4yBA5YI4FgJ8A/FDyhPL6U=
X-Google-Smtp-Source: ABdhPJyJVS6APh/OsnjvGeX7dKcinWqcZiFQx5ZRiOQGbRVqjhMvRMeUj4SyCumwxWjmLyXgre61tljQG0c=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:ec88:ca07:cb52:bb88])
 (user=surenb job=sendgmr) by 2002:a05:6214:2ce:: with SMTP id
 g14mr23549247qvu.46.1628028235332; Tue, 03 Aug 2021 15:03:55 -0700 (PDT)
Date:   Tue,  3 Aug 2021 15:03:50 -0700
Message-Id: <20210803220351.245332-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v5 1/2] mm: introduce process_mrelease system call
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
          (See pidofd_open(2) for further information)

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
changes in v5:
- Changed links, per David Hildenbrand and Michal Hocko
- Condensed the background section in the description, per David Hildenbrand
- Changed flags check, per David Hildenbrand
- Changed description for ENOSYS in the manual pages, per David Hildenbrand
- Changed wording from "SIGKILLed" to "exiting" process in the manual pages
description, per Michal Hocko
- Used find_lock_task_mm() to lock the task_struct, per Michal Hocko
- Added check for MMF_OOM_SKIP, per Michal Hocko

 mm/oom_kill.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c729a4c4a1ac..d19511a4b6b8 100644
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
@@ -1141,3 +1142,68 @@ void pagefault_out_of_memory(void)
 	out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
 }
+
+SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
+{
+#ifdef CONFIG_MMU
+	struct mm_struct *mm = NULL;
+	struct task_struct *task;
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
+	task = find_lock_task_mm(task);
+	if (!task) {
+		ret = -ESRCH;
+		goto put_pid;
+	}
+	if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
+		mm = task->mm;
+		mmget(mm);
+	}
+	task_unlock(task);
+	if (!mm) {
+		ret = -EINVAL;
+		goto put_task;
+	}
+	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
+		ret = -ESRCH;
+		goto put_mm;
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

