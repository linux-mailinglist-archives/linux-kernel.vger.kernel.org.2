Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4203396E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhFAIKy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Jun 2021 04:10:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3314 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhFAIKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:10:53 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FvPnm4SyMz19S3m;
        Tue,  1 Jun 2021 16:04:28 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (7.185.36.148) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:09:09 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:09:09 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Tue, 1 Jun 2021 16:09:09 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mel Gorman <mgorman@suse.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        tangchengchang <tangchengchang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH] sched: fair: don't depend on wake_wide if waker and wakee
 are already in same LLC
Thread-Topic: [PATCH] sched: fair: don't depend on wake_wide if waker and
 wakee are already in same LLC
Thread-Index: AQHXUhAXdUizMfoReUmU6BSpTsz4hqr1J2iAgAEbn9CAAHZUgIAHdICQgAAf8wCAAIRPEA==
Date:   Tue, 1 Jun 2021 08:09:09 +0000
Message-ID: <75ec9e490d1d4854ae2be4ad5b3b24b9@hisilicon.com>
References: <20210526091057.1800-1-song.bao.hua@hisilicon.com>
 <YK474+4xpYlAha+2@hirez.programming.kicks-ass.net>
 <7dd00a98d6454d5e92a7d9b936d1aa1c@hisilicon.com>
 <20210527121409.GK3672@suse.de>
 <07e4ba63a19c451ab47e6a636c400f4a@hisilicon.com>
 <20210601075918.GP3672@suse.de>
In-Reply-To: <20210601075918.GP3672@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.217]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mel Gorman [mailto:mgorman@suse.de]
> Sent: Tuesday, June 1, 2021 7:59 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Peter Zijlstra <peterz@infradead.org>; vincent.guittot@linaro.org;
> mingo@redhat.com; dietmar.eggemann@arm.com; rostedt@goodmis.org;
> bsegall@google.com; valentin.schneider@arm.com; juri.lelli@redhat.com;
> bristot@redhat.com; linux-kernel@vger.kernel.org; guodong.xu@linaro.org;
> yangyicong <yangyicong@huawei.com>; tangchengchang
> <tangchengchang@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH] sched: fair: don't depend on wake_wide if waker and wakee
> are already in same LLC
> 
> On Mon, May 31, 2021 at 10:21:55PM +0000, Song Bao Hua (Barry Song) wrote:
> > The benchmark of tbenchs is still positive:
> >
> > tbench4
> >
> >                            5.13-rc4               5.13-rc4
> >                                      disable-llc-wakewide/
> >
> > Hmean     1       514.87 (   0.00%)      505.17 *  -1.88%*
> > Hmean     2       914.45 (   0.00%)      918.45 *   0.44%*
> > Hmean     4      1483.81 (   0.00%)     1485.38 *   0.11%*
> > Hmean     8      2211.62 (   0.00%)     2236.02 *   1.10%*
> > Hmean     16     2129.80 (   0.00%)     2450.81 *  15.07%*
> > Hmean     32     5098.35 (   0.00%)     5085.20 *  -0.26%*
> > Hmean     64     4797.62 (   0.00%)     4801.34 *   0.08%*
> > Hmean     80     4802.89 (   0.00%)     4780.40 *  -0.47%*
> >
> > I guess something which work across several LLC domains
> > cause performance regression.
> >
> > I wonder how your test will be like if you pin the testing
> > to CPUs within one LLC?
> >
> 
> While I could do this, what would be the benefit? Running within one LLC
> would be running the test in one small fraction of the entire machine as
> the machine has multiple LLCs per NUMA node. A patch dealing with how the
> scheduler works with respect to LLC should take different configurations
> into consideration as best as possible.

I do agree with this. And I do admit this patch is lacking of
consideration and testing of supporting various configurations.
But more input of numbers will be helpful on figuring out a better
solution which can either extend to wider configurations or shrink
to some specific machines like those whose whole numa share
LLC or desktops whose all cpus share LLC in v2. eg:
My pc with the newest i9 intel has all 10 cpus(20 threads) sharing
LLC.

> 
> --
> Mel Gorman
> SUSE Labs

Thanks
Barry

