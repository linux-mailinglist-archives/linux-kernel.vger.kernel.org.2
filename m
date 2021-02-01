Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D595D30A5C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhBAKqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:46:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:48862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233333AbhBAKqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:46:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0F62ADDD;
        Mon,  1 Feb 2021 10:45:27 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To:     Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
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
 <6ceff3cb-c9e9-7e74-92f0-dd745987c943@huawei.com>
 <114751ac-1f7d-ce5e-12c5-7d6303bdb999@suse.de>
 <aebc6c2d-4711-95ba-daf2-1cd17fc6f0e7@huawei.com>
 <47a1b796-9d91-5947-4bac-dd8f397041a3@suse.de>
 <bd37abd5-759d-efe2-fdcd-8b004a41c75a@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2752ed93-6bd5-1a13-0e05-b91e2dcc24e1@suse.de>
Date:   Mon, 1 Feb 2021 11:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <bd37abd5-759d-efe2-fdcd-8b004a41c75a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 10:40 AM, Chao Leng wrote:
> 
> 
> On 2021/2/1 16:57, Hannes Reinecke wrote:
>> On 2/1/21 9:47 AM, Chao Leng wrote:
>>>
>>>
>>> On 2021/2/1 15:29, Hannes Reinecke wrote:[ .. ]
>>>> Urgh. Please, no. That is well impossible to debug.
>>>> Can you please open-code it to demonstrate where the difference to 
>>>> the current (and my fixed) versions is?
>>>> I'm still not clear where the problem is once we applied both patches.
>>> For example assume the list has three path, and all path is not 
>>> NVME_ANA_OPTIMIZED:
>>> head->next = ns1;
>>> ns1->next = ns2;
>>> ns2->next = head;
>>> old->next = ns2;
>>>
>> And this is where I have issues with.
>> Where does 'old' come from?
>> Clearly it was part of the list at one point; so what happened to it?
> I explained this earlier.
> In nvme_ns_remove, there is a hole between list_del_rcu and
> nvme_mpath_clear_current_path. If head->current_path is the "old", and
> the "old" is removing. The "old" is already removed from the list by
> list_del_rcu, but head->current_path is not clear to NULL by
> nvme_mpath_clear_current_path.
> Find path is race with nvme_ns_remove, use the "old" pass to
> nvme_round_robin_path to find path.

Ah. So this should be better:

@@ -202,10 +202,12 @@ static struct nvme_ns *__nvme_find_path(struct 
nvme_ns_head *head, int node)
  static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
                 struct nvme_ns *ns)
  {
-       ns = list_next_or_null_rcu(&head->list, &ns->siblings, struct 
nvme_ns,
-                       siblings);
-       if (ns)
-               return ns;
+       if (ns && !test_bit(NVME_NS_REMOVING, &ns->flags)) {
+               ns = list_next_or_null_rcu(&head->list, &ns->siblings,
+                                          struct nvme_ns, siblings);
+               if (ns)
+                       return ns;
+       }
         return list_first_or_null_rcu(&head->list, struct nvme_ns, 
siblings);
  }

The 'NVME_NS_REMOVING' bit is set before list_del_rcu() is called, so it 
should guard against the issue you mentioned.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
