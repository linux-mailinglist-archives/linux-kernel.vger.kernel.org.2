Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB06644D579
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhKKLFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhKKLFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:05:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42236610D2;
        Thu, 11 Nov 2021 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636628569;
        bh=oDx5eipT9nr35wDXdRGiSymFWGUPXUqTCMJshmLK7eM=;
        h=From:To:Cc:Subject:Date:From;
        b=rmzAqjGZwv+E7BKtpmQJZ3SrWs7kjB2A3pQmJELfV9HMiD7Sg17r2e7adQk556h7z
         yU/velJL5DN3fIlxSLyCC3AC1rD5EKSY86cPlIe0GDyuEOWZ1D8Pkr41xYLoNOP965
         tkLAGj5jNwNr53teOxaacSRNkD13JaPo0+A1aynb/RghVlEvxrTs29xipsw8gfdVJB
         mVjaftbOtwOBj8b/uKhmF900MHDDh/RU8M/zn84OIma5YCcTapm84qoqmcvG8sFvxx
         xQdsIMwzfAPCKqGGgrWi3T6baZ4kw5ZHkNQHBFBw61ahru25XoGfwsiRNn1KqmOI92
         NYRFgXAn28Jqg==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] x86/mm: replace GFP_ATOMIC with GFP_KERNEL for direct map allocations
Date:   Thu, 11 Nov 2021 13:02:37 +0200
Message-Id: <20211111110241.25968-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

The direct map pages on x86 that are allocated using alloc_low_pages() and
spp_getpage() functions. When these functions take 'after_bootmem' branch,
the memory is allocated from buddy with GFP_ATOMIC and I could not find any
reason for this.

Since most of the kernel page tables are anyway allocated really early,
only GART IOMMU initialization and memory hotplug would actually use
get_free_pages() to allocate direct map entries and neither of them happen
in an atomic context, so it would be fine to use GFP_KERNEL. This will give
the page allocator more flexibility when memory hotplug creates the direct
map for hot-added memory and won't use precious atomic memory resources.

The first three patches are trivial cleanups I've encountered while
analysing call paths of alloc_low_pages() and spp_getpage() and the fourth
patch actually replaces GFP_ATOMIC with GFP_KERNEL in those functions.

Mike Rapoport (4):
  x86/mm: make init_trampoline_kaslr() __init
  x86/mm: make kernel_physical_mapping_change() __init
  x86/mm: init_64: make set_pte_vaddr_p4d static
  x86/mm: replace GFP_ATOMIC with GFP_KERNEL for direct map allocations

 arch/x86/include/asm/pgtable_64.h | 1 -
 arch/x86/mm/init.c                | 2 +-
 arch/x86/mm/init_64.c             | 7 ++++---
 arch/x86/mm/kaslr.c               | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)


base-commit: d2f38a3c6507b2520101f9a3807ed98f1bdc545a
-- 
2.28.0

