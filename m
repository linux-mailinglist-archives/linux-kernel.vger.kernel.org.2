Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D03BE407
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhGGH6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhGGH6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:58:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF3DC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 00:55:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p17so84062plf.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cToOui4d+OiABBRcG8ci3JrCJ5BQZEaQcOXHYFcfixY=;
        b=Y577CLwATY/3F7YXuLJcuDjsBRjJ+1FtjazpSrT89WalorRG93N/J6qBhjLWCNYT7m
         aIxrlk1dkoZFedgFnVw226XxMNJ2H0IYuvwj95T3SelmL6HkW1rYWMe7LMo7DC8tl2oO
         iegPa741y9SwsFEwxOf4fMPTzEeKLrm3mWP7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cToOui4d+OiABBRcG8ci3JrCJ5BQZEaQcOXHYFcfixY=;
        b=D8eFxdRRLVihoLOTyBMJxTXcumDgsOoB6RtrRxTSMoJIFety4GZnjfVDs+yrgLt+WJ
         tVXTi3gBjn7vSxxjPkBpKUvTHjM+IPsheCCem9g6UYlBw2J4LsF2GF4eG1SIykwHGkbx
         SbwNgmE7FvKhcFfqjWbzbJ2RFFFoD98FJdJVuPgbzYpjFBqkl27V4WZLws5jWVREucnc
         905p+AqG5+NseulUZiTyoqMP0LSTrYudnhPi3Adv4ZCkLCIoqwa6H2Y7paw5/XM0frbT
         ajhFuWujsZN/WbhcnqnItR5PZ9/ajuPPNfe8tVCGxwDXfTgR7GMcjo6kwvdR8dV+kOPe
         szFQ==
X-Gm-Message-State: AOAM532ZXzN/4mUesOZEPGQOOepABeJfWyPlOuof8fz1tdhnKm5AyOVO
        XjRspoecYHJBvZ3q2tjZBIVort9HJOLJjQ==
X-Google-Smtp-Source: ABdhPJytwgB4PyVy/jCTPPLKNdsrNeknF2nCwebdVINIzGapAzHQp2ce15AkhnT6tXL1YPoeVHUnKA==
X-Received: by 2002:a17:90a:a107:: with SMTP id s7mr4699704pjp.1.1625644533123;
        Wed, 07 Jul 2021 00:55:33 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:355a:c470:1237:e5f4])
        by smtp.gmail.com with UTF8SMTPSA id q18sm19276962pfj.178.2021.07.07.00.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 00:55:32 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH 2/4] dma-iommu: replace device arguments
Date:   Wed,  7 Jul 2021 16:55:03 +0900
Message-Id: <20210707075505.2896824-3-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210707075505.2896824-1-stevensd@google.com>
References: <20210707075505.2896824-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Replace the struct device argument with the device's nid in
__iommu_dma_alloc_pages, since it doesn't need the whole struct. This
allows it to be called from places which don't have access to the
device.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 00993b56c977..98a5c566a303 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -592,12 +592,12 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 	kvfree(pages);
 }
 
-static struct page **__iommu_dma_alloc_pages(struct device *dev,
+static struct page **__iommu_dma_alloc_pages(
 		unsigned int count, unsigned long order_mask,
-		gfp_t page_gfp, gfp_t kalloc_gfp)
+		unsigned int nid, gfp_t page_gfp, gfp_t kalloc_gfp)
 {
 	struct page **pages;
-	unsigned int i = 0, nid = dev_to_node(dev);
+	unsigned int i = 0;
 
 	order_mask &= (2U << MAX_ORDER) - 1;
 	if (!order_mask)
@@ -680,8 +680,8 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 		alloc_sizes = min_size;
 
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
-					gfp, GFP_KERNEL);
+	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT,
+					dev_to_node(dev), gfp, GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
-- 
2.32.0.93.g670b81a890-goog

