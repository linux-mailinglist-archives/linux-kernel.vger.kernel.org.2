Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1786333FF15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCRFyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:54:03 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42300 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229454AbhCRFxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:53:36 -0400
Received: from localhost.localdomain.localdomain (unknown [10.180.13.87])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Bx4+TZ6lJgXg0CAA--.7221S2;
        Thu, 18 Mar 2021 13:53:29 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: use DIV_ROUND_UP to calculate sysctl_sched_rr_timeslice
Date:   Thu, 18 Mar 2021 13:53:29 +0800
Message-Id: <1616046809-6379-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Bx4+TZ6lJgXg0CAA--.7221S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1UAFW8KF4xur4UCFyDKFg_yoW3ZFX_u3
        saqr1Ykw1qvFyv9FsrAw48ArWagFyjqa47ZwnxKr17Jay8tw1DAr98CFZ5JFn5uw1xWa9F
        yFsYq3Z0krsIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE-syl42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jeXdbUUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When HZ is 300, the value of sysctl_sched_rr_timeslice is different from
the actual value. Therefore, replace with DIV_ROUND_UP to calculate
sysctl_sched_rr_timeslice.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b980cc96604f..c684440eefdb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,7 +8,7 @@
 #include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
-int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+int sysctl_sched_rr_timeslice = DIV_ROUND_UP(RR_TIMESLICE * MSEC_PER_SEC, HZ);
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
-- 
2.27.0

