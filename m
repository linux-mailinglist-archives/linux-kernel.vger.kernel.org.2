Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08E140AB36
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhINJ4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:56:44 -0400
Received: from foss.arm.com ([217.140.110.172]:42240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhINJ4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:56:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8CD6D;
        Tue, 14 Sep 2021 02:55:24 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.21.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986A13F719;
        Tue, 14 Sep 2021 02:55:22 -0700 (PDT)
Date:   Tue, 14 Sep 2021 10:55:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: entry: Improve the performance of system calls
Message-ID: <20210914095436.GA26544@C02TD0UTHF1T.local>
References: <20210903121950.2284-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903121950.2284-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 03, 2021 at 08:19:50PM +0800, Zhen Lei wrote:
> Commit 582f95835a8f ("arm64: entry: convert el0_sync to C") converted lots
> of functions from assembly to C, this greatly improves readability. But
> el0_svc()/el0_svc_compat() is in response to system call requests from
> user mode and may be in the hot path.
> 
> Although the SVC is in the first case of the switch statement in C, the
> compiler optimizes the switch statement as a whole, and does not give SVC
> a small boost.
> 
> Use "likely()" to help SVC directly invoke its handler after a simple
> judgment to avoid entering the switch table lookup process.
> 
> After:
> 0000000000000ff0 <el0t_64_sync_handler>:
>      ff0:       d503245f        bti     c
>      ff4:       d503233f        paciasp
>      ff8:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
>      ffc:       910003fd        mov     x29, sp
>     1000:       d5385201        mrs     x1, esr_el1
>     1004:       531a7c22        lsr     w2, w1, #26
>     1008:       f100545f        cmp     x2, #0x15
>     100c:       540000a1        b.ne    1020 <el0t_64_sync_handler+0x30>
>     1010:       97fffe14        bl      860 <el0_svc>
>     1014:       a8c17bfd        ldp     x29, x30, [sp], #16
>     1018:       d50323bf        autiasp
>     101c:       d65f03c0        ret
>     1020:       f100705f        cmp     x2, #0x1c

It would be helpful if you could state which toolchain and config was
used to generate the above.

For comparison, what was the code generation like before? I assume
el0_svc wasn't the target of the first test and branch? Assuming so, how
many tests and branches were there before the call to el0_svc()?

At a high-level, I'm not too keen on special-casing things unless
necessary.

I wonder if we could get similar results without special-casing by using
a static const array of handlers indexed by the EC, since (with GCC
11.1.0 from the kernel.org crosstool page) that can result in code like:

0000000000001010 <el0t_64_sync_handler>:
    1010:       d503245f        bti     c
    1014:       d503233f        paciasp
    1018:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
    101c:       910003fd        mov     x29, sp
    1020:       d5385201        mrs     x1, esr_el1
    1024:       90000002        adrp    x2, 0 <el0t_64_sync_handlers>
    1028:       531a7c23        lsr     w3, w1, #26
    102c:       91000042        add     x2, x2, #:lo12:<el0t_64_sync_handlers>
    1030:       f8637842        ldr     x2, [x2, x3, lsl #3]
    1034:       d63f0040        blr     x2
    1038:       a8c17bfd        ldp     x29, x30, [sp], #16
    103c:       d50323bf        autiasp
    1040:       d65f03c0        ret

... which might do better by virtue of reducing a chain of potential
mispredicts down to a single potential mispredict, and dynamic branch
prediction hopefully does a good job of predicting the common case at
runtime. That said, the resulting tables will be pretty big...

> 
> Execute "./lat_syscall null" on my board (BogoMIPS : 200.00), it can save
> about 10ns.
> 
> Before:
> Simple syscall: 0.2365 microseconds
> Simple syscall: 0.2354 microseconds
> Simple syscall: 0.2339 microseconds
> 
> After:
> Simple syscall: 0.2255 microseconds
> Simple syscall: 0.2254 microseconds
> Simple syscall: 0.2256 microseconds

I appreciate this can be seen by a microbenchmark, but does this have an
impact on a real workload? I'd imagine that real syscall usage will
dominate this in practice, and this would fall into the noise.

Thanks,
Mark.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/kernel/entry-common.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 32f9796c4ffe77b..062eb5a895ec6f3 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -607,11 +607,14 @@ static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
>  asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
>  {
>  	unsigned long esr = read_sysreg(esr_el1);
> +	unsigned long ec = ESR_ELx_EC(esr);
>  
> -	switch (ESR_ELx_EC(esr)) {
> -	case ESR_ELx_EC_SVC64:
> +	if (likely(ec == ESR_ELx_EC_SVC64)) {
>  		el0_svc(regs);
> -		break;
> +		return;
> +	}
> +
> +	switch (ec) {
>  	case ESR_ELx_EC_DABT_LOW:
>  		el0_da(regs, esr);
>  		break;
> @@ -730,11 +733,14 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
>  asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
>  {
>  	unsigned long esr = read_sysreg(esr_el1);
> +	unsigned long ec = ESR_ELx_EC(esr);
>  
> -	switch (ESR_ELx_EC(esr)) {
> -	case ESR_ELx_EC_SVC32:
> +	if (likely(ec == ESR_ELx_EC_SVC32)) {
>  		el0_svc_compat(regs);
> -		break;
> +		return;
> +	}
> +
> +	switch (ec) {
>  	case ESR_ELx_EC_DABT_LOW:
>  		el0_da(regs, esr);
>  		break;
> -- 
> 2.25.1
> 
