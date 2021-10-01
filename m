Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC541F4FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355945AbhJASbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355900AbhJASbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:31:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1AFC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 11:29:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so42378408lfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XC32+DbuSvc3K5dOrrGub5C2bY3YFjXWwOoFToPcL9g=;
        b=Mw49pwyec+mQhfmUwcqTLRU0GcSOspfZMzn/u4ez5UMaCbN+gBJGtjUbXoiofdJqGw
         f1m1VNMc8tpuE+HHssN52A9chuyxZ+vlb/1yqBWKficz3tIuDWIna8Yw4xtC4wPp7x0V
         wKDmOQOlRvHqsuljoFiZgxi9pWV7YmNcYXbyznk98DdGBd5+fzBgmKGeQzo5VhaXI7IL
         zFItyqoh5qviDhxRzf0x7cQwbKEsz/8ls8UKpmG6wUhfyQCMixeIr8mB/S6Nco/OiVdo
         oY1lHXR6nOrsfH4Tjtyaaaq8VBaewMpOjIyiL/mDF52mLXxWrv44WPls9n//uUwNq86E
         1Gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XC32+DbuSvc3K5dOrrGub5C2bY3YFjXWwOoFToPcL9g=;
        b=hdwZsRwMbA1TErhgFgtaGJlw8BU4A3HepOPaT1PrWTgHykwziRuzEvX1vLyH1bb/BW
         8ZOwBAW0xGhrbTAWiYLlzxM+B2PGrqdYhwCTdSu5prysZyx0ob+3ELasE+9uxEoXLNhA
         i+9hveN70iqrcNxCT4o+DWHOllr0vT0fG4Ay2iRBKVXHiHwiTEoo2Dvj/PwDZpJn81Zr
         fVI9q0PjI9uD2QYFqT+BzKW8aDAsQwuTJQ+gSYFJc5tXAeZHnpLWv4R802mkp0mxZ/tX
         ZlqrqOS3zcMMIxxVGLF8uDCRu/EdmO515CEI6YhK93fyexgiCjfQt4cPj65BxryWdh0x
         9jrw==
X-Gm-Message-State: AOAM530v67eVQcXiYBRCrK5PAgSwloguVOqY3fuhF0992thkJ3RXl3Eu
        ao/lVtj4ujmv7R9YlFinRtL6Hh7sVTZGhm5WEBftEg==
X-Google-Smtp-Source: ABdhPJzcIqphm5Qo5f+j/zbRdWMuuqzGOG/aC0ZzAOnc/4PyBCrcWeR13pJl06PMrRodjIzJSWqE8CWB6M2puwTDps0=
X-Received: by 2002:a05:6512:705:: with SMTP id b5mr6829134lfs.82.1633112997677;
 Fri, 01 Oct 2021 11:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <CABCJKue6dYBYTJtyX6oE8Lq1LVHcS+vq+Z4cRE2-Tut8GRHjPQ@mail.gmail.com>
 <20210814124224.8551-1-treasure4paddy@gmail.com>
In-Reply-To: <20210814124224.8551-1-treasure4paddy@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 1 Oct 2021 11:29:45 -0700
Message-ID: <CAKwvOdmXtTE15mUb5x7Lq==emFwba7OGLfx9skayP-G9NqeiNQ@mail.gmail.com>
Subject: Re: [PATCH v5] kallsyms: strip CLANG CFI postfix ".cfi_jt"
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc:     jeyu@kernel.org, keescook@chromium.org, nathan@kernel.org,
        samitolvanen@google.com, Miroslav Benes <mbenes@suse.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 5:43 AM Padmanabha Srinivasaiah
<treasure4paddy@gmail.com> wrote:
>
> Clang CFI adds a postfix ".cfi_jt" to a symbols of extern functions.
> For e.g. this breaks syscall tracer that doesn't expect such postfix,
> so strip out the postfix from the expanded symbol.

$ llvm-nm vmlinux | grep -e 'T ' -e 't '
...
ffff800010cce56c t xhci_map_urb_for_dma
ffff800010cce56c t xhci_map_urb_for_dma.86d975cb70058c10e8ae4c2960627264
ffff800011227f28 t xhci_map_urb_for_dma.86d975cb70058c10e8ae4c2960627264.cfi_jt
...

so I think it's not just the `.cfi_jt` that we want to truncate.  Sami
asked me about sending a v5 for
https://lore.kernel.org/lkml/20210707181814.365496-1-ndesaulniers@google.com/;
I was looking to rebase your v5 on my patch, but Sami also noted that
here https://lore.kernel.org/lkml/CABCJKue5Ay6_+8sibzh5wRh3gPzV1g72gJ9m2ot4E1ezj8bpHA@mail.gmail.com/
that the separator was changed from $ to . for other CFI symbols in
clang-13.

So I think I'm going to "combine" our patches to truncate after the
first `.` as long as CONFIG_LTO_CLANG is enabled, but still check for
`$` for clang-12 for CONFIG_CFI_CLANG.  I will credit you with the
Suggested-by tag; stay tuned.

>
> Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
> ---
> Change in v5:
>   - Also remove explcit config check for postfix ".llvm." as LLVM
>     renames even in full LTO case
>
> Change in v4:
>   - Remove redundant check; irrespective of LTO type (THIN/FULL),
>     LTO_CLANG will be always enabled. Hence will be used as entry flag
>     to check various postfix patterns.
>   - And prior to stripping postfix ".cfi_jt", added a comment to
>     justify why we are doing so.
>
> Change in v3:
>   - Modified commit message to indicate fix is for Clang CFI postfix
>   - Rebased on recent patch from ndesaulniers@google.com.
>     https://lore.kernel.org/lkml/
>         20210707181814.365496-1-ndesaulniers@google.com/#t
>   - Fix is enabled even for CONFIG_LTO_CLANG
>
> Change in v2:
>   - Use existing routine in kallsyms to strip postfix ".cfi_jt" from
>     extern function name.
>   - Modified the commit message accordingly
>
>  kernel/kallsyms.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 5cabe4dd3ff4..c8ef618e2a71 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -174,7 +174,7 @@ static bool cleanup_symbol_name(char *s)
>          * foo.llvm.974640843467629774. This can break hooking of static
>          * functions with kprobes.
>          */
> -       if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
> +       if (!IS_ENABLED(CONFIG_LTO_CLANG))
>                 return false;
>
>         res = strstr(s, ".llvm.");
> @@ -194,6 +194,17 @@ static bool cleanup_symbol_name(char *s)
>                 return false;
>
>         res = strrchr(s, '$');
> +       if (!res) {
> +               /*
> +                * In case of non static function symbol <funcsym>,
> +                * the local jump table will have entry as <funcsym>.cfi_jt.
> +                *
> +                * Such expansion breaks some built-in components,
> +                * e.g. syscall tracer. Hence remove postfix ".cfi_jt".
> +                */
> +               res = strstr(s, ".cfi_jt");
> +       }
> +
>         if (res) {
>                 *res = '\0';
>                 return true;
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
