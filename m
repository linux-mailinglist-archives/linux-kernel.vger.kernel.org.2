Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C141869E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 07:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhIZFrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 01:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhIZFrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 01:47:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8848361038;
        Sun, 26 Sep 2021 05:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632635142;
        bh=hFg5IwklbfMfqsMt3D1a9kK21QQ20aDYL7Nh2srwfkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=lY1It5jlU+2Cm2iaURXs5QIt1x3ioZ6wiS5VskQXaNMTUz/siaiI2nmvJk6WFeUn7
         VcNDRZKRHbGnLQ59ahIlP5WYLEJI8bTIyILAOEW7R+F7ps6q7KwNjC/TMVvlBHhTq6
         ByBPCWzscnFYajnradqBjOuBPzBuTcYdAphusD+V6FBLMysmU8r/6UVHfLMxi/Jtsq
         /HSUTHUm/10P17SFzZNAUEzTtkfnozLF5z1AUGaUcdInkLCxjvQ855Fy4C5eOO9qUJ
         5vtK6/BCj6h5qXBeFTNN6V5q/x6HR6yvfanp6W55GVNJBumFGHhLSY+m42rQXfhXPv
         +Di5EPq/YSwqg==
From:   SeongJae Park <sj@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: nullify pointer ctx->kdamond with a NULL
Date:   Sun, 26 Sep 2021 05:45:39 +0000
Message-Id: <20210926054539.11630-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210925215908.181226-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Colin, thank you for the patch!

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently a plain integer is being used to nullify the
> pointer ctx->kdamond. Use NULL instead. Cleans up sparse
> warning:
> 
> mm/damon/core.c:317:40: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks,
SJ

> ---
>  mm/damon/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 874558a790a0..c8665c80577a 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -314,7 +314,7 @@ static int __damon_start(struct damon_ctx *ctx)
>  				nr_running_ctxs);
>  		if (IS_ERR(ctx->kdamond)) {
>  			err = PTR_ERR(ctx->kdamond);
> -			ctx->kdamond = 0;
> +			ctx->kdamond = NULL;
>  		}
>  	}
>  	mutex_unlock(&ctx->kdamond_lock);
> -- 
> 2.32.0
