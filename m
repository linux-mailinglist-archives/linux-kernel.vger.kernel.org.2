Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA43B8CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 05:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhGADeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 23:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhGADeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 23:34:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2F1C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 20:31:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso3064930pjp.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 20:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msZY6pO+uLvRbTqbuVyF3DQrdahNkZ8jVvJDp5dVU3s=;
        b=DYKvQ6hZpOoZDvD8UDMBrBXvj+pxsgmW3L8DgiIrg3yjTPzheEaj2URbWltPbYnlhF
         cMbju10ohY2XQOMER+ugw4oHnlLdwvVG1Ow1DrqtNOgJgfu4ogeqLcklLzYVttd179wQ
         VUzghQin/AzmkWCJde+c8VruTozdzCzrHQC8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msZY6pO+uLvRbTqbuVyF3DQrdahNkZ8jVvJDp5dVU3s=;
        b=SW6ZnfjGGhKHH7k8b6qS8ucpIbZAkXqrzzqjuyYQ/yoTCsiqBIGX1OtaTy/1VPaGg6
         zldQoqEgWQbP391ZxYisC5sg3GkNKkax7ewnMlOfh2BN7FKkfukAkNFvdKNId0Dv6+SE
         5de5i4ArZeOjFCUwsEcNXPntNdVonnH1pKMUAj5Qm2kA0FqUrmOkwYgfs57//pMsqmOR
         W8mylViNpgwS8XCKHVLTeXlJEIX+wP/fOgi/uErQrqxdo0ur6/kijCLJSnKzveBA0A7h
         bRc7rbaPwAqk5j7iTVc026Q47377YdOdXFr9U+PmRH6/V2rL5qeS1w+LiF3wHqbieEwr
         e74g==
X-Gm-Message-State: AOAM53198uSV3cCjs+SFgtx2lWY8hqWn23NhSAfcTQAe1UUw9G0dYz6d
        x2uknHRIwF9U1sQWsgMabm2PaA==
X-Google-Smtp-Source: ABdhPJyanoqZrCB0SBzIK5zDm2qE63p7f/l1im/uldvXoZUM091XEExr7njiU/Wrt3I965MfX2PXvw==
X-Received: by 2002:a17:902:8484:b029:101:7016:fb7b with SMTP id c4-20020a1709028484b02901017016fb7bmr34305896plo.23.1625110297157;
        Wed, 30 Jun 2021 20:31:37 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:9ab6:fd5:daf0:6742])
        by smtp.gmail.com with UTF8SMTPSA id y7sm24143599pfy.153.2021.06.30.20.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 20:31:36 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, Will Deacon <will@kernel.org>,
        sstabellini@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Claire Chang <tientzu@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4] swiotlb: fix implicit debugfs declarations
Date:   Thu,  1 Jul 2021 11:31:30 +0800
Message-Id: <20210701033130.82308-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the debugfs bits from rmem_swiotlb_device_init() into a separate
rmem_swiotlb_debugfs_init() to fix the implicit debugfs declarations.

Fixes: 461021875c50 ("swiotlb: Add restricted DMA pool initialization")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0ffbaae9fba2..b7f76bca89bf 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -712,6 +712,21 @@ late_initcall(swiotlb_create_default_debugfs);
 #endif
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
+
+#ifdef CONFIG_DEBUG_FS
+static void rmem_swiotlb_debugfs_init(struct reserved_mem *rmem)
+{
+	struct io_tlb_mem *mem = rmem->priv;
+
+	mem->debugfs = debugfs_create_dir(rmem->name, debugfs_dir);
+	swiotlb_create_debugfs_files(mem);
+}
+#else
+static void rmem_swiotlb_debugfs_init(struct reserved_mem *rmem)
+{
+}
+#endif
+
 struct page *swiotlb_alloc(struct device *dev, size_t size)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
@@ -766,11 +781,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 		rmem->priv = mem;
 
-		if (IS_ENABLED(CONFIG_DEBUG_FS)) {
-			mem->debugfs =
-				debugfs_create_dir(rmem->name, debugfs_dir);
-			swiotlb_create_debugfs_files(mem);
-		}
+		rmem_swiotlb_debugfs_init(rmem);
 	}
 
 	dev->dma_io_tlb_mem = mem;
-- 
2.32.0.93.g670b81a890-goog

