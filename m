Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937B133EB14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCQIIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:08:02 -0400
Received: from casper.infradead.org ([90.155.50.34]:50172 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCQIHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D3q4uZIDgb68GSwlm454Rhapno1E10IoZume3/wE36s=; b=OjugeP+axRk/DyZ+Xn2c9QouKf
        os2/3A3d1KS5D9Y+Pt2NdwUKgRotkjLAxGWq8GD8G4O/+hd5k6yaOrkP5vInMMWDPLJx5qUmglUoK
        /QLiY7nzYZK3g9o4sqSdkCynWthXd3ZR9sLAwlPnvBhuWup1Gkf2PMYUvN0t1ga6yEULJpUQvfKZj
        IHctHg23L6C75+sUAfVEEYoQc8mhe58pjxsbNusbDw8HlHGD09U/TcQg9Avrbc0MzgUxszG/OdZMI
        NjRfLWztjlQ2aTNulNWnLmFCqobHoEHkT/58iwMsC49kOiwDV4rx/H2l+1fHgSiX1yc1hVhKrB+xi
        7gZLgllQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMRCO-001FQb-3Q; Wed, 17 Mar 2021 08:06:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59A5C301324;
        Wed, 17 Mar 2021 09:06:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CBDE2C0B11A2; Wed, 17 Mar 2021 09:06:28 +0100 (CET)
Date:   Wed, 17 Mar 2021 09:06:28 +0100
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
Message-ID: <YFG4hEOe65cbCo26@hirez.programming.kicks-ass.net>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
 <YFCAXeZj6sXBI5Ls@hirez.programming.kicks-ass.net>
 <B75EDF95-96B3-44E4-8169-3C1FCBC30A7B@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B75EDF95-96B3-44E4-8169-3C1FCBC30A7B@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 03:16:18PM +0800, changhuaixin wrote:

> > Why do you allow such a large burst? I would expect something like:
> > 
> > 	if (burst > quote)
> > 		return -EINVAL;
> > 
> > That limits the variance in the system. Allowing super long bursts seems
> > to defeat the entire purpose of bandwidth control.
> 
> I understand your concern. Surely large burst value might allow super
> long bursts thus preventing bandwidth control entirely for a long
> time.
> 
> However, I am afraid it is hard to decide what the maximum burst
> should be from the bandwidth control mechanism itself. Allowing some
> burst to the maximum of quota is helpful, but not enough. There are
> cases where workloads are bursty that they need many times more than
> quota in a single period. In such cases, limiting burst to the maximum
> of quota fails to meet the needs.
> 
> Thus, I wonder whether is it acceptable to leave the maximum burst to
> users. If the desired behavior is to allow some burst, configure burst
> accordingly. If that is causing variance, use share or other fairness
> mechanism. And if fairness mechanism still fails to coordinate, do not
> use burst maybe.

It's not fairness, bandwidth control is about isolation, and burst
introduces interference.

> In this way, cfs_b->buffer can be removed while cfs_b->max_overrun is
> still needed maybe.

So what is the typical avg,stdev,max and mode for the workloads where you find
you need this?

I would really like to put a limit on the burst. IMO a workload that has
a burst many times longer than the quota is plain broken.
