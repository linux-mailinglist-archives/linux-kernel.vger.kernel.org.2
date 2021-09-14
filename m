Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC5F40A90B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhINIVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:21:25 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16252 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhINIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:21:24 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H7x8d073Lz8t7f;
        Tue, 14 Sep 2021 16:19:29 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 16:20:04 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 16:20:03 +0800
Subject: Re: [PATCH v2] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
To:     Tejun Heo <tj@kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>
References: <20210911075054.6358-1-zhangqiao22@huawei.com>
 <YT+R3EnFgs78Vyvh@slm.duckdns.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <YT+R3EnFgs78Vyvh@slm.duckdns.org>
Message-ID: <b30205b0-bf54-7255-fc1c-9dfa5dbb4940@huawei.com>
Date:   Tue, 14 Sep 2021 16:20:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.251]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/9/14 2:01, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Sat, Sep 11, 2021 at 03:50:54PM +0800, Zhang Qiao wrote:
>> Between cgroup_can_fork() and cgroup_post_fork(), the cgroup
>> membership is fixed and thus sched_task_group can't change. So
>> call sched_fork() after cgroup_can_fork() and update the child's
>> sched_task_group before it is used.
> 
> The part being fixed looks correct to me but it's difficult to for me to
> assess whether the whole relocation of the sched_fork() hook doesn't change

Indeed is this, although I checked and tested it many times.

> anything else. Besides, even if we decide to relocate the sched_fork hook, I
> think it'd be better to separate the two changes - one is a relatively safe
> bug fix, the other is a code reorganization with possibly subtle side
> effects. So, I think it'd be better to produce a patch which just fixes the
> bug even if that ends up introducing another function in the flow.

Perhaps we can fix this bug at sched_post_fork(), which is executed between cgroup_can_fork()
and cgroup_post_fork(). Relocate the fectching of task_group and access it at sched_post_fork().

thanks.

> 
> Thanks.
> 
