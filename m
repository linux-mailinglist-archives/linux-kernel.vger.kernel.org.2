Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B20E3874B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347758AbhERJH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347783AbhERJHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:07:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34AC86108D;
        Tue, 18 May 2021 09:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621328786;
        bh=8S/jBfuQqPw5Y9SjeyOmElG9wuJ/AnCGL+Y38mTgWSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiPSzD3EHlwQp2twmDYDpgwIJ+zYdl24Jne4bvdQbA/dO2SFfZoDD0RBu/OB1oFBM
         Gnzin6LGBxpmo/uJqT0ZQtLQReJHKqBVUUfi/dCG8iL5c/miJdVGl7ZtN2BaswRMfM
         dwJsiZvxb3ObGV60edfQNhVqmbHcZ0GLl5gmqUja1gSsVkCalkXG1yeKLSGeDQWt33
         +YRwhxPRnSYIFoviTH0GkegVHUEAxDVqo3siMMTcm84PHk3AYo8BbvCuIi1v08B2Jj
         plXqKlFXodC8Z54ua1hfiYSBgglKyKY7yd5B2gBNZfsLbz1YH3LGwFwP3R+x2ZXFXM
         nFXFz2y5tzF3Q==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/3] memblock: align freed memory map on pageblock boundaries with SPARSEMEM
Date:   Tue, 18 May 2021 12:06:12 +0300
Message-Id: <20210518090613.21519-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210518090613.21519-1-rppt@kernel.org>
References: <20210518090613.21519-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

When CONFIG_SPARSEMEM=y the ranges of the memory map that are freed are not
aligned to the pageblock boundaries which breaks assumptions about
homogeneity of the memory map throughout core mm code.

Make sure that the freed memory map is always aligned on pageblock
boundaries regardless of the memory model selection.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memblock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 97fa87541b5f..2e25d69739e0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1941,14 +1941,13 @@ static void __init free_unused_memmap(void)
 		 * due to SPARSEMEM sections which aren't present.
 		 */
 		start = min(start, ALIGN(prev_end, PAGES_PER_SECTION));
-#else
+#endif
 		/*
 		 * Align down here since many operations in VM subsystem
 		 * presume that there are no holes in the memory map inside
 		 * a pageblock
 		 */
 		start = round_down(start, pageblock_nr_pages);
-#endif
 
 		/*
 		 * If we had a previous bank, and there is a space
@@ -1966,8 +1965,10 @@ static void __init free_unused_memmap(void)
 	}
 
 #ifdef CONFIG_SPARSEMEM
-	if (!IS_ALIGNED(prev_end, PAGES_PER_SECTION))
+	if (!IS_ALIGNED(prev_end, PAGES_PER_SECTION)) {
+		prev_end = ALIGN(end, pageblock_nr_pages);
 		free_memmap(prev_end, ALIGN(prev_end, PAGES_PER_SECTION));
+	}
 #endif
 }
 
-- 
2.28.0

