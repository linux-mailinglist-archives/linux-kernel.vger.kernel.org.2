Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8CB41B830
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbhI1UOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232756AbhI1UOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632859955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3BRf/BoVQQhGwaFtZ+fvHSqHQV1racwbJknBUgVnbCI=;
        b=Yu2pN/R9BhhROpfaCT+1kF0gxy/TQLDFWi2MfaTzyHu1M3Bnf0EDKNiZYDBWMloWlLAGfi
        a2JJKiwmuzuV6PcvfdHdM+17qfY9Ix6eRg9Mmh4Zc2iiWAXnHSomhc5XRQrXX8pxIbw/uN
        uWVOfggfM6yyB9vknxIF3jmPLK6sEnI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-89JLxWC1MIC7ejmCh9eJCw-1; Tue, 28 Sep 2021 16:12:29 -0400
X-MC-Unique: 89JLxWC1MIC7ejmCh9eJCw-1
Received: by mail-ot1-f71.google.com with SMTP id a19-20020a9d3e13000000b0054d67e67b64so14159456otd.22
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BRf/BoVQQhGwaFtZ+fvHSqHQV1racwbJknBUgVnbCI=;
        b=zVH0cT7/ZZjERIifITasZzykVVorMx6oXC+rvdZ32x31m2rn4Sld8uvzLjozIVGIPi
         2d0PQ0q0M7Bfwkii+/whGM7xAln5rxQX4uYrAKJ1m7Suo4FSuNYzDjCkkavjYCwtTm5r
         RpxCMWvUr17hQqZc2L5n3y5z29sLbeXjZAT6Ju1oX+leAhOLeRSh0yrqfFbjCgoukBtQ
         z7eipYD+VmPVKV7lsjXClzFm/YHb0J5oUNxdcYJcOmOR8hcFFtIbHpjSCiTkxWVnzam+
         l2Nf66gV/YhBA8zAyaO7SEi9+bQ4K9h5nv5Z+zuCZt+G/QF1akFy4mFQGh68yg5tamBa
         zlkg==
X-Gm-Message-State: AOAM531Ho8tlxH7Bt3Rj05QJ78FyQpDWrl8x75QDWlM5nTXNpuL7lOvY
        B26s5jbm55C0sOkb9zhM0L8KReM6D0I5JguN2oPLJQftfNrytcIMmOpmqNCJrRNmvUlv/gFAHME
        b+wsSPUTS6we+zi2gMc9MaKC8
X-Received: by 2002:a9d:7751:: with SMTP id t17mr6823665otl.276.1632859949030;
        Tue, 28 Sep 2021 13:12:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4Aj9jK75RLkBh3LSiNl3n/TgPSKPaDUroxVKiDxiaDWymphftid12DXqezUM3wGC8T8cNCQ==
X-Received: by 2002:a9d:7751:: with SMTP id t17mr6823656otl.276.1632859948835;
        Tue, 28 Sep 2021 13:12:28 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z83sm30895oiz.41.2021.09.28.13.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 13:12:28 -0700 (PDT)
From:   trix@redhat.com
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] of: remove duplicate declaration of of_iomap()
Date:   Tue, 28 Sep 2021 13:12:14 -0700
Message-Id: <20210928201214.294737-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A ranconfig produces this linker error
irq-al-fic.c:252: undefined reference to `of_iomap'

The declaration of of_iomap() is dependent on OF
The definition of of_iomap() is dependent on OF_ADDRESS
These should match.  There are duplicate declarations
of of_iomap(), remove of_iomap() and the
of_address_to_resource() duplicate.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/of_address.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 45598dbec269..a190996b4b0b 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -122,13 +122,7 @@ static inline bool of_dma_is_coherent(struct device_node *np)
 {
 	return false;
 }
-#endif /* CONFIG_OF_ADDRESS */
 
-#ifdef CONFIG_OF
-extern int of_address_to_resource(struct device_node *dev, int index,
-				  struct resource *r);
-void __iomem *of_iomap(struct device_node *node, int index);
-#else
 static inline int of_address_to_resource(struct device_node *dev, int index,
 					 struct resource *r)
 {
@@ -139,7 +133,7 @@ static inline void __iomem *of_iomap(struct device_node *device, int index)
 {
 	return NULL;
 }
-#endif
+#endif /* CONFIG_OF_ADDRESS */
 #define of_range_parser_init of_pci_range_parser_init
 
 static inline const __be32 *of_get_address(struct device_node *dev, int index,
-- 
2.26.3

