Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32893BA03F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhGBMVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:21:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhGBMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:21:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5A5C422989;
        Fri,  2 Jul 2021 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625228319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tafCEo0yQeDqyI1Ey6/WGCSopcKZ7s02+Wi5y5dZTAI=;
        b=FnKWHedlFVULx5aCP3jFRg0wcDsQg6Sa2NPo83SBoHS3qwD+LLXeOq3SnfMF1eCNjuV97k
        fVxwYj/dP16vUi3TF5j0zB0RW5Qb3UNVX7oJqZl+UrtW6MmTps7BCRz73hmjet5ahHseOd
        JA9VSlhXs5nX9X3TciS1lpWP0DboDq4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A62DBA3B83;
        Fri,  2 Jul 2021 12:18:38 +0000 (UTC)
Date:   Fri, 2 Jul 2021 14:18:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ohhoon Kwon <ohoono.kwon@samsung.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, bhe@redhat.com,
        rppt@linux.ibm.com, ohkwon1043@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: sparse: remove __section_nr() function
Message-ID: <YN8EHfBu358OMugA@dhcp22.suse.cz>
References: <20210702094132.6276-1-ohoono.kwon@samsung.com>
 <CGME20210702094457epcas1p4e181c7b0a18338403a7ffb57f44807fe@epcas1p4.samsung.com>
 <20210702094132.6276-4-ohoono.kwon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702094132.6276-4-ohoono.kwon@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-07-21 18:41:32, Ohhoon Kwon wrote:
> __section_nr() was used to convert struct mem_section * to section_nr.
> 
> With CONFIG_SPARSEMEM_EXTREME enabled, however, __section_nr() can be
> costly since it iterates all section roots to check if the given
> mem_section is in its range.
> 
> On the other hand, __nr_to_section() which converts section_nr to
> mem_section can be done in O(1).
> 
> The only users of __section_nr() was section_mark_present() and
> find_memory_block().
> 
> Since I changed both functions to use section_nr directly in the
> preceeding patches, let's remove __section_nr() which has no users.
> 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>

I would go with a much shorter changelog. The function is not used
anymore so it can be simply dropped.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mmzone.h |  1 -
>  mm/sparse.c            | 26 --------------------------
>  2 files changed, 27 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0d53eba1c383..8931f95cf885 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1321,7 +1321,6 @@ static inline struct mem_section *__nr_to_section(unsigned long nr)
>  		return NULL;
>  	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
>  }
> -extern unsigned long __section_nr(struct mem_section *ms);
>  extern size_t mem_section_usage_size(void);
>  
>  /*
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 4a2700e9a65f..1b32d15593e4 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -108,32 +108,6 @@ static inline int sparse_index_init(unsigned long section_nr, int nid)
>  }
>  #endif
>  
> -#ifdef CONFIG_SPARSEMEM_EXTREME
> -unsigned long __section_nr(struct mem_section *ms)
> -{
> -	unsigned long root_nr;
> -	struct mem_section *root = NULL;
> -
> -	for (root_nr = 0; root_nr < NR_SECTION_ROOTS; root_nr++) {
> -		root = __nr_to_section(root_nr * SECTIONS_PER_ROOT);
> -		if (!root)
> -			continue;
> -
> -		if ((ms >= root) && (ms < (root + SECTIONS_PER_ROOT)))
> -		     break;
> -	}
> -
> -	VM_BUG_ON(!root);
> -
> -	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
> -}
> -#else
> -unsigned long __section_nr(struct mem_section *ms)
> -{
> -	return (unsigned long)(ms - mem_section[0]);
> -}
> -#endif
> -
>  /*
>   * During early boot, before section_mem_map is used for an actual
>   * mem_map, we use section_mem_map to store the section's NUMA
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
