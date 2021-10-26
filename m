Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8292A43B9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbhJZSob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235794AbhJZSoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:44:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCF6B60041;
        Tue, 26 Oct 2021 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635273726;
        bh=uzs4JyciJS1iX0VycLSkqzxbfzK9R2K5JtoJt8LWWY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=nsWcwXl+bu0FrHqIUaLKOI1WV28JSx1M/IGOf6T5FIcARgBmbZ5nnucSJOgHbzI8X
         6EfrlV4QQZm1GasWnxJMMC71Huf//kUJzW4bK6mpSt158k4y4ihXSHp9OKKQRZDamh
         ESI+GRn/hkEftnS2I1O3I4aoECqWS76m/OeqGwyOi4kh5Mtu4EDxuQy+u5LFinfLRn
         QMWWjHlY62yQjsakEl5Bi73IVgqkNwVNmi5vxz+DbHktyTp6drUnyvAGs+lkHVgZdG
         EmSlUxbvHcJZRZ+81L3h8nzpQbeSQ9rqXG46kM30VK43lr5EU9xZGrWO8c3zTjYzug
         LK9qYYgNqJHpg==
From:   SeongJae Park <sj@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: simplify stop mechanism
Date:   Tue, 26 Oct 2021 18:42:03 +0000
Message-Id: <20211026184203.1541-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211026153033.11140-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Changbin,

On Tue, 26 Oct 2021 23:30:33 +0800 Changbin Du <changbin.du@gmail.com> wrote:

> An kernel thread can exit gracefully with kthread_stop(). So we don't need a
> new flag 'kdamond_stop'.  And to make sure the task struct is not freed when
> accessing it, get task struct on start and put it on stop.

We previously considered using kthread_stop() here.  However, we resulted in
current code because kdamond can be self-terminated when all target processes
are invalid[1].

Seems this patch is also not fully prepared for the self-termination case.  I
left some comments below.

[1] https://lore.kernel.org/linux-mm/20210624102623.24563-1-sjpark@amazon.de/

> 
> And since the return value of 'before_terminate' callback is never used,
> we make it have no return value.

This looks nice to me.  Could you please send this again as a separate patch?

> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  include/linux/damon.h |  3 +--
>  mm/damon/core.c       | 59 +++++++++++++------------------------------
>  mm/damon/dbgfs.c      |  5 ++--
>  3 files changed, 20 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a14b3cc54cab..041966786270 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[...]
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[...]  
> @@ -1069,7 +1048,7 @@ static int kdamond_fn(void *data)
>  					sz_limit);
>  			if (ctx->callback.after_aggregation &&
>  					ctx->callback.after_aggregation(ctx))
> -				set_kdamond_stop(ctx);
> +				done = true;
>  			kdamond_apply_schemes(ctx);
>  			kdamond_reset_aggregated(ctx);
>  			kdamond_split_regions(ctx);
> @@ -1088,16 +1067,12 @@ static int kdamond_fn(void *data)
>  			damon_destroy_region(r, t);
>  	}
>  
> -	if (ctx->callback.before_terminate &&
> -			ctx->callback.before_terminate(ctx))
> -		set_kdamond_stop(ctx);
> +	if (ctx->callback.before_terminate)
> +		ctx->callback.before_terminate(ctx);
>  	if (ctx->primitive.cleanup)
>  		ctx->primitive.cleanup(ctx);
>  
>  	pr_debug("kdamond (%d) finishes\n", current->pid);
> -	mutex_lock(&ctx->kdamond_lock);
> -	ctx->kdamond = NULL;
> -	mutex_unlock(&ctx->kdamond_lock);

When kdamond is self-terminating, ctx->kdamond will not be nullfified.  As a
result, this patch can introduce some errors like below:

    # cd /sys/kernel/debug/damon
    # sleep 60 &
    [1] 1926
    # echo $(pidof sleep) > target_ids
    # echo on > monitor_on
    # cat monitor_on
    on
    # # after 60 seconds, sleep finishes and kdamond is self-terminated
    # cat monitor_on
    off
    # echo 42 > target_ids
    bash: echo: write error: Device or resource busy

If we simply restore the nullification here with the mutex locking, we would
result in a deadlock because __damon_stop() calls kthread_stop() while holding
ctx->kdamond_lock.

Also, the reference count of ctx->kdamond, which increased by __damon_start(),
would not be decreased in the case.

If I'm missing something, please let me know.


Thanks,
SJ

[...]
