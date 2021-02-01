Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF1230A930
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhBAN6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:58:05 -0500
Received: from foss.arm.com ([217.140.110.172]:60624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232157AbhBAN6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:58:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEE01101E;
        Mon,  1 Feb 2021 05:57:18 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50AB83F71A;
        Mon,  1 Feb 2021 05:57:17 -0800 (PST)
Date:   Mon, 1 Feb 2021 13:57:14 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>,
        linux-kernel@vger.kernel.org, penberg@kernel.org,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201135714.GB66060@C02TD0UTHF1T.local>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201130344.GF1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201130344.GF1463@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 01:03:45PM +0000, Russell King - ARM Linux admin wrote:
> On Mon, Feb 01, 2021 at 12:47:20PM +0000, Mark Rutland wrote:
> > 1. copy reloc code into buffer
> > 2. alter variables in copy of reloc code
> > 3. branch to buffer
> > 
> > ... which would avoid this class of problem too.
> 
> Yep, slightly messy to do though:
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 5d84ad333f05..6058e0d3a40d 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -174,18 +174,27 @@ void machine_kexec(struct kimage *image)
>  
>  	reboot_code_buffer = page_address(image->control_code_page);
>  
> -	/* Prepare parameters for reboot_code_buffer*/
> -	set_kernel_text_rw();
> -	kexec_start_address = image->start;
> -	kexec_indirection_page = page_list;
> -	kexec_mach_type = machine_arch_type;
> -	kexec_boot_atags = image->arch.kernel_r2;
> -
>  	/* copy our kernel relocation code to the control code page */
>  	reboot_entry = fncpy(reboot_code_buffer,
>  			     &relocate_new_kernel,
>  			     relocate_new_kernel_size);
>  
> +#define set(what, val) \
> +	do { \
> +		uintptr_t __funcp_address; \
> +		int __offset; \
> +		void *__ptr; \
> +		asm("" : "=r" (__funcp_address) : "0" (&relocate_new_kernel)); \
> +		__offset = (uintptr_t)&(what) - (__funcp_address & ~1); \
> +		__ptr = reboot_code_buffer + __offset; \
> +		*(__typeof__(&(what)))__ptr = val; \
> +	} while (0)
> +
> +	set(kexec_start_address, image->start);
> +	set(kexec_indirection_page, page_list);
> +	set(kexec_mach_type, machine_arch_type);
> +	set(kexec_boot_atags, image->arch.kernel_r2);

We could simplify this slightly if we moved the kexec_& variables into a
struct (using asm-offset KEXEC_VAR_* offsets and a KEXEC_VAR_SIZE region
reserved in the asm), then here we could do something like:

static struct kexec_vars *kexec_buffer_vars(void *buffer)
{
	unsigned long code = ((unisigned long)relocate_new_kernel) & ~1;
	unsigned long vars - (unsigned long)relocate_vars;
	unsigned long offset = vars - code;

	return buffer + offset;
}

... and in machine_kexec() do:

	struct kexec_vars *kv = kexec_buffer_vars(reboot_code_buffer);

	kv->start_address = image->start;
	kv->indirection_page = page_list;
	kv->mach_type = machine-arch_type;
	kv->boot_atags = arch.kernel_r2;

... if that looks any better to you?

Mark.
