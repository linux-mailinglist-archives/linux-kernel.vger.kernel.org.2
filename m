Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057E243DBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhJ1HLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1HLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:11:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 140906103B;
        Thu, 28 Oct 2021 07:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635404928;
        bh=NKOgfVI75LT2kYNlTpP+Imw8FP9ky/mWL0iRbt63IFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=IcTTs2pzI1rBl1mGdMHHWabXHzmvKMBHSIrrvOB/b5XyotUao7s7hLyPJAd68TFjK
         gzqtvyXGeg9Cjqnpg0P5/btMu4b1C4lgfTlHJK6vGuGig5ljCMmP405Pd2n+k3m+Ri
         p7ABWupvO8x+s+ocT6BdfztEKPBzQ53kfi9+NDSbXZyRQKJTjwtnJg38zlJ9QLRAMF
         BmDHkzCNOXpj4E9gP1EPaQNVn+RhdQXxqZa0cEi1/wOCrzlH/Bid0aIqcNDLJqPO2K
         s/72hbenst3ZADM5dbq39xyQFyaq97eo107D6xjmHbqt5CMbuNzYytd3XWanzpjAxR
         9ujDF2apI6QhQ==
From:   SeongJae Park <sj@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon: simplify stop mechanism
Date:   Thu, 28 Oct 2021 07:08:45 +0000
Message-Id: <20211028070845.10445-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027130517.4404-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for this patch!

On Wed, 27 Oct 2021 21:05:17 +0800 Changbin Du <changbin.du@gmail.com> wrote:

> An kernel thread can exit gracefully with kthread_stop(). So we don't need
> a new flag 'kdamond_stop'. And to make sure the task struct is not freed
> when accessing it, get reference of it before termination.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/damon.h |  1 -
>  mm/damon/core.c       | 51 +++++++++++++------------------------------
>  2 files changed, 15 insertions(+), 37 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a14b3cc54cab..50c6eb0dee1f 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -381,7 +381,6 @@ struct damon_ctx {
>  
>  /* public: */
>  	struct task_struct *kdamond;
> -	bool kdamond_stop;
>  	struct mutex kdamond_lock;
>  
>  	struct damon_primitive primitive;
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 46a6afea3030..f37c17b53814 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -390,17 +390,6 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
>  	return sz;
>  }
>  
> -static bool damon_kdamond_running(struct damon_ctx *ctx)
> -{
> -	bool running;
> -
> -	mutex_lock(&ctx->kdamond_lock);
> -	running = ctx->kdamond != NULL;
> -	mutex_unlock(&ctx->kdamond_lock);
> -
> -	return running;
> -}
> -
>  static int kdamond_fn(void *data);
>  
>  /*
> @@ -418,7 +407,6 @@ static int __damon_start(struct damon_ctx *ctx)
>  	mutex_lock(&ctx->kdamond_lock);
>  	if (!ctx->kdamond) {
>  		err = 0;
> -		ctx->kdamond_stop = false;
>  		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
>  				nr_running_ctxs);
>  		if (IS_ERR(ctx->kdamond)) {
> @@ -474,13 +462,15 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
>   */
>  static int __damon_stop(struct damon_ctx *ctx)
>  {
> +	struct task_struct *tsk;
> +
>  	mutex_lock(&ctx->kdamond_lock);
> -	if (ctx->kdamond) {
> -		ctx->kdamond_stop = true;
> +	tsk = ctx->kdamond;
> +	if (tsk) {
> +		get_task_struct(tsk);
>  		mutex_unlock(&ctx->kdamond_lock);
> -		while (damon_kdamond_running(ctx))
> -			usleep_range(ctx->sample_interval,
> -					ctx->sample_interval * 2);
> +		kthread_stop(tsk);
> +		put_task_struct(tsk);
>  		return 0;
>  	}
>  	mutex_unlock(&ctx->kdamond_lock);
> @@ -925,12 +915,8 @@ static bool kdamond_need_update_primitive(struct damon_ctx *ctx)
>  static bool kdamond_need_stop(struct damon_ctx *ctx)
>  {
>  	struct damon_target *t;
> -	bool stop;
>  
> -	mutex_lock(&ctx->kdamond_lock);
> -	stop = ctx->kdamond_stop;
> -	mutex_unlock(&ctx->kdamond_lock);
> -	if (stop)
> +	if (kthread_should_stop())
>  		return true;
>  
>  	if (!ctx->primitive.target_valid)
> @@ -1021,13 +1007,6 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
>  	return -EBUSY;
>  }
>  
> -static void set_kdamond_stop(struct damon_ctx *ctx)
> -{
> -	mutex_lock(&ctx->kdamond_lock);
> -	ctx->kdamond_stop = true;
> -	mutex_unlock(&ctx->kdamond_lock);
> -}
> -
>  /*
>   * The monitoring daemon that runs as a kernel thread
>   */
> @@ -1038,17 +1017,18 @@ static int kdamond_fn(void *data)
>  	struct damon_region *r, *next;
>  	unsigned int max_nr_accesses = 0;
>  	unsigned long sz_limit = 0;
> +	bool done = false;
>  
>  	pr_debug("kdamond (%d) starts\n", current->pid);
>  
>  	if (ctx->primitive.init)
>  		ctx->primitive.init(ctx);
>  	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
> -		set_kdamond_stop(ctx);
> +		done = true;
>  
>  	sz_limit = damon_region_sz_limit(ctx);
>  
> -	while (!kdamond_need_stop(ctx)) {
> +	while (!kdamond_need_stop(ctx) && !done) {
>  		if (kdamond_wait_activation(ctx))
>  			continue;
>  
> @@ -1056,7 +1036,7 @@ static int kdamond_fn(void *data)
>  			ctx->primitive.prepare_access_checks(ctx);
>  		if (ctx->callback.after_sampling &&
>  				ctx->callback.after_sampling(ctx))
> -			set_kdamond_stop(ctx);
> +			done = true;
>  
>  		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
>  
> @@ -1069,7 +1049,7 @@ static int kdamond_fn(void *data)
>  					sz_limit);
>  			if (ctx->callback.after_aggregation &&
>  					ctx->callback.after_aggregation(ctx))
> -				set_kdamond_stop(ctx);
> +				done = true;
>  			kdamond_apply_schemes(ctx);
>  			kdamond_reset_aggregated(ctx);
>  			kdamond_split_regions(ctx);
> @@ -1088,9 +1068,8 @@ static int kdamond_fn(void *data)
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
> -- 
> 2.32.0
> 
