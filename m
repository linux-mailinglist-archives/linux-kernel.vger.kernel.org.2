Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38013309FD8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 02:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBABIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 20:08:17 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:18854 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBABIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:08:14 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 11117IVa028927;
        Mon, 1 Feb 2021 10:07:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 11117IVa028927
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612141638;
        bh=vAvPxMJka32zGwQcBFPAbW72EOhcATU4gUWaZkEoWnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WaJSuYZCVQneAQSrh7NLHCCUagXin45j/2DsCqlGFag+cXLu8DNZqIPW16lv5w7Yy
         J0N6H/1lqkbOxB6xWRtpJvZLjsSE/zRZpCIK3H4I4BKHlpkAykSivfGC2tT8UgAeOT
         4uM6dKvuph5N7H7jTEW2fVbklWQ3eDQqGgkDX6erhRcmlRK169q18eJ1kX7R1ZcsA+
         hLiRHBjvVoliClG1FQYSIL2wcurT7s1Et866u67MChHYXPY0KZlPmpus/Q3lvl1RdJ
         NTGmFOiSx3o38D55tKom5D9Q03ZMQF0V7lmNSW+Oh4VX29g1BA1BNjOfWK2Q60ZTy7
         Bjs0KOng2BgDA==
X-Nifty-SrcIP: [209.85.210.171]
Received: by mail-pf1-f171.google.com with SMTP id b145so3695074pfb.4;
        Sun, 31 Jan 2021 17:07:18 -0800 (PST)
X-Gm-Message-State: AOAM53307ddgB/b/z7BNppfoIvpDN+1a5tMU0dRhVtT0rxuPqMJKTmWB
        PHvGuJi3i9vpLPJDI19NbsbFRF/ai23Ldld0Z2g=
X-Google-Smtp-Source: ABdhPJw6Rpk4vN6SBU7PD/Zs1zX4ZZgydLT3Jste+n/vaApNsw8VoZaaCcO7bxp7NUmwdYfRR1/0ommo5IW3Kmm81IQ=
X-Received: by 2002:a63:575e:: with SMTP id h30mr14353295pgm.7.1612141637722;
 Sun, 31 Jan 2021 17:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20210129113544.25946-1-noasakurajin@web.de> <87y2gbwa8i.fsf@meer.lwn.net>
In-Reply-To: <87y2gbwa8i.fsf@meer.lwn.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 1 Feb 2021 10:06:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQDxF-HSWQ7FuCkdL4Wy_+iw9D5DJma1Mwixb3t3301+A@mail.gmail.com>
Message-ID: <CAK7LNAQDxF-HSWQ7FuCkdL4Wy_+iw9D5DJma1Mwixb3t3301+A@mail.gmail.com>
Subject: Re: [PATCH] Updates Documentation/Makefile to use Python3 as fallback
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Noa Sakurajin <noasakurajin@web.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 9:15 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Noa Sakurajin <noasakurajin@web.de> writes:
>
> [CC += kbuild maintainers]
>
> >  Before the command python was needed for the documentation to build.
> >  This patch checks if python is available and uses python3 as
> >  fallback.
> >
> >  This is needed because a lot of distribution (at least Ubuntu)
> >  only provide python3 and not python. scripts/sphinx-pre-install
> >  checks for python3 first and does not check if python exists
> >  which causes it to report that everything is installed even
> >  if the documentation build failed.
> >
> > Signed-off-by: Noa Sakurajin <noasakurajin@web.de>
> > ---
> >  Documentation/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 61a7310b49e0..8a4a7df3b74a 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -75,7 +75,8 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
> >        cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media $2 && \
> >       PYTHONDONTWRITEBYTECODE=1 \
> >       BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
> > -     $(PYTHON) $(srctree)/scripts/jobserver-exec \
> > +     PY=$(shell command -v $(PYTHON) 2> /dev/null) \
> > +     $${PY:-"$(PYTHON3)"} $(srctree)/scripts/jobserver-exec \
>
> So I see what you're trying to do, and we definitely want this to work.
> I susped this isn't the right fix, though; it could leave us open to
> similar issues elsewhere in the tree.
>
> Personally, I think that $(PYTHON) should get a working Python if it's
> installed, so I would suggest fixing the top-level Makefile to set it
> correctly.  Masahiro, thoughts on that?
>
> Alternatively, we could just say $(PYTHON3) and explicitly leave Python2
> behind; that needs to happen in the not-too-distant future regardless
> but we haven't decided to actually do it yet.

We are already doing this in linux-next.

I will apply this.
https://lore.kernel.org/patchwork/patch/1373422/




> Thanks,
>
> jon



-- 
Best Regards
Masahiro Yamada
