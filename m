Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F031074E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBEJDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:03:44 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:9486 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhBEJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:02:31 -0500
X-AuditID: 0a580155-6fbff700000550c6-4d-601d0300702a
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 54.8D.20678.0030D106; Fri,  5 Feb 2021 16:34:08 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 17:01:40 +0800
Date:   Fri, 5 Feb 2021 17:01:35 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "YANGFENG1@kingsoft.com" <YANGFENG1@kingsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <yaoaili@kingsoft.com>
Subject: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210205170135.22f771a2@alex-virtual-machine>
In-Reply-To: <20210204072555.GA22850@hori.linux.bs1.fc.nec.co.jp>
References: <20210201161749.0e8dc212.yaoaili@kingsoft.com>
        <20210204072555.GA22850@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsXCFcGooMvALJtg0DlPx+Lzhn9sFi82tDNa
        TNsobnF51xw2i3tr/rNanN+1ltXi0oEFTBYXGw8wWhzvPcBksXnTVGaLNxfusVj82PCY1YHH
        43trH4vH5hVaHov3vGTy2LSqk81j06dJ7B7vzp1j95h3MtDjxdWNLB7v911l8/i8Sc7jRMsX
        1gDuKC6blNSczLLUIn27BK6ML9N6WQoW6VdcnB/SwDhNvYuRk0NCwETixLyzTF2MXBxCAtOZ
        JFqOvWGDcF4ySvxoWcoGUsUioCJx6Ol6dhCbTUBVYte9WawgtohAksTi2V/BupkFdrBIXJ34
        BaxBWCBe4tTCyWANvAJWErtuXGcEsTkFHCX2b54D1iwkUCjxZeYNsHp+ATGJ3iv/mSBOspdo
        27KIEaJXUOLkzCcsIDazgI7EiVXHmCFseYntb+cwQ8xRlDi85Bc7RK+SxJHuGWwQdqzEsnmv
        WCcwCs9CMmoWklGzkIxawMi8ipGlODfdaBMjJOpCdzDOaPqod4iRiYPxEKMEB7OSCG9im1SC
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd5yB74EIYH0xJLU7NTUgtQimCwTB6dUA5P0bgf+cEcr
        0V8a6i8Uan/3Rl+c9tird2uWzaz2I7Upc6Y8DHy3/FS8wo/Ggxd2njgouPPy36/bnlb9lq3R
        rTz06siblTFs5qrCC75Gct4OFw/Rs1T9rxUds634YaGk1Xl75cUH/L/ueav2+yi75Nqs5mUc
        klNcDs1cZVDkdz3v6+10Rv7Pc2f8iftscPrShozut6zf5V5v3jTz9pObZ3tyJ3qIpM/sWCo7
        e/PRxuDrIi/PStwsnWcl98zc1dWObzn/4iTmD/sLq3eLtjjqpW9603FfewGfTWqDjUPXrUuV
        y1jswkz3JR27F/595eeagzv+hSl3XWqWdeHzuV5Q/oE78eqKvwunc65SlT8d2vpFiaU4I9FQ
        i7moOBEArLLTuCkDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When one page is already hwpoisoned by MCE AO action, processes may not
be killed, processes mapping this page may make a syscall include this
page and result to trigger a VM_FAULT_HWPOISON fault, as it's in kernel
mode it may be fixed by fixup_exception, current code will just return
error code to user code.

This is not sufficient, we should send a SIGBUS to the process and log
the info to console, as we can't trust the process will handle the error
correctly.

Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 arch/x86/mm/fault.c | 62 +++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 08f5f74cf989..62df798abb56 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -617,6 +617,30 @@ static void set_signal_archinfo(unsigned long address,
 	tsk->thread.cr2 = address;
 }
 
+static int
+do_sigbus_mceerr(unsigned long error_code, unsigned long address, vm_fault_t fault, int prepared)
+{
+	struct task_struct *tsk = current;
+	unsigned int lsb = 0;
+
+	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+		pr_err(
+	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
+			tsk->comm, tsk->pid, address);
+		if (fault & VM_FAULT_HWPOISON_LARGE)
+			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+		if (fault & VM_FAULT_HWPOISON)
+			lsb = PAGE_SHIFT;
+		if (!prepared) {
+			sanitize_error_code(address, &error_code);
+			set_signal_archinfo(address, error_code);
+		}
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
+		return 1;
+	}
+	return 0;
+}
+
 static noinline void
 page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address)
@@ -694,7 +718,7 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 
 static noinline void
 kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
-			 unsigned long address, int signal, int si_code)
+			 unsigned long address, int signal, int si_code, vm_fault_t fault)
 {
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -714,12 +738,17 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 		 * In this case we need to make sure we're not recursively
 		 * faulting through the emulate_vsyscall() logic.
 		 */
+
+		/* Sending MCERR Sigbus for page fault error from hwpoison */
+		if (IS_ENABLED(CONFIG_MEMORY_FAILURE)
+			&& do_sigbus_mceerr(error_code, address, fault, 0))
+			return;
+
 		if (current->thread.sig_on_uaccess_err && signal) {
 			sanitize_error_code(address, &error_code);
 
 			set_signal_archinfo(address, error_code);
 
-			/* XXX: hwpoison faults will set the wrong code. */
 			force_sig_fault(signal, si_code, (void __user *)address);
 		}
 
@@ -782,7 +811,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	struct task_struct *tsk = current;
 
 	if (!user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);
+		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code, 0);
 		return;
 	}
 
@@ -914,7 +943,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 {
 	/* Kernel mode? Handle exceptions or die: */
 	if (!user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);
+		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR, fault);
 		return;
 	}
 
@@ -929,22 +958,11 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 
 	set_signal_archinfo(address, error_code);
 
-#ifdef CONFIG_MEMORY_FAILURE
-	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
-		struct task_struct *tsk = current;
-		unsigned lsb = 0;
-
-		pr_err(
-	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
-			tsk->comm, tsk->pid, address);
-		if (fault & VM_FAULT_HWPOISON_LARGE)
-			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
-		if (fault & VM_FAULT_HWPOISON)
-			lsb = PAGE_SHIFT;
-		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
+	/* Sending MCERR Sigbus for page fault error from hwpoison */
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)
+		&& do_sigbus_mceerr(error_code, address, fault, 1))
 		return;
-	}
-#endif
+
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
 
@@ -1380,7 +1398,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 */
 		if (!user_mode(regs))
 			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGBUS, BUS_ADRERR);
+						 SIGBUS, BUS_ADRERR, 0);
 		return;
 	}
 
@@ -1400,7 +1418,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 
 	if (fatal_signal_pending(current) && !user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0);
+		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0, 0);
 		return;
 	}
 
@@ -1408,7 +1426,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		/* Kernel mode? Handle exceptions or die: */
 		if (!user_mode(regs)) {
 			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGSEGV, SEGV_MAPERR);
+						 SIGSEGV, SEGV_MAPERR, 0);
 			return;
 		}
 

base-commit: 167104452673f6c1b0e7bdbdf6a4b25f862e2319
prerequisite-patch-id: 6d1e0f23558f83f851ae883633b5c498f0c826c6
prerequisite-patch-id: 2dd1d48b132e6fa0c7b564dbbd9af2e667ebc997
prerequisite-patch-id: 4fa3543c8706f54bfc0b12b787222c65ff701c10
prerequisite-patch-id: 7465d0fe35a243e23f21a60b3595c09f4a95bdc2
prerequisite-patch-id: 0e7f44bbfa3911af10aa208dee5a8f7fb33f54b7
prerequisite-patch-id: 19bdc10dd055ae8761a8a87f6912f84b4bda68be
prerequisite-patch-id: df466945a2b3150abca123da0467b52220c3cc19
prerequisite-patch-id: 6678a8efeced8907cbdf167221b7d8c0deaa6c44
prerequisite-patch-id: d2270eca0467bbd5e8575fda9f18ddf7943f5562
prerequisite-patch-id: 97ab827e60b94faa6e4fc9f955aa88c4f51ceb5a
-- 
2.25.1

