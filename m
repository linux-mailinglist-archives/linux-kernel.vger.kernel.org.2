Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB33F057D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbhHROAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:00:17 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:30376 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhHROAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:00:00 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 17IDx89D027811
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:59:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 17IDx89D027811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629295148;
        bh=vO1geDOQNqjzTTQB/B8cwaJY7jsdspX3Z/5frXYRJRA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gX3udCcHF7eqfIBq2adIBH9n5nUN5MLsKnG1Z0tGpdjwJi6uLWZAT2nGxcamvBxOD
         qbCrpnHjdDHO5H0rGkHeZPP5dBv4AFmSFKHyYVv26suoL5h+ShLx8P31XpFR3XTsr7
         GHfcYCP/XuxppKtfNgnBCNm3lvXDfyI/sAK+aqOS1eQcraeUkFjc6XnkOM57SUrt1t
         Vm4sFm+w07CmDg4P8oRswyvMuPSPlS4IaqwaLRUQryJyxCGErLYHT3speGO3Ld+dwP
         dqa7Oo4WolYPfe3WbDxHfIJSUiX4T79uDL7hVQSlmT2hiY6O8Bi3TjyzUav+F0c1/w
         bYMMcoU1w2cIw==
X-Nifty-SrcIP: [209.85.216.42]
Received: by mail-pj1-f42.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so8983216pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:59:08 -0700 (PDT)
X-Gm-Message-State: AOAM533uFD9/7v2l1/Bh8clAHaHjCWvqNnq0w2PGMi1wrtBFAEjDL71Q
        I+txubtrjPWPfo3bHe65nqBcABfVk1PIKUmymSo=
X-Google-Smtp-Source: ABdhPJzFlnyln23/Ad0OfAS01oQY49jow7EywmiZ4IYXi6uyi1fdomL1ZKBqsTsbuBhf0Yg/ff0GiTxHmPeutlsz5o8=
X-Received: by 2002:a17:902:a5c5:b029:12c:a867:a839 with SMTP id
 t5-20020a170902a5c5b029012ca867a839mr7527205plq.71.1629295147564; Wed, 18 Aug
 2021 06:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210729141937.445051-1-masahiroy@kernel.org> <20210729141937.445051-3-masahiroy@kernel.org>
 <CAKwvOdkRuxaUvAi4ik2SiDgEeNOX6D76aBtHDBPyDVTumWskLg@mail.gmail.com>
In-Reply-To: <CAKwvOdkRuxaUvAi4ik2SiDgEeNOX6D76aBtHDBPyDVTumWskLg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 18 Aug 2021 22:58:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4qPd2QdJ2=+yh2xH4ku97ykqOCgiCsHUHVo1QDR1qtQ@mail.gmail.com>
Message-ID: <CAK7LNAT4qPd2QdJ2=+yh2xH4ku97ykqOCgiCsHUHVo1QDR1qtQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc: move the install rule to arch/powerpc/Makefile
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Jordan Niethe <jniethe5@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bill Wendling <morbo@google.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 5:30 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jul 29, 2021 at 7:22 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Currently, the install target in arch/powerpc/Makefile descends into
> > arch/powerpc/boot/Makefile to invoke the shell script, but there is no
> > good reason to do so.
>
> Sure, but there are more arch/ subdirs that DO invoke install.sh from
> arch/<arch>/boot/Makefile than, not:
>
> arch/<arch>/boot/Makefile:
> - parisc
> - nios2
> - arm
> - nds32
> - sparc
> - riscv
> - 390
> - ppc (this patch)
> - x86
> - arm64

I sent patches for these architectures.

Check LKML.






> arch/<arch>/Makefile:
> - ia64
> - m68k
>
> Patch is fine, but right now the tree is a bit inconsistent.
>
> >
> > arch/powerpc/Makefile can run the shell script directly.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/powerpc/Makefile      | 3 ++-
> >  arch/powerpc/boot/Makefile | 6 ------
> >  2 files changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 6505d66f1193..9aaf1abbc641 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -407,7 +407,8 @@ endef
> >
> >  PHONY += install
> >  install:
> > -       $(Q)$(MAKE) $(build)=$(boot) install
> > +       sh -x $(srctree)/$(boot)/install.sh "$(KERNELRELEASE)" vmlinux \
> > +       System.map "$(INSTALL_PATH)"
> >
> >  archclean:
> >         $(Q)$(MAKE) $(clean)=$(boot)
> > diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> > index 0d165bd98b61..10c0fb306f15 100644
> > --- a/arch/powerpc/boot/Makefile
> > +++ b/arch/powerpc/boot/Makefile
> > @@ -444,12 +444,6 @@ $(obj)/zImage:             $(addprefix $(obj)/, $(image-y))
> >  $(obj)/zImage.initrd:  $(addprefix $(obj)/, $(initrd-y))
> >         $(Q)rm -f $@; ln $< $@
> >
> > -# Only install the vmlinux
> > -install:
> > -       sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
> > -
> > -PHONY += install
> > -
> >  # anything not in $(targets)
> >  clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
> >         zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
> > --
> > 2.27.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
