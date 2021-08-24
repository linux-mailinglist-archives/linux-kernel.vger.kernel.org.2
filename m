Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748A53F56CD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 05:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhHXDfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 23:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232605AbhHXDfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 23:35:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CD4561220;
        Tue, 24 Aug 2021 03:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629776070;
        bh=LKJhfUsI0RQ2Pv2LUdZ0MjvA3zWwXIhmCSxLFUFJ8ls=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=icxa68HUCpq/++AP/CQpwB5Zwozod5wIGocSEeMFvL0uL/yAfTWrvVnqlm8kz5gch
         BUuPAgNth7ZWLBM7y7WZLwgnJUnBttVib4RG1Qtgdqd0ZMqL8OdNZamWaWtLQzhRs0
         hsoGZKAmLnimAsyP24KdMXc6clFf3zj/FLG69NBRBpzB24Hr4HyWn7EqK2Q4ZrOX9K
         qfkIywSKEMAQBX4AV0wfH6YJdIisOiaDcBJpZU5P8xswODhJN+hQIhi7QcoWvAC7Ly
         BDiu5TjxcSDqMWoX3Af7aR/Sz+vop2cEealQ7VCkSMGxGlxpJ/CjYUkHzRagvzIyB6
         eJ/3L8uwDmy/w==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 67C6B27C0054;
        Mon, 23 Aug 2021 23:34:28 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Mon, 23 Aug 2021 23:34:28 -0400
X-ME-Sender: <xms:wmgkYYxTvVQcjbminnJGXdLrlFvHs_T7MbrMaWwDv21PN7r1epqmIQ>
    <xme:wmgkYcR2suKE6bR5VuK1LEVdtjfUWRQbjxtN6BOztmN0wBqFfDMqZcY2_A9TUY2hx
    zH0FiiA___EmXJbV7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtiedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:wmgkYaUBwUjsIZ0n_Nthv3sHfggK-klpyyVIyf13ABxZCrvhX0J9sg>
    <xmx:wmgkYWhdp0AzQiFCU0e0rgCg0HuyZ2he7E1F48JcA_0OJ-gKZHfqkA>
    <xmx:wmgkYaD5UW2psIKnCLvQBmCmM2zMgoAZWvfVCdhEK4lwaN_J9NXLqA>
    <xmx:xGgkYe4zqhKM7XeUx4k9cX_IgB-yTbLKpQ4QBaTktc__QBtzydD5dcbTtHs>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 688C8A038A7; Mon, 23 Aug 2021 23:34:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1118-g75eff666e5-fm-20210816.002-g75eff666
Mime-Version: 1.0
Message-Id: <8b50991d-2ab5-4577-83e9-a2d74135c5f5@www.fastmail.com>
In-Reply-To: <1cccc2b6-8b5b-4aee-483d-f10e64a248a5@intel.com>
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-5-rppt@kernel.org>
 <1cccc2b6-8b5b-4aee-483d-f10e64a248a5@intel.com>
Date:   Mon, 23 Aug 2021 20:34:05 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Mike Rapoport" <rppt@kernel.org>, linux-mm@kvack.org
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] x86/mm: write protect (most) page tables
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Aug 23, 2021, at 4:50 PM, Dave Hansen wrote:
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
> I would expected this to have leveraged the pte_offset_map/unmap() code
> to enable/disable write access.  Granted, it would enable write access
> even when only a read is needed, but that could be trivially fixed with
> having a variant like:
> 
> 	pte_offset_map_write()
> 	pte_offset_unmap_write()

I would also like to see a discussion of how races in which multiple threads or CPUs access ptes in the same page at the same time.

> 
> in addition to the existing (presumably read-only) versions:
> 
> 	pte_offset_map()
> 	pte_offset_unmap()
> 
> Although those only work for the leaf levels, it seems a shame not to to
> use them.
> 
> I'm also cringing a bit at hacking this into the page allocator.   A
> *lot* of what you're trying to do with getting large allocations out and
> splitting them up is done very well today by the slab allocators.  It
> might take some rearrangement of 'struct page' metadata to be more slab
> friendly, but it does seem like a close enough fit to warrant investigating.
> 
