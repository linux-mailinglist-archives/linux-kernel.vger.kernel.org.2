Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94AF3937E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 23:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhE0VZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 17:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhE0VZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 17:25:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1064C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:23:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a25so2433877edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtk1KfZdLajxwbhT65JW8U2wdZuCaGM9BEuhzktfObs=;
        b=Htjon9vyJB4klyv3eTCZtB8q9+D6GsQWRHU6+y0ymKVo1ONHh37Pf6otfRAc8jAnWx
         WK7qGAo0rt9uYT4g7jQ3wIKSxNEAczZ2mYTihXLVwQvezyJ2YUWBGq70j8v8B/qP1jbP
         gDNKxwQ2vjJyi5k087KjKfYMXCmSZSIbFHl5NrhLxS4Rt5dO7bU4inOvbPbwDw2NHu74
         HroJW4xS6/qj/FItP1rUrHm6MQL4Vq4kF/GW1IwKU5tz+RhSi4cuzKH3QtcsQ1nND36V
         qDg9Mvf5tDQhuDLRXeorxl4mJWTXnL6gsf1el4KjzRHP0+byzPR13155T4AEydehRUQE
         UM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtk1KfZdLajxwbhT65JW8U2wdZuCaGM9BEuhzktfObs=;
        b=Pu6N+72MOCZFOgvWhOX/onPWyNzrCd8fL8BHZskzDrxGcYkhdGRtav428MIDLTE5hx
         R9scpRpksgrsd/B61RjJQ+Y256ndeloGWM4cAN1uyEyL/aYIQqKiRbr2Nc6nxIPZ8BBb
         DXwbFl3R3EwGuz6gxr1KoJ6Barpqf9Ik4EhGco7I9UAHSQJvtMnDP+rP/k5o3toD6Djh
         kgf+BkO3MB5sdUAXhUWWL10z7ma4UtzvZ58LtCPr7eI72T7F4Oh1sGZoSIdz0t5iCpB0
         jnp5thSE5Cqoe8Y6wvSkLCtwBIKXenQDfHRWoMapxjviyjv8ShzBsqy5NwsEanM2TXlV
         tHIQ==
X-Gm-Message-State: AOAM533xLV89tycFT1+HqHCROG+lLhdb6Bfpix4LbVgWyA+SPppEoj3J
        2C4wTptfgNm7Sw1loR3rpkqGSJzv884rWHz2gCUb2Q==
X-Google-Smtp-Source: ABdhPJxuISj8qI4gAyrlKW3NSBXW5qxzRfDjheJb9RE6sYqnS3A0E0DD9bryIgfvOetzNTBQblwjQvJAz2coW3/0uuQ=
X-Received: by 2002:a50:c446:: with SMTP id w6mr6454782edf.62.1622150638129;
 Thu, 27 May 2021 14:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
 <20210527150526.271941-4-pasha.tatashin@soleen.com> <87sg28rx3c.wl-maz@kernel.org>
In-Reply-To: <87sg28rx3c.wl-maz@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 27 May 2021 17:23:22 -0400
Message-ID: <CA+CK2bDvsFX_s-G5tRcE1GreNW_xLTognosUFbPPgaUK7-cafQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] arm64: hyp-stub: Move elx_sync into the vectors
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
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 11:54 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 27 May 2021 16:05:11 +0100,
> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > The hyp-stub's elx_sync code fits in the vector.
> >
> > With this, all of the hyp-stubs behaviour is contained in its vectors.
> > This lets kexec and hibernate copy the hyp-stub when they need its
> > behaviour, instead of re-implementing it.
> >
> > Co-developed-by: James Morse <james.morse@arm.com>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/kernel/hyp-stub.S | 64 +++++++++++++++++++-----------------
> >  1 file changed, 33 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > index 18a97bee3779..86af6c4e52b9 100644
> > --- a/arch/arm64/kernel/hyp-stub.S
> > +++ b/arch/arm64/kernel/hyp-stub.S
> > @@ -21,6 +21,37 @@ SYM_CODE_START_LOCAL(\label)
> >       .align 7
> >       b       \label
> >  SYM_CODE_END(\label)
> > +.endm
> > +
> > +.macro elx_sync_vector       label
> > +SYM_CODE_START_LOCAL(\label)
> > +     .align 7
> > +     cmp     x0, #HVC_SET_VECTORS
> > +     b.ne    1f
> > +     msr     vbar_el2, x1
> > +     b       9f
> > +
> > +1:   cmp     x0, #HVC_VHE_RESTART
> > +     b.eq    mutate_to_vhe
>
> Now that this has turned into a macro, what are the guarantees that
> mutate_to_vhe will be within reach of the site where this macro is
> expanded? It does work here, but what about the other expansion sites
> that will show up later in the series?
>
> What was wrong with directly branching to the original call site?
> Nothing in the commit message explains it.

Hi Marc,

I need to explain this better in the commit log. Later in the series
we create our own vector copy that is outside of the old and new
kernel so it does not get overwritten during kexec relocation. When
VHE is enabled, the vector is passed so we can switch to el2 before
jumping to the new kernel.

arm64_relocate_new_kernel() which performs the relocation runs with
MMU being enabled until relocation is done, after that disables MMU
and if vectors are passed performs:

         mov     x0, #HVC_SOFT_RESTART
         hvc     #0         /* Jumps from el2 */

It cannot call mutate_to_vhe because #HVC_VHE_RESTART is not used
here. But, if it had to it would not work as we cannot return to the
old kernel text after relocation.

Thanks,
Pasha

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
