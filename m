Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311C93876B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348566AbhERKk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:40:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241525AbhERKkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:40:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C35E7AF19;
        Tue, 18 May 2021 10:39:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B00521F2C6E; Tue, 18 May 2021 12:39:28 +0200 (CEST)
Date:   Tue, 18 May 2021 12:39:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     chi wu <wuchi.zero@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, tan.hu@zte.com.cn
Subject: Re: [PATCH] lib/flex_proportions.c: Use abs() when percpu_counter is
 negative.
Message-ID: <20210518103928.GC28667@quack2.suse.cz>
References: <20210517155306.11113-1-wuchi.zero@gmail.com>
 <CA+tQmHAE6vK17Xghi9YT7+7r4oFJuQ86cU8m5MzMs6-D0G=DBQ@mail.gmail.com>
 <20210518085955.GB28667@quack2.suse.cz>
 <CA+tQmHBEvZTe9-7tReRHBw1tkTW7uGS5FhPZ41eZFOqtoyqkHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+tQmHBEvZTe9-7tReRHBw1tkTW7uGS5FhPZ41eZFOqtoyqkHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-05-21 18:22:05, chi wu wrote:
> Jan Kara <jack@suse.cz> 于2021年5月18日周二 下午4:59写道：
> >
> > On Tue 18-05-21 11:42:53, chi wu wrote:
> > > Chi Wu <wuchi.zero@gmail.com> 于2021年5月17日周一 下午11:53写道：
> > > >
> > > > The value of percpu_counter_read() may become negative after
> > > > running percpu_counter_sum() in fprop_reflect_period_percpu().
> > > > The value of variable 'num' will be zero in fprop_fraction_percpu()
> > > > when using percpu_counter_read_positive(), but if using the abs of
> > > > percpu_counter_read() will be close to the correct value.
> > > >
> > >
> > > I realized that I was wrong as follow:
> > > (a) the decay rule is broken, the negative means the difference in
> > > decay here.
> > > (b) as the target event increasing, proportion of the event will
> > > decrease to 0 firstly and then it will increase. The logic is bad.
> > > 1. abs(-50) / abs(100) = 50%       //+50 to 2
> > > 2. abs(0) / abs(150) = 0 %           //+50 to 3
> > > 3. abs(50)/abs(200) = 25%
> > >
> > > Anyway, the percpu_counter_sum() had cost a lost performance,
> > > may be we could get a little benefits from that. So could we add a
> > > variable to stroe the decay value, we will get the value when
> > > percpu_counter_read() is negative?
> >
> > The result of percpu_counter_read() is inherently inexact (but fast! ;). It
> > can be upto number_of_cpus * counter_batch away from the real counter
> > value. But do you observe any practical problems with this inaccuracy on
> > your system? Sure, cache memory won't be split among devices exactly
> > according to writeout proportion but that usually does not matter.
> >
> >                                                                 Honza
> >
> 
> Thanks, Got it.
> Just try to optimize the fuse (with strictlimit feature)performance
> issue: The writing thread will be paused and runs slowly, when the
> proportion of fuse-bdi is 0.
> The issue is normal,and one of reasons is the characteristics of
> percpu_counter batch. Even the pages are writeout, we may be could not
> get the real proportion value due to side effects of counter
> performance. It's just a slight disappointment.

Well, you can tune 'min_ratio' of the fuse-bdi to avoid problems with these
near-zero states... To always give the bdi some breathing room for ramping
up.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
