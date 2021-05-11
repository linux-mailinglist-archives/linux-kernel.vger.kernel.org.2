Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2B37AD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhEKRm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231502AbhEKRmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:42:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB623613C3;
        Tue, 11 May 2021 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620754906;
        bh=/y24nuaxa3ahuPNyDsX+pUzlA7FV7W7+VmIh+phhWv4=;
        h=From:To:Cc:Subject:Date:From;
        b=aLZ+AS1gA5cMZ8RVBKoIqDIZcfszquu/ab7Ff6SE7rkRnIPa1yGD2Wv1/kGeFyZ2s
         KTKehYlE2EUwCF9G4rnoyYlJ7fZKBBdXEwh0VBqARwd8gn0iA0AUJcR8NWIxsiD36S
         hnENri5ucimFD/OOKF3SQJ3xLPKR7GMFxJr0mH5IYSAhPVEgIJlYKyxepqOeINvD6B
         hbzLGO4L4D/Vzw2gjBofuadHnoqU0rF5Vn+NF0QYlcYB2fM0CVcCtM2y9eg5oROn8G
         X2w6XtAJQagQb7QGiiHjRpxbG3HmR9xROVxxsx5qW0OHbSO3sp4gcYF5EfVvEemxZA
         cpgazArg1UgDA==
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     xen-devel@lists.xenproject.org
Cc:     sstabellini@kernel.org, hch@lst.de, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com
Subject: [PATCH 2/2] xen/swiotlb: check if the swiotlb has already been initialized
Date:   Tue, 11 May 2021 10:41:42 -0700
Message-Id: <20210511174142.12742-2-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

xen_swiotlb_init calls swiotlb_late_init_with_tbl, which fails with
-ENOMEM if the swiotlb has already been initialized.

Add an explicit check io_tlb_default_mem != NULL at the beginning of
xen_swiotlb_init. If the swiotlb is already initialized print a warning
and return -EEXIST.

On x86, the error propagates.

On ARM, we don't actually need a special swiotlb buffer (yet), any
buffer would do. So ignore the error and continue.

CC: boris.ostrovsky@oracle.com
CC: jgross@suse.com
Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---
 arch/arm/xen/mm.c         | 8 +++++++-
 drivers/xen/swiotlb-xen.c | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 223b1151fd7d..a7e54a087b80 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -138,9 +138,15 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 static int __init xen_mm_init(void)
 {
 	struct gnttab_cache_flush cflush;
+	int rc;
+
 	if (!xen_swiotlb_detect())
 		return 0;
-	xen_swiotlb_init();
+
+	rc = xen_swiotlb_init();
+	/* we can work with the default swiotlb */
+	if (rc < 0 && rc != -EEXIST)
+		return rc;
 
 	cflush.op = 0;
 	cflush.a.dev_bus_addr = 0;
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 4c89afc0df62..6412d59ce7f8 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -164,6 +164,11 @@ int __ref xen_swiotlb_init(void)
 	int rc = -ENOMEM;
 	char *start;
 
+	if (io_tlb_default_mem != NULL) {
+		printk(KERN_WARNING "Xen-SWIOTLB: swiotlb buffer already initialized\n");
+		return -EEXIST;
+	}
+
 retry:
 	m_ret = XEN_SWIOTLB_ENOMEM;
 	order = get_order(bytes);
-- 
2.17.1

