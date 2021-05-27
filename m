Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3047392E87
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhE0NAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhE0NAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:00:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F0AC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:59:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso2351451pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBa4WmaBqBXHvL8MxFx8fqbv9G1UK9TFNo0t6ZyBRps=;
        b=H8QKHfGZsWxCHEy5cA1tQcGKb44EP5b2zAEgNghokxkbg+whP74qNT9pCynan1YB4C
         ODR1VCmnmaAcY81RiH4rrdh2ogtLXiV4eZN6Qr0E0GHPsI2d+SkbVqT8pWRXMc0PJZWW
         P9APiIrxJsEIWE0eMgqeltDq17QR2UGVMSiSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBa4WmaBqBXHvL8MxFx8fqbv9G1UK9TFNo0t6ZyBRps=;
        b=c9oRCqUJHIHSwXJ5Boj8M8LkWPZbNybwh+7rODWlyRGpQlYW+YSOxgYLlqKb6hUXB9
         9HwxnVcYmbL++Y49GmMKQpXvIMj7MLAVAlM88FazkZ1qFZ4KdJwyyCF2I9G5C3mzTrYR
         a0C7+iy8s+WRb4kXxvSyDN/WYe1k9uCSLw2kkEZ+FXE23Z5MPXiGkWCuAlw71/ciEEh1
         0K/Wu+5gly/5tc3uymEzNo+aXYRPq4GRUwFH+OsF+RR73ZQituOV0Lw7EckmHA2jFi1V
         pIOzLTQbPsV88MScv2S1gYwOFiYdA5PzcdnfjgNL6dXA0J03+SoxhhHY/E6Ti4cEAflB
         YhQQ==
X-Gm-Message-State: AOAM5327SbrgnEOP39SytIeq41NA+Q+7aRFLM9kVqE8U608hXCi2JMZi
        7WLHfPqBZz5jL5fybYF45hNHfA==
X-Google-Smtp-Source: ABdhPJwy7gpYKip34XTwi+RiwqWb6k5jmIQ4n8vVEEugdkMYxDsCVe/LaGvOwoAOLDbCetdBwhFgLQ==
X-Received: by 2002:a17:90b:190b:: with SMTP id mp11mr9025962pjb.77.1622120353025;
        Thu, 27 May 2021 05:59:13 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:a93:378d:9a9e:3b70])
        by smtp.gmail.com with UTF8SMTPSA id r10sm2150201pga.48.2021.05.27.05.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 05:59:12 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH v8 02/15] swiotlb: Refactor swiotlb_create_debugfs
Date:   Thu, 27 May 2021 20:58:32 +0800
Message-Id: <20210527125845.1852284-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527125845.1852284-1-tientzu@chromium.org>
References: <20210527125845.1852284-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the debugfs creation to make the code reusable for supporting
different bounce buffer pools, e.g. restricted DMA pool.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d3232fc19385..b849b01a446f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -64,6 +64,7 @@
 enum swiotlb_force swiotlb_force;
 
 struct io_tlb_mem *io_tlb_default_mem;
+static struct dentry *debugfs_dir;
 
 /*
  * Max segment that we can provide which (if pages are contingous) will
@@ -662,18 +663,30 @@ EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
 #ifdef CONFIG_DEBUG_FS
 
-static int __init swiotlb_create_debugfs(void)
+static void swiotlb_create_debugfs(struct io_tlb_mem *mem, const char *name)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
-
 	if (!mem)
-		return 0;
-	mem->debugfs = debugfs_create_dir("swiotlb", NULL);
+		return;
+
+	mem->debugfs = debugfs_create_dir(name, debugfs_dir);
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
+}
+
+static int __init swiotlb_create_default_debugfs(void)
+{
+	struct io_tlb_mem *mem = io_tlb_default_mem;
+
+	if (mem) {
+		swiotlb_create_debugfs(mem, "swiotlb");
+		debugfs_dir = mem->debugfs;
+	} else {
+		debugfs_dir = debugfs_create_dir("swiotlb", NULL);
+	}
+
 	return 0;
 }
 
-late_initcall(swiotlb_create_debugfs);
+late_initcall(swiotlb_create_default_debugfs);
 
 #endif
-- 
2.31.1.818.g46aad6cb9e-goog

