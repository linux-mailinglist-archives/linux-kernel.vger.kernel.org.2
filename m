Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82C3728BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhEDKXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 06:23:38 -0400
Received: from mail.ispras.ru ([83.149.199.84]:53442 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230153AbhEDKXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 06:23:36 -0400
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id E84804076B3A;
        Tue,  4 May 2021 10:22:38 +0000 (UTC)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org
Subject: [RESEND PATCH v2] iommu/amd: Fix extended features logging
Date:   Tue,  4 May 2021 13:22:20 +0300
Message-Id: <20210504102220.1793-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

print_iommu_info prints the EFR register and then the decoded list of
features on a separate line:

pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
 PPR X2APIC NX GT IA GA PC GA_vAPIC

The second line is emitted via 'pr_cont', which causes it to have a
different ('warn') loglevel compared to the previous line ('info').

Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
from the pci_info format string, but this doesn't work, as pci_info
calls implicitly append a newline anyway.

Printing the decoded features on the same line would make it quite long.
Instead, change pci_info() to pr_info() to omit PCI bus location info,
which is also shown in the preceding message. This results in:

pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
AMD-Vi: Extended features (0x206d73ef22254ade): PPR X2APIC NX GT IA GA PC GA_vAPIC
AMD-Vi: Interrupt remapping enabled

Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix divergent log levels")
Link: https://lore.kernel.org/lkml/alpine.LNX.2.20.13.2104112326460.11104@monopod.intra.ispras.ru
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org
---
 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 429a4baa3aee..8f0eb865119a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1954,8 +1954,8 @@ static void print_iommu_info(void)
 		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
 
 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-			pci_info(pdev, "Extended features (%#llx):",
-				 iommu->features);
+			pr_info("Extended features (%#llx):", iommu->features);
+
 			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
 				if (iommu_feature(iommu, (1ULL << i)))
 					pr_cont(" %s", feat_str[i]);

base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
2.30.0

