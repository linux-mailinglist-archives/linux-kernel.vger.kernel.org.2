Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA703355810
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbhDFPfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345773AbhDFPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617723186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGxL8zigLDTIsv+13RyGOm4L5FHwAQFecgNMTrGBUxg=;
        b=Yo20jjwChsJWxkIbllUQPxtapFXaBEXY4RH8d+8bi1gfe5jo1Stm8w44ODHJuFm2j8+h1s
        MEvN/RCGbZGSDbZfSqw/Bz1RoX7FxWGkDWO3PLMYf6eZueUvBvfK+jzyik6FFM3pEL3lHX
        fBWRh/EaNYbRNokrNj2fSqTCMeQCp+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-e8XWgyLsMBahwui4ZHPonQ-1; Tue, 06 Apr 2021 11:33:02 -0400
X-MC-Unique: e8XWgyLsMBahwui4ZHPonQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D40EE63CDF;
        Tue,  6 Apr 2021 15:32:46 +0000 (UTC)
Received: from [10.36.113.79] (ovpn-113-79.ams2.redhat.com [10.36.113.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 830C110016FC;
        Tue,  6 Apr 2021 15:32:44 +0000 (UTC)
Subject: Re: [PATCH v6 2/8] mm,memory_hotplug: Relax fully spanned sections
 check
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210406111115.8953-1-osalvador@suse.de>
 <20210406111115.8953-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b915143d-a8df-ddfc-94a8-7578fdd5f7bc@redhat.com>
Date:   Tue, 6 Apr 2021 17:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210406111115.8953-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.21 13:11, Oscar Salvador wrote:
> When using self-hosted vmemmap pages, the number of pages passed to
> {online,offline}_pages might not fully span sections, but they always
> fully span pageblocks.
> Relax the check account for that case.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/memory_hotplug.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0cdbbfbc5757..5fe3e3942b19 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -838,9 +838,13 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>   	int ret;
>   	struct memory_notify arg;
>   
> -	/* We can only online full sections (e.g., SECTION_IS_ONLINE) */
> +	/* We can only offline full sections (e.g., SECTION_IS_ONLINE).
> +	 * However, when using e.g: memmap_on_memory, some pages are initialized
> +	 * prior to calling in here. The remaining amount of pages must be
> +	 * pageblock aligned.
> +	 */
>   	if (WARN_ON_ONCE(!nr_pages ||
> -			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
> +			 !IS_ALIGNED(pfn | nr_pages, pageblock_nr_pages)))
>   		return -EINVAL;
>   
>   	mem_hotplug_begin();
> @@ -1573,9 +1577,13 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   	int ret, node;
>   	char *reason;
>   
> -	/* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
> +	/* We can only offline full sections (e.g., SECTION_IS_ONLINE).
> +	 * However, when using e.g: memmap_on_memory, some pages are initialized
> +	 * prior to calling in here. The remaining amount of pages must be
> +	 * pageblock aligned.
> +	 */
>   	if (WARN_ON_ONCE(!nr_pages ||
> -			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
> +			 !IS_ALIGNED(start_pfn | nr_pages, pageblock_nr_pages)))
>   		return -EINVAL;
>   
>   	mem_hotplug_begin();
> 

I'd only relax start_pfn. That way the function is pretty much 
impossible to abuse for sub-section onlining/offlining.

if (WARN_ON_ONCE(!nr_pages ||
		 !IS_ALIGNED(start_pfn, pageblock_nr_pages))
		 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))

-- 
Thanks,

David / dhildenb

