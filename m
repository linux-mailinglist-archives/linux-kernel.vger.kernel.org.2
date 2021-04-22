Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08451367C49
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhDVIRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhDVIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:17:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03312C06138F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:17:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id kb13-20020a17090ae7cdb02901503d67f0beso2334238pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=II4tcMZ5Sw7jMUCuMNHItr2ESdAma+cudK/mj3wTE4E=;
        b=g67oZjS4DG+MlBHAj5fP4OXD/aByavtOTh4g+oC1qn1ppqQSBF1tkJ0F6VjeXpk7XZ
         dMZktmKOrk4Wn3QuYuQVSUq0o7o1vo2ytqYa1fC1S3W1yzuB1Vnkl8D9OUsD3jSSHINJ
         bA/iMCQ6pIa/UrEFSh4rBJKrVOhYdlsthwSBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=II4tcMZ5Sw7jMUCuMNHItr2ESdAma+cudK/mj3wTE4E=;
        b=IKOjshgD947Nk/5OVMZKOUwFq96Wx1rWUOVkjBHrvh0J6w5dJdbqraRPkEVNS5Zaqd
         feQGh4ARtXX5rUVJOxXqLSk7PP/DnDtVEBmLM+yJ3kAQBq4RsKc/EgViQPOMnOlm6Y42
         usVnjAjjPKDMWncLjfjNtjsbAKMyBfIpPkQzlE4gSIoRV6NSIR05d+FmKFXSiPjT4UFx
         9iarTBKMejpIEVCb1z85mapexH9J5y9N/lwHSTiL+X1yxj/rb00Iz0vS14XXIw8CH3en
         GPpCjEpm/HISQe5DbbRRqAagzXvl/j2JobqIRvYR2WVly72+DDmtIwwwbb9vr1SNJQyO
         ZLJQ==
X-Gm-Message-State: AOAM533BmfC4Eq29oqbJEw9p90QiJVr5OIg6zHoRVjuE7DbLz7vIjGrs
        +Cr7Yrd+7pW0dqGa1BfY/DFi0A==
X-Google-Smtp-Source: ABdhPJydBgDAieBYh/9Ynn+xY2fjE6IZW8L2sy0R9JNHtf8kZ7Y8TDb9J+jJ/cnp9RtKMkr9CXa+fg==
X-Received: by 2002:a17:90b:812:: with SMTP id bk18mr2736214pjb.145.1619079421594;
        Thu, 22 Apr 2021 01:17:01 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:1a8e:1bde:f79e:c302])
        by smtp.gmail.com with UTF8SMTPSA id m3sm1445841pgl.91.2021.04.22.01.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:17:01 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Subject: [PATCH v5 12/16] dma-direct: Add a new wrapper __dma_direct_free_pages()
Date:   Thu, 22 Apr 2021 16:15:04 +0800
Message-Id: <20210422081508.3942748-13-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210422081508.3942748-1-tientzu@chromium.org>
References: <20210422081508.3942748-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new wrapper __dma_direct_free_pages() that will be useful later
for swiotlb_free().

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/direct.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 7a88c34d0867..7a27f0510fcc 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -75,6 +75,12 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 		min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
 }
 
+static void __dma_direct_free_pages(struct device *dev, struct page *page,
+				    size_t size)
+{
+	dma_free_contiguous(dev, page, size);
+}
+
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp)
 {
@@ -237,7 +243,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			return NULL;
 	}
 out_free_pages:
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 	return NULL;
 }
 
@@ -273,7 +279,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 		arch_dma_clear_uncached(cpu_addr, size);
 
-	dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
+	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
 }
 
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -310,7 +316,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
 out_free_pages:
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 	return NULL;
 }
 
@@ -329,7 +335,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	if (force_dma_unencrypted(dev))
 		set_memory_encrypted((unsigned long)vaddr, 1 << page_order);
 
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 }
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-- 
2.31.1.368.gbe11c130af-goog

