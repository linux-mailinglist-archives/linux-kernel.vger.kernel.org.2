Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE2F3EA898
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 18:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhHLQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhHLQgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:36:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C423C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 09:36:21 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f8300207fa77f9285c0b6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8300:207f:a77f:9285:c0b6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B7AE1EC01A2;
        Thu, 12 Aug 2021 18:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628786175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iXg+2fsq+rRbwFOnhH5hGZGFEHEg8DqH78cmJkdjAhk=;
        b=LeQuzGk4nhB0GoobNN0egdKPlwPm5OKTc5g9r80Dl5WZga8bkNOoLcNrlchQghK4cNWukx
        smVngCEVNEDRo4oV/aLLzMtzSQmohxHT5xkIWlvqUW1XQuMxbPTopoP2PzDqhUccquJkPE
        QJ5Xl/8EkOSg8JWagCypgyIn4uqGHis=
Date:   Thu, 12 Aug 2021 18:36:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 06/26] x86/fpu/xstate: Calculate and remember dynamic
 XSTATE buffer sizes
Message-ID: <YRVOJgss1VhVkycu@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-7-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210730145957.7927-7-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 07:59:37AM -0700, Chang S. Bae wrote:
> The CPUID instruction separately enumerates sizes and alignments of
> individual xfeatures. It independently enumerates the required size of an
> entire XSAVE buffer to store all enabled features.
> 
> calculate_xstate_sizes() currently uses the individual feature
> size/alignment enumeration to independently recalculate the required XSAVE
> buffer size. This is compared against the CPUID-provided value.
> 
> Extend the function to accept an option to exclude dynamic states. With
> that, calculate the maximum size that contains all the enabled states, and
> the minimum size that fits in the statically-allocated buffer by excluding
> dynamic states.

This explains *what* this patch does but not *why*. *What* I can more or
less see but for *why* I'd need my crystal ball...

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 12caf1a56ce0..cd709408efb5 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -591,24 +591,28 @@ static void check_xstate_against_struct(int nr)
>  	}
>  }
>  
> -/*
> - * This essentially double-checks what the cpu told us about
> - * how large the XSAVE buffer needs to be.  We are recalculating
> - * it to be safe.

Why are you removing that comment? Are we not recalculating anymore?

> +/**
> + * calculate_xstate_size - Calculate the xstate per-task buffer size.
> + *
> + * Independent XSAVE features allocate their own buffers and are always
> + * excluded. Only the size of the buffer for task->fpu is checked here.
>   *
> - * Independent XSAVE features allocate their own buffers and are not
> - * covered by these checks. Only the size of the buffer for task->fpu
> - * is checked here.
> + * @include_dynamic_states:	A knob to include dynamic states or not.
> + *
> + * Return:			The calculated xstate size.
>   */
> -static void do_extra_xstate_size_checks(void)
> +static unsigned int calculate_xstate_size(bool include_dynamic_states)
>  {
> -	int paranoid_xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
> +	unsigned int xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
>  	int i;
>  
>  	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
>  		if (!xfeature_enabled(i))
>  			continue;
>  
> +		if (!include_dynamic_states && (xfeatures_mask_user_dynamic & BIT_ULL(i)))

The order should be flipped: if (dynamic_state and !include_dynamic_states)

> +			continue;
> +
>  		check_xstate_against_struct(i);
>  		/*
>  		 * Supervisor state components can be managed only by
> @@ -619,7 +623,7 @@ static void do_extra_xstate_size_checks(void)
>  
>  		/* Align from the end of the previous feature */
>  		if (xfeature_is_aligned(i))
> -			paranoid_xstate_size = ALIGN(paranoid_xstate_size, 64);
> +			xstate_size = ALIGN(xstate_size, 64);
>  		/*
>  		 * The offset of a given state in the non-compacted
>  		 * format is given to us in a CPUID leaf.  We check
> @@ -627,18 +631,15 @@ static void do_extra_xstate_size_checks(void)
>  		 * setup_xstate_features(). XSAVES uses compacted format.
>  		 */
>  		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
> -			paranoid_xstate_size = xfeature_uncompacted_offset(i);
> +			xstate_size = xfeature_uncompacted_offset(i);
>  		/*
>  		 * The compacted-format offset always depends on where
>  		 * the previous state ended.
>  		 */
> -		paranoid_xstate_size += xfeature_size(i);
> +		xstate_size += xfeature_size(i);
>  	}
> -	/*
> -	 * The size accounts for all the possible states reserved in the
> -	 * per-task buffer.  Check against the maximum size.
> -	 */
> -	XSTATE_WARN_ON(paranoid_xstate_size != get_xstate_config(XSTATE_MAX_SIZE));
> +
> +	return xstate_size;
>  }
>  
>  

<--- You can remove one of the newlines here, while at it.

> @@ -723,7 +724,7 @@ static bool is_supported_xstate_size(unsigned int test_xstate_size)
>  static int __init init_xstate_size(void)
>  {
>  	/* Recompute the context size for enabled features: */
> -	unsigned int possible_xstate_size;
> +	unsigned int possible_xstate_size, xstate_size;
>  	unsigned int xsave_size;
>  
>  	xsave_size = get_xsave_size();
> @@ -734,23 +735,23 @@ static int __init init_xstate_size(void)
>  		possible_xstate_size = xsave_size;
>  
>  	/*
> -	 * The size accounts for all the possible states reserved in the
> -	 * per-task buffer.  Set the maximum with this value.
> +	 * Calculate xstate size for all the possible states by setting
> +	 * 'true' to include dynamic states.

"Calculate the maximum xstate size, including the dynamic states."

> Cross-check with the CPUID-
> +	 * provided size and record it.
>  	 */
> +	xstate_size = calculate_xstate_size(true);
> +	XSTATE_WARN_ON(possible_xstate_size != xstate_size);
>  	set_xstate_config(XSTATE_MAX_SIZE, possible_xstate_size);
>  
> -	/* Perform an extra check for the maximum size. */
> -	do_extra_xstate_size_checks();
> -
>  	/*
> -	 * Set the minimum to be the same as the maximum. The dynamic
> -	 * user states are not supported yet.
> +	 * Calculate the xstate size without dynamic states by setting
> +	 * 'false' to exclude dynamic states.

"Calculate the minimum xstate size, i.e., excluding the dynamic xstates."

> Ensure the size fits in
> +	 * the statically-allocated buffer and record it.
>  	 */
> -	set_xstate_config(XSTATE_MIN_SIZE, possible_xstate_size);
> -
> -	/* Ensure the minimum size fits in the statically-allocated buffer: */
> -	if (!is_supported_xstate_size(get_xstate_config(XSTATE_MIN_SIZE)))
> +	xstate_size = calculate_xstate_size(false);
> +	if (!is_supported_xstate_size(xstate_size))
>  		return -EINVAL;

<---- newline here.

> +	set_xstate_config(XSTATE_MIN_SIZE, xstate_size);
>  
>  	/*
>  	 * User space is always in standard format.
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
