Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA630B7F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 07:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhBBGn0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Feb 2021 01:43:26 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:9042 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhBBGnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 01:43:19 -0500
X-AuditID: 0a580155-6fbff700000550c6-9d-6018edf8fe38
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 27.C3.20678.8FDE8106; Tue,  2 Feb 2021 14:15:20 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 2 Feb 2021
 14:42:27 +0800
Date:   Tue, 2 Feb 2021 14:42:26 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <naoya.horiguchi@nec.com>, "H. Peter Anvin" <hpa@zytor.com>,
        X86 ML <x86@kernel.org>, <YANGFENG1@kingsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210202144226.4869f13e.yaoaili@kingsoft.com>
In-Reply-To: <CALCETrWrj0LJaHTdrydH-i_OkjDb1VF76aJrAWpHA5PL2npezg@mail.gmail.com>
References: <20210201161749.0e8dc212.yaoaili@kingsoft.com>
        <CALCETrWrj0LJaHTdrydH-i_OkjDb1VF76aJrAWpHA5PL2npezg@mail.gmail.com>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsXCFcGooPvjrUSCwfpbXBafN/xjs3ixoZ3R
        YtpGcYvLu+awWdxb85/V4vyutawWlw4sYLK42HiA0eJ47wEmi82bpjJbvLlwj8Xix4bHrA48
        Ht9b+1g8Nq/Q8li85yWTx6ZVnWwemz5NYvd4d+4cu8e8k4EeL65uZPF4v+8qm8fnTXIeJ1q+
        sAZwR3HZpKTmZJalFunbJXBlrDuzmbHgl1bFlqOnWRoY/8l3MXJySAiYSLy+NZepi5GLQ0hg
        OpPEvq1bWUASQgLPGSV237EAsVkEVCRWTfoKFmcTUJXYdW8WK4gtAmS/Pr2DFaSZWWAms8TD
        zr9MIAlhgWSJ1tMP2EFsXgEribeNG8CaOQUCJTbcesIMsaCRUWL7trwuRg4OfgExiVcNxhAH
        2Us8/3uWGaJVUOLkzCdgrcwCOhInVh1jhrC1JZYtfA01RlHi8JJf7BC9ShJHumewQdixEsvm
        vWKdwCg8C8moWUhGzUIyagEj8ypGluLcdKNNjJCYC93BOKPpo94hRiYOxkOMEhzMSiK8pyaJ
        JQjxpiRWVqUW5ccXleakFh9ilOZgURLnLXfgSxASSE8sSc1OTS1ILYLJMnFwSjUwKZ+YKj1X
        as+UdUtKzxysU8mMlucXmayk8Lz83NHYl1WrnUS3LI1azjepgvfYjSUu0x8mPPyiMudKUmfn
        2lvPJ+7Rn9mwS+LnMa1TDDs4BI0TONd9zuBOu6cjy8kUuPbPz68rDhRcOh21xiXrHMtn9j0L
        Cyes4OE2EWg4qGAf/SPT9vwn2adbT7FX2V18kenRbth6f4fSpSlS1+55GAuvdFRjrJyV6e7E
        +lad8cf6/mchapM+T92TuFxMujRBr9iv9m1TYnr43wy/Z6/1P/x4bdpWr9+5OuHES5YVH+99
        /fFJ2O2C/U6f38syOBWOP0hZ1q+o7dmndrLHuGTlpYNZdjeW/zGps8gumNgQrFkcocRSnJFo
        qMVcVJwIAF/gC+woAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 08:58:27 -0800
Andy Lutomirski <luto@kernel.org> wrote:

> On Mon, Feb 1, 2021 at 12:17 AM Aili Yao <yaoaili@kingsoft.com> wrote:
> >
> > When one page is already hwpoisoned by AO action, process may not be
> > killed, the process mapping this page may make a syscall include this
> > page and result to trigger a VM_FAULT_HWPOISON fault, if it's in kernel
> > mode it may be fixed by fixup_exception. Current code will just return
> > error code to user process.
> >
> > This is not sufficient, we should send a SIGBUS to the process and log
> > the info to console, as we can't trust the process will handle the error
> > correctly.  
> 
> Does this happen when one process gets SIGBUSed due to memory failure
> and another process independently hits the poisoned memory?  I'm not
> entirely convinced that this is a problem.
> 

OK, I will explain more, hope this will be helpful:
One page get poisoned which can be caused by at least two scenarios:
1. One user process access a address which corrupted, the memory failure() will 
be called, the function will unmap the page which contain the corrupt memory cell, the process
triggering the error will get signaled with SIGBUS. Other process sharing this page
will get its related pte marked with SWP_HWPOISON, and in early-kill case, these other processes
will also be signaled with SIGBUS, In later-kill case, It should be signaled when it touch the page
which has been poisoned. 

2.A patrol scrub UE error will also trigger the same process, page unmapped, pte being marked with 
SWP_HWPOISON. In later-kill case, the process which touch the poisoned page will trigger a page fault
and should be signaled with SIGBUS.

In this later-kill case, normally it will hit the following code:

    965 #ifdef CONFIG_MEMORY_FAILURE
    966         if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
    967                 struct task_struct *tsk = current;
    968                 unsigned lsb = 0;
    969 
    970                 pr_err(
    971         "MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
    972                         tsk->comm, tsk->pid, address);
    973                 if (fault & VM_FAULT_HWPOISON_LARGE)
    974                         lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
    975                 if (fault & VM_FAULT_HWPOISON)
    976                         lsb = PAGE_SHIFT;
    977                 force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
    978                 return;
    979         }

Or there is a case that user process make a syscall including the posioned user address(assume to be ADD_A)
and make a request to copy the ADD_A content to kernel space. In such a case, it will trigger a page fault when
copying starts. As it's in kernel mode and the address is in user space, the process will hit:

    944 static void
    945 do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
    946           vm_fault_t fault)
    947 {
    948         /* Kernel mode? Handle exceptions or die: */
    949         if (!(error_code & X86_PF_USER)) {
    950                 no_context(regs, error_code, address, SIGBUS, BUS_ADRERR, fault);
    951                 return;
    952         } 

In no_context(), fixup_exception() will be called, usually the copy function in such a case will provide
one fixup function, which will return true, then no_context() return, finally the syscall will return one ERROR
code(errno=14 Bad address) to user process, which the user process won't know the where the real problem is.
From syslog, we can't guarantee memory error recovey log and the user process error will have a close correlation in
timestamp.

Previous behavior is not only for latest upstream code, but also apply to older kernel versions.

This patch is to correct this behavior by Sending SIGBUS to user process in such a scenario. This behavior
in this patch is consistent with other memory poison case.

Following is the test result:

Current 5.11 rc6:
 ./einj_mem_uc -S -c 1 -f copyin
0: copyin   vaddr = 0x7fed9808e400 paddr = 1b00c00400
./einj_mem_uc: couldn't write temp file (errno=14) 
Expected SIGBUS, didn't get one
page not present
Big surprise ... still running. Thought that would be fatal
Test passed

Current 5.11 rc6 with this patch:
./einj_mem_uc -S -c 1 -f copyin
0: copyin   vaddr = 0x7fef60e3d400 paddr = 14b7f43400
SIGBUS: addr = 0x7fef60e3d400
page not present
Big surprise ... still running. Thought that would be fatal
Test passed

And there is a small modification in the einj_mem_uc.c I missed in previous mail, which will lead the
test result unexpected.

    306 int trigger_copyin(char *addr)
    307 {

    316         if ((ret = write(copyin_fd, addr - memcpy_runup, memcpy_size)) != memcpy_size) {

    324 }


> In any case, this patch needs rebasing on top of my big fault series
> -- as it stands, it's way too difficult to keep track of which paths
> even call your new code..  And the various signal paths need to be
> consolidated -- we already have three of them, and the last thing we
> need is a fourth.

If you recognize the point listed, I will rebase the patch to your latest code.

Thanks
-- 
Best Regards!

Aili Yao
