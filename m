Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA456409E91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbhIMUxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbhIMUxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:53:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126CEC0613BB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:50:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s3so19585780ljp.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8TVqbn8thZCqMP/VrYd9m008Vn/d1QsljDuZZA3Cj3U=;
        b=Kx+QXs7/Gqu+0fT01IBf7AvtFuuKzukMCBr8Uj8Tlirfgy3sBlDb/0dgxW8i2fm4ki
         Cr2wjOBudyMAbTz6hMk9v40PhWKj9nMcIvmb30kyKFZB5RsdvaSnLonYQoWCJky9Fn/q
         rvmHHz1xfT6sAANA+Cql145bvCNIa1CwpBa7ThFjKt5zw9vKElWhqhFhEUwiaxOgfZ8Z
         mc6ZDYEM+0S6oMqPrZMSE/Xi4nZl2oaQoisz2wKEDinJKmadJxfu8MSthUEwUNPCWeqH
         fluefePE4KH12STgQsgozYhaHaImiPkP9T36zeeUIgpXLdwXCdryY+34zNJ9CWrttP02
         lFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TVqbn8thZCqMP/VrYd9m008Vn/d1QsljDuZZA3Cj3U=;
        b=pe+MOCvKICChjuR7T5rR94GDOIRoeGF5nwNxBtQX4AZtwIMccobywOVnRkvj9uLAwb
         /Asw2ukvN9ADsEJgz2/ChOKWowSxqkXS5Qm9skFewyMVBUn7DZM0vV+3OjO5J7B8MQca
         M6dohd7+gkLAeyuDudbtH+zgE0BN5wsT0i+PIbv7wu9s7Wk24cYl7R9Xd/eM5Y7xLN/g
         JQGKo+OXOPx/WCy9r+PtJBFJBiaiCVA74GLN6grzxAT68Ft5C7LKEj4kL5nK+WEA/QLn
         YYArw81hagWtfsLH63B4ab5GPFhhXKulZ/Rqmh4r4HIyDvmCcxsCWEYL8DJO0JuYZ7ZQ
         UxBA==
X-Gm-Message-State: AOAM530P9ybqvsGSDsa94bkR5FN8gYrxh0qhoSkbdHEIrN3TkAo6qVhj
        2vMZqHxzdhpJX8VCt+ngLP0ODj2cT6igwpwYmKViGw==
X-Google-Smtp-Source: ABdhPJy0QpA58fznBHhrAEHivK9kgUxh+cUT8ejPHdCeOcbTpFXS2375qe5rVNCNeV1nKlpokjSe4FcWCpoMJsDrm+0=
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr12530242ljp.526.1631566228215;
 Mon, 13 Sep 2021 13:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210913131113.390368911@linuxfoundation.org> <20210913131114.028340332@linuxfoundation.org>
 <CA+G9fYtdPnwf+fi4Oyxng65pWjW9ujZ7dd2Z-EEEHyJimNHN6g@mail.gmail.com>
 <YT+RKemKfg6GFq0S@kroah.com> <CAKwvOdmOAKTkgFK4Oke1SFGR_NxNqXe-buj1uyDgwZ4JdnP2Vg@mail.gmail.com>
 <CAKwvOdmCS5Q7AzUL5nziYVU7RrtRjoE9JjOXfVBWagO1Bzbsew@mail.gmail.com>
 <CA+icZUVuRaMs=bx775gDF88_xzy8LFkBA5xaK21hFDeYvgo12A@mail.gmail.com>
 <CAKwvOdmN3nQe8aL=jUwi0nGXzYQGic=NA2o40Q=yeHeafSsS3g@mail.gmail.com>
 <CAHk-=whwREzjT7=OSi5=qqOkQsvMkCOYVhyKQ5t8Rdq4bBEzuw@mail.gmail.com>
 <CAKwvOdkf3B41RRe8FDkw1H-0hBt1_PhZtZxBZ5pj0pyh7vDLmA@mail.gmail.com> <CAHk-=wjP2ijctPt2Hw3DagSZ-KgdRsO6zWTTKQNnSk0MajtJgA@mail.gmail.com>
In-Reply-To: <CAHk-=wjP2ijctPt2Hw3DagSZ-KgdRsO6zWTTKQNnSk0MajtJgA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Sep 2021 13:50:17 -0700
Message-ID: <CAKwvOd=ZG8sf1ZOkuidX_49VGkQE+BJDa19_vR4gh2FNQ2F_9Q@mail.gmail.com>
Subject: Re: [PATCH 5.14 018/334] nbd: add the check to prevent overflow in __nbd_ioctl()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Baokun Li <libaokun1@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 1:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Sep 13, 2021 at 1:16 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Do we have access to _Generic in GCC 4.9?
>
> We've ended up using it unconditionally since last year, so yes.

Sorry, grepping would have taken < 1s. I'm very lazy.
http://threevirtues.com/

>
> In fact, the compiler version tests got removed when we raised the gcc
> version requirement to 4.9 in commit 6ec4476ac825 ("Raise gcc version
> requirement to 4.9"):
>
>    "In particular, raising the minimum to 4.9 means that we can now just
>     assume _Generic() exists, which is likely the much better replacement
>     for a lot of very convoluted built-time magic with conditionals on
>     sizeof and/or __builtin_choose_expr() with same_type() etc"
>
> but we haven't used it much since.
>
> The "seqprop" code for picking the right lock for seqlock is perhaps
> the main example, and staring at that code will make you go blind, so
> look away.

Looking at my patch:
https://lore.kernel.org/stable/20210913203201.1844253-1-ndesaulniers@google.com/
I don't think _Generic helps us in the case of dispatching based on
the result of is_signed_type() (the operands could undergo type
promotion, so we'd need lots of cases that are more concisely covered
by is_signed_type()). It could replace the nested checks in div_64
with nested _Generics, I think. Not sure it's a huge win for
readability.  Maybe cut the number of expansions of the parameters in
half though. Let me give it a try just to see what it looks like.
-- 
Thanks,
~Nick Desaulniers
