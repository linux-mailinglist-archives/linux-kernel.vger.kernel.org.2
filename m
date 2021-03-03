Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE44B32C381
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353758AbhCDAF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388055AbhCCUo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:44:56 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A678EC061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 12:44:15 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 2so25954714ljr.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cl+ctiF8TwpQDZm2mYgW/hPoAO7x78R4uvY/MJaEkFA=;
        b=h2CSSdDLIU/zeKn696QCaRkWV/yb8DFw1wD5bB1w4bi0LkwzaW/uDPT3f52XY6AYuA
         T2B5ag44qAfllSWvh8/5nFW/P/UGCyL84+hejUKcd5yeTuGXLLsQhWiIf8A/f3DLbFnd
         yVMVurw5QpOiYDiD/ONDMP3+ADkyxvJE+vPVZwErubBhgf6ZTuAKFjcq/xLRH6CiiNKc
         +KTpjLq9pt4xtVIlEN86r13pNNJPJQqHXku7NCMyqXpw9+4YM3J6ayUbRLI2Lleg94vn
         OtdWN1lGlZfC2+s3GQyqPJ48svd8Ty4MDWqBTJkCdjkouaaR4o4QJ7tJt9/iu/wXadhJ
         MrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cl+ctiF8TwpQDZm2mYgW/hPoAO7x78R4uvY/MJaEkFA=;
        b=iI4YbFjJkEOO4vM6y+tSzkZSGhBllF0Fc8cWXJyVUOTTJ870K3CRFtaz8+ECYL4Oel
         gPBwKtcDO66yzpA3Je3tBJFUlkJZvlDFgufhz23LPyUCfY3lvvLK+z07EXHW10rNT3Ht
         uw1KaPboXACQej45+KlhrZNQrdvz2kknL8fbqCCwL4xyLUnTD4wItIE8QHaD42Z3QkQc
         4Y6EQZInCAh1494I3rGi4+ryWky/H9B8NrSJvjAyq4OkX6UsaLcVAkz9U65YnR7uvSsi
         1AZeXfWbpMLc1Bqp0SNOwe5VAfx3Estr76sk1FuxglQJpekn30miljQXPjrBTnT5UvlZ
         yF7g==
X-Gm-Message-State: AOAM531YvMNeJZLvTobltLLSHbgixiTegDqFbI3hilE5E4OM3Bzd3sed
        e8zN9JEainFM5qSS+hDU72HMJTgMIN0F6jNaUc2B+g==
X-Google-Smtp-Source: ABdhPJyv325AMIUW9yUkAP75vUelvwHcmwmpOJmBZiJKFt9ZIqd62JzQR7c7n6Ss34aOoIiPvjgU9O5VycNJZwzOfqc=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr434582ljc.0.1614804253733;
 Wed, 03 Mar 2021 12:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20210303183333.46543-1-masahiroy@kernel.org> <20210303183333.46543-4-masahiroy@kernel.org>
In-Reply-To: <20210303183333.46543-4-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Mar 2021 12:44:02 -0800
Message-ID: <CAKwvOdmNKKpZY38=ayM3NfU5K_27P_CqkKtLx7CbRw6_mFuxPA@mail.gmail.com>
Subject: Re: [PATCH 4/4] kbuild: dwarf: use AS_VERSION instead of test_dwarf5_support.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 10:34 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The test code in scripts/test_dwarf5_support.sh is somewhat difficult
> to understand, but after all, we want to check binutils >= 2.35.2
>
> From the former discussion, the requrement for generating DRAWF v5 from

^typos: s/requrement/requirement, s/DRAWF/DWARF

(in vim you can `:set spell` (`:set nospell` to disable), there's
probably a nice way to auto set this on buffer entry for a commit
message)

> C code is as follows:
>
>  - gcc + binutils as     -> requires gcc 5.0+ (but 7.0+ for full support)
>  - clang + binutils as   -> requires binutils 2.35.2+
>  - clang + integrated as -> OK

Yes. Thanks for the patch.

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  lib/Kconfig.debug              | 3 +--
>  scripts/test_dwarf5_support.sh | 8 --------
>  2 files changed, 1 insertion(+), 10 deletions(-)
>  delete mode 100755 scripts/test_dwarf5_support.sh
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2779c29d9981..f3337a38925d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -284,8 +284,7 @@ config DEBUG_INFO_DWARF4
>
>  config DEBUG_INFO_DWARF5
>         bool "Generate DWARF Version 5 debuginfo"
> -       depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> -       depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
> +       depends on GCC_VERSION >= 50000 || (CC_IS_CLANG && AS_IS_GNU && AS_VERSION >= 23502) || (CC_IS_CLANG && AS_IS_LLVM)

Would this be more concise as:
+       depends on GCC_VERSION >= 50000 || (CC_IS_CLANG && (AS_IS_LLVM
|| (AS_IS_GNU && AS_VERSION >= 23502))

>         depends on !DEBUG_INFO_BTF
>         help
>           Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support.sh
> deleted file mode 100755
> index c46e2456b47a..000000000000
> --- a/scripts/test_dwarf5_support.sh
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -# Test that the assembler doesn't need -Wa,-gdwarf-5 when presented with DWARF
> -# v5 input, such as `.file 0` and `md5 0x00`. Should be fixed in GNU binutils
> -# 2.35.2. https://sourceware.org/bugzilla/show_bug.cgi?id=25611
> -echo '.file 0 "filename" md5 0x7a0b65214090b6693bd1dc24dd248245' | \
> -  $* -gdwarf-5 -Wno-unused-command-line-argument -c -x assembler -o /dev/null -
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
