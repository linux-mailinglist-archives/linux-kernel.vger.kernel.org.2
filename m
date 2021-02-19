Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A5031FD30
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBSQgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhBSQgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:36:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DE4564DF0;
        Fri, 19 Feb 2021 16:35:24 +0000 (UTC)
Date:   Fri, 19 Feb 2021 16:35:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH RESEND] mm, kasan: don't poison boot memory
Message-ID: <20210219163520.GA18049@arm.com>
References: <8d79640cdab4608c454310881b6c771e856dbd2e.1613595522.git.andreyknvl@google.com>
 <20210218104626.GA12761@arm.com>
 <CAAeHK+z-Vsuombjed8OYYpFoL4rENpf1J5F3AzQF8+LsqjDHUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+z-Vsuombjed8OYYpFoL4rENpf1J5F3AzQF8+LsqjDHUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 09:24:49PM +0100, Andrey Konovalov wrote:
> On Thu, Feb 18, 2021 at 11:46 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > The approach looks fine to me. If you don't like the trade-off, I think
> > you could still leave the kasan poisoning in if CONFIG_DEBUG_KERNEL.
> 
> This won't work, Android enables CONFIG_DEBUG_KERNEL in GKI as it
> turns out :)

And does this option go into production kernels?

> > For MTE, we could look at optimising the poisoning code for page size to
> > use STGM or DC GZVA but I don't think we can make it unnoticeable for
> > large systems (especially with DC GZVA, that's like zeroing the whole
> > RAM at boot).
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=211817

A quick hack here if you can give it a try. It can be made more optimal,
maybe calling the set_mem_tag_page directly from kasan:

diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 7ab500e2ad17..b9b9ca1976eb 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -48,6 +48,20 @@ static inline u8 mte_get_random_tag(void)
 	return mte_get_ptr_tag(addr);
 }
 
+static inline void __mte_set_mem_tag_page(u64 curr, u64 end)
+{
+	u64 bs = 4 << (read_cpuid(DCZID_EL0) & 0xf);
+
+	do {
+		asm volatile(__MTE_PREAMBLE "dc gva, %0"
+			     :
+			     : "r" (curr)
+			     : "memory");
+
+		curr += bs;
+	} while (curr != end);
+}
+
 /*
  * Assign allocation tags for a region of memory based on the pointer tag.
  * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
@@ -63,6 +77,11 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	curr = (u64)__tag_set(addr, tag);
 	end = curr + size;
 
+	if (IS_ALIGNED((unsigned long)addr, PAGE_SIZE) && size == PAGE_SIZE) {
+		__mte_set_mem_tag_page(curr, end);
+		return;
+	}
+
 	do {
 		/*
 		 * 'asm volatile' is required to prevent the compiler to move

