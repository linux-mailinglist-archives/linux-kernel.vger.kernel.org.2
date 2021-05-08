Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0493772C9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 17:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhEHPut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHPur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 11:50:47 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AABD3C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=30943O0R59jxDTzI32LnwOuhF+THVYq4XlJ4VEaU5rQ=; b=npbcOiaRYb1+B
        qgVIWLHBmMfZZ10JnR52+YsRVQiYemB/kvwrOdcF7DzFbL1kV4R4s9Yw8ZElPgNH
        PV9ePKeGbfHIULzRHAfXbOwEmSsTIgNaRPHIUcb3cuvWc2KflYzhRLqmUOhRYVbB
        DTfYmWTvq7YJdUZz8LEWnsIBeqUFvk=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBXXZ3wspZg7YCmAA--.28038S2;
        Sat, 08 May 2021 23:49:05 +0800 (CST)
Date:   Sat, 8 May 2021 23:43:47 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: kprobes: Fix build error when MMU=n
Message-ID: <20210508234347.0b40b94a@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBXXZ3wspZg7YCmAA--.28038S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyxArWDtFy8KFW8AFWrKrg_yoW8GrWfpF
        4DCws8ArWrJw4fG3y3tw4kuw10van8Ww43KrWDJr15Aw15Jr4DAws2grWxXrn0gryYkrWf
        Cr4DZrWFyayxA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyYb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        W3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
        JbIYCTnIWIevJa73UjIFyTuYvjxUcDDGUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

lkp reported a randconfig failure:

arch/riscv/kernel/probes/kprobes.c:90:22: error: use of undeclared identifier 'PAGE_KERNEL_READ_EXEC'

We implemented the alloc_insn_page() to allocate PAGE_KERNEL_READ_EXEC
page for kprobes insn page for STRICT_MODULE_RWX. But if MMU=n, we
should fall back to the generic weak alloc_insn_page() by generic
kprobe subsystem.

Fixes: cdd1b2bd358f ("riscv: kprobes: Implement alloc_insn_page()")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/riscv/kernel/probes/kprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 10b965c34536..15cc65ac7ca6 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -84,6 +84,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	return 0;
 }
 
+#ifdef CONFIG_MMU
 void *alloc_insn_page(void)
 {
 	return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
@@ -91,6 +92,7 @@ void *alloc_insn_page(void)
 				     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
 				     __builtin_return_address(0));
 }
+#endif
 
 /* install breakpoint in text */
 void __kprobes arch_arm_kprobe(struct kprobe *p)
-- 
2.31.0


