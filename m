Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26A04227DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhJENdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbhJENdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:33:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B07FC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:31:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b8so44084636edk.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A4bJ/jazYa0luzadMLfi8bAqYKnOylEO6Ksp3Jj7HjU=;
        b=HMU0+P5RNbPXvnWQsIMLsahvhpldzqunA6NcYMuZOMXPgvtg0wMDUVrl4ODgl8Gk/5
         Zq8Lxb4LR5DBrfqyYXsw9/nbPRVFs/Z1maKj7KcJjWdKsWScXzUPAuOgYGdf4n51LGwT
         2G0v8pMq64R80d6Ri0qoYJqfhsccz36TPeaglVREeL3oEsYvcu2R3lBFf6KZ3oWt37zE
         UYfWn0FkRE9GR0adTtAKpmHnqRl/Yj4ukmao9TeThQKNsc0+yXxgE5KQFnb6T3+oED3u
         PLH69RvghL/jYnkyyfLB56Y+SXr2I+dUp0Wc4l1pPIBbCZ/oHOpOY1GM0Cx9G/rrs8V/
         tHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A4bJ/jazYa0luzadMLfi8bAqYKnOylEO6Ksp3Jj7HjU=;
        b=jkop1AcZnVHXWPksQ1l7hRfoO+uyKiJ2LlxWSB3kQ8efWb+rwOfs3OuitsE4O6PmXP
         CmGplI0d2oSa8vaLnBxMh7lnZ9kX1mnUN6bJyFV6ayv7ltgj+fa06mtqaefEVVsKoDz3
         Or2FkaFNQbNa79TwIYg7XibTmLjL2iseOnOHDPrrNC/92Jt8XCOm4wioTMGqCXrv60cz
         QWxNS0M47O4iS1Hd7wwcZKIIjXtJ/BonOgcHBKmfIQOvOdkjeI1eTDYhPo1Jw+bZrg4W
         ky5OKbH5qsvfzwuIybwknDW/COPp1GEEpSdiN9WbCiS+m/EL39emUJSuqxGSlQ6yxB02
         vjWw==
X-Gm-Message-State: AOAM530L9Ocs2rwOKIc2HxDsl+jkc7ghqE385KxAAEanrxxOXxF6QCHm
        CTnzXNfrrH1t5V9aHbcuAsagoMpS10sr4AVUwsA=
X-Google-Smtp-Source: ABdhPJzHLb53q8fuztbAUUvoIvCpy44vPRL0x7G9XqbdqBofieqeb9lzsvm7taldXlHd6eeR/YGn3vKvPYipXKSX48s=
X-Received: by 2002:a17:906:1f09:: with SMTP id w9mr25956053ejj.472.1633440594615;
 Tue, 05 Oct 2021 06:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com> <cf33750f-615a-1edd-0fee-28e720bb38ce@infradead.org>
In-Reply-To: <cf33750f-615a-1edd-0fee-28e720bb38ce@infradead.org>
From:   Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Date:   Tue, 5 Oct 2021 06:29:43 -0700
Message-ID: <CAC41dw-U85dCGDm_QzyyOQfhbbaZZ5m9CvLuDjdXjuxEyid8qw@mail.gmail.com>
Subject: Re: [PATCH v8 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Kuppuswamy Sathyanarayanan 
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
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 9:53 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/4/21 7:51 PM, Kuppuswamy Sathyanarayanan wrote:
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 2b2a9639d8ae..c42dd8a2d1f4 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -865,6 +865,20 @@ config ACRN_GUEST
> >         IOT with small footprint and real-time features. More details c=
an be
> >         found inhttps://projectacrn.org/.
> >
> > +config INTEL_TDX_GUEST
> > +     bool "Intel Trusted Domain eXtensions Guest Support"
> > +     depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
> > +     depends on SECURITY
> > +     select X86_X2APIC
>
> Apparently some Intel CPUs don't have the x2apic feature, since the
> Kconfig help text for X86_X2APIC says:
>
>           This enables x2apic support on CPUs that have this feature.
>
> so how is it safe to set/enable/select that kconfig symbol?
>
> Will the x2apic code just safely not work if the h/w feature is
> missing?

For the TDX guest, x2apic will be emulated. So it will exist in our
case. Even if x2apic or TDX guest is not supported by CPU, it will
boot just fine.

>
> > +     select SECURITY_LOCKDOWN_LSM
> > +     help
> > +       Provide support for running in a trusted domain on Intel proces=
sors
> > +       equipped with Trusted Domain eXtensions. TDX is a Intel technol=
ogy
> > +       that extends VMX and Memory Encryption with a new kind of virtu=
al
> > +       machine guest called Trust Domain (TD). A TD is designed to run=
 in
> > +       a CPU mode that protects the confidentiality of TD memory conte=
nts
> > +       and the TD=E2=80=99s CPU state from other software, including V=
MM.
>
>
> thanks.
> --
> ~Randy



--=20
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
