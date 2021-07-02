Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713543BA044
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhGBMXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:23:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38588 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhGBMXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:23:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ABFD0220ED;
        Fri,  2 Jul 2021 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625227984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B8Ca/03PVVMeP5n0edc8DituqmM6qLoYX7dIIIVyhKA=;
        b=dvBN8ZtaTXw2tmTKaFnY+usmC9pmak3btEi7MP4vZgXo4Trgt2NH0MkASmjnvppGNEtWL6
        ib5BokE4ybVuxz5sGfRhDxWGaUQwaoRFjho30pCKXhsoZl1y28pRoY7VW6HX+iasbMxIeA
        8o3qXLWarTQowcx9ZV/IH0O3uNxz728=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 01075A3B81;
        Fri,  2 Jul 2021 12:13:03 +0000 (UTC)
Date:   Fri, 2 Jul 2021 14:13:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ohhoon Kwon <ohoono.kwon@samsung.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, bhe@redhat.com,
        rppt@linux.ibm.com, ohkwon1043@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: sparse: pass section_nr to section_mark_present
Message-ID: <YN8Cz3wAPs+YUEqR@dhcp22.suse.cz>
References: <20210702094132.6276-1-ohoono.kwon@samsung.com>
 <CGME20210702094457epcas1p3ddac76bd3cc3e5b93fadb897cdb6dfd0@epcas1p3.samsung.com>
 <20210702094132.6276-2-ohoono.kwon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702094132.6276-2-ohoono.kwon@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-07-21 18:41:30, Ohhoon Kwon wrote:
> With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
> mem_section to section_nr could be costly since it iterates all
> section roots to check if the given mem_section is in its range.
> 
> On the other hand, __nr_to_section() which converts section_nr to
> mem_section can be done in O(1).
> 
> Let's pass section_nr instead of mem_section ptr to
> section_mark_present() in order to reduce needless iterations.

It is indeed wasteful to spend time on something that is already known.
Both callers have already determined both the section number and the
section so why not just pass both to section_mark_present?
One could argue that from an API point of view it is a bad practice to
have two indipendent arguments referring to the same underlying object,
and I would agree, but this is not really a something that has a wider
use so it is more of a helper. Maybe we want to make that more explicit
via __ prefix.
 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> ---
>  mm/sparse.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 55c18aff3e42..4a2700e9a65f 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -186,13 +186,14 @@ void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>   * those loops early.
>   */
>  unsigned long __highest_present_section_nr;
> -static void section_mark_present(struct mem_section *ms)
> +static void section_mark_present(unsigned long section_nr)
>  {
> -	unsigned long section_nr = __section_nr(ms);
> +	struct mem_section *ms;
>  
>  	if (section_nr > __highest_present_section_nr)
>  		__highest_present_section_nr = section_nr;
>  
> +	ms = __nr_to_section(section_nr);
>  	ms->section_mem_map |= SECTION_MARKED_PRESENT;
>  }
>  
> @@ -279,7 +280,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>  		if (!ms->section_mem_map) {
>  			ms->section_mem_map = sparse_encode_early_nid(nid) |
>  							SECTION_IS_ONLINE;
> -			section_mark_present(ms);
> +			section_mark_present(section);
>  		}
>  	}
>  }
> @@ -933,7 +934,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  
>  	ms = __nr_to_section(section_nr);
>  	set_section_nid(section_nr, nid);
> -	section_mark_present(ms);
> +	section_mark_present(section_nr);
>  
>  	/* Align memmap to section boundary in the subsection case */
>  	if (section_nr_to_pfn(section_nr) != start_pfn)
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
