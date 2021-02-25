Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15229325360
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhBYQTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:19:52 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:46872 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhBYQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:19:36 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 11PGIba6010136
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:18:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 11PGIba6010136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614269918;
        bh=liXahywxZWfWM2OwbP2+HJ7Aw4ekKS/5tqxTg5Z4tkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tl00HqB4X3QT2dkSn2f1/AwyGVfMDRTiYABHqBLIwceitvJVRgVxsihnlhoMUL+un
         l3/jnGRLIeot0JmyspR0EFM9GLgDs/7r86HwyPMcwF33PDxOYFp5/rJP1g/a19r9tk
         vXbC7rwvKleP83h4x8pqJbL6O9tTgq4ryavGFqIGiUGRs3Y6EzmlEaeaTrJqVjYax+
         0c5yOIjWDYtbexNZHFVRGWk8DLxVHln2EojW5bDuDzorTsHr3K1ZKh5WPyvIgmp+0/
         A+i3Km2sDLHd+f2+x16nx8dac2bsffTT/sKWbDBvlPNKgxJZK95jodv1HKXRlMjx8A
         XEbN2KqcTBErQ==
X-Nifty-SrcIP: [209.85.216.48]
Received: by mail-pj1-f48.google.com with SMTP id t5so5251231pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 08:18:37 -0800 (PST)
X-Gm-Message-State: AOAM5320jshPoayl8RtFIN2aAjUuvkdRNyQYJ5dedDqfEvMMAYcIOLLF
        ZRqbyfrIZEg9ajvvVf9PuCH8avalh1Tftywx9ww=
X-Google-Smtp-Source: ABdhPJyvNneNQc3Q1Jh9Pvg9QHDY++By49aodrcmiTZMZRnbLJ3GQvDct4G4YXcrnCYWMdBm6SE65foJ0cMmQxvLKqw=
X-Received: by 2002:a17:90a:dc08:: with SMTP id i8mr3812508pjv.153.1614269916927;
 Thu, 25 Feb 2021 08:18:36 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de> <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
 <YDYPWAtoDpyD9D4Z@gunter> <CAK7LNAQUL4qEgk97z0WfagVDgGAARzj8hqFyrC2wnPjiLduEoQ@mail.gmail.com>
 <cb28abc8-5c4c-90c2-e3f2-a939ff507a8b@prevas.dk> <CAK7LNASv-pWVdztiD1-VCHCnOqZ6j=J6ra5cEdiUkmM9E8fHWQ@mail.gmail.com>
In-Reply-To: <CAK7LNASv-pWVdztiD1-VCHCnOqZ6j=J6ra5cEdiUkmM9E8fHWQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 26 Feb 2021 01:17:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASs11LbPWRnbMG=1nvgWLrqrmWynEYLd9HjAwx5i+WNtA@mail.gmail.com>
Message-ID: <CAK7LNASs11LbPWRnbMG=1nvgWLrqrmWynEYLd9HjAwx5i+WNtA@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=EF=BF=BCMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:49 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Feb 25, 2021 at 4:36 AM Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
> >
> > On 24/02/2021 15.40, Masahiro Yamada wrote:
> > > On Wed, Feb 24, 2021 at 5:33 PM Jessica Yu <jeyu@kernel.org> wrote:
> > >>
> > >> +++ Linus Torvalds [23/02/21 12:03 -0800]:
> > >>> On Tue, Feb 23, 2021 at 12:01 PM Christoph Hellwig <hch@lst.de> wrote:
> > >>>>
> > >>>> Does your build now enable TRIM_UNUSED_KSYMS but previously didn't by
> > >>>> chance?
> > >>>
> > >>> Crossed emails.
> > >>>
> > >>> This is plain "make allmodconfig", so yes, now it will enable TRIM_UNUSED_KSYMS.
> > >>>
> > >>> This is unacceptably slow. If that symbol trimming takes 30% of the
> > >>> whole kernel build time, it needs to be fixed or removed.
> > >>
> > >> [ Adding Masahiro to CC ]
> > >>
> > >> It looks like CONFIG_TRIM_UNUSED_KSYMS had been hiding behind
> > >> CONFIG_UNUSED_SYMBOLS all this time, and once the EXPORT_UNUSED_SYMBOL
> > >> stuff was removed, it exposed that option to be selected by
> > >> allyesconfig. That option had previously caused build issues on
> > >> powerpc on linux-next, so I had temporarily marked that as BROKEN on
> > >> powerpc until Masahiro's fix landed in linux-next. I was not aware of
> > >> the additional build slowdown issue :/ In any case, Christoph's
> > >> suggestion to invert the option sounds reasonable, since the mips
> > >> defconfig selects it, it does not seem totally unused.
>
>
> Good insight.
> Actually, I came up with the same idea last night, and had started
> the implementation background.
> I needed sleep before completing the patch set, but
> now it is working as far as I tested.
>
> BTW,
> KEEP(*(SORT(___ksymtab+foo ___ksymtab+bar ___ksymtab+baz))
> is a syntax error.
>
> KEEP(*(__ksymtab+foo))
> KEEP(*(__ksymtab+bar))
> KEEP(*(__ksymtab+baz))
>
> works.
>
>

Sorry, I missed to CC you.

This patch set.

https://lore.kernel.org/patchwork/project/lkml/list/?series=486545



-- 
Best Regards
Masahiro Yamada
