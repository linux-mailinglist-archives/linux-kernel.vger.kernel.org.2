Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8859D358083
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhDHKYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHKYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:24:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7456115B;
        Thu,  8 Apr 2021 10:24:08 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lURpW-006HDf-1m; Thu, 08 Apr 2021 11:24:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Apr 2021 11:24:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com,
        rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com,
        tyhicks@linux.microsoft.com, kernelfans@gmail.com
Subject: Re: [PATCH v13 03/18] arm64: hyp-stub: Move el1_sync into the vectors
In-Reply-To: <20210408040537.2703241-4-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
 <20210408040537.2703241-4-pasha.tatashin@soleen.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <480272f8fb3e46d24a0ee1418fb85809@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com, kernelfans@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-08 05:05, Pavel Tatashin wrote:
> From: James Morse <james.morse@arm.com>
> 
> The hyp-stub's el1_sync code doesn't do very much, this can easily fit
> in the vectors.
> 
> With this, all of the hyp-stubs behaviour is contained in its vectors.
> This lets kexec and hibernate copy the hyp-stub when they need its
> behaviour, instead of re-implementing it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> [Fixed merging issues]

That's a pretty odd fix IMO.

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/kernel/hyp-stub.S | 59 ++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hyp-stub.S 
> b/arch/arm64/kernel/hyp-stub.S
> index ff329c5c074d..d1a73d0f74e0 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -21,6 +21,34 @@ SYM_CODE_START_LOCAL(\label)
>  	.align 7
>  	b	\label
>  SYM_CODE_END(\label)
> +.endm
> +
> +.macro hyp_stub_el1_sync
> +SYM_CODE_START_LOCAL(hyp_stub_el1_sync)
> +	.align 7
> +	cmp	x0, #HVC_SET_VECTORS
> +	b.ne	2f
> +	msr	vbar_el2, x1
> +	b	9f
> +
> +2:	cmp	x0, #HVC_SOFT_RESTART
> +	b.ne	3f
> +	mov	x0, x2
> +	mov	x2, x4
> +	mov	x4, x1
> +	mov	x1, x3
> +	br	x4				// no return
> +
> +3:	cmp	x0, #HVC_RESET_VECTORS
> +	beq	9f				// Nothing to reset!
> +
> +	/* Someone called kvm_call_hyp() against the hyp-stub... */
> +	mov_q	x0, HVC_STUB_ERR
> +	eret
> +
> +9:	mov	x0, xzr
> +	eret
> +SYM_CODE_END(hyp_stub_el1_sync)

You said you tested this on a TX2. I guess you don't care whether
it runs VHE or not...

         M.

>  .endm
> 
>  	.text
> @@ -39,7 +67,7 @@ SYM_CODE_START(__hyp_stub_vectors)
>  	invalid_vector	hyp_stub_el2h_fiq_invalid	// FIQ EL2h
>  	invalid_vector	hyp_stub_el2h_error_invalid	// Error EL2h
> 
> -	ventry	el1_sync			// Synchronous 64-bit EL1
> +	hyp_stub_el1_sync				// Synchronous 64-bit EL1
>  	invalid_vector	hyp_stub_el1_irq_invalid	// IRQ 64-bit EL1
>  	invalid_vector	hyp_stub_el1_fiq_invalid	// FIQ 64-bit EL1
>  	invalid_vector	hyp_stub_el1_error_invalid	// Error 64-bit EL1
> @@ -55,35 +83,6 @@ SYM_CODE_END(__hyp_stub_vectors)
>  # Check the __hyp_stub_vectors didn't overflow
>  .org . - (__hyp_stub_vectors_end - __hyp_stub_vectors) + SZ_2K
> 
> -
> -SYM_CODE_START_LOCAL(el1_sync)
> -	cmp	x0, #HVC_SET_VECTORS
> -	b.ne	1f
> -	msr	vbar_el2, x1
> -	b	9f
> -
> -1:	cmp	x0, #HVC_VHE_RESTART
> -	b.eq	mutate_to_vhe
> -
> -2:	cmp	x0, #HVC_SOFT_RESTART
> -	b.ne	3f
> -	mov	x0, x2
> -	mov	x2, x4
> -	mov	x4, x1
> -	mov	x1, x3
> -	br	x4				// no return
> -
> -3:	cmp	x0, #HVC_RESET_VECTORS
> -	beq	9f				// Nothing to reset!
> -
> -	/* Someone called kvm_call_hyp() against the hyp-stub... */
> -	mov_q	x0, HVC_STUB_ERR
> -	eret
> -
> -9:	mov	x0, xzr
> -	eret
> -SYM_CODE_END(el1_sync)
> -
>  // nVHE? No way! Give me the real thing!
>  SYM_CODE_START_LOCAL(mutate_to_vhe)
>  	// Sanity check: MMU *must* be off

-- 
Jazz is not dead. It just smells funny...
