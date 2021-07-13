Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760EF3C6BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhGMIFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:05:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15007 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:05:14 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GPChB21bYzbc4Z;
        Tue, 13 Jul 2021 15:59:06 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 16:02:21 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 16:02:20 +0800
Subject: Re: [PATCH v2] workqueue: fix UAF in pwq_unbound_release_workfn()
To:     Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Xu Qiang <xuqiang36@huawei.com>,
        Pavel Skripkin <paskripkin@gmail.com>
References: <20210709071100.4057639-1-yangyingliang@huawei.com>
 <YOx392cwdEHMMnD0@slm.duckdns.org>
 <CAJhGHyC+oyX6fqnR1-JPnNgPuDpikU6KYr1iXrj7BDZHnjPGTA@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <e8fa4afb-39df-548c-e6f0-4c91cd3c259c@huawei.com>
Date:   Tue, 13 Jul 2021 16:02:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJhGHyC+oyX6fqnR1-JPnNgPuDpikU6KYr1iXrj7BDZHnjPGTA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/7/13 13:56, Lai Jiangshan wrote:
> On Tue, Jul 13, 2021 at 1:12 AM Tejun Heo <tj@kernel.org> wrote:
>> Hello, Yang.
>>
>>> +static void free_pwq(struct pool_workqueue *pwq)
>>> +{
>>> +     if (!pwq || --pwq->refcnt)
>>> +             return;
>>> +
>>> +     put_unbound_pool(pwq->pool);
>>> +     kmem_cache_free(pwq_cache, pwq);
>>> +}
>>> +
>>> +static void free_wqattrs_ctx(struct apply_wqattrs_ctx *ctx)
>>> +{
>>> +     int node;
>>> +
>>> +     if (!ctx)
>>> +             return;
>>> +
>>> +     for_each_node(node)
>>> +             free_pwq(ctx->pwq_tbl[node]);
>>> +     free_pwq(ctx->dfl_pwq);
>>> +
>>> +     free_workqueue_attrs(ctx->attrs);
>>> +
>>> +     kfree(ctx);
>>> +}
>> It bothers me that we're partially replicating the free path including pwq
>> refcnting.
> The replicating code can be reduced by merging
> apply_wqattrs_cleanup() into apply_wqattrs_commit().
>
>> Does something like the following work?
> It works since it has a flush_scheduled_work() in
> alloc_and_link_pwqs(). But I don't think it works for
> workqueue_apply_unbound_cpumask() when apply_wqattrs_commit()
> is not called.
>
> If we want to reuse the current apply_wqattrs_cleanup(), I would prefer
> something like this: (untested)
>
> @@ -3680,15 +3676,21 @@ static void pwq_unbound_release_workfn(struct
> work_struct *work)
>                                                    unbound_release_work);
>          struct workqueue_struct *wq = pwq->wq;
>          struct worker_pool *pool = pwq->pool;
> -       bool is_last;
> +       bool is_last = false;
>
> -       if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
> -               return;
> +       /*
> +        * when @pwq is not linked, it doesn't hold any reference to the
> +        * @wq, and @wq is invalid to access.
> +        */
> +       if (!list_empty(&pwq->pwqs_node)) {
> +               if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
> +                       return;
>
> -       mutex_lock(&wq->mutex);
> -       list_del_rcu(&pwq->pwqs_node);
> -       is_last = list_empty(&wq->pwqs);
> -       mutex_unlock(&wq->mutex);
> +               mutex_lock(&wq->mutex);
> +               list_del_rcu(&pwq->pwqs_node);
> +               is_last = list_empty(&wq->pwqs);
> +               mutex_unlock(&wq->mutex);
> +       }
>
>          mutex_lock(&wq_pool_mutex);
>          put_unbound_pool(pool);
I test the code with my testcase, it works. I can send a v3 about this.

Thanks,
Yang
>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 104e3ef04e33..0c0ab363edeb 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -3693,7 +3693,7 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
>>           * If we're the last pwq going away, @wq is already dead and no one
>>           * is gonna access it anymore.  Schedule RCU free.
>>           */
>> -       if (is_last) {
>> +       if (is_last && !list_empty(&wq->list)) {
>>                  wq_unregister_lockdep(wq);
>>                  call_rcu(&wq->rcu, rcu_free_wq);
>>          }
>> @@ -4199,6 +4199,10 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>>          }
>>          put_online_cpus();
>>
>> +       if (ret) {
>> +               flush_scheduled_work();
>> +       }
>> +
>>          return ret;
>>   }
>>
>> --
>> tejun
> .
