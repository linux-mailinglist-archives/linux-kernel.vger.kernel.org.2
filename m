Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8058130D32D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 06:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhBCFuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 00:50:05 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:50252
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229634AbhBCFuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:50:01 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgC3vcE6ORpgrwquAQ--.30192S3;
        Wed, 03 Feb 2021 13:48:43 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     ardb@kernel.org, jeyu@kernel.org, keescook@chromium.org,
        vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH 2/2] arm64/kernel: improve the coding style
Date:   Wed,  3 Feb 2021 13:48:19 +0800
Message-Id: <1612331299-21127-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgC3vcE6ORpgrwquAQ--.30192S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4rZrW5XFW3uF13Jr4ktFb_yoW8Kw1rpa
        1Duwn5Kr4rG3WUua9Iq3Z8Za45uan5JwsxuFykG3y3Kr4Yvr98XFn5Xr13uw4Yqr15Ww40
        9F90kr4Uta47JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfCztUUU
        UU=
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just improve the coding style.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 arch/arm64/kernel/alternative.c | 2 +-
 arch/arm64/kernel/module-plts.c | 2 +-
 arch/arm64/kernel/perf_event.c  | 2 +-
 arch/arm64/kernel/process.c     | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index a57cffb..1184c44 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -17,7 +17,7 @@
 #include <asm/sections.h>
 #include <linux/stop_machine.h>
 
-#define __ALT_PTR(a,f)		((void *)&(a)->f + (a)->f)
+#define __ALT_PTR(a, f)		((void *)&(a)->f + (a)->f)
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
 
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 2e22443..e53493d 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -131,7 +131,7 @@ u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
 }
 #endif
 
-#define cmp_3way(a,b)	((a) < (b) ? -1 : (a) > (b))
+#define cmp_3way(a, b)	((a) < (b) ? -1 : (a) > (b))
 
 static int cmp_rela(const void *a, const void *b)
 {
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 3605f77a..d1fec4a 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -810,7 +810,7 @@ static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
 {
 	int idx;
 
-	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; idx ++) {
+	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; idx++) {
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6616486..4cc1ccc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -304,7 +304,7 @@ void __show_regs(struct pt_regs *regs)
 	}
 }
 
-void show_regs(struct pt_regs * regs)
+void show_regs(struct pt_regs *regs)
 {
 	__show_regs(regs);
 	dump_backtrace(regs, NULL, KERN_DEFAULT);
@@ -587,7 +587,7 @@ unsigned long get_wchan(struct task_struct *p)
 			ret = frame.pc;
 			goto out;
 		}
-	} while (count ++ < 16);
+	} while (count++ < 16);
 
 out:
 	put_task_stack(p);
-- 
1.8.3.1

