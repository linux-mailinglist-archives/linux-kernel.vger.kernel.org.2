Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A476031FB91
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhBSPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:01:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:44860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhBSPBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:01:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2195ACBF;
        Fri, 19 Feb 2021 15:00:52 +0000 (UTC)
Date:   Fri, 19 Feb 2021 16:00:50 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        jing2.liu@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/21] x86/fpu/xstate: Update xstate buffer address
 finder to support dynamic xstate
Message-ID: <20210219150050.GC26068@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-12-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223155717.19556-12-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 07:57:07AM -0800, Chang S. Bae wrote:
> __raw_xsave_addr() returns the requested component's pointer in an xstate
> buffer, by simply looking up the offset table. The offset used to be fixed,
> but, with dynamic user states, it becomes variable.
> 
> get_xstate_size() has a routine to find an offset at runtime. Refactor to
> use it for the address finder.
> 
> No functional change until the kernel enables dynamic user states.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kernel/fpu/xstate.c | 82 +++++++++++++++++++++++-------------
>  1 file changed, 52 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 8dfbc7d1702a..6b863b2ca405 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -133,15 +133,50 @@ static bool xfeature_is_supervisor(int xfeature_nr)
>  	return ecx & 1;
>  }
>  
> +/*
> + * Available once those arrays for the offset, size, and alignment info are set up,
> + * by setup_xstate_features().
> + */

That's kinda clear, right? Apparently, we do cache FPU attributes in
xstate.c so what is that comment actually trying to tell us? Or do you
want to add some sort of an assertion to this function in case it gets
called before setup_xstate_features()?

I think you should simply add kernel-doc style comment explaining what
the inputs are and what the function gives, which would be a lot more
useful.

> +static unsigned int __get_xstate_comp_offset(u64 mask, int feature_nr)
> +{
> +	u64 xmask = BIT_ULL(feature_nr + 1) - 1;
> +	unsigned int next_offset, offset = 0;
> +	int i;
> +
> +	if ((mask & xmask) == (xfeatures_mask_all & xmask))
> +		return xstate_comp_offsets[feature_nr];
> +
> +	/*
> +	 * Calculate the size by summing up each state together, since no known
> +	 * offset found with the xstate buffer format out of the given mask.
> +	 */
> +
> +	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
> +
> +	for (i = FIRST_EXTENDED_XFEATURE; i <= feature_nr; i++) {
> +		if (!(mask & BIT_ULL(i)))
> +			continue;
> +
> +		offset = xstate_aligns[i] ? ALIGN(next_offset, 64) : next_offset;
> +		next_offset += xstate_sizes[i];
> +	}
> +
> +	return offset;
> +}
> +
> +static unsigned int get_xstate_comp_offset(struct fpu *fpu, int feature_nr)
> +{
> +	return __get_xstate_comp_offset(fpu->state_mask, feature_nr);
> +}

Just get rid of the __ variant and have a single function with the
following signature:

	static unsigned int get_xstate_comp_offset(u64 mask, int feature_nr)


Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
