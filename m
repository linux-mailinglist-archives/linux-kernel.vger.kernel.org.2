Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7328349768
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhCYQ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229616AbhCYQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616691373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=neGbMl2kB4czwu8peBWskWjqlwN2vGnWSvoSCfmqyAw=;
        b=OQxc8qLCZKpQ0l9wbPUlbgpsxOVOIVAvTDneiIJfWLKheMFTaShJS5yqXFf5yOWL57MikJ
        7uI/fEqwVIGML/Wz1VIV/4MNp05SBMcl5gSkEPQdFR3PPdlTVwDkiloNovvPNd1aiZ4h9r
        FBnJgYOdxAn31reQj8NKPPkZJ6YcfJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-i3VhdmjGPR2Kwv6GiGL6Rg-1; Thu, 25 Mar 2021 12:56:11 -0400
X-MC-Unique: i3VhdmjGPR2Kwv6GiGL6Rg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9822F881278;
        Thu, 25 Mar 2021 16:55:40 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 862AA5D736;
        Thu, 25 Mar 2021 16:55:38 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
 <062bc5d7-a83c-1c1a-7b77-9f043643f4fa@redhat.com>
 <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
 <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz> <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz> <YFy+olsdS4iwrovN@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <17e666ec-93ae-c0f3-47cf-67e8a6df6afc@redhat.com>
Date:   Thu, 25 Mar 2021 17:55:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFy+olsdS4iwrovN@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 17:47, Michal Hocko wrote:
> On Thu 25-03-21 17:36:22, Michal Hocko wrote:
>> If all it takes is to make pfn_to_online_page work (and my
>> previous attempt is incorrect because it should consult block rather
>> than section pfn range)
> 
> This should work.
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 9697acfe96eb..e50d685be8ab 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -510,6 +510,23 @@ static struct memory_block *find_memory_block_by_id(unsigned long block_id)
>   	return mem;
>   }
>   
> +struct page *is_vmemmap_page(unsigned long pfn)
> +{
> +	unsigned long nr = pfn_to_section_nr(pfn);
> +	struct memory_block *mem;
> +	unsigned long block_pfn;
> +
> +	mem = find_memory_block_by_id(memory_block_id(nr));
> +	if (!mem || !mem->nr_vmemmap_pages)
> +		return NULL;
> +
> +	block_pfn = section_nr_to_pfn(mem->start_section_nr);
> +	if (pfn - block_pfn > mem->nr_vmemmap_pages)
> +		return NULL;
> +
> +	return pfn_to_page(pfn);
> +}
> +
>   /*
>    * Called under device_hotplug_lock.
>    */
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 754026a9164d..760bf3ad48d5 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -304,8 +304,16 @@ struct page *pfn_to_online_page(unsigned long pfn)
>   		return NULL;
>   
>   	ms = __nr_to_section(nr);
> -	if (!online_section(ms))
> +	if (!online_section(ms)) {
> +		/*
> +		 * vmemmap reserved space can eat up a whole section which then
> +		 * never gets onlined because it doesn't contain any memory to
> +		 * online.
> +		 */
> +		if (memmap_on_memory)
> +			return is_vmemmap_page(pfn);
>   		return NULL;
> +	}
>   
>   	/*
>   	 * Save some code text when online_section() +
> 

It should take care of discussed zone shrinking as well, at least as 
long as the granularity is not smaller than sub-sections.

-- 
Thanks,

David / dhildenb

