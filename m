Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E476B3A7AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhFOJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:34:30 -0400
Received: from foss.arm.com ([217.140.110.172]:57658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhFOJe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:34:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B24B8D6E;
        Tue, 15 Jun 2021 02:32:24 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.86.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A3FF3F694;
        Tue, 15 Jun 2021 02:32:22 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Fix ttbr0 values stored in struct thread_info for software-pan
Date:   Tue, 15 Jun 2021 15:02:58 +0530
Message-Id: <1623749578-11231-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using CONFIG_ARM64_SW_TTBR0_PAN, a task's thread_info::ttbr0 must be
the TTBR0_EL1 value used to run userspace. With 52-bit PAs, the PA must be
packed into the TTBR using phys_to_ttbr(), but we forget to do this in some
of the SW PAN code. Thus, if the value is installed into TTBR0_EL1 (as may
happen in the uaccess routines), this could result in UNPREDICTABLE
behaviour.

Since hardware with 52-bit PA support almost certainly has HW PAN, which
will be used in preference, this shouldn't be a practical issue, but let's
fix this for consistency.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: 529c4b05a3cb ("arm64: handle 52-bit addresses in TTBR")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Just found via code inspection. Applies on v5.13-rc6.

 arch/arm64/include/asm/mmu_context.h | 4 ++--
 arch/arm64/kernel/setup.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index d3cef9133539..eeb210997149 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -177,9 +177,9 @@ static inline void update_saved_ttbr0(struct task_struct *tsk,
 		return;
 
 	if (mm == &init_mm)
-		ttbr = __pa_symbol(reserved_pg_dir);
+		ttbr = phys_to_ttbr(__pa_symbol(reserved_pg_dir));
 	else
-		ttbr = virt_to_phys(mm->pgd) | ASID(mm) << 48;
+		ttbr = phys_to_ttbr(virt_to_phys(mm->pgd)) | ASID(mm) << 48;
 
 	WRITE_ONCE(task_thread_info(tsk)->ttbr0, ttbr);
 }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 61845c0821d9..68b30e8c22db 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -381,7 +381,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	 * faults in case uaccess_enable() is inadvertently called by the init
 	 * thread.
 	 */
-	init_task.thread_info.ttbr0 = __pa_symbol(reserved_pg_dir);
+	init_task.thread_info.ttbr0 = phys_to_ttbr(__pa_symbol(reserved_pg_dir));
 #endif
 
 	if (boot_args[1] || boot_args[2] || boot_args[3]) {
-- 
2.20.1

