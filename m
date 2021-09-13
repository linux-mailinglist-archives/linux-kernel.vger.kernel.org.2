Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADEC409E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbhIMUn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbhIMUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:43:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:42:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id g14so19563589ljk.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWY/EewUPKp73TzxAziJqvXmaqyygdW/b+QHkWc/nhk=;
        b=WUDcnWLSVuipyv/o870gx/3KRDXU/5/pW/w70Iw6g0/mUDCYF5940OAfsqWLvsksEK
         7ykNK7S4TpqCIds/8ffTUxTEHnfLwNVZ/b9beeHJ4pkGgI6UiMzi1Y64I6nBvLCe+zCv
         y2ebJSNNR55jpHO3tEmyEc5E5ilbPqcga0xEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWY/EewUPKp73TzxAziJqvXmaqyygdW/b+QHkWc/nhk=;
        b=lVfopAxdQJROMd7beK+Nwaj+KYvlpi0lR0D0gR6r/QPie2D08GbBQg9KpbzIJcDs6S
         SI0dLZYrTybk7/R+bSnt2LVVZweMKdnwXKsVC7n9AVfE+/WkWdKxhnJmEii98BL1A2Mw
         ERj7nVATicItC500TBtqaAZ3UASnSzipF9zfeyhJ4fTL4Z6tRnXvK7WFG3vTY5vptvhG
         9y1AzfvC8ukm9NAwC4yq3Y0U9k6QBah3NEW/mAk6FQTWrZcoB9mLG7HOwYLiGRPcViU2
         BVX8u1gm/HiWejrN3/sv4LJkK8xqFfV4BNEIxaDTW6+tCFFFadd/qpe2H1UnF1OvaP0w
         XGhw==
X-Gm-Message-State: AOAM530qa31bLNN4Um2DioVZJfrpVcw9kwRs+uaFbe3JHEZabKEPX7F8
        kNIIS528efQEX6WWkhMfg0mX8/7UZtRAFMCATkQ=
X-Google-Smtp-Source: ABdhPJyysJ6RdQ9+XybXJ6DizSAJXtGEBL4/KudMnY6/pR9LuuxM/Z1pLbc9CSYc3FiEmHJk3EUaIg==
X-Received: by 2002:a2e:858e:: with SMTP id b14mr12018526lji.508.1631565759390;
        Mon, 13 Sep 2021 13:42:39 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id i10sm70117lfu.71.2021.09.13.13.42.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:42:36 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id s10so23740646lfr.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:42:36 -0700 (PDT)
X-Received: by 2002:a19:ae15:: with SMTP id f21mr834776lfc.402.1631565756235;
 Mon, 13 Sep 2021 13:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210913131113.390368911@linuxfoundation.org> <20210913131114.028340332@linuxfoundation.org>
 <CA+G9fYtdPnwf+fi4Oyxng65pWjW9ujZ7dd2Z-EEEHyJimNHN6g@mail.gmail.com>
 <YT+RKemKfg6GFq0S@kroah.com> <CAKwvOdmOAKTkgFK4Oke1SFGR_NxNqXe-buj1uyDgwZ4JdnP2Vg@mail.gmail.com>
 <CAKwvOdmCS5Q7AzUL5nziYVU7RrtRjoE9JjOXfVBWagO1Bzbsew@mail.gmail.com>
 <CA+icZUVuRaMs=bx775gDF88_xzy8LFkBA5xaK21hFDeYvgo12A@mail.gmail.com>
 <CAKwvOdmN3nQe8aL=jUwi0nGXzYQGic=NA2o40Q=yeHeafSsS3g@mail.gmail.com>
 <CAHk-=whwREzjT7=OSi5=qqOkQsvMkCOYVhyKQ5t8Rdq4bBEzuw@mail.gmail.com> <CAKwvOdkf3B41RRe8FDkw1H-0hBt1_PhZtZxBZ5pj0pyh7vDLmA@mail.gmail.com>
In-Reply-To: <CAKwvOdkf3B41RRe8FDkw1H-0hBt1_PhZtZxBZ5pj0pyh7vDLmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 13:42:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjP2ijctPt2Hw3DagSZ-KgdRsO6zWTTKQNnSk0MajtJgA@mail.gmail.com>
Message-ID: <CAHk-=wjP2ijctPt2Hw3DagSZ-KgdRsO6zWTTKQNnSk0MajtJgA@mail.gmail.com>
Subject: Re: [PATCH 5.14 018/334] nbd: add the check to prevent overflow in __nbd_ioctl()
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Mon, Sep 13, 2021 at 1:16 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Do we have access to _Generic in GCC 4.9?

We've ended up using it unconditionally since last year, so yes.

In fact, the compiler version tests got removed when we raised the gcc
version requirement to 4.9 in commit 6ec4476ac825 ("Raise gcc version
requirement to 4.9"):

   "In particular, raising the minimum to 4.9 means that we can now just
    assume _Generic() exists, which is likely the much better replacement
    for a lot of very convoluted built-time magic with conditionals on
    sizeof and/or __builtin_choose_expr() with same_type() etc"

but we haven't used it much since.

The "seqprop" code for picking the right lock for seqlock is perhaps
the main example, and staring at that code will make you go blind, so
look away.

            Linus
