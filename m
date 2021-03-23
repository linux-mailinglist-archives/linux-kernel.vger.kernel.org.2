Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327133454CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhCWBQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:16:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:21999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbhCWBPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:15:39 -0400
IronPort-SDR: YhNi8ChqqaU1/vfNYUM3+r3u3MUac/6rTL6kpLZjhftna5LQ/IeKsBnAkucom5r9nfK0ZjOH3c
 hy4DrXMYPo/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210455646"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210455646"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 18:15:38 -0700
IronPort-SDR: Q87OuAXkhgcdd+fU4mrN4tjPyLcaJKrF6KE0p00WKXTA1Vl+BNXWLOt7SrWhXIVbE3aX20PE4A
 xPe9UI3L5tMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="435362436"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 18:15:36 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/5] iommu/vt-d: Remove unused dma map/unmap trace events
Date:   Tue, 23 Mar 2021 09:05:56 +0800
Message-Id: <20210323010600.678627-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323010600.678627-1-baolu.lu@linux.intel.com>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to
the iommu ops"), the trace events for dma map/unmap have no users any
more. Cleanup them to make the code neat.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/trace/events/intel_iommu.h | 120 -----------------------------
 1 file changed, 120 deletions(-)

diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index e801f4910522..d233f2916584 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -15,126 +15,6 @@
 #include <linux/tracepoint.h>
 #include <linux/intel-iommu.h>
 
-DECLARE_EVENT_CLASS(dma_map,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-
-	TP_ARGS(dev, dev_addr, phys_addr, size),
-
-	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
-		__field(dma_addr_t, dev_addr)
-		__field(phys_addr_t, phys_addr)
-		__field(size_t,	size)
-	),
-
-	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
-		__entry->dev_addr = dev_addr;
-		__entry->phys_addr = phys_addr;
-		__entry->size = size;
-	),
-
-	TP_printk("dev=%s dev_addr=0x%llx phys_addr=0x%llx size=%zu",
-		  __get_str(dev_name),
-		  (unsigned long long)__entry->dev_addr,
-		  (unsigned long long)__entry->phys_addr,
-		  __entry->size)
-);
-
-DEFINE_EVENT(dma_map, map_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-	TP_ARGS(dev, dev_addr, phys_addr, size)
-);
-
-DEFINE_EVENT(dma_map, bounce_map_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-	TP_ARGS(dev, dev_addr, phys_addr, size)
-);
-
-DECLARE_EVENT_CLASS(dma_unmap,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-
-	TP_ARGS(dev, dev_addr, size),
-
-	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
-		__field(dma_addr_t, dev_addr)
-		__field(size_t,	size)
-	),
-
-	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
-		__entry->dev_addr = dev_addr;
-		__entry->size = size;
-	),
-
-	TP_printk("dev=%s dev_addr=0x%llx size=%zu",
-		  __get_str(dev_name),
-		  (unsigned long long)__entry->dev_addr,
-		  __entry->size)
-);
-
-DEFINE_EVENT(dma_unmap, unmap_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-	TP_ARGS(dev, dev_addr, size)
-);
-
-DEFINE_EVENT(dma_unmap, unmap_sg,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-	TP_ARGS(dev, dev_addr, size)
-);
-
-DEFINE_EVENT(dma_unmap, bounce_unmap_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-	TP_ARGS(dev, dev_addr, size)
-);
-
-DECLARE_EVENT_CLASS(dma_map_sg,
-	TP_PROTO(struct device *dev, int index, int total,
-		 struct scatterlist *sg),
-
-	TP_ARGS(dev, index, total, sg),
-
-	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
-		__field(dma_addr_t, dev_addr)
-		__field(phys_addr_t, phys_addr)
-		__field(size_t,	size)
-		__field(int, index)
-		__field(int, total)
-	),
-
-	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
-		__entry->dev_addr = sg->dma_address;
-		__entry->phys_addr = sg_phys(sg);
-		__entry->size = sg->dma_length;
-		__entry->index = index;
-		__entry->total = total;
-	),
-
-	TP_printk("dev=%s [%d/%d] dev_addr=0x%llx phys_addr=0x%llx size=%zu",
-		  __get_str(dev_name), __entry->index, __entry->total,
-		  (unsigned long long)__entry->dev_addr,
-		  (unsigned long long)__entry->phys_addr,
-		  __entry->size)
-);
-
-DEFINE_EVENT(dma_map_sg, map_sg,
-	TP_PROTO(struct device *dev, int index, int total,
-		 struct scatterlist *sg),
-	TP_ARGS(dev, index, total, sg)
-);
-
-DEFINE_EVENT(dma_map_sg, bounce_map_sg,
-	TP_PROTO(struct device *dev, int index, int total,
-		 struct scatterlist *sg),
-	TP_ARGS(dev, index, total, sg)
-);
-
 TRACE_EVENT(qi_submit,
 	TP_PROTO(struct intel_iommu *iommu, u64 qw0, u64 qw1, u64 qw2, u64 qw3),
 
-- 
2.25.1

