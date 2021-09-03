Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0982A40004B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhICNOC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Sep 2021 09:14:02 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41554 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235062AbhICNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 09:14:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0Un7-YEe_1630674745;
Received: from 30.25.247.32(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0Un7-YEe_1630674745)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Sep 2021 21:12:57 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/2 v2] Add statistics and document for cfs_b burst
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <20210830032215.16302-1-changhuaixin@linux.alibaba.com>
Date:   Fri, 3 Sep 2021 21:12:25 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>, anderson@cs.unc.edu,
        baruah@wustl.edu, Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, luca.abeni@santannapisa.it,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com, daniel.m.jordan@oracle.com
Content-Transfer-Encoding: 8BIT
Message-Id: <633865D2-64F8-448E-A862-C754D6217123@linux.alibaba.com>
References: <20210830032215.16302-1-changhuaixin@linux.alibaba.com>
To:     open list <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wonder how do these two patches look this time, from cfs_b's point of view.
The statistics is simpler than before. And document is added too.

> On Aug 30, 2021, at 11:22 AM, Huaixin Chang <changhuaixin@linux.alibaba.com> wrote:
> 
> Changelog:
> v2:
> - Use burst_time in nanoseconds for cgroup1 interface, and burst_usec
>  in microseconds for cgroup2 interface.
> - Minor document adjustment.
> 
> v1 Link:
> https://lore.kernel.org/lkml/20210816070849.3153-1-changhuaixin@linux.alibaba.com/
> 
> Huaixin Chang (2):
>  sched/fair: Add cfs bandwidth burst statistics
>  sched/fair: Add document for burstable CFS bandwidth
> 
> Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> Documentation/scheduler/sched-bwc.rst   | 85 +++++++++++++++++++++++++++++----
> kernel/sched/core.c                     | 13 +++--
> kernel/sched/fair.c                     |  9 ++++
> kernel/sched/sched.h                    |  3 ++
> 5 files changed, 105 insertions(+), 13 deletions(-)
> 
> -- 
> 2.14.4.44.g2045bb6

