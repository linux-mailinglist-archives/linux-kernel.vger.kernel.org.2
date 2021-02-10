Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9377D316926
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhBJO3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:29:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhBJO3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:29:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7620BB136;
        Wed, 10 Feb 2021 14:28:48 +0000 (UTC)
Date:   Wed, 10 Feb 2021 15:28:46 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: remove lru_add_drain_all in alloc_contig_range
Message-ID: <20210210142846.GE3636@localhost.localdomain>
References: <20210209175048.361638-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209175048.361638-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:50:48AM -0800, Minchan Kim wrote:
> __alloc_contig_migrate_range already has lru_add_drain_all call
> via migrate_prep. It's necessary to move LRU taget pages into
> LRU list to be able to isolated. However, lru_add_drain_all call
> after __alloc_contig_migrate_range is called is pointless.
> 
> This patch removes it.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

I agree with Michal that the changelog could benefit from Vastimil's
clarification, so with that:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

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
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 
> 

-- 
Oscar Salvador
SUSE L3
