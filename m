Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F71412D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhIUCzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350464AbhIUCcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:32:41 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9DC061788
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 18:38:38 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so19182508pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 18:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DFo/KdHwALOng6HEKOBq1CxW/zYSviOMlInYDjNQwgY=;
        b=OuKhhOMXdJ3+QJ2ozA4PPnvxrX8DCykNuXiiDbt/su3xfY7jVcPrMLK0mfpZusLlML
         QtWo4MKU9QikB7pvMmx7MBl8nXjsHjFdjk9Bbrt/lgwj00ZSws+05+90r75lgRq+wZer
         GXTJ02LcfJ5FhjYczJXDHdIuBlIMdEQnelzKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DFo/KdHwALOng6HEKOBq1CxW/zYSviOMlInYDjNQwgY=;
        b=PzmQym0GcUOzvxjedkoDnQhnmGrrONK+VK6RFFuVzImH/Bx92hxf00jvuzp4OtQ0gf
         t/qy5U1EmtlCOb4pU0TOz9cVjSUN9W5JLo23Nn2+rgo52alfKiD6RezbUt6tSFPqC6CV
         VXUaCUusPBYe7L+go0Rl6zJguX/9Elt1Cli3B9+kTdgD6zCtdsxiYrznyS3tTJYoc+BE
         khVo0LiJKRBOVi79fABRM3cbjX2r/Rwvuo6lvPF1zNmNEVGDO6s0p74zpbRet3G66NEJ
         Gs24+2GLvAP5ddysRnBiJNPL+JTtjyOqLJD+6X3sSC9385mf5gG3A7mzUXDu5aVwswE6
         uZsQ==
X-Gm-Message-State: AOAM532bbh/HbW24ChhaQra/G4l2clye851V7TYU/RUw1Xc+8MFeeh36
        bltDela22/N321TRjKg6Y3lqqw==
X-Google-Smtp-Source: ABdhPJwQ0WNLQZaaLRrF869CrtQnn2XBfqD1LwJBMsKSPTvdLtrP8Ja03e/kBn7zYU8D8ScKjPQXeg==
X-Received: by 2002:a63:7d46:: with SMTP id m6mr26695743pgn.409.1632188317997;
        Mon, 20 Sep 2021 18:38:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11sm14564267pfl.41.2021.09.20.18.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 18:38:37 -0700 (PDT)
Date:   Mon, 20 Sep 2021 18:38:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] overflow: Implement size_t saturating arithmetic
 helpers
Message-ID: <202109201815.E4D4AEA317@keescook>
References: <20210920180853.1825195-1-keescook@chromium.org>
 <20210920180853.1825195-2-keescook@chromium.org>
 <CAKwvOdnWiBwXq2atuHXYUfGLiHPhmipJmXze-ymtKG_Vmf7w2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnWiBwXq2atuHXYUfGLiHPhmipJmXze-ymtKG_Vmf7w2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 03:06:33PM -0700, Nick Desaulniers wrote:
> On Mon, Sep 20, 2021 at 11:09 AM Kees Cook <keescook@chromium.org> wrote:
> > [...]
> > +/*
> > + * Internal logic for size_add(). Takes variable names from UNIQUE_ID
> > + * so that the local variables here will never collide with other local
> > + * variables (for example, with itself).
> > + */
> > +#define __size_add(addend1, addend2, __addend1, __addend2, __sum)      \
> > +({                                                                     \
> > +       size_t __sum;                                                   \
> > +       size_t __addend1 = (addend1);                                   \
> > +       size_t __addend2 = (addend2);                                   \
> > +       if (check_add_overflow(__addend1, __addend2, &__sum))           \
> > +               __sum = SIZE_MAX;                                       \
> > +       __sum;                                                          \
> > +})
> > +
> > +/**
> > + * size_add() - Calculate size_t addition with saturation at SIZE_MAX
> > + *
> > + * @addend1: first addend
> > + * @addend2: second addend
> > + *
> > + * Returns: calculate @addend1 + @addend2, where both values are
> > + * evaluated as size_t, with any overflow causing the return value to
> > + * be SIZE_MAX.
> > + */
> > +#define size_add(addend1, addend2)                                     \
> > +       __must_check_size(__size_add(addend1, addend2,                  \
> > +                                    __UNIQUE_ID(__addend1_),           \
> > +                                    __UNIQUE_ID(__addend2_),           \
> > +                                    __UNIQUE_ID(__sum_)))
> 
> Is the use of __UNIQUE_ID really necessary? Is the point to avoid some
> kind of variable shadowing?  (As opposed to just using names for the
> new variables in the scope of the statement expressions? ie.

Yes, when composed[1], they would shadow (under -Wshadow). I'd rather
not knowingly add yet more[2] shadowed variables to the kernel. :)

[1] https://godbolt.org/z/1rM6Ko1j3
[2] https://github.com/KSPP/linux/issues/152

> +#define __size_add(addend1, addend2, __sum)      \
> +({                                                                     \
> +       size_t __sum;                                                   \
> +       if (check_add_overflow((size_t)__addend1, (size_t)__addend2,
> &__sum))           \
> +               __sum = SIZE_MAX;                                       \
> +       __sum;                                                          \
> +})
> 
> Do the double-underscore-prefixed really need to be a separate
> #define, or can their definitions be inlined into the expansion sites;
> there seems like there's no other users of the
> double-underscore-prefixed versions otherwise. ie.
> 
> #define size_add(addend1, addend2) \
>   __must_check_size(({ \
>     size_t sum;  \
>     if (check_add_overflow((size_t)addend1, (size_t)addend2), &sum;  \
>       sum = SIZE_MAX;  \
>     sum;  \
> })

Right, there aren't, but that's the way to pass such variable names in.
(See minmax.h.) This also leaves the door open for using these helpers
as constant expressions, if the need arises.

> > +       err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX, -3);
> 
> Sorry, is this ^ case saying that we expect SIZE_MAX + -3 == SIZE_MAX?
> This is because the helpers performed unsigned arithmetic on size_t?

Correct. When I wrote this I hadn't yet found any cases of needing to
shrink an allocation size that followed a common pattern like this. But it
turns out we do have some:

drivers/infiniband/core/sa_query.c:     sa_dev = kzalloc(struct_size(sa_dev, port, e - s + 1), GFP_KERNEL);
drivers/infiniband/core/user_mad.c:     umad_dev = kzalloc(struct_size(umad_dev, ports, e - s + 1), GFP_KERNEL);
drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:        len = struct_size(vti, list, adapter->num_tc - 1);

I'll need to add size_sub() as well.

Thanks for looking this over!

-- 
Kees Cook
