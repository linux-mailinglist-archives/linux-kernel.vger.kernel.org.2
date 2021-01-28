Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645D3306BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhA1EH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhA1EGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:06:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C675FC061351
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 19:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qvk4AgnXCmj12XxrrvtAiERhPKsHZ9TYHC+e/qoNEdg=; b=xDja0sL3uytwsMyncVkVw4ukog
        M4Bi+6Sp9tFmI0N6m8JtzFZk+hgoDfvDmqjiesGpWqMCPlEgOykMeu9RxD9wKsUKZ0ALbgpCXKAQz
        C+zlfvkWC+1Ygcsb0AWxhGfUKpf1Ti936z87rjEigrIQxjgxph9ucRJ1baJ6/D+CGlBBi/eA4fXrn
        +ZcPj5WPhODX/C30UyIYKJ7oLBsiI/euBmbvsFyE240SoyTLWrQrOTYCINnNSFp8TmZA9ct8pFQJM
        qnCxn2Z2lT0xfoTa8McS/W4STlG1QEKgC4VD7bKMCZSljtA7pyI4jhjGv4gbmB5z3ZfhGHvIk2yoj
        /NiqEI2w==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4yPD-0006xU-84; Thu, 28 Jan 2021 03:55:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH] arch_numa: fix common code printing of phys_addr_t
Date:   Wed, 27 Jan 2021 19:55:33 -0800
Message-Id: <20210128035533.23722-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warnings in the arch_numa common code:

../include/linux/kern_levels.h:5:18: warning: format '%Lx' expects argument of type 'long long unsigned int', but argument 3 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
../drivers/base/arch_numa.c:360:56: note: format string is defined here
  360 |    pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
../drivers/base/arch_numa.c:435:39: note: format string is defined here
  435 |  pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n", start, end - 1);

Fixes: ae3c107cd8be ("numa: Move numa implementation to common code")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/base/arch_numa.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- linux-next-20210125.orig/drivers/base/arch_numa.c
+++ linux-next-20210125/drivers/base/arch_numa.c
@@ -355,11 +355,12 @@ static int __init numa_register_nodes(vo
 	/* Check that valid nid is set to memblks */
 	for_each_mem_region(mblk) {
 		int mblk_nid = memblock_get_region_node(mblk);
+		phys_addr_t start = mblk->base;
+		phys_addr_t end = mblk->base + mblk->size - 1;
 
 		if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
-			pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
-				mblk_nid, mblk->base,
-				mblk->base + mblk->size - 1);
+			pr_warn("Warning: invalid memblk node %d [mem %pap-%pap]\n",
+				mblk_nid, &start, &end);
 			return -EINVAL;
 		}
 	}
@@ -427,14 +428,14 @@ out_free_distance:
 static int __init dummy_numa_init(void)
 {
 	phys_addr_t start = memblock_start_of_DRAM();
-	phys_addr_t end = memblock_end_of_DRAM();
+	phys_addr_t end = memblock_end_of_DRAM() - 1;
 	int ret;
 
 	if (numa_off)
 		pr_info("NUMA disabled\n"); /* Forced off on command line. */
-	pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n", start, end - 1);
+	pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
 
-	ret = numa_add_memblk(0, start, end);
+	ret = numa_add_memblk(0, start, end + 1);
 	if (ret) {
 		pr_err("NUMA init failed\n");
 		return ret;
