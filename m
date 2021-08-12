Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52A3EAC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 23:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhHLVJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 17:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhHLVJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:09:00 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F44C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:08:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id n6so12464008ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YpFOixfCUpC49LCJc0vUvfuAwPcwjJWVPf9TZf8tyJ8=;
        b=cAG9i2LwB3ilC3ArMI7sK1ndTIQHyayqlAYVv3TlOJ5K+Z6NySlDYlyxQEVoQ9Wgvk
         NhkpaxSmgxedeZ2O7khhDzfm6Pak3MvGiXBVHRibHFlBD2cRKkF8oTVL46xJI4ean5h7
         GVZlzbl37MOZrjyehEAeM9aL+K9Z8D0aTmBV/UpyNzofZ3IdxRhubVb37DRtAxp6f/1W
         XBMmDjpd+LuS370xmTefqRvppJguLKysX+6ubL2k8A+4chahQoxIFx5fdSIdFoWutTy4
         fqmEKHXyCBHHbu9yMrwydNqTj7C7EXBa6HS3BN+B4DqpzrbXVuTyXhqsCprOwayzDeRC
         tEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YpFOixfCUpC49LCJc0vUvfuAwPcwjJWVPf9TZf8tyJ8=;
        b=Pdf0XjvV+v1BIUquhOHdL1DkjjnGdbWM/OYIA6940Ci8AcKJT8EjoFwwUpouuYiabN
         JhxS+c10vgqUnWWeppglifzeajuNoFvyigKbSQdYRrKGXZWTLAzHI+QkCnBUUDistwr1
         45Tfw87Uh+fv21NfQF9JqZj9IZtCfb1qwZYhAExspEEu5Lb/uYcgjxzX5lBiGnSpquvO
         l0x6/INniBXmFQq86twO9wXyPBVSWN6+2FZf11E4/VVuBMO1wcWUh1gvp5jyalPsCy47
         kG8fBVTdCIyvzaJUDnSVMby9MOe9ReEKFtzr6Z8YwVUY/s1HWlvEnPD+rLYM9ti/8SRU
         +uPQ==
X-Gm-Message-State: AOAM530k0EcgYciuhuP2NUn5TI1Rszqadpa4hY85nKaDRh5LaE6UQ4+i
        raOhLe/FxuuaCSOM6Rr/rq8Peg==
X-Google-Smtp-Source: ABdhPJzFIkQOm8E0duwu89bHdOD4H/nXReJ/pZkzEeRcCz/lKjlA0OADTVu1mSRdY1UHYhvG1mAEcQ==
X-Received: by 2002:a05:651c:516:: with SMTP id o22mr161107ljp.152.1628802513050;
        Thu, 12 Aug 2021 14:08:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q66sm441742ljb.83.2021.08.12.14.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 14:08:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 10242102BEE; Fri, 13 Aug 2021 00:08:46 +0300 (+03)
Date:   Fri, 13 Aug 2021 00:08:46 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 1/5] mm: Add support for unaccepted memory
Message-ID: <20210812210846.bfalflrvn4bfpyyh@box.shutemov.name>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-2-kirill.shutemov@linux.intel.com>
 <d091b333-9ef8-ac32-58c5-c325d29f26d7@intel.com>
 <f7667988-4d6c-461e-901d-a6c3612b2f0f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7667988-4d6c-461e-901d-a6c3612b2f0f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 01:50:57PM -0700, Dave Hansen wrote:
> On 8/10/21 11:13 AM, Dave Hansen wrote:
> >> @@ -1001,6 +1004,9 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
> >>  	if (page_reported(page))
> >>  		__ClearPageReported(page);
> >>  
> >> +	if (PageOffline(page))
> >> +		clear_page_offline(page, order);
> >> +
> >>  	list_del(&page->lru);
> >>  	__ClearPageBuddy(page);
> >>  	set_page_private(page, 0);
> > So, this is right in the fast path of the page allocator.  It's a
> > one-time thing per 2M page, so it's not permanent.
> > 
> > *But* there's both a global spinlock and a firmware call hidden in
> > clear_page_offline().  That's *GOT* to hurt if you were, for instance,
> > running a benchmark while this code path is being tickled.  Not just to
> > 
> > That could be just downright catastrophic for scalability, albeit
> > temporarily.
> 
> One more thing...
> 
> How long are these calls?  You have to make at least 512 calls into the
> SEAM module.  Assuming they're syscall-ish, so ~1,000 cycles each,
> that's ~500,000 cycles, even if we ignore the actual time it takes to
> zero that 2MB worth of memory and all other overhead within the SEAM module.

I hope to get away with 2 calls per 2M: one MapGPA and one TDACCEPTPAGE
(or 3 for MAXORDER -- 4M -- pages). I don't have any numbers yet.

> So, we're sitting on one CPU with interrupts off, blocking all the other
> CPUs from doing page allocation in this zone. 

I agree that's not good. Let's see if it's going to be okay with accepting
in 2M chunks.

> Then, we're holding a global lock which prevents any other NUMA nodes
> from accepting pages.

Looking at this again, the global lock is aviodable: the caller owns the
pfn range so nobody can touch these bits in the bitmap. We can replace
bitmap_clear() with atomic clear_bit() loop and drop the lock completely.

> If the other node happens to *try* to do an
> accept, it will sit with its zone lock held waiting for this one.

> Maybe nobody will ever notice.  But, it seems like an awfully big risk
> to me.  I'd at least *try* do these calls outside of the zone lock.
> Then the collateral damage will at least be limited to things doing
> accepts rather than all zone->lock users.
> 
> Couldn't we delay the acceptance to, say the place where we've dropped
> the zone->lock and do the __GFP_ZERO memset() like at prep_new_page()?
> Or is there some concern that the page has been split at that point?

It *will* be split by the point. Like if you ask for order-0 page and you
don't any left page allocator will try higher orders until finds anything.
On order-9 it would hit unaccepted. At that point the page going to split
and put on the free lists accordingly. That's all happens under zone lock.

  __rmqueue_smallest ->
    del_page_from_free_list()
    expand()

> I guess that makes it more complicated because you might have a 4k page
> but you need to go accept a 2M page.  You might end up having to check
> the bitmap 511 more times because you might see 511 more PageOffline()
> pages come through.
> 
> You shouldn't even need the bitmap lock to read since it's a one-way
> trip from unaccepted->accepted.

Yeah. Unless we don't want to flip it back on making the range share.
I think we do. Otherwise it will cause problems for kexec.

-- 
 Kirill A. Shutemov
