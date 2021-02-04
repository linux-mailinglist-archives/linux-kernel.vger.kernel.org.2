Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D39430E990
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhBDBph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 20:45:37 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:37620
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S231259AbhBDBpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 20:45:36 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgCXndF0URtgxLrEAQ--.27446S3;
        Thu, 04 Feb 2021 09:44:21 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] arm64: improve whitespace
Date:   Thu,  4 Feb 2021 09:43:49 +0800
Message-Id: <1612403029-5011-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgCXndF0URtgxLrEAQ--.27446S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1xKFy7WF4fGryfZF17GFg_yoW5CrWkpr
        4Duw1ktr45K3WUCa9Fqwn3Xa45uws5XwsxGFyDJ34aqr4Yvry5XFn5Jr1a9w4Yqry5W3y0
        9F90vr1Utay7JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
        0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoPEfUUUUU
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a few places we don't have whitespace between macro parameters,
which makes them hard to read. This patch adds whitespace to clearly
separate the parameters.

In a few places we have unnecessary whitespace around unary operators,
which is confusing, This patch removes the unnecessary whitespace.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 arch/arm64/kernel/alternative.c | 2 +-
 arch/arm64/kernel/module-plts.c | 2 +-
 arch/arm64/kernel/perf_event.c  | 2 +-
 arch/arm64/kernel/process.c     | 4 ++--
 arch/arm64/kernel/traps.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

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
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 6895ce7..a05d34f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -45,7 +45,7 @@
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>
 
-static const char *handler[]= {
+static const char *handler[] = {
 	"Synchronous Abort",
 	"IRQ",
 	"FIQ",
-- 
1.8.3.1

