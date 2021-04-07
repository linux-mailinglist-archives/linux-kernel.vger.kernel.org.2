Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558F43572D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354646AbhDGRJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:09:21 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:46990 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235711AbhDGRIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:08:51 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by raptor.unsafe.ru (Postfix) with ESMTPSA id AE99F417CD;
        Wed,  7 Apr 2021 17:08:37 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v10 9/9] ucounts: Set ucount_max to the largest positive value the type can hold
Date:   Wed,  7 Apr 2021 19:08:14 +0200
Message-Id: <bb88ee1d7330370094c58f650020e537baf7eb40.1617814298.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1617814298.git.gladkov.alexey@gmail.com>
References: <cover.1617814298.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (raptor.unsafe.ru [5.9.43.93]); Wed, 07 Apr 2021 17:08:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ns->ucount_max[] is signed long which is less than the rlimit size.
We have to protect ucount_max[] from overflow and only use the largest
value that we can hold.

On 32bit using "long" instead of "unsigned long" to hold the counts has
the downside that RLIMIT_MSGQUEUE and RLIMIT_MEMLOCK are limited to 2GiB
instead of 4GiB. I don't think anyone cares but it should be mentioned
in case someone does.

The RLIMIT_NPROC and RLIMIT_SIGPENDING used atomic_t so their maximum
hasn't changed.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 include/linux/user_namespace.h | 6 ++++++
 kernel/fork.c                  | 8 ++++----
 kernel/user_namespace.c        | 8 ++++----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 82851fba7278..1c778182f5d5 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -123,6 +123,12 @@ bool inc_rlimit_ucounts_and_test(struct ucounts *ucounts, enum ucount_type type,
 void dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
 bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
 
+static inline void set_rlimit_ucount_max(struct user_namespace *ns,
+		enum ucount_type type, unsigned long max)
+{
+	ns->ucount_max[type] = max <= LONG_MAX ? max : LONG_MAX;
+}
+
 #ifdef CONFIG_USER_NS
 
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
diff --git a/kernel/fork.c b/kernel/fork.c
index a3a5e317c3c0..2cd01c443196 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -822,10 +822,10 @@ void __init fork_init(void)
 	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
 		init_user_ns.ucount_max[i] = max_threads/2;
 
-	init_user_ns.ucount_max[UCOUNT_RLIMIT_NPROC] = task_rlimit(&init_task, RLIMIT_NPROC);
-	init_user_ns.ucount_max[UCOUNT_RLIMIT_MSGQUEUE] = task_rlimit(&init_task, RLIMIT_MSGQUEUE);
-	init_user_ns.ucount_max[UCOUNT_RLIMIT_SIGPENDING] = task_rlimit(&init_task, RLIMIT_SIGPENDING);
-	init_user_ns.ucount_max[UCOUNT_RLIMIT_MEMLOCK] = task_rlimit(&init_task, RLIMIT_MEMLOCK);
+	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC, task_rlimit(&init_task, RLIMIT_NPROC));
+	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE, task_rlimit(&init_task, RLIMIT_MSGQUEUE));
+	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, task_rlimit(&init_task, RLIMIT_SIGPENDING));
+	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK, task_rlimit(&init_task, RLIMIT_MEMLOCK));
 
 #ifdef CONFIG_VMAP_STACK
 	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 5ef0d4b182ba..df7651935fd5 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -121,10 +121,10 @@ int create_user_ns(struct cred *new)
 	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
 		ns->ucount_max[i] = INT_MAX;
 	}
-	ns->ucount_max[UCOUNT_RLIMIT_NPROC] = rlimit(RLIMIT_NPROC);
-	ns->ucount_max[UCOUNT_RLIMIT_MSGQUEUE] = rlimit(RLIMIT_MSGQUEUE);
-	ns->ucount_max[UCOUNT_RLIMIT_SIGPENDING] = rlimit(RLIMIT_SIGPENDING);
-	ns->ucount_max[UCOUNT_RLIMIT_MEMLOCK] = rlimit(RLIMIT_MEMLOCK);
+	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
+	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
+	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
+	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
 	ns->ucounts = ucounts;
 
 	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
-- 
2.29.3

