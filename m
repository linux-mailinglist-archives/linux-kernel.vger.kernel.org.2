Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E00349CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 00:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhCYXgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 19:36:06 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:60036 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231264AbhCYXfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 19:35:38 -0400
Received: by sf.home (Postfix, from userid 1000)
        id 823765A22061; Thu, 25 Mar 2021 23:35:33 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>
Subject: [PATCH] ia64: simplify code flow around swiotlb init
Date:   Thu, 25 Mar 2021 23:35:30 +0000
Message-Id: <20210325233530.1397011-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the change CONFIG_INTEL_IOMMU && !CONFIG_SWIOTLB && !CONFIG_FLATMEM

could skip `set_max_mapnr(max_low_pfn);` is iommu is not present on system.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-ia64@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/mm/init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 16d0d7d22657..a63585db94fe 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -644,13 +644,16 @@ mem_init (void)
 	 * _before_ any drivers that may need the PCI DMA interface are
 	 * initialized or bootmem has been freed.
 	 */
+	do {
 #ifdef CONFIG_INTEL_IOMMU
-	detect_intel_iommu();
-	if (!iommu_detected)
+		detect_intel_iommu();
+		if (iommu_detected)
+			break;
 #endif
 #ifdef CONFIG_SWIOTLB
 		swiotlb_init(1);
 #endif
+	} while (0);
 
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
-- 
2.31.0

