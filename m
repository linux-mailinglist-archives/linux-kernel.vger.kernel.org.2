Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F473BB98D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhGEIrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhGEIrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:47:45 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A0C061760
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 01:45:08 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id mm14-20020a170906cc4eb02904e17df17fe9so322293ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4je/SN/KnbWSxzkZDr2TBnIQKjzyK1cJT3ltaKs0hSk=;
        b=gIPZ/pkiwQLpxzTFCRj21rl1/o+7fwZ6MTh3ps/+BfQ4hDEsI+00IeYjXdbZCxyIy/
         97UcdDClYYqsmf1N91dYrgdSUqkSwaOHLpzjPIg6K7dJyCPZuEeokHlRanhP06uSybrx
         dctiCkKkuUTG5eZ4xRycny6YX9ll83Y6u+YL5zM1FzYFUzWZ5ChDw5X+BLDworoi4Mlm
         rdv30/Tt1WjVXeMKpn3Doh0/Fr83nqAcR0n5rKMcPxgFEwN4tXahtK4ORjdl0nvrAfuX
         O3jywjaFZe1aflBqeqpKHQeGluwkHnC1A7dwRbq81+LUVKZyVzYxUvzQtveEL82+3BiE
         425A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4je/SN/KnbWSxzkZDr2TBnIQKjzyK1cJT3ltaKs0hSk=;
        b=DvCKhvd7ab7l1rbM03+U6fA60c7NSlePTcDF5CX+lCAuyn+9nT+NExj7GsOSFun8ky
         Sef10v/ASqQREMp2CYBYnEsMhLZpv6uWp6QW8z9/rwJp6GDxAZ/sXAGFlRksgpCDWOtp
         TPiVsgLSTxuFkn8UqVcuP2gGNn3CnGKLeL0DEO8uUTPi5hJzBbt+9PjFmkK50vQlH0op
         4LTAKVKtHRPID9SoGbUsOqdQ7aw8Ep/EZth/ZgYgVm/o/xQ+h0diDruu1OIO6Vg2w5XA
         keUoGHI30Bgryv5khXE9cTxA6rhBUXMV5Uhbv1C2JXl2fii4zDJmvr0EMwuKBusxr+/H
         8osQ==
X-Gm-Message-State: AOAM531ltgvAkZkyI0bVjeNl7ZAoLLkeezpfMzoYfSKAx0ZCDDkgvPSP
        oegtP0PUSWcSDsSJzXS7oh4rRIBNaA==
X-Google-Smtp-Source: ABdhPJxI4Vy7qzVuBvs6X1tEvcku6i7mhTH0+TZK4QhpVyhH9UXVrgJkCPKCUfN2kGvT52m+NLGPbQx6hg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:dddd:647c:7745:e5f7])
 (user=elver job=sendgmr) by 2002:a05:6402:845:: with SMTP id
 b5mr14691508edz.266.1625474706620; Mon, 05 Jul 2021 01:45:06 -0700 (PDT)
Date:   Mon,  5 Jul 2021 10:44:53 +0200
In-Reply-To: <20210705084453.2151729-1-elver@google.com>
Message-Id: <20210705084453.2151729-2-elver@google.com>
Mime-Version: 1.0
References: <20210705084453.2151729-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3 2/2] perf: Refactor permissions check into perf_check_permission()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org
Cc:     tglx@linutronix.de, mingo@kernel.org, dvyukov@google.com,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, ebiederm@xmission.com,
        omosnace@redhat.com, serge@hallyn.com,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the permission check in perf_event_open() into a helper
perf_check_permission(). This makes the permission check logic more
readable (because we no longer have a negated disjunction). Add a
comment mentioning the ptrace check also checks the uid.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Introduce this patch to refactor the permissions checking logic to
  make it more readable (reported by Eric W. Biederman).
---
 kernel/events/core.c | 58 ++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f79ee82e644a..3008b986994b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11912,6 +11912,37 @@ __perf_event_ctx_lock_double(struct perf_event *group_leader,
 	return gctx;
 }
 
+static bool
+perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
+{
+	unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
+	bool is_capable = perfmon_capable();
+
+	if (attr->sigtrap) {
+		/*
+		 * perf_event_attr::sigtrap sends signals to the other task.
+		 * Require the current task to also have CAP_KILL.
+		 */
+		rcu_read_lock();
+		is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
+		rcu_read_unlock();
+
+		/*
+		 * If the required capabilities aren't available, checks for
+		 * ptrace permissions: upgrade to ATTACH, since sending signals
+		 * can effectively change the target task.
+		 */
+		ptrace_mode = PTRACE_MODE_ATTACH_REALCREDS;
+	}
+
+	/*
+	 * Preserve ptrace permission check for backwards compatibility. The
+	 * ptrace check also includes checks that the current task and other
+	 * task have matching uids, and is therefore not done here explicitly.
+	 */
+	return is_capable || ptrace_may_access(task, ptrace_mode);
+}
+
 /**
  * sys_perf_event_open - open a performance event, associate it to a task/cpu
  *
@@ -12152,43 +12183,18 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (task) {
-		unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
-		bool is_capable;
-
 		err = down_read_interruptible(&task->signal->exec_update_lock);
 		if (err)
 			goto err_file;
 
-		is_capable = perfmon_capable();
-		if (attr.sigtrap) {
-			/*
-			 * perf_event_attr::sigtrap sends signals to the other
-			 * task. Require the current task to also have
-			 * CAP_KILL.
-			 */
-			rcu_read_lock();
-			is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
-			rcu_read_unlock();
-
-			/*
-			 * If the required capabilities aren't available, checks
-			 * for ptrace permissions: upgrade to ATTACH, since
-			 * sending signals can effectively change the target
-			 * task.
-			 */
-			ptrace_mode = PTRACE_MODE_ATTACH_REALCREDS;
-		}
-
 		/*
-		 * Preserve ptrace permission check for backwards compatibility.
-		 *
 		 * We must hold exec_update_lock across this and any potential
 		 * perf_install_in_context() call for this new event to
 		 * serialize against exec() altering our credentials (and the
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!is_capable && !ptrace_may_access(task, ptrace_mode))
+		if (!perf_check_permission(&attr, task))
 			goto err_cred;
 	}
 
-- 
2.32.0.93.g670b81a890-goog

