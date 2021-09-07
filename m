Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF094030D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347975AbhIGWST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:18:19 -0400
Received: from home.keithp.com ([63.227.221.253]:56476 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347442AbhIGWSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:18:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 6C3703F30862;
        Tue,  7 Sep 2021 15:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1631053008; bh=Br10VY+kG8zuQcawYNZJl3wRn99/l3RgCIBZPiuU7xw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HM8VmvvtEqqFay6z5n59LqKR5lIta4crBQk9LySAsoI3XoCaV2rJ5f0DvKYLkF0dN
         eCr2kPccAGkNISi84KOB7KuKaAwd88vQI26e0Mu9xlTtYrNYFtkMOwCzRARzl7ePjs
         lA3ekVD7YhoAOj//1A9A41/lN+4GIRU+m90Zi/i0oe/WKiNyM5y8I/iUgzIQ1BnOgf
         NXwhr1SdHcEB6Nbf14C1YfHzQZkT/oyf2UXJ5fGB9gjYWCtwW22ErYy0Xagcf0Jzs+
         cftpOnozxWFz83t2Wlrf7KbMZQYNC+extkAZ7ggUwdlxuXaJoZFECJTQKUn1l+/q/h
         Ovbp7Q9TFCYRw==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id E0QkPcBHPzq0; Tue,  7 Sep 2021 15:16:48 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id C84AC3F30861;
        Tue,  7 Sep 2021 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1631053007; bh=Br10VY+kG8zuQcawYNZJl3wRn99/l3RgCIBZPiuU7xw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X/qLjToeeHXnAHWF7C4yeW3Qdj8icABU9XqOXhNb93J2pp6LL11pklh0OX6Sxbq7h
         1hQIGSZ6RlRM03h98cmzTjzqtJg3kkMomSIHBEyj/u67v9G46BdUguZWRHpFBEwRLx
         oE1wgtBWQvLrGEmBdh/hRf94fnDMXGt9W5rro/bpK96NYR5P2Ri887P3h6rxDV4l3Z
         hKsGPm6ZTW6rHUusySnYHoEoH74V8LSPfBmqvfh6qZu88+zcGSguW6hfSbMf5mR1d7
         AysSwp5bZl/jmCOdlL6XAqv4eg0iFPJJ5zBvNXkExyrGd3NrBTbq+tQVIVww2gAvFs
         M+2uWxkU0tptA==
Received: by keithp.com (Postfix, from userid 1000)
        id 0A0C21E6011A; Tue,  7 Sep 2021 15:17:10 -0700 (PDT)
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
In-Reply-To: <CAMj1kXHA-GiAj2u4vRbEsnJ6O=cxiNOEgPHWHP+71dB-sp9Nww@mail.gmail.com>
References: <20210902155429.3987201-1-keithp@keithp.com>
 <20210904060908.1310204-1-keithp@keithp.com>
 <20210904060908.1310204-3-keithp@keithp.com>
 <CAMj1kXHHb_d4Exg7_5OdB-Ah=EQxVEUgEv1agUQZg-Rz8pLd5Q@mail.gmail.com>
 <8735qifcy6.fsf@keithp.com>
 <CAMj1kXFQHX-PDQXaRXGNjyJNn_frf9tYNFND06DAYC095JhDbw@mail.gmail.com>
 <874kawcssr.fsf@keithp.com>
 <CAMj1kXHA-GiAj2u4vRbEsnJ6O=cxiNOEgPHWHP+71dB-sp9Nww@mail.gmail.com>
Date:   Tue, 07 Sep 2021 15:17:09 -0700
Message-ID: <87pmtkav4q.fsf@keithp.com>
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

> That is still a bit tricky, given that you now have to swap out the
> per-CPU offset when you migrate a task, and the generic code is not
> really set up for that.

Yeah, I decided to just leverage as much generic code as possible and
re-purposed the TPIDRPRW register for 'current', leaving the
per_cpu_offset data in memory. That makes the patch series pretty
compact, with a bunch of restructuring changes followed by fairly short
functional changes.

> I had a stab at this myself today (long boring day with no Internet conne=
ction).
>
> https://android-kvm.googlesource.com/linux/+log/refs/heads/ardb/arm32-ti-=
in-task
>
> It resembles your code in some places - I suppose we went on the same
> journey in a sense :-) We'll fix up the credits before this gets
> resubmitted.

This does look great, and preserves the optimization of keeping the
per_cpu_offset value in a register.

With the series I posted, getting the per_cpu_offset value requires
fetching the cpu value from task_struct and then using that to index the
per_cpu_offset arrray. I don't have a good feeling of how important this
optimization is? We could stick the per_cpu_offset value into
thread_info to avoid one fetch?

> Fixing the per-task stack protector plugin on top of these changes
> should be trivial but I need a coffee first.

I haven't even looked at that step yet :-)

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmE35OUACgkQ2yIaaQAA
ABGChhAApVwLSfm9sLvgnN+jdEQbOboHxuZF+jmX38rDyBdk9IeY/qp6p9aDGbXu
hrmOqv5vkJ+XRmt6qseKxsFRAGv5DEMttLxLeM+ntRr0VprxMVjF08Zl8QMW1rF6
vbQF08Axbim7hjiChGvnpFhbV1TK1+ByF7DK7jHKVW+C9qXG/Lyuciy3D2Fmmvsz
ZfA6fto4AMrTRnXyXujUYdi4IrCdIats1OB7Kje9AFsgqsOndQZqJQjcBXBUgMUB
cTv/7TsS7P91aSO7PdsL5uEnz0+wBLSgxR561cHU7a8E8qBfhfku3COZTh73Ehul
CKfabvdmAvHfYp4FOeLBoJG99///7ivV2FxiLrASZDuMRsIqG0ZT6mfX+hpF3Nhq
Q2ymLZJ9ySLpIS2Ihh1j6IuKlAfK3746mnJ5/lRGxErn67xCrqjOFCh6S6VhBktO
sN4X3OavBNeoaxMF1J2gNaHXp46NA6PKdNxcm4qg78tqEXYKKWRq5Gw9PZoKRMfQ
a+DCCcKCzcAjOE3zwpAAYY6Udk80l1WGIsUQfN+AslFSbuBFxfBx175LtfVvZHYy
1G5+XtRopD32fmFgXn28qNL3uU5khZfdJDFBQvVaJKC2tWSkUt3/hxj//n79iaki
/NvjmdjqUfXbGHlNXtKoknCnV4frtUa0cJXsdL/aHO79cxlscj0=
=REhG
-----END PGP SIGNATURE-----
--=-=-=--
