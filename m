Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F4244C177
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhKJMnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231232AbhKJMnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:43:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17F3E61058;
        Wed, 10 Nov 2021 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636548037;
        bh=jc4GnoAH1zLaYyd8wpTtEW+INmncIENQJOMUgkY/0P0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=fe04rNutJYlEc/QoIVbfU7ZNLoZP2S+meh9Nkag1bU6fKlX48O+UtA6R8c5Eh8SVT
         H4wrg97N8ulrIWszccGe4OeRKWVZ66vwBeRsIymK7HWHQgrNEApvohXIzCuRZv7z9l
         QeTzQgJWwFasPOkKuwWMXt4Rc3ik+TvvtSNctFUNluIt7K/5bvP1UfI7odTgHqzLXN
         Hbl0ZLLakQcQvTAschhf5k5qOdPY++Np/bpvtdtAwNFVQ3FCfnZT9hpzPX91X4WTgO
         z6xzVJlHGBEi31Fkphae5pU5q5nOlRm0tuACjhrdb4i28JVnTIy8DnzYw8HbgzY3KG
         zFWG45D5dTuoQ==
From:   SeongJae Park <sj@kernel.org>
To:     alexs@kernel.org
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon: remove damon_lock
Date:   Wed, 10 Nov 2021 12:40:34 +0000
Message-Id: <20211110124034.2574-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110114721.133808-1-alexs@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for this patch, Alex!

On Wed, 10 Nov 2021 19:47:21 +0800 alexs@kernel.org wrote:

> From: Alex Shi <alexs@kernel.org>
> 
> Variable nr_running_ctxs guards by damon_lock, but a lock for a int
> variable seems a bit heavy, a atomic_t is enough.

The lock is not only for protecting nr_running_ctxs, but also for avoiding
different users concurrently executing damon_start(), because that could allow
the users interfering others.

> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: SeongJae Park <sj@kernel.org> 
> Cc: Andrew Morton <akpm@linux-foundation.org> 
> Cc: linux-mm@kvack.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  include/linux/damon.h |  1 -
>  mm/damon/core.c       | 31 +++++--------------------------
>  mm/damon/dbgfs.c      |  8 +++++---
>  3 files changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index b4d4be3cc987..e5dcc6336ef2 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -453,7 +453,6 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
>  		unsigned long min_nr_reg, unsigned long max_nr_reg);
>  int damon_set_schemes(struct damon_ctx *ctx,
>  			struct damos **schemes, ssize_t nr_schemes);
> -int damon_nr_running_ctxs(void);
>  
>  int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
>  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c381b3c525d0..e821e36d5c10 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[...]
> @@ -437,19 +422,15 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
>  	int i;
>  	int err = 0;
>  
> -	mutex_lock(&damon_lock);
> -	if (nr_running_ctxs) {
> -		mutex_unlock(&damon_lock);
> +	if (atomic_read(&nr_running_ctxs))
>  		return -EBUSY;
> -	}
>  
>  	for (i = 0; i < nr_ctxs; i++) {
>  		err = __damon_start(ctxs[i]);
>  		if (err)
>  			break;
> -		nr_running_ctxs++;
> +		atomic_inc(&nr_running_ctxs);
>  	}
> -	mutex_unlock(&damon_lock);
>  
>  	return err;
>  }

This would let multiple concurrent threads seeing nr_running_ctxs of zero and
therefore proceed together.


Thanks,
SJ
