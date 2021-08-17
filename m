Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB58D3EE6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhHQGlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbhHQGlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:41:10 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D6C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:37 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id m3so10678967qvu.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nohRkEmBhJ456vza0SGQFpwvp2m1XhmvKD+E3e6gpIc=;
        b=S4FVU46lNzjBm03WNWtewVwQV4cjt+148/xWic1zmTpF7MIfY5aVMbp0Nau1eUGq2K
         GGoHxejBXNeNNVZK8hF+qFLpPbaoHHD0OVC4moNtZFhiUwFPj15Jeu+UoYwwUW6s0Fih
         8y7leivTl+gxUCi6g2yD7o38GN9nQn1wwvp0lPHUKLadkAsU/nvLkLxX8W1YmZXOEIkz
         Wg8fQnOPNGRY/OkeJOyrp9JZZvljbz3RTrc6hJjxb/KcfSWTWU+pbtePyFoxH8dtk09g
         sYiD9RvFqASr/b5kkP8p08SVXV4WKcIfYK8hoesqmaVNsmv639s/BJ44t0rQqcjbESWz
         CcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nohRkEmBhJ456vza0SGQFpwvp2m1XhmvKD+E3e6gpIc=;
        b=qkW84Tz0jVnEk3YjVUxH8WaBRbeIRlW7YVTTOp4tDH8fO/21w/UxIadqpAcPhtv9bE
         cxFfp6PwvlrgRdgzL53aief3N8O4yEzj9GvnsKtq+BCbKewINY7enzB4pGK/Ag0CG5ZP
         i5fFFD2l6vaHykbhrI9Uwo70+C4rBNOFRa4X7f+0RNe0tS4W24pWSCp3K6CHLjYlMgcj
         UTbhF9kzdBKmuvZUB+DlzxEQuxtxVTcHvguNXwnzdD1gblCw/CLwI9ePeFpozEgbC14h
         WIJFA+ZwWyN51nf0fLsqtPAh0i0dS/TWYCFWzd0TTx14af3DXg6CkpdtpgAlz6DQKAgm
         RY4w==
X-Gm-Message-State: AOAM531GNP2jYzI60ryPnLxqCwE+9p51RZaDPO13b1D5fjuVfS34f2az
        p7l0HKPxrAzB+NdI3XFbqRA=
X-Google-Smtp-Source: ABdhPJwBDp1+3Xcd8pmbo7T1m0zjICSc6lURMHxvAjssSi2yxwvlSp2mnG+uZPLN5ecmsc1hzmXgxw==
X-Received: by 2002:a05:6214:285:: with SMTP id l5mr1821244qvv.24.1629182436549;
        Mon, 16 Aug 2021 23:40:36 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id c11sm526938qth.29.2021.08.16.23.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 23:40:36 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/11] powerpc/pseries/iommu: Update remove_dma_window() to accept property name
Date:   Tue, 17 Aug 2021 03:39:26 -0300
Message-Id: <20210817063929.38701-9-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817063929.38701-1-leobras.c@gmail.com>
References: <20210817063929.38701-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update remove_dma_window() so it can be used to remove DDW with a given
property name.

This enables the creation of new property names for DDW, so we can
have different usage for it, like indirect mapping.

Also, add return values to it so we can check if the property was found
while removing the active DDW. This allows skipping the remaining property
names while reducing the impact of multiple property names.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a47f59a8f107..901f290999d0 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -844,31 +844,33 @@ static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
 	__remove_dma_window(np, ddw_avail, liobn);
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
+		return 0;
 
-	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
-	if (!win)
-		return;
 
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
@@ -921,7 +923,7 @@ static int find_existing_ddw_windows(void)
 	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
 		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
 		if (!direct64 || len < sizeof(*direct64)) {
-			remove_ddw(pdn, true);
+			remove_ddw(pdn, true, DIRECT64_PROPNAME);
 			continue;
 		}
 
@@ -1565,7 +1567,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 		 * we have to remove the property when releasing
 		 * the device node.
 		 */
-		remove_ddw(np, false);
+		remove_ddw(np, false, DIRECT64_PROPNAME);
 		if (pci && pci->table_group)
 			iommu_pseries_free_group(pci->table_group,
 					np->full_name);
-- 
2.32.0

