Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067AC42CCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhJMV1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:27:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJMV1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:27:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634160335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LRIzbarnzCh1glYU/KEKbTjAQBKhwux1yqJ8H2C3Tc=;
        b=y3jU9dCDH2kDeD/hhXut5Mr6nkHceg0OAI6X7SvLb1DuBmpw2A4NMHyEHWVjrJjlg4Eil/
        5uSsoaXILX0q7xcKMBVDQTCP47dimgQxuwxSExU1YSORh4QkqtZ1sMTrA1VT/jZfxZrpw2
        8+mx8CYG6XLbioQS7ScNXcIFAxuJCOpm6TcfigLQiGuaTcO9yusOPGo5opYEyIFb/b//RZ
        9BvivgoDp8MYvcYLgniL0kfYfyl+Q38gMPsPxDS3F9iKOdUcA0hExEG2vLNWQcsT8bvQ4G
        MY2QN+TIENKG0RuV0kBA1NHQmimDMB6ek8CYI1MlYYWeymimaMB9C8rNB+QBuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634160335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LRIzbarnzCh1glYU/KEKbTjAQBKhwux1yqJ8H2C3Tc=;
        b=vBU1qvp+sthyAdaGXaL96rNr/Y+8zjXEyirDkLtFBUqu5X55jmfswOgs3fmpN3t1SceGw1
        AM9Cr7upYLgIfoDg==
To:     Borislav Petkov <bp@alien8.de>
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
In-Reply-To: <YWdKlG0AzmjpjJKW@zn.tnic>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87ee8o8xje.ffs@tglx> <YWdKlG0AzmjpjJKW@zn.tnic>
Date:   Wed, 13 Oct 2021 23:25:35 +0200
Message-ID: <877deg8vn4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13 2021 at 23:07, Borislav Petkov wrote:
> On Wed, Oct 13, 2021 at 10:44:37PM +0200, Thomas Gleixner wrote:
>> No. This is tasteless garbage, really.
>> 
>> tdx_early_init() is invoked from x86_64_start_kernel() very early in the
>> boot process __before__ is_tdx_guest() is invoked.
>> 
>> So why on earth is it requried to keep those conditionals and cpuid()
>> muck around after init?
>
> Yah, reportedly, they wanna parse cmdline options so it has to be after
> copy_bootdata() but copy_bootdata() has a cc_platform_has() call which
> ends up in is_tdx_guest() on Intel and there you have the catch 22
> because CPUID hasn't happened yet in tdx_early_init().

Seriously?

So this ends up in doing:

   use();
   init();

Can you spot what's wrong with that?

That's a clear violation of common sense and is simply not going to
happen. Why? If you think about deep defensive programming then use()
will look like this:

use()
{
        assert(initialized);
}

which is not something made up. It's a fundamental principle of
programming and some languages enforce that for very good reasons.

Just because it can be done in C is no justification.

What's wrong with:

x86_64_start_kernel()

    tdx_early_init();

    copy_bootdata();
    
    tdx_late_init();

Absolutely nothing. It's clear, simple and well defined.

Thanks,

        tglx
