Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA4B37AD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhEKRmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhEKRmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:42:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F355F611C9;
        Tue, 11 May 2021 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620754905;
        bh=p5pl8VglhLEAnmwX/+IRaXV2EP7T6wfDyOXKKS7PxLw=;
        h=From:To:Cc:Subject:Date:From;
        b=mhCoF0FWPfPN/PDmOQMAitbT9aqlzHlYF/CtyR12btuCdKbmhihNy25BWkvz8BxGC
         6KF9qc8MTe7+Lj+KmpO4FiedIpwSdO+7cGDubiXTrRNiBvkHNAjoXH+c+OZWYxHgMx
         zQ6Sa3KprdTvbEZ9cnC1Kd7x5J/UsZAesiExc1I3mMl8N38992qENw+lLIerKXlsc8
         WUpCBHf4OSTqThh+Iqd1iOapZrAOZatdglTIFNNjebFhOa21pjHlInh6WqQVbYMcT+
         ZKUvjiDXcBrFeMTAMietHC2IqN4pYaxwxClDfIGjMxlZBYJ231GhwkxrL1qt3b/UDL
         qmDo1+MQvlh8w==
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     xen-devel@lists.xenproject.org
Cc:     sstabellini@kernel.org, hch@lst.de, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] xen/arm64: do not set SWIOTLB_NO_FORCE when swiotlb is required
Date:   Tue, 11 May 2021 10:41:41 -0700
Message-Id: <20210511174142.12742-1-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

Although SWIOTLB_NO_FORCE is meant to allow later calls to swiotlb_init,
today dma_direct_map_page returns error if SWIOTLB_NO_FORCE.

For now, without a larger overhaul of SWIOTLB_NO_FORCE, the best we can
do is to avoid setting SWIOTLB_NO_FORCE in mem_init when we know that it
is going to be required later (e.g. Xen requires it).

To make xen_swiotlb_detect available to !CONFIG_XEN builds, move it to a
static inline function.

CC: boris.ostrovsky@oracle.com
CC: jgross@suse.com
CC: catalin.marinas@arm.com
CC: will@kernel.org
CC: linux-arm-kernel@lists.infradead.org
Fixes: 2726bf3ff252 ("swiotlb: Make SWIOTLB_NO_FORCE perform no allocation")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---
 arch/arm/xen/mm.c             | 12 ------------
 arch/arm64/mm/init.c          |  3 ++-
 include/xen/arm/swiotlb-xen.h | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index f8f07469d259..223b1151fd7d 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -135,18 +135,6 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 	return;
 }
 
-int xen_swiotlb_detect(void)
-{
-	if (!xen_domain())
-		return 0;
-	if (xen_feature(XENFEAT_direct_mapped))
-		return 1;
-	/* legacy case */
-	if (!xen_feature(XENFEAT_not_direct_mapped) && xen_initial_domain())
-		return 1;
-	return 0;
-}
-
 static int __init xen_mm_init(void)
 {
 	struct gnttab_cache_flush cflush;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 16a2b2b1c54d..e55409caaee3 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -43,6 +43,7 @@
 #include <linux/sizes.h>
 #include <asm/tlb.h>
 #include <asm/alternative.h>
+#include <asm/xen/swiotlb-xen.h>
 
 /*
  * We need to be able to catch inadvertent references to memstart_addr
@@ -482,7 +483,7 @@ void __init mem_init(void)
 	if (swiotlb_force == SWIOTLB_FORCE ||
 	    max_pfn > PFN_DOWN(arm64_dma_phys_limit))
 		swiotlb_init(1);
-	else
+	else if (!xen_swiotlb_detect())
 		swiotlb_force = SWIOTLB_NO_FORCE;
 
 	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
diff --git a/include/xen/arm/swiotlb-xen.h b/include/xen/arm/swiotlb-xen.h
index 2994fe6031a0..33336ab58afc 100644
--- a/include/xen/arm/swiotlb-xen.h
+++ b/include/xen/arm/swiotlb-xen.h
@@ -2,6 +2,19 @@
 #ifndef _ASM_ARM_SWIOTLB_XEN_H
 #define _ASM_ARM_SWIOTLB_XEN_H
 
-extern int xen_swiotlb_detect(void);
+#include <xen/features.h>
+#include <xen/xen.h>
+
+static inline int xen_swiotlb_detect(void)
+{
+	if (!xen_domain())
+		return 0;
+	if (xen_feature(XENFEAT_direct_mapped))
+		return 1;
+	/* legacy case */
+	if (!xen_feature(XENFEAT_not_direct_mapped) && xen_initial_domain())
+		return 1;
+	return 0;
+}
 
 #endif /* _ASM_ARM_SWIOTLB_XEN_H */
-- 
2.17.1

