Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2EF42D3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJNHac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:30:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40552 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJNHab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:30:31 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634196506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sIUR89tYaefmCvRND4PbDArW4LJYppdekb7f0k6JcsU=;
        b=MUEE4jk0fdxxm8ZP9AOHzlhSxeLG+p/unhpxTgqYbjLS+RdKImmHtIFBKHz8xKmrSTwf/f
        AkVTX/HXOIx9auvhCZTpXk2h87dUdmvzVbtD+qop9+KHNx36uttYWDe10o1PF0qrjpj8EZ
        4GdhigL2r1IxOv4Mbb5OMHdDSn9sDnhPm5gEWq6cOugMVdys7cMWYsNby8KVfwF1yceAS/
        dSsWPyRSlgL31Bgr16qs8iG7v8EIaTCU87sHcpWjA8Mqn73nIFjMHc7JLK3yflghYK0A58
        QGxNVUvGRcmrUVPxCOTqdiuldJXHxUefLBAtTZfgaq1X+mVjyZ7k5C8mvpxQIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634196506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sIUR89tYaefmCvRND4PbDArW4LJYppdekb7f0k6JcsU=;
        b=DDoNUXGUlMzdhqxyzx/d69J0eldw9r7DvovELvU3e93zPHkEg+mcrO342iFhA7Mo4qHVkK
        9FoWR/3Cg4/f7yBw==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/11] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
In-Reply-To: <20211009053747.1694419-6-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 14 Oct 2021 09:28:25 +0200
Message-ID: <87r1co6p5y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +#include <asm/tdx.h>
> +#endif

Please get rid of the #ifdef and make sure that tdx.h can be included unconditionally.

> +	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
> +	pop %r12
> +	pop %r13
> +	pop %r14
> +	pop %r15
> +
> +	jmp 2f
> +1:

ASM supports named labels. 

> +       movq $(-EINVAL), %rax
> +2:
> +       FRAME_END
> +
> +       retq
> +SYM_FUNC_END(__tdx_hypercall)


> +/*
> + * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
> + * for TDCALL error.
> + */
> +static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
> +				 u64 r15, struct tdx_hypercall_output *out)
> +{
> +	struct tdx_hypercall_output outl;
> +	u64 err;
> +
> +	/* __tdx_hypercall() does not accept NULL output pointer */
> +	if (!out)
> +		out = &outl;
> +
> +	err = __tdx_hypercall(TDX_HYPERCALL_STANDARD, fn, r12, r13, r14,
> +			      r15, out);
> +
> +	/* Non zero return value indicates buggy TDX module, so panic */
> +	BUG_ON(err);

BUG() does not necessarily panic. If you want to panic in then invoke
the function which does that, i.e. panic().

Thanks,

        tglx
