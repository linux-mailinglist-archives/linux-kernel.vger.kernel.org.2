Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2803252C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 16:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhBYPvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 10:51:22 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:18607 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhBYPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 10:51:14 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 11PFo4KO025029
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 00:50:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 11PFo4KO025029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614268205;
        bh=EfNUhCf4R+3xK8k7NUCRh0gNVZNKtwuPWzGtwDXWKOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qa8S3NzxOHF6hHbUVZau3hu0tvaub7cilKWGFuOyp+RoxWOUlFljZYjhPshry8DmA
         dCtpTZduPKvb75TiCuBBU6652hQshWEwQqzBcbDb8yxk69R2g2y/iiWXR0tVvqiFg6
         V9khO/FPBqxkxXt1AWhRL9qumD6fEGbG+CoVEBbl9Z0kwGyC5EkAosaaDw4szPyA/d
         ue61gb569PM/wnYoy8IUhz/5S9KyFJylJOTYKFUW/OQCBWCPW91shlH3HCXXOdTqzL
         Fj7DY/y9p3oHpRGdAG/0omGhC+l+tW7EcWHUbxKy/PY0ZJtaR92xqxYkpTgoE8kRaS
         Oo19QtDL2X/Xg==
X-Nifty-SrcIP: [209.85.214.180]
Received: by mail-pl1-f180.google.com with SMTP id u11so3386561plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:50:04 -0800 (PST)
X-Gm-Message-State: AOAM531ZRcQYUqf+U7QoHubzZEebwxx3sKl+5wC216MhT/cKS7/QjaJ0
        CXjDPJP24rEyT+d3zVFwtG/yqmfULtBVBllrXxg=
X-Google-Smtp-Source: ABdhPJx+mKHZd9llpRqPE2+QoBl3ol50VFyOmT1w0voPW7L06qX9XpDH37fAFcMJNb0Q30uPK+wJ5duKyvAcYNr3tbU=
X-Received: by 2002:a17:90a:dc08:: with SMTP id i8mr3700939pjv.153.1614268204142;
 Thu, 25 Feb 2021 07:50:04 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de> <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
 <YDYPWAtoDpyD9D4Z@gunter> <CAK7LNAQUL4qEgk97z0WfagVDgGAARzj8hqFyrC2wnPjiLduEoQ@mail.gmail.com>
 <cb28abc8-5c4c-90c2-e3f2-a939ff507a8b@prevas.dk>
In-Reply-To: <cb28abc8-5c4c-90c2-e3f2-a939ff507a8b@prevas.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 26 Feb 2021 00:49:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASv-pWVdztiD1-VCHCnOqZ6j=J6ra5cEdiUkmM9E8fHWQ@mail.gmail.com>
Message-ID: <CAK7LNASv-pWVdztiD1-VCHCnOqZ6j=J6ra5cEdiUkmM9E8fHWQ@mail.gmail.com>
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

On Thu, Feb 25, 2021 at 4:36 AM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 24/02/2021 15.40, Masahiro Yamada wrote:
> > On Wed, Feb 24, 2021 at 5:33 PM Jessica Yu <jeyu@kernel.org> wrote:
> >>
> >> +++ Linus Torvalds [23/02/21 12:03 -0800]:
> >>> On Tue, Feb 23, 2021 at 12:01 PM Christoph Hellwig <hch@lst.de> wrote:
> >>>>
> >>>> Does your build now enable TRIM_UNUSED_KSYMS but previously didn't by
> >>>> chance?
> >>>
> >>> Crossed emails.
> >>>
> >>> This is plain "make allmodconfig", so yes, now it will enable TRIM_UNUSED_KSYMS.
> >>>
> >>> This is unacceptably slow. If that symbol trimming takes 30% of the
> >>> whole kernel build time, it needs to be fixed or removed.
> >>
> >> [ Adding Masahiro to CC ]
> >>
> >> It looks like CONFIG_TRIM_UNUSED_KSYMS had been hiding behind
> >> CONFIG_UNUSED_SYMBOLS all this time, and once the EXPORT_UNUSED_SYMBOL
> >> stuff was removed, it exposed that option to be selected by
> >> allyesconfig. That option had previously caused build issues on
> >> powerpc on linux-next, so I had temporarily marked that as BROKEN on
> >> powerpc until Masahiro's fix landed in linux-next. I was not aware of
> >> the additional build slowdown issue :/ In any case, Christoph's
> >> suggestion to invert the option sounds reasonable, since the mips
> >> defconfig selects it, it does not seem totally unused.


Good insight.
Actually, I came up with the same idea last night, and had started
the implementation background.
I needed sleep before completing the patch set, but
now it is working as far as I tested.

BTW,
KEEP(*(SORT(___ksymtab+foo ___ksymtab+bar ___ksymtab+baz))
is a syntax error.

KEEP(*(__ksymtab+foo))
KEEP(*(__ksymtab+bar))
KEEP(*(__ksymtab+baz))

works.





> >
> > TRIM_UNUSED_KSYMS builds the tree twice by its concept.
> >
> > [1] 1st build
> >       At this point of time, we do not know  which EXPORT_SYMBOL()
> >       is needed. So, EXPORT_SYMBOL() is enabled, or noop'ed
> >       based on the temporal guess.
> >       (in the fresh build, EXPORT_SYMBOL() are all nooped.)
> >
> > [2]  Get the list of symbols needed to resolve all symbol references.
> >      (this information is collected in include/generated/autoksyms.h)
> >
> > [3] 2nd build
> >      Rebuild the objects whose EXPORT_SYMBOL()
> >      must be flipped.
>
> I'm thinking we should be able to generate a linker script snippet from
> [2] and use that when linking vmlinux, so there's no recursion and no
> rebuild of individual .o files (and all the __cond_export_sym trickery
> goes away).
>
> The ksymtab entry for foo is already emitted in its own ___ksymtab+foo
> section (or ___ksymtab_gpl+foo). So if the sorted list of undefined
> symbols listed in the .mod files (plus the whitelist) consist of foo,
> bar and baz, generate a header to be included by vmlinux.lds.h that says
>
> #define KSYMTAB_SECTIONS \
>   ___ksymtab+foo \
>   ___ksymtab+bar \
>   ___ksymtab+baz \
>
> #define KSYMTAB_GPL_SECTIONS \
>   ___ksymtab_gpl+foo \
>   ___ksymtab_gpl+bar \
>   ___ksymtab_gpl+baz \
>
> with a !CONFIG_TRIM_UNUSED_KSYMS definition of these that just says
>
> #define KSYMTAB_SECTIONS ___ksymtab+*
> #define KSYMTAB_GPL_SECTIONS ___ksymtab_gpl+*
>
> and use that
>
> __ksymtab    AT(ADDR(__ksymtab) - LOAD_OFFSET) {                \
>         __start___ksymtab = .;                                  \
>         KEEP(*(SORT(KSYMTAB_SECTIONS)))                         \
>         __stop___ksymtab = .;                                   \
>
> Only one of ___ksymtab+foo and ___ksymtab_gpl+foo will exist, but that
> doesn't matter (it's really no different from the fact that many files
> (i.e. the * before "(SORT") don't contain any section matching
> ___ksymtab_gpl+*).
>
> We may then have to add another discard section to put the remaining
> ___ksymtab_gpl+* sections in, but that's fine as long as that stanza
> just appears later in the linker script.
>
> If LD_DEAD_CODE_DATA_ELIMINATION was more widely supported (and I was
> surprised to see that it's not even available on arm or x86) one could
> also play another game, dropping the KEEP()s and instead create a linker
> script snippet containing EXTERN(__ksymtab_foo __ksymtab_bar ...),
> referencing the "struct kernel_symbol" elements themselves rather than
> the singleton sections they reside in.

Do you mean LD_DEAD_CODE_DATA_ELIMINATION must be enabled by default
to do this?



>
> Rasmus



-- 
Best Regards
Masahiro Yamada
