Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25D33D1644
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbhGURlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:41:15 -0400
Received: from foss.arm.com ([217.140.110.172]:33468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238453AbhGURkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A3F411FB;
        Wed, 21 Jul 2021 11:21:18 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC58A3F694;
        Wed, 21 Jul 2021 11:21:16 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 19/23] iommu: Expose DMA domain strictness via sysfs
Date:   Wed, 21 Jul 2021 19:20:30 +0100
Message-Id: <fb1dc51d19772284f357bf5603d8f150ff857b41.1626888445.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
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

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/ABI/testing/sysfs-kernel-iommu_groups | 2 ++
 drivers/iommu/iommu.c                               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index eae2f1c1e11e..43ba764ba5b7 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -42,6 +42,8 @@ Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
 		========  ======================================================
 		DMA       All the DMA transactions from the device in this group
 		          are translated by the iommu.
+		DMA-FQ    As above, but using batched invalidation to lazily
+		          remove translations after use.
 		identity  All the DMA transactions from the device in this group
 		          are not translated by the iommu.
 		auto      Change to the type the device was booted with.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d7eaacae0944..d3b562a33ac4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3195,6 +3195,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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

