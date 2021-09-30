Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9900341DA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351258AbhI3NBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351254AbhI3NBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:01:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB87A61452;
        Thu, 30 Sep 2021 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633006758;
        bh=4MOyRRmN6tGcFGQOIiaIoRY71MXH2WNBgg8f7K1CPVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPU60QdKByNWvJX+O7hrTA4M3+qC9ex79bwHlCBl4/GC9BV1GCu+IC5KifKsM5QoR
         TVjSujPeY9o0eMX2hmYhH7mcmXcjBZpDV3QvdZxNPpoGlpy6M5eyaJrC1r5w5Tfwxr
         gJF1OBj380ju1lOrajRYOpzeeXf8AlTWKZTk8WVO9rw+fRTlQgdeeZVKmsSf8rIogG
         VmxVXBCmGOYQxVcZd5SIl+K4alhP7eE7EfctZ0f+cWY+YQNv+jxC9j5DZfDmzr7rj5
         UGfPi5b3y61CwXDCSNhG3MOY/aPWRJs3mj/fr882mtOkfEwZbEmhJBFCdO1qG/lghR
         8ibND9Aohedyg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 7/7] riscv: rely on core code to keep thread_info::cpu updated
Date:   Thu, 30 Sep 2021 14:58:13 +0200
Message-Id: <20210930125813.197418-8-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930125813.197418-1-ardb@kernel.org>
References: <20210930125813.197418-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core code switched back to using thread_info::cpu to keep
a task's CPU number, we no longer need to keep it in sync explicitly. So
just drop the code that does this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/riscv/kernel/asm-offsets.c | 1 -
 arch/riscv/kernel/entry.S       | 5 -----
 arch/riscv/kernel/head.S        | 1 -
 3 files changed, 7 deletions(-)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 90f8ce64fa6f..478d9f02dab5 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -33,7 +33,6 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
-	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
 
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 98f502654edd..459eb1714353 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -544,11 +544,6 @@ ENTRY(__switch_to)
 	REG_L s9,  TASK_THREAD_S9_RA(a4)
 	REG_L s10, TASK_THREAD_S10_RA(a4)
 	REG_L s11, TASK_THREAD_S11_RA(a4)
-	/* Swap the CPU entry around. */
-	lw a3, TASK_TI_CPU(a0)
-	lw a4, TASK_TI_CPU(a1)
-	sw a3, TASK_TI_CPU(a1)
-	sw a4, TASK_TI_CPU(a0)
 	/* The offset of thread_info in task_struct is zero. */
 	move tp, a1
 	ret
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index fce5184b22c3..d5ec30ef6f5d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -317,7 +317,6 @@ clear_bss_done:
 	call setup_trap_vector
 	/* Restore C environment */
 	la tp, init_task
-	sw zero, TASK_TI_CPU(tp)
 	la sp, init_thread_union + THREAD_SIZE
 
 #ifdef CONFIG_KASAN
-- 
2.30.2

