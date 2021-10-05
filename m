Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15CC422B13
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhJEOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhJEOde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:33:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7BC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 07:31:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x4so2447235pln.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zQzPL4jPTfY5Gs01Bw8aEe95wxvsGCtgo8lbfA6ubxs=;
        b=Nt30o8NgZ5mEaFkZasyGYLy6Zo7OP+g2dL9jJrvnBIYXtlhufvbCsp29c6Jr7QDdG/
         SECIVc4tK1lh2d4db2NgODm8X7u8RXf7v6DZgGOpUMG4zugv0OyNWsvafeoSvFK0OUAD
         YZCTPay65h/EXqGVPFnvRMFFsSUqFk9WbQRMpkyjVOZ1fPI+HuubZ3Uov3wSJp/+qp6y
         Pe0WOZEv/+g8SWof2Xa5v9zgz7yhj7l7hXqjr8oHSuwr0j2PerVTjrwDexJfYpRiOxgA
         8oYj18m7OXNxN+kZHq5vPAphCTq06mxWDyBLeKzBSzU4M6HSHTk5wwPAXrw16eGbnsSu
         TU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zQzPL4jPTfY5Gs01Bw8aEe95wxvsGCtgo8lbfA6ubxs=;
        b=Bi9Td7D45ymJv/I+rtJxU72v4AOzBLvSruEP31h3SuYQKAa8793fBOBs720MHwEDNn
         R3kbd9uqMbbBaCe5/GLEVdiACRre62789BRvFVGvWgiJx8b7HXjn/sfEHKJLxx3W83EN
         t9X/IJPCmXrdeqpEvpviN1U1oy5X4x3Cngvr04inbbyHudgMCJO3JCThh3AX/ND7V0ud
         UkncoWn48x275re+PO5WoGw3fsRNIqiKAIpRdZtBd4qTPtcIDDJPJnOQv3gYw89/+gg9
         iQ1ZpvSZRKaaEbcKbOyulzMeyYOrBVQcMT7/vr29vsUed0qJ80h/Ei6uzFxrso7anpyL
         5JIQ==
X-Gm-Message-State: AOAM530AM0Ryykd7AW1HrJO7ulfPgs4tneUyJ3AOzrXdCQmF1DvX8ik9
        UYYF9ZIXyzo4jbDnWhrr6KDoYA==
X-Google-Smtp-Source: ABdhPJxaxnzrnwuk3WbUjo3AEanazNH2E8zk6K3YTdQ7u9Hm79Bmd3CeVhfkk8SQcAAuA0F5oX8zOg==
X-Received: by 2002:a17:90a:6348:: with SMTP id v8mr3993796pjs.231.1633444303378;
        Tue, 05 Oct 2021 07:31:43 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o12sm2398875pjm.57.2021.10.05.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 07:31:42 -0700 (PDT)
Date:   Tue, 5 Oct 2021 14:31:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
Message-ID: <YVxhy0FnMAhxe0+N@google.com>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <cf33750f-615a-1edd-0fee-28e720bb38ce@infradead.org>
 <CAC41dw-U85dCGDm_QzyyOQfhbbaZZ5m9CvLuDjdXjuxEyid8qw@mail.gmail.com>
 <8a484fb1-21c5-5181-3e77-c818bcc2ffa7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a484fb1-21c5-5181-3e77-c818bcc2ffa7@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021, Dave Hansen wrote:
> On 10/5/21 6:29 AM, Sathyanarayanan Kuppuswamy Natarajan wrote:
> > On Mon, Oct 4, 2021 at 9:53 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> On 10/4/21 7:51 PM, Kuppuswamy Sathyanarayanan wrote:
> >>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >>> index 2b2a9639d8ae..c42dd8a2d1f4 100644
> >>> --- a/arch/x86/Kconfig
> >>> +++ b/arch/x86/Kconfig
> >>> @@ -865,6 +865,20 @@ config ACRN_GUEST
> >>>         IOT with small footprint and real-time features. More details can be
> >>>         found inhttps://projectacrn.org/.
> >>>
> >>> +config INTEL_TDX_GUEST
> >>> +     bool "Intel Trusted Domain eXtensions Guest Support"
> >>> +     depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
> >>> +     depends on SECURITY
> >>> +     select X86_X2APIC
> >> Apparently some Intel CPUs don't have the x2apic feature, since the
> >> Kconfig help text for X86_X2APIC says:
> >>
> >>           This enables x2apic support on CPUs that have this feature.
> >>
> >> so how is it safe to set/enable/select that kconfig symbol?

It's safe because the X86_X2APIC=y doesn't force x2APIC mode, it only enables
support for x2APIC mode.  If the CPU doesn't support x2APIC the kernel will use
legacy xAPIC.

That said, using select instead of depends is silly.

> >> Will the x2apic code just safely not work if the h/w feature is
> >> missing?
> > For the TDX guest, x2apic will be emulated. So it will exist in our
> > case.

That's incorrect, TDX partially virtualizes (as opposed to fully emulates) x2APIC
and thus requires the CPU to support x2APIC.

> > Even if x2apic or TDX guest is not supported by CPU, it will boot just fine.
>
> This doesn't really explain the "select X86_X2APIC", though.
> 
> You just said that TDX doesn't *require* X2APIC.

Well, TDX requires the guest to support x2APIC if the guest wants to do anything
useful.

10.9.1. Virtual APIC Mode
 * Guest TDs must use virtualized x2APIC mode. xAPIC mode (using memory mapped
   APIC access) is not allowed.
 * Guest TD attempts to RDMSR or WRMSR the IA32_APIC_BASE MSR cause a #VE to the
   guest TD. The guest TD cannot disable the APIC.
