Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7A332D91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhCIRue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:50:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231245AbhCIRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615312230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wB5JlP23hp5tAup4AoVFCokVu35qaVntvZJ1seqr1d4=;
        b=fGLRW+t/WI1D0JIjwOuNknXVKEZ/nMLjFwOCLavZ+HnrPDRLPJbj6NZ9q3L2sdOl5WCo06
        FPW9e4/ie5B4fQRHnukGmhGMYm57+1zaWFopQz+B1lwXikoJbV6DL3k5MGqpbDE98zYZTF
        vNwvAqeMMXo8jlnr+4OYOW3FSsDL6ZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-VwQ_SSYQNLW_VT530u0oqg-1; Tue, 09 Mar 2021 12:50:28 -0500
X-MC-Unique: VwQ_SSYQNLW_VT530u0oqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76D091842149;
        Tue,  9 Mar 2021 17:50:26 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9560819C59;
        Tue,  9 Mar 2021 17:50:24 +0000 (UTC)
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
 <29cb78c5-4fca-0f0a-c603-0c75f9f50d05@redhat.com>
 <ebb19eb5-ae9e-22f1-4e19-e5fce32c695c@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
Message-ID: <6c66c265-c9b9-ffe9-f860-f96f3485477e@redhat.com>
Date:   Tue, 9 Mar 2021 18:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <ebb19eb5-ae9e-22f1-4e19-e5fce32c695c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.21 18:11, Mike Kravetz wrote:
> On 3/9/21 1:01 AM, David Hildenbrand wrote:
>> On 09.03.21 01:18, Mike Kravetz wrote:
>>> To address these issues, introduce the concept of hugetlb page demotion.
>>> Demotion provides a means of 'in place' splitting a hugetlb page to
>>> pages of a smaller size.  For example, on x86 one 1G page can be
>>> demoted to 512 2M pages.  Page demotion is controlled via sysfs files.
>>> - demote_size    Read only target page size for demotion
>>> - demote    Writable number of hugetlb pages to be demoted
>>>
>>> Only hugetlb pages which are free at the time of the request can be demoted.
>>> Demotion does not add to the complexity surplus pages.  Demotion also honors
>>> reserved huge pages.  Therefore, when a value is written to the sysfs demote
>>> file that value is only the maximum number of pages which will be demoted.
>>> It is possible fewer will actually be demoted.
>>>
>>> If demote_size is PAGESIZE, demote will simply free pages to the buddy
>>> allocator.
>>
>> With the vmemmap optimizations you will have to rework the vmemmap layout. How is that handled? Couldn't it happen that you are half-way through splitting a PUD into PMDs when you realize that you cannot allocate vmemmap pages for properly handling the remaining PMDs? What would happen then?
>>
>> Or are you planning on making both features mutually exclusive?
>>
>> Of course, one approach would be first completely restoring the vmemmap for the whole PUD (allocating more pages than necessary in the end) and then freeing individual pages again when optimizing the layout per PMD.
>>
> 
> You are right about the need to address this issue.  Patch 3 has the
> comment:
> 
> +	/*
> +	 * Note for future:
> +	 * When support for reducing vmemmap of huge pages is added, we
> +	 * will need to allocate vmemmap pages here and could fail.
> +	 */
> 

I only skimmed over the cover letter so far. :)

> The simplest approach would be to restore the entire vmemmmap for the
> larger page and then delete for smaller pages after the split.  We could
> hook into the existing vmemmmap reduction code with just a few calls.
> This would fail to demote/split, if the allocation fails.  However, this
> is not optimal.
> 
> Ideally, the code would compute how many pages for vmemmmap are needed
> after the split, allocate those and then construct vmmemmap
> appropriately when creating the smaller pages.
> 
> I think we would want to always do the allocation of vmmemmap pages up
> front and not even start the split process if the allocation fails.  No
> sense starting something we may not be able to finish.
> 

Makes sense.

Another case might also be interesting: Assume you allocated a gigantic 
page via CMA and denoted it to huge pages. Theoretically (after Oscar's 
series!), we could come back later and re-allocate a gigantic page via 
CMA, migrating all now-hugepages out of the CMA region. Would require 
telling CMA that that area is effectively no longer allocated via CMA 
(adjusting accounting, bitmaps, etc).

That would actually be a neat use case to form new gigantic pages later 
on when necessary :)

But I assume your primary use case is denoting gigantic pages allocated 
during boot, not via CMA.

Maybe you addresses that already as well :)

> I purposely did not address that here as first I wanted to get feedback
> on the usefulness demote functionality.
> 

Makes sense. I think there could be some value in having this 
functionality. Gigantic pages are rare and we might want to keep them as 
long as possible (and as long as we have sufficient free memory). But 
once we need huge pages (e.g., smaller VMs, different granularity 
requiremets), we could denote.

If we ever have pre-zeroing of huge/gigantic pages, your approach could 
also avoid having to zero huge pages again when the gigantic page was 
already zeroed.

-- 
Thanks,

David / dhildenb

