Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0410B3D8CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhG1LpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:45:00 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:58827
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S234301AbhG1Lo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=5e9Aou2yuG
        jULlfSGQmTLEmlcOaCd6brcAIp0QNUc3Q=; b=lH/ELDpn9hliwI5XOkZlaGtUF0
        697e91Qz85OvQzu3TCez9/ZPLBZUCvlhBSlRmbSJuYr68Ckz5Th4wrnUt7+ToQSk
        gipsIgnOTQaZsuLM3x9t16cqBHuHvB/ZaFRmM3AeALL2hb1zpDBjBWWXrsxReDBR
        NELGWgZcqZ0+xLxzw=
Received: from lexp.lan (unknown [222.29.156.242])
        by front01 (Coremail) with SMTP id 5oFpogBnFSQOQwFh9JhuAQ--.57948S2;
        Wed, 28 Jul 2021 19:44:18 +0800 (CST)
From:   Jiashuo Liang <liangjs@pku.edu.cn>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, Jiashuo Liang <liangjs@pku.edu.cn>
Subject: [PATCH] x86/fault: Fix wrong signal when vsyscall fails with pkey
Date:   Wed, 28 Jul 2021 19:44:13 +0800
Message-Id: <20210728114413.287611-1-liangjs@pku.edu.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBnFSQOQwFh9JhuAQ--.57948S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw45Wr45JFyxCr4rWF47XFb_yoW5CF17pa
        45Ca9xGFZ7Xrn09a95XryUuw1Svay7t3Wqkryxta4S9345Zr1rXr10vw48Xry7K3yvq3W7
        JFWY9w1q9anrJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9a1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
        6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
        wVAFwVW8KwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
        Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7VUbcdbUUUUUU==
X-CM-SenderInfo: isqqijqrtqmio6sn3hxhgxhubq/1tbiAwEQBVPy7sYrGgAHso
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function __bad_area_nosemaphore calls kernelmode_fixup_or_oops with
parameter "signal" being "pkey", which will send a signal numbered "pkey".

When emulating vsyscall, the kernel may fail to access user-given memory
pages that are protected by pkey. In such a case, the kernel should send a
SIGSEGV signal with si_code=SEGV_PKUERR and si_pkey=pkey.

So a new parameter "pkey" is added to kernelmode_fixup_or_oops to fix it.

Signed-off-by: Jiashuo Liang <liangjs@pku.edu.cn>
---
 arch/x86/mm/fault.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b2eefdefc108..883294282e1e 100644
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
+					 SIGBUS, BUS_ADRERR, 0);
 		return;
 	}
 
@@ -1396,7 +1403,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 */
 		if (!user_mode(regs))
 			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGBUS, BUS_ADRERR);
+						 SIGBUS, BUS_ADRERR, 0);
 		return;
 	}
 
@@ -1416,7 +1423,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 
 	if (fatal_signal_pending(current) && !user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0);
+		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0, 0);
 		return;
 	}
 
@@ -1424,7 +1431,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		/* Kernel mode? Handle exceptions or die: */
 		if (!user_mode(regs)) {
 			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGSEGV, SEGV_MAPERR);
+						 SIGSEGV, SEGV_MAPERR, 0);
 			return;
 		}
 
-- 
2.32.0

