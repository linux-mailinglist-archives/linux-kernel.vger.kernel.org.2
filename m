Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B684074C5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 04:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhIKDA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 23:00:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9416 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKDAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:00:25 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H5y5P1MyHz8yLQ;
        Sat, 11 Sep 2021 10:54:49 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Sat, 11 Sep 2021 10:59:12 +0800
Received: from [10.67.102.197] (10.67.102.197) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 11 Sep 2021 10:59:11 +0800
Subject: Re: [patch V5 34/72] locking/rwlock: Provide RT variant
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
References: <20210815203225.710392609@linutronix.de>
 <20210815211303.882793524@linutronix.de>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <d456062c-d5d4-be8a-d960-1a1d43f63456@huawei.com>
Date:   Sat, 11 Sep 2021 10:59:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20210815211303.882793524@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema774-chm.china.huawei.com (10.1.198.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/16 5:28, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Similar to rw_semaphores on RT the rwlock substitution is not writer fair
> because it's not feasible to have a writer inherit it's priority to
> multiple readers. Readers blocked on a writer follow the normal rules of
> priority inheritance. Like RT spinlocks RT rwlocks are state preserving
> across the slow lock operations (contended case).
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V5: Add missing might_sleep() and fix lockdep init (Sebastian)
> ---
>   include/linux/rwlock_rt.h       |  140 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/rwlock_types.h    |   49 ++++++++++----
>   include/linux/spinlock_rt.h     |    2
>   kernel/Kconfig.locks            |    2
>   kernel/locking/spinlock.c       |    7 ++
>   kernel/locking/spinlock_debug.c |    5 +
>   kernel/locking/spinlock_rt.c    |  131 +++++++++++++++++++++++++++++++++++++
>   7 files changed, 323 insertions(+), 13 deletions(-)
>   create mode 100644 include/linux/rwlock_rt.h
> ---
.....
> +
> +int __sched rt_rwlock_is_contended(rwlock_t *rwlock)
> +{
> +	return rw_base_is_contended(&rwlock->rwbase);
> +}
> +EXPORT_SYMBOL(rt_rwlock_is_contended);
> +

rt_rwlock_is_conted() exported but not declared in the header file?
Is this a special design or a mistake?

Thanks
Xiaoming Ni

