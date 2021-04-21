Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B41366BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbhDUNEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240537AbhDUNDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC6B26144B;
        Wed, 21 Apr 2021 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010202;
        bh=s+XpiWC2iSLw9hZxfJZYI1ni1c/CY2Y1Js+SRzvs2dI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EltPdJn6DCUnFR9D4kFx5S5Dhgk97VnC/N/YsyaLJpSc0XiZtG8136+f0IJUZ2qx4
         JSIMEW01REUCbxddQfwOfxTKmmp6sUnbKnRqh5vXC+iFXrPBU/h9HhsTNvidQ7ZF0X
         kukOBG/3SRECrZM2ed0c2Iipkp2oD0sGlHWn40Sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 049/190] Revert "agp/intel: Fix a memory leak on module initialisation failure"
Date:   Wed, 21 Apr 2021 14:58:44 +0200
Message-Id: <20210421130105.1226686-50-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b975abbd382fe442713a4c233549abb90e57c22b.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: https
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/agp/intel-gtt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index 5bfdf222d5f9..4b34a5195c65 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -304,10 +304,8 @@ static int intel_gtt_setup_scratch_page(void)
 	if (intel_private.needs_dmar) {
 		dma_addr = pci_map_page(intel_private.pcidev, page, 0,
 				    PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-		if (pci_dma_mapping_error(intel_private.pcidev, dma_addr)) {
-			__free_page(page);
+		if (pci_dma_mapping_error(intel_private.pcidev, dma_addr))
 			return -EINVAL;
-		}
 
 		intel_private.scratch_page_dma = dma_addr;
 	} else
-- 
2.31.1

