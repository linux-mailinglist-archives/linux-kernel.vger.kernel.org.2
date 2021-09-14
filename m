Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFBA40ADD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhINMgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:36:49 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9868 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhINMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:36:48 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H82kv1KkBz8yWP;
        Tue, 14 Sep 2021 20:31:03 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 20:35:28 +0800
Received: from [127.0.0.1] (10.69.38.196) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 14
 Sep 2021 20:35:28 +0800
Subject: Re: [RFC] Perfomance varies according to sysctl_sched_migration_cost
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <21cnbao@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        <prime.zeng@huawei.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>
References: <ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com>
 <YUCHwYo525+/98wq@hirez.programming.kicks-ass.net>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <5be9d830-d6f4-6c2e-278f-940baeb57d89@hisilicon.com>
Date:   Tue, 14 Sep 2021 20:35:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YUCHwYo525+/98wq@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/14 19:30, Peter Zijlstra wrote:
> On Tue, Sep 14, 2021 at 03:27:09PM +0800, Yicong Yang wrote:
>> 2. The ABI now has been removed from sysctl and moved to debugfs. As tuning this can improve the performance
>>    of some workloads on some platforms, maybe it's better to make it a formal sysctl again with docs?
> 
> It never was an ABI, there is nothing to restore. It has always been
> CONFIG_SCHED_DEBUG.
> 

It's right that CONIG_SCHED_DEBUG is on for most releases and it's same to tune
it through debugfs. So I'm not with a strong heart to restore it but just curious
about this magic value since it does have some influence when tuning this on my platform.

> I'm open to topology based improvements to the code, but I don't think
> user tunables are a good way.
> 

sure, it's better to make the scheduler topology adapted rather than manually tuned, but
certainly it's not that easy to achieve. Maybe I can investigate the whole story
first, seems we didn't use a constant migration_cost_ns at very beginning, to see if there's
any inspiration.

Thanks.

> .
> 

