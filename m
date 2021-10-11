Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49404292D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhJKPIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhJKPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:08:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD887C061745
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:06:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c29so15089551pfp.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ES0x4KKi213NBYwRVGpLwmppAh4kTz9W8sOWXXeERdE=;
        b=sgBTxJ6bOpXaNmhkrBXsEoQw4rIy/dIleE6rK90FOuieGJ2a4gVZmJWAfHjR0Yt0yF
         LR6VJK7kjCueP5x820M7LMQr3/z6k3Fdsm6N3nBxxqa1eCRP8TsJ/EAGjJnbtaq2sujf
         c0hrAGdTEBwaxDC4ehCOm6+uFYHrP0gQSCm8qmiX7IurFeRmHHQGhL73ualnsDPFAV5g
         IdmFluPMqkXHU8D8oGC8rvfAq+JxhqEqtXaj9EKy5dR4BN+gHTLLucTvRBhKg2P2h/SW
         IxdYu/Bq71ojz80eZy/OFf4+q4oxBJ1akW7jxBo0vMHZlRaEuodrJKq5dK2LFM70o6JA
         73eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ES0x4KKi213NBYwRVGpLwmppAh4kTz9W8sOWXXeERdE=;
        b=zoDHul71AL1tMw1YNJQLyf0xxvVyL35zwSJVKYyumLhcmR8JPj2sXYVgbHIRIUuJAY
         S2Y2mmwPnDNCYtMLqZQ/6SjFPr06HwsPInAmrT0hrn25tYu0SqmE8Vbzcg9BGzTNPpHq
         RRIAmE6vRN7SokAtJLQ5pnjl232jfH0PTcFdcQZkyWNVgkHDhdXqntQts700ghX2mnjk
         fhi1NVS2ojnoDHRWBmqNevh3MnPTG47q9PYsjVSDG4foBHJXqFd04y5kHLMF+koBNneC
         1cMlmlMVcrJgf3YLTzfRAI3VMY1QD24FDeKQvqXrTnvkJnxpGge/icza7+5qJbQ9SYwF
         bRww==
X-Gm-Message-State: AOAM530hkqrz3wVK0+/pOHpd0mgdFDbJNwKhHsTqMQnAvrn1n1x4UB7k
        sMWqD6ekzlejHDQXjBjYzeDkoQ==
X-Google-Smtp-Source: ABdhPJw/tmih7R7AVrpH1iw+PTL8CTfKZopkCwISVfpzKajPEvPbtOd83S2Fez7aBTajIdVv9UDSbw==
X-Received: by 2002:a63:ac09:: with SMTP id v9mr18351405pge.355.1633964775941;
        Mon, 11 Oct 2021 08:06:15 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r14sm8567066pgf.49.2021.10.11.08.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 08:06:15 -0700 (PDT)
Date:   Mon, 11 Oct 2021 15:06:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/11] x86/traps: Add #VE support for TDX guest
Message-ID: <YWRS41aZH9A6fekt@google.com>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJhGHyAqapG2MHfANeHG+LFHYr3a8AcHtbxcL3xUR_rmEOTqiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyAqapG2MHfANeHG+LFHYr3a8AcHtbxcL3xUR_rmEOTqiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021, Lai Jiangshan wrote:
> On Tue, Oct 5, 2021 at 10:54 AM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> 
> >
> > The entry paths do not access TD-shared memory, MMIO regions or use
> > those specific MSRs, instructions, CPUID leaves that might generate #VE.
> > In addition, all interrupts including NMIs are blocked by the hardware
> > starting with #VE delivery until TDGETVEINFO is called.  This eliminates
> > the chance of a #VE during the syscall gap or paranoid entry paths and
> > simplifies #VE handling.

Minor clarification: it eliminates the chance of a #VE during the syscall gap
_if the VMM is benign_.  If the VMM is malicious, it can unmap and remap the
syscall page to induce an EPT Violation #VE due to the page not being accepted.

> Hello
> 
> If the reason is applied to #VE, I think it can be applied to SVM-ES's
> #VC too.  (I wish the entry code for #VC to be simplified since I'm
> moving some the asm entry code to C code)
>
> And I'm sorry I haven't read all the emails.
> Has the question asked by Andy Lutomirski been answered in any emails?
> 
> https://lore.kernel.org/lkml/CALCETrU9XypKbj-TrXLB3CPW6=MZ__5ifLz0ckbB=c=Myegn9Q@mail.gmail.com/

This question?

  Can the hypervisor cause an already-accepted secure-EPT page to transition to
  the unaccepted state?

Yep.  I wrote the above before following the link, I should have guessed which
question it was :-)

IIRC, the proposed middle ground was to add a TDCALL and/or TDPARAMS setting that
would allow the guest to opt-out of EPT Violation #VE due to page not accepted,
and instead terminate the VM on such a condition.  The caveat is that that would
require the kernel to never take an "page not accepted #VE" when doing lazy page
acceptance, but that was deemed doable.

That also raises the question of whether Andy's NAK applies to SEV-SNP without
support for "Enhanced SYSCALL Behavior"[*], otherwise SEV-SNP has the same "#VC
in syscall gap" attack.

[*] https://www.amd.com/system/files/TechDocs/57115.pdf
