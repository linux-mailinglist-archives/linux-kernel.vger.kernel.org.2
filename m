Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC2358ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhDHUzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhDHUzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:55:54 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC4CC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 13:55:42 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i9so3770858qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjjrWLOd+wnSFUUoajua48yZLA0y5VjsGqmoCyZiy74=;
        b=hPD3m+HbuA0TauWY/jX9or6vW8OZOVympwKhzk3nUDa1u0oIewLQWCBEGMDcR179cW
         ndmO2Wdf2C59DDCO7bnQ0FQswNsRDJwABlH/jcMTsKDeOJFPX/ZFqXbqcuwGq0pWEoXZ
         x+7+zOLW3MTJrB8d/uz2wSFhNjknWNG+dhBLV+eqVR/qmGVmi35Bwe/s+KELU0bjLMko
         TbVgOdcUpbVyHUZ5duWaCohZPHy36oqfzD7yLdYk3fkSNRKMrt4YDEsv/4C3hNpGtI5k
         mvAfTwJJYcpIenCFLLE5ttnLEPYcvRB0F4yKeOG5/aLvX6iUFrdayfqyEXMo9mQhgZT4
         Lr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjjrWLOd+wnSFUUoajua48yZLA0y5VjsGqmoCyZiy74=;
        b=F9/KZBH5x8SsoUZFxUT7WUcAkcdIH69e4A3tlPdXtEIcAInmN84T6vLap/GToccHxI
         Gat5NYebn8A9RoU/Y0s4FSdt4dgqtk095629KWVUw2uPq73u8SIJz8/rcTRaDcIAQnKO
         2qztdgAnXjBmvu0b6bpSkKP+9BzWn/aGoRqOUV0Ldwr0gsaSVX/c0jSh6z6htTnPFYWw
         Gi+WmXXv1VviDHC+q9PIhER9nTEv5p1EexxoBFieJRSsuETQak5cJ06jxD+3OPzVBFQ6
         4PeH4dOby4dWHwT9f/WjEMFbdmTtqyZxRah9EgOQd7wGMmgeSH9mqVDqSzRXjZ57Lm8+
         MnTw==
X-Gm-Message-State: AOAM530UfIODb2O8ZlJW5lm4Jq+39Z4/c1JfMjZiY1x9HlhHnkHHqiCv
        JLUSp/RTsGTACi7uoJd6CRcV5k4dKkA=
X-Google-Smtp-Source: ABdhPJxAGP4IcaK5aUHzAHHeaoBzXHgNUkKtebsPetrYDiGHYUv0dHLLo+wnithZ/HunWvcgBsWwnQ==
X-Received: by 2002:a37:9e50:: with SMTP id h77mr10562580qke.138.1617915342082;
        Thu, 08 Apr 2021 13:55:42 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([2804:14c:482:7b04::1000])
        by smtp.gmail.com with ESMTPSA id g2sm517604qtu.0.2021.04.08.13.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:55:41 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, brking@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes present in LoPAR
Date:   Thu,  8 Apr 2021 17:19:16 -0300
Message-Id: <20210408201915.174217-1-leobras.c@gmail.com>
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
Changes since v2:
 - Restore 'int array & shift' strategy
 - Remove defines for RTAS "IO Page Size" output of ibm,query-pe-dma-window
 - Added/Improved comments
Link: http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210407195613.131140-1-leobras.c@gmail.com/
Changes since v1:
- Remove page shift defines, replace by __builtin_ctzll(SZ_XXX)
- Add bit field defines for RTAS "IO Page Shift" output of ibm,query-pe-dma-window
- Use struct array instead of int array to be more explicit on pagesizes
Link: http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210322190943.715368-1-leobras.c@gmail.com/ 

 arch/powerpc/platforms/pseries/iommu.c | 37 +++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9fc5217f0c8e..67c9953a6503 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1099,6 +1099,33 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
 			 ret);
 }
 
+/* Return largest page shift based on "IO Page Sizes" output of ibm,query-pe-dma-window. */
+static int iommu_get_page_shift(u32 query_page_size)
+{
+	/* Supported IO page-sizes according to LoPAR */
+	const int shift[] = {
+		__builtin_ctzll(SZ_4K),   __builtin_ctzll(SZ_64K), __builtin_ctzll(SZ_16M),
+		__builtin_ctzll(SZ_32M),  __builtin_ctzll(SZ_64M), __builtin_ctzll(SZ_128M),
+		__builtin_ctzll(SZ_256M), __builtin_ctzll(SZ_16G)
+	};
+
+	int i = ARRAY_SIZE(shift) - 1;
+
+	/*
+	 * On LoPAR, ibm,query-pe-dma-window outputs "IO Page Sizes" using a bit field:
+	 * - bit 31 means 4k pages are supported,
+	 * - bit 30 means 64k pages are supported, and so on.
+	 * Larger pagesizes map more memory with the same amount of TCEs, so start probing them.
+	 */
+	for (; i >= 0 ; i--) {
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
@@ -1206,13 +1233,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
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

