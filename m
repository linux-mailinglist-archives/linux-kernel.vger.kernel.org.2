Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7DC3240B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhBXPVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:21:54 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:37774 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhBXOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:42:44 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 11OEfEA4016787
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:41:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 11OEfEA4016787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614177675;
        bh=nBJFqzrN6jnQUKlC2pIdB9ZwCwmrDFNMpBpnfM4zvvA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B9zAzzj+592w4RSX2PDyezmJR3MYP9ex4U/Kn9mO9PHS6FOCgG99/3Fy8ooasUrsl
         cMATAAf+TNB9kJFirvdacMB+ihzTJAry3Gvhvi7htzv2UDCKvUi38NHbPJ2CM8QEZz
         TAksW5orabYSfMxMRNJmb05UXw7oi5e47G9n6Y4AJtYFB+ZtMYxxRdLTZevue6R+Wu
         FIFY7b5M77UeIkb8xXs9yFHMZ7wJzCyBdVWmtkF7CikQkOaKF8PrUBF4h31dsuvU45
         ZdegMpk9ZinzUq933XG7LUcEKpw6NfskZDH2bL7k0wFo4rH9CBHVaB4vCSyaNpsrfz
         ftrgBrghLTrJw==
X-Nifty-SrcIP: [209.85.216.42]
Received: by mail-pj1-f42.google.com with SMTP id s23so1469344pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:41:15 -0800 (PST)
X-Gm-Message-State: AOAM533+EGAt/BroTSxMzWLhvkind+HeLXZ3+qo3asjFprGMOXaiTI+F
        a9vnGTQPD8qL5rWar1oXUQgH0tRFiblQac8IaBo=
X-Google-Smtp-Source: ABdhPJwb3YvEeS+B60K4e+G4qZWDAGU+9jNTWWSK/B7iMpPEZTsMFD7zwa90TLR/3FFMoKvXHfR59Qla4POxtpPbKBY=
X-Received: by 2002:a17:90a:bc8e:: with SMTP id x14mr4612742pjr.153.1614177674458;
 Wed, 24 Feb 2021 06:41:14 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de> <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
 <YDYPWAtoDpyD9D4Z@gunter>
In-Reply-To: <YDYPWAtoDpyD9D4Z@gunter>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 24 Feb 2021 23:40:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUL4qEgk97z0WfagVDgGAARzj8hqFyrC2wnPjiLduEoQ@mail.gmail.com>
Message-ID: <CAK7LNAQUL4qEgk97z0WfagVDgGAARzj8hqFyrC2wnPjiLduEoQ@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=EF=BF=BCMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 5:33 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Linus Torvalds [23/02/21 12:03 -0800]:
> >On Tue, Feb 23, 2021 at 12:01 PM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> Does your build now enable TRIM_UNUSED_KSYMS but previously didn't by
> >> chance?
> >
> >Crossed emails.
> >
> >This is plain "make allmodconfig", so yes, now it will enable TRIM_UNUSED_KSYMS.
> >
> >This is unacceptably slow. If that symbol trimming takes 30% of the
> >whole kernel build time, it needs to be fixed or removed.
>
> [ Adding Masahiro to CC ]
>
> It looks like CONFIG_TRIM_UNUSED_KSYMS had been hiding behind
> CONFIG_UNUSED_SYMBOLS all this time, and once the EXPORT_UNUSED_SYMBOL
> stuff was removed, it exposed that option to be selected by
> allyesconfig. That option had previously caused build issues on
> powerpc on linux-next, so I had temporarily marked that as BROKEN on
> powerpc until Masahiro's fix landed in linux-next. I was not aware of
> the additional build slowdown issue :/ In any case, Christoph's
> suggestion to invert the option sounds reasonable, since the mips
> defconfig selects it, it does not seem totally unused.


TRIM_UNUSED_KSYMS builds the tree twice by its concept.

[1] 1st build
      At this point of time, we do not know  which EXPORT_SYMBOL()
      is needed. So, EXPORT_SYMBOL() is enabled, or noop'ed
      based on the temporal guess.
      (in the fresh build, EXPORT_SYMBOL() are all nooped.)

[2]  Get the list of symbols needed to resolve all symbol references.
     (this information is collected in include/generated/autoksyms.h)

[3] 2nd build
     Rebuild the objects whose EXPORT_SYMBOL()
     must be flipped.


The build system cleverly tracks which object needs rebuild.
So, building the tree twice does not mean
the build cost is twice.
But, 30% increase is reasonable.


In my understanding, TRIM_UNUSED_KSYMS is used
by Android.  (Generic Kernel Image)
So, we should revive it.






--
Best Regards
Masahiro Yamada
