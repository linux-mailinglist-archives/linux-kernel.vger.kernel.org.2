Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CE6406B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhIJMHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:07:12 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:43104 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232873AbhIJMHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:07:11 -0400
Received: from MTA-13-3.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 3445F80C6B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 08:05:59 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id D2EE2180016B;
        Fri, 10 Sep 2021 08:05:57 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.212])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 0068B180015C;
        Fri, 10 Sep 2021 08:05:56 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH] dma-debug: prevent an error message from causing runtime problems
Date:   Fri, 10 Sep 2021 08:05:41 -0400
Message-Id: <20210910120541.39938-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some drivers, that call add_dma_entry() from somewhere down the call
stack. If this error condition is triggered once, it causes the error
message to spam the kernel's printk buffer and bring the CPU usage up to
100%. Also, since there is at least one driver that is in the mainline
and suffers from the error condition, it is more useful to WARN_ON() here
instead of just printing the error message (in hopes that it will make it
easier for other drivers that suffer from this issue to be spotted).

Link: https://lkml.kernel.org/r/fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 kernel/dma/debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 6c90c69e5311..d9806689666e 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -567,7 +567,9 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
 	} else if (rc == -EEXIST) {
-		pr_err("cacheline tracking EEXIST, overlapping mappings aren't supported\n");
+		WARN_ONCE(1,
+			  pr_fmt("cacheline tracking EEXIST, overlapping mappings aren't supported\n"
+			 ));
 	}
 }
 
-- 
2.33.0

