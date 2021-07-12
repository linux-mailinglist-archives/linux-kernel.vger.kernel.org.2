Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB563C5EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhGLPCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:02:23 -0400
Received: from pv50p00im-ztdg10012101.me.com ([17.58.6.49]:39982 "EHLO
        pv50p00im-ztdg10012101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233784AbhGLPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1626101970; bh=XV2wMh7vyeC48jtpLURCw+iOqqnpYWtDLLSie1W1Fp8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=DLRyLiCcUUJbZvj0EDOZ2X6S6wPTRBqLDEOV23Ay57l7MJBh4G6HuIelYePcVE2IE
         fga0TFri7sLrIAjMitwQnEYAOg4WbluuO/PsrJQOLZnLJbPX+HHRhm6BB17rOFlIU5
         q9MNZcG5KGdYPr9Y22Nv6gZVijYnDz4ftH3i7uoLLqDz482XV31hmBpJJG0DDhiS/f
         /MHpDgCLhaw8OFkhduSbvQvrkx8kAe6ZL1BVctYRHnVzNIhQhPXDMm/wQZTwY679f9
         3uZjk0r2i5ptAQe0suRpQK3OtQeR0K96SJupWC2xkK27W0mrsD4RlQCbaPiUBmgBwx
         HxPOMPoYyjD6w==
Received: from xiongwei.. (unknown [120.245.2.75])
        by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id EA6E08403E8;
        Mon, 12 Jul 2021 14:59:24 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2] locking/lockdep: Reorganize the return values of check_wait_context()
Date:   Mon, 12 Jul 2021 22:59:13 +0800
Message-Id: <20210712145913.189202-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_09:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2107120117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Some check_*() functions for lock rules check return 1 if there is no bug,
otherwise return 0 like check_prev_add(), check_irq_usage(), etc. Here we
can reorganize the return values of check_wait_context() to make the
return logic same as other check_*() functions.

The return values of print_lock_invalid_wait_context() are unnecessary,
remove them.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
v2: 
  - Improve commit log.
  - Keep return value sync for check_wait_context in !CONFIG_PROVE_LOCKING.
  - Add statement for return vaules.
v1:
  - https://lkml.org/lkml/2021/7/11/174
---
 kernel/locking/lockdep.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bf1c00c881e4..69e524def98b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4635,16 +4635,16 @@ static inline short task_wait_context(struct task_struct *curr)
 	return LD_WAIT_MAX;
 }
 
-static int
+static void
 print_lock_invalid_wait_context(struct task_struct *curr,
 				struct held_lock *hlock)
 {
 	short curr_inner;
 
 	if (!debug_locks_off())
-		return 0;
+		return;
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=============================\n");
@@ -4664,8 +4664,6 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 
 	pr_warn("stack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -4682,6 +4680,8 @@ print_lock_invalid_wait_context(struct task_struct *curr,
  *
  * Therefore we must look for the strictest environment in the lock stack and
  * compare that to the lock we're trying to acquire.
+ *
+ * Return 1 if no nesting confilct, otherwise return 0.
  */
 static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 {
@@ -4691,7 +4691,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	int depth;
 
 	if (!next_inner || next->trylock)
-		return 0;
+		return 1;
 
 	if (!next_outer)
 		next_outer = next_inner;
@@ -4723,10 +4723,12 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 		}
 	}
 
-	if (next_outer > curr_inner)
-		return print_lock_invalid_wait_context(curr, next);
+	if (next_outer > curr_inner) {
+		print_lock_invalid_wait_context(curr, next);
+		return 0;
+	}
 
-	return 0;
+	return 1;
 }
 
 #else /* CONFIG_PROVE_LOCKING */
@@ -4751,7 +4753,7 @@ static inline int separate_irq_context(struct task_struct *curr,
 static inline int check_wait_context(struct task_struct *curr,
 				     struct held_lock *next)
 {
-	return 0;
+	return 1;
 }
 
 #endif /* CONFIG_PROVE_LOCKING */
@@ -4962,7 +4964,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 #endif
 	hlock->pin_count = pin_count;
 
-	if (check_wait_context(curr, hlock))
+	if (!check_wait_context(curr, hlock))
 		return 0;
 
 	/* Initialize the lock usage bit */
-- 
2.30.2

