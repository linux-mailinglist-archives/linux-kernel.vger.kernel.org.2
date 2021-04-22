Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65046367AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhDVHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbhDVHJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:09:12 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6AAC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id q4so4745754qtn.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwfujHgMzglyScI7GeNIjisX5iaQuzItH19PwGeIyKg=;
        b=ixK1+5OsOEfr3ODi4U4LSVLsfZziSk425usmtInlQr0YST+1LOp2KG7WG6Cy/n82T7
         +XPhIEgLy/UQ2Ye8vZ4XY9OveQ4lsAD+gaDs9/ZepJ4RSFGKOZl+AvnqrY0LzJ0Kya3Y
         gQ/f8otHE/BWGO2fnRrNmTmGpHRZU0cCA5EdvDoNW867Luwp/MbamWvQV0KF9OyQJOK5
         6it1iopcWXT2MH/6GWt7Zd+jIcgjw+gZqLQRk3BZoPDOwjoA8JxTSyyB0M0rhNkzz7y4
         FrWdxYB1k7TMMeGOT80ufA4gvmGl5eEd4CeJsyP0lA/7x1Me7s10tX9++8o9TDL4AeSe
         Xf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwfujHgMzglyScI7GeNIjisX5iaQuzItH19PwGeIyKg=;
        b=FIzA66syxZ04Vo5oREiTtFrk6Aot56II3nxO8kyqjJApOGrFbSv2kHoP/tQnIMKvrS
         AOlrQHzryosBo2SU4sXKmu5bYZLs0Pg74b5MpsBTh+5WMKLC4ojKjg8dmPrNYA1sJJC/
         pp39pPRWyNYIDEZlG1OOUG4pL3kp7IRJiRfYuLd0sjdIbIOIxlxuk/d8amewq7uHILnB
         MTZCEHEQCaYEgI5C7nJc+RoXixn94hxUuJlMZAHTDhZZsEXdVGXLh8EASGb1y+bKOlYp
         BLBCNSPvdTrUYhAt+0rAoZYiiU77VI/juJNEepi5lFMVHsK4Zqrlwi+/YlZ1F2lCic17
         G33g==
X-Gm-Message-State: AOAM533dUzBhwtv1iUECTXlsgoJro2uNiYJGNQ2EftBLkkKy6QJ5KTge
        moGXVhZlbvQn8YyB9B7kxQ4=
X-Google-Smtp-Source: ABdhPJxs0qlDrXwGljG+SQ56jMGScgAac9VXw1yt2VA6N5FBTeNHpwY9oBS683R6fFUpHZDqoQiCog==
X-Received: by 2002:ac8:7596:: with SMTP id s22mr1639546qtq.11.1619075316014;
        Thu, 22 Apr 2021 00:08:36 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id w67sm1658329qkc.79.2021.04.22.00.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:08:35 -0700 (PDT)
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
Subject: [PATCH v3 08/11] powerpc/pseries/iommu: Update remove_dma_window() to accept property name
Date:   Thu, 22 Apr 2021 04:07:20 -0300
Message-Id: <20210422070721.463912-9-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422070721.463912-1-leobras.c@gmail.com>
References: <20210422070721.463912-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update remove_dma_window() so it can be used to remove DDW with a given
property name.

This enables the creation of new property names for DDW, so we can
have different usage for it, like indirect mapping.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0147ccaf0be4..075c6e08f012 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -823,31 +823,32 @@ static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
 			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
 }
 
-static void remove_ddw(struct device_node *np, bool remove_prop)
+static int remove_ddw(struct device_node *np, bool remove_prop, const char *win_name)
 {
 	struct property *win;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	int ret = 0;
 
+	win = of_find_property(np, win_name, NULL);
+	if (!win)
+		return -EINVAL;
+
 	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
 					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
 	if (ret)
-		return;
-
-	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
-	if (!win)
-		return;
+		return 0;
 
 	if (win->length >= sizeof(struct dynamic_dma_window_prop))
 		remove_dma_window(np, ddw_avail, win);
 
 	if (!remove_prop)
-		return;
+		return 0;
 
 	ret = of_remove_property(np, win);
 	if (ret)
 		pr_warn("%pOF: failed to remove direct window property: %d\n",
 			np, ret);
+	return 0;
 }
 
 static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift)
@@ -900,7 +901,7 @@ static int find_existing_ddw_windows(void)
 	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
 		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
 		if (!direct64 || len < sizeof(*direct64)) {
-			remove_ddw(pdn, true);
+			remove_ddw(pdn, true, DIRECT64_PROPNAME);
 			continue;
 		}
 
@@ -1372,7 +1373,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	win64 = NULL;
 
 out_del_win:
-	remove_ddw(pdn, true);
+	remove_ddw(pdn, true, DIRECT64_PROPNAME);
 
 out_failed:
 	if (default_win_removed)
@@ -1536,7 +1537,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 		 * we have to remove the property when releasing
 		 * the device node.
 		 */
-		remove_ddw(np, false);
+		remove_ddw(np, false, DIRECT64_PROPNAME);
 		if (pci && pci->table_group)
 			iommu_pseries_free_group(pci->table_group,
 					np->full_name);
-- 
2.30.2

