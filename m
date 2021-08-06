Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4983E28BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbhHFKgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245180AbhHFKfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:35:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81860C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:35:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e21so6500928pla.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1mq8OVdPA80W1OExBfSV/W93H3mior+3W3/MDGRcPA=;
        b=WiK7nCyqlQFTBMZR9JJTdkj1kZjISOnsxD0sZZqZRttMOKdD7tNOx7SohDYrRPB/vS
         jVshrw+ma253776vxv7OuO7qNXWcABcU9y+C+lqyPYQa0LhHzQS7sqOiH4iyzJSxuHLw
         zBNXvOo7bxz4tkV1givX47JWukXhflrU29vCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1mq8OVdPA80W1OExBfSV/W93H3mior+3W3/MDGRcPA=;
        b=Qn1cmm+6s6Muz9vR7bU47ZCQ3UYOfjt4+nXf2/XbTbYsKzViT8rg8wRtT5sTZ6Np5s
         1sTTxEIICwVIwMua7mWbSLXkeYq1usHu2dqKfF45oiZZj32hP0749BljNVNSZflS8Kaw
         x4qtDeQicDeJm41SYeWdSBEe5CaL0pAatxQTNdO/ySkE8nrcoTRg1rK/ZFJF10yWXF0r
         KQL7+zLMBkdJtSCC2zACyetvxWcQN9PttjEokrmVvLITTc0qYHW5EDY+2Wk2RFmhimWZ
         avod1Fw4jhI/i4uH3LaAO4LC65MKdxldx8I+t58zzMdayFv+KthX55NI+Ks6yJUZHLjC
         Wn9A==
X-Gm-Message-State: AOAM532/0BEHE9B7j91hM9OgkeKtKlbPlO9c9l9T3fRl0Rv9ArIwJy1R
        woUqyU4vfonmwNfSdaUEQ5dpCA==
X-Google-Smtp-Source: ABdhPJxXz1rKwjtjRyr6RAhIU4x/csYMr6Flkwf754fyqLMJNih4b/f9Y7xhRTLzhRZpZaHngGi3BA==
X-Received: by 2002:a17:90a:138f:: with SMTP id i15mr9796044pja.173.1628246126098;
        Fri, 06 Aug 2021 03:35:26 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6f20:cf00:347a:afc2])
        by smtp.gmail.com with UTF8SMTPSA id x24sm12172935pjk.43.2021.08.06.03.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 03:35:25 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 8/9] dma-mapping: add persistent streaming mapping flag
Date:   Fri,  6 Aug 2021 19:34:22 +0900
Message-Id: <20210806103423.3341285-9-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806103423.3341285-1-stevensd@google.com>
References: <20210806103423.3341285-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Add a DMA_ATTR_PERSISTENT_STREAMING flag which indicates that the
streaming mapping is long lived and that the caller will manage
coherency either through the dma_sync_* functions or via some other
use-case specific mechanism. This flag indicates to the platform that
it should optimize for more efficient syncing at the cost of more
expensive mapping and unmapping.

This flag is used to skip optional bounce buffers when
CONFIG_IOMMU_BOUNCE_BUFFERS is enabled. With respect to these bounce
buffers, in most cases the flag is an optimization. However, callers
which do not use the dma_sync_* calls to manage coherency must use this
flag to work properly when CONFIG_IOMMU_BOUNCE_BUFFERS is enabled.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/io-bounce-buffers.c | 14 +++++++++++---
 include/linux/dma-mapping.h       | 11 +++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-bounce-buffers.c b/drivers/iommu/io-bounce-buffers.c
index af8c2a51eeed..3a0071d5a9ea 100644
--- a/drivers/iommu/io-bounce-buffers.c
+++ b/drivers/iommu/io-bounce-buffers.c
@@ -409,8 +409,16 @@ static bool io_bounce_buffers_map_buffer(struct io_bounce_buffers *buffers,
 	return mapped >= info->size;
 }
 
-static bool use_bounce_buffer(bool force_bounce, size_t size)
+static bool use_bounce_buffer(struct device *dev, unsigned long attrs,
+			      bool force_bounce, size_t size)
 {
+	if (attrs & DMA_ATTR_PERSISTENT_STREAMING) {
+		WARN_ONCE(force_bounce,
+			  "Skipping bounce buffer for untrusted mapping %s\n",
+			  dev_name(dev));
+		return false;
+	}
+
 	if (IS_ENABLED(CONFIG_IOMMU_BOUNCE_BUFFERS) &&
 	    size <= always_bounce_limit)
 		return true;
@@ -429,7 +437,7 @@ bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
 	bool force_bounce = buffers->untrusted &&
 			    iova_offset(buffers->iovad, offset | size);
 
-	if (!use_bounce_buffer(force_bounce, size))
+	if (!use_bounce_buffer(dev, attrs, force_bounce, size))
 		return false;
 
 	*handle = DMA_MAPPING_ERROR;
@@ -476,7 +484,7 @@ bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
 				buffers->iovad, iter->offset | iter->length);
 	}
 
-	if (!use_bounce_buffer(force_bounce, size))
+	if (!use_bounce_buffer(dev, attrs, force_bounce, size))
 		return false;
 
 	*out_nents = 0;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 183e7103a66d..5d318753bb79 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -61,6 +61,17 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_PERSISTENT_STREAMING: Indicates that the streaming mapping is long
+ * lived, so syncing performance should be prioritized over mapping/unmapping
+ * performance. Platform code will establish a mapping which only requires CPU
+ * cache synchronization.
+ *
+ * Callers that create long lived mappings and directly handle CPU cache
+ * management without calling using dma_sync_* functions must set this flag.
+ */
+#define DMA_ATTR_PERSISTENT_STREAMING	(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
-- 
2.32.0.605.g8dce9f2422-goog

