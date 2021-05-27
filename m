Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1737439344C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhE0Quq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhE0Qup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:50:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB60C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:49:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622134149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFkUzI9ZSCaEZjRf8Ok1v42xXNlcLl7d3e4riFOlLSI=;
        b=JDLsQi3E3BCRFM0fAHMknw1xof99boUztq6OTwWvdaTGXHemiL9HZlK1DZpAHaDQNYt5A4
        D8yQey5iD6jHc5DmDWgo27izEUkeHFlF9+cmAP5mfbODQ+tRelrK8T3CtjWIcMKizQuaVq
        YhEm8kA7cP9P13dm+OTqfLVu4JC/83A84xg4SIlfUD6YqfUrB08J/GZJRftzJzHr/HzCJs
        rP6Nmnjgql5ghVQI66vtH4+SjzIG415tCd8osz0S9AUGTklZlhbM6TM7svVjRLnimRAxuQ
        phc1Hw8mfStyGnwnMWpSJvai9UjfTwyz2aAw5F7qVmxs7kGYRDt3yJ/IM+1uRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622134149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFkUzI9ZSCaEZjRf8Ok1v42xXNlcLl7d3e4riFOlLSI=;
        b=q0eSIONPtw7IChAb7E55XenFlmnF5IiO1iPx37FcjUDucXVqi/e5Zhq60ZHqPmRbna0F1c
        wtOc9y4DZFXVy+AA==
To:     Andy Lutomirski <luto@kernel.org>,
        syzbot <syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com>,
        bp@alien8.de, bp@suse.de, dave.hansen@linux.intel.com,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tony.luck@intel.com,
        x86@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [syzbot] WARNING in ex_handler_fprestore
In-Reply-To: <87sg29886g.ffs@nanos.tec.linutronix.de>
References: <0000000000004c453905c30f8334@google.com> <fe20f360-7c6c-f1bf-c3a5-403ae979fae6@kernel.org> <87sg29886g.ffs@nanos.tec.linutronix.de>
Date:   Thu, 27 May 2021 18:49:08 +0200
Message-ID: <87bl8w86m3.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27 2021 at 00:03, Thomas Gleixner wrote:
> I decoded it fully by now and will send out coherent info (and hopefully
> a patch) tomorrow with brain awake. Time for bed here...

Not yet there with a patch, but I have a trivial C reproducer. See
below.

The failure mode is:

    signal to task
      sigaction_handler()
        wreckage xsave.header.reserved[0]
        sig_return()
          restore_fpu_from_sigframe()
            try: XRSTOR from user -> #GP
            copy_from_user(fpstate, task->fpu.state.xsave);
            validate(task->fpu.state.xsave) -> fail
            fpu__clear_user_states()
              reinits FPU hardware but task state is still wreckaged
          signal_fault()
      sigsegv_handler()
        sig_return()
          restore_fpu_from_sigframe()
            try: XRSTOR from user -> success

     schedule()
       xsave()

     other task runs on same CPU so fpu state is not longer clean

     wakeup()
     exit_to_user()
      xrstor() -> #GP because the header is still borked.

XSAVE does not clear the header.reserved fields....

The original code kinda worked because fpu__clear() reinitialized the
task fpu state, but as this code is preemptible the same issue can
happen pre 5.8 as well if I'm not missing something. I'll verify that
after dinner.

The commit in question just made it trivial to trigger because it keeps
the broken task fpu state around.

The whole slow path is broken in disgusting ways. I have no good idea
yet how to fix that proper and in a way which can be backported easily.

Thanks,

        tglx
---
#define _GNU_SOURCE

#include <errno.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sched.h>

static void sig_handler(int sig, siginfo_t *info, void *__ctxp)
{
	ucontext_t *uctx = __ctxp;
	mcontext_t *mctx = &uctx->uc_mcontext;
	unsigned long *p = (unsigned long *) mctx->fpregs;

	/* Wreckage xsave.header.reserved[0] */
	p[66] = 0xfffffff;
}

static void sigsegv(int sig)
{
}

int main(void)
{
	struct sigaction sa;
	cpu_set_t set;

	memset(&sa, 0, sizeof(sa));
	sa.sa_sigaction = sig_handler;
	sa.sa_flags = SA_SIGINFO;
	sigemptyset(&sa.sa_mask);
	if (sigaction(SIGUSR1, &sa, 0))
		exit(1);

	signal(SIGSEGV, sigsegv);

	CPU_ZERO(&set);
	CPU_SET(0, &set);

	sched_setaffinity(getpid(), sizeof(set), &set);

	kill(0, SIGUSR1);
	fork();
	sleep(1);

	return 0;
}
