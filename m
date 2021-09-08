Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF694403A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348077AbhIHM4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:56:54 -0400
Received: from foss.arm.com ([217.140.110.172]:45858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232097AbhIHM4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:56:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 826C56D;
        Wed,  8 Sep 2021 05:55:45 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8EB2C3F766;
        Wed,  8 Sep 2021 05:55:44 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] iommu: Clarify default domain Kconfig
Date:   Wed,  8 Sep 2021 13:55:37 +0100
Message-Id: <69a0c6f17b000b54b8333ee42b3124c1d5a869e2.1631105737.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although strictly it is the AMD and Intel drivers which have an existing
expectation of lazy behaviour by default, it ends up being rather
unintuitive to describe this literally in Kconfig. Express it instead as
an architecture dependency, to clarify that it is a valid config-time
decision. The end result is the same since virtio-iommu doesn't support
lazy mode and thus falls back to strict at runtime regardless.

The per-architecture disparity is a matter of historical expectations:
the AMD and Intel drivers have been lazy by default since 2008, and
changing that gets noticed by people asking where their I/O throughput
has gone. Conversely, Arm-based systems with their wider assortment of
IOMMU drivers mostly only support strict mode anyway; only the Arm SMMU
drivers have later grown support for passthrough and lazy mode, for
users who wanted to explicitly trade off isolation for performance.
These days, reducing the default level of isolation in a way which may
go unnoticed by users who expect otherwise hardly seems worth risking
for the sake of one line of Kconfig, so here's where we are.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8ad8618b3530..124c41adeca1 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -82,7 +82,7 @@ config IOMMU_DEBUGFS
 choice
 	prompt "IOMMU default domain type"
 	depends on IOMMU_API
-	default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
+	default IOMMU_DEFAULT_DMA_LAZY if X86 || IA64
 	default IOMMU_DEFAULT_DMA_STRICT
 	help
 	  Choose the type of IOMMU domain used to manage DMA API usage by
-- 
2.25.1

