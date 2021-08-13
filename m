Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCD03EB323
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 11:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbhHMJGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 05:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239165AbhHMJGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:06:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC4F06103E;
        Fri, 13 Aug 2021 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628845545;
        bh=UjJXRNc/DQIe9/Jw4J5eMPHJMcIsyW+Z48GBMG2E3+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etzdedsZpBXHgp9QFpnZLRWf5gs7Rbzdvzij5UheUG679G/NWJqBi5q0jlVVsYTCU
         y0l7cdhhdKTQY/m+qnjEeIWuD50yiKPPPqeRLW1Remlj1AL3zruwGsgpPaw/v0127u
         CVMBXcSmu7nXkNotXDByoOhlfgS9OUq2uIDhy9ej46XeGH4TpNH530qgWQU4DjLIK+
         iAJcvYRErcQAG0HuDvnDF7MUrqODzd5Be3P0rqnmFGK6y0Rt/7LB4oc18EJj5M0Gs2
         /9w6LxaXUna0fAIbf5+ntt0JCxwwr65acDlj0WXWge3+NdSfacBTgQj6o1KGJaW0dL
         x1FVbsg5Wu8KA==
Date:   Fri, 13 Aug 2021 10:05:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
Subject: Re: [PATCH 3/5] arm64: Detect disabled HVC early
Message-ID: <20210813090539.GA7536@willie-the-truck>
References: <20210812190213.2601506-1-maz@kernel.org>
 <20210812190213.2601506-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210812190213.2601506-4-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 08:02:11PM +0100, Marc Zyngier wrote:
> Having HVC disabled from EL3 while the kernel is entered at EL2
> is a complete nightmare.
> 
> We end-up taking an UNDEF at the worse possible moment (checking
> for VHE) and even if we didn't, having KVM enabled would signify
> the premature end of the kernel.
> 
> Instead, try and detect this stupid case by issuing a HVC
> for HVC_RESET_VECTORS, which does nothing when the stubs
> are live. If we get HVC_STUB_ERR back, that's because the
> UNDEF handler has kicked in.
> 
> In this situation, close your eyes, block your nose, and gracefully
> pretend we have booted at EL1.
> 
> Reported-by: Rafał Miłecki <zajec5@gmail.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/head.S | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 9d5aa56a98cc..d6b2b05f5d3a 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -519,6 +519,28 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
>  	msr	vbar_el2, x0
>  	isb
>  
> +	// Check that HVC actually works...
> +	mov	x0, #HVC_RESET_VECTORS
> +	hvc	#0
> +
> +	mov_q	x1, HVC_STUB_ERR
> +	cmp	x0, x1
> +	b.ne	0f
> +
> +	/*
> +	 * HVC is unusable, so pretend we actually booted at EL1.
> +	 * Once we have left EL2, there will be no going back.
> +	 */

This comment got me thinking...

	.macro	host_hvc0
	mrs	xzr, actlr_el1
	.endm

then set HCR_EL2.TACR=1 while we still can and match the ISS against a
constant in the handler. Too awful?

Will
