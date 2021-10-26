Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8ED43B147
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhJZLgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 07:36:01 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58670
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhJZLf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:35:59 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AAC3840279
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635248012;
        bh=p/YSQVHQ2qVFgAnoHpMJgz8Z7UR53z+rl6CiCMg8icA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rN0uXx2tAIuSsssBf651UUh0UYvlUROOV5XPTab3vdIWwFQ7n6whr6dn7+G9TvIXg
         bbP5DZR9F471bRWr0TF6BxJki/BUWxX6p6GSzsIAe3Kx1WAaDrQBlIh28Ss5ckLb1C
         h9eKqZcfCFNTuXrVCSsTrByi2mU5R4/JrBGmbM6P2+jEpd9tNDLJTB+1KWxFmLTcRJ
         PzBqSu26klnJC0llNOcfRbIJTJSS+Z54sDfhMgVLvbWL+vhs4DfBx8/xACdclaE0Jn
         TiDk6pfNbjVcJxyN3eLpELMCT1ykbywbMI47fYyfMxmIHCfV7gyEL59J4UnPjLdhEV
         MYrN9v9mlgdrg==
Received: by mail-ed1-f70.google.com with SMTP id c25-20020a056402143900b003dc19782ea8so12823162edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p/YSQVHQ2qVFgAnoHpMJgz8Z7UR53z+rl6CiCMg8icA=;
        b=Ddinc49gLfJJYjM5yuV6VhTWZftXxE+g4kcSCN87ZtCmt4fBXxeqxUWTbZIZT+ZTFU
         Nd8NQ+mFEWr0XIXgLzG+Wh4u9rBrU6yzP+x6ugnB3Q7vzxneH7NfJFtEzOCcuRn+mSmy
         m6T24tjzrr+xFEsONbNgdGK2XCO5AiB0YGkRfUfr9X7CxaBPwrpeKmxsUDcu74rFGgfF
         HPYut/48J5OeQ295pKD039tHzeOiwHI1ljqIIAfIBtZofdQV5nlQ59A9izjSAiQcEf6m
         uE8NixoTY0mbeh5rku7wAPy9h1tznrfuWGmj81REB1ST+4Nl4ub1LIZvVwKfqkUXJx6e
         JAzg==
X-Gm-Message-State: AOAM532c/Bhaz6pBZQVzxvEZlOAV/kj171DmZbD51yHOaC0OrdUaAKWE
        PVU+gyG+DGH2IHLsyjxIqo1R8S0y9Hk1uDz9XpWcQAfgNVRYT2Gd6k4QLzrZmfwwadXCG3KyVtH
        0JajEljcmInLx3rbuHRgI6xVwRZsilNceTa1Z4+YZ0qq2H/4qtBwG74faDg==
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr5178690ejc.156.1635248012166;
        Tue, 26 Oct 2021 04:33:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwk9yh1otC2FcE4T7DFXV6h0+OXQXCBzAm5yVnfRbJ0//wWZH92fSunNBiBY+8wfJj6PEUCHJI5uenfImglgdM=
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr5178648ejc.156.1635248011842;
 Tue, 26 Oct 2021 04:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <YUyWYpDl2Dmegz0a@archlinux-ax161> <mhng-b5f8a6a0-c3e8-4d25-9daa-346fdc8a2e5e@palmerdabbelt-glaptop>
 <YWhg8/UzjJsB51Gd@archlinux-ax161> <afeaea5f-70f2-330f-f032-fb0c8b5d0aa5@ghiti.fr>
 <990a894c-1806-5ab2-775e-a6f2355c2299@ghiti.fr> <CA+zEjCt28iYQARQa=8Nsw8+_j0PuEee==gUqjKjasMo+w2Ohwg@mail.gmail.com>
 <CACT4Y+YB8bjqxFfSrXKbfETXJAUxH=HR+kizC0T-AZLArY3A5A@mail.gmail.com>
In-Reply-To: <CACT4Y+YB8bjqxFfSrXKbfETXJAUxH=HR+kizC0T-AZLArY3A5A@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Tue, 26 Oct 2021 13:33:20 +0200
Message-ID: <CA+zEjCtVYLdg3FQnnZjv+Bb-bn2mvj9BCZF787dbNNRHPvyZug@mail.gmail.com>
Subject: Re: [PATCH] kasan: Always respect CONFIG_KASAN_STACK
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexandre ghiti <alex@ghiti.fr>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, elver@google.com,
        akpm@linux-foundation.org, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, ndesaulniers@google.com,
        Arnd Bergmann <arnd@arndb.de>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 6:48 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, 26 Oct 2021 at 06:39, Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > Hi,
> >
> > On Fri, Oct 15, 2021 at 3:08 PM Alexandre ghiti <alex@ghiti.fr> wrote:
> > >
> > > On 10/14/21 8:31 PM, Alex Ghiti wrote:
> > > > Hi Nathan,
> > > >
> > > > Le 14/10/2021 =C3=A0 18:55, Nathan Chancellor a =C3=A9crit :
> > > >> On Fri, Oct 08, 2021 at 11:46:55AM -0700, Palmer Dabbelt wrote:
> > > >>> On Thu, 23 Sep 2021 07:59:46 PDT (-0700), nathan@kernel.org wrote=
:
> > > >>>> On Thu, Sep 23, 2021 at 12:07:17PM +0200, Marco Elver wrote:
> > > >>>>> On Wed, 22 Sept 2021 at 22:55, Nathan Chancellor
> > > >>>>> <nathan@kernel.org> wrote:
> > > >>>>>> Currently, the asan-stack parameter is only passed along if
> > > >>>>>> CFLAGS_KASAN_SHADOW is not empty, which requires
> > > >>>>>> KASAN_SHADOW_OFFSET to
> > > >>>>>> be defined in Kconfig so that the value can be checked. In RIS=
C-V's
> > > >>>>>> case, KASAN_SHADOW_OFFSET is not defined in Kconfig, which mea=
ns
> > > >>>>>> that
> > > >>>>>> asan-stack does not get disabled with clang even when
> > > >>>>>> CONFIG_KASAN_STACK
> > > >>>>>> is disabled, resulting in large stack warnings with allmodconf=
ig:
> > > >>>>>>
> > > >>>>>> drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb03=
5q02.c:117:12:
> > > >>>>>>
> > > >>>>>> error: stack frame size (14400) exceeds limit (2048) in functi=
on
> > > >>>>>> 'lb035q02_connect' [-Werror,-Wframe-larger-than]
> > > >>>>>> static int lb035q02_connect(struct omap_dss_device *dssdev)
> > > >>>>>>             ^
> > > >>>>>> 1 error generated.
> > > >>>>>>
> > > >>>>>> Ensure that the value of CONFIG_KASAN_STACK is always passed
> > > >>>>>> along to
> > > >>>>>> the compiler so that these warnings do not happen when
> > > >>>>>> CONFIG_KASAN_STACK is disabled.
> > > >>>>>>
> > > >>>>>> Link: https://github.com/ClangBuiltLinux/linux/issues/1453
> > > >>>>>> References: 6baec880d7a5 ("kasan: turn off asan-stack for clan=
g-8
> > > >>>>>> and earlier")
> > > >>>>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > >>>>>
> > > >>>>> Reviewed-by: Marco Elver <elver@google.com>
> > > >>>>
> > > >>>> Thanks!
> > > >>>>
> > > >>>>> [ Which tree are you planning to take it through? ]
> > > >>>>
> > > >>>> Gah, I was intending for it to go through -mm, then I cc'd neith=
er
> > > >>>> Andrew nor linux-mm... :/ Andrew, do you want me to resend or ca=
n you
> > > >>>> grab it from LKML?
> > > >>>
> > > >>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > > >>>
> > > >>> (assuming you still want it through somewhere else)
> > > >>
> > > >> Thanks, it is now in mainline as commit 19532869feb9 ("kasan: alwa=
ys
> > > >> respect CONFIG_KASAN_STACK").
> > > >>
> > > >>>>> Note, arch/riscv/include/asm/kasan.h mentions KASAN_SHADOW_OFFS=
ET in
> > > >>>>> comment (copied from arm64). Did RISC-V just forget to copy ove=
r the
> > > >>>>> Kconfig option?
> > > >>>>
> > > >>>> I do see it defined in that file as well but you are right that
> > > >>>> they did
> > > >>>> not copy the Kconfig logic, even though it was present in the tr=
ee
> > > >>>> when
> > > >>>> RISC-V KASAN was implemented. Perhaps they should so that they g=
et
> > > >>>> access to the other flags in the "else" branch?
> > > >>>
> > > >>> Ya, looks like we just screwed this up.  I'm seeing some warnings=
 like
> > > >>>
> > > >>>     cc1: warning: =E2=80=98-fsanitize=3Dkernel-address=E2=80=99 w=
ith stack protection
> > > >>> is not supported without =E2=80=98-fasan-shadow-offset=3D=E2=80=
=99 for this target
> > > >>
> > > >> Hmmm, I thought I did a GCC build with this change but I must not =
have
> > > >> :/
> > > >>
> > > >>> which is how I ended up here, I'm assuming that's what you're
> > > >>> talking about
> > > >>> here?  LMK if you were planning on sending along a fix or if you
> > > >>> want me to
> > > >>> go figure it out.
> > > >>
> > > >> I took a look at moving the logic into Kconfig like arm64 before s=
ending
> > > >> this change and I did not really understand it well enough to do s=
o. I
> > > >> think it would be best if you were able to do that so that nothing=
 gets
> > > >> messed up.
> > > >>
> > > >
> > > > I'll do it tomorrow, I'm the last one who touched kasan on riscv :)
> > > >
> > >
> > > Adding KASAN_SHADOW_OFFSET config makes kasan kernel fails to boot.
> > > It receives a *write* fault at the beginning of a memblock_alloc
> > > function while populating the kernel shadow memory: the trap address =
is
> > > in the kasan shadow virtual address range and this corresponds to a
> > > kernel address in init_stack. The question is: how do I populate the
> > > stack shadow mapping without using memblock API? It's weird, I don't
> > > find anything on other architectures.
> >
> > @kasan: Any idea what we are doing wrong in riscv to encounter the
> > above situation?
>
> Hi Alex, Palmer,
>
> The patch changes the definition of the KASAN_SHADOW_OFFSET const.
> Does it's value change as a result or not? Have you tried to print it
> before/after?
> If value does not change, then this is more mysterious. If it changes,
> then there lots of possible explanations (points to unmapped region,
> overlaps with something), but we need to know values before/after to

So I debugged a bit more what happened here, and actually the culprit
is the call to kasan_populate_early_shadow at the beginning of
kasan_init which write-protects the access to kasan_early_shadow_page
and hence the write fault later when using memblock. I don't see the
point of this call anyway since we populate swapper_pg_dir in
kasan_early_init and then we write-protect the access to
kasan_early_shadow_page at the end of kasan_init.

But that may not be ideal, so I'm open to a better suggestion than
just removing the call to kasan_populate_early_shadow.

Sorry I did not dig further before asking and thanks for your time,

Alex

> answer this.
>
>
> > Thanks,
> >
> > Alex
> >
> > >
> > > And just a short note: I have realized this will break with the sv48
> > > patchset as we decide at runtime the address space width and the kasa=
n
> > > shadow start address is different between sv39 and sv48. I will have =
to
> > > do like x86 and move the kasan shadow start at the end of the address
> > > space so that it is the same for both sv39 and sv48.
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > >
> > > > Thanks,
> > > >
> > > > Alex
> > > >
> > > >> Cheers,
> > > >> Nathan
> > > >>
> > > >> _______________________________________________
> > > >> linux-riscv mailing list
> > > >> linux-riscv@lists.infradead.org
> > > >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > >>
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
