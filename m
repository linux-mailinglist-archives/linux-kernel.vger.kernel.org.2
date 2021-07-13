Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4331F3C69EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 07:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhGMFzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 01:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhGMFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:55:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67440C0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 22:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zp53bommybp1pk8ZrcPSSkhx3IAKKWZGzNvK/RyWeR0=; b=dcklGLuH/tB3sRJG6nd0c8BFWh
        VT5aqHFrCB6W1Hsv/Mi4HNEhcZ6CGseY2EXexBSNuphOkV+25bEBLg3H3UwxB8plA/yfBx87/imtu
        9/N4DHy5sGRxFl2f3zcigHtc4bbHlpmSoQf0NjBp0LSv4z1D7f26rwrCcUoACx83M3hJIdG9SDdvF
        zmA8Fe7BY9LwIyMrtS9c/5Tg9LBam9Rf8GzS+0BCb5q3OIL5V/wzNPvXkxK2Qb/5HumbxxXhqr4iy
        JytL/aq4PoyynRtDUaZtiXUmrzOLfRf1LI8b5R/8JaoK3ySgE5HkwJkG0QYuw81uT2DxRklOQ1ihr
        cqaGSXpQ==;
Received: from [2001:4bb8:184:8b7c:e5e6:2d8f:6506:596e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3BLS-000mbI-Hs; Tue, 13 Jul 2021 05:52:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] mm: call flush_dcache_page in memcpy_to_page and memzero_page
Date:   Tue, 13 Jul 2021 07:52:30 +0200
Message-Id: <20210713055231.137602-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713055231.137602-1-hch@lst.de>
References: <20210713055231.137602-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcpy_to_page and memzero_page can write to arbitrary pages, which could
be in the page cache or in high memory, so  call flush_kernel_dcache_pages
to flush the dcache.

Fixes: bb90d4bc7b6a ("mm/highmem: Lift memcpy_[to|from]_page to core")
Fixes: 28961998f858 ("iov_iter: lift memzero_page() to highmem.h")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/highmem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 8c6e8e996c87..8e7e50a53a12 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -318,6 +318,7 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
 
 	VM_BUG_ON(offset + len > PAGE_SIZE);
 	memcpy(to + offset, from, len);
+	flush_dcache_page(page);
 	kunmap_local(to);
 }
 
@@ -325,6 +326,7 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
 {
 	char *addr = kmap_atomic(page);
 	memset(addr + offset, 0, len);
+	flush_dcache_page(page);
 	kunmap_atomic(addr);
 }
 
-- 
2.30.2

