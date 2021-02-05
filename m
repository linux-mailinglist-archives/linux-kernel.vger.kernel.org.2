Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D9310FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhBEQby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbhBEQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:29:28 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B099C06178A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:11:09 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id e10so1682093vkm.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F4x29TTVEpw+IQOs4pBG2aQj/4xmoAAS+aT8UOnwOmY=;
        b=qknmJZd3jqr6x5X39DF2bWa4iCWwABpUdPV+kiRS7BjkpstQ3R85pT/tbr5d3hNpB9
         yW0LXkiBIQ9AFs9DG2uvmihC17ZgotzN27Hng1dlGt5QTun/RUerKK2911tPvuoXn1ZI
         4Qj5x0Fa4n/4T20Qe+2kDzkJuUwxbIOcCOEdtKU2SULF01iC1zgPMTeESFhTMb2BjGOz
         xfKAZYqWDlQvvnzppXYrhii9X4yNttSXp2f+ubulxYF5MhWK7sPq9jj178SvqlBEpC5U
         9Frwc1oFfSbQaJhEktTE7yUVcL/0L7g33b9cogvvwjWiH0rNtSaE0XoSdkY1RCp4AF4l
         MwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F4x29TTVEpw+IQOs4pBG2aQj/4xmoAAS+aT8UOnwOmY=;
        b=f3Viw2ITW+Os4w8BI3SjFp03jtNZpJlihi7fcGHoNjdcIz4LnN9MHkXghW7pCp23Kq
         X1DlEledd320jnZB6PpFjT6BPiikdHtkmvb3LUSUqq9dy/asNX19/g950/Ko66A/91Om
         Gy1yUdQGWMvb9d75thGH/umNAgXpO8ahNinF+D9c/XZng0u2cFnIIGeiwx6c7yfq0WS2
         2pAJ5DB6XdklNC5KdCmgtm2HAnjQ0SKgiLELhbRq5ws4k7NX0plJIHXsws0xE3k8Bj1e
         E+dRLeIQKKFu6mazDCPqdGqelWmd6Obb03slwu2EnGTNJKCU7cOXjrwCkEgkWBE88Kl2
         0TOw==
X-Gm-Message-State: AOAM531GQeAEFkOBtqtt8aA9d+gkNdKYDCfqPY3fpoQWh35YgrPncDLK
        zZ2/KyD2PLDuJoE4xyaqzcp+H7hY5xQBjnmAkig=
X-Google-Smtp-Source: ABdhPJyQSyKITQ1MekomM876tjivL1ZvoCSAVcqpJpbeCFMyFC9uD/Ttet6N6ReP2+QW6Yc6xVzXQLrj29pjrTCK+Po=
X-Received: by 2002:a1f:9c57:: with SMTP id f84mr4084825vke.2.1612548668509;
 Fri, 05 Feb 2021 10:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20210204150100.GE20815@willie-the-truck> <20210204163721.91295-1-lecopzer@gmail.com>
 <20210205171859.GE22665@willie-the-truck>
In-Reply-To: <20210205171859.GE22665@willie-the-truck>
From:   Lecopzer Chen <lecopzer@gmail.com>
Date:   Sat, 6 Feb 2021 02:10:56 +0800
Message-ID: <CANr2M1_9Y9s1jYXOYJDxTtZbnxyc4Xwb2Ask+nZ_eSaZCnCd7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
To:     Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, ardb@kernel.org,
        aryabinin@virtuozzo.com, broonie@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        dan.j.williams@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>, gustavoars@kernel.org,
        kasan-dev@googlegroups.com,
        Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mm@kvack.org,
        linux@roeck-us.net, robin.murphy@arm.com, rppt@kernel.org,
        tyhicks@linux.microsoft.com, vincenzo.frascino@arm.com,
        yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=886=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=881:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Feb 05, 2021 at 12:37:21AM +0800, Lecopzer Chen wrote:
> >
> > > On Thu, Feb 04, 2021 at 10:46:12PM +0800, Lecopzer Chen wrote:
> > > > > On Sat, Jan 09, 2021 at 06:32:49PM +0800, Lecopzer Chen wrote:
> > > > > > Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > > > > > ("kasan: support backing vmalloc space with real shadow memory"=
)
> > > > > >
> > > > > > Like how the MODULES_VADDR does now, just not to early populate
> > > > > > the VMALLOC_START between VMALLOC_END.
> > > > > > similarly, the kernel code mapping is now in the VMALLOC area a=
nd
> > > > > > should keep these area populated.
> > > > > >
> > > > > > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > > > > > ---
> > > > > >  arch/arm64/mm/kasan_init.c | 23 ++++++++++++++++++-----
> > > > > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_i=
nit.c
> > > > > > index d8e66c78440e..39b218a64279 100644
> > > > > > --- a/arch/arm64/mm/kasan_init.c
> > > > > > +++ b/arch/arm64/mm/kasan_init.c
> > > > > > @@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
> > > > > >  {
> > > > > >   u64 kimg_shadow_start, kimg_shadow_end;
> > > > > >   u64 mod_shadow_start, mod_shadow_end;
> > > > > > + u64 vmalloc_shadow_start, vmalloc_shadow_end;
> > > > > >   phys_addr_t pa_start, pa_end;
> > > > > >   u64 i;
> > > > > >
> > > > > > @@ -223,6 +224,9 @@ static void __init kasan_init_shadow(void)
> > > > > >   mod_shadow_start =3D (u64)kasan_mem_to_shadow((void *)MODULES=
_VADDR);
> > > > > >   mod_shadow_end =3D (u64)kasan_mem_to_shadow((void *)MODULES_E=
ND);
> > > > > >
> > > > > > + vmalloc_shadow_start =3D (u64)kasan_mem_to_shadow((void *)VMA=
LLOC_START);
> > > > > > + vmalloc_shadow_end =3D (u64)kasan_mem_to_shadow((void *)VMALL=
OC_END);
> > > > > > +
> > > > > >   /*
> > > > > >    * We are going to perform proper setup of shadow memory.
> > > > > >    * At first we should unmap early shadow (clear_pgds() call b=
elow).
> > > > > > @@ -241,12 +245,21 @@ static void __init kasan_init_shadow(void=
)
> > > > > >
> > > > > >   kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_=
END),
> > > > > >                              (void *)mod_shadow_start);
> > > > > > - kasan_populate_early_shadow((void *)kimg_shadow_end,
> > > > > > -                            (void *)KASAN_SHADOW_END);
> > > > > > + if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> > > > >
> > > > > Do we really need yet another CONFIG option for KASAN? What's the=
 use-case
> > > > > for *not* enabling this if you're already enabling one of the KAS=
AN
> > > > > backends?
> > > >commit message
> > > > As I know, KASAN_VMALLOC now only supports KASAN_GENERIC and also
> > > > KASAN_VMALLOC uses more memory to map real shadow memory (1/8 of vm=
alloc va).
> > >
> > > The shadow is allocated dynamically though, isn't it?
> >
> > Yes, but It's still a cost.
> >
> > > > There should be someone can enable KASAN_GENERIC but can't use VMAL=
LOC
> > > > due to memory issue.
> > >
> > > That doesn't sound particularly realistic to me. The reason I'm pushi=
ng here
> > > is because I would _really_ like to move to VMAP stack unconditionall=
y, and
> > > that would effectively force KASAN_VMALLOC to be set if KASAN is in u=
se.
> > >
> > > So unless there's a really good reason not to do that, please can we =
make
> > > this unconditional for arm64? Pretty please?
> >
> > I think it's fine since we have a good reason.
> > Also if someone have memory issue in KASAN_VMALLOC,
> > they can use SW_TAG, right?
> >
> > However the SW_TAG/HW_TAG is not supported VMALLOC yet.
> > So the code would be like
> >
> >       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>
> Just make this CONFIG_KASAN_VMALLOC, since that depends on KASAN_GENERIC.

OK, this also make sense.
My first thought was that selecting KASAN_GENERIC implies VMALLOC in
arm64 is a special case so this need well documented.
I'll document this in the commit message of Kconfig patch to avoid
messing up the code here.

I'm going to send V3 patch, thanks again for your review.

BRs,
Lecopzer
