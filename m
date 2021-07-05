Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B113BB98C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhGEIrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhGEIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:47:43 -0400
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F59C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 01:45:06 -0700 (PDT)
Received: by mail-lj1-x249.google.com with SMTP id v10-20020a2ea60a0000b029017fd05dc0aaso4308556ljp.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 01:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XT1F6bsaZFgcmmxxyjZZuJTZD371QBzAaF2qKad4ZRA=;
        b=vN2Y2GrXM9wFYnK8wro/zQ6xDDmrrViyrbnBQ/4RMgPlUiGyKcoYBPaG1wATVX1mUc
         HLLbWWydLEqq+/RJ8CvpnNaii17d0JfOUVy3Mc9JbwsqeWqH7aKWjt7xHWqLYzdP6USq
         myjSXPGUDxoAoC8er0ihCXFL4B1umZj8KSlEd2WQOO/OF3SD6fsbJlMNS+levqcWDZtE
         P717hU7sFwpkOAu26fqpZOF5y9tekPitlEOa4PDHMpZcjdYNS0otmoJBrj16WB4XXwx7
         yHqFBHAIswo7fFD3lYb5dIXaxP2ZnUxMyfYPPD+auIZzPgWS5+50kXLs82lARyxwGE1o
         8LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XT1F6bsaZFgcmmxxyjZZuJTZD371QBzAaF2qKad4ZRA=;
        b=epph25lCb+g9glY5EB+yI0RtHy7I/uzHgs/5dvP5VGe+Wp1e3hslkDvbJMluM/vGHe
         NaJV1NtEQ/ZE5WO9V2Spw/67upO1Hhu9HeLmtZ6g5H5dM1ot6JM5kYR6Fkt023L06woa
         CWM+LufYhuMZQ4CDDXFYbjPBoGWr5qx3vGGVFZrKAinLy0+mutJZfvX9WTpusWGpNp4v
         LGhkH0uSH4EUrprUBAS9Rqz7D43aB0vzqdrrei/VKkY2axoEG6A5oBaQkkq+K8hKSxD1
         hgVQiv8zc9oUmz/67eF/WgRujneYUcIkXUzyy/IYDpO/C1X4EXgrBGdQ+LxmL0hi3EMg
         jeFA==
X-Gm-Message-State: AOAM532vfUYBrHuO07P7woVX22FCAtw0Q6URudK7nX1XAiQKOc97SxFr
        ybpSB7E3I14Pkc5fpLf8+afp2udcBg==
X-Google-Smtp-Source: ABdhPJwJJ8IYO0yfnhbmAMrM9usbbtUz3OfJO2G4Ka8fzvRpGpNhtc7thfb1yiXSp6CO0GpfORq4d5EOjA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:dddd:647c:7745:e5f7])
 (user=elver job=sendgmr) by 2002:a19:6d01:: with SMTP id i1mr10104024lfc.422.1625474704103;
 Mon, 05 Jul 2021 01:45:04 -0700 (PDT)
Date:   Mon,  5 Jul 2021 10:44:52 +0200
Message-Id: <20210705084453.2151729-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3 1/2] perf: Fix required permissions if sigtrap is requested
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org
Cc:     tglx@linutronix.de, mingo@kernel.org, dvyukov@google.com,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, ebiederm@xmission.com,
        omosnace@redhat.com, serge@hallyn.com,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If perf_event_open() is called with another task as target and
perf_event_attr::sigtrap is set, and the target task's user does not
match the calling user, also require the CAP_KILL capability or
PTRACE_MODE_ATTACH permissions.

Otherwise, with the CAP_PERFMON capability alone it would be possible
for a user to send SIGTRAP signals via perf events to another user's
tasks. This could potentially result in those tasks being terminated if
they cannot handle SIGTRAP signals.

Note: The check complements the existing capability check, but is not
supposed to supersede the ptrace_may_access() check. At a high level we
now have:

	capable of CAP_PERFMON and (CAP_KILL if sigtrap)
		OR
	ptrace_may_access(...) // also checks for same thread-group and uid

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Cc: <stable@vger.kernel.org> # 5.13+
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Upgrade ptrace mode check to ATTACH if attr.sigtrap, otherwise it's
  possible to change the target task (send signal) even if only read
  ptrace permissions were granted (reported by Eric W. Biederman).

v2: https://lkml.kernel.org/r/20210701083842.580466-1-elver@google.com
* Drop kill_capable() and just check CAP_KILL (reported by Ondrej Mosnacek).
* Use ns_capable(__task_cred(task)->user_ns, CAP_KILL) to check for
  capability in target task's ns (reported by Ondrej Mosnacek).

v1: https://lkml.kernel.org/r/20210630093709.3612997-1-elver@google.com
---
 kernel/events/core.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe88d6eea3c2..f79ee82e644a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12152,10 +12152,33 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (task) {
+		unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
+		bool is_capable;
+
 		err = down_read_interruptible(&task->signal->exec_update_lock);
 		if (err)
 			goto err_file;
 
+		is_capable = perfmon_capable();
+		if (attr.sigtrap) {
+			/*
+			 * perf_event_attr::sigtrap sends signals to the other
+			 * task. Require the current task to also have
+			 * CAP_KILL.
+			 */
+			rcu_read_lock();
+			is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
+			rcu_read_unlock();
+
+			/*
+			 * If the required capabilities aren't available, checks
+			 * for ptrace permissions: upgrade to ATTACH, since
+			 * sending signals can effectively change the target
+			 * task.
+			 */
+			ptrace_mode = PTRACE_MODE_ATTACH_REALCREDS;
+		}
+
 		/*
 		 * Preserve ptrace permission check for backwards compatibility.
 		 *
@@ -12165,7 +12188,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+		if (!is_capable && !ptrace_may_access(task, ptrace_mode))
 			goto err_cred;
 	}
 
-- 
2.32.0.93.g670b81a890-goog

