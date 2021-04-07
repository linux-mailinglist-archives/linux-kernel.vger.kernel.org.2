Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F243565A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244723AbhDGHoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233952AbhDGHn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617781429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81Hux045R8v0ughzSuoFVOYsYv4+asXeqp5fiUzKKzE=;
        b=Rz5qD3iYaDkC79+urxs4pSrjDZkkCtRbagPJ/1IuPI+CB3Oq2A+iu2xovEWnjExJ7USrrf
        zicE9rNEsIrEkcd7Wb+/Kmb/Efof8JlEtU6v33aFh9RFY1VvtpXF946FZDkMfhm1Kfsurt
        DeiYwpk31dH83FVK0TN0REH7QZHnMVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-cCRYU0mZNMenjTM73vIjoQ-1; Wed, 07 Apr 2021 03:43:48 -0400
X-MC-Unique: cCRYU0mZNMenjTM73vIjoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E04E1922023;
        Wed,  7 Apr 2021 07:43:46 +0000 (UTC)
Received: from [10.36.114.68] (ovpn-114-68.ams2.redhat.com [10.36.114.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22B6960C4A;
        Wed,  7 Apr 2021 07:43:43 +0000 (UTC)
Subject: Re: [PATCH v6 2/8] mm,memory_hotplug: Relax fully spanned sections
 check
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <df9bdb5157d6ad2f4a922d396ddf0c07@suse.de>
 <59A04B1D-08D6-4E71-A382-F5503A6E0AF7@redhat.com>
 <20210407074249.GA9353@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f23128b1-0d27-76f0-10b2-7816092089ac@redhat.com>
Date:   Wed, 7 Apr 2021 09:43:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407074249.GA9353@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.21 09:42, Oscar Salvador wrote:
> On Tue, Apr 06, 2021 at 10:43:01PM +0200, David Hildenbrand wrote:
>> But not end_pfn as given in my version or what am I missing?
> 
> Nah, was my fault, I managed to see:
> 
>   if (WARN_ON_ONCE(!nr_pages ||
>           !IS_ALIGNED(start_pfn, pageblock_nr_pages))
>           !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
> 
> which would not work.
> 
> I agree that keeping the PAGES_PER_SECTION check maks this safer, so this all
> should have been:
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0cdbbfbc5757..25e59d5dc13c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -838,9 +838,14 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>          int ret;
>          struct memory_notify arg;
>   
> -       /* We can only online full sections (e.g., SECTION_IS_ONLINE) */
> +       /* We can only offline full sections (e.g., SECTION_IS_ONLINE).
> +        * However, when using e.g: memmap_on_memory, some pages are initialized
> +        * prior to calling in here. The remaining amount of pages must be
> +        * pageblock aligned.
> +        */
>          if (WARN_ON_ONCE(!nr_pages ||
> -                        !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
> +                        !IS_ALIGNED(pfn, pageblock_nr_pages) ||
> +                        !IS_ALIGNED(pfn + nr_pages, PAGES_PER_SECTION)))
>                  return -EINVAL;
>   
>          mem_hotplug_begin();
> @@ -1573,9 +1578,14 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>          int ret, node;
>          char *reason;
>   
> -       /* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
> +       /* We can only offline full sections (e.g., SECTION_IS_ONLINE).
> +        * However, when using e.g: memmap_on_memory, some pages are initialized
> +        * prior to calling in here. The remaining amount of pages must be
> +        * pageblock aligned.
> +        */
>          if (WARN_ON_ONCE(!nr_pages ||
> -                        !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
> +                        !IS_ALIGNED(start_pfn, pageblock_nr_pages) ||
> +                        !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
>                  return -EINVAL;
>   
>          mem_hotplug_begin();
> 
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

