Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0433ED65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhCQJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbhCQJsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615974518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cy/a1Z/HUF5zY1QTMNBd7dixVMe1UxNpkW4BGe5sLnY=;
        b=bY9lTsaFf0lRBs1jV5dBUnbtFQQ7IlGph5UyzWywWy4A0unkV+UVkWA/cWSHTX48qLqqOf
        yQsf/uTHisiUV+fFSMPA24sHPK9WxN+OQ0sgXH+wks6coaSOonzw7aEouKjOns/Y7I1NwF
        bVeW1XjjTKo39GOzZWsAjpln9lc6y1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-o_sZjHjVPY2itaVRMayfqg-1; Wed, 17 Mar 2021 05:48:37 -0400
X-MC-Unique: o_sZjHjVPY2itaVRMayfqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 627FC1922023;
        Wed, 17 Mar 2021 09:48:35 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F472690F6;
        Wed, 17 Mar 2021 09:48:32 +0000 (UTC)
Subject: Re: [PATCH v4 0/4] Make alloc_contig_range handle Hugetlb pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210310150853.13541-1-osalvador@suse.de>
 <c7ba5bba-77fb-6c43-2067-2ebc83b014da@redhat.com>
 <b04aaf5534f9ec0a40937e23a2500fdf@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <01d2ee6a-f0aa-4580-b1f4-f0e8a2ded4f8@redhat.com>
Date:   Wed, 17 Mar 2021 10:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b04aaf5534f9ec0a40937e23a2500fdf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.21 10:43, Oscar Salvador wrote:
> On 2021-03-15 10:06, David Hildenbrand wrote:
>> BTW, I stumbled yesterday over
>>
>> alloc_contig_pages()->pfn_range_valid_contig():
>>
>> 	if (page_count(page) > 0)
>> 		rerurn false;
>> 	if (PageHuge(page))
>> 		return false;
>>
>> As used by memtrace and for gigantic pages. We can now
>>
>> a) Drop these check completely, as it's best-effort only and racy.
>> alloc_contig_pages()/alloc_contig_range() will handle it properly.
> 
> I was preparing v5, and I wanted to be sure I understood you here.
> 
> Right you are that the in-use page check can be dropped, as those pages
> can
> be migrated away, and the Hugetlb page check can also be dropped since
> isolate_migratepages_range is now capable of dealing with those kind of
> pages.
> 
>> b) Similarly, check for gigantic pages and/or movability/migratability.
> 
> I lost you here.
> 
> isolate_or_dissolve_huge_page() already bails out on hugetlb-gigantic
> pages.
> 
> Or do you mean to place an upfront check here? (hstate_is_gigantic())?

Yes. But I prefer a) and keeping it simple here -- just doing basic 
sanity checks (online, zone, PageReserved()) that are absolutely necessary.



-- 
Thanks,

David / dhildenb

