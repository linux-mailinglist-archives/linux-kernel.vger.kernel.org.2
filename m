Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C703161C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhBJJFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:05:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230101AbhBJI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612947404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HuJkwrKM+SC/P2HcDffuGQrd7Q8pyCyuUgvfR1Xy8GE=;
        b=Cy1fmZzLoRxUFATuqi+LdS136n9yEN1XYJoXax0FVMkF+ypMpj7w9Ag8inUD93pQqducFV
        lMxBgFvG+skd1MW4C5E4AK1bu32496nAACiJpZTs9e4uhbNLJjB+lz6Uuny9rqKYUZ29wg
        s7sKCM9L1V9epslKWOXZ8eOMI1XpZhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-1Uc8UV5dOC2F56yh31crsg-1; Wed, 10 Feb 2021 03:56:41 -0500
X-MC-Unique: 1Uc8UV5dOC2F56yh31crsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E609CC620;
        Wed, 10 Feb 2021 08:56:40 +0000 (UTC)
Received: from [10.36.113.218] (ovpn-113-218.ams2.redhat.com [10.36.113.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9A8319CAC;
        Wed, 10 Feb 2021 08:56:38 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [RFC PATCH 1/2] mm,page_alloc: Make alloc_contig_range handle
 in-use hugetlb pages
Message-ID: <6aa21eb3-7bee-acff-8f3c-7c13737066ba@redhat.com>
Date:   Wed, 10 Feb 2021 09:56:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210208103812.32056-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.21 11:38, Oscar Salvador wrote:
> alloc_contig_range is not prepared to handle hugetlb pages and will
> fail if it ever sees one, but since they can be migrated as any other
> page (LRU and Movable), it makes sense to also handle them.
> 
> For now, do it only when coming from alloc_contig_range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/compaction.c | 17 +++++++++++++++++
>   mm/vmscan.c     |  5 +++--
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e5acb9714436..89cd2e60da29 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -940,6 +940,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   			goto isolate_fail;
>   		}
>   
> +		/*
> +		 * Handle hugetlb pages only when coming from alloc_contig
> +		 */
> +		if (PageHuge(page) && cc->alloc_contig) {
> +			if (page_count(page)) {

I wonder if we should care about races here. What if someone 
concurrently allocates/frees?

Note that PageHuge() succeeds on tail pages, isolate_huge_page() not, i 
assume we'll have to handle that as well.

I wonder if it would make sense to move some of the magic to hugetlb 
code and handle it there with less chances for races (isolate if used, 
alloc-and-dissolve if not).

> +				/*
> +				 * Hugetlb page in-use. Isolate and migrate.
> +				 */
> +				if (isolate_huge_page(page, &cc->migratepages)) {
> +					low_pfn += compound_nr(page) - 1;
> +					goto isolate_success_no_list;
> +				}
> +			}

-- 
Thanks,

David / dhildenb

