Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680983B8EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbhGAInW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbhGAInV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:43:21 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFCDC061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 01:40:51 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i3-20020a05620a1503b02903b2ffa0a87fso3690877qkk.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5iHoNZMOeP6TxsWwP/0krCRRwCbLGs4FQeU+EZRnVpw=;
        b=FMpj5JxuvGNfBzF6vXgu2ty+hfpspeI/EDm3LJYTsJoaCNE3k6TVARsbPBxXFX4nWm
         1HoNvamktFRK3begTvvzpfatrEad5S90Acr/VAL1gvywFra+8hYcXivsK0/KDNEQmoL+
         Vfqp6Ej0zCR4SHWdJKdm0irz/YBGo4kKOJyhXv7XrFMuCtX7xJfrRIGY7RGmQMtl2ifu
         dm8fMDH76QKCAL5NJBWJXdxOoqNHMBdk5/w03UE3OnrblaMwURXPUro8tyjfXesNsIeB
         tJIHFJqgIgZzyVsNbxUVFSlBS3fFw7lBxxoX5x3NbOv5OZ4Xm2qPiN7EUtBzyqiN9TXX
         oSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5iHoNZMOeP6TxsWwP/0krCRRwCbLGs4FQeU+EZRnVpw=;
        b=HVL418kdvMus8Fw4NGT7matN5/CSMTqzm92PsMW5CkMKcxzjggJ8BwxfV4EpC63MW6
         Z76//Mz7nr1lIB9Y6WqcSEtrhJ/KA5VP9QeET5jmIe/cnzP+asmajWCVrNXa2mKWEiiC
         jKXn3OFGwMKQiZzCPMrx91ksmJ+QNQLSd1AF3/th83Q9Kx4ep0Lfxf6mEP4eTasSiWOO
         MntoPA53KhfhY88q0ANs2CHzdFniy/7EONPQl5uKh7tPh1+xMUFSey6Yl7/nwHetVKZd
         ikDgf303r4Sc1oo+Wfl2ObT/5SUNN+v5nC9Ll1s12nXLex2s4uqIB9HXszlyyuYoqTH8
         rUNA==
X-Gm-Message-State: AOAM5323oRBBH9RvfuO/b/+6EOHAwiumEIxEA5yqzR7hZ2teWNYSN4nW
        xMuyKNUreiTFBeSp99WIiknow/gfqg==
X-Google-Smtp-Source: ABdhPJzh0BWd6kKdTshLd8GOa6BvrBKw2SUY1e5kpAyenT4O3KV55wn97GNSQeSm1oacAHDSzUhCAtKGzg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:8b0e:c57f:ff29:7e4])
 (user=elver job=sendgmr) by 2002:ad4:4ba4:: with SMTP id i4mr34049163qvw.42.1625128850422;
 Thu, 01 Jul 2021 01:40:50 -0700 (PDT)
Date:   Thu,  1 Jul 2021 10:38:43 +0200
Message-Id: <20210701083842.580466-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2] perf: Require CAP_KILL if sigtrap is requested
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org
Cc:     tglx@linutronix.de, mingo@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, ebiederm@xmission.com,
        omosnace@redhat.com, serge@hallyn.com,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If perf_event_open() is called with another task as target and
perf_event_attr::sigtrap is set, and the target task's user does not
match the calling user, also require the CAP_KILL capability.

Otherwise, with the CAP_PERFMON capability alone it would be possible
for a user to send SIGTRAP signals via perf events to another user's
tasks. This could potentially result in those tasks being terminated if
they cannot handle SIGTRAP signals.

Note: The check complements the existing capability check, but is not
supposed to supersede the ptrace_may_access() check. At a high level we
now have:

	capable of CAP_PERFMON and (CAP_KILL if sigtrap)
		OR
	ptrace_may_access() // also checks for same thread-group and uid

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Cc: <stable@vger.kernel.org> # 5.13+
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Drop kill_capable() and just check CAP_KILL (reported by Ondrej Mosnacek).
* Use ns_capable(__task_cred(task)->user_ns, CAP_KILL) to check for
  capability in target task's ns (reported by Ondrej Mosnacek).
---
 kernel/events/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe88d6eea3c2..43c99695dc3f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12152,10 +12152,23 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (task) {
+		bool is_capable;
+
 		err = down_read_interruptible(&task->signal->exec_update_lock);
 		if (err)
 			goto err_file;
 
+		is_capable = perfmon_capable();
+		if (attr.sigtrap) {
+			/*
+			 * perf_event_attr::sigtrap sends signals to the other
+			 * task. Require the current task to have CAP_KILL.
+			 */
+			rcu_read_lock();
+			is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
+			rcu_read_unlock();
+		}
+
 		/*
 		 * Preserve ptrace permission check for backwards compatibility.
 		 *
@@ -12165,7 +12178,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+		if (!is_capable && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
 			goto err_cred;
 	}
 
-- 
2.32.0.93.g670b81a890-goog

