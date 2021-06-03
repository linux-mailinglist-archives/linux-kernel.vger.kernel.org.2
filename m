Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1E39A1BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFCNDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFCNDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:03:50 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488C0C06174A;
        Thu,  3 Jun 2021 06:02:06 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2ba7c.dip0.t-ipconnect.de [79.242.186.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id C711F15C;
        Thu,  3 Jun 2021 15:02:04 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] iommu/amd: Add amd_iommu=force_enable option
Date:   Thu,  3 Jun 2021 15:02:03 +0200
Message-Id: <20210603130203.29016-1-joro@8bytes.org>
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
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 drivers/iommu/amd/init.c                        | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..f6bf4e87df80 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -301,6 +301,9 @@
 					  allowed anymore to lift isolation
 					  requirements as needed. This option
 					  does not override iommu=pt
+			force_enable - Force enable the IOMMU on platforms known
+				       to be buggy with IOMMU enabled. Use this
+				       option with care.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d006724f4dc2..23614337abef 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -153,7 +153,8 @@ int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
 static bool amd_iommu_detected;
-static bool __initdata amd_iommu_disabled;
+static bool amd_iommu_disabled __initdata;
+static bool amd_iommu_force_enable __initdata;
 static int amd_iommu_target_ivhd_type;
 
 u16 amd_iommu_last_bdf;			/* largest PCI device id we have
@@ -2834,6 +2835,9 @@ static bool detect_ivrs(void)
 
 	acpi_put_table(ivrs_base);
 
+	if (amd_iommu_force_enable)
+		goto out;
+
 	/* Don't use IOMMU if there is Stoney Ridge graphics */
 	for (i = 0; i < 32; i++) {
 		u32 pci_id;
@@ -2845,6 +2849,7 @@ static bool detect_ivrs(void)
 		}
 	}
 
+out:
 	/* Make sure ACS will be enabled during PCI probe */
 	pci_request_acs();
 
@@ -3100,6 +3105,8 @@ static int __init parse_amd_iommu_options(char *str)
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

