Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366B836BF16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhD0GF7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Apr 2021 02:05:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3957 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhD0GF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:05:57 -0400
Received: from dggeml763-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FTrlQ4Zhwz5vms;
        Tue, 27 Apr 2021 14:02:42 +0800 (CST)
Received: from dggpemm000002.china.huawei.com (7.185.36.174) by
 dggeml763-chm.china.huawei.com (10.1.199.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Apr 2021 14:05:10 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm000002.china.huawei.com (7.185.36.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 14:05:09 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Tue, 27 Apr 2021 14:05:09 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mike Galbraith <efault@gmx.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>
CC:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "xieyongjia (A)" <xieyongjia1@huawei.com>
Subject: RE: [PATCH] sched/fair: don't use waker's cpu if the waker of sync
 wake-up is interrupt
Thread-Topic: [PATCH] sched/fair: don't use waker's cpu if the waker of sync
 wake-up is interrupt
Thread-Index: AQHXOw9dc8i42PiGaEKAYTXwXtRa3KrHPV0AgACFWFD//5SmAIAAhgYg
Date:   Tue, 27 Apr 2021 06:05:09 +0000
Message-ID: <6c91195a6de9423abc78e8f85efc2780@hisilicon.com>
References: <20210427023758.4048-1-song.bao.hua@hisilicon.com>
         <9a6cadd9b65068b52c95adc44119bd09c6a4f9d7.camel@gmx.de>
         <d057eb13ec4e4643b314dd1652ffa9d4@hisilicon.com>
 <3fe7113cc87ac89077b55ca55bda2b99729f13c8.camel@gmx.de>
In-Reply-To: <3fe7113cc87ac89077b55ca55bda2b99729f13c8.camel@gmx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mike Galbraith [mailto:efault@gmx.de]
> Sent: Tuesday, April 27, 2021 5:55 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> vincent.guittot@linaro.org; mingo@redhat.com; peterz@infradead.org;
> dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
> mgorman@suse.de
> Cc: valentin.schneider@arm.com; juri.lelli@redhat.com; bristot@redhat.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; xuwei (O)
> <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> guodong.xu@linaro.org; yangyicong <yangyicong@huawei.com>; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>; linuxarm@openeuler.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; xieyongjia (A) <xieyongjia1@huawei.com>
> Subject: Re: [PATCH] sched/fair: don't use waker's cpu if the waker of sync
> wake-up is interrupt
> 
> On Tue, 2021-04-27 at 04:44 +0000, Song Bao Hua (Barry Song) wrote:
> >
> >
> > I agree sync hint might have been overused by other kernel subsystem.
> > But this patch will at least fix a case: sync waker is interrupt,
> > in this case, the existing task has nothing to do with waker and wakee,
> > so this case should be excluded from wake_affine_idle().
> 
> I long ago tried filtering interrupt wakeups, and met some surprises.
> Wakeup twiddling always managing to end up being a rob Peter to pay
> Paul operation despite our best efforts, here's hoping that your pile
> of stolen cycles is small enough to escape performance bot notice :)

Would you like to share the link you did before to filter interrupt
wakeups?

The wake up path has hundreds of lines of code, so I don't expect that
reading preempt_count will cause visible performance losses to bot. But
who knows :-)

> 
> 	-Mike

Thanks
Barry
