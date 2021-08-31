Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F403FC478
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbhHaIs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240156AbhHaIsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:48:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EBF760FE8;
        Tue, 31 Aug 2021 08:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630399676;
        bh=3JkKQ1Gr2earIXtU9C2611/WmKFsUzaW/Ah1TV/+5oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7l2GQM0xUVPZcjBQzRHCJwmHKbqEHZlB2Fvwfw61i4QIMCwVSUX3nsdGc3UsJXAT
         YCCTMVfajuKn/mqFgguAD7SnbatdFt5IgOjjj3o6J3iuVUQ38rY2FXtin4ZdtyXFrF
         5oT66uKddnZQV3UxkMsCP07S8ugiHNj0ni3fW8ly90ESmG62I0Pu525sPtWnb3wOX0
         t880TbzdzHYUaE2DIH+Eeu+WaGB2CRR2OM76NPGMC0Os0t4MhWaxB4SHH6bCTGDPdE
         48F8rKIQcVm2D9dFPeR5v6veSJ7wWbwL9AZlgqWLJT+B6s8V9AcItu9IJyHm+75lGy
         C4Rx/uOfZIg0A==
Date:   Tue, 31 Aug 2021 11:47:49 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        shakeelb@google.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/19] x86/mm: Use alloc_table() for fill_pte(),
 etc
Message-ID: <YS3stfkkCLfqROx1@kernel.org>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
 <20210830235927.6443-11-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830235927.6443-11-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 04:59:18PM -0700, Rick Edgecombe wrote:
> fill_pte(), set_pte_vaddr(), etc allocate page tables with
> spp_getpage(). Use alloc_table() for these allocations in order to get
> tables from the cache of protected pages when needed.
 
I can't say I tracked all the users of set_pte_vaddr(), but I don't see a
fundamental reason why spp_getpage() would need GFP_ATOMIC. Even if there
is a caller of set_pte_vaddr() that cannot sleep, it seems that page tables
can be prepopulated so that set_pte_vaddr() will not need to allocate
anything.  

> Opportunistically, fix a stale comment.

Ack for this one :)
 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/mm/init_64.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 3c0323ad99da..de5a785ee89f 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -220,16 +220,19 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
>  
>  /*
>   * NOTE: This function is marked __ref because it calls __init function
> - * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
> + * (memblock_alloc). It's safe to do it ONLY when after_bootmem == 0.
>   */
>  static __ref void *spp_getpage(void)
>  {
>  	void *ptr;
>  
> -	if (after_bootmem)
> -		ptr = (void *) get_zeroed_page(GFP_ATOMIC);
> -	else
> +	if (after_bootmem) {
> +		struct page *page = alloc_table(GFP_ATOMIC | __GFP_ZERO);
> +
> +		ptr = page ? page_address(page) : NULL;
> +	} else {
>  		ptr = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +	}
>  
>  	if (!ptr || ((unsigned long)ptr & ~PAGE_MASK)) {
>  		panic("set_pte_phys: cannot allocate page data %s\n",
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
