Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEA0439107
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhJYIUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:20:42 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:41564 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231925AbhJYIUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:20:39 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowACHjQkYaHZh4RxLBQ--.9442S2;
        Mon, 25 Oct 2021 16:17:28 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] sched: Fix implicit type conversion
Date:   Mon, 25 Oct 2021 08:17:27 +0000
Message-Id: <1635149847-2426546-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowACHjQkYaHZh4RxLBQ--.9442S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw45Gw4Duw4DGFWDAFW5KFg_yoW3ZrcEy3
        4Ygw18W3sI9rn2v3W7Cw4rXw1Fqay8tFn5Zw18Wa4DA3yUKr9xt3y5KFyrJrn5Xr4xGFZx
        AwnaqF90gr4DCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUeHUDDUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'n' is defined as ULONG. However in the cpumask_next(),
it is used as INT.
That is vulnerable and may cause overflow.
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

