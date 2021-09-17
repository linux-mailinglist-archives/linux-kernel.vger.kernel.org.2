Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B158D40F4E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbhIQJiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:38:03 -0400
Received: from foss.arm.com ([217.140.110.172]:50496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241198AbhIQJh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:37:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92122101E;
        Fri, 17 Sep 2021 02:36:36 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.20.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428D43F59C;
        Fri, 17 Sep 2021 02:36:35 -0700 (PDT)
Date:   Fri, 17 Sep 2021 10:36:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] arm64/traps: Avoid unnecessary kernel/user pointer
 conversion
Message-ID: <20210917093628.GB75427@C02TD0UTHF1T.local>
References: <20210917055811.22341-1-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917055811.22341-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:28:11AM +0530, Amit Daniel Kachhap wrote:
> Annotating a pointer from kernel to __user and then back again requires
> an extra __force annotation to silent sparse warning. In call_undef_hook()
> this unnecessary complexity can be avoided by modifying the intermediate
> user pointer to unsigned long.
> 
> This way there is no inter-changeable use of user and kernel pointers
> and the code is consistent.
> 
> Note: This patch adds no functional changes to code.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>

I like that this clarifies that `pc` is not necessarily a user pointer,
and this makes the relevant lines shorter and eaier to read, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
> Changes from v1:
> * Instead of directly using instruction_pointer() for kernel pointers,
>   modified the pc type from void __user * to unsigned long as suggested
>   by Mark Rutland.
> 
>  arch/arm64/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index b03e383d944a..09236751283e 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -400,11 +400,11 @@ static int call_undef_hook(struct pt_regs *regs)
>  	unsigned long flags;
>  	u32 instr;
>  	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
> -	void __user *pc = (void __user *)instruction_pointer(regs);
> +	unsigned long pc = instruction_pointer(regs);
>  
>  	if (!user_mode(regs)) {
>  		__le32 instr_le;
> -		if (get_kernel_nofault(instr_le, (__force __le32 *)pc))
> +		if (get_kernel_nofault(instr_le, (__le32 *)pc))
>  			goto exit;
>  		instr = le32_to_cpu(instr_le);
>  	} else if (compat_thumb_mode(regs)) {
> -- 
> 2.17.1
> 
