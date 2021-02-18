Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7331EF02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhBRSw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:52:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234036AbhBRQzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613667208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YtvcWwzeSACTJqsYxD6kx8htzZr8ZHgABHYpks1GT1A=;
        b=ZKPmO0JBqNaOTm94M8vxAf2P2kes4EooGbl1K8tNt9KotJ1Ba0YGasgPiidx6v9ID7/64G
        HmDXBo0AXchdrJvRTxiVHqKA8IcCG5XgZj+Bb3d+GEnd1vSU3K0hxVsnLSfGxx+GSuoKHq
        Cx3hWzROZe6nLvSRjV/+CaaeuvzxYNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-tyElYNPvMQ23DwZnrgx_1Q-1; Thu, 18 Feb 2021 11:53:26 -0500
X-MC-Unique: tyElYNPvMQ23DwZnrgx_1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86034107ACC7;
        Thu, 18 Feb 2021 16:53:25 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C65B5D9C6;
        Thu, 18 Feb 2021 16:53:23 +0000 (UTC)
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
 <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
 <YC6TpqT26dSy11fU@google.com>
 <dc534e7b-3992-eb37-8399-67258ff03067@redhat.com>
 <YC6aIL67PaYlmeYq@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <694c1d6a-d3bc-71ec-7730-e83714e85c25@redhat.com>
Date:   Thu, 18 Feb 2021 17:53:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC6aIL67PaYlmeYq@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.02.21 17:47, Minchan Kim wrote:
> On Thu, Feb 18, 2021 at 05:26:08PM +0100, David Hildenbrand wrote:
>> On 18.02.21 17:19, Minchan Kim wrote:
>>> On Thu, Feb 18, 2021 at 10:43:21AM +0100, David Hildenbrand wrote:
>>>> On 18.02.21 10:35, Michal Hocko wrote:
>>>>> On Thu 18-02-21 10:02:43, David Hildenbrand wrote:
>>>>>> On 18.02.21 09:56, Michal Hocko wrote:
>>>>>>> On Wed 17-02-21 08:36:03, Minchan Kim wrote:
>>>>>>>> alloc_contig_range is usually used on cma area or movable zone.
>>>>>>>> It's critical if the page migration fails on those areas so
>>>>>>>> dump more debugging message like memory_hotplug unless user
>>>>>>>> specifiy __GFP_NOWARN.
>>>>>>>
>>>>>>> I agree with David that this has a potential to generate a lot of output
>>>>>>> and it is not really clear whether it is worth it. Page isolation code
>>>>>>> already has REPORT_FAILURE mode which currently used only for the memory
>>>>>>> hotplug because this was just too noisy from the CMA path - d381c54760dc
>>>>>>> ("mm: only report isolation failures when offlining memory").
>>>>>>>
>>>>>>> Maybe migration failures are less likely to fail but still.
>>>>>>
>>>>>> Side note: I really dislike that uncontrolled error reporting on memory
>>>>>> offlining path we have enabled as default. Yeah, it might be useful for
>>>>>> ZONE_MOVABLE in some cases, but otherwise it's just noise.
>>>>>>
>>>>>> Just do a "sudo stress-ng --memhotplug 1" and see the log getting flooded
>>>>>
>>>>> Anyway we can discuss this in a separate thread but I think this is not
>>>>> a representative workload.
>>>>
>>>> Sure, but the essence is "this is noise", and we'll have more noise on
>>>> alloc_contig_range() as we see these calls more frequently. There should be
>>>> an explicit way to enable such *debug* messages.
>>>
>>> alloc_contig_range already has gfp_mask and it respects __GFP_NOWARN.
>>
>> I am not 100% sure it does.
> 
> Oh, it should. Otherwise, let's fix either of caller or
> alloc_contig_range since we have a customer.
> 
> ```
>      ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
>              GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0))
> ```
> 

Oh, interesting. So I certainly want to add that for virtio-mem as well 
- thanks.

And discussed, we should hide the one pr_info... in alloc_contig_range() 
as well.

>>
>>> Why shouldn't people use it if they don't care the failure?
>>
>> Because flooding the log with noise maybe a handful of people on this planet
>> care about is absolutely useless. With the warnings in warn_alloc() people
>> can at least conclude something reasonable.
>>
>>> Semantically, it makes sense to me.
>>>
>>> About the messeage flooding, shouldn't we go with ratelimiting?
>>
>> At least that (see warn_alloc()). But I'd even want to see some other
>> trigger to enable this explicitly on demand.
> 
> No objection.
> 
> How about adding verbose knob under CONFIG_CMA_DEBUGFS with
> alloc_contig_range(..., bool verbose) like start_isolate_page_range?
> 
> If admin turns on the verbose mode under CONFIG_CMA_DEBUGFS,
> cma_alloc will pass alloc_contig_range(...., true).

I'd handle this internally in alloc_contig_range and not pass magic 
flags around. Some kind of debug knob to enable advanced messages 
(exceeding the usual allocation warnings we would usually see).

-- 
Thanks,

David / dhildenb

