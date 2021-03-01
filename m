Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47A53275B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 02:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhCABMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 20:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhCABMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 20:12:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBD4C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 17:11:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso1569523pjk.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 17:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=lt0oVa4TTqOxC4dz7vJKEQu8Xc7A+35tptwF7QqK3/k=;
        b=m0FkE2krnamYFeX1Pti0Fl1Ein+4gSp9e9e/va840QQyrijFm1iLewX6PGXF9ibg8n
         s3GMnM4wODiOLo9FGyv8WP7YT9ws4Nz/G4WLQek+pg9mpQmaHCH7hRoPFQmI6rZI9AR2
         XGdnUYLaSS2E8CeGEeAoxUG9Q5dAGN1ID+Kx2mRbGr2HMlvLZez5AEqF7TOB9MoUbmZu
         BK6iZm6XLsCcCkDH1nRsy6uWEewKtVpFd/zXtYvEhc7RgDRoNXv/MGp5/9CXfMSuHTTf
         UMU8sEdAsEdkjekgqoyNXscD00gPQ36O1F03EZic5KRdL7TYgxbgLTwpBCP/6+tUObFu
         PlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=lt0oVa4TTqOxC4dz7vJKEQu8Xc7A+35tptwF7QqK3/k=;
        b=kh+kVQ91V88YB5k8MTw+rWLDjzQftMFootByaWZE/wuUAPHIohJ2UJ8eHYu/8guZ2y
         MbOXKUO7mUVe0qrtEhAkcUSxCaH4nvn7EYC1tClFZ7G3lj/UnKu9yPFJ7dfSNVE0UW2q
         /wAD229gZ1P2e32E03P31UpyrQkyIKCzxhNAfXyo6DHhu+GF/vUTUA5V/R+z1zmAKzSv
         8lXWFhegfc5hkWvjcec8wZL/Bdoh5K4wKbhOsBMFmvyYrB4Rsq7KYs0v/xii+Dqvjn44
         cdBQsiEhVGlpmAKL/dktATImrHbmTjA9uRFTCiKO1DvEnAo2yFhq5vyXbEQ7iKBm0rNf
         2SCg==
X-Gm-Message-State: AOAM530LmC8mf6naIgAbTG6J/twXjc9nWiUrPNP4jDndt60TZJttxH2H
        Y/wrcYaebO+aXB4ds1AO98E=
X-Google-Smtp-Source: ABdhPJzRbhBimuqvZNSXpcezQzmyQzJVRzPgweHg3FMIK4k3Dxf5yo6rME5JvUFz6xZ8Qyts9jDNTg==
X-Received: by 2002:a17:90a:16d7:: with SMTP id y23mr15152020pje.227.1614561088230;
        Sun, 28 Feb 2021 17:11:28 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id c15sm14911942pfj.170.2021.02.28.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 17:11:27 -0800 (PST)
Date:   Mon, 01 Mar 2021 11:11:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Arnd Bergmann <arnd@kernel.org>, Fangrui Song <maskray@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Nicolas Pitre <nico@fluxnic.net>
References: <20210225112122.2198845-1-arnd@kernel.org>
        <20210226211323.arkvjnr4hifxapqu@google.com>
        <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com>
In-Reply-To: <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1614559739.p25z5x88wl.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Arnd Bergmann's message of February 27, 2021 7:49 pm:
> On Fri, Feb 26, 2021 at 10:13 PM 'Fangrui Song' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
>>
>> For folks who are interested in --gc-sections on metadata sections,
>> I want to bring you awareness of the implication of __start_/__stop_ sym=
bols and C identifier name sections.
>> You can see https://github.com/ClangBuiltLinux/linux/issues/1307 for a s=
ummary.
>> (Its linked blog article has some examples.)
>>
>> In the kernel linker scripts, most C identifier name sections begin with=
 double-underscore __.
>> Some are surrounded by `KEEP(...)`, some are not.
>>
>> * A `KEEP` keyword has GC root semantics and makes ld --gc-sections inef=
fectful.
>> * Without `KEEP`, __start_/__stop_ references from a live input section
>>    can unnecessarily retain all the associated C identifier name input
>>    sections. The new ld.lld option `-z start-stop-gc` can defeat this ru=
le.
>>
>> As an example, a __start___jump_table reference from a live section
>> causes all `__jump_table` input section to be retained, even if you
>> change `KEEP(__jump_table)` to `(__jump_table)`.
>> (If you change the symbol name from `__start_${section}` to something
>> else (e.g. `__start${section}`), the rule will not apply.)
>=20
> I suspect the __start_* symbols are cargo-culted by many developers
> copying stuff around between kernel linker scripts, that's certainly how =
I
> approach making changes to it normally without a deeper understanding
> of how the linker actually works or what the different bits of syntax mea=
n
> there.
>=20
> I see the original vmlinux.lds linker script showed up in linux-2.1.23, a=
nd
> it contained
>=20
> +  . =3D ALIGN(16);               /* Exception table */
> +  __start___ex_table =3D .;
> +  __ex_table : { *(__ex_table) }
> +  __stop___ex_table =3D .;
> +
> +  __start___ksymtab =3D .;       /* Kernel symbol table */
> +  __ksymtab : { *(__ksymtab) }
> +  __stop___ksymtab =3D .;
>=20
> originally for arch/sparc, and shortly afterwards for i386. The magic
> __ex_table section was first used in linux-2.1.7 without a linker
> script. It's probably a good idea to try cleaning these up by using
> non-magic start/stop symbols for all sections, and relying on KEEP()
> instead where needed.
>=20
>> There are a lot of KEEP usage. Perhaps some can be dropped to facilitate
>> ld --gc-sections.
>=20
> I see a lot of these were added by Nick Piggin (added to Cc) in this comm=
it:
>=20
> commit 266ff2a8f51f02b429a987d87634697eb0d01d6a
> Author: Nicholas Piggin <npiggin@gmail.com>
> Date:   Wed May 9 22:59:58 2018 +1000
>=20
>     kbuild: Fix asm-generic/vmlinux.lds.h for LD_DEAD_CODE_DATA_ELIMINATI=
ON
>=20
>     KEEP more tables, and add the function/data section wildcard to more
>     section selections.
>=20
>     This is a little ad-hoc at the moment, but kernel code should be move=
d
>     to consistently use .text..x (note: double dots) for explicit section=
s
>     and all references to it in the linker script can be made with
>     TEXT_MAIN, and similarly for other sections.
>=20
>     For now, let's see if major architectures move to enabling this optio=
n
>     then we can do some refactoring passes. Otherwise if it remains unuse=
d
>     or superseded by LTO, this may not be required.
>=20
>     Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>     Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>=20
> which apparently was intentionally cautious.
>=20
> Unlike what Nick expected in his submission, I now think the annotations
> will be needed for LTO just like they are for --gc-sections.

Yeah I wasn't sure exactly what LTO looks like or how it would work.
I thought perhaps LTO might be able to find dead code with circular /=20
back references, we could put references from the code back to these=20
tables or something so they would be kept without KEEP. I don't know, I=20
was handwaving!

I managed to get powerpc (and IIRC x86?) working with gc sections with
those KEEP annotations, but effectiveness of course is far worse than=20
what Nicolas was able to achieve with all his techniques and tricks.

But yes unless there is some other mechanism to handle these tables,=20
then KEEP probably has to stay. I suggest this wants a very explicit and=20
systematic way to handle it (maybe with some toolchain support) rather=20
than trying to just remove things case by case and see what breaks.

I don't know if Nicolas is still been working on his shrinking patches
recenty but he probably knows more than anyone about this stuff.

Thanks,
Nick

