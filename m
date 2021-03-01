Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C54327ECB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhCANBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235291AbhCANBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614603572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyWLJ3REqh4Uy8iT9y3h51kR3aJXHhlPRMyzcTUdbHE=;
        b=U7RtlYCTN44beqCDeYecPtRMEoH+9GbvcMUsG/thmbuSDsGLz778n1xHzdYjQbyq8mEM2T
        4wQ1BypEj9WoMleCOuhTFQowSzoI/YExAJ0GvvhHkew2cS+Lxty/F2IRIsTDq+c/Hpo/s3
        uURKQ5VWRthDp4F096nt2kOsTbB5ED8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-69D36K4mNXqOkiNOb9bFAQ-1; Mon, 01 Mar 2021 07:59:28 -0500
X-MC-Unique: 69D36K4mNXqOkiNOb9bFAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09FD610066F9;
        Mon,  1 Mar 2021 12:59:27 +0000 (UTC)
Received: from [10.36.114.87] (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E8CF5C1C4;
        Mon,  1 Mar 2021 12:59:24 +0000 (UTC)
Subject: Re: [PATCH v3 0/2] Make alloc_contig_range handle Hugetlb pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210222135137.25717-1-osalvador@suse.de>
 <ff780dd6-f473-5476-fc1c-9f9bbcdb17c8@redhat.com>
 <20210301125754.GA4003@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8c230cb6-9c29-eaec-c548-46199611b1e6@redhat.com>
Date:   Mon, 1 Mar 2021 13:59:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301125754.GA4003@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.21 13:57, Oscar Salvador wrote:
> On Mon, Mar 01, 2021 at 01:43:00PM +0100, David Hildenbrand wrote:
>> Same experiment with ZONE_MOVABLE:
>>
>> a) Free huge pages: all memory can get unplugged again.
>>
>> b) Allocated/populated but idle huge pages: all memory can get unplugged
>> again.
>>
>> c) Allocated/populated but all 512 huge pages are read/written in a loop:
>> all memory can get unplugged again, but I get a single
>>
>> [  121.192345] alloc_contig_range: [180000, 188000) PFNs busy
>>
>> Most probably because it happened to try migrating a huge page while it was
>> busy. As virtio-mem retries on ZONE_MOVABLE a couple of times, it can deal
>> with this temporary failure.
>>
>>
>>
>> Last but not least, I did something extreme:
>>
>> ]# cat /proc/meminfo
>> MemTotal:        5061568 kB
>> MemFree:          186560 kB
>> MemAvailable:     354524 kB
>> ...
>> HugePages_Total:    2048
>> HugePages_Free:     2048
>> HugePages_Rsvd:        0
>> HugePages_Surp:        0
>>
>>
>> Triggering unplug would require to dissolve+alloc - which now fails when
>> trying to allocate an additional ~512 huge pages (1G).
>>
>>
>> As expected, I can properly see memory unplug not fully succeeding. + I get
>> a fairly continuous stream of
>>
>> [  226.611584] alloc_contig_range: [19f400, 19f800) PFNs busy
>> ...
>>
>> But more importantly, the hugepage count remains stable, as configured by
>> the admin (me):
>>
>> HugePages_Total:    2048
>> HugePages_Free:     2048
>> HugePages_Rsvd:        0
>> HugePages_Surp:        0
> 
> Thanks for giving it a spin David, that is highly appreciated ;-)!
> 
> I will add above information in next's version changelog if you do not mind,
> so the before-and-after can be seen clearly.
> 
> I shall send v4 in the course of the next few days.
> 

I'll have some review feedback on error handling that might be improved, 
I'll share that shortly.

-- 
Thanks,

David / dhildenb

