Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B95C3F7E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhHYWJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhHYWJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:09:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC2AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:08:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z2so2107002lft.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8QrabiuUOL5RpIB2bUJcrd5bYgE/GbNoTnPnvGmMIGY=;
        b=pLFAvdXocaGKnG+CfhM8QZSjEylRHuAJ/wcaiGOKcdmAWl3I0FLe8qo3HS+7htgfYv
         LlOeJ2rkbeRn07sqbP6eLa58NOAmAHWKlZYJR7tAbDTWfmPnpU10CnGT0owsSCYzjgdV
         BLmINhIp2eqcvvxT4f8OSzmt0U/pJ20nhQ6juJLDK0inGbJT8pd1876hvRhhuusqOv0q
         IHLv5fScRhF/d6gt4q0+9M+qlyrejDDevvNkFP1wbYei96ZsrC6Gnfkm3bDRQrvY5VWr
         BEj25dAD9RDL334c8gA2RO5Sg59GqGKqxDa2pTn+U8Je6VwInaBUJJZyhk2B2bjpH7h+
         ZJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QrabiuUOL5RpIB2bUJcrd5bYgE/GbNoTnPnvGmMIGY=;
        b=odmqRZtvmFCarc4TpeLQaZbDVlFWW87oKC3iq1bLx+UUJeikhB6wA9UvpOByUirmO5
         tRa8NmRl9p7500uW90P3qdmXQR4oLGXnv3S9O1fcK8OZnNd+7lQ0LpleAhYJggKPSo7M
         WEY4Syi4HcmrMZiV3gN0pJbBBgEOGXK3o/xKskCRXekTl/TM9Dzri2ahOz/vmPguVqWW
         BCnnOCU9rKLJ3IxGGnuHWWrFgPwR1cUh+eT9UN6Q97pa182qi0w395PqzHNYlgSB2yYq
         7U1UawB8D5dvmqFxRWclTuOe/vPMmHyw5BiglbO8b8gwA50BPIble3wRaHHAAICUW2Hr
         3yKA==
X-Gm-Message-State: AOAM530jg2Wfq0NOC17K0aWO1Jt7a3p3BEqpxxasxVSW49UsbpLHa+QE
        OxjBlDEVpvgj51l67R1ymiFhMzKZLvhnEvP9V/WdTw==
X-Google-Smtp-Source: ABdhPJzkDhuzFozlwVe+wwa3G0o4eRmWm94JJUo0qfChZJ4MBNgoDxcylGBnRz0GykDHDpVeeGPBWeyS89G60wPCLSk=
X-Received: by 2002:a05:6512:3a84:: with SMTP id q4mr205725lfu.543.1629929308804;
 Wed, 25 Aug 2021 15:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210825211823.6406-1-nathan@kernel.org>
In-Reply-To: <20210825211823.6406-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 15:08:17 -0700
Message-ID: <CAKwvOdn_3T+sz-5u1Eb8gXDvC3VNyx1vu=1_dxdk30Ucgzqmsw@mail.gmail.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Update ClangBuiltLinux mailing list
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 2:18 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> We are now at llvm@lists.linux.dev.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6b8a720c0bc..8e36f55430de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4504,7 +4504,7 @@ F:        .clang-format
>  CLANG/LLVM BUILD SUPPORT
>  M:     Nathan Chancellor <nathan@kernel.org>
>  M:     Nick Desaulniers <ndesaulniers@google.com>
> -L:     clang-built-linux@googlegroups.com
> +L:     llvm@lists.linux.dev
>  S:     Supported
>  W:     https://clangbuiltlinux.github.io/
>  B:     https://github.com/ClangBuiltLinux/linux/issues
> @@ -4519,7 +4519,7 @@ M:        Sami Tolvanen <samitolvanen@google.com>
>  M:     Kees Cook <keescook@chromium.org>
>  R:     Nathan Chancellor <nathan@kernel.org>
>  R:     Nick Desaulniers <ndesaulniers@google.com>
> -L:     clang-built-linux@googlegroups.com
> +L:     llvm@lists.linux.dev
>  S:     Supported
>  B:     https://github.com/ClangBuiltLinux/linux/issues
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
>
> base-commit: e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
