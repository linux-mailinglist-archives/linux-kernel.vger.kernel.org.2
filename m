Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600BF3148B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBIGYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhBIGXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:23:08 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B90AC061793
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 22:21:58 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x9so9174846plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ypYSGMF0E/cBAHmG+5MgTYKeSo3o0eLQF2YTe8sYrHU=;
        b=nuyunksJVzuVGUJwTZPlPVCVdAk7PqLR5/eJIWK+czvsKm+Rv5adeEB/7QzXpfJ6Qb
         eTQmwh//uII6ybrnF53ZsBr2I2SswetGJe9SJ79VWxXwIXylAfF5A0x6o0MD+aeanu4S
         AHLyX/KnrhYHKwiWZolFO//7UXaKKEQSkWti8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypYSGMF0E/cBAHmG+5MgTYKeSo3o0eLQF2YTe8sYrHU=;
        b=SjouEkFJ9lMmE+babvME1WWM+q9IuffCxtQ1MOuhlkfYM3HtimtGBoiuJtnHf7Nv2/
         HjYGhE+S5blq4uWIoWLy0Z1ngXNCx6Lj80Coga5VrUGBxNUBUwgZ9DWUYQ2Jf6JSaSCr
         yaxVRcfTrnIfxTyXeASJj7q8N9yMtgZE8OEcAZH0hxjwBx6s/CltmN5p524UxWh1pTRj
         ZpFYjjRy3UQ4SBnhIJ1RcF44nKEJnoPlJCDwx/3EQmJVq5Cb4+yick0xObYOStDr/DLb
         AgWWz5F1VKF6ACodyoly2qbwzQUDvRImvG36xKulNuBGYNVSKdzGLMxDpamDJZuDRBJy
         CG9g==
X-Gm-Message-State: AOAM533FiBCra8e2xIKQAMUsz6d5UhAQIatHmrHCh1+HqDh5J4U94Egv
        VothuOQsH1USLKldw2E+olxfYA==
X-Google-Smtp-Source: ABdhPJywOf1kdt/G4UCY0rOH88voPYoRmAlcet1VV4EMdbEytPdXO083Yd5o1179zNV2rDMmBilckQ==
X-Received: by 2002:a17:90a:df87:: with SMTP id p7mr663033pjv.99.1612851717915;
        Mon, 08 Feb 2021 22:21:57 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
        by smtp.gmail.com with UTF8SMTPSA id a24sm22136125pff.18.2021.02.08.22.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 22:21:57 -0800 (PST)
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
        Jim Quinlan <james.quinlan@broadcom.com>,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v4 02/14] swiotlb: Move is_swiotlb_buffer() to swiotlb.c
Date:   Tue,  9 Feb 2021 14:21:19 +0800
Message-Id: <20210209062131.2300005-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move is_swiotlb_buffer() to swiotlb.c and make io_tlb_{start,end}
static, so we can entirely hide struct swiotlb inside of swiotlb.c in
the following patches.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/swiotlb.h | 7 +------
 kernel/dma/swiotlb.c    | 7 ++++++-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 83200f3b042a..041611bf3c2a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -70,13 +70,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
-extern phys_addr_t io_tlb_start, io_tlb_end;
-
-static inline bool is_swiotlb_buffer(phys_addr_t paddr)
-{
-	return paddr >= io_tlb_start && paddr < io_tlb_end;
-}
 
+bool is_swiotlb_buffer(phys_addr_t paddr);
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e180211f6ad9..678490d39e55 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -69,7 +69,7 @@ enum swiotlb_force swiotlb_force;
  * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
  * API.
  */
-phys_addr_t io_tlb_start, io_tlb_end;
+static phys_addr_t io_tlb_start, io_tlb_end;
 
 /*
  * The number of IO TLB blocks (in groups of 64) between io_tlb_start and
@@ -719,6 +719,11 @@ bool is_swiotlb_active(void)
 	return io_tlb_end != 0;
 }
 
+bool is_swiotlb_buffer(phys_addr_t paddr)
+{
+	return paddr >= io_tlb_start && paddr < io_tlb_end;
+}
+
 phys_addr_t get_swiotlb_start(void)
 {
 	return io_tlb_start;
-- 
2.30.0.478.g8a0d178c01-goog

