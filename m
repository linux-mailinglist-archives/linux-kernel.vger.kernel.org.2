Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD74258E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbhJGRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243081AbhJGRIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:08:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD9EC061767
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 10:06:35 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1265004099ae2673030416.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:6500:4099:ae26:7303:416])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1CF71EC04B9;
        Thu,  7 Oct 2021 19:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633626393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9ZsQxbDp8Ou6JmYRjo/eILd/d2Mdmi4Yw7to5qzMcMw=;
        b=WP4Kxx71PuFKgHY6DUyRHpSVtdCTsOI1eN89B4uwM4BqtkKr4+/8IMvY5fWPIdQR8cr38P
        aA+4BQWSAZXhcYi1OOQxpcRq55TseJ5QDEVeXnZSRzSpEpXH0VAsCCmdKos4NoImCKe3An
        fEWemb8/WkWZNmTJdFkiELG2ugXHyKw=
Date:   Thu, 7 Oct 2021 19:06:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/11] x86/traps: Add #VE support for TDX guest
Message-ID: <YV8pE+QYcS/fUe98@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:52:00PM -0700, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index d5fc2904facf..f7885c777a09 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -6,6 +6,9 @@
>  
>  #include <asm/tdx.h>
>  
> +/* TDX Module call Leaf IDs */
> +#define TDGETVEINFO			3
> +
>  /*
>   * Allocate it in the data region to avoid zeroing it during
>   * BSS initialization. It is mainly used in cc_platform_has()
> @@ -50,6 +53,36 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
>  	return out->r10;
>  }
>  
> +unsigned long tdx_get_ve_info(struct ve_info *ve)
> +{
> +	struct tdx_module_output out = {0};
> +	u64 ret;
> +
> +	/*
> +	 * NMIs and machine checks are suppressed. Before this point any
> +	 * #VE is fatal. After this point (TDGETVEINFO call), NMIs and
> +	 * additional #VEs are permitted (but it is expected not to
> +	 * happen unless kernel panics).
> +	 */
> +	ret = __tdx_module_call(TDGETVEINFO, 0, 0, 0, 0, &out);

Same question as before - why do you need to clear this @out thing above
when __tdx_module_call() will overwrite it?

What you should do instead is check that @ve pointer which you get
passed in - it might be NULL.

> +	ve->exit_reason = out.rcx;
> +	ve->exit_qual   = out.rdx;
> +	ve->gla         = out.r8;
> +	ve->gpa         = out.r9;
> +	ve->instr_len   = out.r10 & UINT_MAX;
> +	ve->instr_info  = out.r10 >> 32;
> +
> +	return ret;
> 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
