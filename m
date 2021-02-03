Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493AD30E5B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhBCWIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhBCWIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:08:17 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51707C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 14:07:37 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b17so623986plz.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 14:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6nZdZyk4cH0guJm7TA6JaoVqo+CNeeIlXeJNiI+3dI=;
        b=MDAP/eOyJy2lLRV2njIwZye57EAfQn1v33TuV0rUk3u5svfE2hlXs/aC/RkJkGb8Wh
         tfybo+8vff3Q2vA82M6DfxqrTjJ5he4k1vw6IkYyQKbtbtxZKiFWoYSOmef4fyxTLN9E
         gVzPEKF0+DqI2WeLEMc5uurPlld/oYdLePCpgm2fMM8aClQz2g7HDORwJ8KL/DNZ6K3b
         7LLfPzz0x1Mza6inYgy04szuCR6vmgp7duYjR5sMcdx7n8erWYxLIhRR1ijOzZ3WMlU8
         8vypav5+NYE0btO/oLLEiPLZl8O78JQmcjksUfIURRZgA/D6mwHoexZh9bo2HK0zDVtP
         Lm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6nZdZyk4cH0guJm7TA6JaoVqo+CNeeIlXeJNiI+3dI=;
        b=n/X2JXQ86diqNxeiCaemiZYQXC1imUwd3GpJdHiRmjMAiXAXCSbX33HEeMyhAmmqLo
         PssW/i/uVtma2rDmVjaP3pa4pjMIbgc/p+Z8zNHJDlFR3oaKtbws6tu2LFUKoW0lBIzu
         5eKtIq45rSJ8mSvshbrwIzKxiqAp2uLHPr5YrNkBMgMfxkY5twcPrPpCvVdD/FzUQoll
         cpMFg3jKo5taPkwz+BMiJb427a9ULWMJPcF156tzPc/yufKAOUAA7PySyy4PUHUp4gEp
         bklAsjDMfz21WLuMYcQ/Ln5QTkLxkhuf1gbleGWiK6sV0kys3hy8pdyC8E/ypYezJtvi
         G4lA==
X-Gm-Message-State: AOAM530Mauex6oZEea2yHuPfZll2j933JpPJ/rHrNqFLwIkbUYH4R64S
        exVFfNjxZNPOzX0Jbg+IWRQJRuXhRRbCrB/HJBc50g==
X-Google-Smtp-Source: ABdhPJx5PbI0c93PY14tyfKbVB1kPb7dTK1+9x0Mb901n15BRLBlw78ekqBQ8sYp7yU1lz08DLbVL8zmFAB6igqi5SY=
X-Received: by 2002:a17:90a:db05:: with SMTP id g5mr5288285pjv.32.1612390056670;
 Wed, 03 Feb 2021 14:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20210202060604.711160-1-masahiroy@kernel.org>
In-Reply-To: <20210202060604.711160-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Feb 2021 14:07:24 -0800
Message-ID: <CAKwvOdkA7q-n4uwK3u3tvgMmVhypsE4xSCBcd-oFY0XHLnQ7Qw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/clang-tools: switch explicitly to Python 3
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 10:06 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> For the same reason as commit 51839e29cb59 ("scripts: switch explicitly
> to Python 3"), switch some more scripts, which I tested and confirmed
> working on Python 3.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Nathan Chancellor <nathan@kernel.org>

Thanks Masahiro.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v2:
>  - Drop the spdxcheck.py change. The same fix exists in linux-next.
>
>  scripts/clang-tools/gen_compile_commands.py | 2 +-
>  scripts/clang-tools/run-clang-tools.py      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 19963708bcf8..8ddb5d099029 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Copyright (C) Google LLC, 2018
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> index fa7655c7cec0..f754415af398 100755
> --- a/scripts/clang-tools/run-clang-tools.py
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Copyright (C) Google LLC, 2020
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
