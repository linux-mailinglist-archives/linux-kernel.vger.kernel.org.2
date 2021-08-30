Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4D3FBB35
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbhH3RqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:46:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:14016 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234054AbhH3RqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:46:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="215194221"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="215194221"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 10:45:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="645055823"
Received: from asadekar-mobl1.amr.corp.intel.com (HELO [10.209.23.128]) ([10.209.23.128])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 10:45:10 -0700
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, thiago.macieira@intel.com,
        jing2.liu@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <bb49fdc9-2228-8bd1-bcc5-7c498daf0887@intel.com>
Date:   Mon, 30 Aug 2021 10:45:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210730145957.7927-9-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 7:59 AM, Chang S. Bae wrote:
> +/**
> + * get_xstate_size - Calculate an xstate buffer size

Calculate the amount of space needed to store an xstate buffer with the
given features.

> + * @mask:	This bitmap tells which components reserved in the buffer.

The set of components for which the space is needed.

> + * Available once those arrays for the offset, size, and alignment info are
> + * set up, by setup_xstate_features().

Please just say:

	Consults values populated in setup_xstate_features().  Must be
	called after that setup.


> + * Returns:	The buffer size
> + */
> +unsigned int get_xstate_size(u64 mask)
> +{
> +	unsigned int size;
> +	int i, nr;
> +
> +	if (!mask)
> +		return 0;
> +
> +	/*
> +	 * The minimum buffer size excludes the dynamic user state. When a
> +	 * task uses the state, the buffer can grow up to the max size.
> +	 */
> +	if (mask == (xfeatures_mask_all & ~xfeatures_mask_user_dynamic))
> +		return get_xstate_config(XSTATE_MIN_SIZE);
> +	else if (mask == xfeatures_mask_all)
> +		return get_xstate_config(XSTATE_MAX_SIZE);

Is this just an optimization?  It seems redundant with everything below.
 I think that adds to the confusion.

> +	nr = fls64(mask) - 1;

"nr" is a really, really, confusing name for this.  "last_feature_nr"
might be better.  Otherwise, this might be read as "number of features".
 Comment might have helped, had there been any.

> +	if (!boot_cpu_has(X86_FEATURE_XSAVES))
> +		return xstate_offsets[nr] + xstate_sizes[nr];

Doesn't xstate_comp_offsets[] also work for non-compacted features?
setup_xstate_comp_offsets() says so and __raw_xsave_addr() depends on
that behavior.

> +	if ((xfeatures_mask_all & (BIT_ULL(nr + 1) - 1)) == mask)
> +		return xstate_comp_offsets[nr] + xstate_sizes[nr];

OK, so this is basically saying, "Is the size I'm looking for already
calculated and stored in xstate_comp_offsets[] because the mask is a
subset of xfeatures_mask_all".  Right?

I guess that work.  But, that's a *LOT* of logic to go uncommented.

> +	/*
> +	 * With the given mask, no relevant size is found so far. So,
> +	 * calculate it by summing up each state size.
> +	 */
> +	for (size = FXSAVE_SIZE + XSAVE_HDR_SIZE, i = FIRST_EXTENDED_XFEATURE; i <= nr; i++) {
> +		if (!(mask & BIT_ULL(i)))
> +			continue;
> +
> +		if (xstate_aligns[i])
> +			size = ALIGN(size, 64);
> +		size += xstate_sizes[i];
> +	}
> +	return size;
> +}

OK, so this finally reveals something important about the function.  It
is *trying* to avoid running this loop.  All of the above is really just
optimizations to try and avoid doing this loop.

That makes me wonder why you chose that particular set of optimizations.
 It also makes me wonder if they're even necessary.

So, first of all, why is this a new loop?  Can't it share code with the
XSAVE setup code?  That code also calculates the amount of space needed
for an XSAVE buffer given a mask.

Second, which of those optimizations do we *need*?  I worry that this is
trying to be way too generic and be *optimized* for being generic code
when it will never really get random masks as input.

For instance, who is going to be calling this with
mask!=xfeatures_mask_all with !boot_cpu_has(X86_FEATURE_XSAVES)?  That
seems rather improbable.
