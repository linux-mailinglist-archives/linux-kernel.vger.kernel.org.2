Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290E13E2E46
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhHFQVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhHFQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:21:24 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322FDC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 09:21:07 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id x192so16236341ybe.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 09:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1g7puxrm202RhqkhqVJ0jdDnj+gHqRx1Pn/TRe45VY=;
        b=ZSgW6fw3CIWT31okDRlFQcTrFcT8l65qEdfmz3TZKXYb94+/JcN/c9JpaO+GtuN9BT
         v5vX46xvzv2T61ua9EKXYyo+ICvK8S47xvvCFfMic4SLW6TwFIY0PfC7TDgehJppE1+D
         BhMiHmgvU3V/kkSbwlLE3OZvVnA4Iln4mb6sGY1hdSVvYZXIy1Oax2Mv9giloYidKl7m
         RxrVEVmfTGJzXWi5Z/jLzfPBgiBFdAUXAvjwpzH67uqyFzxX78EZtuRV9dYy0IlPvnRt
         f6e+rRcEbvRpxL70n7j/LCzYB6BWDF7x+O/ABKm86daxV3ytn9Eef0Ang4vfy/ECsAU2
         BgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1g7puxrm202RhqkhqVJ0jdDnj+gHqRx1Pn/TRe45VY=;
        b=LqjtZHTTrN5FFmMAB3ogoWce9ziwQh0zwq3i2ix5ECMHz9CK/itEjOLs31YZcYILWI
         5vO+LCR94yrma5ktodU/sWfx+lkX2NwSeJRreO7Wfpkn4XHesTf4wyRHqLaajzozn2OT
         mi6CTkhzf/vP9RBlQszxuWrJ2xgvgpOW076WkFgpEmv+k21TSwHTtrb5Ox+ZNhrkM0xZ
         rZKwInGKEogs13uMtGN6jO93kTuEQCmOQQqhBGl09VcDM1xCOH4+LqM/fOtKG1Fs9gV9
         facUMs7CojZrEs4V+PPxtufU12Dwg4VNVqjr/Gi8aufsPz2MOEGtX8IXDHHo5UKrZ/DE
         92/A==
X-Gm-Message-State: AOAM530sCLo4olZxmhZpAY/Xdk+eiITdnDLgd5DRlrwBnLvDAVZxJp7Q
        faYcTs5/QyMG65rWUYd//8W9NL4SWXIgFgFVWO3tGg==
X-Google-Smtp-Source: ABdhPJzPXWrdb3mtEhki67zexijTR+ZMXazWQvWl84DH9lHLb8Asg+p+XKn6X1aYaXFs1jSKIuBMSQjtbPJuPoof3Jw=
X-Received: by 2002:a25:2785:: with SMTP id n127mr13814414ybn.235.1628266866064;
 Fri, 06 Aug 2021 09:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <08a2e179-3f5f-639e-946f-54cd07ae12fa@kernel.org> <20210707181814.365496-1-ndesaulniers@google.com>
In-Reply-To: <20210707181814.365496-1-ndesaulniers@google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 6 Aug 2021 09:20:54 -0700
Message-ID: <CABCJKue5Ay6_+8sibzh5wRh3gPzV1g72gJ9m2ot4E1ezj8bpHA@mail.gmail.com>
Subject: Re: [PATCH v4] kallsyms: strip LTO suffixes from static functions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>, "KE . LI" <like1@oppo.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 11:18 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Similar to:
> commit 8b8e6b5d3b01 ("kallsyms: strip ThinLTO hashes from static
> functions")
>
> It's very common for compilers to modify the symbol name for static
> functions as part of optimizing transformations. That makes hooking
> static functions (that weren't inlined or DCE'd) with kprobes difficult.
>
> LLVM has yet another name mangling scheme used by thin LTO.  Strip off
> these suffixes so that we can continue to hook such static functions.
>
> Reported-by: KE.LI(Lieke) <like1@oppo.com>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v3 -> v4:
> * Convert this function to use IS_ENABLED rather than provide multiple
>   definitions based on preprocessor checks.
> * Add Nathan's suggested-by.
>
> Changes v2 -> v3:
> * Un-nest preprocessor checks, as per Nathan.
>
> Changes v1 -> v2:
> * Both mangling schemes can occur for thinLTO + CFI, this new scheme can
>   also occur for thinLTO without CFI. Split cleanup_symbol_name() into
>   two function calls.
> * Drop KE.LI's tested by tag.
> * Do not carry Fangrui's Reviewed by tag.
> * Drop the inline keyword; it is meaningless.
>
>  kernel/kallsyms.c | 43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 4067564ec59f..a10dab216f4f 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -171,26 +171,43 @@ static unsigned long kallsyms_sym_address(int idx)
>         return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
>  }
>
> -#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> -/*
> - * LLVM appends a hash to static function names when ThinLTO and CFI are
> - * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
> - * This causes confusion and potentially breaks user space tools, so we
> - * strip the suffix from expanded symbol names.
> - */
> -static inline bool cleanup_symbol_name(char *s)
> +static bool cleanup_symbol_name(char *s)
>  {
>         char *res;
>
> +       /*
> +        * LLVM appends a suffix for local variables that must be promoted to
> +        * global scope as part of ThinLTO. foo() becomes
> +        * foo.llvm.974640843467629774. This can break hooking of static
> +        * functions with kprobes.
> +        */
> +       if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
> +               return false;
> +
> +       res = strstr(s, ".llvm.");
> +       if (res) {
> +               *res = '\0';
> +               return true;
> +       }
> +
> +       /*
> +        * LLVM appends a hash to static function names when ThinLTO and CFI
> +        * are both enabled, i.e. foo() becomes
> +        * foo$707af9a22804d33c81801f27dcfe489b. This causes confusion and
> +        * potentially breaks user space tools, so we strip the suffix from
> +        * expanded symbol names.
> +        */
> +       if (!IS_ENABLED(CONFIG_CFI_CLANG))
> +               return false;
> +
>         res = strrchr(s, '$');
> -       if (res)
> +       if (res) {
>                 *res = '\0';
> +               return true;
> +       }

Note that starting with https://reviews.llvm.org/D97484, the hash
separator is '.' instead of '$'. It looks like this change will be in
Clang 13.

Sami
