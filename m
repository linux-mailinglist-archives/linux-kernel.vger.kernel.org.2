Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED436FEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhD3Qdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhD3QdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:33:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42941C061344
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:32:34 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id 1so52043952qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQkRMEiXoQJQMt0E0Ob7yojj6AwxsAD6eCu+/Ai/15M=;
        b=TfnJKPEgix5OxYiA7R8Z8XefjWILZepG3WO2mkrfgF/qZEjOD8qptZyYNsr61swk0E
         xK+xtD6T73a9685pPhtVkgRNnSErvjRLXTRy48cVPwtlD0OHfqPebBqIbCrpKSb71qWd
         X21TGGmFNzj0W9nztC0QILn0eStvZmPZVam25EeWQ5uB9kP4E8E7bBEK0ejqljOB2RbM
         xnFH79MBma+dhWXdShcZo8TNo2LHTP2SPMhR/wsGOzPxP2TSkBuMvdfLXkIxs+Mn37M7
         GOzEHDvA/v0UmYvY+JjEnwOwFYQSchRRVdEuoKfCqOO6IKqnnxLA0n2H64QrCh+q30HQ
         P5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQkRMEiXoQJQMt0E0Ob7yojj6AwxsAD6eCu+/Ai/15M=;
        b=UcUTTMO2H6HoBBlzfYrzKhY8yhnkDkYqHIkXtqSZaf9DGgQ7/poRnp1EZX35eLnois
         +tCwuqVlJqOgAaQhEllF7Un2XGVrEhTsU0bCdVNIAI1sbXqgmwNpQ4V87ceu1rir7jC4
         1BWG00cGtMDEF2iW6EjDFytUDQN+Ww9ZdAmac+a5TsLJnDs/f5jyZ7iHJEF2eeiv0dcn
         GJJa+IqWFotr8n7d5PXZLK8b/dI9GlCNTIS4eE77aLOYWMevd8GVTZcgehagzJPo+g8P
         Kd/YaF/ONLc1YGmvPm1WfoouvTBi8quZKd5PCjxZz2ygBJtd0wDz1WFgMhsRiZUsoqO6
         ADOg==
X-Gm-Message-State: AOAM532vLoqONEfcnQ3AS+Rzudgz2fTBblVAScxp4MrQeLC03cuosWYz
        jJDjoWeBDBdjL1LeT6ONGziZCL+DMic=
X-Google-Smtp-Source: ABdhPJzGfg0X4b0k9MbUIGzs3UtEen9/o5yUludLt0Jhn9zF23fk13ygFMFzEZZEo7tAAYPzOehoog==
X-Received: by 2002:ac8:7344:: with SMTP id q4mr5045314qtp.278.1619800353580;
        Fri, 30 Apr 2021 09:32:33 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id p1sm2624334qtu.89.2021.04.30.09.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 09:32:33 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/11] powerpc/pseries/iommu: Update remove_dma_window() to accept property name
Date:   Fri, 30 Apr 2021 13:31:43 -0300
Message-Id: <20210430163145.146984-9-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430163145.146984-1-leobras.c@gmail.com>
References: <20210430163145.146984-1-leobras.c@gmail.com>
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
index 89cb6e9e9f31..f8922fcf34b6 100644
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
 
 out_remove_win:
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

