Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A053F8414
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240767AbhHZJCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:02:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47014 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhHZJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:02:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 528EC1FE68;
        Thu, 26 Aug 2021 09:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629968479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MF/TJuRAvKBiF1bTYgTrqmcC4Of5Rz/lTIfmYnEXMDI=;
        b=v0ZLz0Rz2ALxh0kUgipMnzd5RLpUEXM3RDvwSz9uM/vyKLVebd3+dPBAnS/gLeCWOjSO6R
        llZ92bPijxKnOcKwFKXrAWoG+3T9NK8KdESeQmBqEIYDBDVDB8jKW4Cv/uLISXIgPklqlB
        whnwT4BNPD30L9mKcEBMAnszMkr2CvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629968479;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MF/TJuRAvKBiF1bTYgTrqmcC4Of5Rz/lTIfmYnEXMDI=;
        b=1GUVHARXd6ybTyl51Sv63Qu7DQ3VNBud1h5mnb+VAAvOBraJemlX3kjpJZVOB65Ft2cLuH
        Ji0JUb5dGsTQZ6DA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1C9FF13AA5;
        Thu, 26 Aug 2021 09:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xGxRBl9YJ2EAFQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 26 Aug 2021 09:01:19 +0000
Message-ID: <de31a1c7-1a35-831f-3eed-e4a6e77f9e44@suse.cz>
Date:   Thu, 26 Aug 2021 11:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [RFC PATCH 4/4] x86/mm: write protect (most) page tables
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-5-rppt@kernel.org>
 <1cccc2b6-8b5b-4aee-483d-f10e64a248a5@intel.com>
 <YSdKsTX3EQQqgj0y@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YSdKsTX3EQQqgj0y@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 10:02, Mike Rapoport wrote:
> On Mon, Aug 23, 2021 at 04:50:10PM -0700, Dave Hansen wrote:
>> On 8/23/21 6:25 AM, Mike Rapoport wrote:
>> >  void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
>> >  {
>> > +	enable_pgtable_write(page_address(pte));
>> >  	pgtable_pte_page_dtor(pte);
>> >  	paravirt_release_pte(page_to_pfn(pte));
>> >  	paravirt_tlb_remove_table(tlb, pte);
>> > @@ -69,6 +73,7 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>> >  #ifdef CONFIG_X86_PAE
>> >  	tlb->need_flush_all = 1;
>> >  #endif
>> > +	enable_pgtable_write(pmd);
>> >  	pgtable_pmd_page_dtor(page);
>> >  	paravirt_tlb_remove_table(tlb, page);
>> >  }
>> 
>> I'm also cringing a bit at hacking this into the page allocator.   A
>> *lot* of what you're trying to do with getting large allocations out and
>> splitting them up is done very well today by the slab allocators.  It
>> might take some rearrangement of 'struct page' metadata to be more slab
>> friendly, but it does seem like a close enough fit to warrant investigating.
> 
> I thought more about using slab, but it seems to me the least suitable
> option. The usecases at hand (page tables, secretmem, SEV/TDX) allocate in
> page granularity and some of them use struct page metadata, so even its
> rearrangement won't help. And adding support for 2M slabs to SLUB would be
> quite intrusive.

Agree, and there would be unnecessary memory overhead too, SLUB would be happy
to cache a 2MB block on each CPU, etc.

> I think that better options are moving such cache deeper into buddy or
> using e.g. genalloc instead of a list to deal with higher order allocations. 
> 
> The choice between these two will mostly depend of the API selection, i.e.
> a GFP flag or a dedicated alloc/free.

Implementing on top of buddy seem still like the better option to me.
