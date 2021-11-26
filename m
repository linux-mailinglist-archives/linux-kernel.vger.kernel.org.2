Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD16845E6A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 04:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352179AbhKZDxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 22:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344500AbhKZDvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 22:51:51 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44336C09B114;
        Thu, 25 Nov 2021 18:47:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n8so5744715plf.4;
        Thu, 25 Nov 2021 18:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2rR2M205RaoXv2F1eYgORsUa0WkEJokTNFyh0m1jbQ=;
        b=G2bPd47mof2kPWU7wel0/tp2qN5l0O1ock7AVXOCjPcUgfdz+VGKWkXiYcX9y1PbIN
         Uvx3tGvdiFsjdWcDUHq3iDhH1az6OWWLRddAnuGMRXuAQjASQdHm0ixSfecMUpL9le/f
         eTADybm0qsmMMNVCByp9gq7imYV3VqBKjQnhY0tHT+6qwCx8XaUXkvRuey9ymCNi0yau
         WoLtDhIwjwasn2UdJ3wxPeYWjNgn2rqVtt87k79XaOwIYg6V+MpeZQfne8XEZGhAs8qK
         uIbwyrBUBzoVG2kLvZH+NxhP6qMXM6q23hqGf/n2i4+UUUlxzn35ojINybmpkkIdY6PH
         B+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2rR2M205RaoXv2F1eYgORsUa0WkEJokTNFyh0m1jbQ=;
        b=mjkTn2zxXbZupHVT7O375PPEKBfr3gHINgE/PSZVOKEgIUPV1W9KhZ/XEAlL87dd1Z
         c0RdOB10IQYGAZKj7diO9pKPAHyz1n12BiaR8fBijbSJVpr2aqyf2EJNrBxh7MQnA1Ex
         SpACqq7WsOIEMV9ZorhtVvWVKM2n/Ep0qTP5+OjWl+o85HzgvDRMEYo5nDiTxE3B/Tpu
         KX5oXU79FUSH2R5OAyTAuxPnZ78IKnDsLSQ7FG7fwk9Hy20ZwInPwpZa289ZC12G0LdR
         NF+eVVzNdjysrRxYioqBG8OMicM0LfKo6wDuF+JPcWwqgNxugwFgYyJTpp/nZh5jj0fW
         zV9g==
X-Gm-Message-State: AOAM533DQnub7cyBmc4bUnmkZuODwLowZRUDnSGgIcFv+i2mkrwv3d55
        MufkaffnVWHX25Hzua2kB88=
X-Google-Smtp-Source: ABdhPJx1btLLTBXEFgpXDPhTCJScji/umzB55h96FNh8lq7mlIt4d/IQDK9YMn2EtbU9mBvwLvrqGg==
X-Received: by 2002:a17:902:ab94:b0:143:beb5:b6a7 with SMTP id f20-20020a170902ab9400b00143beb5b6a7mr36447789plr.30.1637894860877;
        Thu, 25 Nov 2021 18:47:40 -0800 (PST)
Received: from localhost.localdomain ([103.99.179.247])
        by smtp.gmail.com with ESMTPSA id k14sm4814513pff.6.2021.11.25.18.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 18:47:40 -0800 (PST)
From:   Calvin Zhang <calvinzhang.cool@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Calvin Zhang <calvinzhang.cool@gmail.com>
Subject: [PATCH] mm: kmemleak: Ignore kmemleak scanning on CMA regions
Date:   Fri, 26 Nov 2021 10:47:11 +0800
Message-Id: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like this:
commit 620951e27457 ("mm/cma: make kmemleak ignore CMA regions").

Add kmemleak_ignore_phys() for CMA created from of reserved node.

Signed-off-by: Calvin Zhang <calvinzhang.cool@gmail.com>
---
 kernel/dma/contiguous.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..66bd9a59615e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -50,6 +50,7 @@
 #include <linux/sizes.h>
 #include <linux/dma-map-ops.h>
 #include <linux/cma.h>
+#include <linux/kmemleak.h>
 
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
@@ -426,6 +427,9 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
 	}
+
+	kmemleak_ignore_phys(rmem->base);
+
 	/* Architecture specific contiguous memory fixup. */
 	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
-- 
2.30.2

