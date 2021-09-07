Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD9A402BB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbhIGPZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:25:47 -0400
Received: from home.keithp.com ([63.227.221.253]:52898 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344974AbhIGPZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:25:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 9E6CB3F30862;
        Tue,  7 Sep 2021 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1631028255; bh=t7VcNGzEjGyV50+1Ty0iiMDwzQyzAK8kFK85FlnpD+A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dDN+Ipk0CqpqNc1QWuC89K5w37dnf4YFJhi/Sf5i+tMFyUHhfWTjfFSdkW/9v0hfD
         7/QkMU5Gn+CSLCOS1MIOHtBFjJWErPmm2hAeevhTBqiveNSZLuKcbng2q5st+uZiV/
         4UCVNT3Lj2p12ezWFGYFqcGhyB8K83ebqeVm+cMjafma4rslTJN5w9n5ltYJpvyGdx
         jVsTbTUCks0GlPA7IVgc8xCmmXJUEXCmHTrfDZUlc7lhBrLOlbIxFxLpGVCLQ9u8ik
         Wt9Y8AyjWBXj1bRGmB1vmq38e3/kombzcKoULWBvBjaki10res0ssh2rpMpuVg5yxv
         1a9+QFsQVhbcQ==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id SnOz81A0WPec; Tue,  7 Sep 2021 08:24:15 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id 0E7C03F30861;
        Tue,  7 Sep 2021 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1631028255; bh=t7VcNGzEjGyV50+1Ty0iiMDwzQyzAK8kFK85FlnpD+A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dDN+Ipk0CqpqNc1QWuC89K5w37dnf4YFJhi/Sf5i+tMFyUHhfWTjfFSdkW/9v0hfD
         7/QkMU5Gn+CSLCOS1MIOHtBFjJWErPmm2hAeevhTBqiveNSZLuKcbng2q5st+uZiV/
         4UCVNT3Lj2p12ezWFGYFqcGhyB8K83ebqeVm+cMjafma4rslTJN5w9n5ltYJpvyGdx
         jVsTbTUCks0GlPA7IVgc8xCmmXJUEXCmHTrfDZUlc7lhBrLOlbIxFxLpGVCLQ9u8ik
         Wt9Y8AyjWBXj1bRGmB1vmq38e3/kombzcKoULWBvBjaki10res0ssh2rpMpuVg5yxv
         1a9+QFsQVhbcQ==
Received: by keithp.com (Postfix, from userid 1000)
        id 41E161E6011A; Tue,  7 Sep 2021 08:24:37 -0700 (PDT)
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
In-Reply-To: <CAMj1kXFQHX-PDQXaRXGNjyJNn_frf9tYNFND06DAYC095JhDbw@mail.gmail.com>
References: <20210902155429.3987201-1-keithp@keithp.com>
 <20210904060908.1310204-1-keithp@keithp.com>
 <20210904060908.1310204-3-keithp@keithp.com>
 <CAMj1kXHHb_d4Exg7_5OdB-Ah=EQxVEUgEv1agUQZg-Rz8pLd5Q@mail.gmail.com>
 <8735qifcy6.fsf@keithp.com>
 <CAMj1kXFQHX-PDQXaRXGNjyJNn_frf9tYNFND06DAYC095JhDbw@mail.gmail.com>
Date:   Tue, 07 Sep 2021 08:24:36 -0700
Message-ID: <874kawcssr.fsf@keithp.com>
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

> Sure, so it is precisely for that reason that it is better to isolate
> changes that can be isolated.

I'll go ahead and split this apart then; that is how I did development,
after all.

> All the time. 'current' essentially never changes value from the POV
> of code running in task context, so there is usually no reason to care
> about preemption/migration when referring to it. Using per-CPU
> variables is what creates the problem here.

Thanks for helping me -- I just got the wrong model stuck in my head
over the weekend somehow.

If I do have this figured out, we should be able to stick the
per_cpu_offset value in thread_info and use TPIDRPRW to hold 'current'
as code using per_cpu_offset should already be disabling
preemption. That should be an easier change than putting a kernel
pointer in a user-visible register.

> Given that we are already relying on the MP extensions for this
> anyway, I personally think that using another thread ID register to
> carry 'current' is a reasonable approach as well, since it would also
> allow us to get per-task stack protector support into the compiler.
> But I would like to hear from some other folks on cc as well.

That would be awesome; I assume that doesn't require leaving
per_cpu_offset in a thread ID register?

In any case, I'll give my plan a try, and then see about trying your
plan as well so I can compare the complexity of the two solutions.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmE3hDQACgkQ2yIaaQAA
ABHLnA//Sc5ObmHK4dcNs4U8k7OGPZwDv30LRorWZBK/HsQq3sJ+uMLoZIbzbI9m
2vKnCfMq6iBV9AONCNHly8yKdIasV/a5my0OoJlo8O+W5eOSw8MvXLVqonAVNdtd
dHe8kuzxZDOfKIsyRzmKE8r+di9USUsRonzTHqjkMIxBXee6jmGnf4hE326ljKjy
dDxouABLVvStdNuB4mM6u/hRs327LSAvqzLjr6qNxi1ueUj1MdDryzieNpAD4HEQ
1jE7a/Tl5ZYf2xe2dUwPlvpem475PDxC3OqF4xRPzkNqgVs+S1OUuCsOn4aIcmdp
EC0GThXyZ02nsS8bJpyRNdBbUWoTUpNBYEF3Eg8X/u8ZIXpcgIBVXcnGmcmeNh+r
AjM3e0b1Oet3uI5GJLbbJVj/DoZsIYPOHK14xNZAWc+kiVJ+g8pZs6Js0g82sX3g
vqa8uxdSQTrfFM1yKczqQU7FoNzVTHooqPQ26qUISG44zvL9Isj47XsQwki0YcYh
MhwB/CsZQDobhk2xAiZFd0+IOU1QL7zmcn6YUtvz2zn23n7O52DdSm6hINE6yZDK
8rBRuc3kM1pczrn80qrP9WVEiK32VrwdVogIG5A2Wt1S74T8KIkDE4H7fx2vlkIl
HfSbc2g063aHdheaVwR7M+mWoGI8RczaJkdQEbvT4p8Awn/esiA=
=shtJ
-----END PGP SIGNATURE-----
--=-=-=--
