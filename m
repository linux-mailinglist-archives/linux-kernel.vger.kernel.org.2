Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893403497B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCYRQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbhCYRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616692577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CvfaC95aieRSVkuhdfvCS5wS1U7ACP9oYPxW5/dC0DU=;
        b=hzXW6Mv9sTMVjpUp890/2k45uZ26DvOQR6zoImwgnWJz7rFDpIvLHZaxUNIuEUl2DPwUhC
        8Prmyv4JeD8hsW54ESDPRmV6RtSidLaOhJIWNeyy2rI5tSfxC93Ksp6ZzDRlGlhhWnzyYg
        eN+94RqD0S7kEz+PFhw/IqysCyshdpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-ksrTlQFjMsaDLsgrOHWiLg-1; Thu, 25 Mar 2021 13:16:12 -0400
X-MC-Unique: ksrTlQFjMsaDLsgrOHWiLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DD1D10A5A2F;
        Thu, 25 Mar 2021 17:15:18 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E76CB88F0C;
        Thu, 25 Mar 2021 17:15:12 +0000 (UTC)
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
 <YFxkXEXMpcMM/KWd@dhcp22.suse.cz>
 <76aaf359-9496-04df-a585-3662d0375749@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4bc3c5d8-f1a7-6439-8fee-582364a7c021@redhat.com>
Date:   Thu, 25 Mar 2021 18:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <76aaf359-9496-04df-a585-3662d0375749@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 17:56, Mike Kravetz wrote:
> On 3/25/21 3:22 AM, Michal Hocko wrote:
>> On Thu 25-03-21 10:56:38, David Hildenbrand wrote:
>>> On 25.03.21 01:28, Mike Kravetz wrote:
>>>> From: Roman Gushchin <guro@fb.com>
>>>>
>>>> cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
>>>> It makes it a blocking function, which complicates its usage from
>>>> non-blocking contexts. For instance, hugetlbfs code is temporarily
>>>> dropping the hugetlb_lock spinlock to call cma_release().
>>>>
>>>> This patch introduces a non-blocking cma_release_nowait(), which
>>>> postpones the cma bitmap clearance. It's done later from a work
>>>> context. The first page in the cma allocation is used to store
>>>> the work struct. Because CMA allocations and de-allocations are
>>>> usually not that frequent, a single global workqueue is used.
>>>>
>>>> To make sure that subsequent cma_alloc() call will pass, cma_alloc()
>>>> flushes the cma_release_wq workqueue. To avoid a performance
>>>> regression in the case when only cma_release() is used, gate it
>>>> by a per-cma area flag, which is set by the first call
>>>> of cma_release_nowait().
>>>>
>>>> Signed-off-by: Roman Gushchin <guro@fb.com>
>>>> [mike.kravetz@oracle.com: rebased to v5.12-rc3-mmotm-2021-03-17-22-24]
>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>> ---
>>>
>>>
>>> 1. Is there a real reason this is a mutex and not a spin lock? It seems to
>>> only protect the bitmap. Are bitmaps that huge that we spend a significant
>>> amount of time in there?
>>
>> Good question. Looking at the code it doesn't seem that there is any
>> blockable operation or any heavy lifting done under the lock.
>> 7ee793a62fa8 ("cma: Remove potential deadlock situation") has introduced
>> the lock and there was a simple bitmat protection back then. I suspect
>> the patch just followed the cma_mutex lead and used the same type of the
>> lock. cma_mutex used to protect alloc_contig_range which is sleepable.
>>
>> This all suggests that there is no real reason to use a sleepable lock
>> at all and we do not need all this heavy lifting.
>>
> 
> When Roman first proposed these patches, I brought up the same issue:
> 
> https://lore.kernel.org/linux-mm/20201022023352.GC300658@carbon.dhcp.thefacebook.com/
> 
> Previously, Roman proposed replacing the mutex with a spinlock but
> Joonsoo was opposed.
> 
> Adding Joonsoo on Cc:
> 

There has to be a good reason not to. And if there is a good reason, 
lockless clearing might be one feasible alternative.

-- 
Thanks,

David / dhildenb

