Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9F368FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbhDWJwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:52:54 -0400
Received: from foss.arm.com ([217.140.110.172]:60782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241184AbhDWJwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:52:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 542591596;
        Fri, 23 Apr 2021 02:52:17 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C41B3F774;
        Fri, 23 Apr 2021 02:52:12 -0700 (PDT)
From:   Vivek Gautam <vivek.gautam@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com,
        Vivek Gautam <vivek.gautam@arm.com>
Subject: [PATCH RFC v1 04/11] iommu/virtio: Add a io page fault queue
Date:   Fri, 23 Apr 2021 15:21:40 +0530
Message-Id: <20210423095147.27922-5-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a io page fault queue to the driver so that it can be used
to redirect faults to the handler.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 drivers/iommu/virtio-iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index fd237cad1ce5..3da5f0807711 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -58,6 +58,7 @@ struct viommu_dev {
 	struct list_head		endpoints;
 	struct workqueue_struct		*pri_wq;
 	struct viommu_dev_pri_work	*pri_work;
+	struct iopf_queue		*iopf_pri;
 
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
@@ -581,6 +582,15 @@ static int viommu_add_pstf(struct viommu_endpoint *vdev, void *pstf, size_t len)
 	return 0;
 }
 
+static int viommu_init_queues(struct viommu_dev *viommu)
+{
+	viommu->iopf_pri = iopf_queue_alloc(dev_name(viommu->dev));
+	if (!viommu->iopf_pri)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 {
 	int ret;
@@ -670,6 +680,15 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 
 	list_add(&ep->list, &viommu->endpoints);
 
+	ret = viommu_init_queues(viommu);
+	if (ret)
+		goto out_free_eps;
+
+	kfree(probe);
+	return 0;
+
+out_free_eps:
+	kfree(ep);
 out_free:
 	kfree(probe);
 	return ret;
-- 
2.17.1

