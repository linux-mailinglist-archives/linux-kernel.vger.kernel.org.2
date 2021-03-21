Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248C83430C4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 04:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCUDhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 23:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCUDhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 23:37:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6052C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 20:37:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v2so6376199pgk.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 20:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UO8rbq0+kqRaTjZw3G4nKUjHlHbuRA+XYvccxPC+8fc=;
        b=F/gnec5pQX2xPdlwo2ptR3vuUqplHpKTaIO68mwzbh1cLT9S5vyjyj08b0hRdo0fRA
         aPtC7T0rehITzUswqexVYYN0otPWzeAxny8FkEto7wxipNyEAKF4eswwy3I0CG8iolK0
         cVXzk0jVFN8xxuMZ8QEN11/XL7dOT2XR7ymXY44vQwdIxyeQlHTfGEuNn8Zm1s5Jx1A9
         iD5KEWqU8G3BUUH+/AkgeQQstXMCcHkYrgnDb7qJWjAelFPq+0eK9CtgYrtvGixyiJtv
         0/AV14nSrgUD6e2OmOwfpA8NlGIrIUHNRGx97eQe3s6Xy9/S8iXtWGVa/Q7ddfM3qNuu
         nCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UO8rbq0+kqRaTjZw3G4nKUjHlHbuRA+XYvccxPC+8fc=;
        b=LLaQ1lNJdNpIcNtKsj/4YaC2d8pZGlUPCzlo3iRPAHuPfFw5KPGUxszHP5BvDv2yjy
         Ewl6iomPBuc6r939849ZoTH2aFhZybZd5bG4hixS9cJ/281LC27ZS0M3/oDtkYschxk8
         KbWZztC47LTydIoxUJSeiMmkJGHrbiPu+n6YvpRPaQVDiFYzEfb+cEdBx1AhP+0ZbeH+
         wHBiPhWwkrrT4c3ZYDFtCEwYVINr9UfBTIX4uzW7q4MsEs44NVnkko9bU93ACEm1nXQx
         ZwdYDNy8VlSjVCVh/nUUYmzZyGMirElcWSEdZquNm7M7LcyuuSrogr1IvBKbksDZqypC
         W8Zw==
X-Gm-Message-State: AOAM532hHc7Tvhj6q3/WdcCO4DuSYvv+v1UQo3ZwNeH4fffF62nAl7tb
        J6X8G3dsT04Pg4rfqwa/H9H/lY/WE5U=
X-Google-Smtp-Source: ABdhPJymdtdqAVJYxOk6uVcvorM3cCBvr0inWwlQnN2ca5LzxTGnat1XqW/aqiGOwRQEEs76gkjl9A==
X-Received: by 2002:aa7:9394:0:b029:1f4:2b30:4cdb with SMTP id t20-20020aa793940000b02901f42b304cdbmr16213688pfe.50.1616297863405;
        Sat, 20 Mar 2021 20:37:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l190sm9708422pfl.73.2021.03.20.20.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 20:37:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:SWIOTLB SUBSYSTEM)
Subject: [PATCH v2] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
Date:   Sat, 20 Mar 2021 20:37:40 -0700
Message-Id: <20210321033740.312500-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319040055.183433-1-f.fainelli@gmail.com>
References: <20210319040055.183433-1-f.fainelli@gmail.com>
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
Changes in v2:

- rebased against devel/for-linus-5.13
- updated commit message to reflect variable names

 kernel/dma/swiotlb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 539c76beb52e..d20002a61546 100644
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
@@ -211,6 +209,9 @@ swiotlb_init(int verbose)
 	size_t bytes = PAGE_ALIGN(default_nslabs << IO_TLB_SHIFT);
 	void *tlb;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		return;
+
 	/* Get IO TLB memory from the low pages */
 	tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb)
-- 
2.25.1

