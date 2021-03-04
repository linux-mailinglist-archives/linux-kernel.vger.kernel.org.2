Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7F32D88A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbhCDRZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:25:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231439AbhCDRYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614878596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Q+msirUjwPNJ/6VeaFJuWexxOMnxBOOZp0eEWINW9s=;
        b=iltkBEt0UyWXvvkIXmYC03ZijRDhoLA4B0pOf1hxkjVEEBDHR4DSNQQHr+hKayELst5QMP
        3eFwXj8Q9XMErQCwaBkqrdwyYAgI/7jb4Het+8jPYVuEA7qW/qtyTpI9g5NTrItFcdh2Ez
        qmcB2sZ3Zb8znkkfY6h4/JOpcIiqOR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-W1S7B9z3NiaqN7idFXyDmQ-1; Thu, 04 Mar 2021 12:23:14 -0500
X-MC-Unique: W1S7B9z3NiaqN7idFXyDmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8814057;
        Thu,  4 Mar 2021 17:23:12 +0000 (UTC)
Received: from [10.36.113.171] (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ADC41002393;
        Thu,  4 Mar 2021 17:23:10 +0000 (UTC)
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
References: <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
 <YC6TpqT26dSy11fU@google.com> <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz>
 <YD50pcPuwV456vwm@google.com> <YEEES/K8cNi8qOJe@google.com>
 <d83a03dd-fdff-ed62-a2ad-77b25d8249f0@redhat.com>
 <YEEJf0itS/8vn8Iy@google.com>
 <d3095ead-a762-61cd-0990-702e14e03d10@redhat.com>
 <YEEUq8ZRn4WyYWVx@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
Date:   Thu, 4 Mar 2021 18:23:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEEUq8ZRn4WyYWVx@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> You want to debug something, so you try triggering it and capturing debug
>> data. There are not that many alloc_contig_range() users such that this
>> would really be an issue to isolate ...
> 
> cma_alloc uses alloc_contig_range and cma_alloc has lots of users.
> Even, it is expoerted by dmabuf so any userspace would trigger the
> allocation by their own. Some of them could be tolerant for the failure,
> rest of them could be critical. We should't expect it by limited kernel
> usecase.

Assume you are debugging allocation failures. You either collect the 
data yourself or ask someone to send you that output. You care about any 
alloc_contig_range() allocation failures that shouldn't happen, don't you?

> 
>>
>> Strictly speaking: any allocation failure on ZONE_MOVABLE or CMA is
>> problematic (putting aside NORETRY logic and similar aside). So any such
>> page you hit is worth investigating and, therefore, worth getting logged for
>> debugging purposes.
> 
> If you believe the every alloc_contig_range failure is problematic

Every one where we should have guarantees I guess: ZONE_MOVABLE or 
MIGRAT_CMA. On ZONE_NORMAL, there are no guarantees.

> and there is no such realy example I menionted above in the world,
> I am happy to put this chunk to support dynamic debugging.
> Okay?
> 
> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +        (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> +static DEFINE_RATELIMIT_STATE(alloc_contig_ratelimit_state,
> +               DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +int alloc_contig_ratelimit(void)
> +{
> +       return __ratelimit(&alloc_contig_ratelimit_state);
> +}
> +

^ do we need ratelimiting with dynamic debugging enabled?

> +void dump_migrate_failure_pages(struct list_head *page_list)
> +{
> +       DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> +                       "migrate failure");
> +       if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
> +                       alloc_contig_ratelimit()) {
> +               struct page *page;
> +
> +               WARN(1, "failed callstack");
> +               list_for_each_entry(page, page_list, lru)
> +                       dump_page(page, "migration failure");

Are all pages on the list guaranteed to be problematic, or only the 
first entry? I assume all.

> +       }
> +}
> +#else
> +static inline void dump_migrate_failure_pages(struct list_head *page_list)
> +{
> +}
> +#endif
> +
>   /* [start, end) must belong to a single zone. */
>   static int __alloc_contig_migrate_range(struct compact_control *cc,
>                                          unsigned long start, unsigned long end)
> @@ -8496,6 +8522,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>                                  NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
>          }
>          if (ret < 0) {
> +               dump_migrate_failure_pages(&cc->migratepages);
>                  putback_movable_pages(&cc->migratepages);
>                  return ret;
>          }
> 
> 

If that's the way dynamic debugging is configured/enabled (still have to 
look into it) - yes, that goes into the right direction. As I said 
above, you should dump only where we have some kind of guarantees I assume.

-- 
Thanks,

David / dhildenb

