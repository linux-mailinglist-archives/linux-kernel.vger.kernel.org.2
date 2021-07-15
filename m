Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601233C95D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 04:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhGOCKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 22:10:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6930 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhGOCKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 22:10:20 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQHjP0vGJz7C0N;
        Thu, 15 Jul 2021 10:03:53 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 10:07:26 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 10:07:26 +0800
Subject: Re: [PATCH -next] sched: Dec __cfs_bandwith_used in
 destroy_cfs_bandwidth()
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
References: <3b2eb2c6-20d5-9f13-09f9-77f87f333b8d@huawei.com>
 <20210714132233.o4zvgdiiugxf6yxk@oracle.com>
In-Reply-To: <20210714132233.o4zvgdiiugxf6yxk@oracle.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <pjt@google.com>, <linux-kernel@vger.kernel.org>
Message-ID: <821cf5ad-4633-0005-63b3-14618891aeed@huawei.com>
Date:   Thu, 15 Jul 2021 10:07:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.251]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/14 21:22, Daniel Jordan wrote:
> On Wed, Jul 14, 2021 at 07:20:39PM +0800, Zhang Qiao wrote:
>> And i have another thought is that we can hold the
>> hotplug lock before calling cfs_bandwidth_usage_dec().
>> This way, fewer modifications are involved.
>> What do you think about it?
> 
> It is fewer lines, but then hotplug lock is taken pointlessly for
> !JUMP_LABEL.  Not a huge deal in a slow path like this, just a bit lame.
> Adding a new variant seems cleaner if more verbose.
make sense. And I will modify in next version.
thanks.
> .
> 
