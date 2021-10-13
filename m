Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D559742CEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhJMXE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:04:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38126 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhJMXEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:04:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634166140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jjiS7Vby7TYfAacFBJrjHOX1La5xXqOyExdDSyCN4hI=;
        b=h6Fm4u6Koc6zUrYwLoJ9I8E+9KlfY9Ne9UoyEOHKk3V6kHZOP114HMTeBHur1z8g1GF0FJ
        d8PwSNEa5fUft7AfXPQEjLLwLdnh2VXaat6dsvdiO9/4z3kIJlDay9/vIsNHUNOZurK2+v
        7SGHs/dfdVYcq/m7brdlBTZkPy0W0dGhoHHDxNtbpTpppTE3+fQjniyZfih1SfDn7RcStx
        zaW+WxFFEW3g797gglANL01nkgl0IpjPmSsh/i7qtG7L8T2eaY8wia5MsYnAwHAlQBkijx
        nPBW6XTK6ESXkeBWAkX1O+sNVe5kjoKK8pX4/oGXvDZdK7O43eVGUCFe3jLN/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634166140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jjiS7Vby7TYfAacFBJrjHOX1La5xXqOyExdDSyCN4hI=;
        b=wFsMZPN055QcM5xbzni4dLRNyOa0wtwtS8nB7i/Nz/l7ybNb7yU0qAorABbqRtSh0Rfsof
        W3/B3hBLjBLdIMDw==
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuwamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
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
In-Reply-To: <e4c0a191-ee26-9768-cbf5-c1d9782b1586@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87ee8o8xje.ffs@tglx> <YWdKlG0AzmjpjJKW@zn.tnic> <877deg8vn4.ffs@tglx>
 <YWdRqAqedkhVA2lD@zn.tnic>
 <e4c0a191-ee26-9768-cbf5-c1d9782b1586@linux.intel.com>
Date:   Thu, 14 Oct 2021 01:02:19 +0200
Message-ID: <87zgrc7clg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13 2021 at 15:28, Sathyanarayanan Kuppuswamy wrote:
> On 10/13/21 2:37 PM, Borislav Petkov wrote:
>> On Wed, Oct 13, 2021 at 11:25:35PM +0200, Thomas Gleixner wrote:
>>> So this ends up in doing:
>>>
>>>     use();
>>>     init();
>>>
>>> Can you spot what's wrong with that?
>>>
>>> That's a clear violation of common sense and is simply not going to
>>> happen. Why? If you think about deep defensive programming then use()
>>> will look like this:
>>>
>>> use()
>>> {
>>>          assert(initialized);
>>> }
>>>
>>> which is not something made up. It's a fundamental principle of
>>> programming and some languages enforce that for very good reasons.
>>>
>>> Just because it can be done in C is no justification.
>> Oh, I heartily agree.
>>   
>>> What's wrong with:
>>>
>>> x86_64_start_kernel()
>>>
>>>      tdx_early_init();
>>>
>>>      copy_bootdata();
>>>      
>>>      tdx_late_init();
>>>
>>> Absolutely nothing. It's clear, simple and well defined.
>> I like simple more than anyone, so sure, I'd prefer that a lot more.
>>
>> And so the options parsing would need to happen early using, say,
>> cmdline_find_option() or so, like sme_enable() does.
>
> Since in tdx_early_init() all we are going to do is to initialize
> "tdx_guest_detected" using cpuid call, shall we name it
> tdx_guest_cpuid_init()? (similar to sme_enable call in AMD)

How is that similar?

Just chose a name which makes sense in the overall scheme. I surely care
about naming convetions, but what I care more about is correctness.

Whether it ends up being named

        tdx_enable() - to match the SME muck

or

        tdx_detect()

or whatever makes sense does not really matter. As long as it makes
sense. That's bikeshed painting realm.

Coming back to your suggestion 'tdx_guest_cpuid_init()'. Just sit back
and think about what that name says:

    tdx_guest_cpuid_init()

For the uniformed reader this says:

    If tdx guest then initialize CPUID

which is obviously not what you want to express, right?

So, naming matters but you are free to chose something which makes
sense.

Thanks,

        tglx
