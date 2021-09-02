Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB963FEF06
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbhIBN6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:58:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49270 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345262AbhIBN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:57:54 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B39C420367;
        Thu,  2 Sep 2021 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630591015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FBJbFYS9GOV6EVOWjJDcmNKkVbrLdPLLQpcRZp1U3Lo=;
        b=F13lE2uqBNL7cIzpI01TniOVlc4xNW5ZO2BZI2dJ6afYyrB454Zmhn+mH9+SatFH9xVzpQ
        ZfKGEBTckXRsgH8XBybfpxxHNQcA0mnznOCjT3CPuats9GRwVCYadzJyd8u+Vlmli+7bU2
        X8hLoWJ+sLTVb8upO6g24YHeDKIxivA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630591015;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FBJbFYS9GOV6EVOWjJDcmNKkVbrLdPLLQpcRZp1U3Lo=;
        b=i9b7kb31nHLHFzgkDvG366ucXQh4DnidX/PceibcSoTwZ1jwf/pQ9lpN0AwFldF98FLLzx
        5nxmRNdWDsvlmKCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7BE4C13732;
        Thu,  2 Sep 2021 13:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id S3cxHSfYMGH7HwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 02 Sep 2021 13:56:55 +0000
Message-ID: <38d2a358-4146-bfc9-2a4f-68ce02f75c94@suse.cz>
Date:   Thu, 2 Sep 2021 15:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
 <20210830235927.6443-12-rick.p.edgecombe@intel.com>
 <YS3uhdT88XFvP9n3@kernel.org>
 <f77f3312a1b17b8f8de2ccf0f40f9f19f4a9f151.camel@intel.com>
 <YS8qRHrGzevns32P@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH v2 11/19] mm/sparsemem: Use alloc_table() for table
 allocations
In-Reply-To: <YS8qRHrGzevns32P@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 09:22, Mike Rapoport wrote:
> On Tue, Aug 31, 2021 at 06:25:23PM +0000, Edgecombe, Rick P wrote:
>> On Tue, 2021-08-31 at 11:55 +0300, Mike Rapoport wrote:
>> > On Mon, Aug 30, 2021 at 04:59:19PM -0700, Rick Edgecombe wrote:
>> <trim> 
>> > > -static void * __meminit vmemmap_alloc_block_zero(unsigned long
>> > > size, int node)
>> > > +static void * __meminit vmemmap_alloc_table(int node)
>> > >  {
>> > > -	void *p = vmemmap_alloc_block(size, node);
>> > > +	void *p;
>> > > +	if (slab_is_available()) {
>> > > +		struct page *page = alloc_table_node(GFP_KERNEL |
>> > > __GFP_ZERO, node);
>> > 
>> > This change removes __GFP_RETRY_MAYFAIL|__GFP_NOWARN from the
>> > original gfp
>> > vmemmap_alloc_block() used.
>> Oh, yea good point. Hmm, I guess grouped pages could be aware of that
>> flag too. Would be a small addition, but it starts to grow
>> unfortunately.
>> 
>> > Not sure __GFP_RETRY_MAYFAIL is really needed in
>> > vmemmap_alloc_block_zero()
>> > at the first place, though.
>> Looks like due to a real issue:
>> 055e4fd96e95b0eee0d92fd54a26be7f0d3bcad0

That commit added __GFP_REPEAT, but __GFP_RETRY_MAYFAIL these days became
subtly different.

> I believe the issue was with memory map blocks rather than with page
> tables, but since sparse-vmemmap uses the same vmemmap_alloc_block() for
> both, the GFP flag got stick with both.
> 
> I'm not really familiar with reclaim internals to say if
> __GFP_RETRY_MAYFAIL would help much for order-0 allocation.

For costly allocation, __GFP_RETRY_MAYFAIL will try harder, thus the RETRY
part is accented. For order-0 the only difference is that it will skip OOM,
thus the MAYFAIL part. It usually means there's a fallback. I guess in this
case there's no fallback, so allocating without __GFP_RETRY_MAYFAIL would be
better.

> Vlastimil, can you comment on this?
>  
>> I think it should not affect PKS tables for now, so maybe I can make
>> separate logic instead. I'll look into it. Thanks.
>> > 
>> > More broadly, maybe it makes sense to split boot time and memory
>> > hotplug
>> > paths and use pxd_alloc() for the latter.
>> > 
>> > > +
>> > > +		if (!page)
>> > > +			return NULL;
>> > > +		return page_address(page);
>> > > +	}
>> > >  
>> > > +	p = __earlyonly_bootmem_alloc(node, PAGE_SIZE, PAGE_SIZE,
>> > > __pa(MAX_DMA_ADDRESS));
>> > 
>> > Opportunistically rename to __earlyonly_memblock_alloc()? ;-)
>> > 
>> Heh, I can. Just grepping, there are several other instances of
>> foo_bootmem() only calling foo_memblock() pattern scattered about. Or
>> maybe I'm missing the distinction.
> 
> Heh, I didn't do s/bootmem/memblock/g, so foo_bootmem() are reminders we
> had bootmem allocator once.
> Maybe it's a good time to remove them :)
>  
>> <trim>
> 

