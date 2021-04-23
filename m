Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66B368FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242086AbhDWJxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:53:23 -0400
Received: from foss.arm.com ([217.140.110.172]:60940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242073AbhDWJxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:53:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 009CB1682;
        Fri, 23 Apr 2021 02:52:45 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD2393F774;
        Fri, 23 Apr 2021 02:52:40 -0700 (PDT)
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
Subject: [PATCH RFC v1 10/11] uapi/virtio-iommu: Add a new request type to send page response
Date:   Fri, 23 Apr 2021 15:21:46 +0530
Message-Id: <20210423095147.27922-11-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the page faults are handled, the response has to be sent to
virtio-iommu backend, from where it can be sent to the host to
prepare the response to a generated io page fault by the device.
Add a new virt-queue request type to handle this.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 include/uapi/linux/virtio_iommu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index c12d9b6a7243..1b174b98663a 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -48,6 +48,7 @@ struct virtio_iommu_config {
 #define VIRTIO_IOMMU_T_PROBE			0x05
 #define VIRTIO_IOMMU_T_ATTACH_TABLE		0x06
 #define VIRTIO_IOMMU_T_INVALIDATE		0x07
+#define VIRTIO_IOMMU_T_PAGE_RESP		0x08
 
 /* Status types */
 #define VIRTIO_IOMMU_S_OK			0x00
@@ -70,6 +71,23 @@ struct virtio_iommu_req_tail {
 	__u8					reserved[3];
 };
 
+struct virtio_iommu_req_page_resp {
+	struct virtio_iommu_req_head		head;
+	__le32					domain;
+	__le32					endpoint;
+#define VIRTIO_IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
+	__le32					flags;
+	__le32					pasid;
+	__le32					grpid;
+#define VIRTIO_IOMMU_PAGE_RESP_SUCCESS		(0x0)
+#define VIRTIO_IOMMU_PAGE_RESP_INVALID		(0x1)
+#define VIRTIO_IOMMU_PAGE_RESP_FAILURE		(0x2)
+	__le16					resp_code;
+	__u8					pasid_valid;
+	__u8					reserved[9];
+	struct virtio_iommu_req_tail		tail;
+};
+
 struct virtio_iommu_req_attach {
 	struct virtio_iommu_req_head		head;
 	__le32					domain;
-- 
2.17.1

