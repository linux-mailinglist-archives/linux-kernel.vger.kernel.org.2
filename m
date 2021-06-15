Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1AE3A7CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhFOLLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:11:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52252 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhFOLKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:10:18 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B23ED219CF;
        Tue, 15 Jun 2021 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623755293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GAlT148YflzoMeSFRcbzFIToOG75iQik6u/49KKSY+A=;
        b=ap1OenAIGTGVpOUxg+WIF5ooePgNmq92OwlpIsZlrtzj4VojwfWdi8agQ/BCIlpdXWX8AY
        j4xGhWVkl4jAIhrcd7StShTXyXGHnLzeMTsTmP7A9tbZnTX+0nCKEthknpQ7geKMHuFRk2
        0ExBSuy/0j+mnQYPqJLbqx3XL7Juz6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623755293;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GAlT148YflzoMeSFRcbzFIToOG75iQik6u/49KKSY+A=;
        b=AVUiHNpBrPk+DM2OQqM08IW/3GspYMMs8aVc15TI1cJ/YB6tcxx8sB2D7dUJ8TOZSoyyju
        hBHMjMWkZOpsWJCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 9E775118DD;
        Tue, 15 Jun 2021 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623755293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GAlT148YflzoMeSFRcbzFIToOG75iQik6u/49KKSY+A=;
        b=ap1OenAIGTGVpOUxg+WIF5ooePgNmq92OwlpIsZlrtzj4VojwfWdi8agQ/BCIlpdXWX8AY
        j4xGhWVkl4jAIhrcd7StShTXyXGHnLzeMTsTmP7A9tbZnTX+0nCKEthknpQ7geKMHuFRk2
        0ExBSuy/0j+mnQYPqJLbqx3XL7Juz6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623755293;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GAlT148YflzoMeSFRcbzFIToOG75iQik6u/49KKSY+A=;
        b=AVUiHNpBrPk+DM2OQqM08IW/3GspYMMs8aVc15TI1cJ/YB6tcxx8sB2D7dUJ8TOZSoyyju
        hBHMjMWkZOpsWJCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id SedoJR2KyGA3OAAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 15 Jun 2021 11:08:13 +0000
Date:   Tue, 15 Jun 2021 13:07:55 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V2 02/52] x86/fpu: Fix copy_xstate_to_kernel() gap
 handling
Message-ID: <YMiKC09GUaG5vZta@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155353.825709513@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155353.825709513@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:10PM +0200, Thomas Gleixner wrote:
>   2) Keeping track of the last copied state in the target buffer and
>      explicitely zero it when there is a feature or alignment gap.

WARNING: 'explicitely' may be misspelled - perhaps 'explicitly'?
#93: 
     explicitely zero it when there is a feature or alignment gap.
     ^^^^^^^^^^^

> -static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
> +static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
> +			 void *init_xstate, unsigned int size)
>  {
> -	if (*last >= offset)
> -		return;
> -	membuf_write(to, (void *)&init_fpstate.xsave + *last, offset - *last);
> -	*last = offset;
> -}
> -
> -static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
> -		      unsigned size, void *from)
> -{
> -	fill_gap(to, last, offset);
> -	membuf_write(to, from, size);
> -	*last = offset + size;
> +	membuf_write(to, from_xstate ? xstate : init_xstate, size);

I wonder - since we're making this code more robust anyway - whether
we should add an additional assertion here to check whether that
membuf.left is < size and warn.

It is cheap and having an additional check here would probably catch
some ptrace insanity or so, who knows...

> @@ -1120,41 +1110,68 @@ void copy_xstate_to_kernel(struct membuf
>  	header.xfeatures = xsave->header.xfeatures;
>  	header.xfeatures &= xfeatures_mask_user();
>  
> -	if (header.xfeatures & XFEATURE_MASK_FP)
> -		copy_part(&to, &last, 0, off_mxcsr, &xsave->i387);
> -	if (header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM))
> -		copy_part(&to, &last, off_mxcsr,
> -			  MXCSR_AND_FLAGS_SIZE, &xsave->i387.mxcsr);
> -	if (header.xfeatures & XFEATURE_MASK_FP)
> -		copy_part(&to, &last, offsetof(struct fxregs_state, st_space),
> -			  128, &xsave->i387.st_space);
> -	if (header.xfeatures & XFEATURE_MASK_SSE)
> -		copy_part(&to, &last, xstate_offsets[XFEATURE_SSE],
> -			  256, &xsave->i387.xmm_space);
> -	/*
> -	 * Fill xsave->i387.sw_reserved value for ptrace frame:
> -	 */
> -	copy_part(&to, &last, offsetof(struct fxregs_state, sw_reserved),
> -		  48, xstate_fx_sw_bytes);
> -	/*
> -	 * Copy xregs_state->header:
> -	 */
> -	copy_part(&to, &last, offsetof(struct xregs_state, header),
> -		  sizeof(header), &header);
> +	/* Copy FP state up to MXCSR */
> +	copy_feature(header.xfeatures & XFEATURE_MASK_FP, &to, &xsave->i387,
> +		     &xinit->i387, off_mxcsr);
> +
> +	/* Copy MXCSR when SSE or YMM are set in the feature mask */
> +	copy_feature(header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM),
> +		     &to, &xsave->i387.mxcsr, &xinit->i387.mxcsr,
> +		     MXCSR_AND_FLAGS_SIZE);

Yah, this copies a whopping 8 bytes:

        u32                     mxcsr;          /* MXCSR Register State */
        u32                     mxcsr_mask;     /* MXCSR Mask           */

I know, I know, it was like that before but dammit, that's obscure.

> +	/* Copy the remaining FP state */
> +	copy_feature(header.xfeatures & XFEATURE_MASK_FP,
> +		     &to, &xsave->i387.st_space, &xinit->i387.st_space,
> +		     sizeof(xsave->i387.st_space));
> +
> +	/* Copy the SSE state - shared with YMM */
> +	copy_feature(header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM),
> +		     &to, &xsave->i387.xmm_space, &xinit->i387.xmm_space,
> +		     16 * 16);

Why not

	sizeof(xsave->i387.xmm_space)

?

> +
> +	/* Zero the padding area */
> +	membuf_zero(&to, sizeof(xsave->i387.padding));
> +
> +	/* Copy xsave->i387.sw_reserved */
> +	membuf_write(&to, xstate_fx_sw_bytes, sizeof(xsave->i387.sw_reserved));
> +
> +	/* Copy the user space relevant state of @xsave->header */
> +	membuf_write(&to, &header, sizeof(header));
> +
> +	zerofrom = offsetof(struct xregs_state, extended_state_area);
>  
>  	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
>  		/*
> -		 * Copy only in-use xstates:
> +		 * The ptrace buffer is XSAVE format which is non-compacted.

... "is in XSAVE, non-compacted format."

> +		 * In non-compacted format disabled features still occupy
		     ^			  ^
		    the			  ,

> +		 * state space, but there is no state to copy from in the
> +		 * compacted init_fpstate. The gap tracking will zero this
> +		 * later.
> +		 */
> +		if (!(xfeatures_mask_user() & BIT_ULL(i)))
> +			continue;
> +
> +		/*
> +		 * If there was a feature or alignment gap, zero the space
> +		 * in the destination buffer.
>  		 */
> -		if ((header.xfeatures >> i) & 1) {
> -			void *src = __raw_xsave_addr(xsave, i);
> +		if (zerofrom < xstate_offsets[i])
> +			membuf_zero(&to, xstate_offsets[i] - zerofrom);
>  
> -			copy_part(&to, &last, xstate_offsets[i],
> -				  xstate_sizes[i], src);
> -		}
> +		copy_feature(header.xfeatures & BIT_ULL(i), &to,
> +			     __raw_xsave_addr(xsave, i),
> +			     __raw_xsave_addr(xinit, i),
> +			     xstate_sizes[i]);
>  
> +		/*
> +		 * Keep track of the last copied state in the non-compacted
> +		 * target buffer for gap zeroing.
> +		 */
> +		zerofrom = xstate_offsets[i] + xstate_sizes[i];
>  	}
> -	fill_gap(&to, &last, size);
> +
> +	if (to.left)
> +		membuf_zero(&to, to.left);
>  }

Yah, I can certainly follow what's going on here but, mapping that
compacted buffer to the uncompacted, XSAVE one is certainly making my
head spin.

Yah, FPU state handling is nasty.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
