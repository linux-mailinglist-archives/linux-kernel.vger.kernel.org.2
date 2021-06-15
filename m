Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA53A8717
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFORLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:11:00 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34909 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230039AbhFORKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623776930; x=1655312930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mN4TJb9ueuhi0oVhusFhmV7MzXLlMZV6zms8zDvW974=;
  b=sopXNqzHbWB50MP+mvDlTvS4eG0YSp/xeyG6r1MH53rV1K73kwUhasvF
   objAgJZUTTYgmdj9G3DhlHT8Od8T5+9ewPqAcfL41eAJYrgf9py+1yo4L
   RmkKl/zqw1MClBypVOSNRxfSQy2ltAzy6SPifVeQhzeXzOjEkyhlZmv/Q
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jun 2021 10:08:50 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2021 10:08:50 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 15 Jun 2021 10:08:50 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <isaacm@codeaurora.org>,
        <baolu.lu@linux.intel.com>, <pratikp@codeaurora.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: [PATCH v6 03/15] iommu/io-pgtable: Introduce map_pages() as a page table op
Date:   Tue, 15 Jun 2021 10:08:21 -0700
Message-ID: <1623776913-390160-4-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623776913-390160-1-git-send-email-quic_c_gdjako@quicinc.com>
References: <1623776913-390160-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Isaac J. Manjarres" <isaacm@codeaurora.org>

Mapping memory into io-pgtables follows the same semantics
that unmapping memory used to follow (i.e. a buffer will be
mapped one page block per call to the io-pgtable code). This
means that it can be optimized in the same way that unmapping
memory was, so add a map_pages() callback to the io-pgtable
ops structure, so that a range of pages of the same size
can be mapped within the same call.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 include/linux/io-pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 9391c5fa71e6..c43f3b899d2a 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -143,6 +143,7 @@ struct io_pgtable_cfg {
  * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
  *
  * @map:          Map a physically contiguous memory region.
+ * @map_pages:    Map a physically contiguous range of pages of the same size.
  * @unmap:        Unmap a physically contiguous memory region.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
@@ -153,6 +154,9 @@ struct io_pgtable_cfg {
 struct io_pgtable_ops {
 	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+	int (*map_pages)(struct io_pgtable_ops *ops, unsigned long iova,
+			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			 int prot, gfp_t gfp, size_t *mapped);
 	size_t (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
 			size_t size, struct iommu_iotlb_gather *gather);
 	size_t (*unmap_pages)(struct io_pgtable_ops *ops, unsigned long iova,
