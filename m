Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A929E42E1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhJNTJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhJNTJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:09:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82648C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:06:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y26so31342006lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJLNe6p0kXll0p/zQ+ix9EnlRMcV8HyMx0Hiy0sszkU=;
        b=QMp8GsscRFycNJArReWU8R4M0PoK8ClOHcQI4E03ubJTpHM9GdjtxAzFhJAPqdJWot
         qwxm2+2u+tb33NJb+VTPaO2xsSLXb+8ZO98YdQkc3geIh8eoa8qOj8DnUTW2xXCo+pk9
         l8IA5HXLxoLitt+gJWUtNv5Y4+4K5NXEr3MmGdLwbw3N05VonZE2Ozj/WhnyKw9vB4c+
         lbhJhLTB1QmN/ac4Chm3TKkD3GgeKkWC2X4UUJ8Gb9GWMoNCipiS/CsfD8RXaKDyMtCG
         lEyDydbQUJJ6Ey2CwqEneC7k4G41OGBHVmmPCRdGZUZ8GnELqXBqM6Y120/QaP8BzBZk
         nn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJLNe6p0kXll0p/zQ+ix9EnlRMcV8HyMx0Hiy0sszkU=;
        b=EM1c8VOfPm7B7g61isrRBD1jjeHGeGEWaU3pOlkzYxk/Af/Fc/sZw38kiTkxRZJ6JM
         qjL+s+7oGjoXg+mAwxUP8tHwzU0jWNpbTQCT2pgrdQ+9hYbCOjmJylBLmHcVnEZu51vz
         qstamTwKPHgnxR1vFB0qvOIYJYy7Wezshe29bxno02KvmPkx0RbI6qDVFY9TbnyEFo6T
         iL6vPxu+yEFvWQIjjoHaXh6ZMJv2wxiE2xWNeOmqd/B7ELZBxgjlpj2y0E6wbwkFXjSD
         rVgMjGL111E74s3dl4/J5ffH+iCLwPiCf6UwJxoQh+c638PSfyryWFuCm48A2U5QESZV
         Z47g==
X-Gm-Message-State: AOAM533XprWboSVpK53DXiKlrtA+S8H3gw+4zsRI0Ibn4NhZgudv4CUh
        tkKfqnq9K5ivVs3j2npFDFPjs2DVaSvi1Wchn8PbHw==
X-Google-Smtp-Source: ABdhPJzma2nL08hEQqA7xBaoTHEUCJANq0HPVL1+yf1LQX/Gkcr4fIO77knmTqXenYjPbxKRQFDbkcuH5w7uEEXYhY4=
X-Received: by 2002:a2e:461a:: with SMTP id t26mr7933890lja.198.1634238414589;
 Thu, 14 Oct 2021 12:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <1446878298.170497.1633338512925@office.mailbox.org>
 <b6abc5a3-39ea-b463-9df5-f50bdcb16d08@redhat.com> <936688112.157288.1633339838738@office.mailbox.org>
 <c4773ecc-053f-9bc6-03af-5039397a4531@redhat.com> <CAKwvOd=rrM4fGdGMkD5+kdA49a6K+JcUiR4K2-go=MMt++ukPA@mail.gmail.com>
 <CALMp9eRzadC50n=d=NFm7osVgKr+=UG7r2cWV2nOCfoPN41vvQ@mail.gmail.com>
 <YWht7v/1RuAiHIvC@archlinux-ax161> <YWh3iBoitI9UNmqV@google.com>
In-Reply-To: <YWh3iBoitI9UNmqV@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 12:06:42 -0700
Message-ID: <CAKwvOdkC7ydAWs+nB3cxEOrbb7uEjiyBWg1nOOBtKqaCh3zhBg@mail.gmail.com>
Subject: Re: [BUG] [5.15] Compilation error in arch/x86/kvm/mmu/spte.h with clang-14
To:     Sean Christopherson <seanjc@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, torvic9@mailbox.org,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:31 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Oct 14, 2021, Nathan Chancellor wrote:
> > On Mon, Oct 04, 2021 at 10:12:33AM -0700, Jim Mattson wrote:
> > > On Mon, Oct 4, 2021 at 9:13 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > On Mon, Oct 4, 2021 at 2:49 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > >
> > > > > On 04/10/21 11:30, torvic9@mailbox.org wrote:
> > > > > >
> > > > > >> Paolo Bonzini <pbonzini@redhat.com> hat am 04.10.2021 11:26 geschrieben:
> > > > > >>
> > > > > >>
> > > > > >> On 04/10/21 11:08, torvic9@mailbox.org wrote:
> > > > > >>> I encounter the following issue when compiling 5.15-rc4 with clang-14:
> > > > > >>>
> > > > > >>> In file included from arch/x86/kvm/mmu/mmu.c:27:
> > > > > >>> arch/x86/kvm/mmu/spte.h:318:9: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
> > > > > >>>           return __is_bad_mt_xwr(rsvd_check, spte) |
> > > > > >>>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >>>                                                    ||
> > > > > >>> arch/x86/kvm/mmu/spte.h:318:9: note: cast one or both operands to int to silence this warning
> > > > > >>
> > > > > >> The warning is wrong, as mentioned in the line right above:
> > >
> > > Casting the bool to an int doesn't seem that onerous.
> >
> > Alternatively, could we just change both of the functions to return u64?
> > I understand that they are being used in boolean contexts only but it
> > seems like this would make it clear that a boolean or bitwise operator
> > on them is acceptable.
>
> If we want to fix this, my vote is for casting to an int and updating the comment

At the least, I think bitwise operations should only be performed on
unsigned types.

> in is_rsvd_spte().  I think I'd vote to fix this?  IIRC KVM has had bitwise goofs
> in the past that manifested as real bugs, it would be nice to turn this on.
>
> Or maybe add a macro to handle this?  E.g.

I think Nathan's suggestion was much cleaner.  If explicit casts are
enough to silence the warning, then I think Jim's suggestion is even
better (though unsigned, not signed int).

>
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 7c0b09461349..38aeb4b21925 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -307,6 +307,12 @@ static inline bool __is_bad_mt_xwr(struct rsvd_bits_validate *rsvd_check,
>         return rsvd_check->bad_mt_xwr & BIT_ULL(pte & 0x3f);
>  }
>
> +/*
> + * Macro for intentional bitwise-OR of two booleans, which requires casting at
> + * least one of the results to an int to suppress -Wbitwise-instead-of-logical.
> + */
> +#define BITWISE_BOOLEAN_OR(a, b) (!!((int)(a) | (int)(b)))
> +
>  static __always_inline bool is_rsvd_spte(struct rsvd_bits_validate *rsvd_check,
>                                          u64 spte, int level)
>  {
> @@ -315,8 +321,8 @@ static __always_inline bool is_rsvd_spte(struct rsvd_bits_validate *rsvd_check,
>          * bits and EPT's invalid memtype/XWR checks to avoid an extra Jcc
>          * (this is extremely unlikely to be short-circuited as true).
>          */
> -       return __is_bad_mt_xwr(rsvd_check, spte) |
> -              __is_rsvd_bits_set(rsvd_check, spte, level);
> +       return BITWISE_BOOLEAN_OR(__is_bad_mt_xwr(rsvd_check, spte),
> +                                 __is_rsvd_bits_set(rsvd_check, spte, level));
>  }
>
>  static inline bool spte_can_locklessly_be_made_writable(u64 spte)



-- 
Thanks,
~Nick Desaulniers
