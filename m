Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4963B2C63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhFXK25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhFXK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:28:56 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A13C061574;
        Thu, 24 Jun 2021 03:26:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id r19so3005930qvw.5;
        Thu, 24 Jun 2021 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=QHA5XL2z4ba2bDn1SI+fh6o/LaSMQqQKLJBCxBSck3k=;
        b=d+6hp2rCz8MMoOIaPRLxD+bKt/A+bFeWEVYlH8fTzLrId/ZyzWjGcjDN89QSKscmG1
         YBZCU2GBs9vX6b07WZUzJKMjJ0+RqAxuOVJ0hme1hgo4DiVtdeHqJXqoYSIbvLCMLItu
         +FcFSESoe0wQM3bH00jN28XrTL9OQEDOuqelyFJg1T7zFu0wB0+bQvjyCXuHv6Zo590p
         +MR3ARY8r/DbQYF5v9s241Di1YF4vP66E0OWkPrqdEiE40taj7fJOwmk+YGcaXajQtKZ
         IXCvGooivBqY+zdW0bCLEs1I1/JFAKMaA8U6QzgFHuJLh04TjY+512Q/ecIiceJFEJ5x
         FPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=QHA5XL2z4ba2bDn1SI+fh6o/LaSMQqQKLJBCxBSck3k=;
        b=Yrh1vJgzYwlMUl6ApeCC91QsVlHzHhMmQRp0qtzmBqxx9xgcS4ycqMecdQlsSGC/Se
         SjrDQ1piCB8MMHLNht53bpV7aigE1R0dQjQc1cdrPgcsJ1Y0ajNUN+2W2SsWGheIJJGt
         F2lt/hyVO98bgrWOiZ9KQ1qdlpadvlzdzo1gyU96Zj2pfz+oe5Or1at2Pl1EKLBz+HXv
         GKtIgwjH9iZMFmgKTx8KyPmLQ8hc/JMVK4x/aGsOtx26LS4aKhZNApDe7C57JXtHrBbE
         UDNsH/t9kk8sKFY7XaOOaMXhwWms/2xem20jh7RNLQUPlP6cLEpnZj+AIncFOqoS49RK
         SC0g==
X-Gm-Message-State: AOAM533MkJew9HSbrAMVnnL3Lhh/VDrJn1eUIjweDu9ZE6Gg4bI16OEP
        mMHSG7hHAupq8tL989EGGBc=
X-Google-Smtp-Source: ABdhPJyzOCBhWMvw4oIaH/BVd+umviU6q7Sjs64gDoJ6+2Nqsa5FiJU6cAX0UNWNwI1r9VwbGIvK4A==
X-Received: by 2002:ad4:5343:: with SMTP id v3mr4639008qvs.45.1624530395013;
        Thu, 24 Jun 2021 03:26:35 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id w195sm2132842qkb.127.2021.06.24.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:26:34 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, greg@kroah.com,
        Greg Thelen <gthelen@google.com>, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, Mel Gorman <mgorman@suse.de>, mheyne@amazon.de,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        sieberf@amazon.com, snu@zelle79.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        zgf574564920@gmail.com, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v31 01/13] mm: Introduce Data Access MONitor (DAMON)
Date:   Thu, 24 Jun 2021 10:26:19 +0000
Message-Id: <20210624102623.24563-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7byYA5jfzF3Vtr1czwWoiaHjkqn9M4e1Ajn1PP47k9=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 22 Jun 2021 07:59:11 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Jun 21, 2021 at 1:31 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > DAMON is a data access monitoring framework for the Linux kernel.  The
> > core mechanisms of DAMON make it
> >
> >  - accurate (the monitoring output is useful enough for DRAM level
> >    performance-centric memory management; It might be inappropriate for
> >    CPU cache levels, though),
> >  - light-weight (the monitoring overhead is normally low enough to be
> >    applied online), and
> >  - scalable (the upper-bound of the overhead is in constant range
> >    regardless of the size of target workloads).
> >
> > Using this framework, hence, we can easily write efficient kernel space
> > data access monitoring applications.  For example, the kernel's memory
> > management mechanisms can make advanced decisions using this.
> > Experimental data access aware optimization works that incurring high
> > access monitoring overhead could again be implemented on top of this.
> >
> > Due to its simple and flexible interface, providing user space interface
> > would be also easy.  Then, user space users who have some special
> > workloads can write personalized applications for better understanding
> > and optimizations of their workloads and systems.
> >
> > ===
> >
> > Nevertheless, this commit is defining and implementing only basic access
> > check part without the overhead-accuracy handling core logic.  The basic
> > access check is as below.
> >
> > The output of DAMON says what memory regions are how frequently accessed
> > for a given duration.  The resolution of the access frequency is
> > controlled by setting ``sampling interval`` and ``aggregation
> > interval``.  In detail, DAMON checks access to each page per ``sampling
> > interval`` and aggregates the results.  In other words, counts the
> > number of the accesses to each region.  After each ``aggregation
> > interval`` passes, DAMON calls callback functions that previously
> > registered by users so that users can read the aggregated results and
> > then clears the results.  This can be described in below simple
> > pseudo-code::
> >
> >     init()
> >     while monitoring_on:
> >         for page in monitoring_target:
> >             if accessed(page):
> >                 nr_accesses[page] += 1
> >         if time() % aggregation_interval == 0:
> >             for callback in user_registered_callbacks:
> >                 callback(monitoring_target, nr_accesses)
> >             for page in monitoring_target:
> >                 nr_accesses[page] = 0
> >         if time() % update_interval == 0:
> 
> regions_update_interval?

It used the name before.  But, I changed the name in this way to use it as a
general periodic updates of monitoring primitives.  Of course we can use the
specific name only in this specific example, but also want to make this as
similar to the actual code as possible.

If you strongly want to rename this, please feel free to let me know.

> 
> >             update()
> >         sleep(sampling interval)
> >
> > The target regions constructed at the beginning of the monitoring and
> > updated after each ``regions_update_interval``, because the target
> > regions could be dynamically changed (e.g., mmap() or memory hotplug).
> > The monitoring overhead of this mechanism will arbitrarily increase as
> > the size of the target workload grows.
> >
> > The basic monitoring primitives for actual access check and dynamic
> > target regions construction aren't in the core part of DAMON.  Instead,
> > it allows users to implement their own primitives that are optimized for
> > their use case and configure DAMON to use those.  In other words, users
> > cannot use current version of DAMON without some additional works.
> >
> > Following commits will implement the core mechanisms for the
> > overhead-accuracy control and default primitives implementations.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > Reviewed-by: Fernand Sieber <sieberf@amazon.com>
> 
> Few nits below otherwise look good to me. You can add:
> 
> Acked-by: Shakeel Butt <shakeelb@google.com>

Thank you!

> 
> [...]
> > +/*
> > + * __damon_start() - Starts monitoring with given context.
> > + * @ctx:       monitoring context
> > + *
> > + * This function should be called while damon_lock is hold.
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + */
> > +static int __damon_start(struct damon_ctx *ctx)
> > +{
> > +       int err = -EBUSY;
> > +
> > +       mutex_lock(&ctx->kdamond_lock);
> > +       if (!ctx->kdamond) {
> > +               err = 0;
> > +               ctx->kdamond_stop = false;
> > +               ctx->kdamond = kthread_create(kdamond_fn, ctx, "kdamond.%d",
> > +                               nr_running_ctxs);
> > +               if (IS_ERR(ctx->kdamond))
> > +                       err = PTR_ERR(ctx->kdamond);
> > +               else
> > +                       wake_up_process(ctx->kdamond);
> 
> Nit: You can use kthread_run() here.

Ok, I will use that from the next spin.

> 
> > +       }
> > +       mutex_unlock(&ctx->kdamond_lock);
> > +
> > +       return err;
> > +}
> > +
> [...]
> > +static int __damon_stop(struct damon_ctx *ctx)
> > +{
> > +       mutex_lock(&ctx->kdamond_lock);
> > +       if (ctx->kdamond) {
> > +               ctx->kdamond_stop = true;
> > +               mutex_unlock(&ctx->kdamond_lock);
> > +               while (damon_kdamond_running(ctx))
> > +                       usleep_range(ctx->sample_interval,
> > +                                       ctx->sample_interval * 2);
> 
> Any reason to not use kthread_stop() here?

Using 'kthread_stop()' here will make the code much simpler.  But, 'kdamond'
also stops itself when all monitoring targets became invalid (e.g., all
monitoring target processes terminated).  However, 'kthread_stop()' is not easy
to be used for the use case (self stopping).  It's of course possible, but it
would make the code longer.  That's why I use 'kdamond_stop' flag here.  So,
I'd like leave this as is.  If you think 'kthread_stop()' should be used,
please feel free to let me know.


Thanks,
SeongJae Park
