Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620C5368FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241934AbhDWJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:52:45 -0400
Received: from foss.arm.com ([217.140.110.172]:60732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241833AbhDWJwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:52:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FAEE1474;
        Fri, 23 Apr 2021 02:52:08 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EBF283F774;
        Fri, 23 Apr 2021 02:52:03 -0700 (PDT)
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
Subject: [PATCH RFC v1 02/11] iommu/virtio: Maintain a list of endpoints served by viommu_dev
Date:   Fri, 23 Apr 2021 15:21:38 +0530
Message-Id: <20210423095147.27922-3-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping a record of list of endpoints that are served by the virtio-iommu
device would help in redirecting the requests of page faults to the
correct endpoint device to handle such requests.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 drivers/iommu/virtio-iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 50039070e2aa..c970f386f031 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -48,6 +48,7 @@ struct viommu_dev {
 	spinlock_t			request_lock;
 	struct list_head		requests;
 	void				*evts;
+	struct list_head		endpoints;
 
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
@@ -115,6 +116,12 @@ struct viommu_endpoint {
 	void				*pgtf;
 };
 
+struct viommu_ep_entry {
+	u32				eid;
+	struct viommu_endpoint		*vdev;
+	struct list_head		list;
+};
+
 struct viommu_request {
 	struct list_head		list;
 	void				*writeback;
@@ -573,6 +580,7 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 	size_t probe_len;
 	struct virtio_iommu_req_probe *probe;
 	struct virtio_iommu_probe_property *prop;
+	struct viommu_ep_entry *ep;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 
@@ -640,6 +648,18 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 		prop = (void *)probe->properties + cur;
 		type = le16_to_cpu(prop->type) & VIRTIO_IOMMU_PROBE_T_MASK;
 	}
+	if (ret)
+		goto out_free;
+
+	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
+	if (!ep) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	ep->eid = probe->endpoint;
+	ep->vdev = vdev;
+
+	list_add(&ep->list, &viommu->endpoints);
 
 out_free:
 	kfree(probe);
@@ -1649,6 +1669,7 @@ static int viommu_probe(struct virtio_device *vdev)
 	viommu->dev = dev;
 	viommu->vdev = vdev;
 	INIT_LIST_HEAD(&viommu->requests);
+	INIT_LIST_HEAD(&viommu->endpoints);
 
 	ret = viommu_init_vqs(viommu);
 	if (ret)
-- 
2.17.1

