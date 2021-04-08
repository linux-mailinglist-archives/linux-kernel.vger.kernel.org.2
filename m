Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67011358763
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhDHOqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhDHOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:46:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC0AC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 07:45:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m3so2759133edv.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aP4+/wgY+aHLdP7WVG3wUuA56ODwMI83uK1g26CTxS8=;
        b=F1ivaxkHYK3YNvEyXAkkE8EKfxCD4mHzwhZR3636bMbnjNCLztUSKrxvIQ3Az1Nn6p
         +7KsTVnHIXWeKT/lFk6SZ68OJI2D77xsEtuCQthGOjtYqayd7ZAOazdA3z1Cg7z7YSKQ
         fYWV+k/o2b/P7GbNKxMrNuvqYQl1zEnwl85OQbek0neUVu2dPqfzEOWiWkcd44kKyArJ
         U3PrSDDMPLqNb10qWyaIe693BjDKwI3GBEQohd9lyOaGid2Oo/QWQZ9bnMgACofMc3Yt
         U14uVl8d1YHsjph5Ppr2yHdzKRpM8xl5X8RbOS+qkJXYsD1poMUUh/okTM9rTIRxSDRB
         aNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aP4+/wgY+aHLdP7WVG3wUuA56ODwMI83uK1g26CTxS8=;
        b=G6m5ZwxMlKjQrF+KTAqqK38gxK/Fvy6vSlKoVIH18/eJ8hMf2wfCqjXY5H9YSWCDnl
         8RuSO5UZ3HPSHBePLugVZSo3CmRGq6Lop91V96i44AkD+SMwaU/44o9+Xug4lTGwVjs5
         S3jU23iIuUgiejpkWpJbhQtwXjyJquAOo9rW7IS59aGWNEuUq8YKZ2s//hry0oJX9hz6
         XYylU61X/MFfTvyTMxzQ4mgUZUAX4RgAQOwMEXIGcOPKJshy31m4zy90kaUNGPk3hzuL
         0pQvoOQ2CDa5cKSm8L42fsso80Yz6WAYFJjuITU9styee6Rsn7RJbM+SRcx/f1VUk3kQ
         bwUg==
X-Gm-Message-State: AOAM531/deTb7lPE0u932kXq23ByQnqQ+O6fa68La4wOSMEAgtfQO+uI
        9s3uMMzlwc2BHJ6y0/4PfVvYV2DUZftR9hDnkU/CMA==
X-Google-Smtp-Source: ABdhPJyLURUxZtiZnGe6SwWCgmcGWMa/94o5nttbjueSVkPKwhjmuYlwF2DAd125IPHmumPkvW62Dys0w+LVTnB9KF0=
X-Received: by 2002:a05:6402:68a:: with SMTP id f10mr11938928edy.26.1617893154596;
 Thu, 08 Apr 2021 07:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
 <20210408040537.2703241-4-pasha.tatashin@soleen.com> <480272f8fb3e46d24a0ee1418fb85809@kernel.org>
In-Reply-To: <480272f8fb3e46d24a0ee1418fb85809@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 8 Apr 2021 10:45:18 -0400
Message-ID: <CA+CK2bDc+9EsH_TLTgg9Pqv_-rZfZfPohdZEfsYjT8ss+8skjg@mail.gmail.com>
Subject: Re: [PATCH v13 03/18] arm64: hyp-stub: Move el1_sync into the vectors
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 6:24 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-04-08 05:05, Pavel Tatashin wrote:
> > From: James Morse <james.morse@arm.com>
> >
> > The hyp-stub's el1_sync code doesn't do very much, this can easily fit
> > in the vectors.
> >
> > With this, all of the hyp-stubs behaviour is contained in its vectors.
> > This lets kexec and hibernate copy the hyp-stub when they need its
> > behaviour, instead of re-implementing it.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> >
> > [Fixed merging issues]
>
> That's a pretty odd fix IMO.
>
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/kernel/hyp-stub.S | 59 ++++++++++++++++++------------------
> >  1 file changed, 29 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/hyp-stub.S
> > b/arch/arm64/kernel/hyp-stub.S
> > index ff329c5c074d..d1a73d0f74e0 100644
> > --- a/arch/arm64/kernel/hyp-stub.S
> > +++ b/arch/arm64/kernel/hyp-stub.S
> > @@ -21,6 +21,34 @@ SYM_CODE_START_LOCAL(\label)
> >       .align 7
> >       b       \label
> >  SYM_CODE_END(\label)
> > +.endm
> > +
> > +.macro hyp_stub_el1_sync
> > +SYM_CODE_START_LOCAL(hyp_stub_el1_sync)
> > +     .align 7
> > +     cmp     x0, #HVC_SET_VECTORS
> > +     b.ne    2f
> > +     msr     vbar_el2, x1
> > +     b       9f
> > +
> > +2:   cmp     x0, #HVC_SOFT_RESTART
> > +     b.ne    3f
> > +     mov     x0, x2
> > +     mov     x2, x4
> > +     mov     x4, x1
> > +     mov     x1, x3
> > +     br      x4                              // no return
> > +
> > +3:   cmp     x0, #HVC_RESET_VECTORS
> > +     beq     9f                              // Nothing to reset!
> > +
> > +     /* Someone called kvm_call_hyp() against the hyp-stub... */
> > +     mov_q   x0, HVC_STUB_ERR
> > +     eret
> > +
> > +9:   mov     x0, xzr
> > +     eret
> > +SYM_CODE_END(hyp_stub_el1_sync)
>
> You said you tested this on a TX2. I guess you don't care whether
> it runs VHE or not...

Hi Marc,

Thank you for noticing this. Not sure how this missmerge happened. I
have added the missing case, and VHE is initialized correctly during
boot.
[   14.698175] kvm [1]: VHE mode initialized successfully

During normal boot, kexec reboot, and kdump reboot. I will respin the
series and send the version 14 soon.

Thanks,
Pasha

>
>          M.
>
> >  .endm
> >
> >       .text
> > @@ -39,7 +67,7 @@ SYM_CODE_START(__hyp_stub_vectors)
> >       invalid_vector  hyp_stub_el2h_fiq_invalid       // FIQ EL2h
> >       invalid_vector  hyp_stub_el2h_error_invalid     // Error EL2h
> >
> > -     ventry  el1_sync                        // Synchronous 64-bit EL1
> > +     hyp_stub_el1_sync                               // Synchronous 64-bit EL1
> >       invalid_vector  hyp_stub_el1_irq_invalid        // IRQ 64-bit EL1
> >       invalid_vector  hyp_stub_el1_fiq_invalid        // FIQ 64-bit EL1
> >       invalid_vector  hyp_stub_el1_error_invalid      // Error 64-bit EL1
> > @@ -55,35 +83,6 @@ SYM_CODE_END(__hyp_stub_vectors)
> >  # Check the __hyp_stub_vectors didn't overflow
> >  .org . - (__hyp_stub_vectors_end - __hyp_stub_vectors) + SZ_2K
> >
> > -
> > -SYM_CODE_START_LOCAL(el1_sync)
> > -     cmp     x0, #HVC_SET_VECTORS
> > -     b.ne    1f
> > -     msr     vbar_el2, x1
> > -     b       9f
> > -
> > -1:   cmp     x0, #HVC_VHE_RESTART
> > -     b.eq    mutate_to_vhe
> > -
> > -2:   cmp     x0, #HVC_SOFT_RESTART
> > -     b.ne    3f
> > -     mov     x0, x2
> > -     mov     x2, x4
> > -     mov     x4, x1
> > -     mov     x1, x3
> > -     br      x4                              // no return
> > -
> > -3:   cmp     x0, #HVC_RESET_VECTORS
> > -     beq     9f                              // Nothing to reset!
> > -
> > -     /* Someone called kvm_call_hyp() against the hyp-stub... */
> > -     mov_q   x0, HVC_STUB_ERR
> > -     eret
> > -
> > -9:   mov     x0, xzr
> > -     eret
> > -SYM_CODE_END(el1_sync)
> > -
> >  // nVHE? No way! Give me the real thing!
> >  SYM_CODE_START_LOCAL(mutate_to_vhe)
> >       // Sanity check: MMU *must* be off
>
> --
> Jazz is not dead. It just smells funny...
