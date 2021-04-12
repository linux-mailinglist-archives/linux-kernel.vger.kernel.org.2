Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93D035BE90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbhDLI7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238097AbhDLIrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618217249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZVzewdg79RzKFsnnpj3toO21U2g5cN2oMm8eONJYHY=;
        b=J8rsO5dXvzCFlWjwK5h0bjoSsjLBgovY9Oeb191zVNoScFbR0elUw2vPuawKm9yHrb7ODT
        qKIs7Lu7//7FfQSuLZc7LSGxcO1n2lfDeY+TjSgVTxceLAAqAxqOSZGtvSCRBPr5lLrisW
        63vAitL7U+8fQ7t2pTwOMIjWGAcAIwM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-3IC6GzGoP_aXuKCuUJ_RAA-1; Mon, 12 Apr 2021 04:47:28 -0400
X-MC-Unique: 3IC6GzGoP_aXuKCuUJ_RAA-1
Received: by mail-wr1-f71.google.com with SMTP id z6so5709948wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+ZVzewdg79RzKFsnnpj3toO21U2g5cN2oMm8eONJYHY=;
        b=UFf+sThDmmHtQW+V0DqP6mE29kMIIDhSCWmywJEezi999bqdKQRtduEuRi6f82jogb
         RnKyZhhmq5CdRIg8IsK3Kkuw+GsGqHQ0CGc16EmrTNYbGPLOPcA6QGIN7ttdYcBNzOKc
         vsPgFEZ8kL4pm9fH8zlaNtR8/Wp7Agii6wQmAuPBw0CTXvdPZLuymNphviaLsoJAX4fy
         bhTyqFnYr6dsQO8QGS8I04yWYetFji1C6O2SazlYAtNVq220Hbkn4waLjo4isiQmf1t0
         A5ThEbfOErz650ztecGEOM94Xp0bSZ2RbKYVBUpc+knFTDnw4jLU8h1EaY2/rgDuZpQo
         Os+Q==
X-Gm-Message-State: AOAM53376Qyt2H4ISEjJoRX3f+WFHwb9XtZCM8Il7jEeCyzi3zDbr6x3
        lGr1Bj9nOzxD7CvS+T7EsY57I8qpk/c13m9QtAv5ykKM0k3pyGDbhi2dApDTUAgI9VAgh/dJ7qC
        S4Kv66Pg/7+JRImVcCz9sEpmb
X-Received: by 2002:a05:600c:4482:: with SMTP id e2mr619414wmo.121.1618217247180;
        Mon, 12 Apr 2021 01:47:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxx4EM0F3QJf++u7/wgOu5mPjOoaJFUsv/zcyrlmWMxAjz9nri7Al51/O7Rz2gFFz2XuY2fYQ==
X-Received: by 2002:a05:600c:4482:: with SMTP id e2mr619402wmo.121.1618217246983;
        Mon, 12 Apr 2021 01:47:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66cb.dip0.t-ipconnect.de. [91.12.102.203])
        by smtp.gmail.com with ESMTPSA id g5sm15937930wrq.30.2021.04.12.01.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 01:47:26 -0700 (PDT)
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "linuxppc-dev @ lists . ozlabs . org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <1618199302-29335-1-git-send-email-anshuman.khandual@arm.com>
 <09284b9a-cfe1-fc49-e1f6-3cf0c1b74c76@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH V2] mm/page_alloc: Ensure that HUGETLB_PAGE_ORDER is less
 than MAX_ORDER
Message-ID: <162877dd-e6ba-d465-d301-2956bb034429@redhat.com>
Date:   Mon, 12 Apr 2021 10:47:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <09284b9a-cfe1-fc49-e1f6-3cf0c1b74c76@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.21 10:06, Anshuman Khandual wrote:
> + linuxppc-dev@lists.ozlabs.org
> + linux-ia64@vger.kernel.org
> 
> On 4/12/21 9:18 AM, Anshuman Khandual wrote:
>> pageblock_order must always be less than MAX_ORDER, otherwise it might lead
>> to an warning during boot. A similar problem got fixed on arm64 platform
>> with the commit 79cc2ed5a716 ("arm64/mm: Drop THP conditionality from
>> FORCE_MAX_ZONEORDER"). Assert the above condition before HUGETLB_PAGE_ORDER
>> gets assigned as pageblock_order. This will help detect the problem earlier
>> on platforms where HUGETLB_PAGE_SIZE_VARIABLE is enabled.
>>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V2:
>>
>> - Changed WARN_ON() to BUILD_BUG_ON() per David
>>
>> Changes in V1:
>>
>> https://patchwork.kernel.org/project/linux-mm/patch/1617947717-2424-1-git-send-email-anshuman.khandual@arm.com/
>>
>>   mm/page_alloc.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cfc72873961d..19283bff4bec 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6875,10 +6875,17 @@ void __init set_pageblock_order(void)
>>   	if (pageblock_order)
>>   		return;
>>   
>> -	if (HPAGE_SHIFT > PAGE_SHIFT)
>> +	if (HPAGE_SHIFT > PAGE_SHIFT) {
>> +		/*
>> +		 * pageblock_order must always be less than
>> +		 * MAX_ORDER. So does HUGETLB_PAGE_ORDER if
>> +		 * that is being assigned here.
>> +		 */
>> +		BUILD_BUG_ON(HUGETLB_PAGE_ORDER >= MAX_ORDER);
> 
> Unfortunately the build test fails on both the platforms (powerpc and ia64)
> which subscribe HUGETLB_PAGE_SIZE_VARIABLE and where this check would make
> sense. I some how overlooked the cross compile build failure that actually
> detected this problem.
> 
> But wondering why this assert is not holding true ? and how these platforms
> do not see the warning during boot (or do they ?) at mm/vmscan.c:1092 like
> arm64 did.
> 
> static int __fragmentation_index(unsigned int order, struct contig_page_info *info)
> {
>          unsigned long requested = 1UL << order;
> 
>          if (WARN_ON_ONCE(order >= MAX_ORDER))
>                  return 0;
> ....
> 
> Can pageblock_order really exceed MAX_ORDER - 1 ?

Ehm, for now I was under the impression that such configurations 
wouldn't exist.

And originally, HUGETLB_PAGE_SIZE_VARIABLE was introduced to handle 
hugepage sizes that all *smaller* than MAX_ORDER - 1: See d9c234005227 
("Do not depend on MAX_ORDER when grouping pages by mobility")


However, looking into init_cma_reserved_pageblock():

	if (pageblock_order >= MAX_ORDER) {
		i = pageblock_nr_pages;
		...
	}


But it's kind of weird, isn't it? Let's assume we have MAX_ORDER - 1 
correspond to 4 MiB and pageblock_order correspond to 8 MiB.

Sure, we'd be grouping pages in 8 MiB chunks, however, we cannot even 
allocate 8 MiB chunks via the buddy. So only alloc_contig_range() could 
really grab them (IOW: gigantic pages).

Further, we have code like deferred_free_range(), where we end up 
calling __free_pages_core()->...->__free_one_page() with 
pageblock_order. Wouldn't we end up setting the buddy order to something 
 > MAX_ORDER -1 on that path?

Having pageblock_order > MAX_ORDER feels wrong and looks shaky.

-- 
Thanks,

David / dhildenb

