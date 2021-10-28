Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C9C43D94A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhJ1C1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:27:20 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:40888 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229534AbhJ1C1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:27:19 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-03 (Coremail) with SMTP id rQCowAD3_2fZCXph4SE9BQ--.6388S2;
        Thu, 28 Oct 2021 10:24:25 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     valentin.schneider@arm.com, peterz@infradead.org,
        bristot@redhat.com, dave.hansen@linux.intel.com, namit@vmware.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] cpumask: Fix implicit type conversion
Date:   Thu, 28 Oct 2021 02:24:24 +0000
Message-Id: <1635387864-2743220-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: rQCowAD3_2fZCXph4SE9BQ--.6388S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4rZF4DZF45GFWDJFWDurg_yoW8tFW3pF
        10grWUK3ykArs5u34UAayUCw1Y93ykJ3yvkw4UGFWDuFW7Aw1kZr129F9xtryUCFZ5GFyS
        9ryq9398uF15AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbpwZ7UUUU
        U==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of the macro in `include/linux/cpumask.h` says the
variable 'cpu' can be unsigned int.
However in the for_each_cpu(), for_each_cpu_wrap() and
for_each_cpu_and(), its value is assigned to -1.
That doesn't make sense. Moreover in the cpumask_next(),
cpumask_next_zero(), cpumask_next_wrap() and cpumask_next_and(),
'cpu' will be implicitly type conversed to int if the type is
unsigned int.
It is universally accepted that the implicit type conversion is
terrible.
Also, having the good programming custom will set an example for
others.
Thus, it might be better to fix the macro description of 'cpu' that
remove the '(optionally unsigned)'.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 include/linux/cpumask.h | 8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bfc4690..ceaed99 100644
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

