Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653953BA3BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhGBRtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:49:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:10794 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhGBRtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:49:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10033"; a="269895263"
X-IronPort-AV: E=Sophos;i="5.83,319,1616482800"; 
   d="scan'208";a="269895263"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 10:46:42 -0700
X-IronPort-AV: E=Sophos;i="5.83,319,1616482800"; 
   d="scan'208";a="409569809"
Received: from tkhalx-mobl.amr.corp.intel.com (HELO [10.252.132.13]) ([10.252.132.13])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 10:46:41 -0700
Subject: Re: [PATCH v6-fix 06/26] x86/fpu/xstate: Calculate and remember
 dynamic XSTATE buffer sizes
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, jing2.liu@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org
References: <7B6BF36A-E1C5-4D7C-96EC-2036AE27414B@intel.com>
 <20210702151726.27293-1-chang.seok.bae@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <bcb5068b-8a33-c803-aa93-fddc005d9a19@intel.com>
Date:   Fri, 2 Jul 2021 10:46:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210702151726.27293-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/21 8:17 AM, Chang S. Bae wrote:
> The XSTATE per-task buffer is currently embedded into struct fpu with
> static size. To accommodate dynamic user XSTATEs, record the maximum and
> minimum buffer sizes.
> 
> Rename the size calculation function. It calculates the maximum XSTATE size
> and sanity checks it with CPUID. It also calculates the static embedded
> buffer size by excluding the dynamic user states from the maximum size.

This is missing a few things for me.  I'd probably start with this instead:

	The CPUID instruction separately enumerates sizes and alignments
	of individual xfeatures.  It independently enumerates the
	required size of an entire XSAVE buffer to store all enabled
	features.

	calculate_xstate_sizes() currently uses the individual feature
	size/alignment enumeration to independently recalculate the
	required XSAVE buffer size.  This is compared against the CPUID-
	provided value.

	Dynamic xstates introduce another wrinkle: with them, the
	'struct fpu' buffer no longer contains all of the enabled state
	components.  This means that there are now two separate sizes:

	1. The CPUID-enumerated all-feature "maxmimum" size
	2. The size of the 'struct fpu' inline buffer

	... then go on to explain how you added the #2 calculations

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index e03853bb2603..75969f1ef4b3 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -590,24 +590,36 @@ static void check_xstate_against_struct(int nr)
>  	}
>  }
>  
> -/*
> - * This essentially double-checks what the cpu told us about
> - * how large the XSAVE buffer needs to be.  We are recalculating
> - * it to be safe.
> +/**
> + * calculate_xstate_sizes() - Calculate the xstate per-task buffer sizes.
> + *
> + * Record the minimum and double-check the maximum against what the CPU
> + * told.
>   *
>   * Independent XSAVE features allocate their own buffers and are not
>   * covered by these checks. Only the size of the buffer for task->fpu
>   * is checked here.
> + *
> + * Dynamic user states are stored in this per-task buffer. They account
> + * for the delta between the maximum and the minimum.
> + *
> + * Return: nothing.
>   */

I'm not sure "Return: nothing" is worth saying.  The "void" kinda gives
it away.

> -static void do_extra_xstate_size_checks(void)
> +static void calculate_xstate_sizes(void)
>  {
> -	int paranoid_xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
> -	int i;
> +	int xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
> +	int xstate_size_no_dynamic, i;

Both the changelog and the function description talk about the maximum
and minimum sizes of the xsave buffer.  Unfortunately, that doesn't seem
to be reflected in the naming at all.

> +	xstate_size_no_dynamic = xstate_size;
>  
>  	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
> +		bool user_dynamic;
> +
>  		if (!xfeature_enabled(i))
>  			continue;
>  
> +		user_dynamic = (xfeatures_mask_user_dynamic & BIT_ULL(i)) ? true : false;
> +
>  		check_xstate_against_struct(i);
>  		/*
>  		 * Supervisor state components can be managed only by
> @@ -617,27 +629,39 @@ static void do_extra_xstate_size_checks(void)
>  			XSTATE_WARN_ON(xfeature_is_supervisor(i));
>  
>  		/* Align from the end of the previous feature */
> -		if (xfeature_is_aligned(i))
> -			paranoid_xstate_size = ALIGN(paranoid_xstate_size, 64);
> +		if (xfeature_is_aligned(i)) {
> +			xstate_size = ALIGN(xstate_size, 64);
> +			if (!user_dynamic)
> +				xstate_size_no_dynamic = ALIGN(xstate_size_no_dynamic, 64);
> +		}
>  		/*
>  		 * The offset of a given state in the non-compacted
>  		 * format is given to us in a CPUID leaf.  We check
>  		 * them for being ordered (increasing offsets) in
>  		 * setup_xstate_features(). XSAVES uses compacted format.
>  		 */
> -		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
> -			paranoid_xstate_size = xfeature_uncompacted_offset(i);
> +		if (!cpu_feature_enabled(X86_FEATURE_XSAVES)) {
> +			xstate_size = xfeature_uncompacted_offset(i);
> +			if (!user_dynamic)
> +				xstate_size_no_dynamic = xfeature_uncompacted_offset(i);
> +		}
>  		/*
>  		 * The compacted-format offset always depends on where
>  		 * the previous state ended.
>  		 */
> -		paranoid_xstate_size += xfeature_size(i);
> +		xstate_size += xfeature_size(i);
> +		if (!user_dynamic)
> +			xstate_size_no_dynamic += xfeature_size(i);
>  	}

I'm not a super big fan of how that loop turned out.  It's trying to
keep two variables in parallel.

How about making calculate_xstate_sizes() *return* the xstate size, and
pass 'user_dynamic' to it:

	/* 'false' to exclude dynamic states: */
	xstate_size_min = calculate_xstate_sizes(false);
	/* 'true' to include dynamic states: */
	xstate_size_max = calculate_xstate_sizes(true);

... then go on to do the checks.

>  	/*
>  	 * The size accounts for all the possible states reserved in the
>  	 * per-task buffer.  Check against the maximum size.
>  	 */
> -	XSTATE_WARN_ON(paranoid_xstate_size != get_xstate_config(XSTATE_MAX_SIZE));
> +	XSTATE_WARN_ON(xstate_size != get_xstate_config(XSTATE_MAX_SIZE));
> +
> +	/* Record the one without dynamic states as the minimum. */
> +	set_xstate_config(XSTATE_MIN_SIZE, xstate_size_no_dynamic);
>  }
>  
>  
> @@ -738,14 +762,11 @@ static int __init init_xstate_size(void)
>  	 */
>  	set_xstate_config(XSTATE_MAX_SIZE, possible_xstate_size);
>  
> -	/* Perform an extra check for the maximum size. */
> -	do_extra_xstate_size_checks();
> -
>  	/*
> -	 * Set the minimum to be the same as the maximum. The dynamic
> -	 * user states are not supported yet.
> +	 * Calculate and double-check the maximum size. Calculate and record
> +	 * the minimum size.
>  	 */
> -	set_xstate_config(XSTATE_MIN_SIZE, possible_xstate_size);
> +	calculate_xstate_sizes();
>  
>  	/* Ensure the minimum size fits in the statically-allocated buffer: */
>  	if (!is_supported_xstate_size(get_xstate_config(XSTATE_MIN_SIZE)))
> 

