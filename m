Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B869830D688
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhBCJoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:44:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:52804 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233129AbhBCJn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:43:57 -0500
IronPort-SDR: e8FozFLZP7OTeUF49v2i/XiQqUmLPRcG+w1UYZCblWIzorWus3qkWSC7n/+4o+vgb2UaxvSejC
 HszprbtqA4kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="199968616"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="199968616"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:42:11 -0800
IronPort-SDR: Oj/AwqmLP8X7/oF8k9PImRunuUL43VquS249Ptf+A3sBvb3qDGT0SzkvEUyhdG2jKQdItJWUHi
 wUg+szf8ggGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="480285030"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2021 01:42:10 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Yian Chen <yian.chen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/3] iommu/vt-d: Add new enum value and structure for SATC
Date:   Wed,  3 Feb 2021 17:33:26 +0800
Message-Id: <20210203093329.1617808-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
References: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yian Chen <yian.chen@intel.com>

Starting from Intel Platform VT-d v3.2, BIOS may provide new remapping
structure SATC for SOC integrated devices, according to section 8.8 of
Intel VT-d architecture specification v3.2. The SATC structure reports
a list of the devices that require ATS for normal device operation. It
is a functional requirement that these devices will not work without OS
enabling ATS capability.

This patch introduces the new enum value and structure to represent the
remapping information. Kernel should parse the information from the
reporting structure and enable ATC for the devices as needed.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/acpi/actbl1.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 43549547ed3e..c38e08cf1b9e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -514,7 +514,8 @@ enum acpi_dmar_type {
 	ACPI_DMAR_TYPE_ROOT_ATS = 2,
 	ACPI_DMAR_TYPE_HARDWARE_AFFINITY = 3,
 	ACPI_DMAR_TYPE_NAMESPACE = 4,
-	ACPI_DMAR_TYPE_RESERVED = 5	/* 5 and greater are reserved */
+	ACPI_DMAR_TYPE_SATC = 5,
+	ACPI_DMAR_TYPE_RESERVED = 6	/* 6 and greater are reserved */
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

