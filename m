Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B823D42C868
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbhJMSN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:13:27 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:22124 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231268AbhJMSNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634148676; x=1665684676;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=HHyOxsqKkzhzocslGHm95HxmgpnJGL36sX/8Jq2I5VQ=;
  b=K2aequsiyevjJgPnLbGLb3xsvKoNobUL05mTnKhX/w0F7p/+Q4MepIg1
   6T8VNLrJqBbqmw0qHUVowL6QQtcKJe/kYknMEXwOzv4DtwFe0rvSJJHBU
   cReMB4mi6l08o7JeoegsaFuoCQRVNGaR9wh4z6XvcRwXTfnwLEK0ddfwc
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Oct 2021 11:11:16 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 11:11:15 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 13 Oct 2021 11:11:15 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <akpm@linux-foundation.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <djakov@kernel.org>
Subject: [PATCH] iommu/iova: Add support for IOVA max alignment tuning
Date:   Wed, 13 Oct 2021 11:11:07 -0700
Message-ID: <1634148667-409263-1-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOVAs are aligned to the smallest PAGE_SIZE order, where the requested
IOVA can fit. But this might not work for all use-cases. It can cause
IOVA fragmentation in some multimedia and 8K video use-cases that may
require larger buffers to be allocated and mapped.

When the above allocation pattern is used with the current alignment
scheme, the IOVA space could be quickly exhausted for 32bit devices.

In order to get better IOVA space utilization and reduce fragmentation,
a new kernel command line parameter is introduced to make the alignment
limit configurable by the user during boot.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 drivers/iommu/iova.c                            | 26 ++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ad94a2aa9819..630246dc691f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2056,6 +2056,14 @@
 			  forcing Dual Address Cycle for PCI cards supporting
 			  greater than 32-bit addressing.
 
+	iommu.max_align_shift=
+			[ARM64, X86] Limit the alignment of IOVAs to a maximum
+			PAGE_SIZE order. Larger IOVAs will be aligned to this
+			specified order. The order is expressed as a power of
+			two multiplied by the PAGE_SIZE.
+			Format: { "4" | "5" | "6" | "7" | "8" | "9" }
+			Default: 9
+
 	iommu.strict=	[ARM64, X86] Configure TLB invalidation behaviour
 			Format: { "0" | "1" }
 			0 - Lazy mode.
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9e8bc802ac05..5a8c86871735 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -15,6 +15,9 @@
 /* The anchor node sits above the top of the usable address space */
 #define IOVA_ANCHOR	~0UL
 
+#define IOMMU_DEFAULT_IOVA_MAX_ALIGN_SHIFT	9
+static unsigned long iommu_max_align_shift __read_mostly = IOMMU_DEFAULT_IOVA_MAX_ALIGN_SHIFT;
+
 static bool iova_rcache_insert(struct iova_domain *iovad,
 			       unsigned long pfn,
 			       unsigned long size);
@@ -27,6 +30,27 @@ static void free_iova_rcaches(struct iova_domain *iovad);
 static void fq_destroy_all_entries(struct iova_domain *iovad);
 static void fq_flush_timeout(struct timer_list *t);
 
+static unsigned long limit_align_shift(struct iova_domain *iovad, unsigned long shift)
+{
+	unsigned long max_align_shift;
+
+	max_align_shift = iommu_max_align_shift + PAGE_SHIFT - iova_shift(iovad);
+	return min_t(unsigned long, max_align_shift, shift);
+}
+
+static int __init iommu_set_def_max_align_shift(char *str)
+{
+	unsigned long max_align_shift;
+
+	int ret = kstrtoul(str, 10, &max_align_shift);
+
+	if (!ret)
+		iommu_max_align_shift = max_align_shift;
+
+	return 0;
+}
+early_param("iommu.max_align_shift", iommu_set_def_max_align_shift);
+
 static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
 {
 	struct iova_domain *iovad;
@@ -242,7 +266,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
 
 	if (size_aligned)
-		align_mask <<= fls_long(size - 1);
+		align_mask <<= limit_align_shift(iovad, fls_long(size - 1));
 
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
