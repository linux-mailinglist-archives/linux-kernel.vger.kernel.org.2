Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE830B6BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhBBEw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:52:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:54663 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231733AbhBBEwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:52:46 -0500
IronPort-SDR: LCQwtk2iE1IO5BCj/r91wUhq+grjNwj1AJ5N5BwySTvHvhWhgc2uZvv3pA1Rkv+lF9m+fG41Cq
 m91FfAPsP90g==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180020416"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="180020416"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 20:49:27 -0800
IronPort-SDR: wAxT30eNnXWM0H40ErK8jQjP1Q9pZ/al1hrouLQk5jVS0VeY2tqaA/bT85AeSabvD5tnK/ejrc
 CJ1cfUArULog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="479423181"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2021 20:49:25 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Yian Chen <yian.chen@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iommu/vt-d: Add new enum value and structure for SATC
Date:   Tue,  2 Feb 2021 12:40:55 +0800
Message-Id: <20210202044057.615277-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202044057.615277-1-baolu.lu@linux.intel.com>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yian Chen <yian.chen@intel.com>

Starting from Intel Platform VT-d v3.2, BIOS may provide new remapping
structure SATC for SOC integrated devices, according to section 8.8 of
Intel VT-d architecture specification v3.2. The SATC structure reports
a list of the devices that require SATC enabling via ATS capacity.

This patch introduces the new enum value and structure to represent the
remapping information. Kernel should parse the information from the
reporting structure and enable ATC for the devices as needed.

Signed-off-by: Yian Chen <yian.chen@intel.com>
---
 include/acpi/actbl1.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 43549547ed3e..b7ca802b66d2 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -514,7 +514,8 @@ enum acpi_dmar_type {
 	ACPI_DMAR_TYPE_ROOT_ATS = 2,
 	ACPI_DMAR_TYPE_HARDWARE_AFFINITY = 3,
 	ACPI_DMAR_TYPE_NAMESPACE = 4,
-	ACPI_DMAR_TYPE_RESERVED = 5	/* 5 and greater are reserved */
+	ACPI_DMAR_TYPE_SATC = 5,
+	ACPI_DMAR_TYPE_RESERVED = 6	/* 5 and greater are reserved */
 };
 
 /* DMAR Device Scope structure */
@@ -607,6 +608,14 @@ struct acpi_dmar_andd {
 	char device_name[1];
 };
 
+/* 5: SOC Integrated Address Translation Cache Reporting Structure */
+
+struct acpi_dmar_satc {
+	struct acpi_dmar_header header;
+	u8 flags;
+	u8 reserved;
+	u16 segment;
+};
 /*******************************************************************************
  *
  * DRTM - Dynamic Root of Trust for Measurement table
-- 
2.25.1

