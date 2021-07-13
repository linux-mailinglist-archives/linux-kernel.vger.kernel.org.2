Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831203C695A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 06:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhGMEcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 00:32:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:54907 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhGMEcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 00:32:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="190474944"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="190474944"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 21:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="492561996"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2021 21:29:09 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Update the virtual command related registers
Date:   Tue, 13 Jul 2021 12:26:49 +0800
Message-Id: <20210713042649.3547403-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VT-d spec Revision 3.3 updated the virtual command registers, virtual
command opcode B register, virtual command response register and virtual
command capability register (Section 10.4.43, 10.4.44, 10.4.45, 10.4.46).
This updates the virtual command interface implementation in the Intel
IOMMU driver accordingly.

Fixes: 24f27d32ab6b7 ("iommu/vt-d: Enlightened PASID allocation")
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  6 +++---
 drivers/iommu/intel/pasid.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d0fa0b31994d..05a65eb155f7 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -124,9 +124,9 @@
 #define DMAR_MTRR_PHYSMASK8_REG 0x208
 #define DMAR_MTRR_PHYSBASE9_REG 0x210
 #define DMAR_MTRR_PHYSMASK9_REG 0x218
-#define DMAR_VCCAP_REG		0xe00 /* Virtual command capability register */
-#define DMAR_VCMD_REG		0xe10 /* Virtual command register */
-#define DMAR_VCRSP_REG		0xe20 /* Virtual command response register */
+#define DMAR_VCCAP_REG		0xe30 /* Virtual command capability register */
+#define DMAR_VCMD_REG		0xe00 /* Virtual command register */
+#define DMAR_VCRSP_REG		0xe10 /* Virtual command response register */
 
 #define DMAR_IQER_REG_IQEI(reg)		FIELD_GET(GENMASK_ULL(3, 0), reg)
 #define DMAR_IQER_REG_ITESID(reg)	FIELD_GET(GENMASK_ULL(47, 32), reg)
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 5ff61c3d401f..8c2efb85fb3b 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -28,12 +28,12 @@
 #define VCMD_CMD_ALLOC			0x1
 #define VCMD_CMD_FREE			0x2
 #define VCMD_VRSP_IP			0x1
-#define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
+#define VCMD_VRSP_SC(e)			(((e) & 0xff) >> 1)
 #define VCMD_VRSP_SC_SUCCESS		0
-#define VCMD_VRSP_SC_NO_PASID_AVAIL	2
-#define VCMD_VRSP_SC_INVALID_PASID	2
-#define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 8) & 0xfffff)
-#define VCMD_CMD_OPERAND(e)		((e) << 8)
+#define VCMD_VRSP_SC_NO_PASID_AVAIL	16
+#define VCMD_VRSP_SC_INVALID_PASID	16
+#define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 16) & 0xfffff)
+#define VCMD_CMD_OPERAND(e)		((e) << 16)
 /*
  * Domain ID reserved for pasid entries programmed for first-level
  * only and pass-through transfer modes.
-- 
2.25.1

