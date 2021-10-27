Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EDF43C2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhJ0GQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbhJ0GQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:16:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41056C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:13:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so2149770wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pibU8nLu7Th8DT1Zw3kLRTLSsjhZSIisT/Igppcs57Q=;
        b=phRWH/s3Bn6j4dE1ATH6pqYHd12lU25N0SzYP0sI7HNW4+lINtz6J/Sy0l7hwYh8c7
         mhdKsbEhJ1rlPNjNKAmIAFxs7yOLyos8BtD/9h5BV2vN7rZK/8GtdENTRzGtGbvtmauj
         kkaMJC7lzHC9vyJgdedf2ukhbcJv8073dmPs8keCODOOzM0SX9Az59G1vDO+jbHvZ4X8
         Nrl0n+QWItWKZ4a8XfKQMk36hBWSPER6VrJDoGLfZF6HGV01x4MZFVa66Sx7/DQpO2fw
         oWthBTUTjCzqFA5i3YVlbNEA270cui7M2d+fVYKoptsTciAqazejGQ2SGTX9SLW6LG90
         Bi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pibU8nLu7Th8DT1Zw3kLRTLSsjhZSIisT/Igppcs57Q=;
        b=6mjqRt8zQiFchTwBnlC3CmARbU5AZnsT3GMKHRjYD/GYJ58FJbb2kJ3slBt4KyYRMb
         RhTvTIG38gbzmOLCN1p55XU45cKm5l3fBERpeELF1L7fdr9UxvJ4RwYsfgZkZ5pVMmfk
         /n6xoCfDdcAhhVPDu94C9J4IaicKEMLUXacbSJL2XW6QRj65RtUvLznBpcrj+2wSOHVO
         lOsmR8t9iDK4JMA4B6V4xaueSKrdeRE8joK/txVDHSZU/mxXQVUJblGCP/Ho3vnMvj1B
         gTzdBQSXhvlLyS52r+smjTstvlFzjObcyStJoOpvXTzVkIN3Q4xtFJA8YkJZPmwp0Fil
         cySA==
X-Gm-Message-State: AOAM533p+Kk52uIwaeSxolsEtVsY/l56S/XfxvcHB5QqjRlBaV7y39Yb
        nuPRcpw+zA9eP4VexkaEKSKvttiTEEU=
X-Google-Smtp-Source: ABdhPJy+4Z7/lnrZTLEj6B/wxxqr+4WP7aDfa2X0Cu9Q4kQzUFKNuChYG+2NQrkcD/q4LP22pYAqxw==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr38226022wrr.323.1635315224833;
        Tue, 26 Oct 2021 23:13:44 -0700 (PDT)
Received: from mail.google.com ([95.179.207.30])
        by smtp.gmail.com with ESMTPSA id y23sm2545459wmi.43.2021.10.26.23.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 23:13:44 -0700 (PDT)
Date:   Wed, 27 Oct 2021 14:13:38 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: simplify stop mechanism
Message-ID: <20211027061338.xdqdyjaghrs63ncp@mail.google.com>
References: <20211026153033.11140-1-changbin.du@gmail.com>
 <20211026184203.1541-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026184203.1541-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 06:42:03PM +0000, SeongJae Park wrote:
> Hello Changbin,
> 
> On Tue, 26 Oct 2021 23:30:33 +0800 Changbin Du <changbin.du@gmail.com> wrote:
> 
> > An kernel thread can exit gracefully with kthread_stop(). So we don't need a
> > new flag 'kdamond_stop'.  And to make sure the task struct is not freed when
> > accessing it, get task struct on start and put it on stop.
> 
> We previously considered using kthread_stop() here.  However, we resulted in
> current code because kdamond can be self-terminated when all target processes
> are invalid[1].
> 
> Seems this patch is also not fully prepared for the self-termination case.  I
> left some comments below.
> 
> [1] https://lore.kernel.org/linux-mm/20210624102623.24563-1-sjpark@amazon.de/
> 
> > 
> > And since the return value of 'before_terminate' callback is never used,
> > we make it have no return value.
> 
> This looks nice to me.  Could you please send this again as a separate patch?
>
Sure, I'll do it later.

> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  include/linux/damon.h |  3 +--
> >  mm/damon/core.c       | 59 +++++++++++++------------------------------
> >  mm/damon/dbgfs.c      |  5 ++--
> >  3 files changed, 20 insertions(+), 47 deletions(-)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index a14b3cc54cab..041966786270 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [...]
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [...]  
> > @@ -1069,7 +1048,7 @@ static int kdamond_fn(void *data)
> >  					sz_limit);
> >  			if (ctx->callback.after_aggregation &&
> >  					ctx->callback.after_aggregation(ctx))
> > -				set_kdamond_stop(ctx);
> > +				done = true;
> >  			kdamond_apply_schemes(ctx);
> >  			kdamond_reset_aggregated(ctx);
> >  			kdamond_split_regions(ctx);
> > @@ -1088,16 +1067,12 @@ static int kdamond_fn(void *data)
> >  			damon_destroy_region(r, t);
> >  	}
> >  
> > -	if (ctx->callback.before_terminate &&
> > -			ctx->callback.before_terminate(ctx))
> > -		set_kdamond_stop(ctx);
> > +	if (ctx->callback.before_terminate)
> > +		ctx->callback.before_terminate(ctx);
> >  	if (ctx->primitive.cleanup)
> >  		ctx->primitive.cleanup(ctx);
> >  
> >  	pr_debug("kdamond (%d) finishes\n", current->pid);
> > -	mutex_lock(&ctx->kdamond_lock);
> > -	ctx->kdamond = NULL;
> > -	mutex_unlock(&ctx->kdamond_lock);
> 
> When kdamond is self-terminating, ctx->kdamond will not be nullfified.  As a
> result, this patch can introduce some errors like below:
> 
>     # cd /sys/kernel/debug/damon
>     # sleep 60 &
>     [1] 1926
>     # echo $(pidof sleep) > target_ids
>     # echo on > monitor_on
>     # cat monitor_on
>     on
>     # # after 60 seconds, sleep finishes and kdamond is self-terminated
>     # cat monitor_on
>     off
>     # echo 42 > target_ids
>     bash: echo: write error: Device or resource busy
> 
> If we simply restore the nullification here with the mutex locking, we would
> result in a deadlock because __damon_stop() calls kthread_stop() while holding
> ctx->kdamond_lock.
> 
> Also, the reference count of ctx->kdamond, which increased by __damon_start(),
> would not be decreased in the case.
>

If so, I suppose below change should work correctly (still set ctx->kdamond to
NULL at the end of kdamond).

 static int __damon_stop(struct damon_ctx *ctx)
 {
+       struct task_struct *tsk;
+
        mutex_lock(&ctx->kdamond_lock);
-       if (ctx->kdamond) {
-               ctx->kdamond_stop = true;
+       tsk = ctx->kdamond;
+       if (tsk) {
+               get_task_struct(tsk);
                mutex_unlock(&ctx->kdamond_lock);
-               while (damon_kdamond_running(ctx))
-                       usleep_range(ctx->sample_interval,
-                                       ctx->sample_interval * 2);
+               kthread_stop(tsk);
+               put_task_struct(tsk);
                return 0;
        }
        mutex_unlock(&ctx->kdamond_lock);


> If I'm missing something, please let me know.
> 
> 
> Thanks,
> SJ
> 
> [...]

-- 
Cheers,
Changbin Du
