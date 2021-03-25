Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D63C348DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCYKOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhCYKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616667250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kFVmifOqpEQKi5+QdYUnPBCpq2/U9G4tu0rz+JAWHU=;
        b=VDWqQPS/aA+RZQIvZsyh6kNaOM/apzbBS7KNDGT8WxiUnZdolOwTQ6xsSp6Qo2uDPZJVO4
        rwz4jLQpTPjSTfr0qKLLUP9yVXeTHm1jji4uEWTlO80hsYzJ/amBgneLGtq65bBKI7nCp2
        nKbh/SzVaKNGRpqSNzJju4ar98RTK9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-pnLX6_OEOCS29hZdy1WTPw-1; Thu, 25 Mar 2021 06:14:06 -0400
X-MC-Unique: pnLX6_OEOCS29hZdy1WTPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA74B101F7AF;
        Thu, 25 Mar 2021 10:14:04 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 797F417264;
        Thu, 25 Mar 2021 10:13:54 +0000 (UTC)
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
To:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
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
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <YFxbrn7pHN4TIHkR@dhcp22.suse.cz> <YFxh5SgXnKsbiFgj@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5afbce32-bb3a-9056-9f61-f26b78ad5f54@redhat.com>
Date:   Thu, 25 Mar 2021 11:13:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFxh5SgXnKsbiFgj@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 11:11, Michal Hocko wrote:
> On Thu 25-03-21 10:45:19, Michal Hocko wrote:
>> On Wed 24-03-21 17:28:28, Mike Kravetz wrote:
>> [...]
>>>   phys_addr_t cma_get_base(const struct cma *cma)
>>>   {
>>>   	return PFN_PHYS(cma->base_pfn);
>>> @@ -146,6 +155,10 @@ static int __init cma_init_reserved_areas(void)
>>>   	for (i = 0; i < cma_area_count; i++)
>>>   		cma_activate_area(&cma_areas[i]);
>>>   
>>> +	cma_release_wq = create_workqueue("cma_release");
>>
>> Considering the workqueue is used to free up memory it should likely be
>> WQ_MEM_RECLAIM to prevent from long stalls when WQs are overloaded.
>>
>> I cannot judge the CMA parts from a very quick glance this looks
>> reasonably.
> 
> I have overlooked that
> +static void cma_clear_bitmap_fn(struct work_struct *work)
> +{
> +       struct cma_clear_bitmap_work *w;
> +
> +       w = container_of(work, struct cma_clear_bitmap_work, work);
> +
> +       cma_clear_bitmap(w->cma, w->pfn, w->count);
> +
> +       __free_page(pfn_to_page(w->pfn));
> +}
> 
> should be doing free_contig_range with w->count target.
> 

Then the name "cma_clear_bitmap_fn" is misleading.

-- 
Thanks,

David / dhildenb

