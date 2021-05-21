Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201F038CB29
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhEUQht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbhEUQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:37:48 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53C6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:36:23 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g38so28230563ybi.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpKwvjbA34GT8TUG22JN9qkVwoh1EUba8E0GHkNoJmQ=;
        b=em0mpm2yxRHrbVKZJHw81smO2VkQ9WjqoJopTyCk4SqJWcGpmTNpP78rSdPKRktyoY
         lOeRxGxmCvDkgoJ0IipkVaeIOja96VuOBZ8sFpBRc/EAZhB1V6YN7d9FOSgagx9aAc2R
         hJEVKM9bvGL6/DEAuW8p85sv67hEzppiQbZJkx4QKUBI4p8L2Va050y3NU6xyyZrTAzG
         Jw/s6+Y9fAo3ktpu0WkF4KtK32uK9B+K1RNeWhCxiHgxbK1EWSv6yLNiqRaD6ejq8okz
         vyfclJXdfFdoYBnaoB/fk4h0K5/YrDzUADdT9edoHnhIOx36C43X8jNl8R+AbJ+IG9Op
         5BrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpKwvjbA34GT8TUG22JN9qkVwoh1EUba8E0GHkNoJmQ=;
        b=JXsVX2tJei6CA+JWpZ7vP8xuqhsajJX0nL6K+HNXTDzIfUQkYGE8kUcB75ub2Z2IBN
         behNLcfzpS7Lw6hhMOuMCeGqFGFFGtzdPHy7pnta1MQlJ+MTB2eMnJGmq9q2LkFRFyBP
         AZ51CQTKwEXkmRdKuXj0id4lb19DDjuYCHqrJz0P1NL0p1tHhEYYPhmzhfCLI9noGTd/
         VApuHeVfzqZya4SO1M/xJnYS8r29gEo12moqh8m4B2EsALBtjsJPd7N2xVlx0shqJThv
         eTzA7sYQ/BFdw+Ov8bmtvZsq94UGSIcNsbGv4iEH3nCfIwms2LXkPOTCWYY1I0TGNSBm
         jUoA==
X-Gm-Message-State: AOAM530wWe+qRyF1MJKejxYRathLpOPyt4ChjiQg38u6xNLrpuQSbRCW
        P77AUMGL+3ge4uxQEalddUGneh1DFO0mbPxJiUSDm70Ovr0=
X-Google-Smtp-Source: ABdhPJx3+clJGySLK9JidPyGF19/d9TDQINrAuj2Aj9Ysvg873MvjtPP3qfiXIzcHX/4f8BRMsq29XaeGNkWamRXG8g=
X-Received: by 2002:a5b:386:: with SMTP id k6mr16200616ybp.235.1621614982594;
 Fri, 21 May 2021 09:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210521072610.2880286-1-elver@google.com>
In-Reply-To: <20210521072610.2880286-1-elver@google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 21 May 2021 09:36:11 -0700
Message-ID: <CABCJKue8=HO+E596=LkMqFD2wN1=6vB_0+ZRSEnG8tqOz7s2Uw@mail.gmail.com>
Subject: Re: [PATCH] init: verify that function is initcall_t at compile-time
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, ojeda@kernel.org,
        johan@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Fri, May 21, 2021 at 12:26 AM Marco Elver <elver@google.com> wrote:
>
> In the spirit of making it hard to misuse an interface, add a
> compile-time assertion in the CONFIG_HAVE_ARCH_PREL32_RELOCATIONS case
> to verify the initcall function matches initcall_t, because the inline
> asm bypasses any type-checking the compiler would otherwise do. This
> will help developers catch incorrect API use in all configurations.
>
> A recent example of this is:
> https://lkml.kernel.org/r/20210514140015.2944744-1-arnd@kernel.org
>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  include/linux/init.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 045ad1650ed1..d82b4b2e1d25 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -242,7 +242,8 @@ extern bool initcall_debug;
>         asm(".section   \"" __sec "\", \"a\"            \n"     \
>             __stringify(__name) ":                      \n"     \
>             ".long      " __stringify(__stub) " - .     \n"     \
> -           ".previous                                  \n");
> +           ".previous                                  \n");   \
> +       static_assert(__same_type(initcall_t, &fn));
>  #else
>  #define ____define_initcall(fn, __unused, __name, __sec)       \
>         static initcall_t __name __used                         \

This looks like a nice improvement, thank you for sending the patch!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
