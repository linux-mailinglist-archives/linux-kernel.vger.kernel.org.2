Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3629E43E11E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJ1Mol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:44:41 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:53434 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229578AbhJ1Mok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:44:40 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowADHifaMmnphjOSBBQ--.18442S2;
        Thu, 28 Oct 2021 20:41:48 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     peterz@infradead.org, valentin.schneider@arm.com, namit@vmware.com,
        mingo@kernel.org, dave.hansen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v4] cpumask: Fix implicit type conversion
Date:   Thu, 28 Oct 2021 12:41:47 +0000
Message-Id: <1635424907-1686047-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowADHifaMmnphjOSBBQ--.18442S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw45JrW5CFyrKFWDAr48Crg_yoW8KFyUpr
        yvgrWUKr48ArWkX34UAayUCw1F9397J39Fk34UGF1UurW3Jw18ZrnF9F9Iqr17CFykGrya
        9r929rWY9F1rAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xr1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDWrXUUUUU=
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the upper bounds for NR_CPUS are less than 2^13 now, maybe
in the future the NR_CPUS will increase and become bigger than
INT_MAX.
Therefore, it might be better to  add the assertion in case it will
be forgotten when the futurn come true.
Anyway, patch costs much less than the loss.
Also, it might be better to fix the macro description of 'cpu' and
deal with all the existing issues.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 include/linux/cpumask.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bfc4690..c433c9b 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -183,7 +183,7 @@ static inline int cpumask_any_distribute(const struct cpumask *srcp)
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
 #define for_each_cpu_and(cpu, mask1, mask2)	\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2)
-#else
+#elif NR_CPUS <= 2147483647
 /**
  * cpumask_first - get the first cpu in a cpumask
  * @srcp: the cpumask pointer
@@ -232,7 +232,7 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the integer iterator
  * @mask: the cpumask pointer
  *
  * After the loop, cpu is >= nr_cpu_ids.
@@ -244,7 +244,7 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu_not - iterate over every cpu in a complemented mask
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the integer iterator
  * @mask: the cpumask pointer
  *
  * After the loop, cpu is >= nr_cpu_ids.
@@ -258,7 +258,7 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 
 /**
  * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the integer iterator
  * @mask: the cpumask poiter
  * @start: the start location
  *
@@ -273,7 +273,7 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 
 /**
  * for_each_cpu_and - iterate over every cpu in both masks
- * @cpu: the (optionally unsigned) integer iterator
+ * @cpu: the integer iterator
  * @mask1: the first cpumask pointer
  * @mask2: the second cpumask pointer
  *
-- 
2.7.4

