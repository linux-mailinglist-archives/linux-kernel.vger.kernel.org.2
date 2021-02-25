Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AFE325517
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhBYSDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:03:14 -0500
Received: from foss.arm.com ([217.140.110.172]:43796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233706AbhBYR6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:58:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBB911063;
        Thu, 25 Feb 2021 09:57:21 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AE7C3F73D;
        Thu, 25 Feb 2021 09:57:20 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, luto@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: [PATCH] sched/fair: Fix shift-out-of-bounds in load_balance()
Date:   Thu, 25 Feb 2021 17:56:56 +0000
Message-Id: <20210225175656.17006-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported a handful of occurrences where an sd->nr_balance_failed can
grow to much higher values than one would expect.

A successful load_balance() resets it to 0; a failed one increments
it. Once it gets to sd->cache_nice_tries + 3, this *should* trigger an
active balance, which will either set it to sd->cache_nice_tries+1 or reset
it to 0. However, in case the to-be-active-balanced task is not allowed to
run on env->dst_cpu, then the increment is done without any further
modification.

This could then be repeated ad nauseam, and would explain the absurdly high
values reported by syzbot (86, 149). VincentG noted there is value in
letting sd->cache_nice_tries grow, so the shift itself should be
fixed. That means preventing:

  """
  If the value of the right operand is negative or is greater than or equal
  to the width of the promoted left operand, the behavior is undefined.
  """

Thus we need to cap the shift exponent to
  BITS_PER_TYPE(typeof(lefthand)) - 1.

I had a look around for other similar cases via coccinelle:

  @expr@
  position pos;
  expression E1;
  expression E2;
  @@
  (
  E1 >> E2@pos
  |
  E1 >> E2@pos
  )

  @cst depends on expr@
  position pos;
  expression expr.E1;
  constant cst;
  @@
  (
  E1 >> cst@pos
  |
  E1 << cst@pos
  )

  @script:python depends on !cst@
  pos << expr.pos;
  exp << expr.E2;
  @@
  # Dirty hack to ignore constexpr
  if exp.upper() != exp:
     coccilib.report.print_report(pos[0], "Possible UB shift here")

The only other match in kernel/sched is rq_clock_thermal() which employs
sched_thermal_decay_shift, and that exponent is already capped to 10, so
that one is fine.

Link: http://lore.kernel.org/r/000000000000ffac1205b9a2112f@google.com
Fixes: 5a7f55590467 ("sched/fair: Relax constraint on task's load during load balance")
Reported-by: syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c  | 3 +--
 kernel/sched/sched.h | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a8bd7b13634..7ae7c2f13a8b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7708,8 +7708,7 @@ static int detach_tasks(struct lb_env *env)
 			 * scheduler fails to find a good waiting task to
 			 * migrate.
 			 */
-
-			if ((load >> env->sd->nr_balance_failed) > env->imbalance)
+			if (shr_bound(load, env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
 			env->imbalance -= load;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..e4e4f47cee6a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -204,6 +204,13 @@ static inline void update_avg(u64 *avg, u64 sample)
 	*avg += diff / 8;
 }
 
+/*
+ * Shifting a value by an exponent greater *or equal* to the size of said value
+ * is UB; cap at size-1.
+ */
+#define shr_bound(val, shift)							\
+	(val >> min_t(typeof(shift), shift, BITS_PER_TYPE(typeof(val)) - 1))
+
 /*
  * !! For sched_setattr_nocheck() (kernel) only !!
  *
-- 
2.27.0

