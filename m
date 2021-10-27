Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB3D43C459
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbhJ0HvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:51:09 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:45668 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240653AbhJ0HvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:51:08 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-03 (Coremail) with SMTP id rQCowACniOVEBHlh5MUkBQ--.5600S2;
        Wed, 27 Oct 2021 15:48:20 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] clocksource: Fix implicit type conversion
Date:   Wed, 27 Oct 2021 07:48:19 +0000
Message-Id: <1635320899-2742957-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: rQCowACniOVEBHlh5MUkBQ--.5600S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryDAFWftw4xCFW8ZF4DXFb_yoW8XFy8pr
        WUC34UJrs5Xa42vayqq39rCr93Cw4vvr1S9ayDJrySyF13tw18XFZrJ343WFWUKF4kWr1a
        vFyfXw4j9anrZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUh4SOUUUUU=
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the type of 'next_cpu' is int, its value is range from (-2^31)
to (2^31 - 1).
But the return type of cpumask_next() is unsigned int, whose value
is range from 0 to (2^32 - 1).
Suppose that the return value of cpumask_next() is (2^31), as it is
impicitly casted to int, the actual value of 'next_cpu' is (-2^31).
Also since the type of 'nr_cpu_ids' is unsigned int, we suppose the
value of 'nr_cpu_ids' is (2^32 - 1).
Therefore, the restriction 'next_cpu >= nr_cpu_ids' isn't statisfied
because 'next_cpu' is impicitly casted to unsigned int, whose value
is (2^31).
As a result, the value of 'next_cpu' in add_timer_on() is (-2^31)
that is obviouly illegal and dangerous.
To avoid the risk, it might be better to add the check which can
prevent the illegal input for add_timer_on().

Fixes: 5db0e1e ("cpumask: replace for_each_cpu_mask_nr with for_each_cpu in kernel/time/")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 2cd9025..6237f18 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -291,7 +291,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	 * to each other.
 	 */
 	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
-	if (next_cpu >= nr_cpu_ids)
+	if (next_cpu < 0 || next_cpu >= nr_cpu_ids)
 		next_cpu = cpumask_first(cpu_online_mask);
 
 	/*
-- 
2.7.4

