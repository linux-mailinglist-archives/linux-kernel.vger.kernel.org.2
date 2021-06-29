Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B06D3B71ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhF2MTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhF2MTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:19:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B7AC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 05:16:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cx9-20020a17090afd89b0290170a3e085edso2321457pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JTFvXmTEK7ZNerH/JtM4n3rDUhmzB5t0n3YIuLeO91E=;
        b=P/Cem1OLebedCiFEzX+z+nyRcO8XCyCPwO2cT6NQpGSax1j38jYuB8ZxuzUMG550QJ
         N6AXqDrucmMBL3XOHkMnUUI8oG2yZmO2NzfzH3OQw+xxF2UUZp6CDJa2vRxgtl0nSOgg
         A81exZpPokUUyZawnZohBg9MTXxaHuGNY+rx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JTFvXmTEK7ZNerH/JtM4n3rDUhmzB5t0n3YIuLeO91E=;
        b=F9CcF289mGbrfS0/VtM3NmAdx2byi3/pMGOU3gEdmHBX6zGW+NxN7ffOmKndE1tAyr
         greeoVxTQL4pgSk7dn5pI315tXufRxAWjzqP+lhZMLmnxOSW5H2owaxPB/9mSAPK17WI
         Smwfszw82f6Jd85TdZjZ9oAZ0w95DqK/95fyls3QQviSTymVL6AjSfKqDROpS98dA8YI
         z17CjP/1hl+BR5aY/ustBGgBPv+udTcDv7mdEP/rgEg4QFfs3CXk0fvkHOmIbEPVKERH
         pK8egq4bfwetXE0gqFaQ2moVfYZ6blS5wKJjq6U2ao+315ROVAQAQRM+k+QR0gOxB7iM
         WuAQ==
X-Gm-Message-State: AOAM530EX6p+9lQSVQ3bKl8J8yqUSCtl9/OlnQoLfn1rJY1olEJGKl8+
        U/PJxYt2zaWiyhBeriwMuQp8ag==
X-Google-Smtp-Source: ABdhPJzbJDsgus4m2r74nhMTRhIy44L6PLzl+efQb5XZsUNrh6rba/6GUjo5ZaMgftY7iMWaxmMhLQ==
X-Received: by 2002:a17:90b:605:: with SMTP id gb5mr13165548pjb.62.1624968992397;
        Tue, 29 Jun 2021 05:16:32 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:3adb:8783:d6da:e6ca])
        by smtp.gmail.com with UTF8SMTPSA id x20sm7319646pge.41.2021.06.29.05.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 05:16:31 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, Will Deacon <will@kernel.org>,
        sstabellini@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Claire Chang <tientzu@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] swiotlb: fix implicit debugfs_create_dir declaration
Date:   Tue, 29 Jun 2021 20:16:25 +0800
Message-Id: <20210629121625.3633999-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ifdef to fix implicit function declaration for other pools.

Fixes: 1d9f94400a7a ("swiotlb: Refactor swiotlb_create_debugfs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0ffbaae9fba2..8ae0bef392c3 100644
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
@@ -686,7 +684,6 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
-#ifdef CONFIG_DEBUG_FS
 static struct dentry *debugfs_dir;
 
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
@@ -709,8 +706,6 @@ static int __init swiotlb_create_default_debugfs(void)
 
 late_initcall(swiotlb_create_default_debugfs);
 
-#endif
-
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 struct page *swiotlb_alloc(struct device *dev, size_t size)
 {
-- 
2.32.0.93.g670b81a890-goog

