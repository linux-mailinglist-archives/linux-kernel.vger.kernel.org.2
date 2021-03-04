Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7529932DB19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhCDUUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:20:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:6280 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239044AbhCDUTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:19:47 -0500
IronPort-SDR: +Cav2cRedfECRZpSM1QkUegtnvB8nk+IfCN/YbXBWjG5S3pMg5T0qQyKfzLLBvMKnNsumlojX8
 /dPWbUJCnyKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="272504381"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="272504381"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 12:19:06 -0800
IronPort-SDR: 8IHLP432SVJfpEPtW/B8iO9EiS88EjkED9rCFG5tHm21VS10ACysIMBbq6/KSSpgZMsG8e92Hf
 /hvZwcnYUSeA==
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="407966663"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 12:19:06 -0800
Date:   Thu, 4 Mar 2021 12:19:06 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 04/11] x86/kthread,dumpstack: Set
 task_pt_regs->cs.RPL=3 for kernel threads
Message-ID: <20210304201906.GM3014244@iweiny-DESK2.sc.intel.com>
References: <cover.1614884673.git.luto@kernel.org>
 <c70a1a4632b976171ca5f3381ef84d40fd028861.1614884673.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c70a1a4632b976171ca5f3381ef84d40fd028861.1614884673.git.luto@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:05:57AM -0800, Andy Lutomirski wrote:
> For kernel threads, task_pt_regs is currently all zeros, a valid user state
> (if kernel_execve() has been called), or some combination thereof during
> execution of kernel_execve().  If a stack trace is printed, the unwinder
> might get confused and treat task_pt_regs as a kernel state.  Indeed,
> forcing a stack dump results in an attempt to display _kernel_ code bytes
> from a bogus address at the very top of kernel memory.
> 
> Fix the confusion by setting cs=3 so that user_mode(task_pt_regs(...)) ==
> true for kernel threads.
> 
> Also improve the error when failing to fetch code bytes to show which type
> of fetch failed.  This makes it much easier to understand what's happening.
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/kernel/dumpstack.c |  4 ++--
>  arch/x86/kernel/process.c   | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 55cf3c8325c6..9b7b69bb12e5 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -128,8 +128,8 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
>  		/* No access to the user space stack of other tasks. Ignore. */
>  		break;
>  	default:
> -		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
> -		       loglvl, prologue);
> +		printk("%sCode: Unable to access %s opcode bytes at RIP 0x%lx.\n",
> +		       loglvl, user_mode(regs) ? "user" : "kernel", prologue);
>  		break;
>  	}
>  }
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 145a7ac0c19a..f6f16df04cb9 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -163,6 +163,19 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  	/* Kernel thread ? */
>  	if (unlikely(p->flags & PF_KTHREAD)) {
>  		memset(childregs, 0, sizeof(struct pt_regs));
> +
> +		/*
> +		 * Even though there is no real user state here, these
> +		 * are were user regs belong, and kernel_execve() will
                       ^^^^^
                       where?

Ira

> +		 * overwrite them with user regs.  Put an obviously
> +		 * invalid value that nonetheless causes user_mode(regs)
> +		 * to return true in CS.
> +		 *
> +		 * This also prevents the unwinder from thinking that there
> +		 * is invalid kernel state at the top of the stack.
> +		 */
> +		childregs->cs = 3;
> +
>  		kthread_frame_init(frame, sp, arg);
>  		return 0;
>  	}
> -- 
> 2.29.2
> 
