Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF8368FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbhDWJwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:52:49 -0400
Received: from foss.arm.com ([217.140.110.172]:60758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241184AbhDWJwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:52:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3D45152B;
        Fri, 23 Apr 2021 02:52:12 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C3533F774;
        Fri, 23 Apr 2021 02:52:08 -0700 (PDT)
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
Subject: [PATCH RFC v1 03/11] iommu/virtio: Handle incoming page faults
Date:   Fri, 23 Apr 2021 15:21:39 +0530
Message-Id: <20210423095147.27922-4-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redirect the incoming page faults to the registered fault handler
that can take the fault information such as, pasid, page request
group-id, address and pasid flags.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 drivers/iommu/virtio-iommu.c      | 80 ++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_iommu.h |  1 +
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index c970f386f031..fd237cad1ce5 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -37,6 +37,13 @@
 /* Some architectures need an Address Space ID for each page table */
 DEFINE_XARRAY_ALLOC1(viommu_asid_xa);
 
+struct viommu_dev_pri_work {
+	struct work_struct		work;
+	struct viommu_dev		*dev;
+	struct virtio_iommu_fault	*vfault;
+	u32				endpoint;
+};
+
 struct viommu_dev {
 	struct iommu_device		iommu;
 	struct device			*dev;
@@ -49,6 +56,8 @@ struct viommu_dev {
 	struct list_head		requests;
 	void				*evts;
 	struct list_head		endpoints;
+	struct workqueue_struct		*pri_wq;
+	struct viommu_dev_pri_work	*pri_work;
 
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
@@ -666,6 +675,58 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 	return ret;
 }
 
+static void viommu_handle_ppr(struct work_struct *work)
+{
+	struct viommu_dev_pri_work *pwork =
+				container_of(work, struct viommu_dev_pri_work, work);
+	struct viommu_dev *viommu = pwork->dev;
+	struct virtio_iommu_fault *vfault = pwork->vfault;
+	struct viommu_endpoint *vdev;
+	struct viommu_ep_entry *ep;
+	struct iommu_fault_event fault_evt = {
+		.fault.type = IOMMU_FAULT_PAGE_REQ,
+	};
+	struct iommu_fault_page_request *prq = &fault_evt.fault.prm;
+
+	u32 flags	= le32_to_cpu(vfault->flags);
+	u32 prq_flags	= le32_to_cpu(vfault->pr_evt_flags);
+	u32 endpoint	= pwork->endpoint;
+
+	memset(prq, 0, sizeof(struct iommu_fault_page_request));
+	prq->addr = le64_to_cpu(vfault->address);
+
+	if (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_LAST_PAGE)
+		prq->flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID) {
+		prq->flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		prq->pasid = le32_to_cpu(vfault->pasid);
+		prq->grpid = le32_to_cpu(vfault->grpid);
+	}
+
+	if (flags & VIRTIO_IOMMU_FAULT_F_READ)
+		prq->perm |= IOMMU_FAULT_PERM_READ;
+	if (flags & VIRTIO_IOMMU_FAULT_F_WRITE)
+		prq->perm |= IOMMU_FAULT_PERM_WRITE;
+	if (flags & VIRTIO_IOMMU_FAULT_F_EXEC)
+		prq->perm |= IOMMU_FAULT_PERM_EXEC;
+	if (flags & VIRTIO_IOMMU_FAULT_F_PRIV)
+		prq->perm |= IOMMU_FAULT_PERM_PRIV;
+
+	list_for_each_entry(ep, &viommu->endpoints, list) {
+		if (ep->eid == endpoint) {
+			vdev = ep->vdev;
+			break;
+		}
+	}
+
+	if ((prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID) &&
+	    (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_NEEDS_PASID))
+		prq->flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
+
+	if (iommu_report_device_fault(vdev->dev, &fault_evt))
+		dev_err(vdev->dev, "Couldn't handle page request\n");
+}
+
 static int viommu_fault_handler(struct viommu_dev *viommu,
 				struct virtio_iommu_fault *fault)
 {
@@ -679,7 +740,13 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
 	u32 pasid	= le32_to_cpu(fault->pasid);
 
 	if (type == VIRTIO_IOMMU_FAULT_F_PAGE_REQ) {
-		dev_info(viommu->dev, "Page request fault - unhandled\n");
+		dev_info_ratelimited(viommu->dev,
+				     "Page request fault from EP %u\n",
+				     endpoint);
+
+		viommu->pri_work->vfault = fault;
+		viommu->pri_work->endpoint = endpoint;
+		queue_work(viommu->pri_wq, &viommu->pri_work->work);
 		return 0;
 	}
 
@@ -1683,6 +1750,17 @@ static int viommu_probe(struct virtio_device *vdev)
 		goto err_free_vqs;
 	}
 
+	viommu->pri_work = kzalloc(sizeof(*viommu->pri_work), GFP_KERNEL);
+	if (!viommu->pri_work)
+		return -ENOMEM;
+
+	viommu->pri_work->dev = viommu;
+
+	INIT_WORK(&viommu->pri_work->work, viommu_handle_ppr);
+	viommu->pri_wq = create_singlethread_workqueue("viommu-pri-wq");
+	if (!viommu->pri_wq)
+		return -ENOMEM;
+
 	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
 	viommu->last_domain = ~0U;
 
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index accc3318ce46..53aa88e6b077 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -302,6 +302,7 @@ struct virtio_iommu_req_invalidate {
 #define VIRTIO_IOMMU_FAULT_F_READ		(1 << 0)
 #define VIRTIO_IOMMU_FAULT_F_WRITE		(1 << 1)
 #define VIRTIO_IOMMU_FAULT_F_EXEC		(1 << 2)
+#define VIRTIO_IOMMU_FAULT_F_PRIV		(1 << 3)
 #define VIRTIO_IOMMU_FAULT_F_ADDRESS		(1 << 8)
 
 #define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
-- 
2.17.1

