Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08E3353442
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhDCOFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 10:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhDCOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 10:05:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D08C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 07:05:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b7so10892666ejv.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkbYgev9qL2BMWr1L6cRiFcLbXU+v6SUrnx3BkXnhug=;
        b=OskhezKveckuC3sNlo4OaMsYJfITcpoSj2Gp/zFZx1ARv+3Y9vB6Dd3eVkfZNrlxzc
         2hu7ChqP5jb8K27n758X0bfGwWgzOhDmiCLxH1Yf7ZkIICGZeED5dZSua4WrU9hpmqQK
         MIo6X82chYccWcE60J+3mx7b0lmvr4jtfviJ93HxIfOdEKYzSrx55thyhrgqlLGJgux4
         WbJj2xapqsAvPgYY6RKf0g0kLn3wx08Hi7GEJq8ngMO/LZF74xIt15OomX935k3VLeU2
         ijqtOo4dNL7G+xqzVM7G0ebP5m9qbvRxXpSqvIECV/QBFq4PbrvZLWPhe+1nMD7oW8He
         oSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkbYgev9qL2BMWr1L6cRiFcLbXU+v6SUrnx3BkXnhug=;
        b=sxnwNAWNUgjHJs9eFqYiZ4IAfjOtwWB0F0b90NhPDV3oAuQu000VZCSdPE0hDddCnQ
         l6TrZgO7urAgWDTLUbDf5T0OM3HKmNb96/f7RAMSOBFl6zlDDsnrZ8xF4ojr5v6NIXXo
         TXKxzYmr+rbsckwTo1dk1e4a6JkKJoPalcVdSHpcL3i2rtkyKQHDtCW5KPoHdkin9h9G
         oc/x78pkzE99mIiCWjf9N46GzTnWmTTsON9OrMqmjUoDDKBapEm/lXJp8vTE9hKiMgaM
         eWpRcVgS7YCAHms7zl+o/4JxRO0dvHOLC/7ABAupzkh6Sx93K5SIjzo14hug17BXjFmg
         bh/A==
X-Gm-Message-State: AOAM533qZbFDbmeKTrlsm93RT0JzrhhhzOkZsegnNHpkX6AEqJFo0JVd
        dlN8Q7OA9GaF+TU3yYH6sdmTZPbdbgsYhbTTD/pPaHcX4s251w==
X-Google-Smtp-Source: ABdhPJwjLJZ4t0V+4o0gvS5Clr1G3GJVriQiBpYopWS895Vd7rMC52nLxNoBSiKjJlAKpuz0vsEiw6+Ui35JQd5ByQ0=
X-Received: by 2002:a17:906:bccb:: with SMTP id lw11mr687488ejb.126.1617458741068;
 Sat, 03 Apr 2021 07:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210403051325.683071-1-pcc@google.com>
In-Reply-To: <20210403051325.683071-1-pcc@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 3 Apr 2021 16:05:30 +0200
Message-ID: <CA+fCnZc+-csYZ+4ao1Y4gmjhej9Rtt9WRzHhEvCee3ePHoydRg@mail.gmail.com>
Subject: Re: [PATCH] kfence: unpoison pool region before use
To:     Peter Collingbourne <pcc@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 7:13 AM Peter Collingbourne <pcc@google.com> wrote:
>
> If the memory region allocated by KFENCE had previously been poisoned,
> any validity checks done using kasan_byte_accessible() will fail. Fix
> it by unpoisoning the memory before using it as the pool region.

Which kasan_byte_accessible() call fails?

KASAN checks shouldn't be performed for KFENCE objects. We have a
number of is_kfence_address() checks in KASAN runtime, but maybe we're
missing some. Perhaps, we should even move those checks into the
high-level wrappers in include/linux/kasan.h.

> Link: https://linux-review.googlesource.com/id/I0af99e9f1c25eaf7e1ec295836b5d148d76940c5
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
>  mm/kfence/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index d53c91f881a4..bb22b0cf77aa 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -633,13 +633,19 @@ static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
>
>  void __init kfence_alloc_pool(void)
>  {
> +       void *pool;
> +
>         if (!kfence_sample_interval)
>                 return;
>
> -       __kfence_pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> -
> -       if (!__kfence_pool)
> +       pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> +       if (!pool) {
>                 pr_err("failed to allocate pool\n");
> +               return;
> +       }
> +
> +       kasan_unpoison_range(pool, KFENCE_POOL_SIZE);
> +       __kfence_pool = pool;
>  }
>
>  void __init kfence_init(void)
> --
> 2.31.0.208.g409f899ff0-goog
>
