Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D746F3E0697
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbhHDRR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:17:29 -0400
Received: from foss.arm.com ([217.140.110.172]:35248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239927AbhHDRRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:17:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F2B2143B;
        Wed,  4 Aug 2021 10:16:52 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4026B3F66F;
        Wed,  4 Aug 2021 10:16:50 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH v3 21/25] iommu: Expose DMA domain strictness via sysfs
Date:   Wed,  4 Aug 2021 18:15:49 +0100
Message-Id: <fca07df20f45952ff5c19b744fc87be777259594.1628094601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs interface for default domain types exists primarily so users
can choose the performance/security tradeoff relevant to their own
workload. As such, the choice between the policies for DMA domains fits
perfectly as an additional point on that scale - downgrading a
particular device from a strict default to non-strict may be enough to
let it reach the desired level of performance, while still retaining
more peace of mind than with a wide-open identity domain. Now that we've
abstracted non-strict mode as a distinct type of DMA domain, allow it to
be chosen through the user interface as well.

CC: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Summarise the implications in the documentation for completeness
---
 Documentation/ABI/testing/sysfs-kernel-iommu_groups | 6 +++++-
 drivers/iommu/iommu.c                               | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index eae2f1c1e11e..b15af6a5bc08 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -42,8 +42,12 @@ Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
 		========  ======================================================
 		DMA       All the DMA transactions from the device in this group
 		          are translated by the iommu.
+		DMA-FQ    As above, but using batched invalidation to lazily
+		          remove translations after use. This may offer reduced
+			  overhead at the cost of reduced memory protection.
 		identity  All the DMA transactions from the device in this group
-		          are not translated by the iommu.
+		          are not translated by the iommu. Maximum performance
+			  but zero protection.
 		auto      Change to the type the device was booted with.
 		========  ======================================================
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 55ca5bf3cafc..b141161d5bbc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3267,6 +3267,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		req_type = IOMMU_DOMAIN_IDENTITY;
 	else if (sysfs_streq(buf, "DMA"))
 		req_type = IOMMU_DOMAIN_DMA;
+	else if (sysfs_streq(buf, "DMA-FQ"))
+		req_type = IOMMU_DOMAIN_DMA_FQ;
 	else if (sysfs_streq(buf, "auto"))
 		req_type = 0;
 	else
-- 
2.25.1

