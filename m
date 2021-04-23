Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB38368FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbhDWJx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:53:27 -0400
Received: from foss.arm.com ([217.140.110.172]:60968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242067AbhDWJxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:53:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94D261684;
        Fri, 23 Apr 2021 02:52:49 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D48D3F774;
        Fri, 23 Apr 2021 02:52:45 -0700 (PDT)
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
Subject: [PATCH RFC v1 11/11] iommu/virtio: Add support to send page response
Date:   Fri, 23 Apr 2021 15:21:47 +0530
Message-Id: <20210423095147.27922-12-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add page_response iommu ops callback to send page response to
the device that generated io page fault.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 drivers/iommu/virtio-iommu.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08f1294baeab..6d62d9eae452 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1778,6 +1778,52 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static int viommu_page_response(struct device *dev,
+				struct iommu_fault_event *evt,
+				struct iommu_page_response *resp)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
+	struct viommu_dev *viommu = vdev->viommu;
+	bool pasid_valid = resp->flags & IOMMU_PAGE_RESP_PASID_VALID;
+	struct virtio_iommu_req_page_resp req = {
+		.head.type	= VIRTIO_IOMMU_T_PAGE_RESP,
+		.domain		= cpu_to_le32(vdomain->id),
+		.endpoint	= cpu_to_le32(fwspec->ids[0]),
+	};
+
+	if (vdev->pri_supported) {
+		bool needs_pasid = (evt->fault.prm.flags &
+				    IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID);
+
+		req.pasid_valid	= needs_pasid && pasid_valid;
+		req.flags	= cpu_to_le32((needs_pasid && pasid_valid) ?
+				   VIRTIO_IOMMU_PAGE_RESP_PASID_VALID : 0);
+		req.pasid	= cpu_to_le32(resp->pasid);
+		req.grpid	= cpu_to_le32(resp->grpid);
+
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_FAILURE:
+			req.resp_code = cpu_to_le16(VIRTIO_IOMMU_PAGE_RESP_FAILURE);
+			break;
+		case IOMMU_PAGE_RESP_INVALID:
+			req.resp_code = cpu_to_le16(VIRTIO_IOMMU_PAGE_RESP_INVALID);
+			break;
+		case IOMMU_PAGE_RESP_SUCCESS:
+			req.resp_code = cpu_to_le16(VIRTIO_IOMMU_PAGE_RESP_SUCCESS);
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		return -ENODEV;
+	}
+
+	return viommu_send_req_sync(viommu, &req, sizeof(req));
+}
+
 static u32 viommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	struct viommu_sva_bond *bond = sva_to_viommu_bond(handle);
@@ -2155,6 +2201,7 @@ static struct iommu_ops viommu_ops = {
 	.sva_bind		= viommu_sva_bind,
 	.sva_unbind		= viommu_sva_unbind,
 	.sva_get_pasid		= viommu_sva_get_pasid,
+	.page_response		= viommu_page_response,
 };
 
 static int viommu_init_vqs(struct viommu_dev *viommu)
-- 
2.17.1

