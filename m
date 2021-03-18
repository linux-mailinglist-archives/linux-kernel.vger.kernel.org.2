Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0091C340867
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhCRPGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhCRPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:05:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rXwfeVKScFdlCNlk/ZnNhMvpa14Ch3Ej13zRadb83nQ=; b=NSZxlOJ4Z003XWOqE63JjqGQd2
        1XvgtZkIzZb2j7dkwMXt1oQO/AmXkf1pqgFRISrfyvlgKW2FxE19BAAdejzF285mgd2LdoEhiciQF
        VV8+4z5oHV++cHmeLKfXsNvwGqUIT+Xsr7p305Vt1QG9AJEczOxaTCDp6BaG/ctTj/248GpFY+cBk
        lzOx2GtLPS3V9k63yvWQ3jqoDygL+VXboRCjJ8quycj363EKrPojfXHyXtDSRyPvu9PSjW6CDRIyt
        GfWeneeHVAHHOGqcsVXc3gHBnOERBnPHuX6mn2wdEKDG0s99wEKJSWo9Y+DUkRGmaVl3pPouwoqcv
        6Yv30sRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMuDB-005Xp5-4i; Thu, 18 Mar 2021 15:05:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B21723003E1;
        Thu, 18 Mar 2021 16:05:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97A3F20D3873D; Thu, 18 Mar 2021 16:05:12 +0100 (CET)
Date:   Thu, 18 Mar 2021 16:05:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>, mgorman@suse.de,
        mingo@redhat.com, Odin Ugedal <odin@uged.al>,
        Odin Ugedal <odin@ugedal.com>, pauld@redhead.com,
        Paul Turner <pjt@google.com>, rostedt@goodmis.org,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS
 bandwidth burst
Message-ID: <YFNsKGKRL3SaJNZk@hirez.programming.kicks-ass.net>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
 <YFCAXeZj6sXBI5Ls@hirez.programming.kicks-ass.net>
 <B75EDF95-96B3-44E4-8169-3C1FCBC30A7B@linux.alibaba.com>
 <YFG4hEOe65cbCo26@hirez.programming.kicks-ass.net>
 <EA9BCA7F-8B57-4A87-A32E-DBBF8E7BAD8F@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EA9BCA7F-8B57-4A87-A32E-DBBF8E7BAD8F@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:26:58AM +0800, changhuaixin wrote:
> > On Mar 17, 2021, at 4:06 PM, Peter Zijlstra <peterz@infradead.org> wrote:

> > So what is the typical avg,stdev,max and mode for the workloads where you find
> > you need this?
> > 
> > I would really like to put a limit on the burst. IMO a workload that has
> > a burst many times longer than the quota is plain broken.
> 
> I see. Then the problem comes down to how large the limit on burst shall be.
> 
> I have sampled the CPU usage of a bursty container in 100ms periods. The statistics are:

So CPU usage isn't exactly what is required, job execution time is what
you're after. Assuming there is a relation...

> average	: 42.2%
> stddev	: 81.5%
> max		: 844.5%
> P95		: 183.3%
> P99		: 437.0%

Then your WCET is 844% of 100ms ? , which is .84s.

But you forgot your mode; what is the most common duration, given P95 is
so high, I doubt that avg is representative of the most common duration.

> If quota is 100000ms, burst buffer needs to be 8 times more in order
> for this workload not to be throttled.

Where does that 100s come from? And an 800s burst is bizarre.

Did you typo [us] as [ms] ?

> I can't say this is typical, but these workloads exist. On a machine
> running Kubernetes containers, where there is often room for such
> burst and the interference is hard to notice, users would prefer
> allowing such burst to being throttled occasionally.

Users also want ponies. I've no idea what kubernetes actually is or what
it has to do with containers. That's all just word salad.

> In this sense, I suggest limit burst buffer to 16 times of quota or
> around. That should be enough for users to improve tail latency caused
> by throttling. And users might choose a smaller one or even none, if
> the interference is unacceptable. What do you think?

Well, normal RT theory would suggest you pick your runtime around 200%
to get that P95 and then allow a full period burst to get your P99, but
that same RT theory would also have you calculate the resulting
interference and see if that works with the rest of the system...

16 times is horrific.

