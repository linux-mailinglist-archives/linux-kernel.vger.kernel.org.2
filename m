Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2883A996A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFPLpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFPLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:45:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BF8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:43:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v22so3846245lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRz4KFdLmerhp38zcm9b3IR/zrRQXeHz9t6YRT8nYG4=;
        b=BQ1EiQqyrVqVHYO1YJE1WkJqCisfV4zCqAT3TpOECMypGYpV2HVPzoVU78QyxUTGAf
         aAH1SaSFCB7L2Zwql0oaykhTd5SIZvsqRiyKGnR6Kxog148iIqumKXrnh0/VJ/veU9Ux
         wvSgoT6qHRxR8lAsqujwyx9M+PQupGHXXWZpxTPZG0r4b8vCndoHVlDaSmhzeTE2Manq
         3vxiQEtDa7fUD49JhUcZzcevSLWhTCg706FlcM3EuG69A56qczdMbi5WsoKwXdU2sXaJ
         ze1zdv4c9B+QJXP88ExqlT0wV7mh1mHgraR8vV7NhcZ77jHpxAgJjsi/6obs4dwP4k4B
         Da3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TRz4KFdLmerhp38zcm9b3IR/zrRQXeHz9t6YRT8nYG4=;
        b=NW1emrCg27GhNZkd3Knr5QUv5Z1bnXrfLnbe5xOxDHOw6I89tSzvmacYfh3M4mbtQY
         dzJ1Uou+xb16sE5XSKF03ZcrUKp10ZnY03R7NycH6XRS66wLbjUBgZHqZ03IkxWwFVNn
         zuei5dBoyy3tFBr/CVH2gs6a6nHblPr+QAdJWHJ9BtcieerGRkGWBc5UOms/6QykwPC2
         d0uhZr8dGrhcQuGzNUznJDRfFQmdXSQoJw/KpSUT4hom5coTOjEJWrgMCYtjPFd3S1IO
         xoBIB3FukWx64WDocATkpSSJNNnTgr4AI59A1/MgufYRTLVLSZP4L7r+WgWdX2ig5suM
         +MyA==
X-Gm-Message-State: AOAM530gf3WbNnCH5yiF0Qqwh80CWhBvioQ3rwD1/84i0MM2WmQuYoGf
        5wbPfUgB8s2g0HuZyQitwCo=
X-Google-Smtp-Source: ABdhPJwAYLX/JWWa/WTgHFPNNwbAi3jjfzTIsIUGQh6s1o9tPoHMdzNk1Uqk89bpuFeRS3vRXZ3c8w==
X-Received: by 2002:ac2:58e3:: with SMTP id v3mr3388446lfo.339.1623843788885;
        Wed, 16 Jun 2021 04:43:08 -0700 (PDT)
Received: from localhost ([178.151.124.169])
        by smtp.gmail.com with ESMTPSA id bp28sm222612lfb.188.2021.06.16.04.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 04:43:08 -0700 (PDT)
From:   Roman Skakun <rm.skakun@gmail.com>
X-Google-Original-From: Roman Skakun <roman_skakun@epam.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Roman Skakun <rm.skakun@gmail.com>,
        Roman Skakun <roman_skakun@epam.com>
Subject: [PATCH 1/2] Revert "swiotlb-xen: remove xen_swiotlb_dma_mmap and xen_swiotlb_dma_get_sgtable"
Date:   Wed, 16 Jun 2021 14:42:04 +0300
Message-Id: <20210616114205.38902-1-roman_skakun@epam.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
References: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 922659ea771b3fd728149262c5ea15608fab9719.

Signed-off-by: Roman Skakun <roman_skakun@epam.com>
---
 drivers/xen/swiotlb-xen.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2b385c1b4a99..90bc5fc321bc 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -563,6 +563,31 @@ xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return xen_virt_to_bus(hwdev, xen_io_tlb_end - 1) <= mask;
 }
 
+/*
+ * Create userspace mapping for the DMA-coherent memory.
+ * This function should be called with the pages from the current domain only,
+ * passing pages mapped from other domains would lead to memory corruption.
+ */
+static int
+xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		     unsigned long attrs)
+{
+	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+}
+
+/*
+ * This function should be called with the pages from the current domain only,
+ * passing pages mapped from other domains would lead to memory corruption.
+ */
+static int
+xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
+			void *cpu_addr, dma_addr_t handle, size_t size,
+			unsigned long attrs)
+{
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
+}
+
 const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.alloc = xen_swiotlb_alloc_coherent,
 	.free = xen_swiotlb_free_coherent,
@@ -575,8 +600,8 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.map_page = xen_swiotlb_map_page,
 	.unmap_page = xen_swiotlb_unmap_page,
 	.dma_supported = xen_swiotlb_dma_supported,
-	.mmap = dma_common_mmap,
-	.get_sgtable = dma_common_get_sgtable,
+	.mmap = xen_swiotlb_dma_mmap,
+	.get_sgtable = xen_swiotlb_get_sgtable,
 	.alloc_pages = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 };
-- 
2.25.1

