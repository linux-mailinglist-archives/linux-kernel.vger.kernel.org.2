Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D6A41F572
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 21:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355382AbhJATHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355173AbhJATHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 15:07:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CD4C06177F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 12:05:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y23so7505347lfj.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIyzFyagBnHT8jP6LfBQs4hFyHSv/A2jIyX9+OpUkIE=;
        b=nA4P9JdJGml1jm/hMC5wepVvR3aeNB4EBKNviekcJuiAXO1yBMXi+XAd/mgcCxlbl2
         MkacKDtknLlEqgaVsRRR0HYVEBfgQxtM36Rb6C9w+X8v5ldMr3VQYkbFwRlf6hWoFMAs
         OC/Ko3YbeaSJKK3Qxv/kxTCxFv7ktQQyvoq6E7gFKdHXouxkk7ieZ+EVh6OwoWKyROCt
         dpLND0SWgIXUFCV3GKg2KGnXUfvl6rpPRDEBRtV8t0GnyEhT88YooGRvAIwEMkv62f2c
         3cmVYpaR1RLmQ6bwX419Zi+wCFNJD2nSEJNel7NMxOAONBqUXgGp5vkPtkUenaaEJ8hx
         vX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIyzFyagBnHT8jP6LfBQs4hFyHSv/A2jIyX9+OpUkIE=;
        b=SBp68X1VotxgRVOn7Hc8rDqfMAf2xrQY7WKPrHvX+tq3PALNYxVbFkcketnBSfbJNp
         NYB7N/+wdU+wZBpxVz0AirUo4ChDk0TOMtmMsDZ4q5zZZ3xuXCf7M9Q5tSw/pMS1X65Y
         2wsuqbmCsuvbKL0BOTGm3cZtxHxQ6XJgWPxwmbmybxuu31d4AXTp6sg7LzfsHR9HiOv6
         Uc4GRSHrAicc527gzGcIEaOqcdKrFeFqNreHnwFmyk6dy2CZ+SqsrouasfXOGq1iVPbJ
         3xiID8jXCmdEipMr4GXt1SHtwFKF/FmxXp7oj7cpLgZRgK0dZdeFz8qAjZvuAIUYFPXD
         iHiw==
X-Gm-Message-State: AOAM530FbkLs7RNdBKi3cD4eVpalge7R0vWzuXNDReaMSSyYba55Hu7a
        JgkZNK7QGpYHhPss/cOEnnZviooDZ2OxQHLF3w5HKA==
X-Google-Smtp-Source: ABdhPJw7k2Ejrd33oH7X93vPMhlcsMxINKoeiF3I5eE7NKcckSZiHU8x+5kOur6gKKpbidK9YUU9xE2a1k9qlWmWoec=
X-Received: by 2002:a05:6512:3ba5:: with SMTP id g37mr6867797lfv.651.1633115137559;
 Fri, 01 Oct 2021 12:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210930235754.2635912-1-keescook@chromium.org>
In-Reply-To: <20210930235754.2635912-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 1 Oct 2021 12:05:25 -0700
Message-ID: <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
Subject: Re: [PATCH v4] docs: Explain the desired position of function attributes
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 4:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> While discussing how to format the addition of various function
> attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
> close as possible to Linus's preferences for future reference.
>
> (Though I note the dissent voiced by Joe Perches, Alexey Dobriyan, and
> others that would prefer all attributes live on a separate leading line.)
>
> [1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

While I appreciate you getting the ball across the finish line (having
_any_ documentation to point to in future bikesheds), I can't help but
shake the feeling that the chosen policy will harm the ability of
existing automated code formatting tools from being able to automate
code formatting on the kernel.

> ---
> v4:
> - fix another stray "void"! This is why code needs a compiler... (thx randy)
> ---
>  Documentation/process/coding-style.rst | 30 ++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 42969ab37b34..45b48510f5ec 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -487,6 +487,36 @@ because it is a simple way to add valuable information for the reader.
>  Do not use the ``extern`` keyword with function prototypes as this makes
>  lines longer and isn't strictly necessary.
>
> +When writing a function declarations, please keep the `order of elements regular
> +<https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/>`_.
> +For example::
> +
> + extern __init void * __must_check action(enum magic value, size_t size, u8 count,
> +                                         char *fmt, ...) __printf(4, 5) __malloc;
> +
> +The preferred order of elements for a function prototype is:
> +
> +- storage class (here, ``extern``, and things like ``static __always_inline`` even though
> +  ``__always_inline`` is technically an attribute, it is treated like ``inline``)
> +- storage class attributes (here, ``__init`` -- i.e. section declarations, but also things like ``__cold``)
> +- return type (here, ``void *``)
> +- return type attributes (here, ``__must_check``)
> +- function name (here, ``action``)
> +- function parameters (here, ``(enum magic value, size_t size, u8 count, char *fmt, ...)``, noting that parameter names should always be included)
> +- function parameter attributes (here, ``__printf(4, 5)``)
> +- function behavior attributes (here, ``__malloc``)
> +
> +Note that for a function definition (e.g. ``static inline``), the compiler does
> +not allow function parameter attributes after the function parameters. In these
> +cases, they should go after the storage class attributes (e.g. note the changed
> +position of ``__printf(4, 5)``)::
> +
> + static __always_inline __init __printf(4, 5) void * __must_check action(enum magic value,
> +               size_t size, u8 count, char *fmt, ...)
> +               __malloc
> + {
> +       ...
> + }
>
>  7) Centralized exiting of functions
>  -----------------------------------
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
