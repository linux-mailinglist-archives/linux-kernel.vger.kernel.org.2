Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2630A7F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhBAMs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:48:27 -0500
Received: from foss.arm.com ([217.140.110.172]:59038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhBAMsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:48:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A1E1ED1;
        Mon,  1 Feb 2021 04:47:31 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE4193F66E;
        Mon,  1 Feb 2021 04:47:28 -0800 (PST)
Date:   Mon, 1 Feb 2021 12:47:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        rppt@kernel.org, penberg@kernel.org, geert@linux-m68k.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201124720.GA66060@C02TD0UTHF1T.local>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 12:44:56AM +0000, Giancarlo Ferrari wrote:
> machine_kexec() need to set rw permission in text and rodata sections
> to assign some variables (e.g. kexec_start_address). To do that at
> the end (after flushing pdm in memory, etc.) it needs to invalidate
> TLB [section] entries.

It'd be worth noting explicitly that set_kernel_text_rw() alters
current->active_mm...

> If during the TLB invalidation an interrupt occours, which might cause
> a context switch, there is the risk to inject invalid TLBs, with ro
> permissions.

... which is why if there's a context switch things can go wrong, since
active_mm isn't stable, and so it's possible that set_kernel_text_rw()
updates multiple tables, none of which might be the active table at the
point we try to make an access.

It would be nice to spell that out rather than saying "invalid TLBs".

We could disable preemption to prevent that, which is possibly better
than disabling interrupts.

Overall, it would be much better to avoid having to mess with the kernel
page tables. So rather than going:

1. mark kernel RW
2. alter variables in reloc code
3. copy reloc code into buffer
4. branch to buffer

... we should be able to go:

1. copy reloc code into buffer
2. alter variables in copy of reloc code
3. branch to buffer

... which would avoid this class of problem too.

Thanks,
Mark.

> When trying to assign .text labels, this lead to the following:
> 
>  Unable to handle kernel paging request at virtual address 80112f38
>  pgd = fd7ef03e
>  [80112f38] *pgd=0001141e(bad)
>  Internal error: Oops: 80d [#1] PREEMPT SMP ARM
>  ...
> 
> Signed-off-by: Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
> ---
>  arch/arm/kernel/machine_kexec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 5d84ad3..23e8816 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -174,6 +174,13 @@ void machine_kexec(struct kimage *image)
>  
>  	reboot_code_buffer = page_address(image->control_code_page);
>  
> +	/*
> +	 * If below part is not atomic TLB entries might be corrupted after TLB
> +	 * invalidation, which leads to Data Abort in .text variable assignment
> +	 */
> +	raw_local_irq_disable();
> +	local_fiq_disable();
> +
>  	/* Prepare parameters for reboot_code_buffer*/
>  	set_kernel_text_rw();
>  	kexec_start_address = image->start;
> @@ -181,6 +188,9 @@ void machine_kexec(struct kimage *image)
>  	kexec_mach_type = machine_arch_type;
>  	kexec_boot_atags = image->arch.kernel_r2;
>  
> +	local_fiq_enable();
> +	raw_local_irq_enable();
> +
>  	/* copy our kernel relocation code to the control code page */
>  	reboot_entry = fncpy(reboot_code_buffer,
>  			     &relocate_new_kernel,
> -- 
> 2.7.4
> 
