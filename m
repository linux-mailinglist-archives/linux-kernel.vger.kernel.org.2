Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3863E43960B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhJYMWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:22:55 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:51132 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232455AbhJYMWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:22:50 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowAA3PAjaoHZhLBNQBQ--.18991S2;
        Mon, 25 Oct 2021 20:19:38 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] sched: Fix implicit type conversion
Date:   Mon, 25 Oct 2021 12:19:37 +0000
Message-Id: <1635164377-2426740-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAA3PAjaoHZhLBNQBQ--.18991S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw45Gw4DtryxKw4UKF45KFg_yoWDZFX_W3
        4Y9w1ru34a9rs2g3W2ka1rZ340qa15XFn5Zw1xWasrZ3y5Kr9xt3y5CFyrJr1kXrs7CFZ8
        JwnaqFn0gr1UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfU5rWrDUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'n' is defined as ULONG. However in the cpumask_next(),
it is used as INT.
That is vulnerable and may cause overflow.
For example, if the value of 'n' is (2^31 - 1), then it can pass the
check ('n == 0') and ('n-- > 0'). Then in cpumask_next(), its value
is (2^31 - 3). But it is implicit type conversed to int, its actual
value is -3, which is illegal in the cpumask_next().
Therefore, it might be better to define 'n' as INT.

Fixes: cb152ff ("sched: Fix /proc/sched_stat failure on very very large systems")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 kernel/sched/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 3f93fc3..6503d3a 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -82,7 +82,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
  */
 static void *schedstat_start(struct seq_file *file, loff_t *offset)
 {
-	unsigned long n = *offset;
+	int n = *offset;
 
 	if (n == 0)
 		return (void *) 1;
-- 
2.7.4

