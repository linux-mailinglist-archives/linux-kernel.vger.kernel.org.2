Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4863BE9CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhGGOes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:34:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50200 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhGGOer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:34:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 646362009B;
        Wed,  7 Jul 2021 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625668326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kuS5bmizMP3/HWTyoAHfOXtGA9iGXpLookw1mW0+L+g=;
        b=p4izdV5DJ23yq+Ht46GKB5gi+T+R/XCFqLaZqPr2G6yEOaeJBlk7tgfa+voRydbpM+Gczl
        8cEzPNtL/k0fMydjvhD6rEoWVBn65HvLK8iv74nTuo7k8zU83KSeO+4kfDZO/aOlWk0uf0
        CaSjbPvQs9WyhR0Vuwd67vCrFP2JcT4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F1A0A3D78;
        Wed,  7 Jul 2021 14:32:05 +0000 (UTC)
Date:   Wed, 7 Jul 2021 16:32:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ohhoon Kwon <ohoono.kwon@samsung.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, bhe@redhat.com,
        rppt@linux.ibm.com, ohkwon1043@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: ***UNCHECKED*** [PATCH v3 1/1] mm: sparse: pass section_nr to
 section_mark_present
Message-ID: <YOW65RnclfCZe/J8@dhcp22.suse.cz>
References: <20210707131443.6242-1-ohoono.kwon@samsung.com>
 <CGME20210707131841epcas1p129d1c10efdbbe403e80f45245b0b5afd@epcas1p1.samsung.com>
 <20210707131443.6242-2-ohoono.kwon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707131443.6242-2-ohoono.kwon@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-07-21 22:14:43, Ohhoon Kwon wrote:
> With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
> mem_section to section_nr could be costly since it iterates all
> section roots to check if the given mem_section is in its range.
> 
> Since both callers of section_mark_present already know section_nr,
> let's also pass section_nr as well as mem_section in order to reduce
> costly translation.
> 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

I would simply fold that into the first patch but a separate patch is
also OK.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks

> ---
>  mm/sparse.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 6326cdf36c4f..8018ee7fcda5 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -187,10 +187,9 @@ void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>   * those loops early.
>   */
>  unsigned long __highest_present_section_nr;
> -static void section_mark_present(struct mem_section *ms)
> +static void __section_mark_present(struct mem_section *ms,
> +		unsigned long section_nr)
>  {
> -	unsigned long section_nr = __section_nr(ms);
> -
>  	if (section_nr > __highest_present_section_nr)
>  		__highest_present_section_nr = section_nr;
>  
> @@ -280,7 +279,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>  		if (!ms->section_mem_map) {
>  			ms->section_mem_map = sparse_encode_early_nid(nid) |
>  							SECTION_IS_ONLINE;
> -			section_mark_present(ms);
> +			__section_mark_present(ms, section);
>  		}
>  	}
>  }
> @@ -934,7 +933,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  
>  	ms = __nr_to_section(section_nr);
>  	set_section_nid(section_nr, nid);
> -	section_mark_present(ms);
> +	__section_mark_present(ms, section_nr);
>  
>  	/* Align memmap to section boundary in the subsection case */
>  	if (section_nr_to_pfn(section_nr) != start_pfn)
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
