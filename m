Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5E3255B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhBYSlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:41:06 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:55149 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhBYSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:39:28 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 11PIc4Jv028517
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 03:38:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 11PIc4Jv028517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614278285;
        bh=Z8+kqUseSqK3HMya4Ci/I24by2e0cUeHUUPO5SCqTSk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xu0mkMB1L98ZYI8HPHpra+xQjSZMMALM2zMY2EM+TBEZ8oUU0t/0HFYjOqYtUu3Qb
         4LYRN2wk2SCZTVhgpvGupFywdeG80Oav5eKb5ZKOFLGcPBHYs/j3fnTJA8y2OEVIuX
         gQMBdRCi7OxekdNhCcnPh9bq2y+V2wPpd20wEtez1qg8RRG1+JftWhVv5j1kARLUwM
         zeQGsRB4x9scgAe9tzkSBPpSIzi7Npf+9Ov21vAQFW4U87c0qhu5iWvfsh5N4krKp3
         yIe7Bj3njusLBa5DDnv/wqYwY3HvpBf3/FbwiTSQYrSd1ZfbkB42wqRM5HXG20EvED
         f5VXjwW+lawBQ==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id o6so4074508pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:38:04 -0800 (PST)
X-Gm-Message-State: AOAM530mIpsI25exhyYB+IyRqNELErjBLcgYW2LWLoo1/3fozn6sWSQu
        quH79HdJHa54T2qgxbaCbPw+luqps2g3eVmSZYw=
X-Google-Smtp-Source: ABdhPJypt+UAufMFvAvVHTnV38C4hEfOkSolIyhRkHkxcm9pXO70Ta7cV+/G4X+4aON4slEv4CPJ0qp6I7p0A2hPPx0=
X-Received: by 2002:a17:90a:5510:: with SMTP id b16mr4584900pji.87.1614278284075;
 Thu, 25 Feb 2021 10:38:04 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de> <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
 <YDYPWAtoDpyD9D4Z@gunter> <CAK7LNAQUL4qEgk97z0WfagVDgGAARzj8hqFyrC2wnPjiLduEoQ@mail.gmail.com>
 <cb28abc8-5c4c-90c2-e3f2-a939ff507a8b@prevas.dk> <CAK7LNASv-pWVdztiD1-VCHCnOqZ6j=J6ra5cEdiUkmM9E8fHWQ@mail.gmail.com>
 <a2d84bf6-f753-92f6-7613-38391e65af85@prevas.dk>
In-Reply-To: <a2d84bf6-f753-92f6-7613-38391e65af85@prevas.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 26 Feb 2021 03:37:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNATsQ9mnV-5z04fCK=wMw+eXCyVLruCq3too_oqw3YMK+Q@mail.gmail.com>
Message-ID: <CAK7LNATsQ9mnV-5z04fCK=wMw+eXCyVLruCq3too_oqw3YMK+Q@mail.gmail.com>
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

On Fri, Feb 26, 2021 at 1:19 AM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 25/02/2021 16.49, Masahiro Yamada wrote:
> > On Thu, Feb 25, 2021 at 4:36 AM Rasmus Villemoes
> > <rasmus.villemoes@prevas.dk> wrote:
> >>
> >> On 24/02/2021 15.40, Masahiro Yamada wrote:
> >
> >
> > Good insight.
> > Actually, I came up with the same idea last night, and had started
> > the implementation background.
> > I needed sleep before completing the patch set, but
> > now it is working as far as I tested.
> >
> > BTW,
> > KEEP(*(SORT(___ksymtab+foo ___ksymtab+bar ___ksymtab+baz))
> > is a syntax error.
> >
>
> ah, ok, didn't test anything, just threw it out there in case somebody
> wanted to see if it was doable.
>
> Is that a limitation of SORT? The ld docs say
>
>    There are two ways to include more than one section:
>      *(.text .rdata)
>      *(.text) *(.rdata)
> The difference between these is the order in which the '.text' and
> '.rdata' input sections will appear in the output section.
>
> so there shouldn't be a problem mentioning more than one section name?


    KEEP(*(foo bar))
and
    SORT(*(foo bar))

are both syntax error.


I think having multiple entries in KEEP() / SORT()
is sensible, but unfortunately the linker rejects this form.



> >> If LD_DEAD_CODE_DATA_ELIMINATION was more widely supported (and I was
> >> surprised to see that it's not even available on arm or x86) one could
> >> also play another game, dropping the KEEP()s and instead create a linker
> >> script snippet containing EXTERN(__ksymtab_foo __ksymtab_bar ...),
> >> referencing the "struct kernel_symbol" elements themselves rather than
> >> the singleton sections they reside in.
> >
> > Do you mean LD_DEAD_CODE_DATA_ELIMINATION must be enabled by default
> > to do this?
> >
>
> No, but without LD_DEAD_CODE_DATA_ELIMINATION, I don't see much point of
> the TRIM_UNUSED_KSYMS. Yes, the export_symbol metadata itself vanishes,
> but the actual functions remain in the image. Conversely, with modules
> enabled, LD_DEAD_CODE_DATA_ELIMINATION can't do much when almost all of
> the kernel can be built modular so almost extern interface is an
> EXPORT_SYMBOL. At least, that's what I see for a ppc target with a
> somewhat trimmed-down .config, combining the two gives much more space
> saving than the sum of what each option does:
>
> $ size vmlinux.{vanilla,trim,dead,trim-dead}
>    text    data     bss     dec     hex filename
> 6197380 1159488  121732 7478600  721d48 vmlinux.vanilla
> 6045906 1159440  121732 7327078  6fcd66 vmlinux.trim
> 6087316 1137284  120476 7345076  7013b4 vmlinux.dead
> 5675370 1101964  115180 6892514  692be2 vmlinux.trim-dead
>
> Anyway, that was just an aside, probably the above ___ksymtab+foo thing
> will work just fine.
>
> Rasmus


Make sense.

The combination of LD_DEAD_CODE_DATA_ELIMINATION and
TRIM_UNUSED_KSYMS is more powerful than
the stand-alone use of TRIM_UNUSED_KSYMS.


I just expected the combination of LTO and TRIM_UNUSED_KSYMS
would be even more powerful...

Unfortunately, Clang LTO which lands in this MW
cannot trim any code. So, it is useless for the
purpose of eliminating unreachable code.



--
Best Regards
Masahiro Yamada
