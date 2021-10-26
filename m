Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7554543AB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhJZEmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:42:10 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43960
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230414AbhJZEmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:42:09 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 162BB4000B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635223185;
        bh=KVhIZhSXB0M0vyj9/7/Cl1UkXRcb4g+5QcVGTYNYcgo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cdEzxWE4E0P6DTEwzmtHGbavKRnW3dWTxmEH6xKne1QxEPaLXnRAX4SngboAdSGZj
         Ei+4nGmElOAVVGWWGh8iorXQKNjb9/qY6kF/9WIPfpm83Ox43ywn4y0EIwO4cCkNz/
         RgFYdyALEgnOD1yOS4arRhMjiSPtpubalg36Cp4DPmBT7BfWfA6cF2LJdC7i3s/U6J
         9dwA5b1+h/4JBqbLjxEZ66xTkv0jTkj/nwojldPk/M/iHudxou9Ba6P09ACB7MHD0J
         GdCzf29ov1G0yKXTW3Sb0d1kNEpqk9lwh1smJSQDyzyHuu5bAUvfhAG+n+azTayDWw
         I0j+IMPyrou+g==
Received: by mail-ed1-f70.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so2619828edv.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 21:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KVhIZhSXB0M0vyj9/7/Cl1UkXRcb4g+5QcVGTYNYcgo=;
        b=k6aW13+abhLmv3Cl7U3NCvWe4JDd3vYFAi4PD1PnWRoBXg1XttBQKbp+EodVFV6VXd
         GZvByE504G/jzZsQ+tuikM8nFDk0yUXhOuX1Thzn3gEFs/yZbGB2ecIa//MxV98c6zdj
         Eipy86jVHrTb4m1ODQj2wxV/ZYuN/ijYhieZxNGkkBXjfWFpk2TzslwWg1/prm4mW15W
         0MZQ/hqB+oQKFEGg0TNlwXiTOjcaObeSa1srofPl2WQYpdV3ELooikfw6AoU3szpurWh
         Bg87MFTYa2svZEynHr2XWvj0Pj5n+dmZRDhIZUIN28uhGH3qKcMJUrndYoi+jxn2r8/g
         MWBw==
X-Gm-Message-State: AOAM530CE8Igx7C8+JkaEPPuezWf9CFQxDoI5R02zaIB8v5TeHTDl1+4
        G5REnEa4gkrgiaKMPR4WRUPorQhraC0iPzpQ6ho2U4gnYN2d3XLDAcNmC/2OvvjUfcowq4/RXj8
        Ev57JNyjEw/DS2C7IsLuHKPHuYabyssgZ+9Ftp7U7UQCzQ86FutdHb5kCfA==
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr2839495ejc.156.1635223183477;
        Mon, 25 Oct 2021 21:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkpOQjSsxy4BbivbGbiR5w6Hk4KaWKisTkBst3LHn0VETbEITcOi/fB/MTKShp/KaTjhZkVas96zEud+sqEuw=
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr2839461ejc.156.1635223183204;
 Mon, 25 Oct 2021 21:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <YUyWYpDl2Dmegz0a@archlinux-ax161> <mhng-b5f8a6a0-c3e8-4d25-9daa-346fdc8a2e5e@palmerdabbelt-glaptop>
 <YWhg8/UzjJsB51Gd@archlinux-ax161> <afeaea5f-70f2-330f-f032-fb0c8b5d0aa5@ghiti.fr>
 <990a894c-1806-5ab2-775e-a6f2355c2299@ghiti.fr>
In-Reply-To: <990a894c-1806-5ab2-775e-a6f2355c2299@ghiti.fr>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Tue, 26 Oct 2021 06:39:31 +0200
Message-ID: <CA+zEjCt28iYQARQa=8Nsw8+_j0PuEee==gUqjKjasMo+w2Ohwg@mail.gmail.com>
Subject: Re: [PATCH] kasan: Always respect CONFIG_KASAN_STACK
To:     Alexandre ghiti <alex@ghiti.fr>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, elver@google.com,
        akpm@linux-foundation.org, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        ndesaulniers@google.com, Arnd Bergmann <arnd@arndb.de>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 15, 2021 at 3:08 PM Alexandre ghiti <alex@ghiti.fr> wrote:
>
> On 10/14/21 8:31 PM, Alex Ghiti wrote:
> > Hi Nathan,
> >
> > Le 14/10/2021 =C3=A0 18:55, Nathan Chancellor a =C3=A9crit :
> >> On Fri, Oct 08, 2021 at 11:46:55AM -0700, Palmer Dabbelt wrote:
> >>> On Thu, 23 Sep 2021 07:59:46 PDT (-0700), nathan@kernel.org wrote:
> >>>> On Thu, Sep 23, 2021 at 12:07:17PM +0200, Marco Elver wrote:
> >>>>> On Wed, 22 Sept 2021 at 22:55, Nathan Chancellor
> >>>>> <nathan@kernel.org> wrote:
> >>>>>> Currently, the asan-stack parameter is only passed along if
> >>>>>> CFLAGS_KASAN_SHADOW is not empty, which requires
> >>>>>> KASAN_SHADOW_OFFSET to
> >>>>>> be defined in Kconfig so that the value can be checked. In RISC-V'=
s
> >>>>>> case, KASAN_SHADOW_OFFSET is not defined in Kconfig, which means
> >>>>>> that
> >>>>>> asan-stack does not get disabled with clang even when
> >>>>>> CONFIG_KASAN_STACK
> >>>>>> is disabled, resulting in large stack warnings with allmodconfig:
> >>>>>>
> >>>>>> drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02=
.c:117:12:
> >>>>>>
> >>>>>> error: stack frame size (14400) exceeds limit (2048) in function
> >>>>>> 'lb035q02_connect' [-Werror,-Wframe-larger-than]
> >>>>>> static int lb035q02_connect(struct omap_dss_device *dssdev)
> >>>>>>             ^
> >>>>>> 1 error generated.
> >>>>>>
> >>>>>> Ensure that the value of CONFIG_KASAN_STACK is always passed
> >>>>>> along to
> >>>>>> the compiler so that these warnings do not happen when
> >>>>>> CONFIG_KASAN_STACK is disabled.
> >>>>>>
> >>>>>> Link: https://github.com/ClangBuiltLinux/linux/issues/1453
> >>>>>> References: 6baec880d7a5 ("kasan: turn off asan-stack for clang-8
> >>>>>> and earlier")
> >>>>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >>>>>
> >>>>> Reviewed-by: Marco Elver <elver@google.com>
> >>>>
> >>>> Thanks!
> >>>>
> >>>>> [ Which tree are you planning to take it through? ]
> >>>>
> >>>> Gah, I was intending for it to go through -mm, then I cc'd neither
> >>>> Andrew nor linux-mm... :/ Andrew, do you want me to resend or can yo=
u
> >>>> grab it from LKML?
> >>>
> >>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >>>
> >>> (assuming you still want it through somewhere else)
> >>
> >> Thanks, it is now in mainline as commit 19532869feb9 ("kasan: always
> >> respect CONFIG_KASAN_STACK").
> >>
> >>>>> Note, arch/riscv/include/asm/kasan.h mentions KASAN_SHADOW_OFFSET i=
n
> >>>>> comment (copied from arm64). Did RISC-V just forget to copy over th=
e
> >>>>> Kconfig option?
> >>>>
> >>>> I do see it defined in that file as well but you are right that
> >>>> they did
> >>>> not copy the Kconfig logic, even though it was present in the tree
> >>>> when
> >>>> RISC-V KASAN was implemented. Perhaps they should so that they get
> >>>> access to the other flags in the "else" branch?
> >>>
> >>> Ya, looks like we just screwed this up.  I'm seeing some warnings lik=
e
> >>>
> >>>     cc1: warning: =E2=80=98-fsanitize=3Dkernel-address=E2=80=99 with =
stack protection
> >>> is not supported without =E2=80=98-fasan-shadow-offset=3D=E2=80=99 fo=
r this target
> >>
> >> Hmmm, I thought I did a GCC build with this change but I must not have
> >> :/
> >>
> >>> which is how I ended up here, I'm assuming that's what you're
> >>> talking about
> >>> here?  LMK if you were planning on sending along a fix or if you
> >>> want me to
> >>> go figure it out.
> >>
> >> I took a look at moving the logic into Kconfig like arm64 before sendi=
ng
> >> this change and I did not really understand it well enough to do so. I
> >> think it would be best if you were able to do that so that nothing get=
s
> >> messed up.
> >>
> >
> > I'll do it tomorrow, I'm the last one who touched kasan on riscv :)
> >
>
> Adding KASAN_SHADOW_OFFSET config makes kasan kernel fails to boot.
> It receives a *write* fault at the beginning of a memblock_alloc
> function while populating the kernel shadow memory: the trap address is
> in the kasan shadow virtual address range and this corresponds to a
> kernel address in init_stack. The question is: how do I populate the
> stack shadow mapping without using memblock API? It's weird, I don't
> find anything on other architectures.

@kasan: Any idea what we are doing wrong in riscv to encounter the
above situation?

Thanks,

Alex

>
> And just a short note: I have realized this will break with the sv48
> patchset as we decide at runtime the address space width and the kasan
> shadow start address is different between sv39 and sv48. I will have to
> do like x86 and move the kasan shadow start at the end of the address
> space so that it is the same for both sv39 and sv48.
>
> Thanks,
>
> Alex
>
>
> > Thanks,
> >
> > Alex
> >
> >> Cheers,
> >> Nathan
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
