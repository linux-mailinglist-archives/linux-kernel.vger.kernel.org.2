Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EC93A3DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFKINq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:13:46 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:42617 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKINp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:13:45 -0400
Received: by mail-pg1-f173.google.com with SMTP id i34so1817339pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oB6+mhaZq1/S8zvcB9kBZ21qORgpvon6mGB7EKZH3nI=;
        b=c1gimOBP+ScWyp4SxGsA/TqWIYR9V4xIOyTge6SNhG6OFiClnQO6XgQvsKoQGD+87A
         Kq+5rMTlG3iyvwbvVUXEJBpJdGKNwc4GJnHFkm28uSbNte5j+2UzraUYLDRxIV8bUcwn
         uSrwJKAzf/m256pn4d04Q1/WAPT+IuQCG7nLhiWvUIzBpzefeNrYqvVMpfqk4nHUqKuL
         RdDjxLnfhtYiwY5JwJ7NA1haEO5LYhsASGUAQRiiIHnN1NaJ7oZaxScLuhAzGYGxUNuE
         MDVM1VDxxZeN3KdYtHDZcpbK7LRUl/KDuYQgVBxvz4BCsRBxXkORjNVP0cwMDrqLHdyn
         6QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oB6+mhaZq1/S8zvcB9kBZ21qORgpvon6mGB7EKZH3nI=;
        b=hkLHiLavghPmUptvwNZUlJtlJvRiAryF0iTdIUrmMj5R8WGQ/UlSjBlqSR2On4Vyg1
         7gTS/h0ahxaVEefmEAhE5GkLPHJ4zu/dWo+5xsA16px+tgMTq4t5LpXfqBTERoqbCXiv
         y1D+aNanyfYY1wnvXyYq6GESJn2l+MAH9rXh0171kKzr1GgiJgd19BuuO1AA5efVtfDA
         sXctBh39Kwb+GU50HQa98E0Zjk7fZMJZYzSBSAupndYfCH9HmUXRT16mgMX/hDP4Kx0+
         B9hVQftnmnDcEcqaQu3wmkL41PFJB14XZmNxba5aZI/4UN5QqbEQymxQtnWLWUMhueFi
         lnKA==
X-Gm-Message-State: AOAM531KLJlm2Fxjcre938YNaii2Ojat8eWc341YE/kIA+KAGyA/OUOv
        RbK5hsbetLWvgAmD5Ao+EIvKuC4StGk50IdBwdI=
X-Google-Smtp-Source: ABdhPJxHPElraPZkxHHX9IaCR+0D2pBnlkdkVWY5S1pg1ayQcF+Lq4QXp0Ihg5gMOYbY7xd4+klO6qIXRcRzLHpmi1A=
X-Received: by 2002:a62:e404:0:b029:2ee:f086:726f with SMTP id
 r4-20020a62e4040000b02902eef086726fmr7074250pfh.7.1623399047338; Fri, 11 Jun
 2021 01:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210611071241.16728-1-thunder.leizhen@huawei.com> <CAHp75Vdpgpa=TDt5RgG2Eq_+iLZrRSj9XqB97y01SxhdKUYYgg@mail.gmail.com>
In-Reply-To: <CAHp75Vdpgpa=TDt5RgG2Eq_+iLZrRSj9XqB97y01SxhdKUYYgg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 11:10:31 +0300
Message-ID: <CAHp75VdJJdPTnUMVqjwMv+73nQf_-0nosS5su-GiDFRAVCbMyw@mail.gmail.com>
Subject: Re: [PATCH 0/3] scripts/spelling.txt: add some spelling pairs and reorder
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 11:02 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jun 11, 2021 at 10:19 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >
> > Add spelling_sanitizer.sh and use it to reorder, then add some spelling
> > "mistake||correction" pairs.
>
> The sorting idea is good, but the order is not.
> What you really need is to use language corpus [1] instead. So in such
> case you will eliminate false positives (to some extent).

Perhaps I need to elaborate what I meant. The (important) feature of
the corpus is sorting by frequency of the word usage. That's what
would be the best. Unfortunately I don't know if codespell uses linear
search or hash based (i.o.w. does it convert the input file to the
Python list() or set() object?).

> [1]: https://en.wikipedia.org/wiki/Corpus_of_Contemporary_American_English


-- 
With Best Regards,
Andy Shevchenko
