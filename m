Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62E3B3BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhFYFE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhFYFE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:04:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4436C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:02:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y13so4110528plc.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5r9y0DuPKIkFXl5HZacGmA+FHZr5TguPZuuivsw9axA=;
        b=fuQDLirew2DROVEKhVG07H1CT9vGGgdcQSbx4lECRGyyaP5bgiifTAzxWJ5P2nf/mw
         z48BgZG1R7uPtDmrrrxs25+zVyzIIWfk0UHF1r43+1FcA2ktAzKxQulx8m4y864I8KX2
         bR1fFOoZvdw7BPZODmSS08Lhmr7e0igQjkEYm1ZZzaF3bjvpaE4uIcXb/b3tCdeJCF1O
         wNipujLgsYrbszeFZskZNnAX4+Brf1A4uqacrspKi6m72p8I9g9OIcG2ZzkRowUEyC9/
         W/NeQ5qZ18vDxEfxh03TvyXPDp6MTbcR6+1xk8/9I6qpC9+KGy/6gzN8HoKnYQ3M4Iks
         sNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5r9y0DuPKIkFXl5HZacGmA+FHZr5TguPZuuivsw9axA=;
        b=HlrDSQDJ6G8l40t7euvHuhE2nflk9wtnzMN+nq44gK8VrkAmjFa1nzK75thLNkUM+D
         bdFvkZC+tJ7uDBuknGQeQlaF5qTFivnY0IoLF42OIw5v9Qs/CWGiJzYmqv+vlx7h7gRb
         64u0gBju9kMQFhEYW33Nn7R7h/JC4tG3/eYRvOl9jloIyEkWVRPQp68czhD82x9qIPvt
         DaKlBgsizlf9AUKbrskW4eVGH0AjNcpf5/ehHWiTBv9a2RzAP32Mh8z+SO2CauMr3ErQ
         IkOGLKhQvYFsweYmmbMyBq6cgBFYcU2TwXsWdU2fxQnfzcnA0mRjRr6/oopgBU5Lst7R
         KgDA==
X-Gm-Message-State: AOAM532DDwHS4aFbRuREFRm79KCmv+o+eWROMiUUDMblCkpSGjRrAR07
        ZeyaN/QXX1oK9bXOnmVnlKofCDTzlal0C1/QXLkutQ==
X-Google-Smtp-Source: ABdhPJxETDHcgLBIFXu00r/zhM7WdGEx7akqu9B5kK/m2vplDtGR6sW7EOilwwcpTb74C9VYycebasMwyL63SXvAKiM=
X-Received: by 2002:a17:90a:14a4:: with SMTP id k33mr6617767pja.13.1624597356423;
 Thu, 24 Jun 2021 22:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210624123930.1769093-1-linmiaohe@huawei.com> <20210624123930.1769093-3-linmiaohe@huawei.com>
In-Reply-To: <20210624123930.1769093-3-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 25 Jun 2021 13:01:53 +0800
Message-ID: <CAMZfGtUNtR3ZPv4m5bBCGdE5GuMR5Bw18_n7YzqB4s6QHyV+Pg@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] [PATCH 2/3] mm/zsmalloc.c: combine two
 atomic ops in zs_pool_dec_isolated()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, ngupta@vflare.org,
        senozhatsky@chromium.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 8:40 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> atomic_long_dec_and_test() is equivalent to atomic_long_dec() and
> atomic_long_read() == 0. Use it to make code more succinct.

Actually, they are not equal. atomic_long_dec_and_test implies a
full memory barrier around it but atomic_long_dec and atomic_long_read
don't.

That RMW operations that have a return value is equal to the following.

smp_mb__before_atomic()
non-RMW operations or RMW operations that have no return value
smp_mb__after_atomic()

Thanks.

>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/zsmalloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 1476289b619f..0b4b23740d78 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1828,13 +1828,12 @@ static void putback_zspage_deferred(struct zs_pool *pool,
>  static inline void zs_pool_dec_isolated(struct zs_pool *pool)
>  {
>         VM_BUG_ON(atomic_long_read(&pool->isolated_pages) <= 0);
> -       atomic_long_dec(&pool->isolated_pages);
>         /*
>          * There's no possibility of racing, since wait_for_isolated_drain()
>          * checks the isolated count under &class->lock after enqueuing
>          * on migration_wait.
>          */
> -       if (atomic_long_read(&pool->isolated_pages) == 0 && pool->destroying)
> +       if (atomic_long_dec_and_test(&pool->isolated_pages) && pool->destroying)
>                 wake_up_all(&pool->migration_wait);
>  }
>
> --
> 2.23.0
>
