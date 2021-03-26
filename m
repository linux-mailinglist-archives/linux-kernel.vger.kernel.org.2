Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2334B0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhCZUsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhCZUsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:48:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C54461A28
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 20:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616791694;
        bh=0rMg/pE0UVImohnWe+m+usj/8tIiLJvFetfjLnR36zE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OBB3AptihC7dO1Ahhzn3cf74jA5caUTRwVbTE2uoowaiRHOHRC1ZA0glFIfNiUy98
         J0kopjkZaMiNjHfumKk4AxOs1lT7dQfmGXTsLOpc4LlEQw/chLwN3iFoKPi9Jk4RMd
         FYqABJiJpwEURZmg4lBE8zcmly1uZ4FAuJwrtZZJQzLEgRW6bFavybKIWy79+a3jMa
         ehjlazw9yw9wTo7iWd43+9lkAtmPD7hF+R5FXZb/aPx7nDu+gecxyVEwFltUj2Dylw
         kctdu1ABroK78J2dwu70dir+3vwr8ddfTOSk1KLe3ZiyEnBcE54HjvmVznHCDbzEt6
         4BzjMSmV+Hs0w==
Received: by mail-ej1-f45.google.com with SMTP id u21so10273356ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 13:48:14 -0700 (PDT)
X-Gm-Message-State: AOAM533x8ar4OYrl/lGsEgY2VyKbpwxPALiWbNyCJZIy2osJlLF2/1YF
        XfxYs3t1+keypgJU2A/XaXKkx4/KJcugCwMNusPAxg==
X-Google-Smtp-Source: ABdhPJzn9R4Rt/42fCkxZBStbARgWDWrTL7wHrtqPxt73PjmPmEVXgbkb+pVFpKboe7miomgDordcil5Agn6+SLIiyI=
X-Received: by 2002:a17:906:a896:: with SMTP id ha22mr17050353ejb.503.1616791692854;
 Fri, 26 Mar 2021 13:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
 <87a6qqi064.fsf@mid.deneb.enyo.de> <CALCETrUM1=Db3vmQAhPkt=SktL7+dtUrt5Ef6BP3T1Q6HY3Bmw@mail.gmail.com>
 <87blb5d7zx.fsf@mid.deneb.enyo.de> <CALCETrUXMnutTV=SEs6ot58j32_5=K5Z=G7_57gVZt_GFcuDiw@mail.gmail.com>
 <877dltd569.fsf@mid.deneb.enyo.de>
In-Reply-To: <877dltd569.fsf@mid.deneb.enyo.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 26 Mar 2021 13:48:01 -0700
X-Gmail-Original-Message-ID: <CALCETrW0jn1j9xO5Q+4y2gf71Ddb0R34KX1dWKAROhxS-yJwSA@mail.gmail.com>
Message-ID: <CALCETrW0jn1j9xO5Q+4y2gf71Ddb0R34KX1dWKAROhxS-yJwSA@mail.gmail.com>
Subject: Re: Why does glibc use AVX-512?
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 1:35 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Andy Lutomirski:
>
> > On Fri, Mar 26, 2021 at 12:34 PM Florian Weimer <fw@deneb.enyo.de> wrot=
e:
> >>   x86: Sporadic failures in tst-cpu-features-cpuinfo
> >>   <https://sourceware.org/bugzilla/show_bug.cgi?id=3D27398#c3>
> >
> > It's worth noting that recent microcode updates have make RTM
> > considerably less likely to actually work on many parts.  It's
> > possible you should just disable it. :(
>
> Sorry, I'm not sure who should disable it.
>
> Let me sum up the situation:
>
> We have a request for a performance enhancement in glibc, so that
> applications can use it on server parts where RTM actually works.
>
> For CPUs that support AVX-512, we may be able to meet that with a
> change that uses the new 256-bit registers, t avoid the %xmm
> transition penalty.  (This is the easy case, hopefully=E2=80=94there shou=
ldn't
> be any frequency issues associated with that, and if the kernel
> doesn't optimize the context switch today, that's a nonissue as well.)

I would make sure that the transition penalty actually works the way
you think it does.  My general experience with the transition
penalties is that the CPU is rather more aggressive about penalizing
you than makes sense.

>
> For CPUs that do not support AVX-512 but support RTM (and AVX2), we
> need a dynamic run-time check whether the string function is invoked
> in a transaction.  In that case, we need to use VZEROALL instead of
> VZEROUPPER.  (It's apparently too costly to issue VZEROALL
> unconditionally.)

So VZEROALL works in a transaction and VZEROUPPER doesn't?  That's bizarre.


> All this needs to work transparently without user intervention.  We
> cannot require firmware upgrades to fix the incorrect RTM reporting
> issue (the bug I referenced).  I think we can require software updates
> which tell glibc when to use RTM-enabled string functions if the
> dynamic selection does not work (either for performance reasons, or
> because of the RTM reporting bug).
>
> I want to avoid a situation where one in eight processes fail to work
> correctly because the CPUID checks ran on CPU 0, where RTM is reported
> as available, and then we trap when executing XTEST on other CPUs.

What kind of system has that problem?  If RTM reports as available,
then it should work in the sense of not trapping.  (There is no
guarantee that transactions will *ever* complete, and that part is no
joke.)
