Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC81F36ED1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhD2PK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233480AbhD2PKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:10:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D24A4613F8;
        Thu, 29 Apr 2021 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619709007;
        bh=F83HiRYb/7vD0NCwP6T7zsoqGk6EPDrxndew4NKOdR0=;
        h=From:To:Cc:Subject:Date:From;
        b=Ed791e2JdBeC0+P66pUV1zAcp3U68ddtHMcjmSjyDOpfAef+xO2iAPqznf8WIbKZq
         XqJ8cdYBNI3Ota25TJ6nOlHjUcCWc4odfkE6NiiPEA986UfDuK2WmaBFUvtlBBmzX9
         FPQsRefC/89GU7LHWpC7saLqmGrpkYGkl4jK6sbja9wpGeHzF81vYnUiK0jJif1p9K
         AhWkPseRCeF5UnHOGyK+gemHLjkWe7hm/KTVV10ubCtOsBY9Fq6uitz50iBbVYa+Wy
         YC/LaPEQaJxoF4NxRiOY5u2ykE1YP1VFQESC/+5+9oIFVGbZ34RtTV5D8vpSTSO3Pr
         1WwPVYs/93wxw==
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
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] smp: fix smp_call_function_single_async prototype
Date:   Thu, 29 Apr 2021 17:09:40 +0200
Message-Id: <20210429150940.3256656-1-arnd@kernel.org>
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
Cc: Jens Axboe <axboe@kernel.dk>
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
 include/linux/smp.h | 2 +-
 kernel/smp.c        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

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
index e21074900006..1ec771d9f91c 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -401,7 +401,7 @@ static void __csd_lock_wait(call_single_data_t *csd)
 	smp_acquire__after_ctrl_dep();
 }
 
-static __always_inline void csd_lock_wait(call_single_data_t *csd)
+static __always_inline void csd_lock_wait(struct __call_single_data *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled)) {
 		__csd_lock_wait(csd);
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
 
-- 
2.29.2

