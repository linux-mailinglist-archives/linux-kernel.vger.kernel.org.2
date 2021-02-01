Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233DB30A04F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 03:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhBACRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 21:17:32 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2572 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhBACRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 21:17:20 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DTWjN2ZnJzW62Q;
        Mon,  1 Feb 2021 10:14:32 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 1 Feb 2021 10:16:36 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Mon, 1 Feb
 2021 10:16:35 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        "Daniel Wagner" <dwagner@suse.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Jens Axboe" <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
 <65392653-6b03-9195-f686-5fe4b3290bd2@suse.de>
 <81b22bbf-4dd3-6161-e63a-9699690a4e4f@huawei.com>
 <715dd943-0587-be08-2840-e0948cf0bc62@suse.de>
 <eb131d8f-f009-42e7-105d-58b84060f0dd@huawei.com>
 <ac019690-7f02-d28c-ed58-bfc8c1d48879@suse.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <6ceff3cb-c9e9-7e74-92f0-dd745987c943@huawei.com>
Date:   Mon, 1 Feb 2021 10:16:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ac019690-7f02-d28c-ed58-bfc8c1d48879@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/29 17:20, Hannes Reinecke wrote:
> On 1/29/21 9:46 AM, Chao Leng wrote:
>>
>>
>> On 2021/1/29 16:33, Hannes Reinecke wrote:
>>> On 1/29/21 8:45 AM, Chao Leng wrote:
>>>>
>>>>
>>>> On 2021/1/29 15:06, Hannes Reinecke wrote:
>>>>> On 1/29/21 4:07 AM, Chao Leng wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/1/29 9:42, Sagi Grimberg wrote:
>>>>>>>
>>>>>>>>> You can't see exactly where it dies but I followed the assembly to
>>>>>>>>> nvme_round_robin_path(). Maybe it's not the initial nvme_next_ns(head,
>>>>>>>>> old) which returns NULL but nvme_next_ns() is returning NULL eventually
>>>>>>>>> (list_next_or_null_rcu()).
>>>>>>>> So there is other bug cause nvme_next_ns abormal.
>>>>>>>> I review the code about head->list and head->current_path, I find 2 bugs
>>>>>>>> may cause the bug:
>>>>>>>> First, I already send the patch. see:
>>>>>>>> https://lore.kernel.org/linux-nvme/20210128033351.22116-1-lengchao@huawei.com/
>>>>>>>> Second, in nvme_ns_remove, list_del_rcu is before
>>>>>>>> nvme_mpath_clear_current_path. This may cause "old" is deleted from the
>>>>>>>> "head", but still use "old". I'm not sure there's any other
>>>>>>>> consideration here, I will check it and try to fix it.
>>>>>>>
>>>>>>> The reason why we first remove from head->list and only then clear
>>>>>>> current_path is because the other way around there is no way
>>>>>>> to guarantee that that the ns won't be assigned as current_path
>>>>>>> again (because it is in head->list).
>>>>>> ok, I see.
>>>>>>>
>>>>>>> nvme_ns_remove fences continue of deletion of the ns by synchronizing
>>>>>>> the srcu such that for sure the current_path clearance is visible.
>>>>>> The list will be like this:
>>>>>> head->next = ns1;
>>>>>> ns1->next = head;
>>>>>> old->next = ns1;
>>>>>
>>>>> Where does 'old' pointing to?
>>>>>
>>>>>> This may cause infinite loop in nvme_round_robin_path.
>>>>>> for (ns = nvme_next_ns(head, old);
>>>>>>      ns != old;
>>>>>>      ns = nvme_next_ns(head, ns))
>>>>>> The ns will always be ns1, and then infinite loop.
>>>>>
>>>>> No. nvme_next_ns() will return NULL.
>>>> If there is just one path(the "old") and the "old" is deleted,
>>>> nvme_next_ns() will return NULL.
>>>> The list like this:
>>>> head->next = head;
>>>> old->next = head;
>>>> If there is two or more path and the "old" is deleted,
>>>> "for" will be infinite loop. because nvme_next_ns() will return
>>>> the path which in the list except the "old", check condition will
>>>> be true for ever.
>>>
>>> But that will be caught by the statement above:
>>>
>>> if (list_is_singular(&head->list))
>>>
>>> no?
>> Two path just a sample example.
>> If there is just two path, will enter it, may cause no path but there is
>> actually one path. It is falsely assumed that the "old" must be not deleted.
>> If there is more than two path, will cause infinite loop.
> So you mean we'll need something like this?
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 71696819c228..8ffccaf9c19a 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -202,10 +202,12 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>   static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
>                  struct nvme_ns *ns)
>   {
> -       ns = list_next_or_null_rcu(&head->list, &ns->siblings, struct nvme_ns,
> -                       siblings);
> -       if (ns)
> -               return ns;
> +       if (ns) {
> +               ns = list_next_or_null_rcu(&head->list, &ns->siblings,
> +                                          struct nvme_ns, siblings);
> +               if (ns)
> +                       return ns;
> +       }
No, in the scenario, ns should not be NULL.
May be we can do like this:

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 282b7a4ea9a9..b895011a2cbd 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -199,30 +199,24 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
         return found;
  }

-static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
-               struct nvme_ns *ns)
-{
-       ns = list_next_or_null_rcu(&head->list, &ns->siblings, struct nvme_ns,
-                       siblings);
-       if (ns)
-               return ns;
-       return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
-}
+#define nvme_next_ns_condition(head, current, condition) \
+({ \
+       struct nvme_ns *__ptr = list_next_or_null_rcu(&(head)->list, \
+               &(current)->siblings, struct nvme_ns, siblings); \
+       __ptr ? __ptr : (condition) ? (condition) = false, \
+               list_first_or_null_rcu(&(head)->list, struct nvme_ns, \
+                       siblings) : NULL; \
+})

  static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
                 int node, struct nvme_ns *old)
  {
         struct nvme_ns *ns, *found = NULL;
+       bool first_half = true;

-       if (list_is_singular(&head->list)) {
-               if (nvme_path_is_disabled(old))
-                       return NULL;
-               return old;
-       }
-
-       for (ns = nvme_next_ns(head, old);
+       for (ns = nvme_next_ns_condition(head, old, first_half);
              ns && ns != old;
-            ns = nvme_next_ns(head, ns)) {
+            ns = nvme_next_ns_condition(head, ns, first_half)) {
                 if (nvme_path_is_disabled(ns))
                         continue;

>          return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
>   }
> 
> Cheers,
> 
> Hannes
