Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512103232CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhBWVF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:05:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46894 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbhBWVEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:04:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 14C121F450C9
Subject: Re: mainline/master bisection: baseline.login on
 meson-sm1-khadas-vim3l
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Remi Denis-Courmont <remi.denis.courmont@huawei.com>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
References: <6033a5da.1c69fb81.9be93.66e6@mx.google.com>
 <00e098ec-671b-1117-c9c6-7f8fa96519f7@collabora.com>
 <87blca27fy.wl-maz@kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <d9156098-f512-09bc-fa42-7a0f0bdee978@collabora.com>
Date:   Tue, 23 Feb 2021 21:03:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87blca27fy.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2021 14:18, Marc Zyngier wrote:
> Hi Guillaume,
> 
> On Tue, 23 Feb 2021 09:46:30 +0000,
> Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
>>
>> Hello Marc,
>>
>> Please see the bisection report below about a boot failure on
>> meson-sm1-khadas-vim3l on mainline.  It seems to only be
>> affecting kernels built with CONFIG_ARM64_64K_PAGES=y.
>>
>> Reports aren't automatically sent to the public while we're
>> trialing new bisection features on kernelci.org but this one
>> looks valid.
>>
>> There's no output in the log, so the kernel is most likely
>> crashing early.  Some more details can be found here:
>>
>>   https://kernelci.org/test/case/id/6034bed3b344e2860daddcc8/
>>
>> Please let us know if you need any help to debug the issue or try
>> a fix on this platform.
> 
> Thanks for the heads up.
> 
> There is actually a fundamental problem with the patch you bisected
> to: it provides no guarantee that the point where we enable the EL2
> MMU is in the idmap and, as it turns out, the code we're running from
> disappears from under our feet, leading to a translation fault we're
> not prepared to handle.
> 
> How does it work with 4kB pages? Luck.

There may be a fascinating explanation for it, but luck works
too.  It really seems to be booting happily with 4k pages:

  https://kernelci.org/test/plan/id/60347b358de339d1b7addcc5/

> Do you mind giving the patch below a go? It does work on my vim3l and
> on a FVP, so odds are that it will solve it for you too.

Sure, and that worked here as well:

  http://lava.baylibre.com:10080/scheduler/job/752416

and here's the test branch where I applied your fix, for
completeness:

  https://gitlab.collabora.com/gtucker/linux/-/commits/v5.11-vim3l-vhe/

As always, if you do send a patch with the fix, please give some
credit to the bot:

  Reported-by: "kernelci.org bot" <bot@kernelci.org> 

Thanks,
Guillaume


> Thanks,
> 
> 	M.
> 
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 678cd2c618ee..fbd2543b8f7d 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -96,8 +96,10 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
>  	cmp	x1, xzr
>  	and	x2, x2, x1
>  	csinv	x2, x2, xzr, ne
> -	cbz	x2, 1f
> +	cbnz	x2, 2f
>  
> +1:	eret
> +2:
>  	// Engage the VHE magic!
>  	mov_q	x0, HCR_HOST_VHE_FLAGS
>  	msr	hcr_el2, x0
> @@ -131,11 +133,29 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
>  	msr	mair_el1, x0
>  	isb
>  
> +	// Hack the exception return to stay at EL2
> +	mrs	x0, spsr_el1
> +	and	x0, x0, #~PSR_MODE_MASK
> +	mov	x1, #PSR_MODE_EL2h
> +	orr	x0, x0, x1
> +	msr	spsr_el1, x0
> +
> +	b	enter_vhe
> +SYM_CODE_END(mutate_to_vhe)
> +
> +	// At the point where we reach enter_vhe(), we run with
> +	// the MMU off (which is enforced by mutate_to_vhe()).
> +	// We thus need to be in the idmap, or everything will
> +	// explode when enabling the MMU.
> +
> +	.pushsection	.idmap.text, "ax"
> +
> +SYM_CODE_START_LOCAL(enter_vhe)
> +	// Enable the EL2 S1 MMU, as set up from EL1
>  	// Invalidate TLBs before enabling the MMU
>  	tlbi	vmalle1
>  	dsb	nsh
>  
> -	// Enable the EL2 S1 MMU, as set up from EL1
>  	mrs_s	x0, SYS_SCTLR_EL12
>  	set_sctlr_el1	x0
>  
> @@ -143,17 +163,12 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
>  	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
>  	msr_s	SYS_SCTLR_EL12, x0
>  
> -	// Hack the exception return to stay at EL2
> -	mrs	x0, spsr_el1
> -	and	x0, x0, #~PSR_MODE_MASK
> -	mov	x1, #PSR_MODE_EL2h
> -	orr	x0, x0, x1
> -	msr	spsr_el1, x0
> -
>  	mov	x0, xzr
>  
> -1:	eret
> -SYM_CODE_END(mutate_to_vhe)
> +	eret
> +SYM_CODE_END(enter_vhe)
> +
> +	.popsection
>  
>  .macro invalid_vector	label
>  SYM_CODE_START_LOCAL(\label)
> 
> 

