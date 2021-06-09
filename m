Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8283A0D57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhFIHOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:14:37 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:46898 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhFIHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:14:36 -0400
Received: by mail-pf1-f181.google.com with SMTP id u126so13725172pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KDN/Y4NVTR4ONCwZelyjSq2F6Y9RLnw1vkdnl5IlqRs=;
        b=KPxT3dD2Xv5hQ/9Vzr/W5NCK2tV9xqbduw/dMDvLVKZqd2HhHoHhHjegmaJIpWGejS
         omInBCkhJ7eKs4JoCUV5p6jyhyiY2IF2aGu+ap8ihYe57MXJK8/2e+9pTokHTwze6vMb
         D3UFQF67vY2raQmjyYGI083bkGZ3YqW0agp3lrBjG5nLwOmv/RNWSBwImjePSmaljvDz
         L7d619extVGDWfQElHka2Yc2nUORel59OjLsi7tiwvA7eAxRyJIJhsFZN0I69fHJseJE
         /PvM4sv8mfjiNVROnmfzVps4P7MFoAP/nR1Mxt3RY1k/3H8kVqwdEj/+GHzhERFd0/c1
         Q+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KDN/Y4NVTR4ONCwZelyjSq2F6Y9RLnw1vkdnl5IlqRs=;
        b=aV+52JZpkxy3f2EgF0nGrcJkgfKu9/pXG2ye7BG6J1YoY6NgjA8RpE0ffxMthmQziF
         O2HBTGMe163Hn4F4F3pTaE7NH+5vIY5BQXHjAWDaZkm7MJnKQyZ3LDIBwI2ynbMDCNxi
         yWqT+bKCiPOdqVRLhJ1RxW7p1W+j/6aqSzodchK6hQSPfwrs3gzNhRYxZxhjYduGkllN
         LZAvWlZHek2pvgTyXyyCweVBRtZ0eaeM4tFm37wIlbIX0kna912yMMaOwcTB8xPoGnXo
         JYzADEplU6OfCCyngNBxRQHN6wh3MsHxXFnVBQ295RbQp5vTlshDQGSivCp63+0aPBVF
         uZmQ==
X-Gm-Message-State: AOAM531Fik+VSBK5WLgSQgYAonQaZH/2rl5CjhnC7gvb2B1ooMA9v4oT
        Bw+3hGvP6Wg5TUKTjc64PHj5zjuR2WVL9w0o9qVlhw==
X-Google-Smtp-Source: ABdhPJwu5BwmwD40gkRV31J10HDXDnRxG4qw/R5s/Xkkq54Nr4KxJBF7YPI2dUu3/tmXWXSWLNaORFLYhcfD+fAQbY4=
X-Received: by 2002:a62:7cca:0:b029:2e9:c89d:d8a9 with SMTP id
 x193-20020a627cca0000b02902e9c89dd8a9mr3899409pfc.55.1623222689831; Wed, 09
 Jun 2021 00:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210604235046.w3hazgcpsg4oefex@google.com> <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net> <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
 <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net> <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
 <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org> <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
 <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org> <YL+0MO/1Ra1tnzhT@hirez.programming.kicks-ass.net>
 <5dd58dce-c3a7-39e5-8959-b858de95b72c@kernel.org>
In-Reply-To: <5dd58dce-c3a7-39e5-8959-b858de95b72c@kernel.org>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Wed, 9 Jun 2021 09:11:18 +0200
Message-ID: <CAFJ_xbp5YzYNQWEJLDySyC_bWUsirq=P03k8HHW=B4sH0V_uUg@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 8 cze 2021 o 20:49 Nathan Chancellor <nathan@kernel.org> napisa=C5=82(=
a):
>
> On 6/8/2021 11:17 AM, Peter Zijlstra wrote:
> > On Tue, Jun 08, 2021 at 10:29:56AM -0700, Nathan Chancellor wrote:
> >> Unfortunately, this is the VM provided by the Windows Subsystem for Li=
nux so
> >> examining it is nigh-impossible :/ I am considering bisecting the tran=
sforms
> >> that objtool does to try and figure out the one that causes the machin=
e to
> >> fail to boot or try to reproduce in a different hypervisor, unless you=
 have
> >> any other ideas.
> >
> > Does breaking Windows earn points similar to breaking the binary
> > drivers? :-) :-)
>
> :)
>
> > The below should kill this latest transform and would quickly confirm i=
f
> > the that is causing your problem. If that's not it, what was your last
> > known working version?
>
> Yes, that diff gets me back to booting. I will see if I can figure out
> the exact rewrite that blows everything up.
>
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index e5947fbb9e7a..d0f231b9c5a1 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -1857,10 +1857,10 @@ static int decode_sections(struct objtool_file =
*file)
> >        * Must be after add_special_section_alts(), since this will emit
> >        * alternatives. Must be after add_{jump,call}_destination(), sin=
ce
> >        * those create the call insn lists.
> > -      */
> >       ret =3D arch_rewrite_retpolines(file);
> >       if (ret)
> >               return ret;
> > +      */
> >
> >       return 0;
> >   }
> >
>
> Cheers,
> Nathan

Hi Peter,

I'm sorry I was on vacation last week - do you still need the requested deb=
ugs?

Best regards,
Lukasz
