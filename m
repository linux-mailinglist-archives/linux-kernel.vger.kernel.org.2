Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688753CB448
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhGPIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbhGPIbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:31:01 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97457C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:06 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 77so7901764qkk.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3+83yzbFQq/PFFzGDFoywhH27snBZiW/PLWZzD8z9Q=;
        b=UPeRmlt8CiV/lZ/I5YnavccKBrZlDh9NMTkw6GYeY+14sRS/ChQHa2K5gkn0JnhMEJ
         joSTc1JZ3Ds40TjYZN42HcbuhZRfDVMVOUXYLz9GoKNbbRdMkzRkewP7FdxrT32ILjxL
         OF9SNFknmBrDQEyhZk+K53OFC9a+Gf0SSe5WSe+thMG6jUgYr+L3Vb8/OgdQE3giY1Vw
         zxmTiIw5N0HftS9UjIlxpKkERvkTqwqmC81ey6oXHyZmJAI22q6hCaUCAiDCaIK0tN/P
         3DTMtfdPKIzM69/xpKafmGUlwAI7reFf1v/EmiwZdTMUr8MelxUXFlmjOcSsk2lYyen+
         kwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3+83yzbFQq/PFFzGDFoywhH27snBZiW/PLWZzD8z9Q=;
        b=Mg3LdfsWd8wXJqTzvswh/BpBgWZddpoZEYoVFfHYeoMFUykUWc391uO+kYxZb/Tv8Z
         Q8dN1Lu9rP0FTY44ZChgN3lCJ9FwcSBgP7xiQMOCBQ0Dw2RbYA5qWG3z1hVvpGQHQ46T
         pfMPPnuiw/zpsxWQLSS24CYnBxuBmo2hjhBBKOy0kGHYG1pIMgsHSxCtRtWvGRtFzP6y
         +zI1JfMaoqtmOczvZC9ZugqKJ2ACFevEyn09aMZ6K5ylRVvjpIoMcyoZnK4wFQUf1vJZ
         HnJfWG+GTqK5+ttKYOxdijH8mYH7YaDLKWqzEn5p5TSNV8/c3RWZvJAuEudB/8XnwMVD
         ZMWw==
X-Gm-Message-State: AOAM530uYgYocLaN3bJmjG3QkCWdupZrY1hAdHeemK/T57e1TJVVMH3S
        iVxR1G4tCAoAa8bN5bNM/cw=
X-Google-Smtp-Source: ABdhPJzdNEPoCc3Vn1zv2AoWdtsg5viM9npzOUT6b+TsXtiSCHWC/FI8FhQYGDhZKOId95bwoFB8xQ==
X-Received: by 2002:ae9:e203:: with SMTP id c3mr8311912qkc.400.1626424085880;
        Fri, 16 Jul 2021 01:28:05 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id q199sm3603540qka.112.2021.07.16.01.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:28:05 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/11] powerpc/pseries/iommu: Add ddw_list_new_entry() helper
Date:   Fri, 16 Jul 2021 05:27:49 -0300
Message-Id: <20210716082755.428187-5-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716082755.428187-1-leobras.c@gmail.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
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
index 33d82865d6e6..712d1667144a 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -874,6 +874,21 @@ static u64 find_existing_ddw(struct device_node *pdn, int *window_shift)
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
@@ -886,18 +901,15 @@ static int find_existing_ddw_windows(void)
 
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
@@ -1307,7 +1319,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
 		  create.liobn, dn);
 
-	window = kzalloc(sizeof(*window), GFP_KERNEL);
+	window = ddw_list_new_entry(pdn, ddwprop);
 	if (!window)
 		goto out_clear_window;
 
@@ -1326,8 +1338,6 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		goto out_free_window;
 	}
 
-	window->device = pdn;
-	window->prop = ddwprop;
 	spin_lock(&direct_window_list_lock);
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
-- 
2.32.0

