Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7CD43DBAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJ1HJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:09:45 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:37128 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229626AbhJ1HJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:09:44 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowABXOe4MTHph60h7BQ--.10285S2;
        Thu, 28 Oct 2021 15:06:52 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     peterz@infradead.org, valentin.schneider@arm.com, namit@vmware.com,
        mingo@kernel.org, dave.hansen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v3] cpumask: Fix implicit type conversion
Date:   Thu, 28 Oct 2021 07:06:51 +0000
Message-Id: <1635404811-2992370-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowABXOe4MTHph60h7BQ--.10285S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4fGFWxXrW3XF1rAF1DWrg_yoW5WF43pF
        W0g3yUK3ykJr4kZ34UC3yUur1F93ykJ3yvk3yUGFyq9FW3Aw18Zr12kF9xXrWUCF1kWFyI
        9r9093yUuFn8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4x
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYMKZDUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of the macro in `include/linux/cpumask.h` says the
variable 'cpu' can be int, whose value ranges from (-2^31) to
(2^31 - 1).
However in the for_each_cpu(), 'nr_cpu_ids' and the return value of
cpumask_next() is unsigned int, whose value ranges from 0 to
(2^32 - 1).
If return value of cpumask_next() is (2^31), the restrict
'cpu < nr_cpu_ids' can also be statisfied, but the actual value
of 'cpu' is (-2^31).
Take amd_pmu_cpu_starting() in `arch/x86/events/amd/core.c` as an
example. When value of 'cpu' is (-2^31), then in the per_cpu(),
there will apear __per_cpu_offset[-2^31], which is array out of
bounds error.
Moreover, the num of cpu to be the negative doesn't make sense and
may easily causes trouble.
It is universally accepted that the implicit type conversion is
terrible.
Also, having the good programming custom will set an example for
others.
Thus, it might be better to fix the macro description of 'cpu' and
deal with all the existing issues.

Fixes: c743f0a ("sched/fair, cpumask: Export for_each_cpu_wrap()")
Fixes: 8bd93a2 ("rcu: Accelerate grace period if last non-dynticked CPU")
Fixes: 984f2f3 ("cpumask: introduce new API, without changing anything, v3")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 include/linux/cpumask.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bfc4690..5db1d9d 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -232,7 +232,7 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the unsigned integer iterator
  * @mask: the cpumask pointer
  *
  * After the loop, cpu is >= nr_cpu_ids.
@@ -244,7 +244,7 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu_not - iterate over every cpu in a complemented mask
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the unsigned integer iterator
  * @mask: the cpumask pointer
  *
  * After the loop, cpu is >= nr_cpu_ids.
@@ -258,7 +258,7 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 
 /**
  * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the unsigned integer iterator
  * @mask: the cpumask poiter
  * @start: the start location
  *
@@ -273,7 +273,7 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 
 /**
  * for_each_cpu_and - iterate over every cpu in both masks
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the unsigned integer iterator
  * @mask1: the first cpumask pointer
  * @mask2: the second cpumask pointer
  *
-- 
2.7.4

