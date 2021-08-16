Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0393ED3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhHPMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhHPMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:33:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1A3C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BOVcqfklKBkhIqWYd2Cf4VMWcXeUvpipN4dgSEq2GFo=; b=fIPE6cs2v5kLiY7FK3DubWjE7r
        Vg4Zhh8Z7rItBG6yn7YMlFbfZc6aPAAYqql0xOXd5/RvdTlKz/dl3U3uCcOLroSA+uTF5depWvFhs
        QCzDDftH7lTFT2rZ0qiOs6mnjq4ycKdFRG0uP6LLFCLx6sm5ca0TtF64fGVOTWSpdH9pbb9iaUFPx
        0PECasRWqkWIMWqaA8nM6P0JPRsy3iR5nNXdZuZ0FETlJU+QC4QjuiA7FdNSIQDjPMHFueHwriA1O
        QiNIL8N8rT8+e31ntSihpoKSPwO6HxE6rv3sU9F7oVCNsikVRfENimOeiZL85Mo7O5KFiJJzSXHoN
        P0so94QQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFbmY-00ABpo-G7; Mon, 16 Aug 2021 12:31:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4BC43004B2;
        Mon, 16 Aug 2021 14:31:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D72612028D932; Mon, 16 Aug 2021 14:31:57 +0200 (CEST)
Date:   Mon, 16 Aug 2021 14:31:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched: adjust SCHED_IDLE interactions
Message-ID: <YRpavaMk09iw0fkE@hirez.programming.kicks-ass.net>
References: <20210730020019.1487127-1-joshdon@google.com>
 <20210730020019.1487127-3-joshdon@google.com>
 <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com>
 <CABk29Ns8P9AGy7Tpo6duOeEh=ZFWM1jO8FnvhZhktfcA0GWOpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ns8P9AGy7Tpo6duOeEh=ZFWM1jO8FnvhZhktfcA0GWOpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 02:09:15PM -0700, Josh Don wrote:
> > > @@ -697,8 +699,18 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >                 slice = __calc_delta(slice, se->load.weight, load);
> > >         }
> > >
> > > -       if (sched_feat(BASE_SLICE))
> > > -               slice = max(slice, (u64)w);
> > > +       if (sched_feat(BASE_SLICE)) {
> > > +               /*
> > > +                * SCHED_IDLE entities are not subject to min_granularity if
> > > +                * they are competing with non SCHED_IDLE entities. As a result,
> > > +                * non SCHED_IDLE entities will have reduced latency to get back
> > > +                * on cpu, at the cost of increased context switch frequency of
> > > +                * SCHED_IDLE entities.
> > > +                */
> >
> > Ensuring that the entity will have a minimum runtime has been added to
> > ensure that we let enough time to move forward.
> > If you exclude sched_idle entities from this min runtime, the
> > sched_slice of an idle_entity will be really small.
> > I don't have details of your example above but I can imagine that it's
> > a 16 cpus system which means a sysctl_sched_min_granularity=3.75ms
> > which explains the 4ms running time of an idle entity
> > For a 16 cpus system, the sched_slice of an idle_entity in your
> > example in the cover letter is: 6*(1+log2(16))*3/1027=87us. Of course
> > this become even worse with more threads and cgroups or thread with
> > ncie prio -19
> >
> > This value is then used to set the next hrtimer event in SCHED_HRTICK
> > and 87us is too small to make any progress
> >
> > The 1ms of your test comes from the tick which could be a good
> > candidate for a min value or the
> > normalized_sysctl_sched_min_granularity which has the advantage of not
> > increasing with number of CPU
> 
> Fair point, this shouldn't completely ignore min granularity. Something like
> 
> unsigned int sysctl_sched_idle_min_granularity = NSEC_PER_MSEC;
> 
> (and still only using this value instead of the default
> min_granularity when the SCHED_IDLE entity is competing with normal
> entities)

TICK_NSEC ?
