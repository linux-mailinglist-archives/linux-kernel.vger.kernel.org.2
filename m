Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AA8401643
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 08:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbhIFGPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 02:15:22 -0400
Received: from home.keithp.com ([63.227.221.253]:43210 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhIFGPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 02:15:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 86EAF3F307E8;
        Sun,  5 Sep 2021 23:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630908828; bh=nzQzOWzurWPXI3nB4kbriI3K5D3ah45RRHm3ACe7Waw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=vaOfet+uYMffXEWxV3r4g6+YzBofDhX54sdRdPrR+r3xkeKN6cZadhVWo1WJJ7xeD
         88TAeYER/TSzYrkF4Mm21LwnQMtysa82uey18kW5KfieUbgATvplvUbKFYTusGyd00
         eXDF/j0fujASLnlKYG+t375RR6v3YdQ9j+0cNyW6DuQWfBn+izE5LmhodiqBSgOhf5
         fqrJqUrT4xS2pLpjiciG3hFh1fJFLvKvEocMmTfeqQWgJsXcNLGinithxz0chjuD5A
         0/PvvoTZ9XPSweJr1xxlwnfWVD7fONhznQZ+svIgRpkJh88AcT7rqQ4wtd8OpnrBoh
         ZaPaGndBaYVLg==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id bTezPySDxRLX; Sun,  5 Sep 2021 23:13:48 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id C11C73F307D6;
        Sun,  5 Sep 2021 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630908828; bh=nzQzOWzurWPXI3nB4kbriI3K5D3ah45RRHm3ACe7Waw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=vaOfet+uYMffXEWxV3r4g6+YzBofDhX54sdRdPrR+r3xkeKN6cZadhVWo1WJJ7xeD
         88TAeYER/TSzYrkF4Mm21LwnQMtysa82uey18kW5KfieUbgATvplvUbKFYTusGyd00
         eXDF/j0fujASLnlKYG+t375RR6v3YdQ9j+0cNyW6DuQWfBn+izE5LmhodiqBSgOhf5
         fqrJqUrT4xS2pLpjiciG3hFh1fJFLvKvEocMmTfeqQWgJsXcNLGinithxz0chjuD5A
         0/PvvoTZ9XPSweJr1xxlwnfWVD7fONhznQZ+svIgRpkJh88AcT7rqQ4wtd8OpnrBoh
         ZaPaGndBaYVLg==
Received: by keithp.com (Postfix, from userid 1000)
        id 6D1A21E60119; Sun,  5 Sep 2021 23:14:09 -0700 (PDT)
From:   Keith Packard <keithp@keithp.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: Re: [PATCH 2/3] ARM: Move thread_info into task_struct (v7 only)
In-Reply-To: <CAMj1kXHHb_d4Exg7_5OdB-Ah=EQxVEUgEv1agUQZg-Rz8pLd5Q@mail.gmail.com>
References: <20210902155429.3987201-1-keithp@keithp.com>
 <20210904060908.1310204-1-keithp@keithp.com>
 <20210904060908.1310204-3-keithp@keithp.com>
 <CAMj1kXHHb_d4Exg7_5OdB-Ah=EQxVEUgEv1agUQZg-Rz8pLd5Q@mail.gmail.com>
Date:   Sun, 05 Sep 2021 23:14:09 -0700
Message-ID: <8735qifcy6.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ard Biesheuvel <ardb@kernel.org> writes:

> c13 is not a register, it is a value in one of the dimensions of the
> ARM sysreg space, and probably covers other system registers that
> pre-v7 cores do implement.

> Better to use its architectural name (TPIDRPRW) and clarify that
> pre-v6k/v7 cores simply don't implement it.

Thanks, I'll reword the commit message

> Could we split this up?

I could split up the assembler macro changes which add a temporary
register to the calls getting the current thread_info/task_struct value?
If that would help get this reviewed, I'd be happy to do
that. Otherwise, it's pretty much all-or-nothing as enabling
THREAD_INFO_IN_TASK requires a bunch of synchronized changes.

>> +#ifdef CONFIG_THREAD_INFO_IN_TASK
>
> No need for this #ifdef - it only guards macros that will have no
> effect if they are never instantiated (another case below)

Sure, the resulting code is a bit less noisy, which seems good.

>> +DECLARE_PER_CPU(struct task_struct *, current_task);
>> +
>> +static __always_inline struct task_struct *get_current(void)
>> +{
>> +       return raw_cpu_read(current_task);
>
> This needs to run with preemption disabled, or we might get migrated
> to another CPU halfway through, and produce the wrong result (i.e.,
> the current task of the CPU we migrated from). However, it appears
> that manipulating the preempt count will create a circular dependency
> here.

Yeah, I really don't understand the restrictions of this API well. Any
code fetching the current task pointer better not be subject to
preemption or that value will be stale at some point after it was
computed. Do you know if it could ever be run in a context allowing
preemption?
>
> Instead of using a per-CPU variable for current, I think it might be
> better to borrow another system register (TPIDRURO or TPIDRURW) to
> carry 'current' when THREAD_INFO_IN_TASK is in effect, similar to how
> arm64 uses SP_EL0 - those registers could be preserved/restored in the
> entry/exit from/to user space paths rather than in the context switch
> path, and then be used any way we like while running in the kernel.

Making sure these values don't leak through to user space somehow? I'm
not excited by that prospect at all. But, perhaps someone can help me
understand the conditions under which the current task value can be
computed where preemption was enabled and have that not be a problem for
the enclosing code?

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmE1sbEACgkQ2yIaaQAA
ABGusg/9FwN3xd/eIDwhSpWhgmZQsghjqpdH0H9Sjh/+nk4W6N9kRp22bty3b6Sx
thxasQmaf6sgH+ZZA27hWbuoKU8QGBRj+cmjR9kSZWo/ia9C6QsqqvJB4W9Je6WQ
S7wnmUrE2wIvcRsVNyPv1qBhpjoPq5yoCD8TainCrz9+n39QEmb4VL4ptwOpMvQr
bk6iSoKdsv+KlZfOSGN4v4uO47KhMBpoJQQZGDsolBgmqDzKsI2LAqQUhLSt4YLr
bZJkE7OGJ+DMrYCZBFka3P0UaJQC1mTdyv4IPYsLnY5wkNmje1AyfMYqgnjGVNgs
7mlkClXI+yrkBGSW6BHfEzpkAgjql+ZuEMBXY7TFNn0mUMuJ3qspJwwAU4YgFaHZ
lkSp6aOJMCBshBvbbbG7BQ4unNlVhy43iJa9pHfMjeURSxV6dqydxmiQ7w9VjTJq
g4pwRM8n7aoi2+aiPLgnR/Jva0U5JIM9Co4+97JtzbivVsnkLlZB2uC1DQe7VnPZ
fPBg+ZDVYe46CftOjpmeG0Uogu2glKwUyaH3W+GTxXs4gHk6QfKkLZTaa+3FJQZv
ejYsfvTeU/eAoMQeskyOOgvOlbkBxlGLiGUCvsV9pxZR2BwyFlGnTpz9Eq7ZZXG8
S+LacsRFQ87EmnAJBZMgRhL15/I0JOg3ybkYECzv3njVOUv2B2Y=
=1sPs
-----END PGP SIGNATURE-----
--=-=-=--
