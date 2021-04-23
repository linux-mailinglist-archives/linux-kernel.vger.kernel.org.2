Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DFC368FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbhDWJwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:52:41 -0400
Received: from foss.arm.com ([217.140.110.172]:60706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241845AbhDWJwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:52:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F48513A1;
        Fri, 23 Apr 2021 02:52:03 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB7363F774;
        Fri, 23 Apr 2021 02:51:58 -0700 (PDT)
From:   Vivek Gautam <vivek.gautam@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com,
        Vivek Gautam <vivek.gautam@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v1 01/11] uapi/virtio-iommu: Add page request grp-id and flags information
Date:   Fri, 23 Apr 2021 15:21:37 +0530
Message-Id: <20210423095147.27922-2-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fault information for group-id and necessary flags for page
request faults that can be handled by page fault handler in
virtio-iommu driver.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
---
 include/uapi/linux/virtio_iommu.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index f8bf927a0689..accc3318ce46 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -307,14 +307,27 @@ struct virtio_iommu_req_invalidate {
 #define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
 #define VIRTIO_IOMMU_FAULT_F_PAGE_REQ		2
 
+#define VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID		(1 << 0)
+#define VIRTIO_IOMMU_FAULT_PRQ_F_LAST_PAGE		(1 << 1)
+#define VIRTIO_IOMMU_FAULT_PRQ_F_PRIV_DATA		(1 << 2)
+#define VIRTIO_IOMMU_FAULT_PRQ_F_NEEDS_PASID		(1 << 3)
+
+#define VIRTIO_IOMMU_FAULT_UNREC_F_PASID_VALID		(1 << 0)
+#define VIRTIO_IOMMU_FAULT_UNREC_F_ADDR_VALID		(1 << 1)
+#define VIRTIO_IOMMU_FAULT_UNREC_F_FETCH_ADDR_VALID	(1 << 2)
+
 struct virtio_iommu_fault {
 	__u8					reason;
 	__u8					reserved[3];
 	__le16					flt_type;
 	__u8					reserved2[2];
+	/* flags is actually permission flags */
 	__le32					flags;
+	/* flags for PASID and Page request handling info */
+	__le32					pr_evt_flags;
 	__le32					endpoint;
 	__le32					pasid;
+	__le32					grpid;
 	__u8					reserved3[4];
 	__le64					address;
 	__u8					reserved4[8];
-- 
2.17.1

