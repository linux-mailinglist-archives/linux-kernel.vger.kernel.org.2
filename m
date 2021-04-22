Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5897436806F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhDVM3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236412AbhDVM2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:28:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC0B46146B;
        Thu, 22 Apr 2021 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619094480;
        bh=LYPfQthXMNQ1j9xLmLGXwzKg7zmVgH1XIEPaB1Wwz2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ug9dX7vRz+FtzTRXvkbuDxG/uOMLB2nXneNbtqRPFk6MQy2Q8ZfAaDbxSNlBViBDV
         Au6lPRutiSI/TvNNrpZtC/EoOunlb5W4n5Xdvka4c9QfnXegQGtEc1bKcaBCJaMGwo
         BIhXDs/iwQLycW/ul5krwdXnbfxD3v6CKMd/knz0AjqNJM9gId0N5JhYFGxfuraAcx
         1V/uFAy0jHmrVN48+tnpXGfzZbt5xb05hhlYsq3qqFbdRZmJrC+vW+07eVkozBu2S0
         nGZpKUCQobsvJu7RmlXwrQbFW6Z/n+SC8Zv5nBXMYktu6EN+Mstv73EyzwjZnI3WUP
         QjwUfgmZ5Szsw==
From:   legion@kernel.org
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
Subject: [PATCH v11 9/9] ucounts: Set ucount_max to the largest positive value the type can hold
Date:   Thu, 22 Apr 2021 14:27:16 +0200
Message-Id: <1825a5dfa18bc5a570e79feb05e2bd07fd57e7e3.1619094428.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1619094428.git.legion@kernel.org>
References: <cover.1619094428.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Gladkov <legion@kernel.org>

The ns->ucount_max[] is signed long which is less than the rlimit size.
We have to protect ucount_max[] from overflow and only use the largest
value that we can hold.

On 32bit using "long" instead of "unsigned long" to hold the counts has
the downside that RLIMIT_MSGQUEUE and RLIMIT_MEMLOCK are limited to 2GiB
instead of 4GiB. I don't think anyone cares but it should be mentioned
in case someone does.

The RLIMIT_NPROC and RLIMIT_SIGPENDING used atomic_t so their maximum
hasn't changed.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/user_namespace.h | 6 ++++++
 kernel/fork.c                  | 8 ++++----
 kernel/user_namespace.c        | 8 ++++----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index e42efd0ae595..2409fd57fd61 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -122,6 +122,12 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
 bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
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

