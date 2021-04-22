Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A73367A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhDVHJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbhDVHI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:08:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F731C06138D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id f12so33110993qtf.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijXkh5bc5eEQEAPTsHyC4GzIBhozaiyqx/uWR9aUj2Q=;
        b=jUULwv6sWz6Zkys3P6Wn8srjX65o/R+FGjJ9gVnAxHajP75zVpsQlVdJ5ys7H4fIsV
         viroDkq72TSmyHBFpoV6WN9jxo3FTP7C6hl1Mo9U/X3QBhndnbM1d+WE0JorWTB2WE13
         zWLK4BsXcQTdKw2FC9zw1hPtjjp61IAYVf6LbXR1JV2coNHb9XFZrkkvPjjAZ/9dq3hU
         ZXN/2cdiCwrYKACSQ0KnwMMmPCxGz5IwRQpeOfXBbJnjQNqetVqyf3cpk3s3CnnO8RZc
         wKdQJPISZ6Ht21rEBVmm9D51Kx8eA/wTPsPrdH8GFQImawz0EanM/yu9hrb/IMFEMEYq
         DUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijXkh5bc5eEQEAPTsHyC4GzIBhozaiyqx/uWR9aUj2Q=;
        b=sA11etnEz9TOBib2yJBtkv4dSSUKh64CtOU5rrml/EFjm7YoJKa76B8ImgIePLI9Xs
         kwpVJxanUzEz2X/7Wp466g/7zg2TCWE/qmYdza7C4WNPMe68pTe6phQuy2MqocjK99EM
         VmLCFD2Blb5+bf0KBO1ATsKgEzvM7Y01AetmFvk9zT9zr4DUD1x4MODCpNdYRkv45yLM
         nhFVf1oDWZyHsDIvJ6ImIYyH1S4DW1BGD0PZ6rN830KrkTSBwDpJfU/eDHKXZwOp3Jfv
         J1e+fp4Y/5IDkfbU9fosLq9LZL8YmbqRpl/5cZKGBw5k5EGXTBJWToxxDqJK7a3wfwTa
         ZpSQ==
X-Gm-Message-State: AOAM532bC6lHu6B3NVHgYEDKWZqEkD3lHoBjbBEuamCYFysSS0Ufori/
        +ng/HQv29Y/BtHK2cgr3MUU=
X-Google-Smtp-Source: ABdhPJyY3oyj/kkUxMhC8t2SaqN7XMp8wRvulCzFRmh6biO3CezC8nU62gZAIOGM09bNXDTeiABKVg==
X-Received: by 2002:ac8:5a0b:: with SMTP id n11mr1721655qta.381.1619075297815;
        Thu, 22 Apr 2021 00:08:17 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id w67sm1658329qkc.79.2021.04.22.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:08:17 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] powerpc/pseries/iommu: Add ddw_list_new_entry() helper
Date:   Thu, 22 Apr 2021 04:07:16 -0300
Message-Id: <20210422070721.463912-5-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422070721.463912-1-leobras.c@gmail.com>
References: <20210422070721.463912-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two functions creating direct_window_list entries in a
similar way, so create a ddw_list_new_entry() to avoid duplicity and
simplify those functions.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 32 +++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index d02359ca1f9f..6f14894d2d04 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -870,6 +870,21 @@ static u64 find_existing_ddw(struct device_node *pdn, int *window_shift)
 	return dma_addr;
 }
 
+static struct direct_window *ddw_list_new_entry(struct device_node *pdn,
+						const struct dynamic_dma_window_prop *dma64)
+{
+	struct direct_window *window;
+
+	window = kzalloc(sizeof(*window), GFP_KERNEL);
+	if (!window)
+		return NULL;
+
+	window->device = pdn;
+	window->prop = dma64;
+
+	return window;
+}
+
 static int find_existing_ddw_windows(void)
 {
 	int len;
@@ -882,18 +897,15 @@ static int find_existing_ddw_windows(void)
 
 	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
 		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
-		if (!direct64)
-			continue;
-
-		window = kzalloc(sizeof(*window), GFP_KERNEL);
-		if (!window || len < sizeof(struct dynamic_dma_window_prop)) {
-			kfree(window);
+		if (!direct64 || len < sizeof(*direct64)) {
 			remove_ddw(pdn, true);
 			continue;
 		}
 
-		window->device = pdn;
-		window->prop = direct64;
+		window = ddw_list_new_entry(pdn, direct64);
+		if (!window)
+			break;
+
 		spin_lock(&direct_window_list_lock);
 		list_add(&window->list, &direct_window_list);
 		spin_unlock(&direct_window_list_lock);
@@ -1303,7 +1315,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
 		  create.liobn, dn);
 
-	window = kzalloc(sizeof(*window), GFP_KERNEL);
+	window = ddw_list_new_entry(pdn, ddwprop);
 	if (!window)
 		goto out_clear_window;
 
@@ -1322,8 +1334,6 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		goto out_free_window;
 	}
 
-	window->device = pdn;
-	window->prop = ddwprop;
 	spin_lock(&direct_window_list_lock);
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
-- 
2.30.2

