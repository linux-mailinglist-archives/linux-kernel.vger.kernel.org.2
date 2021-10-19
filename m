Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27953433B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhJSPwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:32934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhJSPwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:52:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA28D610CC;
        Tue, 19 Oct 2021 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634658594;
        bh=//aSf488iOwsBGJ5XsBtanerGR/joEI23orGPxMdgRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=ZDPgsdC28OzFPax++9DOanfuZUyMbIh6wmAXTUhc7HWmMRv+FR6ywCquvL0V7umpX
         ccShfRvZ8sg0MEsMiOZqpz3EGkcBcxfcS2JWuZ1W/aFxnRM9W6nZkgT4bmtMsfTTHu
         u/BLZLqF5MOswUEPUW2iyLofZRauP4Am+QL0ptLhjhYrmxsfOrVbt1E2RIaEAE2FwY
         M42/ojtzgcIe0cUBgI5O95U0Fi+EEL1b28rCuFOOhyLhrK3knuPgNpwbO6L6twKLr8
         efVwalsoEy4DkBObQcRnwTZsKwt9E50OEEk5gBst9pwbb+YnrLwqIJKabmXa1eO/lI
         YJTq/rAnYVCgw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Xin Hao <xhao@linux.alibaba.com>, sjpark@amazon.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/dbgfs: Add adaptive_targets list check before enable monitor_on
Date:   Tue, 19 Oct 2021 15:49:51 +0000
Message-Id: <20211019154951.17570-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019154243.17474-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 15:42:43 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello Xin,
> 
> On Tue, 19 Oct 2021 22:26:04 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> 
> > When the ctx->adaptive_targets list is empty,
> > i did some test on monitor_on interface like this.
> 
> s/i/I/
> 
> > 
> > echo on > /sys/kernel/debug/damon/monitor_on
> > [  851.988307] damon: kdamond (5390) starts
> 
> Could you please add four spaces in the beginning of this example terminal
> outputs?  Also, I think confirming targets are empty like below before writing
> 'on' could make this example better.
> 
>     # cat /sys/kernel/debug/damon/target_ids
>     #
> 
> or, like below.
> 
>     # echo > /sys/kernel/debug/damon/target_ids
> 
> > 
> > Though the ctx->adaptive_targets list is empty, but the
> > kthread_run still be called, and the kdamond.x thread still
> > be created, this is meaningless.
> > 
> > So there adds a judgment in 'dbgfs_monitor_on_write',
> > if the ctx->adaptive_targets list is empty, return -EINVAL.
> > 
> > Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> > ---
> >  include/linux/damon.h |  1 +
> >  mm/damon/core.c       |  5 +++++
> >  mm/damon/dbgfs.c      | 10 ++++++++--
> >  3 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 715dadd21f7c..06acf73fe9db 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -316,6 +316,7 @@ void damon_destroy_scheme(struct damos *s);
> > 
> >  struct damon_target *damon_new_target(unsigned long id);
> >  void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
> > +int damon_target_empty(struct damon_ctx *ctx);
> 
> Seems 'bool' would be better for the return type?

Also, I think 'damon_targets_empty()' (s/target/targets/) might be a better
naming?


Thanks,
SJ

> 
> >  void damon_free_target(struct damon_target *t);
> >  void damon_destroy_target(struct damon_target *t);
> >  unsigned int damon_nr_regions(struct damon_target *t);
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 2f6785737902..c651b49249e5 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -156,6 +156,11 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
> >  	list_add_tail(&t->list, &ctx->adaptive_targets);
> >  }
> > 
> > +int damon_target_empty(struct damon_ctx *ctx)
> > +{
> > +	return list_empty(&ctx->adaptive_targets);
> > +}
> > +
> >  static void damon_del_target(struct damon_target *t)
> >  {
> >  	list_del(&t->list);
> > diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> > index 38188347d8ab..bac42dd358d1 100644
> > --- a/mm/damon/dbgfs.c
> > +++ b/mm/damon/dbgfs.c
> > @@ -865,9 +865,15 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
> >  		return -EINVAL;
> >  	}
> > 
> > -	if (!strncmp(kbuf, "on", count))
> > +	if (!strncmp(kbuf, "on", count)) {
> > +		int i;
> > +
> > +		for (i = 0; i < dbgfs_nr_ctxs; i++) {
> > +			if (damon_target_empty(dbgfs_ctxs[i]))
> > +				return -EINVAL;
> > +		}
> >  		err = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
> > -	else if (!strncmp(kbuf, "off", count))
> > +	} else if (!strncmp(kbuf, "off", count))
> >  		err = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
> >  	else
> >  		err = -EINVAL;
> 
> Please use braces for all above branches:
> 
> https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces
> 
> 
> Thanks,
> SJ
> 
> > --
> > 2.31.0
