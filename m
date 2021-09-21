Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A75412ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhIUGxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhIUGxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:53:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7256AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 23:51:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m3so74977385lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 23:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PmUxxAm5ITAvyghfA6bZRCHhMyqlvP3QCz/768ov8hk=;
        b=L81ihPf8T/6RIYGvnE/E9n7EHP7Hd3sCSeIqlj3OiJeqRcQzr8dejHXnCAI5Fo6+pX
         Q+1IN5cltLOKdviNX24mROUyqLgXPTKwu/+ORjVMGAEXnMEDrTcSH7gQofpjwWgpjoHn
         YAM66EmWr4XOqMOZvjC7qnGTjkd7DFe/FzkFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PmUxxAm5ITAvyghfA6bZRCHhMyqlvP3QCz/768ov8hk=;
        b=VIfLa12mwLt0NJQgaqlR++3BIuYZ3igECkQuVY+hvNYYlMaCyKoU+bV0v0aDNlo34h
         RKFqBM0axQ7KFSQmDLh5DT1BF7QaLxZGyoEG9sQWdTPvqDpenEPbyNZHTDUmQi1MKrcP
         Y1i0vgRWLdOvz4BhAWby8M3GvJE8CQVJ16/iFEbsfm7WoJeOPeEdPvg/uu5ekjJ/hHVE
         gumCwkFt03dM/eiMDj1OGaX2sMOz2Ydbin0nyFya7/MROtYzbi9nn66OUil/Bc2F3prD
         WxcdU4KEGrL7e25VU0uIcMZfbbacoO0Mj1GGXqm477lxvVop/r7pdG1CLF574d5SYFpr
         jerw==
X-Gm-Message-State: AOAM530GaAVOd8X5P2uF048kVWKvfO60+HxS9jHV8+ziEbJc+9zAajco
        5TRnsGjRnw9j1zCNasy/knuTCQ==
X-Google-Smtp-Source: ABdhPJx205uFeWJsT1qKB3UGV8PqKxzeu5VH/UsdWQwaniWffUyNryustBoKw+e7i87dFLYJ5skltg==
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr15740974lfq.597.1632207114820;
        Mon, 20 Sep 2021 23:51:54 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l23sm1442544lfe.159.2021.09.20.23.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 23:51:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] overflow: Implement size_t saturating arithmetic
 helpers
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210920180853.1825195-1-keescook@chromium.org>
 <20210920180853.1825195-2-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <aa42ebfa-03b8-93fa-e036-a7507397d0dc@rasmusvillemoes.dk>
Date:   Tue, 21 Sep 2021 08:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920180853.1825195-2-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 20.08, Kees Cook wrote:

> + * Internal logic for size_mul(). Takes variable names from UNIQUE_ID
> + * so that the local variables here will never collide with other local
> + * variables (for example, with itself).
> + */
> +#define __size_mul(factor1, factor2, __factor1, __factor2, __product)	\
> +({									\
> +	size_t __product;						\
> +	size_t __factor1 = (factor1);					\
> +	size_t __factor2 = (factor2);					\
> +	if (check_mul_overflow(__factor1, __factor2, &__product))	\
> +		__product = SIZE_MAX;					\
> +	__product;							\
> +})
> +

Why can't this just be a static inline taking and returning size_ts,
avoiding all the unique_id ritual and triple layers of macros?

> -static inline __must_check size_t array_size(size_t a, size_t b)
> -{
> -	size_t bytes;
> -
> -	if (check_mul_overflow(a, b, &bytes))
> -		return SIZE_MAX;
> -
> -	return bytes;
> -}
> +#define array_size(a, b)	size_mul(a, b)

For example, it could be the very function that you remove here and then
add a compat alias. IDGI, if you want that functionality by another
name, just rename array_size, or let size_mul be a #define for array_size.

And we don't have a size_add, but that could just as well be a static
inline that has the __must_check itself.

Not that I can see that the __must_check matters much for these anyway;
if anybody does

  size_mul(foo, bar);

that's just a statement with no side effects, so probably the compiler
would warn anyway, or at least nobody can then go on to do anything
"wrong". Unlike the check_*_overflow(), which have the (possibly
wrapped) result in a output-pointer and the "did it overflow" as the
return value, so you can do

  check_mul_overflow(a, b, &d);
  do_stuff_with(d);

were it not for the __must_check wrapper.

[Reminder: __must_check is a bit of a misnomer, the attribute is really
warn_unused_result, and there's no requirement that the result is part
of the controlling expression of an if() or while() - just passing the
result on directly to some other function counts as a "use", which is
indeed what we do with the size wrappers.]

Rasmus
