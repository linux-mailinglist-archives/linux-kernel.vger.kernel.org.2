Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C743DBF8B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhG3UU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhG3UUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:20:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2647C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 13:20:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l4so14071455ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZdxsXIhfZeShR0BpG7ZM9hlF98/ed3x62uZjV8NOlc=;
        b=JLaAC3h6i7sv+zobgB6FCO8AkNHOnE+QSegQ6bJPG6zSD18coezaJg3a+0CFIZQDfS
         8q2bUhPPeq8m6y39/0m8Oj0eweVmITzggzzvOvTbMRziX1ZII5ODNwmvKf5pQ2aAcIyR
         aejTL5OimVzszTLBmMh/RQY5fS6aDnBUyroYVcmtGcurAfL/38PbaRCFUlL8bEkPg2M6
         iI76uy2PSOch+Xjq8lgsVsP5Q7CyTB9B37NnsW/dBhrfXzwYpdNeOp7Sl5aILWZ13KJ5
         TvQtlXaQ1w+IqLoPVg9nOVqxFjaQA1nx72kNzlQ/DV8S+Ow1gRYts2kwwuBIlJeGLIkG
         Uu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZdxsXIhfZeShR0BpG7ZM9hlF98/ed3x62uZjV8NOlc=;
        b=V6BdHO1ECK2YuClh3nAKt4V3o0l0Mt8qMjNo+35EVJ8Wlxa59n4gLYSZqdWIPy5KvL
         KDaV+PEoao15/AD3A4zX14k2GMqm7tpXAdBoySbdhGaj+RJ2mw/02H29GTtMdPQ2/enG
         /wvyjQEyyQ+VZbRNIbjMHpw0bn1gV6Ci6l+qgJDVjSbPfVUT2WglVZKmHA1DT5deT0DB
         4O2ZoxBR97FhIYjENEQvpty0AaeKt5kyrxQ/ufTkEa+HvuYZhtHB0Y5k5g+kRfajIYxg
         L5ZvVlXItnHPTXsyS70+5kbyfXW2HAGj8tdefFxWkYPDpN/Uns8DgB3J5JefbkGw8pqb
         uUCQ==
X-Gm-Message-State: AOAM533SQgWzevsvzvS7J7+v3y2RyVg7RvgRfNveX2yCvKJ4NulIT+Qi
        XxYDI+Ird2PXQLswgOp4SQ7XM4GhpW52W/9KAhKqkA==
X-Google-Smtp-Source: ABdhPJxOp5UzhKE8mQDqRvlDz8V9c71SjR7m9HyAJLUxJZSu5SbSBuLRrcen1tdS0S3uE6PnU0rTNbtfAOPrHw/7VOw=
X-Received: by 2002:a05:651c:329:: with SMTP id b9mr2900217ljp.116.1627676446795;
 Fri, 30 Jul 2021 13:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210729141937.445051-1-masahiroy@kernel.org>
In-Reply-To: <20210729141937.445051-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Jul 2021 13:20:34 -0700
Message-ID: <CAKwvOd=AM1zus+apNQ14oS05bQPoSuhSdjUhPUD-4EU5x2KFSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: remove unused zInstall target from arch/powerpc/boot/Makefile
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, Jordan Niethe <jniethe5@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Bill Wendling <morbo@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 7:22 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit c913e5f95e54 ("powerpc/boot: Don't install zImage.* from make
> install") added the zInstall target to arch/powerpc/boot/Makefile,
> but you cannot use it since the corresponding hook is missing in
> arch/powerpc/Makefile.
>
> It has never worked since its addition. Nobody has complained about
> it for 7 years, which means this code was unneeded.
>
> With this removal, the install.sh will be passed in with 4 parameters.
> Simplify the shell script.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  arch/powerpc/boot/Makefile   |  6 +-----
>  arch/powerpc/boot/install.sh | 13 -------------
>  2 files changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index e312ea802aa6..a702f9d1ec0d 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -448,11 +448,7 @@ $(obj)/zImage.initrd:      $(addprefix $(obj)/, $(initrd-y))
>  install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
>         sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
>
> -# Install the vmlinux and other built boot targets.
> -zInstall: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
> -       sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $^
> -
> -PHONY += install zInstall
> +PHONY += install
>
>  # anything not in $(targets)
>  clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
> diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
> index b6a256bc96ee..658c93ca7437 100644
> --- a/arch/powerpc/boot/install.sh
> +++ b/arch/powerpc/boot/install.sh
> @@ -15,7 +15,6 @@
>  #   $2 - kernel image file
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
> -#   $5 and more - kernel boot files; zImage*, uImage, cuImage.*, etc.
>  #
>
>  # Bail with error code if anything goes wrong
> @@ -41,15 +40,3 @@ fi
>
>  cat $2 > $4/$image_name
>  cp $3 $4/System.map
> -
> -# Copy all the bootable image files
> -path=$4
> -shift 4
> -while [ $# -ne 0 ]; do
> -       image_name=`basename $1`
> -       if [ -f $path/$image_name ]; then
> -               mv $path/$image_name $path/$image_name.old
> -       fi
> -       cat $1 > $path/$image_name
> -       shift
> -done;
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
