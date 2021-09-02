Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4598B3FEB32
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245565AbhIBJ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245139AbhIBJ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:28:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFF1C061575;
        Thu,  2 Sep 2021 02:27:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t42so1152474pfg.12;
        Thu, 02 Sep 2021 02:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5eh/glHsJ8jkOW+kWHIi3NmtKaQUQdLU+4tO181UN7Y=;
        b=oaH/d0E0Ho4VV9lo48x1+E38Z6h0g+HzFEPpck5bucZvK65hrec7GlSgUCetVurSdr
         fm2FzpZqZieSl6QnyRQFGgoqaLV9FiY4XqGVZ2T7+5/pDRji8kZp6VSUk0Q+Y0B2o6nf
         ZdmVH5coxVtusISG05cFPBjkEu7/lbKpQGU8uZIVVN+YdKDV2fYsbHQac4nWtNhcvCXH
         CL6+XWWDFxJmdcmE+bWbMjpashCwW78+5PuMeA9fAT8msm4suEkNTA8Wb6Tx2YwTV+xR
         /LmIUmTW69dtR6wFThyxGvrMTr7/rLq0k/vF3nlCHuBYYxJfcVvOdXXM/XQ5SahPfZlG
         vUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5eh/glHsJ8jkOW+kWHIi3NmtKaQUQdLU+4tO181UN7Y=;
        b=cSkfeZgaYQxOSm5gWNVBZEUBBVN3xDPi+/nbA20GedWHeehSDT3UZ/lN0/MfXXWHaX
         1GmlpVqIYnDXcLMkO3ilDoHIm/O+u6HalpJ5hS3Tw4RQmcu19CtCbPQpiNcbHaHZSLd6
         79ROT1qLLDQa7AeanmBgFxogjTEiZiJNHxIo3AoIWvCmoBq/kEb7Umfdhuo0+HE4V2Ry
         R4G46idC7hzOTHwBh1HirbBHTXNEnFlwJ5/JcJA5ab5mjWOwcWAx1fOQZdibk7WKTX3c
         rHDrCw2ZcCiHx/v1KCiADcxb5n1UhbPo6mCV64vvsP2eirD1cCNcZJBdseM7IS8WxtkS
         bkSA==
X-Gm-Message-State: AOAM5312whyok4kw5qOKwzBEH1RoBFHm5yNleErhdRRNB3CpPHZM5iV1
        J+fPiMfFk+U4RdnlhQ1ojIE=
X-Google-Smtp-Source: ABdhPJzJ6Pz5nO5o8PukyJhRE0xNeP8YLs3eEf0JrqcClvTsVTAqXKz4JUwBy3rTsfBe5vbTJNIMFQ==
X-Received: by 2002:a65:400c:: with SMTP id f12mr2338150pgp.296.1630574846270;
        Thu, 02 Sep 2021 02:27:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 23sm2071467pgk.89.2021.09.02.02.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 02:27:25 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] of: fix of_address_to_resource and of_iomap undefined
Date:   Thu,  2 Sep 2021 17:27:03 +0800
Message-Id: <20210902092704.2678277-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

If CONFIG_OF is selected, but CONFIG_OF_ADDRESS is not, when compiling
files (sunch as timer_of.c) in which the function of_iomap() is invoked,
compiler would report 'undefined reference to of_iomap', the same case
is for of_address_to_resource().

This patch also makes sure that of_iomap() and of_address_to_resource()
are declared for sparc so that sparc can have its specific
implementations in arch/sparc/kernel/of_device_common.c, even if
including include/linux/of_address.h in it.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 include/linux/of_address.h | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 45598dbec269..02a719d58466 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -80,6 +80,23 @@ static inline u64 of_translate_address(struct device_node *np,
 	return OF_BAD_ADDR;
 }
 
+#ifdef CONFIG_SPARC
+extern int of_address_to_resource(struct device_node *dev, int index,
+				  struct resource *r);
+void __iomem *of_iomap(struct device_node *device, int index);
+#else
+static inline int of_address_to_resource(struct device_node *dev, int index,
+					 struct resource *r)
+{
+	return -EINVAL;
+}
+
+static inline void __iomem *of_iomap(struct device_node *device, int index)
+{
+	return NULL;
+}
+#endif
+
 static inline const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
 					     u64 *size, unsigned int *flags)
 {
@@ -124,22 +141,6 @@ static inline bool of_dma_is_coherent(struct device_node *np)
 }
 #endif /* CONFIG_OF_ADDRESS */
 
-#ifdef CONFIG_OF
-extern int of_address_to_resource(struct device_node *dev, int index,
-				  struct resource *r);
-void __iomem *of_iomap(struct device_node *node, int index);
-#else
-static inline int of_address_to_resource(struct device_node *dev, int index,
-					 struct resource *r)
-{
-	return -EINVAL;
-}
-
-static inline void __iomem *of_iomap(struct device_node *device, int index)
-{
-	return NULL;
-}
-#endif
 #define of_range_parser_init of_pci_range_parser_init
 
 static inline const __be32 *of_get_address(struct device_node *dev, int index,
-- 
2.25.1

