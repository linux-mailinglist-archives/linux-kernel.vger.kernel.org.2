Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84F643C32E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbhJ0GsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:48:13 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:38990 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231530AbhJ0GsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:48:11 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowAAXHAiF9XhhXEOQBQ--.36188S2;
        Wed, 27 Oct 2021 14:45:25 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     valentin.schneider@arm.com, peterz@infradead.org, mingo@kernel.org,
        namit@vmware.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] cpumask: Fix implicit type conversion
Date:   Wed, 27 Oct 2021 06:45:23 +0000
Message-Id: <1635317123-2716894-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAAXHAiF9XhhXEOQBQ--.36188S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArWxZF4DWFW3tr13Kr17Wrg_yoWrJr1fpr
        yjg3yUKrWkXF40g34UZa48Cr1jk397A3Wvka4DGFWUuFy3Aw18ZrnFgF98XrWUCF1kGr1a
        vryq9ayj9an8AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU8xR6UUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the 'nr_cpu_ids' is unsigned int, then we can assume its
value is (2^32 - 1).
Also, the 'cpu' is unsigned int.
As the number of cycles increases, the value of 'cpu' can be
(2^31 - 1).
Although in the cpumask_next() 'cpu' is implicitly casted to int,
its actual value is also (2^31 - 1).
However, the return value of cpumask_next(), the updated value of
'cpu', is (2^31).
That means the restriction 'cpu < nr_cpu_ids' is still statisfied
and in cpumask_next() when 'cpu' is implicitly casted to int, its
actual value is (-2^31).
Obviously, it is illegal and dangerous for cpumask_next(), as well
as others.
Therefore, we should fix the macro description of 'cpu' that remove
the '(optionally unsigned)' and restrict the value of 'cpu' to be
non-negative integer.
Moreover, all the existing issues should be dealed with.

Fixes: c743f0a ("sched/fair, cpumask: Export for_each_cpu_wrap()")
Fixes: 8bd93a2 ("rcu: Accelerate grace period if last non-dynticked CPU")
Fixes: 984f2f3 ("cpumask: introduce new API, without changing anything, v3")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 include/linux/cpumask.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bfc4690..8a8e59f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -232,7 +232,7 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the integer iterator
  * @mask: the cpumask pointer
  *
  * After the loop, cpu is >= nr_cpu_ids.
@@ -240,11 +240,11 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 #define for_each_cpu(cpu, mask)				\
 	for ((cpu) = -1;				\
 		(cpu) = cpumask_next((cpu), (mask)),	\
-		(cpu) < nr_cpu_ids;)
+		(cpu) < nr_cpu_ids && (cpu) >= 0;)
 
 /**
  * for_each_cpu_not - iterate over every cpu in a complemented mask
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the integer iterator
  * @mask: the cpumask pointer
  *
  * After the loop, cpu is >= nr_cpu_ids.
@@ -252,13 +252,13 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 #define for_each_cpu_not(cpu, mask)				\
 	for ((cpu) = -1;					\
 		(cpu) = cpumask_next_zero((cpu), (mask)),	\
-		(cpu) < nr_cpu_ids;)
+		(cpu) < nr_cpu_ids && (cpu) >= 0;)
 
 extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
 
 /**
  * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the integer iterator
  * @mask: the cpumask poiter
  * @start: the start location
  *
@@ -268,12 +268,12 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
  */
 #define for_each_cpu_wrap(cpu, mask, start)					\
 	for ((cpu) = cpumask_next_wrap((start)-1, (mask), (start), false);	\
-	     (cpu) < nr_cpumask_bits;						\
+	     (cpu) < nr_cpumask_bits && (cpu) >= 0;						\
 	     (cpu) = cpumask_next_wrap((cpu), (mask), (start), true))
 
 /**
  * for_each_cpu_and - iterate over every cpu in both masks
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the integer iterator
  * @mask1: the first cpumask pointer
  * @mask2: the second cpumask pointer
  *
@@ -288,7 +288,7 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 #define for_each_cpu_and(cpu, mask1, mask2)				\
 	for ((cpu) = -1;						\
 		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
-		(cpu) < nr_cpu_ids;)
+		(cpu) < nr_cpu_ids && (cpu) >= 0;)
 #endif /* SMP */
 
 #define CPU_BITS_NONE						\
-- 
2.7.4

