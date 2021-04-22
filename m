Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D7D368127
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhDVNH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVNHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:07:54 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6DC06174A;
        Thu, 22 Apr 2021 06:07:19 -0700 (PDT)
Received: from cap.home.8bytes.org (p5b0069de.dip0.t-ipconnect.de [91.0.105.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id C04D3133;
        Thu, 22 Apr 2021 15:07:15 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        alexander.deucher@amd.com, d1nuc0m@protonmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/amd: Add amd_iommu=force_enable option
Date:   Thu, 22 Apr 2021 15:07:01 +0200
Message-Id: <20210422130701.29872-1-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Add this option to enable the IOMMU on platforms like AMD Stoney,
where the kernel usually disables it because it may cause problems in
some scenarios.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 drivers/iommu/amd/init.c                        | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..c9573f726707 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -303,6 +303,9 @@
 					  allowed anymore to lift isolation
 					  requirements as needed. This option
 					  does not override iommu=pt
+			force_enable - Force enable the IOMMU on platforms known
+				       to be buggy with IOMMU enabled. Use this
+				       option with care.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 321f5906e6ed..3e2295d3b3e2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -155,6 +155,7 @@ static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
 static bool amd_iommu_detected;
 static bool __initdata amd_iommu_disabled;
+static bool __initdata amd_iommu_force_enable;
 static int amd_iommu_target_ivhd_type;
 
 u16 amd_iommu_last_bdf;			/* largest PCI device id we have
@@ -2882,6 +2883,9 @@ static bool detect_ivrs(void)
 
 	acpi_put_table(ivrs_base);
 
+	if (amd_iommu_force_enable)
+		goto out;
+
 	/* Don't use IOMMU if there is Stoney Ridge graphics */
 	for (i = 0; i < 32; i++) {
 		u32 pci_id;
@@ -2893,6 +2897,7 @@ static bool detect_ivrs(void)
 		}
 	}
 
+out:
 	/* Make sure ACS will be enabled during PCI probe */
 	pci_request_acs();
 
@@ -3148,6 +3153,8 @@ static int __init parse_amd_iommu_options(char *str)
 	for (; *str; ++str) {
 		if (strncmp(str, "fullflush", 9) == 0)
 			amd_iommu_unmap_flush = true;
+		if (strncmp(str, "force_enable", 12) == 0)
+			amd_iommu_force_enable = true;
 		if (strncmp(str, "off", 3) == 0)
 			amd_iommu_disabled = true;
 		if (strncmp(str, "force_isolation", 15) == 0)
-- 
2.31.1

