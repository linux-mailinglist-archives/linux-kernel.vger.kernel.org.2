Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6243F7C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhJ2HY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhJ2HYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:24:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BD9260238;
        Fri, 29 Oct 2021 07:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635492146;
        bh=t8ppdzxFsp5v6Zb0J/RKUojmjtwxmCEGZi+MQ8JGgOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=kswy1uGbZzYi1OJpZnZFuB0Dvsd1IRbA77F9rQLFZ+HRpAIJUNPfoZrNZYvr9Cu68
         HvoSd8nkmPd0SvlwB0x3LgFSYmQ7MiqAra+1b+cB32fGM2+jUfUaZN6XbkHuKAsSTb
         tFUmzlUje84/OMP31t7V19xB+bBHAsEsoNDkSJfWY5QkNHOBr5cse2Z/fQFO1U0TId
         tfsec9b0NZIZw7mK/Z9esrCY0004bJmmFcOH7iN4J1BDXFatw3ZlySoe8v+CivzmTc
         Fs+rHS+SrUpyvfJzuKGksX/Gj5tb50MdfuN1llGbQKkWD+6orW5yMgOhBmTDfOxVgh
         /mlwXMLKcUxEQ==
From:   SeongJae Park <sj@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: remove return value from before_terminate callback
Date:   Fri, 29 Oct 2021 07:22:18 +0000
Message-Id: <20211029072218.16880-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029005023.8895-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 08:50:23 +0800 Changbin Du <changbin.du@gmail.com> wrote:

> Since the return value of 'before_terminate' callback is never used,
> we make it have no return value.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Thank you for this patch!

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/damon.h | 2 +-
>  mm/damon/dbgfs.c      | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 50c6eb0dee1f..041966786270 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -322,7 +322,7 @@ struct damon_callback {
>  	int (*before_start)(struct damon_ctx *context);
>  	int (*after_sampling)(struct damon_ctx *context);
>  	int (*after_aggregation)(struct damon_ctx *context);
> -	int (*before_terminate)(struct damon_ctx *context);
> +	void (*before_terminate)(struct damon_ctx *context);
>  };
>  
>  /**
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index befb27a29aab..eccc14b34901 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -645,18 +645,17 @@ static void dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
>  		debugfs_create_file(file_names[i], 0600, dir, ctx, fops[i]);
>  }
>  
> -static int dbgfs_before_terminate(struct damon_ctx *ctx)
> +static void dbgfs_before_terminate(struct damon_ctx *ctx)
>  {
>  	struct damon_target *t, *next;
>  
>  	if (!targetid_is_pid(ctx))
> -		return 0;
> +		return;
>  
>  	damon_for_each_target_safe(t, next, ctx) {
>  		put_pid((struct pid *)t->id);
>  		damon_destroy_target(t);
>  	}
> -	return 0;
>  }
>  
>  static struct damon_ctx *dbgfs_new_ctx(void)
> -- 
> 2.32.0
