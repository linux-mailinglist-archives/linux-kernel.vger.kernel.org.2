Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60B3CB44D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhGPIbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbhGPIbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:31:15 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFEFC061762
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:19 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o9so4206167qvu.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HStJt93myujXkiZQMq2zmTujx5HW2GAuqZwyAMsw7c=;
        b=qHUoBUu3Sw3Tk0EuHyvuzjq4f6BBXmGfLKzUbS3/NaKeCWnBP2KjAbYBBMeQimTgUD
         qOEIZiwIpl/Zo/dZcW3xFuYlgfYrbo/IHzhVWXivW9raaiga4RK0yfVTWqGxmb79cSIh
         I8QjImbiI1SfuOSu71s9E460qBnw0r3Fa1qMiMdQUYoSdaUtGqUV9DwIA4A7dV1fVvXC
         xPvUBWPRiRBZ6X3ykVrhAkwMRuzVl3jTb5P7BGPApI3zed0lyXFyLqJyXkULD2KHn354
         X160sTIvkxmzScKCG46SU/uZtNpH/B1hNdkio/VNablnNDAw5cPTWWFjJeLtw16N9Vcm
         IIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HStJt93myujXkiZQMq2zmTujx5HW2GAuqZwyAMsw7c=;
        b=ZBm0l0BVhdiWA4ZNd7nSZ9QsjcvQ8FIn8PCjYu+0XpWPyN0awXafIJldelFFqTE4+r
         h+3TxsWcl3IOwDgcSXmK9VFqambuQZqiO21WVNXLQ87+9LoeiMb11Ftm9EgWoRuAi157
         dQTftXi0FSqW3KpeZ2UJ/XBPepHnifjhfLKFxvdFe9rJ8aZf5ZEOSsHPpg5jBG8DG96f
         +K5FuVMqo83rijlJvAFSK8zXJhSME5LjiQsw9dWm08MOmn6SCjpsWOWIbZys7Fl4MZbj
         wYMtQQ8WUpUjfPxIYdQGaGr+kB2rakmJhvqC+IZqVxlbmMXKrZp5oQx5G8bC7oR/V+v1
         N5YA==
X-Gm-Message-State: AOAM532KxVZ5ZMJosuR0Zdm+oXIvZR0fLQRxqeC2arlABG39Iw/H33NF
        KRcfAQ17dVhJEPPW+6YYq8s=
X-Google-Smtp-Source: ABdhPJw0i5ZUI8lYnbnD00lebBmJteNllGdC0MOzJ03SzUov36MdHGpP20MCxVYVmLVjuJDILGBzsg==
X-Received: by 2002:ad4:5144:: with SMTP id g4mr9049706qvq.3.1626424098644;
        Fri, 16 Jul 2021 01:28:18 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id q199sm3603540qka.112.2021.07.16.01.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:28:18 -0700 (PDT)
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
Subject: [PATCH v5 09/11] powerpc/pseries/iommu: Find existing DDW with given property name
Date:   Fri, 16 Jul 2021 05:27:54 -0300
Message-Id: <20210716082755.428187-10-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716082755.428187-1-leobras.c@gmail.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment pseries stores information about created directly mapped
DDW window in DIRECT64_PROPNAME.

With the objective of implementing indirect DMA mapping with DDW, it's
necessary to have another propriety name to make sure kexec'ing into older
kernels does not break, as it would if we reuse DIRECT64_PROPNAME.

In order to have this, find_existing_ddw_windows() needs to be able to
look for different property names.

Extract find_existing_ddw_windows() into find_existing_ddw_windows_named()
and calls it with current property name.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 17c6f4706e76..22d251e15b61 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -895,24 +895,21 @@ static struct direct_window *ddw_list_new_entry(struct device_node *pdn,
 	return window;
 }
 
-static int find_existing_ddw_windows(void)
+static void find_existing_ddw_windows_named(const char *name)
 {
 	int len;
 	struct device_node *pdn;
 	struct direct_window *window;
-	const struct dynamic_dma_window_prop *direct64;
-
-	if (!firmware_has_feature(FW_FEATURE_LPAR))
-		return 0;
+	const struct dynamic_dma_window_prop *dma64;
 
-	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
-		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
-		if (!direct64 || len < sizeof(*direct64)) {
-			remove_ddw(pdn, true, DIRECT64_PROPNAME);
+	for_each_node_with_property(pdn, name) {
+		dma64 = of_get_property(pdn, name, &len);
+		if (!dma64 || len < sizeof(*dma64)) {
+			remove_ddw(pdn, true, name);
 			continue;
 		}
 
-		window = ddw_list_new_entry(pdn, direct64);
+		window = ddw_list_new_entry(pdn, dma64);
 		if (!window)
 			break;
 
@@ -920,6 +917,14 @@ static int find_existing_ddw_windows(void)
 		list_add(&window->list, &direct_window_list);
 		spin_unlock(&direct_window_list_lock);
 	}
+}
+
+static int find_existing_ddw_windows(void)
+{
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		return 0;
+
+	find_existing_ddw_windows_named(DIRECT64_PROPNAME);
 
 	return 0;
 }
-- 
2.32.0

