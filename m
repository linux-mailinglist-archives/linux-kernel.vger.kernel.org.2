Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1558327C11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhCAK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:27:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234260AbhCAK0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614594304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2PXXweWR2zP2U++UYNUd6iWZNSXgVsvVpfrP7iK9ick=;
        b=Rxkp9/LnsNUhkl3j02/Uo77ONfOV54q/WhCEVu0A6jfm8G5XdD+fTQh/g+mzu4DuKWANZa
        2GpKYSksLTGOEqy8FfoFnoLWZ3AwwqSrRA+rVYIgZV/4+WM/QM2ckQR9kj+zIHcQn6lO5y
        G8rsr+K7/Jp6g9J979Ga4n/7dFr3Wlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-YwhrSmb3N6CF1kSQC78Hgg-1; Mon, 01 Mar 2021 05:25:01 -0500
X-MC-Unique: YwhrSmb3N6CF1kSQC78Hgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13F9E107ACC7;
        Mon,  1 Mar 2021 10:25:00 +0000 (UTC)
Received: from [10.36.114.87] (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4698E6EF40;
        Mon,  1 Mar 2021 10:24:57 +0000 (UTC)
Subject: Re: [PATCH v2 4/7] mm,memory_hotplug: Enforce struct page size to be
 multiple of PMD
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-5-osalvador@suse.de>
 <13253f19-d0e9-e27c-046a-c2669c5ee33d@redhat.com>
 <20210301100640.GA32425@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2ba12dc6-bd3b-4d23-4288-13447bb1225d@redhat.com>
Date:   Mon, 1 Mar 2021 11:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301100640.GA32425@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.21 11:06, Oscar Salvador wrote:
> On Thu, Feb 25, 2021 at 07:26:50PM +0100, David Hildenbrand wrote:
>> On 09.02.21 14:38, Oscar Salvador wrote:
>>> When struct page's size is not multiple of PMD, these do not get
>>> fully populated when adding sections, hence two sections will
>>> intersect the same the PMD. This goes against the vmemmap-per-device
>>> premise, so reject it if that is the case.
>>>
>>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>>> ---
>>>    mm/memory_hotplug.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 95695483a622..d3fb036d33fd 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -57,10 +57,11 @@ static __meminit int memmap_on_memory_store(const char *val,
>>>    					    const struct kernel_param *kp)
>>>    {
>>>    	/*
>>> -	 * Fail silently in case we cannot enable it due to platform constraints.
>>> +	 * Fail silently in case we cannot enable it due to system constraints.
>>>    	 * User can always check whether it is enabled or not via /sys/module.
>>>    	 */
>>> -	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE))
>>> +	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE) ||
>>> +	    (PMD_SIZE % sizeof(struct page)))
>>>    		return 0;
>>>    	return param_set_bool(val, kp);
>>>
>>
>> Squash that into #1 - it's part of basic operation.
> 
> Just to be sure we are on the same page.
> You mean to move this patch and patch#5 into the runtime check in
> mhp_supports_memmap_on_memory(), right?

Yes, then the compiler might even be able to figure out that what 
follows the check is dead code.

-- 
Thanks,

David / dhildenb

