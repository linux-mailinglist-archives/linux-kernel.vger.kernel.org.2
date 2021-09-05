Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C24400DDB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 05:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhIEDXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 23:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhIEDW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 23:22:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFAFC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 20:21:57 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id n18so3149040pgm.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 20:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/gerKdrKZe0vTryyiju4nrlBJe7KcLhAqRYTVCfauU=;
        b=V/9277Ev9IgrpJGZG5cuEjoYmo01JmbLLtjDZLZb261ERG7HexloC+xgCVFkS+Kqnm
         F/JiG2x0o5rFgNro4kjakWXIxNi/O/W+EUKhCS53NEm+mYMWHa/jjHAmdYz7Azc/Nw2t
         6x5NibuFwef9uV9Xz48dvzq594k9RMSpuRxVt+5qPWsfWeLUV5UF+Bugfsqmcup8NmK9
         SLYJNy7V2TWlUyfMi+4PPJtAdWLebCu6k6BYcfbVPhLaa8At/R07jjYI8FPBj8dIw7ua
         yTXawlOcO/9UelaHi2GvBNK/F9nrgqYb4uG2KYknpeMhPuMtrgyvh31IlvUdZBG02yYu
         EPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/gerKdrKZe0vTryyiju4nrlBJe7KcLhAqRYTVCfauU=;
        b=D6H4fRindHDsh0BLG2QtbrebnkSAqU2H38rz3et81uox7k+loV//XZ3YoRudD/u0VM
         htrjCD1y6++iJ3UkTwgmZe8lS5hCbqjCvU30DLznZ0WeTzQ7Prp+P6KIc4kJnZ29h9qB
         hz+ZEkZFr8nLd2G0zhSw2xTyU6xpaolAsJobILS0PhWQtGrtZ9PMgy3QuJujIGdkzUeN
         Ra/8NPnNu9KPZwZKX1oXkTAxP505TbMsBfN8xZkfE4OTdhiQhXGNd8Tw4Ka/TbA9nnei
         28uaKy2h4Dq+ccUX1oKO4GB86O2jcyMVQufNOV/0VWjnYRboZDyVfBGISGz2nMpxNSXP
         jeWQ==
X-Gm-Message-State: AOAM531uwF3zlWZpDpmgOtp9nVygG7HlbUofjUIlmq81BOlfX0/zsojr
        gPproFqZ2qk+aNVoExZxP86qOA==
X-Google-Smtp-Source: ABdhPJyr5N0kHuWsgI2T1HNJZwUFesDD4hhKas8ngvC6PFP2eD5GtZ7jnC0HmwNLF8PkUR5egT6ywA==
X-Received: by 2002:a62:1c96:0:b0:3f5:e01a:e47 with SMTP id c144-20020a621c96000000b003f5e01a0e47mr9960844pfc.76.1630812115633;
        Sat, 04 Sep 2021 20:21:55 -0700 (PDT)
Received: from localhost ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id b27sm253327pfr.121.2021.09.04.20.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 20:21:54 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4] coresight: tmc-etr: Speed up for bounce buffer in flat mode
Date:   Sun,  5 Sep 2021 11:21:44 +0800
Message-Id: <20210905032144.966766-1-leo.yan@linaro.org>
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

This patch changes to allocate pages with dma_alloc_noncoherent(), the
driver can access the memory via cacheable mapping; therefore, load
instructions can fetch data from cache lines rather than always read
data from DRAM, the driver can boost memory performance.  After using
the cacheable mapping, the driver uses dma_sync_single_for_cpu() to
invalidate cacheline prior to read bounce buffer so can avoid read stale
trace data.

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
  2) # 2525.420 us |  }

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---

Changes from v3:
Refined change to use dma_alloc_noncoherent()/dma_free_noncoherent()
(Robin Murphy);
Retested functionality and performance on Juno-r2 board.

Changes from v2:
Sync the entire buffer in one go when the tracing is wrap around
(Suzuki);
Add Suzuki's review tage.

 .../hwtracing/coresight/coresight-tmc-etr.c   | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index acdb59e0e661..a049b525a274 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -609,8 +609,9 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 	if (!flat_buf)
 		return -ENOMEM;
 
-	flat_buf->vaddr = dma_alloc_coherent(real_dev, etr_buf->size,
-					     &flat_buf->daddr, GFP_KERNEL);
+	flat_buf->vaddr = dma_alloc_noncoherent(real_dev, etr_buf->size,
+						&flat_buf->daddr,
+						DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!flat_buf->vaddr) {
 		kfree(flat_buf);
 		return -ENOMEM;
@@ -631,14 +632,18 @@ static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
 	if (flat_buf && flat_buf->daddr) {
 		struct device *real_dev = flat_buf->dev->parent;
 
-		dma_free_coherent(real_dev, flat_buf->size,
-				  flat_buf->vaddr, flat_buf->daddr);
+		dma_free_noncoherent(real_dev, etr_buf->size,
+				     flat_buf->vaddr, flat_buf->daddr,
+				     DMA_FROM_DEVICE);
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
@@ -648,6 +653,19 @@ static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
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

