Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7E036E538
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhD2G6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2G6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:58:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAD7A6144B;
        Thu, 29 Apr 2021 06:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619679483;
        bh=l1YNoSMCv4WqRE2vuNJAwrTs3h6UQBEivHBC6/hQdn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aO7gxyhOVkLEx+raw89h1VPcYXGHTfGyqvHsdHo+ICI31y241io5QGGPJR12RCD/p
         8AV8o5ax3nhSce+p3MiYHZSHqQ3/x1PJX8BN+6vIYtKheOallgAVi/YfSh3X7TEeB6
         hjyaQyhwr1wfIx38apMX8lqS4GMc67eRdUkGB7x35fhWcDz6Fqm+yi56m8gChW4baP
         JKP9TA+UXsJKV0urjwKkeiV01FoQLOC2yqnzM0MqCY6C8bKYb1LBHxDpS0R9BsOMdw
         QP6NufksB+r1kxa/ucqzUL74NkyIi/gXA3Je3MbkdY2i2jyKJ9umoNjuWeNLy8ChHy
         yO1oOEtaPufSA==
Date:   Thu, 29 Apr 2021 09:57:53 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
Message-ID: <YIpY8TXCSc7Lfa2Z@kernel.org>
References: <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
 <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
 <YIUYG8N9T3/C/tSG@kernel.org>
 <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
 <YIZNq5HMfJ1rWytv@kernel.org>
 <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
 <YIet5X7lgygD9rpZ@kernel.org>
 <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
 <YIj5zcbHBHt7CC8B@kernel.org>
 <6ad2956c-70ae-c423-ed7d-88e94c88060f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ad2956c-70ae-c423-ed7d-88e94c88060f@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 08:48:26AM +0800, Kefeng Wang wrote:
> 
> On 2021/4/28 13:59, Mike Rapoport wrote:
> > On Tue, Apr 27, 2021 at 07:08:59PM +0800, Kefeng Wang wrote:
> > > On 2021/4/27 14:23, Mike Rapoport wrote:
> > > > On Mon, Apr 26, 2021 at 11:26:38PM +0800, Kefeng Wang wrote:
> > > > > On 2021/4/26 13:20, Mike Rapoport wrote:
> > > > > > On Sun, Apr 25, 2021 at 03:51:56PM +0800, Kefeng Wang wrote:
> > > > > > > On 2021/4/25 15:19, Mike Rapoport wrote:
> > > > > > > 
> > > > > > >        On Fri, Apr 23, 2021 at 04:11:16PM +0800, Kefeng Wang wrote:
> > > > > > > 
> > > > > > >            I tested this patchset(plus arm32 change, like arm64 does)
> > > > > > >            based on lts 5.10，add some debug log, the useful info shows
> > > > > > >            below, if we enable HOLES_IN_ZONE, no panic, any idea,
> > > > > > >            thanks.
> > > > > > > 
> > > > > > >        Are there any changes on top of 5.10 except for pfn_valid() patch?
> > > > > > >        Do you see this panic on 5.10 without the changes?
> > > > > > > 
> > > > > > > Yes, there are some BSP support for arm board based on 5.10,
> > > > Is it possible to test 5.12?
> > Do you use SPARSMEM? If yes, what is your section size?
> > What is the value if CONFIG_FORCE_MAX_ZONEORDER in your configuration?
> 
> Yes,
> 
> CONFIG_SPARSEMEM=y
> 
> CONFIG_SPARSEMEM_STATIC=y
> 
> CONFIG_FORCE_MAX_ZONEORDER = 11
> 
> CONFIG_PAGE_OFFSET=0xC0000000
> CONFIG_HAVE_ARCH_PFN_VALID=y
> CONFIG_HIGHMEM=y
> #define SECTION_SIZE_BITS    26
> #define MAX_PHYSADDR_BITS    32
> #define MAX_PHYSMEM_BITS     32

It seems that with SPARSEMEM we don't align the freed parts on pageblock
boundaries.

Can you try the patch below:

diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..1926369b52ec 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1941,14 +1941,13 @@ static void __init free_unused_memmap(void)
 		 * due to SPARSEMEM sections which aren't present.
 		 */
 		start = min(start, ALIGN(prev_end, PAGES_PER_SECTION));
-#else
+#endif
 		/*
 		 * Align down here since the VM subsystem insists that the
 		 * memmap entries are valid from the bank start aligned to
 		 * MAX_ORDER_NR_PAGES.
 		 */
 		start = round_down(start, MAX_ORDER_NR_PAGES);
-#endif
 
 		/*
 		 * If we had a previous bank, and there is a space
 

-- 
Sincerely yours,
Mike.
