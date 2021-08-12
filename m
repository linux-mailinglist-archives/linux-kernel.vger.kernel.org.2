Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D99E3EAC16
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhHLUtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhHLUtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:49:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BC8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:49:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d4so15761175lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pfVYeiF6NsTodz2n4eSeO7tT8BowjN/vmYohy2o7SVU=;
        b=pTPOMagXaOUXVggHiYUHmrkCBZT4ZIZ8OcOlXpc7anChygiuYEiuDMFnf3RqRNcM26
         OzweCu8YyeDAJcSJIP63ZV4nfBiX7FGB7RB54fv4t9PkDPyt97XfD/cx97VeKalO8dY8
         d+Vns1JaZOc0hTjGsxPeXXQGbUx58KdeJwUg+GBr2fNgaAlYb7iSeVtPHY7rE3sPeZCD
         8vbdsy+9twQDArQLUz8Fh0pRIxgFjQ2NjOI0+cQbO6mI4cdNtv3P9uDjwThn0OgE4cPz
         7dZOYsxhT3yQTth6RzYIEvXEH0JrQYHIrMRFuuXMvjZ139FYzBm/NxPw0P3oBGXN2oir
         emUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pfVYeiF6NsTodz2n4eSeO7tT8BowjN/vmYohy2o7SVU=;
        b=b2YbSd9xCBNTo5rZuOpnfianEN9xYh5Ixnl7czV9TqmF6eXI66PWv2cPQbNKcJ5/zs
         QjNyIUB95oYgNkaXgahox5TX4VhmfxKiMHQFFwx78sq16/JhvYpZuOCDqNfpBbNevIpP
         rzaPwBybQTTS29nWLhzPRgLxOQ+ZTB8+S47geijT0TytgnRKDRh/Myo46FLQqoM4Gzoc
         A61yu8qmBVK2l3Cn+XnYINLxbWSdoFdbLFDDGUFMtAfynGlCpPXskHw6Cf1IStGF7HyM
         TSrnTEA66KYUcms9IyIMjoo7jBkelK1Ad63vqzjFqYBjLKgNQIoSJxY4/mU1WWlI3+3/
         xhwA==
X-Gm-Message-State: AOAM530ZjgXHPuLWqju1V/En2KY033b/edL1qs8sOjPJs9oOri7G0/vP
        Zt0sPU+5VbmNBj11tdVhYBKMLw==
X-Google-Smtp-Source: ABdhPJx0kYDvYIJQVOD8WIttESM9kcBa3OyExZB3hoeM0L7g01xXKYY3CCXhwlpnGaNCOgkg88F9QA==
X-Received: by 2002:a05:6512:3682:: with SMTP id d2mr3897174lfs.50.1628801351604;
        Thu, 12 Aug 2021 13:49:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e1sm2294lfs.307.2021.08.12.13.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:49:10 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B3CE4102BEE; Thu, 12 Aug 2021 23:49:24 +0300 (+03)
Date:   Thu, 12 Aug 2021 23:49:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20210812204924.haneuxapkmluli6t@box.shutemov.name>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-2-kirill.shutemov@linux.intel.com>
 <d091b333-9ef8-ac32-58c5-c325d29f26d7@intel.com>
 <9748c07c-4e59-89d0-f425-c57f778d1b42@linux.intel.com>
 <17b6a3a3-bd7d-f57e-8762-96258b16247a@intel.com>
 <796a4b20-7fa3-3086-efa0-2f728f35ae06@linux.intel.com>
 <f445da8b-c044-3765-65f2-f911dbf6a507@intel.com>
 <3caf5e73-c104-0057-680c-7851476e67ac@linux.intel.com>
 <YRTZr/Pxyb8fsV58@suse.de>
 <25312492-5d67-e5b0-1a51-b6880f45a550@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25312492-5d67-e5b0-1a51-b6880f45a550@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 07:14:20AM -0700, Dave Hansen wrote:
> On 8/12/21 1:19 AM, Joerg Roedel wrote:
> > On Tue, Aug 10, 2021 at 02:20:08PM -0700, Andi Kleen wrote:
> >> Also I agree with your suggestion that we should get the slow path out of
> >> the zone locks/interrupt disable region. That should be easy enough and is
> >> an obvious improvement.
> > 
> > I also agree that the slow-path needs to be outside of the memory
> > allocator locks. But I think this conflicts with the concept of
> > accepting memory in 2MB chunks even if allocation size is smaller.
> > 
> > Given some kernel code allocated 2 pages and the allocator path starts
> > to validate the whole 2MB page the memory is on, then there are
> > potential races to take into account.
> 
> Yeah, the PageOffline()+PageBuddy() trick breaks down as soon as
> PageBuddy() gets cleared.
> 
> I'm not 100% sure we need a page flag, though.  Imagine if we just did a
> static key check in prep_new_page():
> 
> 	if (static_key_whatever(tdx_accept_ongoing))
> 		maybe_accept_page(page, order);
> 
> maybe_accept_page() could just check the acceptance bitmap and see if
> the 2MB page has been accepted.  If so, just return.  If not, take the
> bitmap lock, accept the 2MB page, then mark the bitmap.
> 
> maybe_accept_page()
> {
> 	unsigned long huge_pfn = page_to_phys(page) / PMD_SIZE;
> 
> 	/* Test the bit before taking any locks: */
> 	if (test_bit(huge_pfn, &accepted_bitmap))
> 		return;
> 
> 	spin_lock_irq();
> 	/* Retest inside the lock: */
> 	if (test_bit(huge_pfn, &accepted_bitmap))
> 		return;
> 	tdx_accept_page(page, PMD_SIZE);
> 	set_bit(huge_pfn, &accepted_bitmap));
> 	spin_unlock_irq();
> }
> 
> That's still not great.  It's still a global lock and the lock is still
> held for quite a while because that accept isn't going to be lightning
> fast.  But, at least it's not holding any *other* locks.  It also
> doesn't take any locks in the fast path where the 2MB page was already
> accepted.

I expect a cache line with bitmap to bounce around during warm up. One
cache line covers a gig of RAM.

It's also not clear at all at what point the static key has to be
switched. We don't have any obvious point where we can say we are done
with accepting (unless you advocate for proactive accepting).

I like PageOffline() because we only need to consult the cache page
allocator already have in hands before looking into bitmap.

> The locking could be more fine-grained, for sure.  The bitmap could, for
> instance, have a lock bit too.  Or we could just have an array of locks
> and hash the huge_pfn to find a lock given a huge_pfn.  But, for now, I
> think it's fine to just keep the global lock.
> 
> > Either some other code path allocates memory from that page and returns
> > it before validation is finished or we end up with double validation.
> > Returning unvalidated memory is a guest-problem and double validation
> > will cause security issues for SNP guests.
> 
> Yeah, I think the *canonical* source of information for accepts is the
> bitmap.  The page flags and any static keys or whatever are
> less-canonical sources that tell you when you _might_ need to consult
> the bitmap.

Right.

-- 
 Kirill A. Shutemov
