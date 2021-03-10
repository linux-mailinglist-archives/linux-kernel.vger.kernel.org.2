Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5113334AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhCJWD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhCJWCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:02:47 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF53C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:02:38 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u18so27666906ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sXKxf2WheKTyVYrbgS1oaunkjJtfisdRmZ807RF1ULg=;
        b=dbU4ABptlvOkwDfx7plNb6a5nN6D3I3kAXWL/Oeko/xOmVpIlvVeERfIF6cIirsLEv
         nuevb/uU9rqPIsW4zwKzOoZ9h9xbXwV37dTOuoBmPxQGIVr/QPHA2GzWKOmiJB+I1xp7
         ecrphjmPAcMl1PfEUhUBXeOdOS29Vim/ALbGZoaIQYEZCTo3fpIcrAvW5Op+St6fEUsI
         VI9Nh2X1G7sDheoPWjf7y8Md/pyrscJEUIS3Pr2OznkRsRGmrNvBzkvBUyOihPuRZUUm
         GjFqtqhG1zI/d6vW3rtQK9hX6kBUs+tqoyLrtA2te62P48fhoDo95rHm/ZqN+kOJthKo
         8N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXKxf2WheKTyVYrbgS1oaunkjJtfisdRmZ807RF1ULg=;
        b=XXBflvqoVSh4b1TZW/xrNA+yYuuLqLCeEiRaDXWy4jrkOU5iZsLbwQKoETL0h9s02o
         Q5zl0OF4Vg8xgoBxZ92OpTHnmZvcQTzCiybijdybtfbJ2Tign+hD8LpQuY5Sq5yy6F6s
         WMtLNGdILEjXENwRd2ITPxEk1yHNEGj5HwJytELfz6GSwiDkXcB3S7uxD9fJoFUDXadQ
         dGLVGu3B8sRnHQ+DSP4jT1aiNcU4FSeEHDuJml9aH81SsBuxg5c/12NIiKt77RNZ/0w5
         KylXbLNHTJnc23CE2jR/XGOVEP056EcOnyT/S/UxzDd6R8FmznldgS/Z9R7fDiyfLjNo
         1fjQ==
X-Gm-Message-State: AOAM533uklGdvBSxQwOrQcNd+eTsYUKNAiwF4/22KtzndXJDk20tnNom
        qQ01l85EwiJmvgHcHi1qY60jGh+G/O9yXdtstqq0KA==
X-Google-Smtp-Source: ABdhPJznUWbLFNZFALzU8fQ9YS1h0QQBh8Wqc/a3pb1tgbl1rRtFm+l7R02qCrm4WRhwHDcStYtCj/ZrwiScdaMDdy0=
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr2941721ljp.495.1615413756356;
 Wed, 10 Mar 2021 14:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <20210226211323.arkvjnr4hifxapqu@google.com>
 <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com>
 <1614559739.p25z5x88wl.astroid@bobo.none> <CAK7LNATUSJ5T6bs-aA3sMQgXKWfcyWJLDfhmteBhQ5FuUR52Zg@mail.gmail.com>
 <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com>
In-Reply-To: <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Mar 2021 14:02:24 -0800
Message-ID: <CAKwvOdk4y3Ekc_TiWuk6D2KNbH_6YHZLRK9TtAnOP=cLP6E0Rw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     kernel-toolchains@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 1:08 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Mar 10, 2021 at 9:50 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > On Mon, Mar 1, 2021 at 10:11 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > Excerpts from Arnd Bergmann's message of February 27, 2021 7:49 pm:
>
> >
> > masahiro@oscar:~/ref/linux$ echo  'void this_func_is_unused(void) {}'
> > >>  kernel/cpu.c
> > masahiro@oscar:~/ref/linux$ export
> > CROSS_COMPILE=/home/masahiro/tools/powerpc-10.1.0/bin/powerpc-linux-
> > masahiro@oscar:~/ref/linux$ make ARCH=powerpc  defconfig
> > masahiro@oscar:~/ref/linux$ ./scripts/config  -e EXPERT
> > masahiro@oscar:~/ref/linux$ ./scripts/config  -e LD_DEAD_CODE_DATA_ELIMINATION
> > masahiro@oscar:~/ref/linux$
> > ~/tools/powerpc-10.1.0/bin/powerpc-linux-nm -n  vmlinux | grep
> > this_func
> > c000000000170560 T .this_func_is_unused
> > c000000001d8d560 D this_func_is_unused
> > masahiro@oscar:~/ref/linux$ grep DEAD_CODE_ .config
> > CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
> >
> >
> > If I remember correctly,
> > LD_DEAD_CODE_DATA_ELIMINATION dropped unused functions
> > when I tried it last time.
> >
> >
> > I also tried arm64 with a HAVE_LD_DEAD_CODE_DATA_ELIMINATION hack.
> > The result was the same.
> >
> >
> >
> > Am I missing something?
>
> It's possible that it only works in combination with CLANG_LTO now
> because something broke. I definitely saw a reduction in kernel
> size when both options are enabled, but did not try a simple test
> case like you did.
>
> Maybe some other reference gets created that prevents the function
> from being garbage-collected unless that other option is removed
> as well?

I wish the linker had a debug flag that could let developers discover
the decisions it made during --gc-sections as to why certain symbols
were retained/kept or not.
-- 
Thanks,
~Nick Desaulniers
