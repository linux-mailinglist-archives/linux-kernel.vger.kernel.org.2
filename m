Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3933749F6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhEEVOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhEEVOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:14:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 874A4613E9;
        Wed,  5 May 2021 21:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620249214;
        bh=cH5ZdHHMHjfEKZdo833MVNL/5Cstj/6Lfg0e/92RceM=;
        h=From:To:Cc:Subject:Date:From;
        b=B1CgeEw4W8lKDNwIdKZS8k82D1GctkKpvOqWFV7FBuhUsYKWORsDeoVyotKA4rdJF
         s0XCpRYz5xoM2c2GnLsYeaf3zPmv97o+R/dLZizTb99JrQFm+xr4r3Oy+srS7sj130
         +Op0Fl/E3LdVKoDfOnX0d808sr+mGNWAYT8M4gyIO48epu/fUibRdiBAvec9N4IhCQ
         M2nM8S4N0VvDE3QCtx5u26JimQGmSxjPdGiF0X/6UmT+Z8Tz1zJeqY41F5v054Qgam
         fG552FuA09334UldFVr+kf+BIX4xt2TN8jp58D7QoBKqe8UXP6d0FiYgJODg0wA5w+
         NZTpSoTYvqnEg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Jian Cai <jiancai@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        He Ying <heying24@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] smp: fix smp_call_function_single_async prototype
Date:   Wed,  5 May 2021 23:12:42 +0200
Message-Id: <20210505211300.3174456-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As of commit 966a967116e6 ("smp: Avoid using two cache lines for struct
call_single_data"), the smp code prefers 32-byte aligned call_single_data
objects for performance reasons, but the block layer includes an instance
of this structure in the main 'struct request' that is more senstive
to size than to performance here, see 4ccafe032005 ("block: unalign
call_single_data in struct request").

The result is a violation of the calling conventions that clang correctly
points out:

block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to 32-byte aligned parameter 2 of 'smp_call_function_single_async' may result in an unaligned pointer access [-Walign-mismatch]
                smp_call_function_single_async(cpu, &rq->csd);

It does seem that the usage of the call_single_data without cache line
alignment should still be allowed by the smp code, so just change the
function prototype so it accepts both, but leave the default alignment
unchanged for the other users. This seems better to me than adding
a local hack to shut up an otherwise correct warning in the caller.

Link: https://lore.kernel.org/linux-block/20210330230249.709221-1-jiancai@google.com/
Link: https://github.com/ClangBuiltLinux/linux/issues/1328
Acked-by: Jens Axboe <axboe@kernel.dk>
Cc: Jian Cai <jiancai@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: avoid adding other warnings by a more thorough change
---
 include/linux/smp.h |  2 +-
 kernel/smp.c        | 26 +++++++++++++-------------
 kernel/up.c         |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 669e35c03be2..510519e8a1eb 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
-int smp_call_function_single_async(int cpu, call_single_data_t *csd);
+int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
 
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
diff --git a/kernel/smp.c b/kernel/smp.c
index e21074900006..52bf159ec400 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -211,7 +211,7 @@ static u64 cfd_seq_inc(unsigned int src, unsigned int dst, unsigned int type)
 	} while (0)
 
 /* Record current CSD work for current CPU, NULL to erase. */
-static void __csd_lock_record(call_single_data_t *csd)
+static void __csd_lock_record(struct __call_single_data *csd)
 {
 	if (!csd) {
 		smp_mb(); /* NULL cur_csd after unlock. */
@@ -226,13 +226,13 @@ static void __csd_lock_record(call_single_data_t *csd)
 		  /* Or before unlock, as the case may be. */
 }
 
-static __always_inline void csd_lock_record(call_single_data_t *csd)
+static __always_inline void csd_lock_record(struct __call_single_data *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled))
 		__csd_lock_record(csd);
 }
 
-static int csd_lock_wait_getcpu(call_single_data_t *csd)
+static int csd_lock_wait_getcpu(struct __call_single_data *csd)
 {
 	unsigned int csd_type;
 
@@ -282,7 +282,7 @@ static const char *csd_lock_get_type(unsigned int type)
 	return (type >= ARRAY_SIZE(seq_type)) ? "?" : seq_type[type];
 }
 
-static void csd_lock_print_extended(call_single_data_t *csd, int cpu)
+static void csd_lock_print_extended(struct __call_single_data *csd, int cpu)
 {
 	struct cfd_seq_local *seq = &per_cpu(cfd_seq_local, cpu);
 	unsigned int srccpu = csd->node.src;
@@ -321,7 +321,7 @@ static void csd_lock_print_extended(call_single_data_t *csd, int cpu)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *ts1, int *bug_id)
 {
 	int cpu = -1;
 	int cpux;
@@ -387,7 +387,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
  * previous function call. For multi-cpu calls its even more interesting
  * as we'll have to ensure no other cpu is observing our csd.
  */
-static void __csd_lock_wait(call_single_data_t *csd)
+static void __csd_lock_wait(struct __call_single_data *csd)
 {
 	int bug_id = 0;
 	u64 ts0, ts1;
@@ -401,7 +401,7 @@ static void __csd_lock_wait(call_single_data_t *csd)
 	smp_acquire__after_ctrl_dep();
 }
 
-static __always_inline void csd_lock_wait(call_single_data_t *csd)
+static __always_inline void csd_lock_wait(struct __call_single_data *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled)) {
 		__csd_lock_wait(csd);
@@ -431,17 +431,17 @@ static void __smp_call_single_queue_debug(int cpu, struct llist_node *node)
 #else
 #define cfd_seq_store(var, src, dst, type)
 
-static void csd_lock_record(call_single_data_t *csd)
+static void csd_lock_record(struct __call_single_data *csd)
 {
 }
 
-static __always_inline void csd_lock_wait(call_single_data_t *csd)
+static __always_inline void csd_lock_wait(struct __call_single_data *csd)
 {
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #endif
 
-static __always_inline void csd_lock(call_single_data_t *csd)
+static __always_inline void csd_lock(struct __call_single_data *csd)
 {
 	csd_lock_wait(csd);
 	csd->node.u_flags |= CSD_FLAG_LOCK;
@@ -454,7 +454,7 @@ static __always_inline void csd_lock(call_single_data_t *csd)
 	smp_wmb();
 }
 
-static __always_inline void csd_unlock(call_single_data_t *csd)
+static __always_inline void csd_unlock(struct __call_single_data *csd)
 {
 	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
 
@@ -501,7 +501,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
  */
-static int generic_exec_single(int cpu, call_single_data_t *csd)
+static int generic_exec_single(int cpu, struct __call_single_data *csd)
 {
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
@@ -784,7 +784,7 @@ EXPORT_SYMBOL(smp_call_function_single);
  * NOTE: Be careful, there is unfortunately no current debugging facility to
  * validate the correctness of this serialization.
  */
-int smp_call_function_single_async(int cpu, call_single_data_t *csd)
+int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
 {
 	int err = 0;
 
diff --git a/kernel/up.c b/kernel/up.c
index df50828cc2f0..a38b8b095251 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-int smp_call_function_single_async(int cpu, call_single_data_t *csd)
+int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
 {
 	unsigned long flags;
 
-- 
2.29.2

