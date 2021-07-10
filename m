Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752D83C32EC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 07:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhGJFDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 01:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhGJFDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 01:03:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5170EC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 22:00:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso9443621pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 22:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcwItNZ7VMmtWqMy9kb+USrQm64KGF/wTocx0UJTLmY=;
        b=Yo8MPJJFqYRj6I1y1qWr1H7m9/q/z2W3G40ZdBkUcDDqNK+bfwzTb0Cy3w9BpPrzz9
         OxuG7ioqb2m3x8o81cvwZea/hMBez/sSfXydSSIzJ5iYvODa7KKiubBfmSAkgNBtaaOb
         n4DSGLVW0v98dFNkms3Lx48PTJ6CoTMUBcO8KaFUjnNcxDjqzy7yAT8J/+s+eb2UQMwf
         XSCLoBhSFKGKfuuDgnTB9pIZ7FNdz3z5b9QnsiACXubf+lLdYeYT1IrHx0LbVgOd3xQQ
         dL4Gj9F/FuU7UVm0M3rsS+qQk6zGf2GzdvUmuJ63M42qPndcNiFw0MUQAPUSgIaH/Cey
         7VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcwItNZ7VMmtWqMy9kb+USrQm64KGF/wTocx0UJTLmY=;
        b=NHMHQM3xF+cNfRGRslWePi/UjgvbIEEcbXP34/WtNv0V3FLDlXI7UbPDAy+NVfsmLN
         J+Mwaxcbqonyu4u/5uqDB7l8Owo6HafdDh61+qjn4sn5Vhre01OmkkC23Q9fWn3+L3i7
         /3/A/zz8BDZ21UBYxUqAbb1QeUUVgG+s+WyAkqIJfYB+v6xFyHYIDBsIxBlCbjq+AQqY
         CQusfK/K86SE/rAXxaFWYMk9njjYmG/eu+khC57298pM9buTL3g1VQMCDhAwLo76h6Zi
         BUEzgfbCf3uowa1ON9Y+30nvmRVxr7brC6qww9VlJnC3iCYG5P2h/XJe27zOKJSvGA4d
         sWig==
X-Gm-Message-State: AOAM530kB8H3gmPzHORKyWLWTy1k//qHUkdQXihVPoTbstRf9umEvbvo
        w5q6YGuA7dIamD5tG8J1yqiSKZ19OB5zfQ==
X-Google-Smtp-Source: ABdhPJxybbAadTrNo73EVv+PkEJlQ8ET9MR98Sg4dOjmHm1+eNdi7vIFrNy/GqXnIhkYm9rxmvTr6A==
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr42028483pjb.52.1625893252597;
        Fri, 09 Jul 2021 22:00:52 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id z3sm9174589pgl.77.2021.07.09.22.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 22:00:51 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1] coresight: tmc-etr: Speed up for bounce buffer in flat mode
Date:   Sat, 10 Jul 2021 13:00:46 +0800
Message-Id: <20210710050046.414669-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AUX bounce buffer is allocated with API dma_alloc_coherent(), in the
low level's architecture code, e.g. for Arm64, it maps the memory with
the attribution "Normal non-cacheable"; this can be concluded from the
definition for pgprot_dmacoherent() in arch/arm64/include/asm/pgtable.h.

Later when access the AUX bounce buffer, since the memory mapping is
non-cacheable, it's low efficiency due to every load instruction must
reach out DRAM.

This patch changes to allocate pages with alloc_pages_node(), thus the
driver can access the memory with cacheable mapping in the kernel linear
virtual address; therefore, because load instructions can fetch data
from cache lines rather than always read data from DRAM, the driver can
boost memory coping performance.  After using the cacheable mapping, the
driver uses dma_sync_single_for_cpu() to invalidate cacheline prior to
read bounce buffer so can avoid read stale trace data.

By measurement the duration for function tmc_update_etr_buffer() with
ftrace function_graph tracer, it shows the performance significant
improvement for copying 4MiB data from bounce buffer:

  # echo tmc_etr_get_data_flat_buf > set_graph_notrace // avoid noise
  # echo tmc_update_etr_buffer > set_graph_function
  # echo function_graph > current_tracer

  before:

  # CPU  DURATION                  FUNCTION CALLS
  # |     |   |                     |   |   |   |
  2)               |    tmc_update_etr_buffer() {
  ...
  2) # 8148.320 us |    }

  after:

  # CPU  DURATION                  FUNCTION CALLS
  # |     |   |                     |   |   |   |
  2)               |  tmc_update_etr_buffer() {
  ...
  2) # 2463.980 us |  }

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 58 ++++++++++++++++---
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index acdb59e0e661..94558dc5bcf4 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -21,6 +21,7 @@
 
 struct etr_flat_buf {
 	struct device	*dev;
+	struct page	*pages;
 	dma_addr_t	daddr;
 	void		*vaddr;
 	size_t		size;
@@ -600,6 +601,7 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 {
 	struct etr_flat_buf *flat_buf;
 	struct device *real_dev = drvdata->csdev->dev.parent;
+	ssize_t	aligned_size;
 
 	/* We cannot reuse existing pages for flat buf */
 	if (pages)
@@ -609,12 +611,17 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 	if (!flat_buf)
 		return -ENOMEM;
 
-	flat_buf->vaddr = dma_alloc_coherent(real_dev, etr_buf->size,
-					     &flat_buf->daddr, GFP_KERNEL);
-	if (!flat_buf->vaddr) {
-		kfree(flat_buf);
-		return -ENOMEM;
-	}
+	aligned_size = PAGE_ALIGN(etr_buf->size);
+	flat_buf->pages = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO,
+					   get_order(aligned_size));
+	if (!flat_buf->pages)
+		goto fail_alloc_pages;
+
+	flat_buf->vaddr = page_address(flat_buf->pages);
+	flat_buf->daddr = dma_map_page(real_dev, flat_buf->pages, 0,
+				       aligned_size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(real_dev, flat_buf->daddr))
+		goto fail_dma_map_page;
 
 	flat_buf->size = etr_buf->size;
 	flat_buf->dev = &drvdata->csdev->dev;
@@ -622,23 +629,34 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 	etr_buf->mode = ETR_MODE_FLAT;
 	etr_buf->private = flat_buf;
 	return 0;
+
+fail_dma_map_page:
+	__free_pages(flat_buf->pages, get_order(aligned_size));
+fail_alloc_pages:
+	kfree(flat_buf);
+	return -ENOMEM;
 }
 
 static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
 {
 	struct etr_flat_buf *flat_buf = etr_buf->private;
 
-	if (flat_buf && flat_buf->daddr) {
+	if (flat_buf && flat_buf->vaddr) {
 		struct device *real_dev = flat_buf->dev->parent;
+		ssize_t aligned_size = PAGE_ALIGN(etr_buf->size);
 
-		dma_free_coherent(real_dev, flat_buf->size,
-				  flat_buf->vaddr, flat_buf->daddr);
+		dma_unmap_page(real_dev, flat_buf->daddr, aligned_size,
+			       DMA_FROM_DEVICE);
+		__free_pages(flat_buf->pages, get_order(aligned_size));
 	}
 	kfree(flat_buf);
 }
 
 static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
 {
+	struct etr_flat_buf *flat_buf = etr_buf->private;
+	struct device *real_dev = flat_buf->dev->parent;
+
 	/*
 	 * Adjust the buffer to point to the beginning of the trace data
 	 * and update the available trace data.
@@ -648,6 +666,28 @@ static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
 		etr_buf->len = etr_buf->size;
 	else
 		etr_buf->len = rwp - rrp;
+
+	if (etr_buf->offset + etr_buf->len > etr_buf->size) {
+		int len1, len2;
+
+		/*
+		 * If trace data is wrapped around, sync AUX bounce buffer
+		 * for two chunks: "len1" is for the trace date length at
+		 * the tail of bounce buffer, and "len2" is the length from
+		 * the start of the buffer after wrapping around.
+		 */
+		len1 = etr_buf->size - etr_buf->offset;
+		len2 = etr_buf->len - len1;
+		dma_sync_single_for_cpu(real_dev,
+					flat_buf->daddr + etr_buf->offset,
+					len1, DMA_FROM_DEVICE);
+		dma_sync_single_for_cpu(real_dev, flat_buf->daddr,
+					len2, DMA_FROM_DEVICE);
+	} else {
+		dma_sync_single_for_cpu(real_dev,
+					flat_buf->daddr + etr_buf->offset,
+					etr_buf->len, DMA_FROM_DEVICE);
+	}
 }
 
 static ssize_t tmc_etr_get_data_flat_buf(struct etr_buf *etr_buf,
-- 
2.25.1

