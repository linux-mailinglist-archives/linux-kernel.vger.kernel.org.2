Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECBE3B6F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhF2IOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhF2IN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 04:13:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482EBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 01:11:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g24-20020a17090ace98b029017225d0c013so95988pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZ7Eych3eQIlfh+/2Dgt3JxjlYh8mhidB3EhZ1LJg5c=;
        b=iFPEbA8zgUYfgyJoITZ74CL2TVC6IEoPhXSOY36VdqsimRVnR28PiSeFaghcurm+vA
         c6D7TG3UumCGZURl8jL1rLNGqN3+zI0JtDcOTiLbOR7pPIfN8jtNV0GPjeiKoKP0+mN+
         pVFfIVa8qShaj51VryS1rVOhwdgOOchqhuNpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZ7Eych3eQIlfh+/2Dgt3JxjlYh8mhidB3EhZ1LJg5c=;
        b=MJW/8e2b7jZe3K3r0VnZv54VrvhhCLP1tCHa87kcVKYiQlHmZJx30Rw7IqrbfbHdHb
         CN9YlC9Q3KdUSU2+sTRfDDUGy/2N/nd2mCsb+Sz+snmnI5IiS7IRzN1qEeNqvXrJmt2e
         Iz70WXVeh42HAPQnNwVVSAFEoYMR9U5+gWft5f0ZHOx7vZsn41Cq1fVTi7qUHYAGnX22
         1zE6PhkpDFou+TEU3cJhWkYjV7iSpdI9wgnZ3My0dbhvFL9DhpxiYMOEl0PVM/54MGSX
         MmMZGfq5O9qrxRAvjmeVkecagQO8c1VG6kgt8BgU3eNNhUs6grdpokGgdn6z7xWYez2b
         F8Mg==
X-Gm-Message-State: AOAM5335TDHlp4EJCGDfFTkyWQZ1vWTLUy/Oq57FHUJbXmiBeVsodR60
        qh7YELyxvjLYHrp5N+0tIi0Qkg==
X-Google-Smtp-Source: ABdhPJw1FVWlWOx5X6EYkjASANlLpC8tRNRt7cR/woChlKwIfBoBkiDo1jmCzD+pRBe1ktNKZS0LAA==
X-Received: by 2002:a17:902:ea12:b029:128:977b:fa78 with SMTP id s18-20020a170902ea12b0290128977bfa78mr20661461plg.15.1624954291887;
        Tue, 29 Jun 2021 01:11:31 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:3adb:8783:d6da:e6ca])
        by smtp.gmail.com with UTF8SMTPSA id m21sm1992037pjz.57.2021.06.29.01.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 01:11:31 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Claire Chang <tientzu@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] swiotlb: fix implicit debugfs_create_dir declaration
Date:   Tue, 29 Jun 2021 16:11:24 +0800
Message-Id: <20210629081124.3585539-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __maybe_unused instead of ifdef to fix implicit function declaration
for other pools.

Fixes: 1d9f94400a7a ("swiotlb: Refactor swiotlb_create_debugfs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0ffbaae9fba2..508b678f6448 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,9 +36,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
-#ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
-#endif
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 #include <linux/io.h>
 #include <linux/of.h>
@@ -686,10 +684,9 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
-#ifdef CONFIG_DEBUG_FS
-static struct dentry *debugfs_dir;
+__maybe_unused static struct dentry *debugfs_dir;
 
-static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
+__maybe_unused static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
 {
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
@@ -709,8 +706,6 @@ static int __init swiotlb_create_default_debugfs(void)
 
 late_initcall(swiotlb_create_default_debugfs);
 
-#endif
-
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 struct page *swiotlb_alloc(struct device *dev, size_t size)
 {
-- 
2.32.0.93.g670b81a890-goog

