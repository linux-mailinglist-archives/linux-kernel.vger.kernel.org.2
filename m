Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DB3344D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhCVRlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhCVRkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:40:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF9FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:40:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k8so18037478wrc.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+fO8q0q5J+d7OtGdbjb3cUlxaHCNevc3CNJXbnhrioc=;
        b=iqx4aHW7FNF4wyHYPNIxseKctlq/hpv2wK6Dm4zP9Tm/R4vtJuDBdYLnpsXx7vRvl5
         29DRkgQ0flZpLqhEWVQF+YDhsqwjyVHk9Kvze/AiJZjbPlu7s/j/P21LjcE8WT6+FCA/
         T6MzgN0XxviMCYwiIIlm3Xms3t6SW+FWzrAAz6WmTD9+buffDPXNPy3XgjT/T/6LNnww
         dz4ze9nLU2jgndXpnCn+7uJTD7KOzUP1Qg+DZxaOCa1GkylEgeUItff0Oip8TwrR6hix
         VKsxwdpQila6uZCigkSXOny68RWCrG0mlOb9U8kdycED+PLzsttKS1heAJ78rtygNuDT
         gOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+fO8q0q5J+d7OtGdbjb3cUlxaHCNevc3CNJXbnhrioc=;
        b=sl0L9ti4l8a3g/ZhyY9UT7WvXFM2U88wsacCsQqJteHYJzLQ55jG1HjJUr209Xzm7c
         TAKXjvngVyNStasAnGEHPlr2mzXTQPgtcMEPi9FHdRd4rvbq3dyb0UdHYc2YoD9bcDZh
         /FIu6u6UTnc0tRAlfPFGyz97p0ZRTKmiMnfOdiQ6i8yqVBDN5ilaKMq8PAM9JLbeZ17y
         ltSo3yeiiuhrAVoX7sEiQFvNQoMvym9vKZsnybXiXNe2T16kVEVtkOgOfekNWzbC2UgG
         u4NHa8Fmr+Iy9NroVeuRUSz/oMFh55+uXFk2XWg0TyEViUF5BsOZysff0aipm6KlvlQp
         MYew==
X-Gm-Message-State: AOAM533tcC8wxi21+AGS8JnZPoC6d96cwv3mPA4UYpxZPXzrzq6e9kYF
        0PpdQQghPdSahCYp2qE4Kad2Iw==
X-Google-Smtp-Source: ABdhPJwlW8Sko8nIrzPZMUnI95OPH4WRWyOCvQ0v+YlPw7MwCNpZVFd7Scuq1pqSBTH9xLCYIArLHQ==
X-Received: by 2002:adf:f0c1:: with SMTP id x1mr656464wro.7.1616434843381;
        Mon, 22 Mar 2021 10:40:43 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id b131sm105865wmb.34.2021.03.22.10.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:40:43 -0700 (PDT)
Date:   Mon, 22 Mar 2021 17:40:40 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        tabba@google.com, ardb@kernel.org, mark.rutland@arm.com,
        dbrazdil@google.com
Subject: Re: [PATCH 2/3] KVM: arm64: Generate final CTR_EL0 value when
 running in Protected mode
Message-ID: <YFjWmHerKk7+9d7N@google.com>
References: <20210322164828.800662-1-maz@kernel.org>
 <20210322164828.800662-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322164828.800662-3-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

On Monday 22 Mar 2021 at 16:48:27 (+0000), Marc Zyngier wrote:
> In protected mode, late CPUs are not allowed to boot (enforced by
> the PSCI relay). We can thus specialise the read_ctr macro to
> always return a pre-computed, sanitised value.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/assembler.h | 9 +++++++++
>  arch/arm64/kernel/image-vars.h     | 1 +
>  arch/arm64/kvm/va_layout.c         | 7 +++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index fb651c1f26e9..1a4cee7eb3c9 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -270,12 +270,21 @@ alternative_endif
>   * provide the system wide safe value from arm64_ftr_reg_ctrel0.sys_val
>   */
>  	.macro	read_ctr, reg
> +#ifndef __KVM_NVHE_HYPERVISOR__
>  alternative_if_not ARM64_MISMATCHED_CACHE_TYPE
>  	mrs	\reg, ctr_el0			// read CTR
>  	nop
>  alternative_else
>  	ldr_l	\reg, arm64_ftr_reg_ctrel0 + ARM64_FTR_SYSVAL
>  alternative_endif
> +#else
> +alternative_cb kvm_compute_final_ctr_el0
> +	movz	\reg, #0
> +	movk	\reg, #0, lsl #16
> +	movk	\reg, #0, lsl #32
> +	movk	\reg, #0, lsl #48
> +alternative_cb_end
> +#endif
>  	.endm

So, FWIW, if we wanted to make _this_ macro BUG in non-protected mode
(and drop patch 01), I think we could do something like:

alternative_cb kvm_compute_final_ctr_el0
	movz	\reg, #0
	ASM_BUG()
	nop
	nop
alternative_cb_end

and then make kvm_compute_final_ctr_el0() check that we're in protected
mode before patching. That would be marginally better as that would
cover _all_ users of read_ctr and not just __flush_dcache_area, but that
first movz is a bit yuck (but necessary to keep generate_mov_q() happy I
think?), so I'll leave the decision to you.

No objection from me for the current implementation, and if you decide to
go with it:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
