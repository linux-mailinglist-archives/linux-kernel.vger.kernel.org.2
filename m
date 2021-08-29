Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6D73FAC10
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 15:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhH2NzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 09:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhH2NzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 09:55:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9EFC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 06:54:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso8170989pjq.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lqr/c/gJOKlmwMp84/Zj8cYHaHHr7xgvGVweaxqgfc=;
        b=px45uXQ8O928UUgoarhC5nhS5ZkVYyVy1L+Ooc0rQXifuM0k3bGYU6eel2YUmMIEHS
         vmrMOFxLKAof+MjJf9Vtdj5EbNxOkYodeh4P1Cw+omOWpKKOy7RJkMZktBws3AaY6zm0
         eC8UPbtzm6MlCRGoznklKMH/AKvBLNZp1kNG1PPZRkMcaD+trNyZK37xZhfl3oP5GN1+
         vuyKPhscqDIoNlZY9d6LQMdq4MEkxdNis29ZV+0RXg6mRvNpjqHpdeYOV65zTKuk2+yy
         QXLYe9KY7thl7pPUkfCELXtYFvQEV7GR6jHXoM06pH6EIhVr5mwm5io+Rj+lQmO3/A9y
         HFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lqr/c/gJOKlmwMp84/Zj8cYHaHHr7xgvGVweaxqgfc=;
        b=U6Tr5/t5d2Dd9aG2Yd1LTCzSubHprbFtvUtNPXw8PjwWdJXRTDAloCIagb46WQOAiQ
         RLVdp9RQUL4PrTm5GY6xlzQ/AI85cXgzpsdti18j7Loe3HOfZFGkK/mTupoJPlJ2jHpd
         KQG8aMGNAlH+EET2Z9eCrEJgkToautZuw8HEpaFR9O/i9PLR87VDteghge+OidFiO7xz
         pq3kqzYBoZdpBQP5F6hCn7gd1BssVZEdnq45/cYyczAdbVzFI5gU9C8InxthNtt9CP6p
         8/xnfcmzAfjfrT3Rh7+SkQHJMDAykcdOHh4xQb4x4GSLts+h9fVtzZZpUFNfPh9hWCBK
         6OlQ==
X-Gm-Message-State: AOAM532oFo6cmlued/wSMGitQw+CY/v6kHjPWDIyXS2XOXnagzWm1AcD
        K5+iJ7RnL3Gf6pQoS1IiK/mpDA==
X-Google-Smtp-Source: ABdhPJx+ZDJdsBUjao79CGXAHagErDze4YVIY5UM8EiAsQvl+Q2oGnQTxgtsiZHllBXfK9hl16QVJA==
X-Received: by 2002:a17:90a:4148:: with SMTP id m8mr6107221pjg.185.1630245254036;
        Sun, 29 Aug 2021 06:54:14 -0700 (PDT)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id c11sm8745245pfm.55.2021.08.29.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 06:54:13 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3] coresight: tmc-etr: Speed up for bounce buffer in flat mode
Date:   Sun, 29 Aug 2021 21:54:09 +0800
Message-Id: <20210829135409.186732-1-leo.yan@linaro.org>
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
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---

Changes from v2:
Sync the entire buffer in one go when the tracing is wrap around
(Suzuki);
Add Suzuki's review tage.

Changes from v1:
Set "flat_buf->daddr" to 0 when fails to map DMA region; and dropped the
unexpected if condition change in tmc_etr_free_flat_buf().

 .../hwtracing/coresight/coresight-tmc-etr.c   | 47 ++++++++++++++++---
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 13fd1fc730ed..ac37e9376d2b 100644
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
@@ -648,6 +668,19 @@ static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
 		etr_buf->len = etr_buf->size;
 	else
 		etr_buf->len = rwp - rrp;
+
+	/*
+	 * The driver always starts tracing at the beginning of the buffer,
+	 * the only reason why we would get a wrap around is when the buffer
+	 * is full.  Sync the entire buffer in one go for this case.
+	 */
+	if (etr_buf->offset + etr_buf->len > etr_buf->size)
+		dma_sync_single_for_cpu(real_dev, flat_buf->daddr,
+					etr_buf->size, DMA_FROM_DEVICE);
+	else
+		dma_sync_single_for_cpu(real_dev,
+					flat_buf->daddr + etr_buf->offset,
+					etr_buf->len, DMA_FROM_DEVICE);
 }
 
 static ssize_t tmc_etr_get_data_flat_buf(struct etr_buf *etr_buf,
-- 
2.25.1

