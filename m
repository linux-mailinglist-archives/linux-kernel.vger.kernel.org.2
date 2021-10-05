Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B1F4224CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhJELQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:16:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41598 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhJELQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:16:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E5942027E;
        Tue,  5 Oct 2021 11:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633432506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iXB7Q8sRuEn5IalpujyMPzVx9cKiV7uy8PSeyuhzXA=;
        b=P6UWVjRA1QJefVXQzGHBE56/zXKTBSG7au+zg1DROwVHfYHSJ/SQ28kzAspfEZuekdKGtf
        Qz93sGTFcl+SxcbdiKPs7aUR6WBDYDUUWMX8JfuAN07SlBdKbPAOJyryx7/Rx8Dm5bDjMH
        DgGRIs/nEda1TQjTAa/45A0kjW7hIKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633432506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iXB7Q8sRuEn5IalpujyMPzVx9cKiV7uy8PSeyuhzXA=;
        b=svlCpJ7mOa+0fPKz4EjTmrhBAZpotiFCH5+jOUFqMrLsssMpjPYqvhw5AXijXltYbIMhnP
        t8mJ78jF4XikC/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8F7C13C35;
        Tue,  5 Oct 2021 11:15:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YNGYM7kzXGGDNgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Oct 2021 11:15:05 +0000
Message-ID: <4bcf5e1d-cd86-319a-889f-782755955e04@suse.cz>
Date:   Tue, 5 Oct 2021 13:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210917164756.8586-1-peterx@redhat.com>
 <20210917164756.8586-4-peterx@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 3/3] mm/smaps: Simplify shmem handling of pte holes
In-Reply-To: <20210917164756.8586-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/21 18:47, Peter Xu wrote:
> Firstly, check_shmem_swap variable is actually not necessary, because it's
> always set with pte_hole hook; checking each would work.

Right...

> Meanwhile, the check within smaps_pte_entry is not easy to follow.  E.g.,
> pte_none() check is not needed as "!pte_present && !is_swap_pte" is the same.

Seems to be true, indeed.

> Since at it, use the pte_hole() helper rather than dup the page cache lookup.

pte_hole() is for checking a range and we are calling it for single page,
isnt't that causing larger overhead in the end? There's xarray involved, so
maybe Matthew will know best.

> Still keep the CONFIG_SHMEM part so the code can be optimized to nop for !SHMEM.
> 
> There will be a very slight functional change in smaps_pte_entry(), that for
> !SHMEM we'll return early for pte_none (before checking page==NULL), but that's
> even nicer.

I don't think this is true, 'unlikely(IS_ENABLED(CONFIG_SHMEM))' will be a
compile-time constant false and shortcut the rest of the 'if' evaluation
thus there will be no page check? Or I misunderstood.

> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/proc/task_mmu.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 2197f669e17b..ad667dbc96f5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -397,7 +397,6 @@ struct mem_size_stats {
>  	u64 pss_shmem;
>  	u64 pss_locked;
>  	u64 swap_pss;
> -	bool check_shmem_swap;
>  };
>  
>  static void smaps_page_accumulate(struct mem_size_stats *mss,
> @@ -490,6 +489,16 @@ static int smaps_pte_hole(unsigned long addr, unsigned long end,
>  #define smaps_pte_hole		NULL
>  #endif /* CONFIG_SHMEM */
>  
> +static void smaps_pte_hole_lookup(unsigned long addr, struct mm_walk *walk)
> +{
> +#ifdef CONFIG_SHMEM
> +	if (walk->ops->pte_hole) {
> +		/* depth is not used */
> +		smaps_pte_hole(addr, addr + PAGE_SIZE, 0, walk);
> +	}
> +#endif
> +}
> +
>  static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  		struct mm_walk *walk)
>  {
> @@ -518,12 +527,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  			}
>  		} else if (is_pfn_swap_entry(swpent))
>  			page = pfn_swap_entry_to_page(swpent);
> -	} else if (unlikely(IS_ENABLED(CONFIG_SHMEM) && mss->check_shmem_swap
> -							&& pte_none(*pte))) {
> -		page = xa_load(&vma->vm_file->f_mapping->i_pages,
> -						linear_page_index(vma, addr));
> -		if (xa_is_value(page))
> -			mss->swap += PAGE_SIZE;
> +	} else {
> +		smaps_pte_hole_lookup(addr, walk);
>  		return;
>  	}
>  
> @@ -737,8 +742,6 @@ static void smap_gather_stats(struct vm_area_struct *vma,
>  		return;
>  
>  #ifdef CONFIG_SHMEM
> -	/* In case of smaps_rollup, reset the value from previous vma */
> -	mss->check_shmem_swap = false;
>  	if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
>  		/*
>  		 * For shared or readonly shmem mappings we know that all
> @@ -756,7 +759,6 @@ static void smap_gather_stats(struct vm_area_struct *vma,
>  					!(vma->vm_flags & VM_WRITE))) {
>  			mss->swap += shmem_swapped;
>  		} else {
> -			mss->check_shmem_swap = true;
>  			ops = &smaps_shmem_walk_ops;
>  		}
>  	}
> 

