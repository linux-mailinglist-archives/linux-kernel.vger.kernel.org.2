Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD7D407413
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhIJXzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:55:40 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:47383 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232897AbhIJXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:55:39 -0400
Received: from MTA-15-3.privateemail.com (MTA-15-1.privateemail.com [198.54.118.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 945EE829C2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 19:54:26 -0400 (EDT)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
        by mta-15.privateemail.com (Postfix) with ESMTP id 2C61B18000B2;
        Fri, 10 Sep 2021 19:54:25 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.209])
        by mta-15.privateemail.com (Postfix) with ESMTPA id 4FAAF18000A3;
        Fri, 10 Sep 2021 19:54:24 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2] dma-debug: prevent an error message from causing runtime problems
Date:   Fri, 10 Sep 2021 19:53:37 -0400
Message-Id: <20210910235337.13172-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some drivers, that use the DMA API. This error message can be reached
several millions of times per second, causing spam to the kernel's printk
buffer and bringing the CPU usage up to 100% (so, it should be rate
limited). However, since there is at least one driver that is in the
mainline and suffers from the error condition, it is more useful to
err_printk() here instead of just rate limiting the error message (in hopes
that it will make it easier for other drivers that suffer from this issue
to be spotted).

Link: https://lkml.kernel.org/r/fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
v2: use err_printk() and make some clarifications in the commit message.
---
 kernel/dma/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 6c90c69e5311..718a7f455df6 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -567,7 +567,8 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
 	} else if (rc == -EEXIST) {
-		pr_err("cacheline tracking EEXIST, overlapping mappings aren't supported\n");
+		err_printk(entry->dev, entry, "cacheline tracking EEXIST, "
+			   "overlapping mappings aren't supported\n");
 	}
 }
 
-- 
2.33.0

