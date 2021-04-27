Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C6236BE90
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 06:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhD0EpS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Apr 2021 00:45:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3408 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhD0EpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:45:16 -0400
Received: from dggeml702-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FTpxd5d6Mz5sbc;
        Tue, 27 Apr 2021 12:41:25 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (7.185.36.106) by
 dggeml702-chm.china.huawei.com (10.3.17.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Apr 2021 12:44:32 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 12:44:31 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Tue, 27 Apr 2021 12:44:32 +0800
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
Thread-Index: AQHXOw9dc8i42PiGaEKAYTXwXtRa3KrHPV0AgACFWFA=
Date:   Tue, 27 Apr 2021 04:44:32 +0000
Message-ID: <d057eb13ec4e4643b314dd1652ffa9d4@hisilicon.com>
References: <20210427023758.4048-1-song.bao.hua@hisilicon.com>
 <9a6cadd9b65068b52c95adc44119bd09c6a4f9d7.camel@gmx.de>
In-Reply-To: <9a6cadd9b65068b52c95adc44119bd09c6a4f9d7.camel@gmx.de>
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
> Sent: Tuesday, April 27, 2021 4:22 PM
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
> On Tue, 2021-04-27 at 14:37 +1200, Barry Song wrote:
> >
> > To fix this issue, this patch checks the waker of sync wake-up is a task
> > but not an interrupt. In this case, the waker will schedule out and give
> > CPU to wakee.
> 
> That rash "the waker will schedule out" assumption, ie this really
> really is a synchronous wakeup, may be true in your particular case,

Hi Mike,

For my particular case, sync hint is used by interrupt but not task.
so "the waker will schedule out" is false because the existing task
is relevant at all.

Here the description "the waker will schedule out" is just copying
the general idea of sync wake-up though the real code might overuse
this hint.

> but the sync hint is so overused as to be fairly meaningless. We've
> squabbled with it repeatedly over the years because of that.  It really
> should either become more of a communication of intent than it
> currently is, or just go away.

I agree sync hint might have been overused by other kernel subsystem.
But this patch will at least fix a case: sync waker is interrupt,
in this case, the existing task has nothing to do with waker and wakee,
so this case should be excluded from wake_affine_idle().

> 
> I'd argue for go away, simply because there is no way for the kernel to
> know that there isn't more work directly behind any particular wakeup.

To some extent, "go way" might be a good choice. But this is a more
aggressive action. For those cases waker will really scheduler out,
wakee won't be able to take the advantage of getting the idle cpu
of waker.

> 
> Take a pipe, does shoving some bits through a pipe mean you have no
> further use of your CPU?  IFF you're doing nothing but playing ping-
> pong, sure it does, but how many real proggies have zero overlap among
> its threads of execution?  The mere notion of threaded apps having no
> overlap *to be converted to throughput* is dainbramaged, which should
> be the death knell of the sync wakeup hint.  Threaded apps can't do
> stuff like, oh, networking, which uses the sync hint heavily, without
> at least to some extent defeating the purpose of threading if we were
> to take the hint seriously.  Heck, just look at the beauty (gak) of
> wake_wide().  It was born specifically to combat the pure-evil side of
> the sync wakeup hint.

As above, removing the code of migrating wakee to the cpu of sync waker
could be an option, but needs more investigations.

> 
> Bah, 'nuff "Danger Will Robinson, that thing will *eat you*!!" ;-)
> 
> 	-Mike

Thanks
Barry
