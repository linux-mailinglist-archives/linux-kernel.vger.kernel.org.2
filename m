Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57983278C8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 08:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhCAH6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 02:58:46 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:45850 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232518AbhCAH6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:58:44 -0500
X-AuditID: 0a580157-f21ff7000005df43-ca-603c981ee21a
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 07.4A.57155.E189C306; Mon,  1 Mar 2021 15:30:38 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Mar 2021
 15:57:55 +0800
Date:   Mon, 1 Mar 2021 15:57:49 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "HORIGUCHI NAOYA( =?UTF-8?B?5aCA?= =?UTF-8?B?5Y+jIOebtOS5nw==?=)" 
        <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        <yangfeng1@kingsoft.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210301155749.1cc324c7@alex-virtual-machine>
In-Reply-To: <CALCETrXT9vGRT1S6Kk5ExfU+mW16rCY964r73ihRf5ZSh9H8jg@mail.gmail.com>
References: <20210223204436.1df73153@alex-virtual-machine>
 <788DFBA0-903F-4548-9C2F-B1A1543EE770@amacapital.net>
 <20210223164259.GA166727@agluck-desk2.amr.corp.intel.com>
 <20210225124711.35b31965@alex-virtual-machine>
 <CALCETrXT9vGRT1S6Kk5ExfU+mW16rCY964r73ihRf5ZSh9H8jg@mail.gmail.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsXCFcGooCs3wybB4N9nBYvPG/6xWbzY0M5o
        MW2juMXlXXPYLO6t+c9qcX7XWlaLSwcWMFlcbDzAaHG89wCTxeZNU5kt3ly4x2LxY8NjVgce
        j++tfSwem1doeSze85LJY9OqTjaPTZ8msXu8O3eO3WPeyUCPF1c3sni833eVzePzJjmPEy1f
        WAO4o7hsUlJzMstSi/TtErgy9i/7xlKwRL5iWW8zYwPjQYkuRg4OCQETieNnmbsYOTmEBKYz
        SXyfat7FyAVkv2SUmProCStIgkVAReL0sTYmEJtNQFVi171ZYHERIPv16R2sIA3MAg+YJVY8
        PQiWEBZIljgz6QEjiM0rYCVxcNEssA2cAoES3/b/ZYLYsIxJ4t++dWAN/AJiEr1X/oNtkBCw
        l2jbsgiqWVDi5MwnLCA2s4COxIlVx5ghbHmJ7W/nQJ2tKHF4yS92iF4liSPdM9gg7FiJZfNe
        sU5gFJ6FZNQsJKNmIRm1gJF5FSNLcW664SZGSNSF72Cc1/RR7xAjEwfjIUYJDmYlEd6Tny0T
        hHhTEiurUovy44tKc1KLDzFKc7AoifMKu9gkCAmkJ5akZqemFqQWwWSZODilGpi4jvIE/c7t
        1V7vdFNxxp937+/cS11a/Gc116Js/Rmez25puu+a4eAcZybb4DKVJSvufYymY8Z8zRmdGmta
        j/v3/ag8umKl/9UH3420uj/EGzp/Za6/9o5305a8bRunpQVtf/X87bazV49t4n7W139t+9yP
        f3PWl3ZtK90RkJ46/9auH1Mm9KVeTXr2JSNq+gTxKZsTD13V2aL9znafnxT/syxbhUnGb1nv
        vzrQ8fIbB7u6ALPpYf0OP/XGh6K2e9Jv3pm0J1/EL4j9BG9JpoaF98GI2f8fsV79+CL99M1/
        Z/uPeLA/80so6fZ8XNjk5qO8VTN7wYuvQQWsapw+HGb9r+fdvpbKXGK8ImTuxPUuSizFGYmG
        WsxFxYkA19XyvikDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luto:

> > > > At the very least, this needs a clear explanation of why your proposed behavior is better than the existing behavior.  
> > >
> > > The explanation is buried in that "can't trust the process" line.
> > >
> > > E.g. user space isn't good about checking for failed write(2) syscalls.
> > > So if the poison was in a user buffer passed to write(fd, buffer, count)
> > > sending a SIGBUS would be the action if they read the poison directly,
> > > so it seems reasonable to send the same signal if the kernel read their
> > > poison for them.
> > >
> > > It would avoid users that didn't check the return value merrily proceeding
> > > as if everything was ok.  
> >
> > Hi luto:
> >    I will add more infomation:
> >    Even if the process will check return value of syscall like write, I don't think
> > process will take proper action for this.
> >    In test example, the return value will be errno is 14 (Bad Address), the process may not realize
> > this is a hw issue, and may take wrong action not as expected.
> >    And totally, A hw error will rarely happen, and the hw error hitting this branch will be
> > more unlikely, the impaction without this patch is quite minor, but this is still not good enough, we should
> > make it better, right?  
> 
> There are a few issues I can imagine:
> 
> Some programs may use read(2), write(2), etc as ways to check if
> memory is valid without getting a signal.  They might not want
> signals, which means that this feature might need to be configurable.

I checked the code again and found that: For poison page access, the process may not ignore the SIGBUS signal even if it was set to

1298 /*
1299  * Force a signal that the process can't ignore: if necessary
1300  * we unblock the signal and change any SIG_IGN to SIG_DFL.
1301  *
1302  * Note: If we unblock the signal, we always reset it to SIG_DFL,
1303  * since we do not want to have a signal handler that was blocked
1304  * be invoked when user space had explicitly blocked it.
1305  *
1306  * We don't want to have recursive SIGSEGV's etc, for example,
1307  * that is why we also clear SIGNAL_UNKILLABLE.
1308  */
1309 static int
1310 force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)

> It's worth making sure that this doesn't end up sending duplicate
> signals.  If nothing else, this would impact the vsyscall emulation
> code.

I am not totally get the "duplicate signals" meaning , SIGBUS is a fatal signal and if it was 
processed, the process should exit and another same signal will not be processed i think. Or if
the process capture the signal and not to exit, duplicate SIGBUS signal seems not a problem if that happens 

For vsyscall emulation:
I do check the related code, and this may be a read operation like instruction fetch for the issue, it will
not hit the modified branch but go to emulation code, it seems we can't differentiate between a vsyscall emulation page fault
and a hwposion page fault, for current code it may access the invalid page again and lead to a panic. This patch will not
cover this scenario.

> Programs that get a signal might expect that the RIP that the signal
> frame points to is the instruction that caused the signal and that the
> instruction faulted without side effects.  For SIGSEGV, I would be
> especially nervous about this.  Maybe SIGBUS is safer.  For SIGSEGV,
> it's entirely valid to look at CR2 / si_fault_addr, fix it up, and
> return.  This would be completely *invalid* with your patch.  I'm not
> sure what to do about this.

Do you mean the patch will replace the SIGSEGV with SIGBUS for hwposion case? I think SIGBUS is more accurate for the error.
Normally for poison access, the process shouldn't be returned and an exit will be good or we need another code stream for this I think.
This is the legacy way to process user poison access error like other posion code branch in kernel. 

Thanks!
Aili Yao
