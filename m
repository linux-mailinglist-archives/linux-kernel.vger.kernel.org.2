Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62153F02C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhHRLd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:33:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49882 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233798AbhHRLd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:33:27 -0400
Received: from zn.tnic (p200300ec2f0cc300f5e19ee5ff269b4b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:f5e1:9ee5:ff26:9b4b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C99E01EC0236;
        Wed, 18 Aug 2021 13:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629286367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jjBnHr/ph8EqG7il00Xg4FP/yeMl6hat1Mzp9ji+YZg=;
        b=gAZumXR8loOLvjhvB47Anqjg1etnvbT5wxn8jJDD4dodQ+9IKHZGfH6YHCJMPyHlge9J7Q
        uZ7JFFNE24aeKTOBcDKNdWpyCVJO6pGweSW6aVtorRwuKcSFUq/Sn/IDnjI0OrjgfD8al2
        0t0ZV9cuV9NJk86TewsizcEPD8jTwpc=
Date:   Wed, 18 Aug 2021 13:33:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 10/26] x86/fpu/xstate: Update the XSTATE buffer
 address finder to support dynamic states
Message-ID: <YRzwB+fAEotDf4d7@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-11-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210730145957.7927-11-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 07:59:41AM -0700, Chang S. Bae wrote:
> __raw_xsave_addr() returns the requested component's pointer in an XSTATE
> buffer, by simply looking up the offset table. The offset used to be fixed,
> but, with dynamic user states, it becomes variable.
> 
> get_xstate_size() has a routine to find an offset at runtime. Refactor to
> use it for the address finder.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v5:
> * Updated for future proofed __raw_xsave_addr().
> 
> Changes from v3:
> * Added the function description in the kernel-doc style. (Borislav Petkov)
> * Removed 'no functional change' in the changelog. (Borislav Petkov)
> ---
>  arch/x86/kernel/fpu/xstate.c | 78 ++++++++++++++++++++++++------------
>  1 file changed, 53 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 26f6d5e0f1ed..98ab10e4da3b 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -182,6 +182,38 @@ static bool xfeature_is_supervisor(int xfeature_nr)
>  	return ecx & 1;
>  }
>  
> +/**
> + * get_xstate_comp_offset - Find the feature's offset in the compacted
> + *			    format.
> + * @mask:	This bitmap tells which components reserved in the format.

There's that "reserved" confusion thing. Rewrite pls.

> + * @feature_nr:	The feature number
> + *
> + * Returns:	The offset value
> + */
> +static unsigned int get_xstate_comp_offset(u64 mask, int feature_nr)
> +{
> +	u64 xmask = BIT_ULL(feature_nr + 1) - 1;
> +	unsigned int next_offset, offset = 0;
> +	int i;
> +
> +	if ((xfeatures_mask_all & xmask) == (mask & xmask))
> +		return xstate_comp_offsets[feature_nr];
> +
> +	/*
> +	 * With the given mask, no relevant size is found. Calculate it by
> +	 * summing up each state size.
> +	 */
> +	for (next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE, i = FIRST_EXTENDED_XFEATURE;
> +	     i <= feature_nr; i++) {
> +		if (!(mask & BIT_ULL(i)))
> +			continue;
> +
> +		offset = xstate_aligns[i] ? ALIGN(next_offset, 64) : next_offset;
> +		next_offset += xstate_sizes[i];

Why is this more complex than it has to be?

IOW, why can't you simply do:

        offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
        for (i = FIRST_EXTENDED_XFEATURE; i <= feature_nr; i++) {
                if (!(mask & BIT_ULL(i)))
                        continue;

                if (xstate_aligns[i])
                        offset = ALIGN(offset, 64);

                offset += xstate_sizes[i];
        }
        return offset;

like it was before?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
