Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1015B32C3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354330AbhCDAIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:08:07 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50980 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390139AbhCCWCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:02:02 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 59C4F72C8B8;
        Thu,  4 Mar 2021 00:51:07 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 47F467CC8A2; Thu,  4 Mar 2021 00:51:07 +0300 (MSK)
Date:   Thu, 4 Mar 2021 00:51:07 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: fix ia64_syscall_get_set_arguments() for
 break-based syscalls
Message-ID: <20210303215107.GC19445@altlinux.org>
References: <20210221002554.333076-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221002554.333076-1-slyfox@gentoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 12:25:53AM +0000, Sergei Trofimovich wrote:
> In https://bugs.gentoo.org/769614 Dmitry noticed that
> `ptrace(PTRACE_GET_SYSCALL_INFO)` does not work for syscalls called
> via glibc's syscall() wrapper.
> 
> ia64 has two ways to call syscalls from userspace: via `break` and via
> `eps` instructions.
> 
> The difference is in stack layout:
> 
> 1. `eps` creates simple stack frame: no locals, in{0..7} == out{0..8}
> 2. `break` uses userspace stack frame: may be locals (glibc provides
>    one), in{0..7} == out{0..8}.
> 
> Both work fine in syscall handling cde itself.
> 
> But `ptrace(PTRACE_GET_SYSCALL_INFO)` uses unwind mechanism to
> re-extract syscall arguments but it does not account for locals.
> 
> The change always skips locals registers. It should not change `eps`
> path as kernel's handler already enforces locals=0 and fixes `break`.
> 
> Tested on v5.10 on rx3600 machine (ia64 9040 CPU).
> 
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: linux-ia64@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Dmitry V. Levin <ldv@altlinux.org>
> Bug: https://bugs.gentoo.org/769614
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  arch/ia64/kernel/ptrace.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
> index c3490ee2daa5..e14f5653393a 100644
> --- a/arch/ia64/kernel/ptrace.c
> +++ b/arch/ia64/kernel/ptrace.c
> @@ -2013,27 +2013,39 @@ static void syscall_get_set_args_cb(struct unw_frame_info *info, void *data)
>  {
>  	struct syscall_get_set_args *args = data;
>  	struct pt_regs *pt = args->regs;
> -	unsigned long *krbs, cfm, ndirty;
> +	unsigned long *krbs, cfm, ndirty, nlocals, nouts;
>  	int i, count;
>  
>  	if (unw_unwind_to_user(info) < 0)
>  		return;
>  
> +	/*
> +	 * We get here via a few paths:
> +	 * - break instruction: cfm is shared with caller.
> +	 *   syscall args are in out= regs, locals are non-empty.
> +	 * - epsinstruction: cfm is set by br.call
> +	 *   locals don't exist.

typo: epsinstruction

> +	 *
> +	 * For both cases argguments are reachable in cfm.sof - cfm.sol.

typo: argguments

> +	 * CFM: [ ... | sor: 17..14 | sol : 13..7 | sof : 6..0 ]
> +	 */
>  	cfm = pt->cr_ifs;
> +	nlocals = (cfm >> 7) & 0x7f; /* aka sol */
> +	nouts = (cfm & 0x7f) - nlocals; /* aka sof - sol */
>  	krbs = (unsigned long *)info->task + IA64_RBS_OFFSET/8;
>  	ndirty = ia64_rse_num_regs(krbs, krbs + (pt->loadrs >> 19));
>  
>  	count = 0;
>  	if (in_syscall(pt))
> -		count = min_t(int, args->n, cfm & 0x7f);
> +		count = min_t(int, args->n, nouts);
>  
> +	/* Iterate over outs. */
>  	for (i = 0; i < count; i++) {
> +		int j = ndirty + nlocals + i + args->i;
>  		if (args->rw)
> -			*ia64_rse_skip_regs(krbs, ndirty + i + args->i) =
> -				args->args[i];
> +			*ia64_rse_skip_regs(krbs, j) = args->args[i];
>  		else
> -			args->args[i] = *ia64_rse_skip_regs(krbs,
> -				ndirty + i + args->i);
> +			args->args[i] = *ia64_rse_skip_regs(krbs, j);
>  	}
>  
>  	if (!args->rw) {

This stuff is too ia64 specific, so I cannot properly review this patch,
but it definitely fixes ia64 PTRACE_GET_SYSCALL_INFO on entering syscall.


-- 
ldv
