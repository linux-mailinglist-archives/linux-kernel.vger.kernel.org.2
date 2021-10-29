Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ACF43F534
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 05:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhJ2DK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 23:10:26 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:53564 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231558AbhJ2DKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 23:10:25 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowACXnal3ZXthsRuVBQ--.41556S2;
        Fri, 29 Oct 2021 11:07:35 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     peterz@infradead.org, valentin.schneider@arm.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] stop_machine: Fix implicit type conversion
Date:   Fri, 29 Oct 2021 03:07:33 +0000
Message-Id: <1635476853-1849088-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowACXnal3ZXthsRuVBQ--.41556S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy5GFyktFykZw15KFy8Krg_yoWftrc_Cr
        12qr1vgr1YgrZ2q3W2qr4FqFy8Kw1Yq3Wxt3W8WFZrZa4ktr43Xw1qgr98Xrn7W3yrAFnx
        Z3s0g3Z8t342gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r48
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU84SoDUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'cpu' is defined as unsigned int.
However in the for_each_cpu, its values is assigned to -1.
That doesn't make sense and in the cpumask_next() it is implicitly
type conversed to int.
It is universally accepted that the implicit type conversion is
terrible.
Also, having the good programming custom will set an example for
others.
Thus, it might be better to change the definition of 'cpu' from
unsigned int to int.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 kernel/stop_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cbc3027..db6ea9f 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -393,7 +393,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 				 struct cpu_stop_done *done)
 {
 	struct cpu_stop_work *work;
-	unsigned int cpu;
+	int cpu;
 	bool queued = false;
 
 	/*
-- 
2.7.4

