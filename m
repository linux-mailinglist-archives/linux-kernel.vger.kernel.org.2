Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD83DBFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhG3Ua0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhG3UaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:30:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF78AC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 13:30:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m9so14062984ljp.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlNJsWKLmqO3IeQQioweQYYN6qx+xQ/7jnpZkoegGsQ=;
        b=N8HoRlaGoRDU1r+nR55Q+mD8NeG34Px6GOxSmRxfAWW/GtjaLdW4aEeIuv/KprECeS
         nlkj1pzEAMruW5U2sly70QyiAeKTV7LAgxYxFO5Ghd+vKCdzW2j0cp2YcLu0GLu4zTkX
         gf8JtbV00p0gPK9m1zN7X84cFLWtYaj/gcnSOMvkCOkm915o9iUhaJbypDlgNwlsaCYm
         6cLVDs9eLPDBauUK9WRcd5TAEwbftzIPZKZyABICTTlEZmWKkWwmUfVd/E03Y+x7H32F
         GwRknAJs6R8kf0WLZw6JN8rYtXRbl/xtr5FoJDjoRXDQZrn8G/VXJkeaoiv3RCrBcY9C
         nDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlNJsWKLmqO3IeQQioweQYYN6qx+xQ/7jnpZkoegGsQ=;
        b=oO4Ms0+UdSoQdW/PhdfnQqOxIxDAlSuTx61wN2EYIsh3si82qpB24BWtlaG9agNCZS
         ed8ahdg5kY6UEa6YrCVi87GPHg4jCv7AVyOSjeopiizgrBXYVfUINnwRFuBXEousiL07
         sK/1iksmFxEeCiqHrnXyOLICtAyO+Q521Nso9qLJePC1EBgexBOZLqlhcLknWOkfCfXD
         +/kw4PVV32Q/7BxRhrlCqFmSJ86uGo+Af8z1SORzMuvNFZR18603HuwhKpcylsEemY03
         dPr6rJJ4R5lneZZV15+bbIQk54Uj18/55U4IPWz5MiaDwXBJTmIfmkQcoDdeZSfFbriq
         MmFQ==
X-Gm-Message-State: AOAM5303lE+A/oks5xlI9bJsbDLJIRqNze0r09Dw0O3C+IJ2evUxuvEY
        BhDJB382yxrPWW/mVffnSmmb5jdzvAB7sT336pn4QpKWRpcuQg==
X-Google-Smtp-Source: ABdhPJycP4d14boj+x7rHzVPDwajcqyRnadT/XwhsCoJtnZ5aga9ccR/57cOzQWxd3X3ZJJjF6Pof8pxFnN/+9b14Ac=
X-Received: by 2002:a05:651c:329:: with SMTP id b9mr2927423ljp.116.1627677010835;
 Fri, 30 Jul 2021 13:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210729141937.445051-1-masahiroy@kernel.org> <20210729141937.445051-3-masahiroy@kernel.org>
In-Reply-To: <20210729141937.445051-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Jul 2021 13:29:59 -0700
Message-ID: <CAKwvOdkRuxaUvAi4ik2SiDgEeNOX6D76aBtHDBPyDVTumWskLg@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc: move the install rule to arch/powerpc/Makefile
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Jordan Niethe <jniethe5@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bill Wendling <morbo@google.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 7:22 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Currently, the install target in arch/powerpc/Makefile descends into
> arch/powerpc/boot/Makefile to invoke the shell script, but there is no
> good reason to do so.

Sure, but there are more arch/ subdirs that DO invoke install.sh from
arch/<arch>/boot/Makefile than, not:

arch/<arch>/boot/Makefile:
- parisc
- nios2
- arm
- nds32
- sparc
- riscv
- 390
- ppc (this patch)
- x86
- arm64

arch/<arch>/Makefile:
- ia64
- m68k

Patch is fine, but right now the tree is a bit inconsistent.

>
> arch/powerpc/Makefile can run the shell script directly.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/powerpc/Makefile      | 3 ++-
>  arch/powerpc/boot/Makefile | 6 ------
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 6505d66f1193..9aaf1abbc641 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -407,7 +407,8 @@ endef
>
>  PHONY += install
>  install:
> -       $(Q)$(MAKE) $(build)=$(boot) install
> +       sh -x $(srctree)/$(boot)/install.sh "$(KERNELRELEASE)" vmlinux \
> +       System.map "$(INSTALL_PATH)"
>
>  archclean:
>         $(Q)$(MAKE) $(clean)=$(boot)
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 0d165bd98b61..10c0fb306f15 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -444,12 +444,6 @@ $(obj)/zImage:             $(addprefix $(obj)/, $(image-y))
>  $(obj)/zImage.initrd:  $(addprefix $(obj)/, $(initrd-y))
>         $(Q)rm -f $@; ln $< $@
>
> -# Only install the vmlinux
> -install:
> -       sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
> -
> -PHONY += install
> -
>  # anything not in $(targets)
>  clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
>         zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
