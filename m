Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE823DB1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 05:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhG3DDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 23:03:11 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:50406
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229750AbhG3DDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 23:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=StjqyN0Avt
        +j93b0C7ZHpieKEBZdXbJT0ePujB2Zqg8=; b=JILlyQAdqPpsN2e31m96WvNvPh
        fEROWUlNefJzTG83xlnbffpSRyvYR37Sr3s7gxPeJB/s2JsXD2kxauMun/kuM/G/
        NLC46ukNB6/EyhPl7O8hXqzBphHhiHHNxSkOTYQGtBw3OOd+vbv15Lj4rolmjLQO
        tbIxrwNrLNMxgfiY8=
Received: from lexp.lan (unknown [222.29.156.242])
        by front01 (Coremail) with SMTP id 5oFpogAnLISpawNhSwqNAQ--.6560S2;
        Fri, 30 Jul 2021 11:02:04 +0800 (CST)
From:   Jiashuo Liang <liangjs@pku.edu.cn>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, Jiashuo Liang <liangjs@pku.edu.cn>
Subject: [PATCH v2] x86/fault: Fix wrong signal when vsyscall fails with pkey
Date:   Fri, 30 Jul 2021 11:01:52 +0800
Message-Id: <20210730030152.249106-1-liangjs@pku.edu.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogAnLISpawNhSwqNAQ--.6560S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15Wrykur1kGr1kWw4kJFb_yoW5KF43pa
        45C39xGFZ7XrnF9a95X34Uur1rZay7t3WDCryxta4a9as8Zr1rXr1jvw48Xry7G3yqq3WU
        tFWY934q9anrJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9I1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
        wVAFwVW8GwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
        Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
        IYCTnIWIevJa73UjIFyTuYvjfUnQ6pDUUUU
X-CM-SenderInfo: isqqijqrtqmio6sn3hxhgxhubq/1tbiAwERBVPy7sZO2gACsJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function __bad_area_nosemaphore() calls kernelmode_fixup_or_oops() with
parameter "signal" being "pkey", which will send a signal numbered "pkey".

This bug appears when the kernel fail to access user-given memory pages
that are protected by pkey, so it can go through the do_user_addr_fault()
path and pass the !user_mode() check in __bad_area_nosemaphore(). Most
cases will simply run the kernel fixup code to make an -EFAULT. But when
another condition current->thread.sig_on_uaccess_err is met, which is
only used to emulate vsyscall, we will generate the wrong signal.

A new parameter "pkey" is added to kernelmode_fixup_or_oops() to fix it.

Fixes: 5042d40a264c ("x86/fault: Bypass no_context() for implicit kernel faults from usermode")
Signed-off-by: Jiashuo Liang <liangjs@pku.edu.cn>
---

Changes in v2:
  - Use ARCH_DEFAULT_PKEY instead of 0 for unused pkey parameter.

 arch/x86/mm/fault.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b2eefdefc108..84a2c8c4af73 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -710,7 +710,8 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 
 static noinline void
 kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
-			 unsigned long address, int signal, int si_code)
+			 unsigned long address, int signal, int si_code,
+			 u32 pkey)
 {
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -735,8 +736,12 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 
 			set_signal_archinfo(address, error_code);
 
-			/* XXX: hwpoison faults will set the wrong code. */
-			force_sig_fault(signal, si_code, (void __user *)address);
+			if (si_code == SEGV_PKUERR) {
+				force_sig_pkuerr((void __user *)address, pkey);
+			} else {
+				/* XXX: hwpoison faults will set the wrong code. */
+				force_sig_fault(signal, si_code, (void __user *)address);
+			}
 		}
 
 		/*
@@ -798,7 +803,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	struct task_struct *tsk = current;
 
 	if (!user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);
+		kernelmode_fixup_or_oops(regs, error_code, address,
+					 SIGSEGV, si_code, pkey);
 		return;
 	}
 
@@ -930,7 +936,8 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 {
 	/* Kernel mode? Handle exceptions or die: */
 	if (!user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);
+		kernelmode_fixup_or_oops(regs, error_code, address,
+					 SIGBUS, BUS_ADRERR, ARCH_DEFAULT_PKEY);
 		return;
 	}
 
@@ -1396,7 +1403,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 */
 		if (!user_mode(regs))
 			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGBUS, BUS_ADRERR);
+						 SIGBUS, BUS_ADRERR,
+						 ARCH_DEFAULT_PKEY);
 		return;
 	}
 
@@ -1416,7 +1424,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 
 	if (fatal_signal_pending(current) && !user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0);
+		kernelmode_fixup_or_oops(regs, error_code, address,
+					 0, 0, ARCH_DEFAULT_PKEY);
 		return;
 	}
 
@@ -1424,7 +1433,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		/* Kernel mode? Handle exceptions or die: */
 		if (!user_mode(regs)) {
 			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGSEGV, SEGV_MAPERR);
+						 SIGSEGV, SEGV_MAPERR,
+						 ARCH_DEFAULT_PKEY);
 			return;
 		}
 
-- 
2.32.0

