Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884F8340637
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCRNAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230169AbhCRM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616072398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zttNs7jZbn6D0lj/XsWF0ni+5Nn1KjE+7Wi6kmfAuuo=;
        b=EyjUadxDE4dqnpVVfKSErLnlbU3bxE/fm9Qe5S3ntfTkR3aCOqnTc2kR21NwIWNcg76jC4
        k64NK9UM2bno1PpFfz9CoQvbr9CgwC04s1ISo2tfCe1YINP5tiugHoSjA2wEC03dO2WRk2
        vt6Za/+f/zNzpt0AVUhCSBXv0THpOs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-aKlDJAgtOEyllUU2KOOVgg-1; Thu, 18 Mar 2021 08:59:55 -0400
X-MC-Unique: aKlDJAgtOEyllUU2KOOVgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B06D107ACCD;
        Thu, 18 Mar 2021 12:59:52 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-115-156.rdu2.redhat.com [10.10.115.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40AC110013C1;
        Thu, 18 Mar 2021 12:59:46 +0000 (UTC)
Date:   Thu, 18 Mar 2021 08:59:44 -0400
From:   Phil Auld <pauld@redhat.com>
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>, mgorman@suse.de,
        mingo@redhat.com, Odin Ugedal <odin@uged.al>,
        Odin Ugedal <odin@ugedal.com>, pauld@redhat.com,
        Paul Turner <pjt@google.com>, rostedt@goodmis.org,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS
 bandwidth burst
Message-ID: <YFNNWumXTSa3Bssl@lorien.usersys.redhat.com>
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
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:26:58AM +0800 changhuaixin wrote:
> 
> 
> > On Mar 17, 2021, at 4:06 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Mar 17, 2021 at 03:16:18PM +0800, changhuaixin wrote:
> > 
> >>> Why do you allow such a large burst? I would expect something like:
> >>> 
> >>> 	if (burst > quote)
> >>> 		return -EINVAL;
> >>> 
> >>> That limits the variance in the system. Allowing super long bursts seems
> >>> to defeat the entire purpose of bandwidth control.
> >> 
> >> I understand your concern. Surely large burst value might allow super
> >> long bursts thus preventing bandwidth control entirely for a long
> >> time.
> >> 
> >> However, I am afraid it is hard to decide what the maximum burst
> >> should be from the bandwidth control mechanism itself. Allowing some
> >> burst to the maximum of quota is helpful, but not enough. There are
> >> cases where workloads are bursty that they need many times more than
> >> quota in a single period. In such cases, limiting burst to the maximum
> >> of quota fails to meet the needs.
> >> 
> >> Thus, I wonder whether is it acceptable to leave the maximum burst to
> >> users. If the desired behavior is to allow some burst, configure burst
> >> accordingly. If that is causing variance, use share or other fairness
> >> mechanism. And if fairness mechanism still fails to coordinate, do not
> >> use burst maybe.
> > 
> > It's not fairness, bandwidth control is about isolation, and burst
> > introduces interference.
> > 
> >> In this way, cfs_b->buffer can be removed while cfs_b->max_overrun is
> >> still needed maybe.
> > 
> > So what is the typical avg,stdev,max and mode for the workloads where you find
> > you need this?
> > 
> > I would really like to put a limit on the burst. IMO a workload that has
> > a burst many times longer than the quota is plain broken.
> 
> I see. Then the problem comes down to how large the limit on burst shall be.
> 
> I have sampled the CPU usage of a bursty container in 100ms periods. The statistics are:
> average	: 42.2%
> stddev	: 81.5%
> max		: 844.5%
> P95		: 183.3%
> P99		: 437.0%
> 
> If quota is 100000ms, burst buffer needs to be 8 times more in order for this workload not to be throttled.
> I can't say this is typical, but these workloads exist. On a machine running Kubernetes containers,
> where there is often room for such burst and the interference is hard to notice, users would prefer
> allowing such burst to being throttled occasionally.
>

I admit to not having followed all the history of this patch set. That said, when I see the above I just
think your quota is too low for your workload.

The burst (mis?)feature seems to be a way to bypass the quota.  And it sort of assumes cooperative
containers that will only burst when they need it and then go back to normal. 

> In this sense, I suggest limit burst buffer to 16 times of quota or around. That should be enough for users to
> improve tail latency caused by throttling. And users might choose a smaller one or even none, if the interference
> is unacceptable. What do you think?
> 

Having quotas that can regularly be exceeded by 16 times seems to make the concept of a quota
meaningless.  I'd have thought a burst would be some small percentage.

What if several such containers burst at the same time? Can't that lead to overcommit that can effect
other well-behaved containers?


Cheers,
Phil

-- 

