Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6964B3F837B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbhHZIEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240449AbhHZID6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:03:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B95D610D2;
        Thu, 26 Aug 2021 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629964984;
        bh=lfRfUXOGIU4YMr/zTdbR8FxwhkqufEf81zxtWDbyrto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mp6vowKKyllc2+JJB5xlTei4338zSzOYKtJJyozcgKr6aNY0omJj5UdEONhAV2bH4
         jjHOwxf0URkO7Ez5ukpFG5gsDnqDRwAq0dj7Nz9Gff0uxXjAKa3yieOwNjRoup9FRj
         uE5ourq3uVh8UPQai4M2gi5FJab1AmYdVPS5CIVRtVVGZNMJvNKZL7itHN1VhC6EDO
         vIAvSf2inIODt5HYtv0s4N73agqhsXYwkI+MUcKb4OC7tTL6orjE0rnJcEoog9tCDt
         adib1s/Im7zxPaXy5aJqOD3tMyi9HQ1HwAfSp6zlm+EaHmb0vCHG9ZOpoX1wp4ahV7
         RlSo4K9odDl4w==
Date:   Thu, 26 Aug 2021 11:02:57 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] x86/mm: write protect (most) page tables
Message-ID: <YSdKsTX3EQQqgj0y@kernel.org>
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-5-rppt@kernel.org>
 <1cccc2b6-8b5b-4aee-483d-f10e64a248a5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cccc2b6-8b5b-4aee-483d-f10e64a248a5@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 04:50:10PM -0700, Dave Hansen wrote:
> On 8/23/21 6:25 AM, Mike Rapoport wrote:
> >  void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
> >  {
> > +	enable_pgtable_write(page_address(pte));
> >  	pgtable_pte_page_dtor(pte);
> >  	paravirt_release_pte(page_to_pfn(pte));
> >  	paravirt_tlb_remove_table(tlb, pte);
> > @@ -69,6 +73,7 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
> >  #ifdef CONFIG_X86_PAE
> >  	tlb->need_flush_all = 1;
> >  #endif
> > +	enable_pgtable_write(pmd);
> >  	pgtable_pmd_page_dtor(page);
> >  	paravirt_tlb_remove_table(tlb, page);
> >  }
> 
> I'm also cringing a bit at hacking this into the page allocator.   A
> *lot* of what you're trying to do with getting large allocations out and
> splitting them up is done very well today by the slab allocators.  It
> might take some rearrangement of 'struct page' metadata to be more slab
> friendly, but it does seem like a close enough fit to warrant investigating.

I thought more about using slab, but it seems to me the least suitable
option. The usecases at hand (page tables, secretmem, SEV/TDX) allocate in
page granularity and some of them use struct page metadata, so even its
rearrangement won't help. And adding support for 2M slabs to SLUB would be
quite intrusive.

I think that better options are moving such cache deeper into buddy or
using e.g. genalloc instead of a list to deal with higher order allocations. 

The choice between these two will mostly depend of the API selection, i.e.
a GFP flag or a dedicated alloc/free.

-- 
Sincerely yours,
Mike.
