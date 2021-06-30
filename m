Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB373B7C62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 06:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhF3EIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 00:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 00:08:52 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC33C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 21:06:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s14so1271216pfg.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vBJD4JFUNrU/4Zr4GHTZ0cbKWbsN7ynXpqMyWSZuNks=;
        b=dwNl699PBL5B58FmaDpVfL75n8ZRKUXs2RNoJqAhVYMvToRUCqOPdJslYwxpyi8x/o
         PUG7M7nd3CueZnEyY1roDTdHocmQob3cdTJTB/XJooAVzdHxjFqMsFFnq7MmpDNQxBsC
         59fIJvd6H6q/qwTjGKOk57dw/7R583m8iL3Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vBJD4JFUNrU/4Zr4GHTZ0cbKWbsN7ynXpqMyWSZuNks=;
        b=dA7nGdZiwVbpD7Yq7U+YcWewXkTNglvhdg2oGAWx/9q81G4EsmUE/H4FliF+Dy2OFu
         NF6CX9/30FnBE1tFrU9SUPBfPqtKX3z46caUFfbm47/65WdH78kbRxcvIxMAMc/P2NH+
         4LbuGTeSQ7CjHSvBjLaOu1/ZTuOBHZ2Q4YU3dmeKZMk51xS3uUa9bVJ7E/KPodXSkqDX
         uy1vJ2uTfWWAsLHEED3Enc7c0PzIkKTgKT/ZkxCPuUj+ColG84UUtWOR2xms4R5NeAFf
         iKwQ0WXUlG6i6aidnlBZFIPKzKYWReeEHaLq1aPGiXdg19VHS7QxP38GFbZWP9yLQKWQ
         h+sg==
X-Gm-Message-State: AOAM532aJG6Y0CDF2ZgjnA5sWV58I3U+e4FlM3y1Yygvn0oNtmyPToO3
        9eONwTjZ/yLIoSa43TWP2LT1iA==
X-Google-Smtp-Source: ABdhPJyDNSfiMLEx1IjDrOQBQe0ELtIJOclgwIvSOu8aXf3zCZlrspUVX6l2BzINSKHYgZOnxNzdQg==
X-Received: by 2002:a63:f609:: with SMTP id m9mr9895587pgh.74.1625025982775;
        Tue, 29 Jun 2021 21:06:22 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:94c8:1447:c37c:e392])
        by smtp.gmail.com with UTF8SMTPSA id b25sm19665184pft.76.2021.06.29.21.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 21:06:22 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, Will Deacon <will@kernel.org>,
        sstabellini@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Claire Chang <tientzu@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] swiotlb: fix implicit debugfs_create_dir declaration
Date:   Wed, 30 Jun 2021 12:06:15 +0800
Message-Id: <20210630040616.3914990-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the debugfs bits from rmem_swiotlb_device_init() into a separate
rmem_swiotlb_debugfs_init().

Fixes: 461021875c50 ("swiotlb: Add restricted DMA pool initialization")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0ffbaae9fba2..355dc98d381c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -709,6 +709,16 @@ static int __init swiotlb_create_default_debugfs(void)
 
 late_initcall(swiotlb_create_default_debugfs);
 
+static void rmem_swiotlb_debugfs_init(const char *name, struct io_tlb_mem *mem)
+{
+	mem->debugfs = debugfs_create_dir(name, debugfs_dir);
+	swiotlb_create_debugfs_files(mem);
+}
+#else
+__maybe_unused static void rmem_swiotlb_debugfs_init(const char *name,
+						     struct io_tlb_mem *mem)
+{
+}
 #endif
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
@@ -766,11 +776,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 		rmem->priv = mem;
 
-		if (IS_ENABLED(CONFIG_DEBUG_FS)) {
-			mem->debugfs =
-				debugfs_create_dir(rmem->name, debugfs_dir);
-			swiotlb_create_debugfs_files(mem);
-		}
+		if (IS_ENABLED(CONFIG_DEBUG_FS))
+			rmem_swiotlb_debugfs_init(rmem->name, mem);
 	}
 
 	dev->dma_io_tlb_mem = mem;
-- 
2.32.0.93.g670b81a890-goog

