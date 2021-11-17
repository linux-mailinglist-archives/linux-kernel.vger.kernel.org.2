Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC2454979
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbhKQPDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:03:03 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:58691 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbhKQPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:03:00 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 1AHExUEG025783
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:59:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 1AHExUEG025783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1637161171;
        bh=J8i3NpRpaKfGQtvzORCBEFDJAvllsZKJSM1zjCIXB5w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jeZ139xNuuPKkkBUiVdLxtv34imOmLcJaG4ph4URV81TzdJFj4X76/RpweJmZBAmM
         CIBUPGW9d1Gau1m2axIHjJtZD2dY1F/D8KbPO4ggLJXnGQ2MdJCI04gGlZEKkvqfbp
         PaRRl6nZUErOvK1LGpQFPdt5f9hCYQuGeRF2Yb1aZ/h91UegiD1s+4y4qIUgLoYkm/
         6LrMXtoMjNEu6mA5DjpSb/1+6q5a8d9wAxGFC6p2jLvw9StrCqM19/luxjUFCEEra3
         wficM9zShtFj7o5oXsGh9ZNGLpkx/cAbBPBOczaHHKXEr3+fcNPV/2S96atJ79qGkL
         VoewliR8+igsg==
X-Nifty-SrcIP: [209.85.210.178]
Received: by mail-pf1-f178.google.com with SMTP id g19so2908159pfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:59:30 -0800 (PST)
X-Gm-Message-State: AOAM530gYI4pnvrXsX8Zp3mdVVE2qBDUDp44U59HqdbIthRfSZiih3U+
        n4zOiMI1fvoAZyzJNsDlojCiib9sbTowfsx25LY=
X-Google-Smtp-Source: ABdhPJxhF60oVNSvNyG0OLv0f0qLGXdDOSidaYAxE6cIOA4VDzi+zys+8JZrgsEmaWa77j9NdikoixTwUYB+0s2ZSbg=
X-Received: by 2002:a65:530d:: with SMTP id m13mr5678027pgq.128.1637161170000;
 Wed, 17 Nov 2021 06:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20211109185015.615517-1-masahiroy@kernel.org> <0cdd39b2-73f8-e0c1-bfa2-7940d4b788f0@csgroup.eu>
In-Reply-To: <0cdd39b2-73f8-e0c1-bfa2-7940d4b788f0@csgroup.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 17 Nov 2021 23:58:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4KD4zG2Me7RhsJNOXrMqDOHpd2YNoSPH4CZ63HXtqpQ@mail.gmail.com>
Message-ID: <CAK7LNAQ4KD4zG2Me7RhsJNOXrMqDOHpd2YNoSPH4CZ63HXtqpQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: clean vdso32 and vdso64 directories
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 12:38 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Hi Masahiro,
>
> Le 09/11/2021 =C3=A0 19:50, Masahiro Yamada a =C3=A9crit :
> > Since commit bce74491c300 ("powerpc/vdso: fix unnecessary rebuilds of
> > vgettimeofday.o"), "make ARCH=3Dpowerpc clean" does not clean up the
> > arch/powerpc/kernel/{vdso32,vdso64} directories.
> >
> > Use the subdir- trick to let "make clean" descend into them.
> >
> > Fixes: bce74491c300 ("powerpc/vdso: fix unnecessary rebuilds of vgettim=
eofday.o")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >   arch/powerpc/kernel/Makefile | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefil=
e
> > index 0e3640e14eb1..5fa68c2ef1f8 100644
> > --- a/arch/powerpc/kernel/Makefile
> > +++ b/arch/powerpc/kernel/Makefile
> > @@ -196,3 +196,6 @@ clean-files :=3D vmlinux.lds
> >   # Force dependency (incbin is bad)
> >   $(obj)/vdso32_wrapper.o : $(obj)/vdso32/vdso32.so.dbg
> >   $(obj)/vdso64_wrapper.o : $(obj)/vdso64/vdso64.so.dbg
> > +
> > +# for cleaning
> > +subdir- +=3D vdso32 vdso64
> >
>
> This patch make me think about one thing I would have liked to do, but I
> don't know Makefiles well enough to be able to do it. You could probably
> help me with it.
>
> vdso32 and vdso64 contain a lot of redundant sources. I would like to
> merge them into a new single directory, let say 'vdso', and use the
> files in that directory to build both vdso32.so and vdso64.so. I have a
> feeling that x86 is doing it that way, but I've not been able to figure
> out how to build two objects using the same C/S files.
>
> Thanks
> Christophe

Changing the code as follows might work.

$(obj-vdso32): %-32.o: %.S FORCE
          $(call if_changed_dep,vdso32as)




--=20
Best Regards
Masahiro Yamada
