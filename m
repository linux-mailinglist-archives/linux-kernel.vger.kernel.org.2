Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A393935C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhE0TBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:01:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:37064 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhE0TBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:01:08 -0400
IronPort-SDR: QGnw236ClLwUbYJWKgeI+KA0vnm+D+eO+EeWRCvkMC1Buy7PGlc58EBIzT8XV7gCTXGSOWGImc
 wx07EtEoHzSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="202576586"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="202576586"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 11:59:35 -0700
IronPort-SDR: MDOL1enHI8gpCMoq1QQitV4tmghzhaNCH7dk33NRVl19rJu+4VW59lFO/jc4pHnPkr678z3qdz
 39oURwj9lVZg==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="445151710"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.182.84]) ([10.209.182.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 11:59:34 -0700
Subject: Re: [syzbot] WARNING in ex_handler_fprestore
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        syzbot <syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com>,
        bp@alien8.de, bp@suse.de, dave.hansen@linux.intel.com,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tony.luck@intel.com,
        x86@kernel.org
References: <0000000000004c453905c30f8334@google.com>
 <fe20f360-7c6c-f1bf-c3a5-403ae979fae6@kernel.org>
 <87sg29886g.ffs@nanos.tec.linutronix.de>
 <87bl8w86m3.ffs@nanos.tec.linutronix.de>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b2dddfbc-02cd-fcd8-6c89-ae6204e4cf6f@intel.com>
Date:   Thu, 27 May 2021 11:59:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <87bl8w86m3.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/2021 9:49 AM, Thomas Gleixner wrote:
> On Thu, May 27 2021 at 00:03, Thomas Gleixner wrote:
>> I decoded it fully by now and will send out coherent info (and hopefully
>> a patch) tomorrow with brain awake. Time for bed here...
> 
> Not yet there with a patch, but I have a trivial C reproducer. See
> below.
> 
> The failure mode is:
> 
>      signal to task
>        sigaction_handler()
>          wreckage xsave.header.reserved[0]
>          sig_return()
>            restore_fpu_from_sigframe()
>              try: XRSTOR from user -> #GP
>              copy_from_user(fpstate, task->fpu.state.xsave);
>              validate(task->fpu.state.xsave) -> fail
>              fpu__clear_user_states()
>                reinits FPU hardware but task state is still wreckaged

In fpu__clear_user_states(), maybe can we clear xstate_header.reserved[] 
as well?  Or do we want to check the user buffer first before copy it?

>            signal_fault()
>        sigsegv_handler()
>          sig_return()
>            restore_fpu_from_sigframe()
>              try: XRSTOR from user -> success
> 
>       schedule()
>         xsave()
> 
>       other task runs on same CPU so fpu state is not longer clean
> 
>       wakeup()
>       exit_to_user()
>        xrstor() -> #GP because the header is still borked.
> 
> XSAVE does not clear the header.reserved fields....
> 
> The original code kinda worked because fpu__clear() reinitialized the
> task fpu state, but as this code is preemptible the same issue can
> happen pre 5.8 as well if I'm not missing something. I'll verify that
> after dinner.
> 
> The commit in question just made it trivial to trigger because it keeps
> the broken task fpu state around.
> 
> The whole slow path is broken in disgusting ways. I have no good idea
> yet how to fix that proper and in a way which can be backported easily.
> 
> Thanks,
> 
>          tglx
> ---
> #define _GNU_SOURCE
> 
> #include <errno.h>
> #include <pthread.h>
> #include <signal.h>
> #include <stdlib.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <unistd.h>
> #include <sched.h>
> 
> static void sig_handler(int sig, siginfo_t *info, void *__ctxp)
> {
> 	ucontext_t *uctx = __ctxp;
> 	mcontext_t *mctx = &uctx->uc_mcontext;
> 	unsigned long *p = (unsigned long *) mctx->fpregs;
> 
> 	/* Wreckage xsave.header.reserved[0] */
> 	p[66] = 0xfffffff;
> }
> 
> static void sigsegv(int sig)
> {
> }
> 
> int main(void)
> {
> 	struct sigaction sa;
> 	cpu_set_t set;
> 
> 	memset(&sa, 0, sizeof(sa));
> 	sa.sa_sigaction = sig_handler;
> 	sa.sa_flags = SA_SIGINFO;
> 	sigemptyset(&sa.sa_mask);
> 	if (sigaction(SIGUSR1, &sa, 0))
> 		exit(1);
> 
> 	signal(SIGSEGV, sigsegv);
> 
> 	CPU_ZERO(&set);
> 	CPU_SET(0, &set);
> 
> 	sched_setaffinity(getpid(), sizeof(set), &set);
> 
> 	kill(0, SIGUSR1);
> 	fork();
> 	sleep(1);
> 
> 	return 0;
> }
> 

