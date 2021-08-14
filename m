Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F693EC60C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 01:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhHNXun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 19:50:43 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:32428 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhHNXuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 19:50:40 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 17ENnpW3026713
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 08:49:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 17ENnpW3026713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628984992;
        bh=4qC4AERb0Snk+55rk2CLhMwMYEU3AtPhxGssFF1Wn6E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2dbOfK20z85mtZRexmRyPdAfSlmQ0bHm8Jl+QEWw2ylAPkiK0jgeuKXizVsKL19BK
         ZLrJQdxtYIzkS4rBn948m0KKuMH/Vyy7/yOm50LEQcGJGMPRClb5MT2wNdxA9ribrw
         rXUQ3D1vpTW+/lpNrsnKze/ikY1CxKA1/wPDylZt67zO61DRpVpGNSkNp76BrUGBeh
         G1nNauOf+DA2J7WeIl55xMHl10zgACZ9CPFpsDkZ/Ze3k8e2gXVvDjpKU161zaK8WG
         GxV68Ntoklzat2/3Dxul8PmOzfJjeVBg83WmOtgyaCmrQkBKPcY1EgRO3CSjMTc7dB
         WVU48LLmjWpcw==
X-Nifty-SrcIP: [209.85.214.180]
Received: by mail-pl1-f180.google.com with SMTP id a5so16530294plh.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 16:49:51 -0700 (PDT)
X-Gm-Message-State: AOAM53350/QOPUgB/frm8Hd5xw09DmflAwF24yZg3p/QVhRVeEfpq8hO
        ZvBkY7aLO00qpf2+cIIggcipafrXnjiRLI/ChkY=
X-Google-Smtp-Source: ABdhPJz5XOqnHANztna/aYDFzteB9C6xf5kkT9BSKSsHlNBNwwsYo2uIuqDV+v3Cw8m6EcYrntZp4ngs/Fdz8lEcXDE=
X-Received: by 2002:a17:90a:7384:: with SMTP id j4mr8993112pjg.153.1628984990887;
 Sat, 14 Aug 2021 16:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210729142147.445593-1-masahiroy@kernel.org> <mhng-fe558e10-6cee-4e55-b975-8c525c2bcb02@palmerdabbelt-glaptop>
In-Reply-To: <mhng-fe558e10-6cee-4e55-b975-8c525c2bcb02@palmerdabbelt-glaptop>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 15 Aug 2021 08:49:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNARVjdVf5QRFduKrxb-TJyiCdUPkpSSMtYiS7yN2yAZhEQ@mail.gmail.com>
Message-ID: <CAK7LNARVjdVf5QRFduKrxb-TJyiCdUPkpSSMtYiS7yN2yAZhEQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: move the (z)install rules to arch/riscv/Makefile
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tobias Klauser <tklauser@distanz.ch>, vitaly.wool@konsulko.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 2:00 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 29 Jul 2021 07:21:47 PDT (-0700), masahiroy@kernel.org wrote:
> > Currently, the (z)install targets in arch/riscv/Makefile descend into
> > arch/riscv/boot/Makefile to invoke the shell script, but there is no
> > good reason to do so.
> >
> > arch/riscv/Makefile can run the shell script directly.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/riscv/Makefile      | 7 +++++--
> >  arch/riscv/boot/Makefile | 8 --------
> >  2 files changed, 5 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index bc74afdbf31e..3c437fb09a07 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -126,8 +126,11 @@ $(BOOT_TARGETS): vmlinux
> >  Image.%: Image
> >       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> >
> > -zinstall install:
> > -     $(Q)$(MAKE) $(build)=$(boot) $@
> > +install: install-image = Image
> > +zinstall: install-image = Image.gz
> > +install zinstall:
> > +     $(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
> > +     $(boot)/$(install-image) System.map "$(INSTALL_PATH)"
> >
> >  archclean:
> >       $(Q)$(MAKE) $(clean)=$(boot)
> > diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> > index 6bf299f70c27..becd0621071c 100644
> > --- a/arch/riscv/boot/Makefile
> > +++ b/arch/riscv/boot/Makefile
> > @@ -58,11 +58,3 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
> >
> >  $(obj)/loader.bin: $(obj)/loader FORCE
> >       $(call if_changed,objcopy)
> > -
> > -install:
> > -     $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
> > -     $(obj)/Image System.map "$(INSTALL_PATH)"
> > -
> > -zinstall:
> > -     $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
> > -     $(obj)/Image.gz System.map "$(INSTALL_PATH)"
>
> Admittidly I don't see a reason to do it this way either, but it looks
> like the other common ports (I checked arm64 and x86) are doing things
> this way.  I don't really care that much about which way we do it, but
> it'd be better to keep everyone aligned.
>
> Are you converting the other ports over as well?

Yes.


-- 
Best Regards
Masahiro Yamada
