Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200273D1BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhGVCE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:04:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12284 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhGVCE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:04:27 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GVcBJ4C0pz7wsD;
        Thu, 22 Jul 2021 10:40:24 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 10:45:01 +0800
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 22 Jul
 2021 10:45:01 +0800
Subject: Re: [PATCH] workqueue: Fix possible memory leaks in wq_numa_init()
To:     Lai Jiangshan <jiangshanlai@gmail.com>
CC:     Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210719065914.3801-1-thunder.leizhen@huawei.com>
 <CAJhGHyCnmgpZjSP6wFCtY8Vr75eMuV-ZFtvWRuvXHDxejOpK2w@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <85e3c41c-0346-a77f-60f2-7ee8d51079b1@huawei.com>
Date:   Thu, 22 Jul 2021 10:44:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJhGHyCnmgpZjSP6wFCtY8Vr75eMuV-ZFtvWRuvXHDxejOpK2w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/22 10:05, Lai Jiangshan wrote:
> Please ignore my previous email which included/copied a wrong line of code.
> 
> On Thu, Jul 22, 2021 at 12:23 AM Tejun Heo <tj@kernel.org> wrote:
>> Yeah, idk. It's not an actual bug tho. Maybe we should just add a comment.
>> Which version do you like the best?
> 
> I hope Zhen Lei continues to refine his version.  I think he is still
> working on it.

Yes, I'm inclined to fix it, too. The tools aren't that smart, and handling
false positives is an annoyance.


> 
> On Mon, Jul 19, 2021 at 3:00 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> In error handling branch "if (WARN_ON(node == NUMA_NO_NODE))", the
>> previously allocated memories are not released. Doing this before
>> allocating memory eliminates memory leaks.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/workqueue.c | 19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 50142fc08902..6aa0ba582d15 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -5896,6 +5896,14 @@ static void __init wq_numa_init(void)
>>                 return;
>>         }
>>
>> +       for_each_possible_cpu(cpu) {
>> +               if (WARN_ON(cpu_to_node(cpu) == NUMA_NO_NODE)) {
>> +                       pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
> 
> 
>> +                       /* happens iff arch is bonkers, let's just proceed */
> 
> I don't think this comment is still needed.

OK, I will remove it.

> 
>> +                       return;
>> +               }
>> +       }
>> +
>>         wq_update_unbound_numa_attrs_buf = alloc_workqueue_attrs();
>>         BUG_ON(!wq_update_unbound_numa_attrs_buf);
>>
>> @@ -5907,18 +5915,11 @@ static void __init wq_numa_init(void)
>>         tbl = kcalloc(nr_node_ids, sizeof(tbl[0]), GFP_KERNEL);
>>         BUG_ON(!tbl);
>>
>> -       for_each_node(node)
>> +       for_each_node(node) {
>>                 BUG_ON(!zalloc_cpumask_var_node(&tbl[node], GFP_KERNEL,
>>                                 node_online(node) ? node : NUMA_NO_NODE));
>>
>> -       for_each_possible_cpu(cpu) {
>> -               node = cpu_to_node(cpu);
>> -               if (WARN_ON(node == NUMA_NO_NODE)) {
>> -                       pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
>> -                       /* happens iff arch is bonkers, let's just proceed */
>> -                       return;
>> -               }
>> -               cpumask_set_cpu(cpu, tbl[node]);
>> +               cpumask_copy(tbl[node], cpumask_of_node(node));
> 
> It is incorrect.  cpumask_of_node(node) is the online cpumask of the node, not
> the possible cpumask of the node that we are interested in.
> 
> If the NUMA subsystem provided something like cpumask_possible_of_node(node),
> we wouldn't need wq_numa_possible_cpumask.
> 
> Please keep "for_each_possible_cpu(cpu)" loop and
> "cpumask_set_cpu(cpu, tbl[node]);"

OK.

> 
>>         }
>>
>>         wq_numa_possible_cpumask = tbl;
>> --
>> 2.25.1
>>
> .
> 
