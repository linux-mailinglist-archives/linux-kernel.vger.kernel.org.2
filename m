Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5942CE6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhJMWia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJMWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:38:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16C5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:36:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so4427306pjq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=1pHWS+BVUq5uchM7vuDgjyeC26Eu0fi2X4MKj9b33xs=;
        b=mnw2mRlMo+9glNuJrzyfBvyZO7oj+N3Os5/ZrSjUejev7KQi7KbSKpEdKuxQP97fSr
         QtU2sDn1c+fGNq2fCjq97Fr+PC9HdTjnw6uiZgeGzILuc3UcgBKOBgK453o4qU8+ZCNJ
         j8jdD34QLLE1AJaEGYAOdoM5a2MYGTZaZ9Hb/OE1GmcZwbX1F7g9UEuIePp3YtRDT0ac
         Neb5ieJDHZejUOaMx4ask4jjPPqWwum/xiyt6OWzv6a5sH1S8Et5men2W4T1L1Y+LwiU
         I+IxcN/8lAQc5EgG4CVrQ07d2/L4ZR/pg4fbpXrHBEVsowgH9cLI9glPmTwIHh5Ao5uh
         V06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=1pHWS+BVUq5uchM7vuDgjyeC26Eu0fi2X4MKj9b33xs=;
        b=EHJvtNqMtPekW+BUkebMZp3DyHSrkSoZPePfDDNBB0iFi1XsWXPtu02BaElcXxwcIl
         xJuneZ/QNGaBSds/yNZgLnTDCGF1FtVBKHvyMUk0Ih33jiTLdYfj0J/ppVlxJorooZfG
         lwvRJbvVYFhUVQN8MXnkBjbxlQFm6wkHQ97+aoR4MhQ4ImAg7gFB2KSwgMR3Y/KltYGN
         cC4ZnutcIYGf91MWX7sdwKYzWLtb0fvo+5neYMo2eY/KYXCnX6vX76Y+fT/lAZuHMzzY
         Fia1TfCK/L22gJuhwYlyEOcPl2ncJYKrPuYqoG3fKk8zD1OR2WqsZAYkcTORuPPuXnig
         1piw==
X-Gm-Message-State: AOAM533BWwv0s+dN/sD1DuWjN4XhsNit7dYh6Ttwh1ueBLmSNKp2GDWb
        1WbITSkzEf9Qm9cFbcLEqgk8lRFGjhk0zw/faIk=
X-Received: by 2002:a17:90b:4a01:: with SMTP id kk1mt1143547pjb.208.1634164585388;
 Wed, 13 Oct 2021 15:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com> <CAFUsyfJWXJEc1879uX_YOJg7cvie0gitv+bu83DiUXiE74uQww@mail.gmail.com>
In-Reply-To: <CAFUsyfJWXJEc1879uX_YOJg7cvie0gitv+bu83DiUXiE74uQww@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 13 Oct 2021 17:36:14 -0500
Message-ID: <CAFUsyfJQ8_=QnZjZ2zS45wwB6AaRgL4JO8_sT1a_rXUsfh_1WQ@mail.gmail.com>
Subject: Re: [PATCH v1] x86/fpu: Remove opmask state from avx512_timestamp check
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 1:02 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Mon, Sep 20, 2021 at 12:40 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > This commit creates a new mask, XFEATURE_MASK_ZMM, to test against
> > xfeatures for conditionally updating the axx512_timestamp.
> >
> > Based on the comments, the avx512 state is meant to track when the
> > state would cause frequencey throttling. The opmasks (k0-k7) do not
> > cause frequency throttling, so they don't make sense to include.
> >
> > The current implementation, as well as the old, still does have a
> > false positive on ymm16-ymm31 and xmm16-31 because
> > XFEATURE_MASK_Hi16_ZMM includes them.
> >
> > Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> > ---
> > Issue is reproducible with the following code on x86_64:
> >
> > ```
> >         .global _start
> >         .text
> > _start:
> >         korq    %k0, %k0, %k0
> >
> > loop:
> >         jmp     loop
> >
> >
> >         movl    $60, %eax
> >         xorl    %edi, %edi
> >         syscall
> > ```
> >
> > Pretending run as executable named "foo":
> >
> > $> cat /proc/$(pidof foo)/arch_status
> >
> >
> > This should yield -1 as no frequency changing AVX512 instructions
> > where used but instead tracks the process.
> >
> > Note there still is a false positive with ymm16-ymm31 and xmm16-xmm31
> > but since there is no state to distinguish between there use and
> > zmm16-31 that seems inevitable.
> >
> >
> >  arch/x86/include/asm/fpu/types.h | 2 ++
> >  arch/x86/kernel/fpu/core.c       | 4 +++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> > index f5a38a5f3ae1..a4816fa7d541 100644
> > --- a/arch/x86/include/asm/fpu/types.h
> > +++ b/arch/x86/include/asm/fpu/types.h
> > @@ -141,6 +141,8 @@ enum xfeature {
> >  #define XFEATURE_MASK_AVX512           (XFEATURE_MASK_OPMASK \
> >                                          | XFEATURE_MASK_ZMM_Hi256 \
> >                                          | XFEATURE_MASK_Hi16_ZMM)
> > +#define XFEATURE_MASK_ZMM              (XFEATURE_MASK_ZMM_Hi256 \
> > +                                        | XFEATURE_MASK_Hi16_ZMM)
> >
> >  #define FIRST_EXTENDED_XFEATURE        XFEATURE_YMM
> >
> > diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> > index 7ada7bd03a32..342620a2e8ef 100644
> > --- a/arch/x86/kernel/fpu/core.c
> > +++ b/arch/x86/kernel/fpu/core.c
> > @@ -104,8 +104,10 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
> >                 /*
> >                  * AVX512 state is tracked here because its use is
> >                  * known to slow the max clock speed of the core.
> > +                * Note: This has a false positive on Hi16 ymm and
> > +                * xmm registers.
> >                  */
> > -               if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
> > +               if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_ZMM)
> >                         fpu->avx512_timestamp = jiffies;
> >                 return;
> >         }
> > --
> > 2.25.1
> >
> Ping
>
> (sorry if this has shown up multiple times for anyone,
> was accidentally including HTML earlier)

Ping2
