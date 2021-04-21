Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0B367123
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244696AbhDURR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:17:57 -0400
Received: from foss.arm.com ([217.140.110.172]:38466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241450AbhDURRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:17:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0E391424;
        Wed, 21 Apr 2021 10:17:21 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.3.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 322E73F694;
        Wed, 21 Apr 2021 10:17:20 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:17:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, oleg@redhat.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle
 compat
Message-ID: <20210421171715.GA52940@C02TD0UTHF1T.local>
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416123322.GA23184@arm.com>
 <9b5b340b-66ad-41c9-865e-32724e33a5b8@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b5b340b-66ad-41c9-865e-32724e33a5b8@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 04:42:53PM +0800, He Zhe wrote:
> On 4/16/21 8:33 PM, Catalin Marinas wrote:
> > On Fri, Apr 16, 2021 at 03:55:31PM +0800, He Zhe wrote:
> >> The general version of is_syscall_success does not handle 32-bit
> >> compatible case, which would cause 32-bit negative return code to be
> >> recoganized as a positive number later and seen as a "success".
> >>
> >> Since is_compat_thread is defined in compat.h, implementing
> >> is_syscall_success in ptrace.h would introduce build failure due to
> >> recursive inclusion of some basic headers like mutex.h. We put the
> >> implementation to ptrace.c
> >>
> >> Signed-off-by: He Zhe <zhe.he@windriver.com>
> >> ---
> >>  arch/arm64/include/asm/ptrace.h |  3 +++
> >>  arch/arm64/kernel/ptrace.c      | 10 ++++++++++
> >>  2 files changed, 13 insertions(+)
> >>
> >> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> >> index e58bca832dff..3c415e9e5d85 100644
> >> --- a/arch/arm64/include/asm/ptrace.h
> >> +++ b/arch/arm64/include/asm/ptrace.h
> >> @@ -328,6 +328,9 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
> >>  	regs->regs[0] = rc;
> >>  }
> >>  
> >> +extern inline int is_syscall_success(struct pt_regs *regs);
> >> +#define is_syscall_success(regs) is_syscall_success(regs)
> >> +
> >>  /**
> >>   * regs_get_kernel_argument() - get Nth function argument in kernel
> >>   * @regs:	pt_regs of that context
> >> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> >> index 170f42fd6101..3266201f8c60 100644
> >> --- a/arch/arm64/kernel/ptrace.c
> >> +++ b/arch/arm64/kernel/ptrace.c
> >> @@ -1909,3 +1909,13 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
> >>  	else
> >>  		return valid_native_regs(regs);
> >>  }
> >> +
> >> +inline int is_syscall_success(struct pt_regs *regs)
> >> +{
> >> +	unsigned long val = regs->regs[0];
> >> +
> >> +	if (is_compat_thread(task_thread_info(current)))
> >> +		val = sign_extend64(val, 31);
> >> +
> >> +	return !IS_ERR_VALUE(val);
> >> +}
> > It's better to use compat_user_mode(regs) here instead of
> > is_compat_thread(). It saves us from worrying whether regs are for the
> > current context.
> 
> Thanks. I'll use this for v2.
> 
> >
> > I think we should change regs_return_value() instead. This function
> > seems to be called from several other places and it has the same
> > potential problems if called on compat pt_regs.
> 
> IMHO, now that we have had specific function, syscall_get_return_value, to get
> syscall return code, we might as well use it. regs_return_value may be left for
> where we want internal return code. I found such places below and haven't found
> other places that syscall sign extension is concerned about.
> 
> kernel/test_kprobes.c
> kernel/trace/trace_kprobe.c
> samples/kprobes/kretprobe_example.c

FWIW, I agree that we should use syscall_get_return_value(). If we make
the common implementation of is_syscall_success() use
syscall_get_return_value(), we shouldn't need to write our own
implementation, so I'd prefer if we could do that if possible.

IIUC regs_get_return_value() was originally meant to be used for kernel
regs, and is trying to do something quite different, so having the core
code use syscall_get_return_value() makes sense to allow architectures
to handle those cases differently.

Thanks,
Mark.
