Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F57413A85
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhIUTJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhIUTJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:09:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A93EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:07:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k23-20020a17090a591700b001976d2db364so358100pji.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ml/B9AE3unZPxWy+Po9t2eo0Ju6Y8TZgjbb8wuz0J5c=;
        b=jAWtvCGD3Uwu9MO3kfWahPr7jL1eclROA/kmtd77QcOTYJfFk4fqSBE1+2viMb+wAI
         98A7jMhfeq+7CKWQOtuibkHwhgyCJOtw3m1Nddk5odYiwfjn0DUveaeSmnwYyOswFBen
         6fTOk6fH1GfBraI8KTvjdwRN9vEiezuC4UBYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ml/B9AE3unZPxWy+Po9t2eo0Ju6Y8TZgjbb8wuz0J5c=;
        b=ja6YbGVmXHrbCkcQO8TXbbJchi/e+ko0lo9QFRBsFAUCa1ONjBVqeyTKIT4K+KlSBZ
         urNbJmfzPXKSkx177NQlYAuDlPm+llkM1iMgMZKiv7x1KuH0cpwlmovQNTUNSzzec9sn
         oJnJXVwBesf48vrcMXL0i21vOlk55patpz9TB8kVlrBi+vktBlet0dRpcGzHyYgATcwF
         opFQP2rfg8htfaQ8kRpZEwR/M+yCx6ZjVuxCF4IvQ9VhoAFm1puLgjejEcgBuz5ZvxAK
         SkxgR5H2OL+71lpcc6BGhoYDqfUMAOcpT4ajB386dA1eLOsuyhMoDzB1lVuUglVQhT3D
         UY8Q==
X-Gm-Message-State: AOAM531+70VTUaFy+1iDTrYInYGwlyH5h4N5Lo6IKtY++LQ3d/k0TkhI
        FSQ3fQmr+jo+vJweOSeEHsHGPQ==
X-Google-Smtp-Source: ABdhPJxBNntgGV1SogJHsiSuFb6EWrvFr89frBiGL/EqL3090vj0ZVg7K7OXe3sSFWAomsHAji/x4w==
X-Received: by 2002:a17:90b:4d8d:: with SMTP id oj13mr6992187pjb.226.1632251257644;
        Tue, 21 Sep 2021 12:07:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1sm3403151pjg.0.2021.09.21.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:07:36 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:07:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] overflow: Implement size_t saturating arithmetic
 helpers
Message-ID: <202109211204.75043CDF@keescook>
References: <20210920180853.1825195-1-keescook@chromium.org>
 <20210920180853.1825195-2-keescook@chromium.org>
 <aa42ebfa-03b8-93fa-e036-a7507397d0dc@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa42ebfa-03b8-93fa-e036-a7507397d0dc@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 08:51:53AM +0200, Rasmus Villemoes wrote:
> On 20/09/2021 20.08, Kees Cook wrote:
> 
> > + * Internal logic for size_mul(). Takes variable names from UNIQUE_ID
> > + * so that the local variables here will never collide with other local
> > + * variables (for example, with itself).
> > + */
> > +#define __size_mul(factor1, factor2, __factor1, __factor2, __product)	\
> > +({									\
> > +	size_t __product;						\
> > +	size_t __factor1 = (factor1);					\
> > +	size_t __factor2 = (factor2);					\
> > +	if (check_mul_overflow(__factor1, __factor2, &__product))	\
> > +		__product = SIZE_MAX;					\
> > +	__product;							\
> > +})
> > +
> 
> Why can't this just be a static inline taking and returning size_ts,
> avoiding all the unique_id ritual and triple layers of macros?

*hold face* Yeah. I've been doing so much type-agnostic macro work
lately that I completely looked past the characteristics I was
describing for this macro are ... in fact ... how functions actually
work. *sigh* Yes, I'll change all of these to just be static inlines.
If we ever need them as constant expressions, we can fix them then.

> Not that I can see that the __must_check matters much for these anyway;
> if anybody does
> 
>   size_mul(foo, bar);
> 
> that's just a statement with no side effects, so probably the compiler
> would warn anyway, or at least nobody can then go on to do anything
> "wrong". Unlike the check_*_overflow(), which have the (possibly
> wrapped) result in a output-pointer and the "did it overflow" as the
> return value, so you can do
> 
>   check_mul_overflow(a, b, &d);
>   do_stuff_with(d);
> 
> were it not for the __must_check wrapper.
> 
> [Reminder: __must_check is a bit of a misnomer, the attribute is really
> warn_unused_result, and there's no requirement that the result is part
> of the controlling expression of an if() or while() - just passing the
> result on directly to some other function counts as a "use", which is
> indeed what we do with the size wrappers.]

Yeah, all a good point. My knee-jerk reaction is to include __must_check
just because it's "free" here.

Thanks!

-Kees

-- 
Kees Cook
