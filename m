Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2620B38794D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhERM47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:56:59 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:60773 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349416AbhERM4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:56:49 -0400
Received: from MTA-06-3.privateemail.com (mta-06.privateemail.com [68.65.122.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id A97B5800BD
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:55:30 -0400 (EDT)
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
        by MTA-06.privateemail.com (Postfix) with ESMTP id 354876005B;
        Tue, 18 May 2021 08:55:29 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.225])
        by MTA-06.privateemail.com (Postfix) with ESMTPA id 6B7516005F;
        Tue, 18 May 2021 08:55:28 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Hamza Mahfooz <someguy@effective-light.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] dma debug: report -EEXIST errors in add_dma_entry
Date:   Tue, 18 May 2021 08:54:43 -0400
Message-Id: <20210518125443.34148-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since, overlapping mappings are not supported by the DMA API we should
report an error if active_cacheline_insert returns -EEXIST.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 kernel/dma/debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 14de1271463f..dadae6255d05 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -566,11 +566,9 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 	if (rc == -ENOMEM) {
 		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
+	} else if (rc == -EEXIST) {
+		pr_err("cacheline tracking EEXIST, overlapping mappings aren't supported\n");
 	}
-
-	/* TODO: report -EEXIST errors here as overlapping mappings are
-	 * not supported by the DMA API
-	 */
 }
 
 static int dma_debug_create_entries(gfp_t gfp)
-- 
2.31.1

