Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6992E31171E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBEXaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:30:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232570AbhBEOXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:23:11 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37A8D64FCB;
        Fri,  5 Feb 2021 14:04:31 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l81in-00CHIk-17; Fri, 05 Feb 2021 14:04:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Feb 2021 14:04:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Hector Martin 'marcan' <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jing Zhang <jingzhangos@google.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Ajay Patil <pajay@qti.qualcomm.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v6 05/21] arm64: Initialise as nVHE before switching to
 VHE
In-Reply-To: <1dbffcd4-5b20-404c-94af-c985a96785e2@marcan.st>
References: <20210201115637.3123740-1-maz@kernel.org>
 <20210201115637.3123740-6-maz@kernel.org>
 <1dbffcd4-5b20-404c-94af-c985a96785e2@marcan.st>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <2f93bbfa7159f135252c6df870a652cc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: marcan@marcan.st, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, mark.rutland@arm.com, jingzhangos@google.com, psodagud@codeaurora.org, sramana@codeaurora.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, alexandru.elisei@arm.com, james.morse@arm.com, pajay@qti.qualcomm.com, kernel-team@android.com, dbrazdil@google.com, will@kernel.org, ardb@kernel.org, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

On 2021-02-05 12:01, Hector Martin 'marcan' wrote:
> On 01/02/2021 20.56, Marc Zyngier wrote:
>> As we are aiming to be able to control whether we enable VHE or
>> not, let's always drop down to EL1 first, and only then upgrade
>> to VHE if at all possible.
>> 
>> This means that if the kernel is booted at EL2, we always start
>> with a nVHE init, drop to EL1 to initialise the the kernel, and
>> only then upgrade the kernel EL to EL2 if possible (the process
>> is obviously shortened for secondary CPUs).
> 
> Unfortunately, this is going to break on Apple SoCs, where it turns
> out HCR_EL2.E2H is hard-wired to 1 - there is no nVHE mode. :(

#facepalm

Thanks for the heads up. That's a blatant violation of the architecture,
as the only fixed value allowed is 0. I guess it was tempting for them
to ignore about half of the architecture... Oh well.

Here's a terrible hack on top of this series. It really doesn't
play nicely with the rest of the override stuff, but that's the
least of your worries at this stage. I've boot-tested it in a model
with E2H artificially forced, and nothing caught fire. YMMV.

It also means that if/when we merge the support for this CPU,
CONFIG_ARM64_VHE will becomes more or less mandatory...

Please let me know if this helps.

Thanks,

         M.

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2e116ef255e1..bce66d6bda74 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -477,14 +477,13 @@ EXPORT_SYMBOL(kimage_vaddr)
   * booted in EL1 or EL2 respectively.
   */
  SYM_FUNC_START(init_kernel_el)
-	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
-	msr	sctlr_el1, x0
-
  	mrs	x0, CurrentEL
  	cmp	x0, #CurrentEL_EL2
  	b.eq	init_el2

  SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr	sctlr_el1, x0
  	isb
  	mov_q	x0, INIT_PSTATE_EL1
  	msr	spsr_el1, x0
@@ -504,6 +503,34 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
  	msr	vbar_el2, x0
  	isb

+	/*
+	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1,
+	 * making it impossible to start in nVHE mode. Is that
+	 * compliant with the architecture? Absolutely not!
+	 */
+	mrs	x0, hcr_el2
+	and	x0, x0, #HCR_E2H
+	cbz	x0, 1f
+
+	/* Switching to VHE requires a sane SCTLR_EL1 as a start */
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr_s	SYS_SCTLR_EL12, x0
+
+	/*
+	 * Force an eret into a helper "function", and let it return
+	 * to our original caller... This makes sure that we have
+	 * initialised the basic PSTATE state.
+	 */
+	mov	x0, #INIT_PSTATE_EL2
+	msr	spsr_el1, x0
+	adr_l	x0, stick_to_vhe
+	msr	elr_el1, x0
+	eret
+
+1:
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr	sctlr_el1, x0
+
  	msr	elr_el2, lr
  	mov	w0, #BOOT_CPU_MODE_EL2
  	eret
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 3e08dcc924b5..109a555a1068 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -27,12 +27,12 @@ SYM_CODE_START(__hyp_stub_vectors)
  	ventry	el2_fiq_invalid			// FIQ EL2t
  	ventry	el2_error_invalid		// Error EL2t

-	ventry	el2_sync_invalid		// Synchronous EL2h
+	ventry	elx_sync			// Synchronous EL2h
  	ventry	el2_irq_invalid			// IRQ EL2h
  	ventry	el2_fiq_invalid			// FIQ EL2h
  	ventry	el2_error_invalid		// Error EL2h

-	ventry	el1_sync			// Synchronous 64-bit EL1
+	ventry	elx_sync			// Synchronous 64-bit EL1
  	ventry	el1_irq_invalid			// IRQ 64-bit EL1
  	ventry	el1_fiq_invalid			// FIQ 64-bit EL1
  	ventry	el1_error_invalid		// Error 64-bit EL1
@@ -45,7 +45,7 @@ SYM_CODE_END(__hyp_stub_vectors)

  	.align 11

-SYM_CODE_START_LOCAL(el1_sync)
+SYM_CODE_START_LOCAL(elx_sync)
  	cmp	x0, #HVC_SET_VECTORS
  	b.ne	1f
  	msr	vbar_el2, x1
@@ -71,7 +71,7 @@ SYM_CODE_START_LOCAL(el1_sync)

  9:	mov	x0, xzr
  	eret
-SYM_CODE_END(el1_sync)
+SYM_CODE_END(elx_sync)

  // nVHE? No way! Give me the real thing!
  SYM_CODE_START_LOCAL(mutate_to_vhe)
@@ -227,3 +227,24 @@ SYM_FUNC_START(switch_to_vhe)
  #endif
  	ret
  SYM_FUNC_END(switch_to_vhe)
+
+SYM_FUNC_START(stick_to_vhe)
+	/*
+	 * Make sure the switch to VHE cannot fail, by overriding the
+	 * override. This is hilarious.
+	 */
+	adr_l	x1, id_aa64mmfr1_override
+	add	x1, x1, #FTR_OVR_MASK_OFFSET
+	dc 	civac, x1
+	dsb	sy
+	isb
+	ldr	x0, [x1]
+	bic	x0, x0, #(0xf << ID_AA64MMFR1_VHE_SHIFT)
+	str	x0, [x1]
+
+	mov	x0, #HVC_VHE_RESTART
+	hvc	#0
+	mov	x0, #BOOT_CPU_MODE_EL2
+	ret
+SYM_FUNC_END(stick_to_vhe)
+

-- 
Jazz is not dead. It just smells funny...
