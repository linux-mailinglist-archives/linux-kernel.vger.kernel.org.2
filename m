Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD9B31DDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhBQQxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:53:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233694AbhBQQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613580694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yMIS807XTo5yQfEzXou+XaOw6DOdn/T2qnRI6G97U5A=;
        b=GzB+aaOXtXDIuh8Pu4FfWtSdczAYR2pBSsoTBptTvkmMNahyJk8KMvXQw65HV55VfF7gbt
        po3KDLkwqmag6D/C/hHzFwRUTq0NvcTkE0evfFSCO40k9r0SbUV2ppw+HHQNV5egyNADWN
        rz70jQjbGKL73Imz8jDeVu7bYSK2VZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-GcOLr05MOi200kd3A4xlQw-1; Wed, 17 Feb 2021 11:51:30 -0500
X-MC-Unique: GcOLr05MOi200kd3A4xlQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48CE487498B;
        Wed, 17 Feb 2021 16:51:29 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDF9F10013D7;
        Wed, 17 Feb 2021 16:51:27 +0000 (UTC)
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        mhocko@suse.com, joaodias@google.com
References: <20210217163603.429062-1-minchan@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <854d4ec8-1eb9-3595-b867-3e50f5a0e6a8@redhat.com>
Date:   Wed, 17 Feb 2021 17:51:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217163603.429062-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.21 17:36, Minchan Kim wrote:
> alloc_contig_range is usually used on cma area or movable zone.
> It's critical if the page migration fails on those areas so
> dump more debugging message like memory_hotplug unless user
> specifiy __GFP_NOWARN.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>   mm/page_alloc.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0b55c9c95364..67f3ee3a1528 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8486,6 +8486,15 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
>   	}
>   	if (ret < 0) {
> +		if (!(cc->gfp_mask & __GFP_NOWARN)) {
> +			struct page *page;
> +
> +			list_for_each_entry(page, &cc->migratepages, lru) {
> +				pr_warn("migrating pfn %lx failed ret:%d ",
> +						page_to_pfn(page), ret);
> +				dump_page(page, "migration failure");
> +			}

This can create *a lot* of noise. For example, until huge pages are 
actually considered, we will choke on each end every huge page - and 
might do so over and over again.

This might be helpful for debugging, but is unacceptable for production 
systems for now I think. Maybe for now, do it based on CONFIG_DEBUG_VM.

> +		}
>   		putback_movable_pages(&cc->migratepages);
>   		return ret;
>   	}
> @@ -8728,6 +8737,8 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
>   		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
>   		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
>   			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
> +				unsigned long gfp_flags;
> +
>   				/*
>   				 * We release the zone lock here because
>   				 * alloc_contig_range() will also lock the zone
> @@ -8736,8 +8747,11 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
>   				 * and cause alloc_contig_range() to fail...
>   				 */
>   				spin_unlock_irqrestore(&zone->lock, flags);
> +
> +				if (zone_idx(zone) != ZONE_MOVABLE)
> +					gfp_flags = gfp_mask | __GFP_NOWARN;

This feels wrong. It might be better to make that decision inside 
__alloc_contig_migrate_range() based on cc->zone.

-- 
Thanks,

David / dhildenb

