Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62F0345525
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCWByW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCWBxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:53:53 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA03BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:53:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v2so10135380pgk.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UN25kkS2KebRuu15wRF3YovKapnV4LybmIZMwea2YYo=;
        b=X4Hl65Vht8ypMH0BrR0aS/wzxgY9EdKWM8THL1iBDBWDVa03DGOeOvbQqxUp2Qlfr0
         LCivPy5VLWfs8Gz9CxuhYn5VzH6AB9vifmRKFmoakKCvnDTDv9e9ri6mU87ekvCqn8vB
         waPxprwZ3hVctrMPlk2o4AgKEm/KOVAqxZ4PIJ2h6645pCiMNEGzhqvc04g59k5Rzw2r
         LYh+Apd6aQNlfwW5KUMCm8wLJUMZhXgDcGL+VG9iyvBbYKiSJyPmSVUNe1dOc7UJY1ZB
         tXu/y/Hnyfa7DY5P1e3aO123voc/qDI6fNDlvCdzPn76uA0Y2NNejeoNZHSequ1NIn87
         jIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UN25kkS2KebRuu15wRF3YovKapnV4LybmIZMwea2YYo=;
        b=P/WB9hCgWeriWDbCaiaBCD0SipNUXx+1BEqL2mvNuNHWbnHWJ1i1A00vydG7cxeB0s
         Dpi7u1aBWSQgID2uMhQXQKrKLEFN5lPD3G/M62mWoLsUc/ZaQnQ0AWfaLRWDwmvI4/M+
         IiiakccPhtFFTSRt7Mg0QU05Tb5H0TlU5qM1DYrf9vsgWnMD7LldhPRQdTfXQOwY4AMg
         /mrFhTTTMVrEAmLnsJqTdEjqc2bsJ7XkwwI3+fMvjXMduPTrbL74Vb2saepkitYXvTvX
         Q9X9+rAj0Snd8KAlZEg+O/nGNKTggSSgc2ggA7glTpVB668fTpaDqkF24MiDGcyB7BRr
         OT1A==
X-Gm-Message-State: AOAM530yFo7GgKg1xBQxcwwTKPdWjObO7N9FHazoFllMnAZguK2BWEEW
        Xn7/tb/rMRb2M5lRBYIM07MyBPIvIss=
X-Google-Smtp-Source: ABdhPJyqE1ohS2TSgebv7K5iabFQEl7wcTcGFvBsF7yvXcxIbElsqBcsJY3s4Q6L/Rom+/w3AzJBdg==
X-Received: by 2002:a62:f248:0:b029:20a:f9d5:dac3 with SMTP id y8-20020a62f2480000b029020af9d5dac3mr2159803pfl.13.1616464432788;
        Mon, 22 Mar 2021 18:53:52 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 14sm3721376pfl.1.2021.03.22.18.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 18:53:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:SWIOTLB SUBSYSTEM)
Subject: [PATCH v3] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
Date:   Mon, 22 Mar 2021 18:53:49 -0700
Message-Id: <20210323015350.399493-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321033740.312500-1-f.fainelli@gmail.com>
References: <20210321033740.312500-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SWIOTLB_NO_FORCE is used, there should really be no allocations of
default_nslabs to occur since we are not going to use those slabs. If a
platform was somehow setting swiotlb_no_force and a later call to
swiotlb_init() was to be made we would still be proceeding with
allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
was set on the kernel command line we would have only allocated 2KB.

This would be inconsistent and the point of initializing default_nslabs
to 1, was intended to allocate the minimum amount of memory possible, so
simply remove that minimal allocation period.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
- patch all call sites that can allocate SWIOTLB memory

Changes in v2:

- rebased against devel/for-linus-5.13
- updated commit message to reflect variable names

 kernel/dma/swiotlb.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 539c76beb52e..0a5b6f7e75bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -83,12 +83,10 @@ setup_io_tlb_npages(char *str)
 	}
 	if (*str == ',')
 		++str;
-	if (!strcmp(str, "force")) {
+	if (!strcmp(str, "force"))
 		swiotlb_force = SWIOTLB_FORCE;
-	} else if (!strcmp(str, "noforce")) {
+	else if (!strcmp(str, "noforce"))
 		swiotlb_force = SWIOTLB_NO_FORCE;
-		default_nslabs = 1;
-	}
 
 	return 0;
 }
@@ -174,6 +172,9 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	struct io_tlb_mem *mem;
 	size_t alloc_size;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		return 0;
+
 	/* protect against double initialization */
 	if (WARN_ON_ONCE(io_tlb_default_mem))
 		return -ENOMEM;
@@ -211,6 +212,9 @@ swiotlb_init(int verbose)
 	size_t bytes = PAGE_ALIGN(default_nslabs << IO_TLB_SHIFT);
 	void *tlb;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		return;
+
 	/* Get IO TLB memory from the low pages */
 	tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb)
@@ -240,6 +244,9 @@ swiotlb_late_init_with_default_size(size_t default_size)
 	unsigned int order;
 	int rc = 0;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		return 0;
+
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
@@ -276,6 +283,9 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
 	struct io_tlb_mem *mem;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		return 0;
+
 	/* protect against double initialization */
 	if (WARN_ON_ONCE(io_tlb_default_mem))
 		return -ENOMEM;
-- 
2.25.1

