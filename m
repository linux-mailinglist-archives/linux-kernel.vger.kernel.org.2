Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC4408AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbhIMMVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237538AbhIMMVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631535630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dc6ekLOLHMsMtYs2HMXfatsRC2o+NJYfkVB406jRynY=;
        b=C8nlkjVV0ZodijDwrH9cO7pQ90ZqJZk7gXn3GLyHmO/0r2uBQR8MGA5cFqwb9vTbCGWETd
        Ce8ni/TlSeJpLnxZgLCe7J/eSY1LzQW1qXGjOtHSqLIP1sbcDiL0NYgDYgWv7R903GyRRd
        l2WA0cgNSXkiH11SH74DyANVAPIk4z8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-yr3hVtgDPy2Bemh351gH3A-1; Mon, 13 Sep 2021 08:20:28 -0400
X-MC-Unique: yr3hVtgDPy2Bemh351gH3A-1
Received: by mail-wr1-f70.google.com with SMTP id d10-20020adffbca000000b00157bc86d94eso2592691wrs.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 05:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dc6ekLOLHMsMtYs2HMXfatsRC2o+NJYfkVB406jRynY=;
        b=5WaAeVN0Wq3ndbNJVOkEjJnrYcgQsJsk8EmsHswyqr9I2u5fxxXY+Lw4iqZi/YrDD9
         ksrTUmI9dAiuXHMyig6TaL8gaWrMrdIV8md3BwScDJ/caU6rgMu0Eno5vk86hbm09e/X
         pU7IbcTt2H35Cuz/xD15yfiQUvZKwt3l/M3/NksvnCtMdscFPT1tEQ+MQWQJlxmcX/ee
         L1vgS6M4U45N7jmH3VC+wS3snzzH5xPi7TNy1RlYl2aYo58M6cEiPg4cDIZRp6CAWf/4
         b1iArIPR1+pkPpSv4+U4DmgtC7cn/dszlWU2b+ZwxGd/I4fucWK4/taUa9aQZXJ6o25A
         qBWg==
X-Gm-Message-State: AOAM531JAlB5qGfNFrQtkBq4cNRO4gVxIkLcPwB7qu4Ze0jLE8qALdHz
        ZY0fdtn0b6XYDccLACk3wKuTCar56eF1reR7345FxGCd4f8CyH6UdkVsqJWEJMCijM2tduivRJ/
        Phpr3DHeAUYzWF3ir8WZYi0APZc5y7EjvJ/73Faeq5I2SAdFqZNVJMILQ7lrP4Dt5UXLG1Bgw
X-Received: by 2002:adf:80eb:: with SMTP id 98mr12140649wrl.348.1631535627797;
        Mon, 13 Sep 2021 05:20:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqACPVeVpqdGbdZKyYWRSwo6XFlp8j0+JXG9OX6JdRQ4wyJBLWvBTheHOQ1up66bOZp7bZ0g==
X-Received: by 2002:adf:80eb:: with SMTP id 98mr12140621wrl.348.1631535627518;
        Mon, 13 Sep 2021 05:20:27 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6576.dip0.t-ipconnect.de. [91.12.101.118])
        by smtp.gmail.com with ESMTPSA id i18sm3635059wrn.64.2021.09.13.05.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 05:20:27 -0700 (PDT)
Subject: Re: [PATCH v2] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
To:     Michal Hocko <mhocko@suse.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210913115125.33617-1-linmiaohe@huawei.com>
 <YT9AS6I1Th14mCxh@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e1e772b8-b9a7-0182-c469-73f32cda005e@redhat.com>
Date:   Mon, 13 Sep 2021 14:20:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YT9AS6I1Th14mCxh@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.21 14:12, Michal Hocko wrote:
> On Mon 13-09-21 19:51:25, Miaohe Lin wrote:
>> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
>> the first pfn in a pageblock while __first_valid_page() will traverse the
>> pageblock until the first online pfn is found. So we may miss the call to
>> unset_migratetype_isolate() in undo path and pages will remain isolated
>> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
>> also help to simplify the code further.
> 
> I like the clean up part but is this a real problem that requires CC
> stable? Have you ever seen this to be a real problem? It looks like
> something based on reading the code.

We discussed that it isn't an issue anymore (we never call it on memory 
holes), but might have been an issue on older kernels, back when we 
didn't have the "memory holes" check in the memory offlining path in place.

Agreed, these details belong into this description.

> 
>> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>> v1->v2:
>>    Simplify the code further per David Hildenbrand.
>> ---
>>   mm/page_isolation.c | 20 +++-----------------
>>   1 file changed, 3 insertions(+), 17 deletions(-)
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index a95c2c6562d0..f93cc63d8fa1 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -183,7 +183,6 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>   			     unsigned migratetype, int flags)
>>   {
>>   	unsigned long pfn;
>> -	unsigned long undo_pfn;
>>   	struct page *page;
>>   
>>   	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>> @@ -193,25 +192,12 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>   	     pfn < end_pfn;
>>   	     pfn += pageblock_nr_pages) {
>>   		page = __first_valid_page(pfn, pageblock_nr_pages);
>> -		if (page) {
>> -			if (set_migratetype_isolate(page, migratetype, flags)) {
>> -				undo_pfn = pfn;
>> -				goto undo;
>> -			}
>> +		if (page && set_migratetype_isolate(page, migratetype, flags)) {
>> +			undo_isolate_page_range(start_pfn, pfn, migratetype);
>> +			return -EBUSY;
>>   		}
>>   	}
>>   	return 0;
>> -undo:
>> -	for (pfn = start_pfn;
>> -	     pfn < undo_pfn;
>> -	     pfn += pageblock_nr_pages) {
>> -		struct page *page = pfn_to_online_page(pfn);
>> -		if (!page)
>> -			continue;
>> -		unset_migratetype_isolate(page, migratetype);
>> -	}
>> -
>> -	return -EBUSY;
>>   }
>>   
>>   /*
>> -- 
>> 2.23.0
> 


-- 
Thanks,

David / dhildenb

