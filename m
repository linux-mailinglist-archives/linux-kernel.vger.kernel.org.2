Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC7E35B6F8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 23:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhDKVOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 17:14:07 -0400
Received: from mail.ispras.ru ([83.149.199.84]:52780 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhDKVOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 17:14:06 -0400
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id D0C8D40D3BFF;
        Sun, 11 Apr 2021 21:13:47 +0000 (UTC)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu/amd: Fix extended features logging
Date:   Mon, 12 Apr 2021 00:13:30 +0300
Message-Id: <20210411211330.2252-1-amonakov@ispras.ru>
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
which is shown in the preceding message anyway. This results in:

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

v2: avoid pr_info(""), change pci_info() to pr_info() for a nicer
solution

 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 596d0c413473..62913f82a21f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1929,8 +1929,8 @@ static void print_iommu_info(void)
 		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
 
 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-			pci_info(pdev, "Extended features (%#llx):",
-				 iommu->features);
+			pr_info("Extended features (%#llx):", iommu->features);
+
 			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
 				if (iommu_feature(iommu, (1ULL << i)))
 					pr_cont(" %s", feat_str[i]);
-- 
2.30.0

