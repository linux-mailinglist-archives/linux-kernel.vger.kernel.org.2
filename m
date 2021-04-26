Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D025736B4BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhDZOUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233792AbhDZOUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:20:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3BA56101C;
        Mon, 26 Apr 2021 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619446782;
        bh=/Q3C+Yf/LH5vmVHv0+NtFuLk/XJ/KpuX0JQvBT1NiDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfFZC1sTriLI2UHnZdynbjCvY3wZY+lTDlPwmRsNvkQ8D1gn8m53T7X/0WltGXx+l
         Z6LfX0gv+b4UWHf0wo9b1Po4B3G1pveAavsVfpBDNs24uU4BFHkZ1f7clX0foRVWQy
         O+EbcD0OwmDFztxIbY8WZ2Vo3JCrkkJ2WSc+ULA1zxEIlZ4QGbCsCZBHyfIAE/L8Zo
         DPH9ws/Uka4LoigEg40qzdLwWt5BjBKBVl0n74JycZSMz3Ef+f/NDga/3NsNogthMd
         YZqMtfc/FY9xh6mBuPTvOa6OOU867I+ZSSDCJyHInarXcEGgVr/SLvRGn2Gno+GfVW
         yS9jJRl982wiA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/2] mm/mmzone.h: simplify is_highmem_idx()
Date:   Mon, 26 Apr 2021 17:19:27 +0300
Message-Id: <20210426141927.1314326-3-rppt@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210426141927.1314326-1-rppt@kernel.org>
References: <20210426141927.1314326-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There is a lot of historical ifdefery in is_highmem_idx() and its helper
zone_movable_is_highmem() that was required because of two different paths
for nodes and zones initialization that were selected at compile time.

Until commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP
option") the movable_zone variable was only available for configurations
that had CONFIG_HAVE_MEMBLOCK_NODE_MAP enabled so the test in
zone_movable_is_highmem() used that variable only for such configurations.
For other configurations the test checked if the index of ZONE_MOVABLE was
greater by 1 than the index of ZONE_HIGMEM and then movable zone was
considered a highmem zone. Needless to say, ZONE_MOVABLE - 1 equals
ZONE_HIGHMEM by definition when CONFIG_HIGHMEM=y.

Commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
made movable_zone variable always available. Since this variable is set to
ZONE_HIGHMEM if CONFIG_HIGHMEM is enabled and highmem zone is populated, it
is enough to check whether

	zone_idx == ZONE_MOVABLE && movable_zone == ZONE_HIGMEM

to test if zone index points to a highmem zone.

Remove zone_movable_is_highmem() that is not used anywhere except
is_highmem_idx() and use the test above in is_highmem_idx() instead.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mmzone.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0d53eba1c383..c2bfefd34b59 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -982,22 +982,11 @@ static inline void zone_set_nid(struct zone *zone, int nid) {}
 
 extern int movable_zone;
 
-#ifdef CONFIG_HIGHMEM
-static inline int zone_movable_is_highmem(void)
-{
-#ifdef CONFIG_NEED_MULTIPLE_NODES
-	return movable_zone == ZONE_HIGHMEM;
-#else
-	return (ZONE_MOVABLE - 1) == ZONE_HIGHMEM;
-#endif
-}
-#endif
-
 static inline int is_highmem_idx(enum zone_type idx)
 {
 #ifdef CONFIG_HIGHMEM
 	return (idx == ZONE_HIGHMEM ||
-		(idx == ZONE_MOVABLE && zone_movable_is_highmem()));
+		(idx == ZONE_MOVABLE && movable_zone == ZONE_HIGHMEM));
 #else
 	return 0;
 #endif
-- 
2.29.2

