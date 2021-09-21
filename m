Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7068D412B14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbhIUCGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbhIUBuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8888DC06AB30
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:06:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p29so72719751lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/UkYUWvQppHg/h6TOvqj/oAgk41M6HSow/5/SrZHMU=;
        b=rsMnFXZppvLGZL3CfEbgfKuxneUnfyJInkdmHVLG8BtzQHhCbMvvrbfHNvF6AFDZ8T
         PxHs8tfG9o/4WvZIJpHkq5A4jQml1PC5etTsYHCEgKR9jyq6QBQ0uEjPYcAbmRIaQa8e
         dchL1erHY4W1CRt0t5SgTAoPHLdhqAzm+bEGgM0CPWTIT/KoCb0OxYR3KrVf92DHuWZ8
         ViK91qEuxhfMJXzi0neGQSKlA6JfhwqSDgNVrMUELnx/wxRG4TTWStkFUrHMnHFmzNnb
         Q80Z8Dq6RMVNOVsN+Ky+O63OHTP2ZtpIJe2fOcQD7ZhEhiBWvcVUHnak7rtWU/2cGf/G
         h7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/UkYUWvQppHg/h6TOvqj/oAgk41M6HSow/5/SrZHMU=;
        b=yKgNQUSthwY21mX2Y5gxB5o7emE6081oBUc9cI2bpsJTH8HgtVUsGJsSpN957n5/1b
         FZQnN79dx8FHVZTfWMoY+93jp/8nal1QyvrMw78hXNxpHwkdIGMKsmVdohM+vx0/6/+e
         eueTO1vUT97/I8HN3z5ECNAfuHNjbgocAew/9fRolgL06CW7/yffDe9Vk8hcoSbSyWIO
         RRjiwGsgEcfWU/CES/R28U4zRR21StH8YJSrzxy1TDRv3vdLNREC7o1EjJCyjofwPBg9
         bE9+adDfp0Ay/IGstk7iv/9L2hsOREroLW22LvdK743Eu5hbyL0dnDYwHWOjON4IbApG
         ONeQ==
X-Gm-Message-State: AOAM530gH0MP20bSRct4QL4aLgTFyErRBwACQRmBo3YgVXVKGXKUyVww
        uSELC02CxKlCkqoT+DiC5rbORBSNpjFFc5JDmox5mw==
X-Google-Smtp-Source: ABdhPJznaJqCc9LFaUArhF7hBN8tCRFGKy1v8jj2zHxLpTMt9pKxLG2KTCj0rg3x8CdKaTFNoNgU4mvdmGQ9i8FXwIk=
X-Received: by 2002:a05:6512:b22:: with SMTP id w34mr5587375lfu.240.1632175605544;
 Mon, 20 Sep 2021 15:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210920180853.1825195-1-keescook@chromium.org> <20210920180853.1825195-2-keescook@chromium.org>
In-Reply-To: <20210920180853.1825195-2-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 20 Sep 2021 15:06:33 -0700
Message-ID: <CAKwvOdnWiBwXq2atuHXYUfGLiHPhmipJmXze-ymtKG_Vmf7w2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] overflow: Implement size_t saturating arithmetic helpers
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 11:09 AM Kees Cook <keescook@chromium.org> wrote:
>
> In order to perform more open-coded replacements of common allocation
> size arithmetic, the kernel needs a saturating (SIZE_MAX) helper for
> addition and multiplication. It is common in allocators, especially on
> realloc, to add to an existing size. For example:
>
>         p = krealloc(map->patch,
>                      sizeof(struct reg_sequence) * (map->patch_regs + num_regs),
>                      GFP_KERNEL);
>
> There is no existing saturating replacement for this calculation, and
> just leaving the addition open coded inside array_size() could
> potentially overflow as well. For example, an overflow in an expression
> for a size_t argument might wrap to zero:
>
>         array_size(anything, something_at_size_max + 1) == 0
>
> Introduce size_mul() and size_add() helpers to perform size_t promotion
> and saturated calculations for use in such allocations. With these
> helpers it is also possible to redefine array_size(), array3_size(),
> flex_array_size(), and struct_size() in terms of the new helpers.
>
> As with the check_*_overflow() helpers, the helpers are wrapped in a
> __must_check function that passes through the size_t result. In order
> for the helpers to be composed with themselves, they must have unique
> variable names to avoid shadowing, so this uses a similar method to what
> is already done in minmax.h for constructing unique names to be passed
> in as arguments to the statement expression that does the actual work.
>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Len Baker <len.baker@gmx.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 140 ++++++++++++++++++++++++---------------
>  lib/test_overflow.c      |  61 +++++++++++++++++
>  2 files changed, 149 insertions(+), 52 deletions(-)
>
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 4669632bd72b..cd154d47807c 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -117,6 +117,77 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>         (*_d >> _to_shift) != _a);                                      \
>  }))
>
> +/*
> + * As with __must_check_overflow() above, this is used to wrap the
> + * size_t output from a statement expression macro.
> + */
> +static inline size_t __must_check __must_check_size(size_t size)
> +{
> +       return size;
> +}
> +
> +/*
> + * Internal logic for size_mul(). Takes variable names from UNIQUE_ID
> + * so that the local variables here will never collide with other local
> + * variables (for example, with itself).
> + */
> +#define __size_mul(factor1, factor2, __factor1, __factor2, __product)  \
> +({                                                                     \
> +       size_t __product;                                               \
> +       size_t __factor1 = (factor1);                                   \
> +       size_t __factor2 = (factor2);                                   \
> +       if (check_mul_overflow(__factor1, __factor2, &__product))       \
> +               __product = SIZE_MAX;                                   \
> +       __product;                                                      \
> +})
> +
> +/**
> + * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
> + *
> + * @factor1: first factor
> + * @factor2: second factor
> + *
> + * Returns: calculate @factor1 * @factor2, where both values are
> + * evaluated as size_t, with any overflow causing the return value to
> + * be SIZE_MAX.
> + */
> +#define size_mul(factor1, factor2)                                     \
> +       __must_check_size(__size_mul(factor1, factor2,                  \
> +                                    __UNIQUE_ID(__factor1_),           \
> +                                    __UNIQUE_ID(__factor2_),           \
> +                                    __UNIQUE_ID(__product_)))
> +
> +/*
> + * Internal logic for size_add(). Takes variable names from UNIQUE_ID
> + * so that the local variables here will never collide with other local
> + * variables (for example, with itself).
> + */
> +#define __size_add(addend1, addend2, __addend1, __addend2, __sum)      \
> +({                                                                     \
> +       size_t __sum;                                                   \
> +       size_t __addend1 = (addend1);                                   \
> +       size_t __addend2 = (addend2);                                   \
> +       if (check_add_overflow(__addend1, __addend2, &__sum))           \
> +               __sum = SIZE_MAX;                                       \
> +       __sum;                                                          \
> +})
> +
> +/**
> + * size_add() - Calculate size_t addition with saturation at SIZE_MAX
> + *
> + * @addend1: first addend
> + * @addend2: second addend
> + *
> + * Returns: calculate @addend1 + @addend2, where both values are
> + * evaluated as size_t, with any overflow causing the return value to
> + * be SIZE_MAX.
> + */
> +#define size_add(addend1, addend2)                                     \
> +       __must_check_size(__size_add(addend1, addend2,                  \
> +                                    __UNIQUE_ID(__addend1_),           \
> +                                    __UNIQUE_ID(__addend2_),           \
> +                                    __UNIQUE_ID(__sum_)))

Is the use of __UNIQUE_ID really necessary? Is the point to avoid some
kind of variable shadowing?  (As opposed to just using names for the
new variables in the scope of the statement expressions? ie.

+#define __size_add(addend1, addend2, __sum)      \
+({                                                                     \
+       size_t __sum;                                                   \
+       if (check_add_overflow((size_t)__addend1, (size_t)__addend2,
&__sum))           \
+               __sum = SIZE_MAX;                                       \
+       __sum;                                                          \
+})

Do the double-underscore-prefixed really need to be a separate
#define, or can their definitions be inlined into the expansion sites;
there seems like there's no other users of the
double-underscore-prefixed versions otherwise. ie.

#define size_add(addend1, addend2) \
  __must_check_size(({ \
    size_t sum;  \
    if (check_add_overflow((size_t)addend1, (size_t)addend2), &sum;  \
      sum = SIZE_MAX;  \
    sum;  \
})

> +
>  /**
>   * array_size() - Calculate size of 2-dimensional array.
>   *
> @@ -128,15 +199,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   * Returns: number of bytes needed to represent the array or SIZE_MAX on
>   * overflow.
>   */
> -static inline __must_check size_t array_size(size_t a, size_t b)
> -{
> -       size_t bytes;
> -
> -       if (check_mul_overflow(a, b, &bytes))
> -               return SIZE_MAX;
> -
> -       return bytes;
> -}
> +#define array_size(a, b)       size_mul(a, b)
>
>  /**
>   * array3_size() - Calculate size of 3-dimensional array.
> @@ -150,65 +213,38 @@ static inline __must_check size_t array_size(size_t a, size_t b)
>   * Returns: number of bytes needed to represent the array or SIZE_MAX on
>   * overflow.
>   */
> -static inline __must_check size_t array3_size(size_t a, size_t b, size_t c)
> -{
> -       size_t bytes;
> -
> -       if (check_mul_overflow(a, b, &bytes))
> -               return SIZE_MAX;
> -       if (check_mul_overflow(bytes, c, &bytes))
> -               return SIZE_MAX;
> -
> -       return bytes;
> -}
> -
> -/*
> - * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
> - * struct_size() below.
> - */
> -static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
> -{
> -       size_t bytes;
> -
> -       if (check_mul_overflow(a, b, &bytes))
> -               return SIZE_MAX;
> -       if (check_add_overflow(bytes, c, &bytes))
> -               return SIZE_MAX;
> -
> -       return bytes;
> -}
> +#define array3_size(a, b, c)   size_mul(size_mul(a, b), c)
>
>  /**
> - * struct_size() - Calculate size of structure with trailing array.
> + * flex_array_size() - Calculate size of a flexible array member
> + *                     within an enclosing structure.
> + *
>   * @p: Pointer to the structure.
> - * @member: Name of the array member.
> + * @member: Name of the flexible array member.
>   * @count: Number of elements in the array.
>   *
> - * Calculates size of memory needed for structure @p followed by an
> - * array of @count number of @member elements.
> + * Calculates size of a flexible array of @count number of @member
> + * elements, at the end of structure @p.
>   *
>   * Return: number of bytes needed or SIZE_MAX on overflow.
>   */
> -#define struct_size(p, member, count)                                  \
> -       __ab_c_size(count,                                              \
> -                   sizeof(*(p)->member) + __must_be_array((p)->member),\
> -                   sizeof(*(p)))
> +#define flex_array_size(p, member, count)                              \
> +       size_mul(count,                                                 \
> +                sizeof(*(p)->member) + __must_be_array((p)->member))
>
>  /**
> - * flex_array_size() - Calculate size of a flexible array member
> - *                     within an enclosing structure.
> + * struct_size() - Calculate size of structure with trailing flexible array.
>   *
>   * @p: Pointer to the structure.
> - * @member: Name of the flexible array member.
> + * @member: Name of the array member.
>   * @count: Number of elements in the array.
>   *
> - * Calculates size of a flexible array of @count number of @member
> - * elements, at the end of structure @p.
> + * Calculates size of memory needed for structure @p followed by an
> + * array of @count number of @member elements.
>   *
>   * Return: number of bytes needed or SIZE_MAX on overflow.
>   */
> -#define flex_array_size(p, member, count)                              \
> -       array_size(count,                                               \
> -                   sizeof(*(p)->member) + __must_be_array((p)->member))
> +#define struct_size(p, member, count)                                  \
> +       size_add(sizeof(*(p)), flex_array_size(p, member, count))
>
>  #endif /* __LINUX_OVERFLOW_H */
> diff --git a/lib/test_overflow.c b/lib/test_overflow.c
> index 7a4b6f6c5473..01a469ff7ff6 100644
> --- a/lib/test_overflow.c
> +++ b/lib/test_overflow.c
> @@ -588,12 +588,73 @@ static int __init test_overflow_allocation(void)
>         return err;
>  }
>
> +struct __test_flex_array {
> +       unsigned long flags;
> +       size_t count;
> +       unsigned long data[];
> +};
> +
> +static int __init test_overflow_size_helpers(void)
> +{
> +       struct __test_flex_array *obj;
> +       int count = 0;
> +       int err = 0;
> +
> +#define check_one_size_helper(expected, func, args...) ({      \
> +       bool __failure = false;                                 \
> +       size_t _r;                                              \
> +                                                               \
> +       _r = func(args);                                        \
> +       if (_r != (expected)) {                                 \
> +               pr_warn("expected " #func "(" #args ") "        \
> +                       "to return %zu but got %zu instead\n",  \
> +                       (size_t)(expected), _r);                \
> +               __failure = true;                               \
> +       }                                                       \
> +       count++;                                                \
> +       __failure;                                              \
> +})
> +
> +       err |= check_one_size_helper(5,        size_add, 2, 3);
> +       err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  1);
> +       err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  3);
> +       err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX, -3);

Sorry, is this ^ case saying that we expect SIZE_MAX + -3 == SIZE_MAX?
This is because the helpers performed unsigned arithmetic on size_t?

> +
> +       err |= check_one_size_helper(6,        size_mul, 2, 3);
> +       err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  1);
> +       err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  3);
> +       err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX, -3);
> +
> +       err |= check_one_size_helper(0, flex_array_size, obj, data, 0);
> +       err |= check_one_size_helper(sizeof(*obj->data),
> +                                    flex_array_size, obj, data, 1);
> +       err |= check_one_size_helper(7 * sizeof(*obj->data),
> +                                    flex_array_size, obj, data, 7);
> +       err |= check_one_size_helper(SIZE_MAX,
> +                                    flex_array_size, obj, data, -1);
> +       err |= check_one_size_helper(SIZE_MAX,
> +                                    flex_array_size, obj, data, SIZE_MAX - 4);
> +
> +       err |= check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0);
> +       err |= check_one_size_helper(sizeof(*obj) + sizeof(*obj->data),
> +                                    struct_size, obj, data, 1);
> +       err |= check_one_size_helper(SIZE_MAX,
> +                                    struct_size, obj, data, -3);
> +       err |= check_one_size_helper(SIZE_MAX,
> +                                    struct_size, obj, data, SIZE_MAX - 3);
> +
> +       pr_info("%d overflow size helper tests finished\n", count);
> +
> +       return err;
> +}
> +
>  static int __init test_module_init(void)
>  {
>         int err = 0;
>
>         err |= test_overflow_calculation();
>         err |= test_overflow_shift();
> +       err |= test_overflow_size_helpers();
>         err |= test_overflow_allocation();
>
>         if (err) {
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
