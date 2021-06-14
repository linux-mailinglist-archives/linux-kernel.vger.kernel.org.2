Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E453A696F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhFNO7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:59:37 -0400
Received: from foss.arm.com ([217.140.110.172]:37998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233087AbhFNO7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:59:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05DB01FB;
        Mon, 14 Jun 2021 07:57:33 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E17EF3F70D;
        Mon, 14 Jun 2021 07:57:31 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, john.garry@huawei.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: [PATCH] iommu: Update "iommu.strict" documentation
Date:   Mon, 14 Jun 2021 15:57:26 +0100
Message-Id: <2c8c06e1b449d6b060c5bf9ad3b403cd142f405d.1623682646.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidating the flush queue logic also meant that the "iommu.strict"
option started taking effect on x86 as well. Make sure we document that.

Fixes: a250c23f15c2 ("iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..20a32de990ed 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1987,7 +1987,7 @@
 			  forcing Dual Address Cycle for PCI cards supporting
 			  greater than 32-bit addressing.
 
-	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
+	iommu.strict=	[ARM64, X86] Configure TLB invalidation behaviour
 			Format: { "0" | "1" }
 			0 - Lazy mode.
 			  Request that DMA unmap operations use deferred
@@ -1998,6 +1998,10 @@
 			1 - Strict mode (default).
 			  DMA unmap operations invalidate IOMMU hardware TLBs
 			  synchronously.
+			Note: on x86, the default behaviour depends on the
+			equivalent driver-specific parameters, but a strict
+			mode explicitly specified by either method takes
+			precedence.
 
 	iommu.passthrough=
 			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
-- 
2.25.1

