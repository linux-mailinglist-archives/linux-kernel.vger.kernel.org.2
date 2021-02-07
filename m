Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434C731249D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhBGOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhBGONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:13:47 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C714C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:13:06 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id v15so13397179ljk.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=16o/Z+5upyUHDrLVmHwI5TdllWSqlH3kjJsNlYfK/dI=;
        b=sdAob03aN01bGphLyuq7yn+DUdeoZNHe6b2eGUb+pt5y+edC/5QzINLkJNO/66iLB1
         2VUex09f5JS4nx0CoeFX8sYgN1spfZ/ohSTEYDArUKugvdQqFMQFTuAVqZxZ8xtoFCYO
         mODdUWMUJy6f96sGAWGA3rwJyv6s8i+5DnZfnQNk4PZT2buMqNfVRgtjSwUBiPbvZafJ
         nfAAmtsdTAwuHvDOf+dVVQhE5dv02M0LrY1pJ3z5e+hfdhawLg5MPtyIdGvKb2xaZLqq
         ooRIJqPZtwRqqpGOVip/uHBYIQQ3/BEgS5tp6mksYBNasj8ioCfJd75uCUg59EiuwXxv
         jslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=16o/Z+5upyUHDrLVmHwI5TdllWSqlH3kjJsNlYfK/dI=;
        b=DH3wtcTq0tO4CTf9wVNBm85beFPGAZrAf+H4Dc/FCL7AQIoSkwILLC8mXktDLplkDP
         WrSsAzAPDNaSq2D0oJaPiMHBZpwqZLlNFjESI40AtZqFigPnEgUIMaMqU0aT86JSWb0R
         1pw32HaWrYdtWV63+bV69oJ8SJrP8X1I07Hpm8shB1EXDve09ko8XzrzNt+zvuKFkcAs
         YvMbp1TIq5UXK0kC0mxRuUluxgBp5e+y915xxmTmT0hJwaqfl/jOYs96g1HyJ+8XCcDU
         R75e8pwVHzUOYAytcZ415/WzxUbQn2ZCOt2k2Sl6nhU3Qf3rn8nXU3o5sY03JSSBM8J0
         GOQg==
X-Gm-Message-State: AOAM5327bJaOmFUi70SVW0hSjhpC2/sTGT9mcuuZaDBULWL1EEi03owp
        /+5ddb799Xp2aZ8PecNpc5iw9Q==
X-Google-Smtp-Source: ABdhPJwGYjyqV9o9D15MhutySTWgowfjEJaTA+lLGBeJ4qML63CfUyt+eIf0QhR4L3y92geYFyFOjA==
X-Received: by 2002:a2e:a58f:: with SMTP id m15mr8198871ljp.214.1612707184921;
        Sun, 07 Feb 2021 06:13:04 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a1sm1713974lfi.202.2021.02.07.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:13:04 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 54ED6102656; Sun,  7 Feb 2021 17:13:04 +0300 (+03)
Date:   Sun, 7 Feb 2021 17:13:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1 09/26] x86/tdx: Handle CPUID via #VE
Message-ID: <20210207141304.kdjg732lzh5uzz7i@box>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <e45fcb584cd9fd67e6585ad8a904659a8b2ff9a5.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CALCETrW3+mzHaCUcWC1YUSwiuHkDWo=S4xnavk0CMcBiZd17+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW3+mzHaCUcWC1YUSwiuHkDWo=S4xnavk0CMcBiZd17+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 03:42:01PM -0800, Andy Lutomirski wrote:
> On Fri, Feb 5, 2021 at 3:39 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >
> > TDX has three classes of CPUID leaves: some CPUID leaves
> > are always handled by the CPU, others are handled by the TDX module,
> > and some others are handled by the VMM. Since the VMM cannot directly
> > intercept the instruction these are reflected with a #VE exception
> > to the guest, which then converts it into a TDCALL to the VMM,
> > or handled directly.
> >
> > The TDX module EAS has a full list of CPUID leaves which are handled
> > natively or by the TDX module in 16.2. Only unknown CPUIDs are handled by
> > the #VE method. In practice this typically only applies to the
> > hypervisor specific CPUIDs unknown to the native CPU.
> >
> > Therefore there is no risk of causing this in early CPUID code which
> > runs before the #VE handler is set up because it will never access
> > those exotic CPUID leaves.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > ---
> >  arch/x86/kernel/tdx.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> > index 5d961263601e..e98058c048b5 100644
> > --- a/arch/x86/kernel/tdx.c
> > +++ b/arch/x86/kernel/tdx.c
> > @@ -172,6 +172,35 @@ static int tdx_write_msr_safe(unsigned int msr, unsigned int low,
> >         return ret || r10 ? -EIO : 0;
> >  }
> >
> > +static void tdx_handle_cpuid(struct pt_regs *regs)
> > +{
> > +       register long r10 asm("r10") = TDVMCALL_STANDARD;
> > +       register long r11 asm("r11") = EXIT_REASON_CPUID;
> > +       register long r12 asm("r12") = regs->ax;
> > +       register long r13 asm("r13") = regs->cx;
> > +       register long r14 asm("r14");
> > +       register long r15 asm("r15");
> > +       register long rcx asm("rcx");
> > +       long ret;
> > +
> > +       /* Allow to pass R10, R11, R12, R13, R14 and R15 down to the VMM */
> > +       rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15);
> > +
> > +       asm volatile(TDCALL
> > +                       : "=a"(ret), "=r"(r10), "=r"(r11), "=r"(r12), "=r"(r13),
> > +                         "=r"(r14), "=r"(r15)
> > +                       : "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
> > +                         "r"(r13)
> > +                       : );
> 
> Some "+" constraints would make this simpler.  But I think you should
> factor the TDCALL helper out into its own function.

Factor out TDCALL into a helper is tricky: different TDCALLs have
different list of registers passed to VMM.

-- 
 Kirill A. Shutemov
