Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EB835E2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346726AbhDMPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346629AbhDMPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:23:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89036C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:22:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso3843962pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNYshAOIhIfYWplCoKI3GKQhqu3xrQdJgtDgLoPsrVY=;
        b=jp8qbqTxevt3fdyQq8b90lIy5Mw3k9Z6yoHsMiBXwH4fDpxjxdLMTa8PGmUGYRVo15
         UuyUCWEMXA6prtck9kKNZi8q5cIvXOQdT1AfgdK4H8IabvykjPZKs0WeIaB2S3g0lrf+
         Em6ziCnIcHB9pEqBFotRuVBu03DKULXJy8+g7S78YqgQEWZqfqDpvBGVmBDF+SKWmu3i
         m1djg6mYmWmSPiqLAADMVltOnyDP91MH+xEIL5xUgoNfsTiycItmhWshzQWfODOcwqPJ
         LKeqyXHHjrY7yhcUaCVGSvPMJTQ1QqM4GYYBpkhy/d5ZzdKvINdHsphO8hgpkaupFrgB
         g7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNYshAOIhIfYWplCoKI3GKQhqu3xrQdJgtDgLoPsrVY=;
        b=Q/IFrx+u3r//+gZL3c7qatSwjEgvzkA+3fxwIixIkSKCLNRUHS4aMsiowH7T5wK7yP
         W8DYNuZN2jpHIMFvo2iR76vDcN5g2IddTD1jP/tASTeuooSAh3e27gfJGk7M7xrMfIRS
         np3Tnkar5NTI0CpNoYkLWK7HC9i5JWZjLkk8EtVMQLxf/A8CcqmSVbsTAELjWTbwQ+IL
         cbyXBw0CjkkW8g3raL0Hqpt5cKmA3oM2x3l8tPmlp+eiNTvPkqTCsQj8dNKdMMZhJEv6
         ZYeOAVbjQJJuiGFT2lCtPfSOPKM8TryaPx07ITwj01cKi2dzxZFaGAd7FMUao7SW8h7c
         IMeA==
X-Gm-Message-State: AOAM532nEJHM6lBokpvVOS6kLSGb6wpfEaEA42Xy8htyshqxPTtfYdJ/
        zUKV3rTRgaYvpL6DZGlBJo8=
X-Google-Smtp-Source: ABdhPJzxOadIW9AoyD8BTTDKf7rAcHW65iwBoDDGNL6nNN1XC0+VeHv+FxJbtWQNFGR2CFI0/fzDKQ==
X-Received: by 2002:a17:902:dac8:b029:eb:14e1:5057 with SMTP id q8-20020a170902dac8b02900eb14e15057mr7667402plx.65.1618327361177;
        Tue, 13 Apr 2021 08:22:41 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:5b29:fe1a:45c9:c61c])
        by smtp.gmail.com with ESMTPSA id y3sm12882026pfg.145.2021.04.13.08.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:22:40 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: [RFC V2 PATCH 9/12] swiotlb: Add bounce buffer remap address setting function
Date:   Tue, 13 Apr 2021 11:22:14 -0400
Message-Id: <20210413152217.3386288-10-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413152217.3386288-1-ltykernel@gmail.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

For Hyper-V isolation VM with AMD SEV SNP, the bounce buffer(shared memory)
needs to be accessed via extra address space(e.g address above bit39).
Hyper-V code may remap extra address space outside of swiotlb. swiotlb_bounce()
needs to use remap virtual address to copy data from/to bounce buffer. Add
new interface swiotlb_set_bounce_remap() to do that.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  5 +++++
 kernel/dma/swiotlb.c    | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index d9c9fc9ca5d2..3ccd08116683 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -82,8 +82,13 @@ unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
 void __init swiotlb_adjust_size(unsigned long new_size);
+void swiotlb_set_bounce_remap(unsigned char *vaddr);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
+static inline void swiotlb_set_bounce_remap(unsigned char *vaddr)
+{
+}
+
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return false;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e6100..5fd2db6aa149 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -94,6 +94,7 @@ static unsigned int io_tlb_index;
  * not be bounced (unless SWIOTLB_FORCE is set).
  */
 static unsigned int max_segment;
+static unsigned char *swiotlb_bounce_remap_addr;
 
 /*
  * We need to save away the original address corresponding to a mapped entry
@@ -421,6 +422,11 @@ void __init swiotlb_exit(void)
 	swiotlb_cleanup();
 }
 
+void swiotlb_set_bounce_remap(unsigned char *vaddr)
+{
+	swiotlb_bounce_remap_addr = vaddr;
+}
+
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
@@ -428,7 +434,12 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 			   size_t size, enum dma_data_direction dir)
 {
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned char *vaddr;
+
+	if (swiotlb_bounce_remap_addr)
+		vaddr = swiotlb_bounce_remap_addr + tlb_addr - io_tlb_start;
+	else
+		vaddr = phys_to_virt(tlb_addr);
 
 	if (PageHighMem(pfn_to_page(pfn))) {
 		/* The buffer does not have a mapping.  Map it in and copy */
-- 
2.25.1

