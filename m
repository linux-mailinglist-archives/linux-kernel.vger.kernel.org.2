Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D1633FA41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhCQVC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233494AbhCQVCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:02:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82BB864EE7;
        Wed, 17 Mar 2021 21:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616014925;
        bh=ZogjEdjKQAhjXyPzAFxZvQQtQO3W9Tg9U2Pxkh6sU8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkgvOlbvw4mwrydnJc/U6K2RNNySw3XUhNERP+p3j5Ni52el9/uBnbs0JSrkCpZEY
         LMjsQToCxWhUNf+49GMg8zW8X/ZLOjx9pPiRu5UHHNtCCTtvwA/7yl5VCeOzw6EHbN
         yMNldQZd9lYp2nwGiZ9EIyI0RIIoLQh2BUlRfwxZWAq1GK1/AEOnAp3xiqxNXLwvTI
         Y3QwAg50O3nMpVH2rt/9AK1lJHcQ1zuEwEJ2om3LZuJI6siCxA8MYzD8vsohY6nSx8
         fgruWFLohRnujOXQYlabfY/TSZxYAxuYFKm1X6hmZoT74poTWWv00DQR4LDEkMdCfC
         NuJOYyxRyy1gg==
Date:   Wed, 17 Mar 2021 23:01:38 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Oliver Sang <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jbaron@akamai.com,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool,static_call: Don't emit static_call_site for
 .exit.text
Message-ID: <YFJuMi9ZSJk5Ctvw@kernel.org>
References: <20210315142345.GB4401@xsang-OptiPlex-9020>
 <CAFA6WYNMHAqqmNfncmJm3+BUYCktXouRtV_udSxQb7eifPmX+Q@mail.gmail.com>
 <20210317030101.GB22345@xsang-OptiPlex-9020>
 <CAFA6WYMb-C2L7DmGnhWgxjuuvP=qxPA4-s4q+knxH+iWXypHmw@mail.gmail.com>
 <YFHAsgNhe8c3ZHQN@hirez.programming.kicks-ass.net>
 <YFHE9CjanDAD4l5M@hirez.programming.kicks-ass.net>
 <YFHFjarVo7HAP7pg@hirez.programming.kicks-ass.net>
 <CAFA6WYNs-rQLUGPMwc-p0q_KRvR16rm-x55gDqw828c7-C1qeA@mail.gmail.com>
 <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 01:45:57PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 17, 2021 at 05:25:48PM +0530, Sumit Garg wrote:
> > Thanks Peter for this fix. It does work for me on qemu for x86. Can
> > you turn this into a proper fix patch? BTW, feel free to add:
> 
> Per the below, the original patch ought to be fixed as well, to not use
> static_call() in __exit.
> 
> ---
> Subject: objtool,static_call: Don't emit static_call_site for .exit.text
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Mar 17 13:35:05 CET 2021
> 
> Functions marked __exit are (somewhat surprisingly) discarded at
> runtime when built-in. This means that static_call(), when used in
> __exit functions, will generate static_call_site entries that point
> into reclaimed space.
> 
> Simply skip such sites and emit a WARN about it. By not emitting a
> static_call_site the site will remain pointed at the trampoline, which
> is also maintained, so things will work as expected, albeit with the
> extra indirection.
> 
> The WARN is so that people are aware of this; and arguably it simply
> isn't a good idea to use static_call() in __exit code anyway, since
> module unload is never a performance critical path.
> 
> Reported-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> ---
>  tools/objtool/check.c |   32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -850,6 +850,22 @@ static int add_ignore_alternatives(struc
>  	return 0;
>  }
>  
> +static inline void static_call_add(struct instruction *insn,
> +				   struct objtool_file *file)
> +{
> +	if (!insn->call_dest->static_call_tramp)
> +		return;
> +
> +	if (!strcmp(insn->sec->name, ".exit.text")) {
> +		WARN_FUNC("static_call in .exit.text, skipping inline patching",
> +			  insn->sec, insn->offset);
> +		return;
> +	}
> +
> +	list_add_tail(&insn->static_call_node,
> +		      &file->static_call_list);
> +}
> +
>  /*
>   * Find the destination instructions for all jumps.
>   */
> @@ -888,10 +904,7 @@ static int add_jump_destinations(struct
>  		} else if (insn->func) {
>  			/* internal or external sibling call (with reloc) */
>  			insn->call_dest = reloc->sym;
> -			if (insn->call_dest->static_call_tramp) {
> -				list_add_tail(&insn->static_call_node,
> -					      &file->static_call_list);
> -			}
> +			static_call_add(insn, file);
>  			continue;
>  		} else if (reloc->sym->sec->idx) {
>  			dest_sec = reloc->sym->sec;
> @@ -950,10 +963,7 @@ static int add_jump_destinations(struct
>  
>  				/* internal sibling call (without reloc) */
>  				insn->call_dest = insn->jump_dest->func;
> -				if (insn->call_dest->static_call_tramp) {
> -					list_add_tail(&insn->static_call_node,
> -						      &file->static_call_list);
> -				}
> +				static_call_add(insn, file);
>  			}
>  		}
>  	}
> @@ -2746,10 +2756,8 @@ static int validate_branch(struct objtoo
>  			if (dead_end_function(file, insn->call_dest))
>  				return 0;
>  
> -			if (insn->type == INSN_CALL && insn->call_dest->static_call_tramp) {
> -				list_add_tail(&insn->static_call_node,
> -					      &file->static_call_list);
> -			}
> +			if (insn->type == INSN_CALL)
> +				static_call_add(insn, file);
>  
>  			break;
>  
> 
