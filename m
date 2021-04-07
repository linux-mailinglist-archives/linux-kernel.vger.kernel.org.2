Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05F6357548
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355788AbhDGT4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355794AbhDGT4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:56:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE781C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 12:56:30 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 30so9658184qva.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Eng7Tpw0FiWFLkjNvSjq59edTb6xsd45/k2bJyWpHk=;
        b=IEMh9Y9yToEHrunZIi68gQMCGR+u48t1fn4nt2y7hYbXjuhnwVgszFIB2zsEqiTvyb
         FrWaWnhhc9nxxKgD/fgdnaDwz2NzpWcsRKlrYwLqbnxnBkLF4k5LEOe+XPXhmg/NMVlK
         4r0kktRr6l0LuKzPbeBaLuPq6sFN96RCgj7TFWzdTdsdIw6IqKDNOq2Hi+OJxnvSYUGY
         lyUjKYCCMk0oE5JJIpvmiV1nVuwXPOn4qZn4Pjd57Bwq02Dge9+3DmddfAtlv0q0WgJf
         +vMZIX/cmFlc3GVvfQmZFaexlxI7EyileSPh1jknFEhk6A9lyhMwJjxPE/bp37sp6ANI
         MgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Eng7Tpw0FiWFLkjNvSjq59edTb6xsd45/k2bJyWpHk=;
        b=c1KgMtsNNSurH5ppHzcexU0XB6w+o7SFY/21a3HjP8sT3RqBt5pSO7fjDifPqdIX+b
         5FTkk0SvOWPcX4STcc4aAkWYMhmG/akVX6OCjM0TYEX/ftLjz7OUl2Q+PHytdAv+M06r
         IrxO6cDK3P66iXD9Wfix7bdSaWKS6iSFvtrkuv/t2xDbR7kcwSbLDuQ96znL1d3EF66S
         cOFpFCyI6EePUyzqsJV1+kMtGsKVUet7SIxeyNJMPqgLuGE7IgAPgbWBT//c+kbBx85E
         LncgjXQdvBBaKKOQtqpullClF2zR+XGl9PRTJPCtsw7ur2B38Y5z9lHk45F/C+IpF68v
         4+6A==
X-Gm-Message-State: AOAM53103ElUIecKVh8LXMI5JfZcz74OJij78MViDWJyJYz30mOpGicf
        f4Hjg6zmuzPtZLzKEEQkGmsJYVBw8zE=
X-Google-Smtp-Source: ABdhPJxp+hcbe06ZwiMG5kRIwG9oTXWRPdTZKwgdXT9zklzHRrNr9pQYNKhtbwkrXVCkaru+HsTSmA==
X-Received: by 2002:a05:6214:164e:: with SMTP id f14mr5347841qvw.60.1617825390157;
        Wed, 07 Apr 2021 12:56:30 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([2804:14c:482:7b04::1000])
        by smtp.gmail.com with ESMTPSA id a207sm19489303qkc.135.2021.04.07.12.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 12:56:29 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>, brking@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes present in LoPAR
Date:   Wed,  7 Apr 2021 16:56:13 -0300
Message-Id: <20210407195613.131140-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
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
 arch/powerpc/platforms/pseries/iommu.c | 49 ++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9fc5217f0c8e..6cda1c92597d 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -53,6 +53,20 @@ enum {
 	DDW_EXT_QUERY_OUT_SIZE = 2
 };
 
+#define QUERY_DDW_PGSIZE_4K	0x01
+#define QUERY_DDW_PGSIZE_64K	0x02
+#define QUERY_DDW_PGSIZE_16M	0x04
+#define QUERY_DDW_PGSIZE_32M	0x08
+#define QUERY_DDW_PGSIZE_64M	0x10
+#define QUERY_DDW_PGSIZE_128M	0x20
+#define QUERY_DDW_PGSIZE_256M	0x40
+#define QUERY_DDW_PGSIZE_16G	0x80
+
+struct iommu_ddw_pagesize {
+	u32 mask;
+	int shift;
+};
+
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
 	struct iommu_table_group *table_group;
@@ -1099,6 +1113,31 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
 			 ret);
 }
 
+/* Returns page shift based on "IO Page Sizes" output at ibm,query-pe-dma-window. See LoPAR */
+static int iommu_get_page_shift(u32 query_page_size)
+{
+	const struct iommu_ddw_pagesize ddw_pagesize[] = {
+		{ QUERY_DDW_PGSIZE_16G,  __builtin_ctz(SZ_16G)  },
+		{ QUERY_DDW_PGSIZE_256M, __builtin_ctz(SZ_256M) },
+		{ QUERY_DDW_PGSIZE_128M, __builtin_ctz(SZ_128M) },
+		{ QUERY_DDW_PGSIZE_64M,  __builtin_ctz(SZ_64M)  },
+		{ QUERY_DDW_PGSIZE_32M,  __builtin_ctz(SZ_32M)  },
+		{ QUERY_DDW_PGSIZE_16M,  __builtin_ctz(SZ_16M)  },
+		{ QUERY_DDW_PGSIZE_64K,  __builtin_ctz(SZ_64K)  },
+		{ QUERY_DDW_PGSIZE_4K,   __builtin_ctz(SZ_4K)   }
+	};
+
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ddw_pagesize); i++) {
+		if (query_page_size & ddw_pagesize[i].mask)
+			return ddw_pagesize[i].shift;
+	}
+
+	/* No valid page size found. */
+	return 0;
+}
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -1206,13 +1245,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
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
2.30.2

