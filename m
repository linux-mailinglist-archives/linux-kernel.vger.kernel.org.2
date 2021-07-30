Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D953DBFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhG3UY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhG3UYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:24:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85224C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 13:24:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a26so20173967lfr.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhW1Jw1DENMC35TDbXRVr3UzXIX691dUHdyLHQqhvKg=;
        b=pMsQbhstAXAmYIm7x/KJo8DsaFh27rjlna5EJEi5Y2LEKQo42VBLqMQ7F3uoL7aqDc
         7KalHMpeGGtNBwzzAW90LiJeFK5gdUYVoi4oWOAQVO+GksnGO+4p5CHgTDB6dH6HgEDm
         wagLS0ulkCrycuUroE+gCiHrmv36u0gyNEvcaASPoqxxzELVoSydDSKq5wjTfSCA0lSm
         SbhwYnI5joFdBdRkLRNwgRcYwmJ8wcf5TtfGUG+R4n31ZlWrsWPXL9b77Mgk1QDwz1yI
         KYpmqQ8zwiS3F8w42QipdXmgdZ8yqVcnjq0j1g80SwotApygxBDwp0GOdSCwvxJ8QMVe
         X2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhW1Jw1DENMC35TDbXRVr3UzXIX691dUHdyLHQqhvKg=;
        b=myRUdrnaWyLopjBw+d/twigt+DVuRfkDAnuqCJskSZZUa7z4ILak9gr7GX+ZJPsWF9
         GEgjHAdlq3Mo3EQepNHESEXLuZVhvgV7bvcoX9oh8SjwmZsbJ7nwbOOLGayE12c7n8en
         hTX48zVluh3XT6asvAxsMdGxn/TezeZtwyc5qvpw1Ia92M002Xxpph4cgZ7b57CQm/U5
         hCmLhwOecYxrbyVzn6v2fEsVPqV3e6f8ytng1GpxUrEsGS6JkbBP8bmk41dMuXUDm4wE
         tYtYWWXO8M1t6tYKzy3atX3Up5yo7S0RtwLhEuushXro7QIUKiuCS1+mFr66dT6XvJVb
         90Dg==
X-Gm-Message-State: AOAM5310lkL9kZ1VxkLpxU8LLmiTdWjRH3Mt3S/ODV5Gy5lpRJHIDAU2
        KY0FlQZYtGsMkPHZUpwJaTAF+B8d+PfhJOrzuuLI/A==
X-Google-Smtp-Source: ABdhPJyvSrq0KR6B0tuKx+NyIXbuYTNdLjAlogrdD/CfP9mB+76d2GTI/v6xgCFbE43Y6mY1Rj19njas82jQmJyHaAE=
X-Received: by 2002:a05:6512:32aa:: with SMTP id q10mr3148115lfe.368.1627676658562;
 Fri, 30 Jul 2021 13:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210729141937.445051-1-masahiroy@kernel.org> <20210729141937.445051-2-masahiroy@kernel.org>
In-Reply-To: <20210729141937.445051-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Jul 2021 13:24:07 -0700
Message-ID: <CAKwvOd=dkr_GYEO3fdges+saA-7r0b2xWsuMQDex3FNQJgQNCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: make the install target not depend on any
 build artifact
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, Jordan Niethe <jniethe5@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bill Wendling <morbo@google.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 7:22 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The install target should not depend on any build artifact.
>
> The reason is explained in commit 19514fc665ff ("arm, kbuild: make
> "make install" not depend on vmlinux").
>
> Change the PowerPC installation code in a similar way.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  arch/powerpc/boot/Makefile   |  2 +-
>  arch/powerpc/boot/install.sh | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index a702f9d1ec0d..0d165bd98b61 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -445,7 +445,7 @@ $(obj)/zImage.initrd:       $(addprefix $(obj)/, $(initrd-y))
>         $(Q)rm -f $@; ln $< $@
>
>  # Only install the vmlinux
> -install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
> +install:
>         sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
>
>  PHONY += install
> diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
> index 658c93ca7437..14473150ddb4 100644
> --- a/arch/powerpc/boot/install.sh
> +++ b/arch/powerpc/boot/install.sh
> @@ -20,6 +20,20 @@
>  # Bail with error code if anything goes wrong
>  set -e
>
> +verify () {
> +       if [ ! -f "$1" ]; then
> +               echo ""                                                   1>&2
> +               echo " *** Missing file: $1"                              1>&2
> +               echo ' *** You need to run "make" before "make install".' 1>&2
> +               echo ""                                                   1>&2
> +               exit 1
> +       fi
> +}
> +
> +# Make sure the files actually exist
> +verify "$2"
> +verify "$3"
> +
>  # User may have a custom install script
>
>  if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
