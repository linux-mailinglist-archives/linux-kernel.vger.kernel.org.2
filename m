Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1663D401662
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 08:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbhIFGV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 02:21:59 -0400
Received: from home.keithp.com ([63.227.221.253]:43312 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhIFGVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 02:21:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id AA3143F307E8;
        Sun,  5 Sep 2021 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630909227; bh=ePE4WVEfrsW5wFsYJEyIJVtKVV4yV85wqkSYHft+rA4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IZbNLEPvASFBS3HZjOdMOl4AXe0U7v6Iqq0zp2l255rLBdml+K17jMu6OGdaC1wJM
         3y5TSb3TBrZVhKkVFhR/S2GgJ30NBLTD6oa0ZkDInYbJLq4raM5ZC9AxXZZt+Vw8qS
         +fTjNLI1RMP0R5sI/tu0f5Ck1PEsDh+Sh9tmX6fQE/SSPocevHoYHux7LVe10ntTye
         GsSdo4SL3pEoAqQQsWkF2Ve/dzGf8rIRBGDNU2gQa6G6PV8XPjZACzxF+fki742lHR
         +Vp3rkpRJ5ZYFo53MiIj3TsXcZl5Wsy7fyH6tAneu5+itHbp4cY3qUysYic/Dn5+tF
         Oo1jPyd7nhY5A==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id JFgHc_d-HxbX; Sun,  5 Sep 2021 23:20:27 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id 408193F307D6;
        Sun,  5 Sep 2021 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630909227; bh=ePE4WVEfrsW5wFsYJEyIJVtKVV4yV85wqkSYHft+rA4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IZbNLEPvASFBS3HZjOdMOl4AXe0U7v6Iqq0zp2l255rLBdml+K17jMu6OGdaC1wJM
         3y5TSb3TBrZVhKkVFhR/S2GgJ30NBLTD6oa0ZkDInYbJLq4raM5ZC9AxXZZt+Vw8qS
         +fTjNLI1RMP0R5sI/tu0f5Ck1PEsDh+Sh9tmX6fQE/SSPocevHoYHux7LVe10ntTye
         GsSdo4SL3pEoAqQQsWkF2Ve/dzGf8rIRBGDNU2gQa6G6PV8XPjZACzxF+fki742lHR
         +Vp3rkpRJ5ZYFo53MiIj3TsXcZl5Wsy7fyH6tAneu5+itHbp4cY3qUysYic/Dn5+tF
         Oo1jPyd7nhY5A==
Received: by keithp.com (Postfix, from userid 1000)
        id 704C21E60119; Sun,  5 Sep 2021 23:20:49 -0700 (PDT)
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
Date:   Sun, 05 Sep 2021 23:20:49 -0700
Message-ID: <87zgsqdy2m.fsf@keithp.com>
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

(sorry, missed a couple of comments, and also neglected to thank you for
your review!)

>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 24804f11302d..1c1ded500a2b 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -128,6 +128,7 @@ config ARM
>>         select RTC_LIB
>>         select SET_FS
>>         select SYS_SUPPORTS_APM_EMULATION
>> +       select THREAD_INFO_IN_TASK if CPU_V7
>
> CPU_V6K also supports this

I've only tested on V7; help getting testing for V6K so we could enable
that as well would be greatly appreciated.

>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index 415c3514573a..71a2ba4549d3 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -284,6 +284,14 @@ stack_protector_prepare: prepare0
>>         $(eval GCC_PLUGINS_CFLAGS +=3D $(SSP_PLUGIN_CFLAGS))
>>  endif
>>
>> +ifdef CONFIG_SMP
>> +prepare: task_cpu_prepare
>> +
>> +PHONY +=3D task_cpu_prepare
>> +task_cpu_prepare: prepare0
>> +       $(eval KBUILD_CFLAGS +=3D -D_TSK_CPU=3D$(shell awk '{if ($$2 =3D=
=3D "TSK_CPU") print $$3;}' include/generated/asm-offsets.h))
>> +endif
>> +
>>  all:   $(notdir $(KBUILD_IMAGE))
>>
>
> This is rather horrid, and removed again in the next patch. Can we
> omit it entirely?

Yeah, this did get rather ugly -- I wanted to use the task_struct in the
raw_smp_processor_id() macro, but discovered that I couldn't include
linux/sched.h in that file.

I found this lovely hack in the powerpc kernel code and just lifted it
from there. In terms of code changes, this one is "smaller" than
including the new per-cpu variable, "cpu_number", but in terms of
ugliness, it's hard to argue which is cleaner.

I was going for fewest logical changes in structure with this patch
instead of cleanest result to try and make it slightly easier to review.

Happy to squash these two patches together if you'd prefer; I initially
wrote the code with the cpu_number variable but then discovered that I
didn't need it if I used the cpu value in the task_struct...

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmE1s0EACgkQ2yIaaQAA
ABEq+Q/8CfHHovIDWJ9LnHSq+/I0OsdtxiiTXtdokT+GhZcQMBdGUT//pv23m2Sg
HJoWdpTmJBcinKnfLE3/7rzpWCBJQfQ0eS/BThBmNrzqRNdaAhY4aR0oH/USrH25
96g0SftryN2ovkRQdTlFKFgyiChTOvdH6uHWUYx0Z1FUmz4/nB9xQpl/69lPLdng
hdXP82g/qsKS4LtuayEUxjvBid6LPVfzT3I4y9Bq5UPdnJFkYH0YVXxpn+3b/24+
QB22JzPYNYHy8KjDET9qS+rMWIibrAEa0UBgV4RIedF+HRz1sb94coXLmZfAb+LX
ODWmuAfS9j9CU0M8dvPMZGRxKK2/CjBq6tM0TbO34JeSTLte8GDNK0s37zIKFFCT
CR1IVL8H8rgDIbyk46GiLz/C4mPLfkx7o3wLjED+L3IsrBlh87DCt7pl76O2QLQE
hkjbL+sssCDkC2C03H0Zh96O5Ixq1Em5GIA5Y5LiPtNgyF9VEX88pLI1d6hE5y5L
P0zSADRxZw7fT3Okd3QEAkFdkbmED4buNGPQsDZ3EZFsRpym/aRgip9xDDpCYNDI
2zMuWX1ylue13v5eLHuyyg+m7SWkfudUOhK8zQQpfgLkL/kPXWFyYcVtm0aemL19
/E391AKEWTYSXQ+VXSj7RZQ/t5l0sXD/WKbW6n+1PkfQM1q35Sk=
=s+T5
-----END PGP SIGNATURE-----
--=-=-=--
