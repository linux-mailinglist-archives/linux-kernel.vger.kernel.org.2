Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90C4360C18
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhDOOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:45:11 -0400
Received: from 8bytes.org ([81.169.241.247]:35100 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232774AbhDOOpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:45:09 -0400
Received: from lemmy.home.8bytes.org (p549adcf6.dip0.t-ipconnect.de [84.154.220.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 5EB9415C;
        Thu, 15 Apr 2021 16:44:45 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iommu/fsl-pamu: Fix uninitialized variable warning
Date:   Thu, 15 Apr 2021 16:44:42 +0200
Message-Id: <20210415144442.25103-1-joro@8bytes.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The variable 'i' in the function update_liodn_stash() is not
initialized and only used in a debug printk(). So it has no
meaning at all, remove it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/fsl_pamu_domain.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 32944d67baa4..0ac781186dbd 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -57,14 +57,13 @@ static int __init iommu_init_mempool(void)
 static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
 			      u32 val)
 {
-	int ret = 0, i;
+	int ret = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&iommu_lock, flags);
 	ret = pamu_update_paace_stash(liodn, val);
 	if (ret) {
-		pr_debug("Failed to update SPAACE %d field for liodn %d\n ",
-			 i, liodn);
+		pr_debug("Failed to update SPAACE for liodn %d\n ", liodn);
 		spin_unlock_irqrestore(&iommu_lock, flags);
 		return ret;
 	}
-- 
2.30.2

