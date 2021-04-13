Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4135E73E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348084AbhDMTrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242249AbhDMTrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:47:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233DFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oEFp9oGvZ6I7WinWmnB+A7S0Z09gh1JWVMa9yxM84sg=; b=bS9I+q7kiWT1NzIv1yWFEMXJF/
        x/Syia9IoTE1ssQxeowX47W4cnMwsZB6TiG4bCkeSJcxmuLk5FF8X3Af7cleJsofkMRbhl+xXsCyJ
        3IBD+ZysmU+c7sQX1dLQsN7JN/MWh1EAWsogqxB+XphexbQlaD4F0AhT8Fm5vaY6Y5DlBzhBeZGA+
        6vDWf81wn/a0/kFG36vbLbzlQZwBLCszP0yBQ9DQ+lb7MbFDfiHwkJVCHu6Q2WMz4UWeZIJHSW09+
        B7zcjgDE1/UWpWuPkstt0ig2WmoUHwEzDEb7qP8QXILV2HHr29Ltlsw3oihSNPJ/Ag/6vXPuyYPqG
        xCalSiHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWOzX-006BHL-16; Tue, 13 Apr 2021 19:46:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Douglas Gilbert <dougg@torque.net>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] mm: Optimise nth_page for contiguous memmap
Date:   Tue, 13 Apr 2021 20:46:25 +0100
Message-Id: <20210413194625.1472345-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memmap is virtually contiguous (either because we're using
a virtually mapped memmap or because we don't support a discontig
memmap at all), then we can implement nth_page() by simple addition.
Contrary to popular belief, the compiler is not able to optimise this
itself for a vmemmap configuration.  This reduces one example user (sg.c)
by four instructions:

        struct page *page = nth_page(rsv_schp->pages[k], offset >> PAGE_SHIFT);

before:
   49 8b 45 70             mov    0x70(%r13),%rax
   48 63 c9                movslq %ecx,%rcx
   48 c1 eb 0c             shr    $0xc,%rbx
   48 8b 04 c8             mov    (%rax,%rcx,8),%rax
   48 2b 05 00 00 00 00    sub    0x0(%rip),%rax
           R_X86_64_PC32      vmemmap_base-0x4
   48 c1 f8 06             sar    $0x6,%rax
   48 01 d8                add    %rbx,%rax
   48 c1 e0 06             shl    $0x6,%rax
   48 03 05 00 00 00 00    add    0x0(%rip),%rax
           R_X86_64_PC32      vmemmap_base-0x4

after:
   49 8b 45 70             mov    0x70(%r13),%rax
   48 63 c9                movslq %ecx,%rcx
   48 c1 eb 0c             shr    $0xc,%rbx
   48 c1 e3 06             shl    $0x6,%rbx
   48 03 1c c8             add    (%rax,%rcx,8),%rbx

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 25b9041f9925..2327f99b121f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -234,7 +234,11 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 		pgoff_t index, gfp_t gfp, void **shadowp);
 
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
+#else
+#define nth_page(page,n) ((page) + (n))
+#endif
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
-- 
2.30.2

