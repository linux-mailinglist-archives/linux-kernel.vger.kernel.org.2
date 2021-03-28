Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE034BEDF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhC1UZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 16:25:03 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:36330 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhC1UYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 16:24:54 -0400
Received: by sf.home (Postfix, from userid 1000)
        id 8C4745A22061; Sun, 28 Mar 2021 21:24:46 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        inux-ia64@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-ia64@vger.kernel.org
Subject: [PATCH v2] ia64: simplify code flow around swiotlb init
Date:   Sun, 28 Mar 2021 21:24:39 +0100
Message-Id: <20210328202439.403601-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d0f37f22-1d2a-50f5-886b-5e4b9892b921@physik.fu-berlin.de>
References: <d0f37f22-1d2a-50f5-886b-5e4b9892b921@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the change CONFIG_INTEL_IOMMU && !CONFIG_SWIOTLB && !CONFIG_FLATMEM
could skip `set_max_mapnr(max_low_pfn);` if iommu is not present on system.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
CC: linux-ia64@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
Change since v1: fixed a typo in commit mesage.

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
2.31.1

