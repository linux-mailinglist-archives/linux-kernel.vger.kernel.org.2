Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610F9344FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhCVTKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhCVTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:10:24 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E549CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:10:23 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z10so11752767qkz.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNkMlxbd5hw8vbFbsx/z880fTB06PFSXH/nFwwKyStY=;
        b=rnlGQtVK9HXlygnqWYdHt7Txl0gnxq9HLW0CGVrRuzpqd69n+S42Gyed5hCfbylmjI
         oKiixgwo495YWGW0sq99flzrhZyPCH4/vXD4C0EKShIpop7qf+69ML9lKCmq3gOhZnNM
         qlKr1ecNrZWZUniNY+3FvKGjjHX4kWieZaYbQm9hSRFTWHEPXWTMexC1ZeVKimlBShMs
         ZkeDpEHlFTI2N5WE3IGf0DMHh+g0f/yvF5UlkS+ATOVQmcAUu7PXiJEsQGzDUW3lhHt4
         wf43IZ+7Gtrj6iM80U+L+UNlXvjqhEAyPBtspqJAy9EP8G/pefSlp/THDyzXl02LSlyH
         DqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNkMlxbd5hw8vbFbsx/z880fTB06PFSXH/nFwwKyStY=;
        b=FefVmT0PV7Vgjf3jxPOzy7K+JRMaVg0m6xWqBKLX7aaiO/gOqQBMOYiUZ+H8zcx6l4
         NJgvmXBJJ5EgtXBOBJvwydx4IAjhYcnQQM+lHyX6cIn2a/x/d0d234nkmQqfPSWU3ca/
         6xGikY7wdjbheHg70RkZf00eI9GZ+B5XpEgVUJ0JRTSgjLAehM29IVA+OLKL4PgtULi0
         XOvO3Xf3t8ir1zhvil0g5PonQfOZENWd1XRzfeJwQQSTygkBrOXZToQOlI3w5N6fZtcF
         SYLAZeRMbE+0sR/bSnWzlU1lZhFhCeM1zDyfJFBzOGZ7zEdmaMmGEjorCPyBKCNzzR81
         Xnvg==
X-Gm-Message-State: AOAM530u0CWQxhac96SC5QhKfSeAiJn4rCwRxDJe1R+X7npjpYBJY7sH
        IxBs3S5bl2TdOLHo3nK0ZV8uKxUoenA=
X-Google-Smtp-Source: ABdhPJx2GYs+mlG9vxpWgsKw5z54VcLtQ6iDAT/CYzn5OSkaZdO704su+AGykz3PLGvC9Wyhb9dy1Q==
X-Received: by 2002:a05:620a:20c7:: with SMTP id f7mr1619367qka.156.1616440223181;
        Mon, 22 Mar 2021 12:10:23 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com (179-125-204-19.dynamic.desktop.com.br. [179.125.204.19])
        by smtp.gmail.com with ESMTPSA id r133sm11810186qke.20.2021.03.22.12.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 12:10:22 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, brking@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes present in LoPAR
Date:   Mon, 22 Mar 2021 16:09:43 -0300
Message-Id: <20210322190943.715368-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to LoPAR, ibm,query-pe-dma-window output named "IO Page Sizes"
will let the OS know all possible pagesizes that can be used for creating a
new DDW.

Currently Linux will only try using 3 of the 8 available options:
4K, 64K and 16M. According to LoPAR, Hypervisor may also offer 32M, 64M,
128M, 256M and 16G.

Enabling bigger pages would be interesting for direct mapping systems
with a lot of RAM, while using less TCE entries.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/include/asm/iommu.h       |  8 ++++++++
 arch/powerpc/platforms/pseries/iommu.c | 28 +++++++++++++++++++-------
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index deef7c94d7b6..c170048b7a1b 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -19,6 +19,14 @@
 #include <asm/pci-bridge.h>
 #include <asm/asm-const.h>
 
+#define IOMMU_PAGE_SHIFT_16G	34
+#define IOMMU_PAGE_SHIFT_256M	28
+#define IOMMU_PAGE_SHIFT_128M	27
+#define IOMMU_PAGE_SHIFT_64M	26
+#define IOMMU_PAGE_SHIFT_32M	25
+#define IOMMU_PAGE_SHIFT_16M	24
+#define IOMMU_PAGE_SHIFT_64K	16
+
 #define IOMMU_PAGE_SHIFT_4K      12
 #define IOMMU_PAGE_SIZE_4K       (ASM_CONST(1) << IOMMU_PAGE_SHIFT_4K)
 #define IOMMU_PAGE_MASK_4K       (~((1 << IOMMU_PAGE_SHIFT_4K) - 1))
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9fc5217f0c8e..02958e80aa91 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1099,6 +1099,24 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
 			 ret);
 }
 
+/* Returns page shift based on "IO Page Sizes" output at ibm,query-pe-dma-window. SeeL LoPAR */
+static int iommu_get_page_shift(u32 query_page_size)
+{
+	const int shift[] = {IOMMU_PAGE_SHIFT_4K,   IOMMU_PAGE_SHIFT_64K,  IOMMU_PAGE_SHIFT_16M,
+			     IOMMU_PAGE_SHIFT_32M,  IOMMU_PAGE_SHIFT_64M,  IOMMU_PAGE_SHIFT_128M,
+			     IOMMU_PAGE_SHIFT_256M, IOMMU_PAGE_SHIFT_16G};
+	int i = ARRAY_SIZE(shift) - 1;
+
+	/* Looks for the largest page size supported */
+	for (; i >= 0; i--) {
+		if (query_page_size & (1 << i))
+			return shift[i];
+	}
+
+	/* No valid page size found. */
+	return 0;
+}
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -1206,13 +1224,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 			goto out_failed;
 		}
 	}
-	if (query.page_size & 4) {
-		page_shift = 24; /* 16MB */
-	} else if (query.page_size & 2) {
-		page_shift = 16; /* 64kB */
-	} else if (query.page_size & 1) {
-		page_shift = 12; /* 4kB */
-	} else {
+
+	page_shift = iommu_get_page_shift(query.page_size);
+	if (!page_shift) {
 		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
 			  query.page_size);
 		goto out_failed;
-- 
2.29.2

