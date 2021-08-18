Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2243F0326
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhHRMD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:03:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53912 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231476AbhHRMD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:03:28 -0400
Received: from zn.tnic (p200300ec2f0cc3003e50addba46a22f0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:3e50:addb:a46a:22f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 438681EC0531;
        Wed, 18 Aug 2021 14:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629288169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ztV+9c3fFxVL/xa6z34FIPGEC2Q/xPNB41wgufE7JAg=;
        b=GEUroTRWOTVgdyjDwtFEYUSu053+kq9+zHvDoeqZblbQHcJRFK0gIDbucn3NSbQ/Egu7QS
        3j16UXN7pL/UTUOxL14cplKqux8AbQ7za9jYyoiBUXmOqBGpLmFivrxAB3VnoJyH6f8N7q
        uhdRZmyZpxwsDTRQsXGC55tHGSdOGOM=
Date:   Wed, 18 Aug 2021 14:03:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 11/26] x86/fpu/xstate: Update the XSTATE context copy
 function to support dynamic states
Message-ID: <YRz3EWQl7pHEahdF@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-12-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210730145957.7927-12-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 07:59:42AM -0700, Chang S. Bae wrote:
> ptrace() and signal return paths use XSTATE context copy functions. They
> allow callers to read (or write) XSTATE values in the target's buffer. With
> dynamic user states, a component's position in the buffer may vary and the
> init fpstate is not always large enough to cover all the states.
> 
> Adjust the helpers to find a component's offset correctly. Also, update the
> copy loop in the ptrace read path to support dynamic states.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v5:
> * Updated to ensure xstate_bv aligned with the target.
> * Rewrote the xstate copy loop, for the ptrace() read path, in an open
>   code.
> * Adjusted the changelog.
> 
> Changes from v3:
> * Cleaned up the code change with more comments.
> * Removed 'no functional change' in the changelog. (Borislav Petkov)
> 
> Changes from v2:
> * Updated the changelog with task->fpu removed. (Borislav Petkov)
> ---
>  arch/x86/kernel/fpu/xstate.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 98ab10e4da3b..3b56e7612c45 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1273,6 +1273,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
>  	zerofrom = offsetof(struct xregs_state, extended_state_area);
>  
>  	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
> +		u64 mask = BIT_ULL(i);
>  		/*
>  		 * The ptrace buffer is in non-compacted XSAVE format.
>  		 * In non-compacted format disabled features still occupy
> @@ -1280,7 +1281,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
>  		 * compacted init_fpstate. The gap tracking will zero this
>  		 * later.
>  		 */
> -		if (!(xfeatures_mask_uabi() & BIT_ULL(i)))
> +		if (!(xfeatures_mask_uabi() & mask))
>  			continue;
>  
>  		/*
> @@ -1300,10 +1301,24 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
>  			pkru.pkru = tsk->thread.pkru;
>  			membuf_write(&to, &pkru, sizeof(pkru));
>  		} else {

So this chunk, the else branch starting here is begging to be a separate
function.

> -			copy_feature(header.xfeatures & BIT_ULL(i), &to,
> -				     __raw_xsave_addr(&tsk->thread.fpu, i),
> -				     __raw_xsave_addr(NULL, i),
> -				     xstate_sizes[i]);
> +			unsigned int size = xstate_sizes[i];
> +			void *from = NULL;
> +
> +			/*
> +			 * Copy the xstate if available. Otherwise, copy the
> +			 * non-zero init states for legacy states (FP and
> +			 * SSE) or fill zeros.
> +			 */
> +
> +			if (header.xfeatures & mask)
> +				from = __raw_xsave_addr(&tsk->thread.fpu, i);
> +			else if (XFEATURE_MASK_FPSSE & mask)

The i loop variable above starts from FIRST_EXTENDED_XFEATURE - why is
this XFEATURE_MASK_FPSSE check even here?

> +				from = __raw_xsave_addr(NULL, i);
> +
> +			if (from)
> +				membuf_write(&to, from, size);
> +			else
> +				membuf_zero(&to, size);
>  		}
>  		/*
>  		 * Keep track of the last copied state in the non-compacted
> @@ -1345,6 +1360,8 @@ static int copy_uabi_to_xstate(struct fpu *fpu, const void *kbuf,
>  	if (validate_user_xstate_header(&hdr))
>  		return -EINVAL;
>  
> +	hdr.xfeatures &= fpu->state_mask;
> +

This hunk looks arbitrary here and wants to be together with the patch
which adds ->state_mask.

>  	/* Validate MXCSR when any of the related features is in use */
>  	mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
>  	if (hdr.xfeatures & mask) {
> @@ -1371,6 +1388,9 @@ static int copy_uabi_to_xstate(struct fpu *fpu, const void *kbuf,
>  		if (hdr.xfeatures & mask) {
>  			void *dst = __raw_xsave_addr(fpu, i);
>  
> +			if (!dst)
> +				continue;
> +
>  			offset = xstate_offsets[i];
>  			size = xstate_sizes[i];

I don't know where this hunk belongs to...

Maybe as a completely separate patch which fixes the case where
__raw_xsave_addr() can in the very unlikely event return NULL...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
