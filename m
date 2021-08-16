Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A8E3ED456
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhHPMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhHPMxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:53:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02446C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q30iAxJ4gafqAM06AnmCnX2w2228InUwMoes33hyLXQ=; b=IU3BoXKDzf0B7TuMH2MkyXxOlp
        26OqzRmax2soE7EWfMFaqaNpGmNfluy2TR+fG+nYCcExtY9KfD66fRzdqgN/+s2dqM/Rnwcr+EoHU
        PnyCee+BRfgQvO0o73D1icXPEMaKX+yIxgUAG1mL1NApL+Jy8nMl2kub5rCSH7sAvUmVLzaow5mI4
        TlrC98dPftZePBiX3jI7XOm3efA/+0iB5Lbc/8ePNrQgkkG3h4MeqGXFDx6pTAT7cCKljAFBX3p15
        g/hBksNh//0Oav7ErSEdR5WKrIp6E4gz1O+omFeQxsI9LekD5wmQRGSweXpKTRapswWA7K9YiCII8
        QS5zc+ZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFc63-00AC1x-8g; Mon, 16 Aug 2021 12:52:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C832A3004E6;
        Mon, 16 Aug 2021 14:52:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A62E72028D932; Mon, 16 Aug 2021 14:52:05 +0200 (CEST)
Date:   Mon, 16 Aug 2021 14:52:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <YRpfdWwJL34PjgI1@hirez.programming.kicks-ass.net>
References: <20210730020019.1487127-1-joshdon@google.com>
 <20210730020019.1487127-3-joshdon@google.com>
 <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 03:31:49PM +0200, Vincent Guittot wrote:
> On Fri, 30 Jul 2021 at 04:00, Josh Don <joshdon@google.com> wrote:


> > @@ -4216,7 +4228,15 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> >                 if (sched_feat(GENTLE_FAIR_SLEEPERS))
> >                         thresh >>= 1;
> >
> > -               vruntime -= thresh;
> > +               /*
> > +                * Don't give sleep credit to a SCHED_IDLE entity if we're
> > +                * placing it onto a cfs_rq with non SCHED_IDLE entities.
> > +                */
> > +               if (!se_is_idle(se) ||
> > +                   cfs_rq->h_nr_running == cfs_rq->idle_h_nr_running)

I really dislike that second clause, either never do this for idle or
always, but not sometimes when the planets are aligned just right.

> Can't this condition above create unfairness between idle entities ?
> idle thread 1 wake up while normal thread is running
> normal thread thread sleeps immediately after
> idle thread 2 wakes up just after and gets some credits compared to the 1st one.

No. Strictly speaking cfs is unfair here. But it's a really tricky case.

Consider a task that is running 50% competing against a task that's
running 100%. What's fair in that situation, a 50/50 split, or a 25/75
split? What if that 50% is 50% of a minute?

What we do here is fudge the vruntime such that we end up with a 50/50
split provided the period over which it blocks is less than a slice.
After that it gradually converges to the 'expected' 25/75 split that
results from strict runnable competition.

By not letting idle tasks participate in this, we avoid idle tasks
'stealing' the !runnable time and they revert back to strict runnable
competition only.

> > +                       vruntime -= thresh;
> > +               else
> > +                       vruntime += 1;
> >         }
> >
> >         /* ensure we never gain time by being placed backwards. */
> > --
> > 2.32.0.554.ge1b32706d8-goog
> >
