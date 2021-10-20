Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106B7434697
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhJTIOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhJTIOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:14:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2C2B60F46;
        Wed, 20 Oct 2021 08:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634717556;
        bh=RK6eiA3Ff133h/eqM6N0sgj9Q8kr6wnbFVmSUumeQMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=qNecR+mfFmE26/nylO0Fu1aiROA68Uqz6uJ0blGytlE+ib5ghmLvgoar7MQ71R9kv
         M5H0PmpJwtEIg6IQKGqNzvLbb12eL75ajLMbHju0GgSTDkhfwceGc5BYSt4+fWPD72
         i0oNqbgy7yC7Er2Qb3BrBqCnxjBMh475M0sKlC7ttJrKQO8mZfRZ2InBjSnLkunEmG
         uI67NlePP+suxEDaX+5HKsfe8R5c/khwTIfXzxt1WgE2X/NIm3yhrkK+BaN245f5WN
         5A/qDy5M5FCwM9ZtOM2+m+vOW6uUcpCr8tna2Trv0h6QTxSaqWtoxDL0nm1KNncAF2
         Igu6DqbiAdfAA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Xin Hao <xhao@linux.alibaba.com>, sjpark@amazon.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/damon/dbgfs: Add adaptive_targets list check before enable monitor_on
Date:   Wed, 20 Oct 2021 08:12:33 +0000
Message-Id: <20211020081233.28363-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211020072121.17166-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 07:21:21 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 20 Oct 2021 09:42:33 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> 
> > When the ctx->adaptive_targets list is empty,
> > I did some test on monitor_on interface like this.
> > 
> >     # echo > /sys/kernel/debug/damon/target_ids
> 
> Thanks for the change, but you missed writing 'on' to 'monitor_on' in the above
> example.
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
> 
> Other parts looks good to me.  However, seems this commit conflicts with a
> patch[1] which already merged in -mm tree.  Could you please rebase this on it?
> FYI, all DAMON patches that merged in -mm tree are also applied on DAMON
> development tree.  So, you could get the patch applied tree by:
> 
>     $ git remote add sj git://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git
>     $ git fetch sj
>     $ git checkout 0fa378d04b12
> 
> [1] https://lore.kernel.org/linux-mm/20211014073014.35754-1-sj@kernel.org/
> 
> 
> Thanks,
> SJ
> 
> > ---
> >  include/linux/damon.h |  1 +
> >  mm/damon/core.c       |  5 +++++
> >  mm/damon/dbgfs.c      | 13 ++++++++++---
> >  3 files changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 715dadd21f7c..4fce5f1f6dad 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -316,6 +316,7 @@ void damon_destroy_scheme(struct damos *s);
> > 
> >  struct damon_target *damon_new_target(unsigned long id);
> >  void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
> > +bool damon_targets_empty(struct damon_ctx *ctx);
> >  void damon_free_target(struct damon_target *t);
> >  void damon_destroy_target(struct damon_target *t);
> >  unsigned int damon_nr_regions(struct damon_target *t);
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 2f6785737902..c3a1374dbe0b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -156,6 +156,11 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
> >  	list_add_tail(&t->list, &ctx->adaptive_targets);
> >  }
> > 
> > +bool damon_targets_empty(struct damon_ctx *ctx)
> > +{
> > +	return list_empty(&ctx->adaptive_targets);
> > +}
> > +
> >  static void damon_del_target(struct damon_target *t)
> >  {
> >  	list_del(&t->list);
> > diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> > index 38188347d8ab..9dee29f7d103 100644
> > --- a/mm/damon/dbgfs.c
> > +++ b/mm/damon/dbgfs.c
> > @@ -865,12 +865,19 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
> >  		return -EINVAL;
> >  	}
> > 
> > -	if (!strncmp(kbuf, "on", count))
> > +	if (!strncmp(kbuf, "on", count)) {
> > +		int i;
> > +
> > +		for (i = 0; i < dbgfs_nr_ctxs; i++) {
> > +			if (damon_targets_empty(dbgfs_ctxs[i]))
> > +				return -EINVAL;

Oops, I forgot that you should 'kfree(kbuf)' before returning here.  Please do
that.


Thanks,
SJ

> > +		}
> >  		err = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
> > -	else if (!strncmp(kbuf, "off", count))
> > +	} else if (!strncmp(kbuf, "off", count)) {
> >  		err = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
> > -	else
> > +	} else {
> >  		err = -EINVAL;
> > +	}
> > 
> >  	if (err)
> >  		ret = err;
> > --
> > 2.31.0
> 
> 
