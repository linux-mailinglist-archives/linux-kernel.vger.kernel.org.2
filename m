Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7437E3DF28C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhHCQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhHCQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:28:48 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36357C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 09:28:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z18so7996822ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSb2IKKpERpkumP5sU1ao0eAPDF2DFQMa3HuULiiIYU=;
        b=ECRfHDayxKQkXlWojcqT3lbjECAkvI3C+PLPW3HzR3xVClyUuikfbcoLeNsf7qZjQP
         PTXHYkpy44Zru4eFR2klLWWzKjoEsMpj6abT1N7DMb6Ys3F9IblPRSwUN2LrUh1hWOJC
         p+PD94oh9f2eMLXAihi5PAL6Z+mwpSnhWW9OdjjqKEULG3s0Fe5kXE07B+Z02xVe8CWi
         NIVa5skJYvvedltQsBWSVs9Va12QcuhFc37zRCTUfqMZ5nO6eD5+ffNFBFi4InGwuoD7
         /v7G6OOP7WEKAIcfK6s1JcQ/x1y5E/TmEcuNk391EJOKT7+5t1wDim3sZGuIVMqI6u9Z
         ZTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSb2IKKpERpkumP5sU1ao0eAPDF2DFQMa3HuULiiIYU=;
        b=TCwaLDs16r06vhCpWNFH1RmoYkqZae1BMz3MphZ43lB5wnnUbAv9hF+oa+rKnVUFfp
         r798yRcyBWAHQKtgkjfOLE4xtsGJNYwVdBiw5muqTzlwzOu/Tt+eGrxNrBeI1avAjENy
         wi7A84ERWO6GHJ7Ddqiv7zB8Fa0MdH/euh8aBXeDV6KtuVz9PrhE3oBGI4wciJ9OmKWr
         Jm8TWAHQ2sBoYG63+gomSk2qvgGA2KsCaIMTjc8FjS9iPi/ypbR+pUpCtBKZ8K9Cmh5L
         DJKF/g7k26hUS6PuKx6MfvdkKc29scjJy6AaLkBY8yrATQqPcTF5flCoRHNMD4/v0USP
         Fwxg==
X-Gm-Message-State: AOAM530Ag6VNptlxHreswc/mBT6aI1q3OoGSOmvxeRIQBTR+M1BIv8U3
        up2JMmVw4p4tciWwQA5lKgTtM/Q2Eb6LoPX5DEeFug==
X-Google-Smtp-Source: ABdhPJx2nN0RJicb3fn4l75ad0JyGz36/5KQH9kduX6E6hvkdu6Y7YPPEdSiEBu5tQtRzz2FC6AK0vsiOstTSHBZIxY=
X-Received: by 2002:a25:2901:: with SMTP id p1mr29523316ybp.459.1628008115237;
 Tue, 03 Aug 2021 09:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <CABCJKudYRiK0KcMHGHeBFcr+Smwa9EM+NFeBpMo_ePqK+zHz0w@mail.gmail.com>
 <20210729205317.25685-1-treasure4paddy@gmail.com>
In-Reply-To: <20210729205317.25685-1-treasure4paddy@gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 3 Aug 2021 09:28:23 -0700
Message-ID: <CABCJKuei==gaaKw0qH1WkshcRyUbqdS_WGRWr6anYAew1HHT2w@mail.gmail.com>
Subject: Re: [PATCH v3] kallsyms: strip CLANG CFI postfix ".cfi_jt"
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 29, 2021 at 1:54 PM Padmanabha Srinivasaiah
<treasure4paddy@gmail.com> wrote:
>
> Clang CFI adds a postfix ".cfi_jt" to a symbols of extern functions.
> For example this breaks syscall tracer that doesn't expect such postfix,
> so strip out the postfix from the expanded symbol.
>
> Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
> ---
>
> Change in v3:
>   - Modified commit message to indicate fix is for Clang CFI postfix
>   - Rebased on recent patch from ndesaulniers@google.com.
>   - Fix is enabled even for CONFIG_LTO_CLANG
>
> Change in v2:
>   - Use existing routine in kallsyms to strip postfix ".cfi_jt" from
>     extern function name.
>   - Modified the commit message accordingly
>
>  kernel/kallsyms.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 5cabe4dd3ff4..67d015854cbd 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -174,7 +174,8 @@ static bool cleanup_symbol_name(char *s)
>          * foo.llvm.974640843467629774. This can break hooking of static
>          * functions with kprobes.
>          */
> -       if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
> +       if (!(IS_ENABLED(CONFIG_LTO_CLANG) ||
> +             IS_ENABLED(CONFIG_LTO_CLANG_THIN)))

This is redundant. LTO_CLANG is selected for both LTO modes, so
there's no need to also check for LTO_CLANG_THIN here.

>                 return false;
>
>         res = strstr(s, ".llvm.");

However, we should probably check for ".llvm." only with LTO_CLANG_THIN.

> @@ -184,16 +185,24 @@ static bool cleanup_symbol_name(char *s)
>         }
>
>         /*
> -        * LLVM appends a hash to static function names when ThinLTO and CFI
> -        * are both enabled, i.e. foo() becomes
> -        * foo$707af9a22804d33c81801f27dcfe489b. This causes confusion and
> -        * potentially breaks user space tools, so we strip the suffix from
> -        * expanded symbol names.
> +        * LLVM appends a hash to static function names when both
> +        * (Thin/FULL) LTO and CFI are enabled, i.e. foo() becomes
> +        * foo$707af9a22804d33c81801f27dcfe489b.

That's not quite right, the hash is only appended with ThinLTO. I
would leave this comment untouched.

> +        *
> +        * In case of non static function symbol <funcsym>,
> +        * the local jump table will have entry as <funcsym>.cfi_jt.
> +        *
> +        * This causes confusion and potentially breaks
> +        * user space tools and some built-in components.
> +        * So we strip the suffix from expanded symbol names.
>          */
>         if (!IS_ENABLED(CONFIG_CFI_CLANG))
>                 return false;
>
>         res = strrchr(s, '$');
> +       if (!res)
> +               res = strstr(s, ".cfi_jt");

And add a comment about stripping .cfi_jt from jump table symbols
before this part.

> +
>         if (res) {
>                 *res = '\0';
>                 return true;
> --
> 2.17.1
>

Sami
