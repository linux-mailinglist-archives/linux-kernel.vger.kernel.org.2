Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA943C335C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 09:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhGJHEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhGJHEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:04:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D6FC0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 00:01:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p17so5674173plf.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 00:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRxQ1Imlo1o6LoMENe44lEkVB1Lq1SxOmIRVr1+XIjk=;
        b=udQugjiUxnU3JISFgL6nJ6aj9D/VOokdRj5eO0ztnkzYoIc/vjxZEDA3lDgNyKMK92
         FmwQvaQyanxs+QtuVdGpzna/iukRnMQeubegP7AT3HgetTU5/gq8Bj5l5IdB2sXnzk2g
         oukC4Re0Odm4tpIteHr+pDbyK/qLudApX3ceLG6r13jlcYBXoQHw08AB9zNPa/4zhpe1
         Szzy4c9/M4jTvzRSE+QFe9cOthuc9SnwZzSvcGxf2/X/VkSnrSJ8c308KMhtlrF9zlBd
         zpibiuW78KMrmp1WtFbOjja2TXup1mwfcmv3WXSgzLeBP2BFFwGaELOCgtiCJmsO0QcK
         iN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRxQ1Imlo1o6LoMENe44lEkVB1Lq1SxOmIRVr1+XIjk=;
        b=KT+UJOl7YJ/JzfsXvGSu/hUZebhBK+nsNgFsqZzEgwI/9GmnHEPbY6MoszQV5E0nBW
         WwNEIRSxTr0HeDbs/e8H+k0YwikBY/l7SXX6G/9lk/R8BmEbmuiS/Jw3yMVGxYMsocrG
         Pcn34gID7bmyUk0OfY16TNfj+YpVLXhIgJACdi09iyOwVEYS0wtF1VhCA2E901a9VW1z
         wIj/TDmQPu0jdvuR8Z0VTQb8QLH3RuGrcslSXmknbl2bP4FAoiO1cpEwycBc31gqzIwW
         ji5dnstNkxYbBQ82VuYom75vPRShafPm1fbBul23DTXspxstCGOu1riVauRP8YtzpRjK
         m1XA==
X-Gm-Message-State: AOAM5309r7NqXeRsp7ANl7km4RUuklHn1hnCQLOUFU7TxliE6dPOvhIG
        9Whmmz43JD0WO9JxCtHiJduNXA==
X-Google-Smtp-Source: ABdhPJzeLdFdrL3o+iTQzpKjSswpyEDkSHrKAXiwU//V6MR7B6JcAnlmtkdY2yecpASQ+7+f3Jey3g==
X-Received: by 2002:a17:902:9695:b029:117:2072:88a8 with SMTP id n21-20020a1709029695b0290117207288a8mr34410670plp.64.1625900479991;
        Sat, 10 Jul 2021 00:01:19 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id m13sm8179970pfo.102.2021.07.10.00.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 00:01:19 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] coresight: tmc-etr: Speed up for bounce buffer in flat mode
Date:   Sat, 10 Jul 2021 15:01:15 +0800
Message-Id: <20210710070115.462674-1-leo.yan@linaro.org>
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

Changes from v1:
Set "flat_buf->daddr" to 0 when fails to map DMA region; and dropped the
unexpected if condition change in tmc_etr_free_flat_buf().

 .../hwtracing/coresight/coresight-tmc-etr.c   | 56 ++++++++++++++++---
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index acdb59e0e661..888b0f929d33 100644
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
@@ -609,11 +611,18 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 	if (!flat_buf)
 		return -ENOMEM;
 
-	flat_buf->vaddr = dma_alloc_coherent(real_dev, etr_buf->size,
-					     &flat_buf->daddr, GFP_KERNEL);
-	if (!flat_buf->vaddr) {
-		kfree(flat_buf);
-		return -ENOMEM;
+	aligned_size = PAGE_ALIGN(etr_buf->size);
+	flat_buf->pages = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO,
+					   get_order(aligned_size));
+	if (!flat_buf->pages)
+		goto fail_alloc_pages;
+
+	flat_buf->vaddr = page_address(flat_buf->pages);
+	flat_buf->daddr = dma_map_page(real_dev, flat_buf->pages, 0,
+				       aligned_size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(real_dev, flat_buf->daddr)) {
+		flat_buf->daddr = 0;
+		goto fail_dma_map_page;
 	}
 
 	flat_buf->size = etr_buf->size;
@@ -622,6 +631,12 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
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
@@ -630,15 +645,20 @@ static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
 
 	if (flat_buf && flat_buf->daddr) {
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
@@ -648,6 +668,28 @@ static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
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

