Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D3D3C69F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 07:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhGMFzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 01:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhGMFzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:55:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D40C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 22:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=d8q66gZVOpTmMdIc6dC+FZOKYvaRSFF6AtytyOW/st0=; b=jIxUPdAEFPmCu55gfoYLZDhxkp
        /d9LbXp8yp6IYRhraQRpyhV+vKVymM35vehxoN+ZyuSAi+PaBSO19h4JulUBCkB6R1PNaGWdkpQAj
        JV1s3FuKQ7Cadgdkq38+iecc869DxbHovvRI+tW7UO1TBUZppiXg05m2vDe6NLXTLB584kiDUoSBM
        rEE+Kaf5MsYfqo1qE3puB+T9FZ3jO0OVbMyZdV5Z0CgfFrBMdtrsdHELacHWd+L7K1G0SVigXj9xj
        Q1V5El41xtQttd1+KU5psKdd2V2l+wfSuWrkqhitRYXiIRpbZ42eCsV7TuRhKx1O4mMkr52VCeJWR
        ZcuBlXkw==;
Received: from [2001:4bb8:184:8b7c:e5e6:2d8f:6506:596e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3BLU-000mbL-QU; Tue, 13 Jul 2021 05:52:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/2] mm: use kmap_local_page in memzero_page
Date:   Tue, 13 Jul 2021 07:52:31 +0200
Message-Id: <20210713055231.137602-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713055231.137602-1-hch@lst.de>
References: <20210713055231.137602-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit message introducing the global memzero_page explicitly
mentions switching to kmap_local_page in the commit log but doesn't
actually do that.

Fixes: 28961998f858 ("iov_iter: lift memzero_page() to highmem.h")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/highmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 8e7e50a53a12..d9a606a9fc64 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -324,10 +324,10 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
 
 static inline void memzero_page(struct page *page, size_t offset, size_t len)
 {
-	char *addr = kmap_atomic(page);
+	char *addr = kmap_local_page(page);
 	memset(addr + offset, 0, len);
 	flush_dcache_page(page);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 }
 
 #endif /* _LINUX_HIGHMEM_H */
-- 
2.30.2

