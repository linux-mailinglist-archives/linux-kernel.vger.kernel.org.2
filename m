Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C60B434885
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhJTKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhJTKGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:06:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEDB2610D0;
        Wed, 20 Oct 2021 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634724235;
        bh=lrPMdPFAqscn7Rpjk8b6fNTYESlFC3wEHYb4rxUKF8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=AhjfgR+kfD0iXHN8WahIBAiZsXceoYRbLnAySaQTa/55pvc89T2Oqo748oiscc+Ej
         hFml1/ADubHTsjE4LVECHcS3/Vla2ybT/XiQWK60fMQ55A4k4Bw8UOV4GFtAseeMOv
         UDmhGGqRaVPs7g6FeLC0xKsQIPrsD1YTWQlbT7KWEieYaGvNXoUhqQ5u5DbVrxnfX9
         Bt4UoAYY5kNd76Oc8F1hMebegiSzpAKliDpetlURdSGciiH3JPU9ARMi7Ju/qEXFoB
         92tbrmTLZlt0XLkNGZ60W5z2fJU3QX1X6eYLDCy/FmVuPUzQfDk4MFjt4crnUqK1Ln
         dvu8/SYrioJ2g==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/2] mm/damon/dbgfs: Add adaptive_targets list check before enable monitor_on
Date:   Wed, 20 Oct 2021 10:03:52 +0000
Message-Id: <20211020100352.31747-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <0a60a6e8ec9d71989e0848a4dc3311996ca3b5d4.1634720326.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 17:03:01 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> When the ctx->adaptive_targets list is empty,
> I did some test on monitor_on interface like this.
> 
>     # cat /sys/kernel/debug/damon/target_ids
>     #
>     # echo on > /sys/kernel/debug/damon/monitor_on
>     # damon: kdamond (5390) starts
> 
> Though the ctx->adaptive_targets list is empty, but the
> kthread_run still be called, and the kdamond.x thread still
> be created, this is meaningless.
> 
> So there adds a judgment in 'dbgfs_monitor_on_write',
> if the ctx->adaptive_targets list is empty, return -EINVAL.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/damon.h |  1 +
>  mm/damon/core.c       |  5 +++++
>  mm/damon/dbgfs.c      | 15 ++++++++++++---
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 715dadd21f7c..4fce5f1f6dad 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -316,6 +316,7 @@ void damon_destroy_scheme(struct damos *s);
> 
>  struct damon_target *damon_new_target(unsigned long id);
>  void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
> +bool damon_targets_empty(struct damon_ctx *ctx);
>  void damon_free_target(struct damon_target *t);
>  void damon_destroy_target(struct damon_target *t);
>  unsigned int damon_nr_regions(struct damon_target *t);
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 2f6785737902..c3a1374dbe0b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -156,6 +156,11 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
>  	list_add_tail(&t->list, &ctx->adaptive_targets);
>  }
> 
> +bool damon_targets_empty(struct damon_ctx *ctx)
> +{
> +	return list_empty(&ctx->adaptive_targets);
> +}
> +
>  static void damon_del_target(struct damon_target *t)
>  {
>  	list_del(&t->list);
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index c90988a20fa4..a02cf6bee8e8 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -861,12 +861,21 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
>  		return -EINVAL;
>  	}
> 
> -	if (!strncmp(kbuf, "on", count))
> +	if (!strncmp(kbuf, "on", count)) {
> +		int i;
> +
> +		for (i = 0; i < dbgfs_nr_ctxs; i++) {
> +			if (damon_targets_empty(dbgfs_ctxs[i])) {
> +				kfree(kbuf);
> +				return -EINVAL;
> +			}
> +		}
>  		ret = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
> -	else if (!strncmp(kbuf, "off", count))
> +	} else if (!strncmp(kbuf, "off", count)) {
>  		ret = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
> -	else
> +	} else {
>  		ret = -EINVAL;
> +	}
> 
>  	if (!ret)
>  		ret = count;
> --
> 2.31.0
