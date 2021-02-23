Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBD0322806
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhBWJri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhBWJrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:47:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6902EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 01:46:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id AA7131F452EF
Subject: Re: mainline/master bisection: baseline.login on
 meson-sm1-khadas-vim3l
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Brazdil <dbrazdil@google.com>
References: <6033a5da.1c69fb81.9be93.66e6@mx.google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Remi Denis-Courmont <remi.denis.courmont@huawei.com>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <00e098ec-671b-1117-c9c6-7f8fa96519f7@collabora.com>
Date:   Tue, 23 Feb 2021 09:46:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6033a5da.1c69fb81.9be93.66e6@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

Please see the bisection report below about a boot failure on
meson-sm1-khadas-vim3l on mainline.  It seems to only be
affecting kernels built with CONFIG_ARM64_64K_PAGES=y.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

There's no output in the log, so the kernel is most likely
crashing early.  Some more details can be found here:

  https://kernelci.org/test/case/id/6034bed3b344e2860daddcc8/

Please let us know if you need any help to debug the issue or try
a fix on this platform.

Best wishes,
Guillaume

On 22/02/2021 12:38, KernelCI bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> mainline/master bisection: baseline.login on meson-sm1-khadas-vim3l
> 
> Summary:
>   Start:      31caf8b2a847 Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
>   Plain log:  https://storage.kernelci.org/mainline/master/v5.11-7579-g31caf8b2a847/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/clang-10/lab-baylibre/baseline-meson-sm1-khadas-vim3l.txt
>   HTML log:   https://storage.kernelci.org/mainline/master/v5.11-7579-g31caf8b2a847/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/clang-10/lab-baylibre/baseline-meson-sm1-khadas-vim3l.html
>   Result:     0c93df9622d4 arm64: Initialise as nVHE before switching to VHE
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       mainline
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   Branch:     master
>   Target:     meson-sm1-khadas-vim3l
>   CPU arch:   arm64
>   Lab:        lab-baylibre
>   Compiler:   clang-10
>   Config:     defconfig+CONFIG_ARM64_64K_PAGES=y
>   Test case:  baseline.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 0c93df9622d4d921bcd0dc83f71fed9e98f5119f
> Author: Marc Zyngier <maz@kernel.org>
> Date:   Mon Feb 8 09:57:14 2021 +0000
> 
>     arm64: Initialise as nVHE before switching to VHE
>     
>     As we are aiming to be able to control whether we enable VHE or
>     not, let's always drop down to EL1 first, and only then upgrade
>     to VHE if at all possible.
>     
>     This means that if the kernel is booted at EL2, we always start
>     with a nVHE init, drop to EL1 to initialise the the kernel, and
>     only then upgrade the kernel EL to EL2 if possible (the process
>     is obviously shortened for secondary CPUs).
>     
>     The resume path is handled similarly to a secondary CPU boot.
>     
>     Signed-off-by: Marc Zyngier <maz@kernel.org>
>     Acked-by: David Brazdil <dbrazdil@google.com>
>     Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>     Link: https://lore.kernel.org/r/20210208095732.3267263-6-maz@kernel.org
>     [will: Avoid calling switch_to_vhe twice on kaslr path]
>     Signed-off-by: Will Deacon <will@kernel.org>
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 28e9735302df..ec66dc061b0c 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -447,6 +447,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>  	ret					// to __primary_switch()
>  0:
>  #endif
> +	bl	switch_to_vhe			// Prefer VHE if possible
>  	add	sp, sp, #16
>  	mov	x29, #0
>  	mov	x30, #0
> @@ -493,42 +494,6 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
>  	eret
>  
>  SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
> -#ifdef CONFIG_ARM64_VHE
> -	/*
> -	 * Check for VHE being present. x2 being non-zero indicates that we
> -	 * do have VHE, and that the kernel is intended to run at EL2.
> -	 */
> -	mrs	x2, id_aa64mmfr1_el1
> -	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
> -#else
> -	mov	x2, xzr
> -#endif
> -	cbz	x2, init_el2_nvhe
> -
> -	/*
> -	 * When VHE _is_ in use, EL1 will not be used in the host and
> -	 * requires no configuration, and all non-hyp-specific EL2 setup
> -	 * will be done via the _EL1 system register aliases in __cpu_setup.
> -	 */
> -	mov_q	x0, HCR_HOST_VHE_FLAGS
> -	msr	hcr_el2, x0
> -	isb
> -
> -	init_el2_state vhe
> -
> -	isb
> -
> -	mov_q	x0, INIT_PSTATE_EL2
> -	msr	spsr_el2, x0
> -	msr	elr_el2, lr
> -	mov	w0, #BOOT_CPU_MODE_EL2
> -	eret
> -
> -SYM_INNER_LABEL(init_el2_nvhe, SYM_L_LOCAL)
> -	/*
> -	 * When VHE is not in use, early init of EL2 and EL1 needs to be
> -	 * done here.
> -	 */
>  	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
>  	msr	sctlr_el1, x0
>  
> @@ -623,6 +588,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
>  	/*
>  	 * Common entry point for secondary CPUs.
>  	 */
> +	bl	switch_to_vhe
>  	bl	__cpu_secondary_check52bitva
>  	bl	__cpu_setup			// initialise processor
>  	adrp	x1, swapper_pg_dir
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 3f3dbbe8914d..373ed2213e1d 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -190,3 +190,27 @@ SYM_FUNC_START(__hyp_reset_vectors)
>  	hvc	#0
>  	ret
>  SYM_FUNC_END(__hyp_reset_vectors)
> +
> +/*
> + * Entry point to switch to VHE if deemed capable
> + */
> +SYM_FUNC_START(switch_to_vhe)
> +#ifdef CONFIG_ARM64_VHE
> +	// Need to have booted at EL2
> +	adr_l	x1, __boot_cpu_mode
> +	ldr	w0, [x1]
> +	cmp	w0, #BOOT_CPU_MODE_EL2
> +	b.ne	1f
> +
> +	// and still be at EL1
> +	mrs	x0, CurrentEL
> +	cmp	x0, #CurrentEL_EL1
> +	b.ne	1f
> +
> +	// Turn the world upside down
> +	mov	x0, #HVC_VHE_RESTART
> +	hvc	#0
> +1:
> +#endif
> +	ret
> +SYM_FUNC_END(switch_to_vhe)
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index 6bdef7362c0e..5bfd9b87f85d 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -100,6 +100,7 @@ SYM_FUNC_END(__cpu_suspend_enter)
>  	.pushsection ".idmap.text", "awx"
>  SYM_CODE_START(cpu_resume)
>  	bl	init_kernel_el
> +	bl	switch_to_vhe
>  	bl	__cpu_setup
>  	/* enable the MMU early - so we can access sleep_save_stash by va */
>  	adrp	x1, swapper_pg_dir
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [55f62bc873477dae2c45bbbc30b86cf3e0982f3b] Merge tag 'pnp-5.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good 55f62bc873477dae2c45bbbc30b86cf3e0982f3b
> # bad: [31caf8b2a847214be856f843e251fc2ed2cd1075] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect bad 31caf8b2a847214be856f843e251fc2ed2cd1075
> # bad: [de1617578849acab8e16c9ffdce39b91fb50639d] Merge tag 'media/v5.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> git bisect bad de1617578849acab8e16c9ffdce39b91fb50639d
> # good: [657bd90c93146a929c69cd43addf2804eb70c926] Merge tag 'sched-core-2021-02-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 657bd90c93146a929c69cd43addf2804eb70c926
> # bad: [3e10585335b7967326ca7b4118cada0d2d00a2ab] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect bad 3e10585335b7967326ca7b4118cada0d2d00a2ab
> # bad: [08179b47e1fdf288e5d59f90e5ce31513bb019c3] Merge branch 'parisc-5.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> git bisect bad 08179b47e1fdf288e5d59f90e5ce31513bb019c3
> # bad: [99ca0edb41aabd888ca1548fa0391a4975740a83] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect bad 99ca0edb41aabd888ca1548fa0391a4975740a83
> # bad: [1d32854ea76331d10d376ed3ac67831b94466ae9] Merge branch 'for-next/misc' into for-next/core
> git bisect bad 1d32854ea76331d10d376ed3ac67831b94466ae9
> # bad: [90eb8c9d94fa7f9969792584c376b435bf8a035c] Merge branch 'for-next/errata' into for-next/core
> git bisect bad 90eb8c9d94fa7f9969792584c376b435bf8a035c
> # bad: [41fac42c25338f4ea295b58106c26683d893a1c6] arm64: Honor VHE being disabled from the command-line
> git bisect bad 41fac42c25338f4ea295b58106c26683d893a1c6
> # bad: [19e87e131915a2389a08874092a82fe5aa0f8952] arm64: Move VHE-specific SPE setup to mutate_to_vhe()
> git bisect bad 19e87e131915a2389a08874092a82fe5aa0f8952
> # good: [8cc8a32415364e475c25277b507f06f67c47ca9a] arm64: Turn the MMU-on sequence into a macro
> git bisect good 8cc8a32415364e475c25277b507f06f67c47ca9a
> # bad: [0c93df9622d4d921bcd0dc83f71fed9e98f5119f] arm64: Initialise as nVHE before switching to VHE
> git bisect bad 0c93df9622d4d921bcd0dc83f71fed9e98f5119f
> # good: [f359182291c757cdf77bcd014c025d1ed6b87662] arm64: Provide an 'upgrade to VHE' stub hypercall
> git bisect good f359182291c757cdf77bcd014c025d1ed6b87662
> # first bad commit: [0c93df9622d4d921bcd0dc83f71fed9e98f5119f] arm64: Initialise as nVHE before switching to VHE
> -------------------------------------------------------------------------------
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#7239): https://groups.io/g/kernelci-results/message/7239
> Mute This Topic: https://groups.io/mt/80821202/924702
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

