Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC55A30A329
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhBAISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:18:38 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:8927 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhBAISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:18:35 -0500
X-AuditID: 0a580155-6fbff700000550c6-51-6017b2da19fb
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 64.A0.20678.AD2B7106; Mon,  1 Feb 2021 15:50:50 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Feb 2021
 16:17:49 +0800
Date:   Mon, 1 Feb 2021 16:17:49 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     <tony.luck@intel.com>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <naoya.horiguchi@nec.com>,
        <hpa@zytor.com>, <x86@kernel.org>, <hpa@zytor.com>
CC:     <YANGFENG1@kingsoft.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210201161749.0e8dc212.yaoaili@kingsoft.com>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsXCFcGooHtrk3iCwcNl8hafN/xjs3ixoZ3R
        YtpGcYvLu+awWdxb85/V4vyutawWlw4sYLK42HiA0eJ47wEmi82bpjJbvLlwj8Xix4bHrA48
        Ht9b+1g8Nq/Q8li85yWTx6ZVnWwemz5NYvd4d+4cu8e8k4EeL65uZPF4v+8qm8fnTXIeJ1q+
        sAZwR3HZpKTmZJalFunbJXBldC+azV6wSK5i+ZWLrA2MiyW6GDk5JARMJGbsvcDWxcjFISQw
        nUlix9JvTBDOc0aJWZf/sXcxcnCwCKhILHiTB9LAJqAqseveLFaQGhGBT4wSXxs+MYEkmAVC
        JO7MPswOYgsLxEt0zLnEAmLzClhJnDh6mQ1kDr+AmMSrBmOIxfYSz/+eZYYoEZQ4OfMJC8QY
        HYkTq44xQ9jyEtvfzgGzhQQUJQ4v+cUO0askcaR7BhuEHSuxbN4r1gmMgrOQjJqFZNQsJKMW
        MDKvYmQpzk032sQIiaHQHYwzmj7qHWJk4mA8xCjBwawkwntqkliCEG9KYmVValF+fFFpTmrx
        IUZpDhYlcd5yB74EIYH0xJLU7NTUgtQimCwTB6dUA1Oiinvx6tXSz2fdLJ5d9uzxguuf4344
        PvwX41zxe7aBdPC/RYHb7n4U7s/7zNbL2nd74sfcfa+nJ36SZr+5JHTm7IdzHt3beKTBNn7C
        spfmDrcyfrzeKXsutf5/VP/MA2Eu0zOu2AQXZthuMe7tje3Le9YWNv2y6832S5LrVMsVeKL1
        bmRrBBxyE5ItWeh9eYFwiljQjKcrm+tesHw+MLH1uZbJNoU3Pr+XWnBkRLirrWLKWOX4lf2n
        3LwdMxnTrqpZfuTOzdMx6flVy3Uu9VKKl9tTvd7w/Wb9v5qShCel/V7G8PQ74zG10/6zedaq
        8YVciU6MvuR9ty9cpbvVstzgicb52IKpDc5uArXvTJRYijMSDbWYi4oTAbtrBnoQAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When one page is already hwpoisoned by AO action, process may not be
killed, the process mapping this page may make a syscall include this
page and result to trigger a VM_FAULT_HWPOISON fault, if it's in kernel
mode it may be fixed by fixup_exception. Current code will just return
error code to user process.

This is not sufficient, we should send a SIGBUS to the process and log
the info to console, as we can't trust the process will handle the error
correctly.

Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 arch/x86/mm/fault.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f1f1b5a0956a..23095b94cf42 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -631,7 +631,7 @@ static void set_signal_archinfo(unsigned long address,
 
 static noinline void
 no_context(struct pt_regs *regs, unsigned long error_code,
-	   unsigned long address, int signal, int si_code)
+	   unsigned long address, int signal, int si_code, vm_fault_t fault)
 {
 	struct task_struct *tsk = current;
 	unsigned long flags;
@@ -662,12 +662,32 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 		 * In this case we need to make sure we're not recursively
 		 * faulting through the emulate_vsyscall() logic.
 		 */
+
+		if (IS_ENABLED(CONFIG_MEMORY_FAILURE) &&
+		    fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+			unsigned int lsb = 0;
+
+			pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
+				current->comm, current->pid, address);
+
+			sanitize_error_code(address, &error_code);
+			set_signal_archinfo(address, error_code);
+
+			if (fault & VM_FAULT_HWPOISON_LARGE)
+				lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+			if (fault & VM_FAULT_HWPOISON)
+				lsb = PAGE_SHIFT;
+
+			force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
+
+			return;
+		}
+
 		if (current->thread.sig_on_uaccess_err && signal) {
 			sanitize_error_code(address, &error_code);
 
 			set_signal_archinfo(address, error_code);
 
-			/* XXX: hwpoison faults will set the wrong code. */
 			force_sig_fault(signal, si_code, (void __user *)address);
 		}
 
@@ -836,7 +856,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	if (is_f00f_bug(regs, address))
 		return;
 
-	no_context(regs, error_code, address, SIGSEGV, si_code);
+	no_context(regs, error_code, address, SIGSEGV, si_code, 0);
 }
 
 static noinline void
@@ -927,7 +947,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 {
 	/* Kernel mode? Handle exceptions or die: */
 	if (!(error_code & X86_PF_USER)) {
-		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
+		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR, fault);
 		return;
 	}
 
@@ -966,7 +986,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 	       unsigned long address, vm_fault_t fault)
 {
 	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
-		no_context(regs, error_code, address, 0, 0);
+		no_context(regs, error_code, address, 0, 0, 0);
 		return;
 	}
 
@@ -974,7 +994,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 		/* Kernel mode? Handle exceptions or die: */
 		if (!(error_code & X86_PF_USER)) {
 			no_context(regs, error_code, address,
-				   SIGSEGV, SEGV_MAPERR);
+				   SIGSEGV, SEGV_MAPERR, 0);
 			return;
 		}
 
@@ -1396,7 +1416,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, hw_error_code, address, SIGBUS,
-				   BUS_ADRERR);
+				   BUS_ADRERR, 0);
 		return;
 	}
 
-- 
2.25.1

