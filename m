Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17993B94C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhGAQmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 12:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhGAQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:42:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81457C061764
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 09:39:42 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t9so6629006pgn.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cfR2cpEKwd7JnwMd7pln/e5tA5maTHJfnUSpc6bVutM=;
        b=hd3FmeECoBLGhbkNg99GbCXDXsYXw0+us5vtgKFZNZj0P+an07WD20BVGZ0D3rstzY
         AxCHukR8Iiijs6HfR2C0vBEYprz/T8BgKA2xRxiNofkCzKDyjGlf7Y4v6vLelqUcVaEI
         LzVJfkVmWsCr6WRLFTqWhEa2bDKkzKGLBsyyetIirE5hgm4L2bvSoFTapDNIwaSjk2RE
         SUmdZ95HuCy4XNmntWeqUGernbMehmL3KA+rxWVQ8FM75r9tXzNQ83lBMHLUduU2q9fT
         pSeyU14m0RANquZGfLRE57nVMh/DpTMeReOLQEIsYsY7Oxeb6+wMSGRxnOgpUDnkdu2o
         N2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cfR2cpEKwd7JnwMd7pln/e5tA5maTHJfnUSpc6bVutM=;
        b=GuMw3yLZu+b96cYU/m+Wz3E+cUsfwj+2TTm3hg+e77rtcmA+jXzXQVvJCuN91Xabxk
         HMnpD+i29Gs37tzFB9dru4hsJ55GE34VjvLZFJBIyk5wY9Dke4/CJjuCZ6rYc5qtW8tb
         iGE+UThT5E5vk4syMSP/AxPzsDkVBjox5+shmYYBWiDekE/h3hDZB3Fh8sLdXtg1orRx
         Y6cwC0puztDBMS+ji2ykDNjyGHIjXDW278mpTut0aJfQuzcRrbVMOLYDTNgaNyDb1dLX
         AiiHjtQYUktCqU6pIVW38PTUlNFjFTg63FYHDaLHsBJAwKh5UvkeZFkYr9cjB1DJi3Sl
         5Isg==
X-Gm-Message-State: AOAM532sp+bBBOOBZjsuxnRz6A0WELWqJQ0GNN2mv4vnNnViDoA/lWjd
        GBMOHhdcUddogcrV+AZYBIoHlA==
X-Google-Smtp-Source: ABdhPJwybx/XAmsHosT1b2ZP2gPi4pjG51QHEkjfIgVkF3UL8gkxmxo0KDwi5eVlCQ13ykwKNY3X2w==
X-Received: by 2002:a63:1913:: with SMTP id z19mr483993pgl.294.1625157581991;
        Thu, 01 Jul 2021 09:39:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:726f])
        by smtp.gmail.com with ESMTPSA id b10sm487999pfi.122.2021.07.01.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:39:41 -0700 (PDT)
Date:   Thu, 1 Jul 2021 12:39:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, matthias.bgg@gmail.com,
        minchan@google.com, timmurray@google.com, yt.chang@mediatek.com,
        wenju.xu@mediatek.com, jonathan.jmchen@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com,
        SH Chen <show-hong.chen@mediatek.com>
Subject: Re: [PATCH v2 1/1] psi: stop relying on timer_pending for poll_work
 rescheduling
Message-ID: <YN3vyvoDwSUepM18@cmpxchg.org>
References: <20210630205151.137001-1-surenb@google.com>
 <YN2DsLlE+WtxK6K9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN2DsLlE+WtxK6K9@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 10:58:24AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 30, 2021 at 01:51:51PM -0700, Suren Baghdasaryan wrote:
> > +	/* cmpxchg should be called even when !force to set poll_scheduled */
> > +	if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) && !force)
> >  		return;
> 
> Why is that a cmpxchg() ?

I now realize you had already pointed that out, but I dismissed it in
the context of poll_lock not being always taken after all.

But you're right, cmpxchg indeed seems inappropriate. xchg will do
just fine for this binary toggle.

When it comes to ordering, looking at it again, I think we actually
need ordering here that the seqcount doesn't provide. We have:

timer:
scheduled = 0
smp_rmb()
x = state

scheduler:
state = y
smp_wmb()
if xchg(scheduled, 1) == 0
  mod_timer()

Again, the requirement is that when the scheduler sees the timer as
already or still pending, the timer must observe its state updates -
otherwise we miss poll events.

The seqcount provides the wmb and rmb, but the scheduler-side read of
@scheduled mustn't be reordered before the write to @state. Likewise,
the timer-side read of @state also mustn't occur before the write to
@scheduled.

AFAICS this is broken, not just in the patch, but also in the current
code when timer_pending() on the scheduler side gets reordered. (Not
sure if timer reading state can be reordered before the detach_timer()
of its own expiration, but I don't see full ordering between them.)

So it seems to me we need the ordered atomic_xchg() on the scheduler
side, and on the timer side an smp_mb() after we set scheduled to 0.
