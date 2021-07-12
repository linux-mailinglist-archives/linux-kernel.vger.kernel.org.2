Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD52D3C63CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhGLTfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhGLTfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:35:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C7C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:32:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a127so17364761pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biBvoLhNGtX6R6KSS5eeNClmIVIiyb/IBsq6BVCuJzE=;
        b=R/P+hxOwSNm+AWShZrzPf5OTy01ZvqCcvpnhwFIOSmWQO9gUSGgZOgab3InxdjfuWT
         JLB8gUJFUhikwtz+J9F/7c0Kso/s4tCB9cp1kT5Ei+0rI1Yh+d12wJ5e7v0WBFCots3A
         AWa8BTmz1NyERVEHJz8DLBexKy6gt85lTBCGhoQKUH1FuSlmVbpNgQzGSDOqbX7zwhJh
         dqexlt8a9soXI1IHGoQ5oN8KjfsdcX8efymIhUgcnwjanuTiqTcRXUOKnuCr9GWo6eZk
         XqSqyhUd9IKnBmAIJtC31JQXYz0nBBwZy0wEg8urQPEJAgMHlpW2/0D/8Juw9UAckP7f
         dbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biBvoLhNGtX6R6KSS5eeNClmIVIiyb/IBsq6BVCuJzE=;
        b=aJxAzQwQUdWwnZo74BTS4Pe+0+le7JeRbJHskWHibdsXM24+i8NTVtD40BmfNjb28R
         K6JzkQ81/L2hkxIjYkJn6+j76BKoiXVqBJbfhKnvV9RlZpAseHKntgw3DRtW2mNlHYpV
         SnokRejC7HBTX5N7t0XQyjCk5vU83Qt01FF3f2otaveHnZ4n9L+E+nFuIzyD5iR/+pS9
         qfXONj3twVpPWouhFoIp0sjH8mvfRmf1K87ilafBLSssKqp/HRdYrYw0tThwt4YXkxoB
         Ec4gItsAF6EFbSYWJX4hXTeCKaXs9zG8iavAST3XzwMApdNP+6+l+7jOR/OaGwmXz76J
         dYhg==
X-Gm-Message-State: AOAM531DTFiarXO+HoD2U0KZfZV6E7P0VSFREeoj13OEYdxoSzJ5tDAL
        eERTw17Smi+XOg6WROJT/9EamflMl69t7OFiewpcZA==
X-Google-Smtp-Source: ABdhPJydReQltwH7zpq2+GDfb8NFl3MD+iNG/25G17yQ9cx34L0AHJ4b1oCbjPdcknQgNR3JJ5oB7Z4IusWx7vqKE6I=
X-Received: by 2002:a65:6659:: with SMTP id z25mr629389pgv.291.1626118375545;
 Mon, 12 Jul 2021 12:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210712153207.39302-1-willy@infradead.org> <9877bef9-b2e8-6a8c-4d68-7df7f3fb71eb@oracle.com>
In-Reply-To: <9877bef9-b2e8-6a8c-4d68-7df7f3fb71eb@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 12 Jul 2021 12:32:44 -0700
Message-ID: <CAHS8izP7Q8VX+kpzzEUML625aPVOJkUADFs-gnBXWF-QaeKKhA@mail.gmail.com>
Subject: Re: [PATCH] mm: Make copy_huge_page() always available
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 10:52 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 7/12/21 8:32 AM, Matthew Wilcox (Oracle) wrote:
> > Rewrite copy_huge_page() and move it into mm/util.c so it's always
> > available.  Fixes an exposure of uninitialised memory on configurations
> > with HUGETLB and UFFD enabled and MIGRATION disabled.
> >
> > Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-By: Mina Almasry <almasrymina@google.com>

> > ---
> >  include/linux/migrate.h |  5 -----
> >  include/linux/mm.h      |  1 +
> >  mm/migrate.c            | 48 -----------------------------------------
> >  mm/util.c               | 10 +++++++++
> >  4 files changed, 11 insertions(+), 53 deletions(-)
>
> Thanks Matthew,
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> --
> Mike Kravetz
