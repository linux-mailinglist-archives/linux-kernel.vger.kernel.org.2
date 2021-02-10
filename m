Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEA1316940
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhBJOiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:38:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhBJOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612967810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y0cOXkjjqhYfEYLaqUjm8JsPqdbJg8o77yvHL5dd1FI=;
        b=Y3say0TpC41qZp4QdNYGwLeJTHMOg5L3PSGvETdG8iP1A+cTYtfFxVbtp+P8PWjv9iusmp
        X+HH2b5mqOml7OXf3VNTGp6af4JL147fN7PHqsJrU6XPENDCIj+4yGMacr43pJ+BTp7gas
        s8y1/ZNzPfN0RTKeBrT4moB/AZvvfH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-n8rUQhb7MnOwA1wTH2RqWA-1; Wed, 10 Feb 2021 09:36:45 -0500
X-MC-Unique: n8rUQhb7MnOwA1wTH2RqWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C36780196E;
        Wed, 10 Feb 2021 14:36:44 +0000 (UTC)
Received: from [10.36.113.218] (ovpn-113-218.ams2.redhat.com [10.36.113.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6DE918AA1;
        Wed, 10 Feb 2021 14:36:42 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] mm,page_alloc: Make alloc_contig_range handle
 free hugetlb pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-3-osalvador@suse.de>
 <9ed946df-9c6c-9a4d-4be9-2f32809974f7@redhat.com>
 <20210210142424.GC3636@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6e999708-2edb-c25f-4aee-217d2f3cc037@redhat.com>
Date:   Wed, 10 Feb 2021 15:36:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210210142424.GC3636@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.02.21 15:24, Oscar Salvador wrote:
> On Wed, Feb 10, 2021 at 09:23:59AM +0100, David Hildenbrand wrote:
>> On 08.02.21 11:38, Oscar Salvador wrote:
>>> Free hugetlb pages are trickier to handle as to in order to guarantee
>>> no userspace appplication disruption, we need to replace the
>>> current free hugepage with a new one.
>>>
>>> In order to do that, a new function called alloc_and_dissolve_huge_page
>>> in introduced.
>>> This function will first try to get a new fresh hugetlb page, and if it
>>> succeeds, it will dissolve the old one.
>>>
>>
>> Thanks for looking into this! Can we move this patch to #1 in the series? It
>> is the easier case.
>>
>> I also wonder if we should at least try on the memory unplug path to keep
>> nr_pages by at least trying to allocate at new one if required, and printing
>> a warning if that fails (after all, we're messing with something configured
>> by the admin - "nr_pages"). Note that gigantic pages are special (below).
> 
> So, do you mean to allocate a new fresh hugepage in case we have a free
> hugetlb page within the range we are trying to offline? That makes some
> sense I guess.
> 
> I can have a look at that, and make hotplug code use the new
> alloc_and_dissolve().

Yes, with the difference that hotplug code most probably wants to 
continue even if allocation failed (printing a warning) - mimix existing 
behavior. For alloc_contig, I'd say, fail if we cannot "relocate free 
huge pages that are still required to no modify nr_pages".

alloc_and_dissolve() should only allocate a page if really required 
(e.g., not sure if we could skip allocation in some cases - like with 
surplus pages, needs some investigation), such that the admin-configured 
nr_pages stays unchanged.

-- 
Thanks,

David / dhildenb

