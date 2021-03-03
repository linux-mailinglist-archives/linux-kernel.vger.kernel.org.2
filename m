Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A02932BE7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349273AbhCCRbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:17 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49581 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1444892AbhCCNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:47:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UQGMW59_1614779196;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UQGMW59_1614779196)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Mar 2021 21:46:36 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH v2 3/3] mm/slub: Use percpu partial free counter
To:     Christoph Lameter <cl@gentwo.de>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
 <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com>
 <alpine.DEB.2.22.394.2103021012010.860725@gentwo.de>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <1c61e8fb-98ef-6d5f-12d7-ab5f16890e17@linux.alibaba.com>
Date:   Wed, 3 Mar 2021 21:46:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2103021012010.860725@gentwo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/21 5:14 PM, Christoph Lameter wrote:
> On Mon, 10 Aug 2020, Xunlei Pang wrote:
> 
>>
>> diff --git a/mm/slab.h b/mm/slab.h
>> index c85e2fa..a709a70 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -616,7 +616,7 @@ struct kmem_cache_node {
>>  #ifdef CONFIG_SLUB
>>  	unsigned long nr_partial;
>>  	struct list_head partial;
>> -	atomic_long_t partial_free_objs;
>> +	atomic_long_t __percpu *partial_free_objs;
> 
> A percpu counter is never atomic. Just use unsigned long and use this_cpu
> operations for this thing. That should cut down further on the overhead.
> 
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1775,11 +1775,21 @@ static void discard_slab(struct kmem_cache *s, struct page *page)
>>  /*
>>   * Management of partially allocated slabs.
>>   */
>> +static inline long get_partial_free(struct kmem_cache_node *n)
>> +{
>> +	long nr = 0;
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu)
>> +		nr += atomic_long_read(per_cpu_ptr(n->partial_free_objs, cpu));
> 
> this_cpu_read(*n->partial_free_objs)
> 
>>  static inline void
>>  __update_partial_free(struct kmem_cache_node *n, long delta)
>>  {
>> -	atomic_long_add(delta, &n->partial_free_objs);
>> +	atomic_long_add(delta, this_cpu_ptr(n->partial_free_objs));
> 
> this_cpu_add()
> 
> and so on.
> 

Thanks, I changed them both to use "unsigned long", and will send v3 out
after our internal performance regression test passes.
