Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA69732D0E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhCDKeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:34:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238732AbhCDKeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614853958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiZqplkYFpKQpRJK+Go2qo6gqDSjfUsNUqyq5r5k7eU=;
        b=DoUkOCro1GON79/nrOEUyNQtX4hW6gduPUg4Xb7d9IQG8YI0RGW3SfQMcB5UK+l//2NCao
        I+EkFlNauPyj3004+RbC1yEAJ+Mg4NKrTByfsaowL7Z+/+hMPY+zE5tZnyczOQ10+U6tTm
        R9w9HkUcLMLRZWBka9bGz+jZ58czZlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-3w1_vlQjPe-i0U51OOeStA-1; Thu, 04 Mar 2021 05:32:34 -0500
X-MC-Unique: 3w1_vlQjPe-i0U51OOeStA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CA681005D4C;
        Thu,  4 Mar 2021 10:32:32 +0000 (UTC)
Received: from [10.36.113.171] (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACDA65C1C2;
        Thu,  4 Mar 2021 10:32:30 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-2-osalvador@suse.de>
 <3f071dd4-3181-f4e0-fd56-1a70f6ac72fe@redhat.com>
 <YEC0ODM5gtEU+JqN@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4ede47fd-d01e-6d9c-288a-2ec97b5392af@redhat.com>
Date:   Thu, 4 Mar 2021 11:32:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEC0ODM5gtEU+JqN@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think we should not swallo such return values in
>> isolate_or_dissolve_huge_page() and instead properly report esp. -ENOMEM
>> properly up this callchain now. Otherwise we'll end up retrying / reporting
>> -EBUSY, which is misleading.
> 
> I am not sure I follow you here.
> So, atm, alloc_and_dissolve_huge_page can either generate -ENOMEM or
> -EBUSY wrt. error codes.
> -ENOMEM when we cannot allocate a page, and -EBUSY when we raced with
> someone.
> You mean to only report ENOMEM down the chain?

Yes, fatal errors.

> 
>>  From isolate_migratepages_range()/isolate_migratepages_block() we'll keep
>> reporting "pfn > 0".
>>
>> a) In isolate_migratepages_range() we'll keep iterating over pageblocks
>> although we should just fail with -ENOMEM right away.
>>
>> b) In __alloc_contig_migrate_range() we'll keep retrying up to 5 times
>> although we should just fail with -ENOMEM. We end up returning "-EBUSY"
>> after retrying.
>>
>> c) In alloc_contig_range() we'll continue trying to isolate although we
>> should just return -ENOMEM.
> 
> Yes, "fatal" errors get masked, and hence we treat everything as "things
> are busy, let us try again", and this is rather unforunate.
> 
>> I think we have should start returning proper errors from
>> isolate_migratepages_range()/isolate_migratepages_block() on critical issues
>> (-EINTR, -ENOMEM) instead of going via "!pfn vs. pfn" and retrying on "pfn".
>>
>> So we should then fail with -ENOMEM during isolate_migratepages_range()
>> cleanly, just as we would do when we get -ENOMEM during migrate_pages().
> 
> I guess we could rework the interface and make isolate_migratepages_range and
> isolate_migratepages_block to report the right thing.
> I yet have to check that this does not mess up a lot with the compaction
> interface.
> 
> But overall I agree with your point here, and I am willing to to tackle
> this.
> 
> The question is whether we want to do this as part of this series, or
> after this series gets picked up.
> IMHO, we could do it after, as a follow-up, unless you feel strong about
> it.
> 
> What do you think?

I think this is now the second fatal error we can have (-EINTR, 
-ENOMEM), thus the current interface (return "NULL" on fatal errros) no 
longer works properly.

No strong opinion about fixing this up on top - could be it's cleaner to 
just do it right away.

-- 
Thanks,

David / dhildenb

