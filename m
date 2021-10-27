Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC1D43C817
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbhJ0Kyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236103AbhJ0Ky2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:54:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 417866103B;
        Wed, 27 Oct 2021 10:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635331922;
        bh=b42wC/g9RlnpUJ/IcMnZ8nC7VV3irkCSL78veVUQExE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=F1cFINxCe48pXXHFsjtgrsogkZAywUVld1dZXo9ofTlIJ1iAjVrGHSbH3TcbN9f5U
         vVMBlkwoW/qXeqcOsYZRdr8jEYEo+/P8yY1CYkWZPiSaahuu+xEhiGWYXvJPzck2Y1
         TWv/OXYFAVDWCPXjBUt/qkbM6YODUKwy/aJRLVO3Kb0+j3YlLaczSzb/3vdT0EMd3w
         SQ0hPClEONY9ByKr5RMGpx9y4rwZcvhVwILkrn1hQMtf3Navu3Uwfvru9T1ub1nsw/
         XPm5jxtn68D/93h9Qm2jaYg7HqJwD9sz7bgReCwTFnK83Nq7li9iBb9motpP/N8eep
         wDpB0H4P6vANA==
From:   SeongJae Park <sj@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: simplify stop mechanism
Date:   Wed, 27 Oct 2021 10:51:58 +0000
Message-Id: <20211027105158.6932-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027061338.xdqdyjaghrs63ncp@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 14:13:38 +0800 Changbin Du <changbin.du@gmail.com> wrote:

> On Tue, Oct 26, 2021 at 06:42:03PM +0000, SeongJae Park wrote:
> > Hello Changbin,
> > 
> > On Tue, 26 Oct 2021 23:30:33 +0800 Changbin Du <changbin.du@gmail.com> wrote:
> > 
> > > An kernel thread can exit gracefully with kthread_stop(). So we don't need a
> > > new flag 'kdamond_stop'.  And to make sure the task struct is not freed when
> > > accessing it, get task struct on start and put it on stop.
> > 
> > We previously considered using kthread_stop() here.  However, we resulted in
> > current code because kdamond can be self-terminated when all target processes
> > are invalid[1].
> > 
> > Seems this patch is also not fully prepared for the self-termination case.  I
> > left some comments below.
> > 
> > [1] https://lore.kernel.org/linux-mm/20210624102623.24563-1-sjpark@amazon.de/
> > 
> > > 
> > > And since the return value of 'before_terminate' callback is never used,
> > > we make it have no return value.
> > 
> > This looks nice to me.  Could you please send this again as a separate patch?
> >
> Sure, I'll do it later.
> 
> > > 
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > ---
> > >  include/linux/damon.h |  3 +--
> > >  mm/damon/core.c       | 59 +++++++++++++------------------------------
> > >  mm/damon/dbgfs.c      |  5 ++--
> > >  3 files changed, 20 insertions(+), 47 deletions(-)
> > > 
> > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > index a14b3cc54cab..041966786270 100644
> > > --- a/include/linux/damon.h
> > > +++ b/include/linux/damon.h
> > [...]
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > [...]  
> > > @@ -1069,7 +1048,7 @@ static int kdamond_fn(void *data)
> > >  					sz_limit);
> > >  			if (ctx->callback.after_aggregation &&
> > >  					ctx->callback.after_aggregation(ctx))
> > > -				set_kdamond_stop(ctx);
> > > +				done = true;
> > >  			kdamond_apply_schemes(ctx);
> > >  			kdamond_reset_aggregated(ctx);
> > >  			kdamond_split_regions(ctx);
> > > @@ -1088,16 +1067,12 @@ static int kdamond_fn(void *data)
> > >  			damon_destroy_region(r, t);
> > >  	}
> > >  
> > > -	if (ctx->callback.before_terminate &&
> > > -			ctx->callback.before_terminate(ctx))
> > > -		set_kdamond_stop(ctx);
> > > +	if (ctx->callback.before_terminate)
> > > +		ctx->callback.before_terminate(ctx);
> > >  	if (ctx->primitive.cleanup)
> > >  		ctx->primitive.cleanup(ctx);
> > >  
> > >  	pr_debug("kdamond (%d) finishes\n", current->pid);
> > > -	mutex_lock(&ctx->kdamond_lock);
> > > -	ctx->kdamond = NULL;
> > > -	mutex_unlock(&ctx->kdamond_lock);
> > 
> > When kdamond is self-terminating, ctx->kdamond will not be nullfified.  As a
> > result, this patch can introduce some errors like below:
> > 
> >     # cd /sys/kernel/debug/damon
> >     # sleep 60 &
> >     [1] 1926
> >     # echo $(pidof sleep) > target_ids
> >     # echo on > monitor_on
> >     # cat monitor_on
> >     on
> >     # # after 60 seconds, sleep finishes and kdamond is self-terminated
> >     # cat monitor_on
> >     off
> >     # echo 42 > target_ids
> >     bash: echo: write error: Device or resource busy
> > 
> > If we simply restore the nullification here with the mutex locking, we would
> > result in a deadlock because __damon_stop() calls kthread_stop() while holding
> > ctx->kdamond_lock.
> > 
> > Also, the reference count of ctx->kdamond, which increased by __damon_start(),
> > would not be decreased in the case.
> >
> 
> If so, I suppose below change should work correctly (still set ctx->kdamond to
> NULL at the end of kdamond).
> 
>  static int __damon_stop(struct damon_ctx *ctx)
>  {
> +       struct task_struct *tsk;
> +
>         mutex_lock(&ctx->kdamond_lock);
> -       if (ctx->kdamond) {
> -               ctx->kdamond_stop = true;
> +       tsk = ctx->kdamond;
> +       if (tsk) {
> +               get_task_struct(tsk);
>                 mutex_unlock(&ctx->kdamond_lock);
> -               while (damon_kdamond_running(ctx))
> -                       usleep_range(ctx->sample_interval,
> -                                       ctx->sample_interval * 2);
> +               kthread_stop(tsk);
> +               put_task_struct(tsk);
>                 return 0;
>         }
>         mutex_unlock(&ctx->kdamond_lock);

Agreed, this seems to make sense.  Could you please send a complete patch?


Thanks,
SJ

> 
> 
> > If I'm missing something, please let me know.
> > 
> > 
> > Thanks,
> > SJ
> > 
> > [...]
> 
> -- 
> Cheers,
> Changbin Du
