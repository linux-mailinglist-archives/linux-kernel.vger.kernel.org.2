Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738F633EA63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCQHOi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Mar 2021 03:14:38 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:55896 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229550AbhCQHO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:14:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0USESlcv_1615965261;
Received: from 30.240.101.46(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0USESlcv_1615965261)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 15:14:22 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS bandwidth
 burst
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <YFCAXeZj6sXBI5Ls@hirez.programming.kicks-ass.net>
Date:   Wed, 17 Mar 2021 15:16:18 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>, mgorman@suse.de,
        mingo@redhat.com, Odin Ugedal <odin@uged.al>,
        Odin Ugedal <odin@ugedal.com>, pauld@redhead.com,
        Paul Turner <pjt@google.com>, rostedt@goodmis.org,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <B75EDF95-96B3-44E4-8169-3C1FCBC30A7B@linux.alibaba.com>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
 <YFCAXeZj6sXBI5Ls@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 16, 2021, at 5:54 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Tue, Mar 16, 2021 at 12:49:28PM +0800, Huaixin Chang wrote:
>> @@ -8982,6 +8983,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
>> 	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
>> 		return -EINVAL;
>> 
>> +	/*
>> +	 * Bound burst to defend burst against overflow during bandwidth shift.
>> +	 */
>> +	if (burst > max_cfs_runtime)
>> +		return -EINVAL;
> 
> Why do you allow such a large burst? I would expect something like:
> 
> 	if (burst > quote)
> 		return -EINVAL;
> 
> That limits the variance in the system. Allowing super long bursts seems
> to defeat the entire purpose of bandwidth control.

I understand your concern. Surely large burst value might allow super long bursts
thus preventing bandwidth control entirely for a long time.

However, I am afraid it is hard to decide what the maximum burst should be from
the bandwidth control mechanism itself. Allowing some burst to the maximum of
quota is helpful, but not enough. There are cases where workloads are bursty
that they need many times more than quota in a single period. In such cases, limiting
burst to the maximum of quota fails to meet the needs.

Thus, I wonder whether is it acceptable to leave the maximum burst to users. If the desired
behavior is to allow some burst, configure burst accordingly. If that is causing variance, use share
or other fairness mechanism. And if fairness mechanism still fails to coordinate, do not use
burst maybe.

In this way, cfs_b->buffer can be removed while cfs_b->max_overrun is still needed maybe.
