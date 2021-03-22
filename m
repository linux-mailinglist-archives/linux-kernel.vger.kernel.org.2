Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB22344C15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhCVQqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhCVQpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:45:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2478E60249;
        Mon, 22 Mar 2021 16:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616431545;
        bh=n50q5Gzq/i9g7PBBu+0MPcklAUij0y9jGQqJxE+e5eg=;
        h=From:To:Cc:Subject:Date:From;
        b=qiosDjrYa/kEPRZWkMtscsaxiGMe0SCxv1xhgUkP3/bMf4fRGJTUcGqNVjzbhBcxk
         hmPm9EUr0vH02FdcN3RLmQ8EJTLdAShWRkXzqp/YTJkBt+sFah5CHWzpwch2HY19tB
         LyQGNYkwhsG0cjjQTXgpTGQQE9eexMjSHLCOHqJuc95ntzGs3oxnXSuwqt6tcC7EJ1
         iSW5O12/aVMG9R3gzLTqOjVszU30UhzfYGPkMOu+tgJkPsIavub3oUAfXOlWqARVkF
         aV1pAC4c3PqsSEkZ20Ryx1HurHKzMxCalUscuEwl24UBq5HSBB7q+ylqik9PT6pd45
         ItdcNYiK8posA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/msr: fix wr/rdmsr_safe_regs_on_cpu prototype
Date:   Mon, 22 Mar 2021 17:45:36 +0100
Message-Id: <20210322164541.912261-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-11 warns about mismatched prototypes here:

arch/x86/lib/msr-smp.c:255:51: error: argument 2 of type ‘u32 *’ {aka ‘unsigned int *’} declared as a pointer [-Werror=array-parameter=]
  255 | int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
      |                                              ~~~~~^~~~
In file included from arch/x86/include/asm/processor.h:22,
                 from arch/x86/include/asm/cpufeature.h:5,
                 from arch/x86/include/asm/thread_info.h:53,
                 from include/linux/thread_info.h:58,
                 from arch/x86/include/asm/preempt.h:7,
                 from include/linux/preempt.h:78,
                 from arch/x86/lib/msr-smp.c:3:
arch/x86/include/asm/msr.h:347:50: note: previously declared as an array ‘u32[8]’ {aka ‘unsigned int[8]’}

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/lib/msr-smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 75a0915b0d01..40bbe56bde32 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -252,7 +252,7 @@ static void __wrmsr_safe_regs_on_cpu(void *info)
 	rv->err = wrmsr_safe_regs(rv->regs);
 }
 
-int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
+int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 {
 	int err;
 	struct msr_regs_info rv;
@@ -265,7 +265,7 @@ int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
 }
 EXPORT_SYMBOL(rdmsr_safe_regs_on_cpu);
 
-int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
+int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 {
 	int err;
 	struct msr_regs_info rv;
-- 
2.29.2

