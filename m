Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09B342CCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhJMVjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhJMVjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:39:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E68C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:37:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f120800116c2285b64386c8.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:800:116c:2285:b643:86c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 99EBF1EC04EE;
        Wed, 13 Oct 2021 23:37:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634161065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XugKOBYqyZPfh5ia8uzqR/sDJjkLgZNVUGvPqAP3mwI=;
        b=HV9I3tRRgS9KRjjQ2O5jOipcTkMy+Qyc1sIpu3QUk2fmVDeGP72PHsPuilcENxmV8xqiwN
        Kjgi+dwDgSRCVDz27xAaUR6jt5mzjlb869GOBQZeB6d7VoL8qUv1GmzA1d8NtmdmSN+iAn
        fUmFWq/XDHw1EmBrUm4jW9bNLyH49xs=
Date:   Wed, 13 Oct 2021 23:37:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YWdRqAqedkhVA2lD@zn.tnic>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87ee8o8xje.ffs@tglx>
 <YWdKlG0AzmjpjJKW@zn.tnic>
 <877deg8vn4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877deg8vn4.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:25:35PM +0200, Thomas Gleixner wrote:
> So this ends up in doing:
> 
>    use();
>    init();
> 
> Can you spot what's wrong with that?
> 
> That's a clear violation of common sense and is simply not going to
> happen. Why? If you think about deep defensive programming then use()
> will look like this:
> 
> use()
> {
>         assert(initialized);
> }
> 
> which is not something made up. It's a fundamental principle of
> programming and some languages enforce that for very good reasons.
> 
> Just because it can be done in C is no justification.

Oh, I heartily agree.
 
> What's wrong with:
> 
> x86_64_start_kernel()
> 
>     tdx_early_init();
> 
>     copy_bootdata();
>     
>     tdx_late_init();
> 
> Absolutely nothing. It's clear, simple and well defined.

I like simple more than anyone, so sure, I'd prefer that a lot more.

And so the options parsing would need to happen early using, say,
cmdline_find_option() or so, like sme_enable() does.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
