Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC746316672
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBJMSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:18:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:50748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhBJMOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:14:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B52CAC97;
        Wed, 10 Feb 2021 12:13:33 +0000 (UTC)
Subject: Re: [PATCH] mm: remove lru_add_drain_all in alloc_contig_range
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
References: <20210209175048.361638-1-minchan@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <429d0494-ac72-de24-08e1-60851c6f8c0c@suse.cz>
Date:   Wed, 10 Feb 2021 13:13:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209175048.361638-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 6:50 PM, Minchan Kim wrote:
> __alloc_contig_migrate_range already has lru_add_drain_all call
> via migrate_prep. It's necessary to move LRU taget pages into
> LRU list to be able to isolated. However, lru_add_drain_all call
> after __alloc_contig_migrate_range is called is pointless.
> 
> This patch removes it.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6446778cbc6b..f8fbee73dd6d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8603,8 +8603,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	 * isolated thus they won't get removed from buddy.
>  	 */
>  
> -	lru_add_drain_all();
> -
>  	order = 0;
>  	outer_start = start;
>  	while (!PageBuddy(pfn_to_page(outer_start))) {
> 

