Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A473A2929
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFJKSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhFJKSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:18:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29844613C6;
        Thu, 10 Jun 2021 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623320206;
        bh=6+nLeDoiuIVoMIimwxK/LqVQ2x7nzoElsByfywPVNkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OrWJbkTKlJqWvMNBauFZK3YK5P1EjdI/N94S6lEqwGjhg5lZbEMR6Msy+5f0UOOfz
         DYpDsOF4+EKxh4BRh1l+OSO/lZuMGIqbYFD2fpbDmYBAQPqYckMRw5irjHGJJqC1Eh
         2QhY5mWDbD0w3DVwTXaobkTMDxZordeKqjdmjzKr+6eEYXI+ZCuluBQYgyJ8iYNVMt
         bPFpSzFMM8eZi53fdCJafE+mkhHQ6o+M9tnT4cJ8BpFYAs6+uhiY8YAbMdyXm1Gwog
         9l58+rmZIqVx26U7OFC5TgKyHBdFZlKvKtZsY3IXuUlEyy029HWmIYIqokJAeRRJMb
         u9Ze3yDKJCxUw==
Date:   Thu, 10 Jun 2021 19:16:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
Message-Id: <20210610191643.d24e7d56d102567070fe8386@kernel.org>
In-Reply-To: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Thu, 10 Jun 2021 14:26:17 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> When probing at different locations in the kernel, it is not always
> evident if the location can be probed or not. As an example:
> 
>     $ perf probe __radix__flush_tlb_range:35
>     Failed to write event: Invalid argument
>       Error: Failed to add events.
> 
> The probed line above is:
>      35         if (!mmu_has_feature(MMU_FTR_GTSE) && type == FLUSH_TYPE_GLOBAL) {
> 
> This ends up trying to probe on BUILD_BUG_ON(), which is rejected.
> However, the user receives no indication at all as to why the probe
> failed. Print an error in such cases so that it is clear that the probe
> was rejected.

Hmm, Nack for this way, but I understand that is a problem.
If you got the error in perf probe, which uses ftrace dynamic-event interface.
In that case, the errors should not be output in the dmesg, but are reported
via error_log in tracefs.
And kprobes itself should return different error code to the caller, instead
of printing error in dmesg. See below.

[...]
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1542,8 +1542,10 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	int ret;
>  
>  	ret = arch_check_ftrace_location(p);
> -	if (ret)
> +	if (ret) {
> +		pr_err("kprobes: can't probe at the provided ftrace location\n");
>  		return ret;

This must be -EBUSY. (or arch depend return value)

> +	}
>  	jump_label_lock();
>  	preempt_disable();
>  
> @@ -1552,6 +1554,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	    within_kprobe_blacklist((unsigned long) p->addr) ||
>  	    jump_label_text_reserved(p->addr, p->addr) ||
>  	    find_bug((unsigned long)p->addr)) {
> +		pr_err("kprobes: can't probe at address in reject list\n");
>  		ret = -EINVAL;

This maybe -EACCESS.

>  		goto out;
>  	}
> @@ -1976,8 +1979,10 @@ int register_kretprobe(struct kretprobe *rp)
>  	void *addr;
>  
>  	ret = kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset);
> -	if (ret)
> +	if (ret) {
> +		pr_err("kretprobes: can't probe at address outside function entry\n");
>  		return ret;

return -ERANGE.

> +	}
>  
>  	/* If only rp->kp.addr is specified, check reregistering kprobes */
>  	if (rp->kp.addr && warn_kprobe_rereg(&rp->kp))
> @@ -1989,8 +1994,10 @@ int register_kretprobe(struct kretprobe *rp)
>  			return PTR_ERR(addr);
>  
>  		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
> -			if (kretprobe_blacklist[i].addr == addr)
> +			if (kretprobe_blacklist[i].addr == addr) {
> +				pr_err("kretprobes: can't probe at address in reject list\n");
>  				return -EINVAL;

return -EACCESS too.

Thank you,

> +			}
>  		}
>  	}
>  
> 
> base-commit: 2e38eb04c95e5546b71bb86ee699a891c7d212b5
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
