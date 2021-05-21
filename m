Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D558138C6B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhEUMm3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 May 2021 08:42:29 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:48522 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231584AbhEUMmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:42:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UZbu5W2_1621600848;
Received: from 30.240.99.2(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UZbu5W2_1621600848)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 May 2021 20:40:49 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v5 2/3] sched/fair: Add cfs bandwidth burst statistics
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <CAFpoUr1GZspG1yKHf3D=+BZKfufWNNdu2Ccuj+YBo8EaJYRi8w@mail.gmail.com>
Date:   Fri, 21 May 2021 20:42:27 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        pauld@redhead.com, Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        shanpeic@linux.alibaba.com, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <E4AA746E-6608-4576-BF19-57589B2867FE@linux.alibaba.com>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-3-changhuaixin@linux.alibaba.com>
 <CAFpoUr1GZspG1yKHf3D=+BZKfufWNNdu2Ccuj+YBo8EaJYRi8w@mail.gmail.com>
To:     Odin Ugedal <odin@uged.al>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 20, 2021, at 10:11 PM, Odin Ugedal <odin@uged.al> wrote:
> 
> I am a bit sceptical about both the nr_burst and burst_time as they are now.
> 
> As an example; a control group using "99.9%" of the quota each period
> and that is never throttled. Such group would with this patch with a burst of X
> still get nr_throttled = 0 (as before), but it would get a nr_burst
> and burst_time that
> will keep increasing.
> 

Agreed, there are false positive and false negetive cases, as the current implementation
uses cfs_b->runtime to judge instead of the actual runtime used.

> I think there is a big difference between runtime moved/taken from
> cfs_b->runtime to cfs_rq->runtime_remaining and the actual runtime used
> in the period. Currently, cfs bw can only supply info the first one, and
> not the latter.
> 
> I think that if people see nr_burst increasing, that they think they _have_
> to use cfs burst in order to avoid being throttled, even though that might
> not be the case. It is probably fine as is, as long as it is explicitly stated

It can't be seeing nr_burst incresing first, and using cfs burst feature afterwards.
Do you mean people see nr_throttled increasing and use cfs burst, while the actual usage
is below quota? In that case, tasks get throttled because there are runtime to be returned from
cfs_rq, and get unthrottled shortly. That is a false positive for nr_throttled. When users see that,
using burst can help improve.

> what the values mean and imply, and what they do not. I cannot see another
> way to calculate it as it is now, but maybe someone else has some thoughts.
> 
> Thanks
> Odin

