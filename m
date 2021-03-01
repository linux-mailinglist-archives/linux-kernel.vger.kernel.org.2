Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE776327944
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 09:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhCAIbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 03:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233060AbhCAIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614587425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MitleQLlkGN1VE4ERP6Ypb/q7crtufZjduSINbkl1RE=;
        b=cakCdD6LbmAtUDJuwGPcdXEePqRzxBf/fdbTOuC5Q/CedTiMDm+uM6ZdzTaThlnpmBjILg
        IhGQ10Q2AFDlGg4O1HY/KdhRyW95V+iwNA3QNGsxSHQ04s1bFErDNTZO/H6q9N/2k/6LzK
        Zayv1s3QY7Ty4GaE+amUdj1IT7oE6SA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-miwzFtP-OLaGJJxaqYnNjQ-1; Mon, 01 Mar 2021 03:30:21 -0500
X-MC-Unique: miwzFtP-OLaGJJxaqYnNjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07421107ACE3;
        Mon,  1 Mar 2021 08:30:20 +0000 (UTC)
Received: from [10.36.114.87] (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 287205D9FC;
        Mon,  1 Mar 2021 08:30:17 +0000 (UTC)
Subject: Re: [PATCH v2 1/7] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-2-osalvador@suse.de>
 <60afb5ca-230e-265f-9579-dac66a152c33@redhat.com>
 <20210228185044.GA3929@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d02e77cf-fd23-2ccd-612e-b857a8140a1c@redhat.com>
Date:   Mon, 1 Mar 2021 09:30:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210228185044.GA3929@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
>>> +		pfn += 1 << pageblock_order;
>>
>> pfn += pageblock_nr_pages;
>>
>> Can you add a comment why we can be sure that we are off by  a single pageblock? What about s390x where a MAX_ORDER_NR_PAGES == 4 * pageblock_nr_pages?
>>
>> Would it make thing simpler to just do a
>>
>> while (!IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)) {
>> 	(*online_page_callback)(pfn_to_page(pfn), 0);
>> 	pfn++;
>> }
> 
> Honestly, I did not spend much time thinking on other platforms other
> than arm64/x86_64.
> But I think that that would be the universal solution as we do not make
> any assumptions.
> 
> I will replace it.

I think you could also go with

while (!IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)) {
     (*online_page_callback)(pfn_to_page(pfn), pageblock_order);
  	pageblock_nr_pages;
}

And maybe add a comment why we can be sure it has to be aligned to 
pageblocks. Or maybe rather add

VM_BUG_ON(IS_ALIGNED(pfn, pageblock_nr_pages));

-- 
Thanks,

David / dhildenb

