Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C508631887D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhBKKpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:45:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230346AbhBKKlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613040021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oLC7a4i0K7MCY0/uq/IzIb60MqNgbIOajiBNYOXcbB4=;
        b=Z+oR/DhxEET4AxuPd3uwDViVXYXqBMy4s6psAOM1Abi1CumAQjqjW1gogYMwQnkJwYYug6
        4P+l1uF3ndxfrn/nQZO1mfLeMFgNu/oHIRYM0wyfJOFKc+lf3OpD29UC2ev6S4aMVb34AU
        8Xt2CxvEww+rdPjL8j7LOdht7DL9KrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-Gj-iRevKOk-_LL1hW5n8tg-1; Thu, 11 Feb 2021 05:40:16 -0500
X-MC-Unique: Gj-iRevKOk-_LL1hW5n8tg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ADAA100CCC0;
        Thu, 11 Feb 2021 10:40:15 +0000 (UTC)
Received: from [10.36.114.52] (ovpn-114-52.ams2.redhat.com [10.36.114.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 239E710016F7;
        Thu, 11 Feb 2021 10:40:13 +0000 (UTC)
Subject: Re: [RFC PATCH 1/2] mm,page_alloc: Make alloc_contig_range handle
 in-use hugetlb pages
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-2-osalvador@suse.de>
 <6783e871-e981-c845-16c3-c5ff3e6502ed@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <007046e9-4655-42d1-0422-6a210f726eff@redhat.com>
Date:   Thu, 11 Feb 2021 11:40:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <6783e871-e981-c845-16c3-c5ff3e6502ed@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.21 01:56, Mike Kravetz wrote:
> On 2/8/21 2:38 AM, Oscar Salvador wrote:
>> alloc_contig_range is not prepared to handle hugetlb pages and will
>> fail if it ever sees one, but since they can be migrated as any other
>> page (LRU and Movable), it makes sense to also handle them.
>>
>> For now, do it only when coming from alloc_contig_range.
>>
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>> ---
>>   mm/compaction.c | 17 +++++++++++++++++
>>   mm/vmscan.c     |  5 +++--
>>   2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index e5acb9714436..89cd2e60da29 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -940,6 +940,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   			goto isolate_fail;
>>   		}
>>   
>> +		/*
>> +		 * Handle hugetlb pages only when coming from alloc_contig
>> +		 */
>> +		if (PageHuge(page) && cc->alloc_contig) {
>> +			if (page_count(page)) {
> 
> Thanks for doing this!
> 
> I agree with everything in the discussion you and David had.  This code
> is racy, but since we are scanning lockless there is no way to eliminate
> them all.  Best to just minimize the windows and document.
>

Agreed - and make sure that we don't have strange side. (e.g., in the 
next patch, allocate a new page, try to dissolve. Dissolving fails, what 
happens to the just-allocated page?)

-- 
Thanks,

David / dhildenb

