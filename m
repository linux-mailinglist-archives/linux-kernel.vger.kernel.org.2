Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80394387488
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347338AbhERJB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:01:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:53552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347632AbhERJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:01:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DBA1ADCA;
        Tue, 18 May 2021 08:59:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EE8161F2C6E; Tue, 18 May 2021 10:59:55 +0200 (CEST)
Date:   Tue, 18 May 2021 10:59:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     chi wu <wuchi.zero@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, tan.hu@zte.com.cn
Subject: Re: [PATCH] lib/flex_proportions.c: Use abs() when percpu_counter is
 negative.
Message-ID: <20210518085955.GB28667@quack2.suse.cz>
References: <20210517155306.11113-1-wuchi.zero@gmail.com>
 <CA+tQmHAE6vK17Xghi9YT7+7r4oFJuQ86cU8m5MzMs6-D0G=DBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+tQmHAE6vK17Xghi9YT7+7r4oFJuQ86cU8m5MzMs6-D0G=DBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-05-21 11:42:53, chi wu wrote:
> Chi Wu <wuchi.zero@gmail.com> 于2021年5月17日周一 下午11:53写道：
> >
> > The value of percpu_counter_read() may become negative after
> > running percpu_counter_sum() in fprop_reflect_period_percpu().
> > The value of variable 'num' will be zero in fprop_fraction_percpu()
> > when using percpu_counter_read_positive(), but if using the abs of
> > percpu_counter_read() will be close to the correct value.
> >
> 
> I realized that I was wrong as follow:
> (a) the decay rule is broken, the negative means the difference in
> decay here.
> (b) as the target event increasing, proportion of the event will
> decrease to 0 firstly and then it will increase. The logic is bad.
> 1. abs(-50) / abs(100) = 50%       //+50 to 2
> 2. abs(0) / abs(150) = 0 %           //+50 to 3
> 3. abs(50)/abs(200) = 25%
> 
> Anyway, the percpu_counter_sum() had cost a lost performance,
> may be we could get a little benefits from that. So could we add a
> variable to stroe the decay value, we will get the value when
> percpu_counter_read() is negative?

The result of percpu_counter_read() is inherently inexact (but fast! ;). It
can be upto number_of_cpus * counter_batch away from the real counter
value. But do you observe any practical problems with this inaccuracy on
your system? Sure, cache memory won't be split among devices exactly
according to writeout proportion but that usually does not matter.

								Honza

> > ---
> >  lib/flex_proportions.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
> > index 451543937524..3ac79ca2c441 100644
> > --- a/lib/flex_proportions.c
> > +++ b/lib/flex_proportions.c
> > @@ -147,7 +147,7 @@ void fprop_fraction_single(struct fprop_global *p,
> >                 seq = read_seqcount_begin(&p->sequence);
> >                 fprop_reflect_period_single(p, pl);
> >                 num = pl->events;
> > -               den = percpu_counter_read_positive(&p->events);
> > +               den = abs(percpu_counter_read(&p->events));
> >         } while (read_seqcount_retry(&p->sequence, seq));
> >
> >         /*
> > @@ -209,7 +209,7 @@ static void fprop_reflect_period_percpu(struct fprop_global *p,
> >                         val = percpu_counter_sum(&pl->events);
> >
> >                 percpu_counter_add_batch(&pl->events,
> > -                       -val + (val >> (period-pl->period)), PROP_BATCH);
> > +                       -val + (val >> (period - pl->period)), PROP_BATCH);
> >         } else
> >                 percpu_counter_set(&pl->events, 0);
> >         pl->period = period;
> > @@ -234,8 +234,8 @@ void fprop_fraction_percpu(struct fprop_global *p,
> >         do {
> >                 seq = read_seqcount_begin(&p->sequence);
> >                 fprop_reflect_period_percpu(p, pl);
> > -               num = percpu_counter_read_positive(&pl->events);
> > -               den = percpu_counter_read_positive(&p->events);
> > +               num = abs(percpu_counter_read(&pl->events));
> > +               den = abs(percpu_counter_read(&p->events));
> >         } while (read_seqcount_retry(&p->sequence, seq));
> >
> >         /*
> > --
> > 2.17.1
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
