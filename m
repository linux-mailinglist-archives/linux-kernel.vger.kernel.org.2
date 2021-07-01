Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152873B95A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhGARpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbhGARpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:45:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C94C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 10:43:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w19so13255144lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5t/eiICJInDaoPzgCkbGyquWwZQG2z8agCSrrhjkWw=;
        b=BoZk87HblOIMHhcA3JOWDsn38hVKRcHQUjkhqOV5B1xlLqWV/kZ+R9udPMbCwa87sl
         6UAyLiXgdH0srcoB9t9t9KQ39Av+nUavAbCdyRRwKurZdJrCo43DSyv0fHbiA6arIRoF
         jIZ/U1h5Xgo6B91m//GEDty2RQlV30/hu5z4r3ANXUFkZjOGr0tt6im+pKQAw3vSLWwO
         t2hPfJnQP3/7zYpOJ/hXlCXViKwCaF+LOJweA/FeS0344DL66IHsQvbYEu6MIyQcJyUu
         GINhw4gAEJJ3sEmkVdzYfYftnQ/1056KDMnrTpsw6fLJy0uzAbLnuVAc8kcVz/I4ooK1
         /U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5t/eiICJInDaoPzgCkbGyquWwZQG2z8agCSrrhjkWw=;
        b=dEpybmWpNlPJyeTvZgaS8kx/QRPJYfAyyZIkxQS8/PScyqirW4jl/lWImok7jzrfZd
         vpM/VicOEO0Rg26D/nVUnFNnfUBDy9Lmjs1lLWxYk6Kp7o7GrQWzCI1F9PM1aVEAKRNa
         oVgR6/Gr/roRISfF3/1e5bpVpj3aRBgUFE55bzYmoOFUwy21Ek4bjrTSdWYBmDw071FO
         nuSmYmsrzobKllFbFrMgf8yhkB1+oQ5svMSTCP4lraDnmX7ZfBFOpfkPPbXeOWY1R3fG
         A+BC3be+kR29fR2Y3dYdZU5GQ+EOyuCW/oPqtJpK1/0M0N48OhFgmy46fYbawSjZpysC
         Ycmg==
X-Gm-Message-State: AOAM531LeJI+VGFRR+mTj2TSvlV9B+fAINd0lOu7o3QK98bIHqv+/5vW
        mnS/a8oFPFrhS3WQfPUhfJqjwzv5tLv7aDCcqTPMv/JH66U=
X-Google-Smtp-Source: ABdhPJzyu1JesxIKgYX0997DHE64yRPefBgiqP3dkWfIIqKK601FKEdirVgejDjCY82RNvVwazpRhnvL5FFZmhyi+lg=
X-Received: by 2002:a19:5f04:: with SMTP id t4mr583484lfb.297.1625161380470;
 Thu, 01 Jul 2021 10:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210701092841.1419-1-lecopzer.chen@mediatek.com> <20210701092841.1419-2-lecopzer.chen@mediatek.com>
In-Reply-To: <20210701092841.1419-2-lecopzer.chen@mediatek.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 1 Jul 2021 10:42:49 -0700
Message-ID: <CAKwvOdkGjz-rH8AHudO3dJmSt+48FSJ8iT-eCacwyeMhWv909w@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/2] Kbuild: lto: add CONFIG_MAKE_VERSION
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     keescook@chromium.org, samitolvanen@google.com,
        linux-kbuild@vger.kernel.org, nathan@kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        yj.chiang@mediatek.com, masahiroy@kernel.org,
        michal.lkml@markovi.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 2:28 AM Lecopzer Chen <lecopzer.chen@mediatek.com> wrote:
>
> To check the GNU make version. Used by the LTO Kconfig.
>
> LTO with MODVERSIONS will fail in generating correct CRC because
> the makefile rule doesn't work for make with version 3.8X.[1]
>
> Thus we need to check make version during selecting on LTO Kconfig.
> Add CONFIG_MAKE_VERSION which means MAKE_VERSION in canonical digits
> for arithmetic comparisons.
>
> [1] https://lore.kernel.org/lkml/20210616080252.32046-1-lecopzer.chen@mediatek.com/
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  Makefile                |  2 +-
>  init/Kconfig            |  4 ++++
>  scripts/make-version.sh | 13 +++++++++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/make-version.sh
>
> diff --git a/Makefile b/Makefile
> index 88888fff4c62..2402745b2ba9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -516,7 +516,7 @@ CLANG_FLAGS :=
>
>  export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
>  export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
> -export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> +export PERL PYTHON3 CHECK CHECKFLAGS MAKE MAKE_VERSION UTS_MACHINE HOSTCXX
>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
>  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 55f9f7738ebb..ecc110504f87 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -86,6 +86,10 @@ config CC_HAS_ASM_INLINE
>  config CC_HAS_NO_PROFILE_FN_ATTR
>         def_bool $(success,echo '__attribute__((no_profile_instrument_function)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
>
> +config MAKE_VERSION
> +       int
> +       default $(shell,$(srctree)/scripts/make-version.sh $(MAKE_VERSION))
> +
>  config CONSTRUCTORS
>         bool
>
> diff --git a/scripts/make-version.sh b/scripts/make-version.sh
> new file mode 100755
> index 000000000000..ce5af96696cc
> --- /dev/null
> +++ b/scripts/make-version.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Print the linker name and its version in a 5 or 6-digit form.

The linker?

> +
> +set -e
> +
> +# Convert the version string x.y.z to a canonical 5 or 6-digit form.
> +IFS=.
> +set -- $1
> +
> +# If the 2nd or 3rd field is missing, fill it with a zero.
> +echo $((10000 * $1 + 100 * ${2:-0} + ${3:-0}))
> --


-- 
Thanks,
~Nick Desaulniers
