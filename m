Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44063CB44C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbhGPIbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbhGPIbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:31:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E2C061765
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:16 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m68so7930605qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iXGgb/5Va0eqpRGTSVzjW8LDpHV/dLXtU//ErgInw+M=;
        b=MKISFQEzulngPloG/c1AkFIgXCAZxuKeEXjHi2jlqZUoA3XrTwiil4nya8QLpqNNqZ
         tJ5KQJA7qgN/ENmBMCHrk0j0+wKSz5uopBGjXmHl4HWx0v3MVcmo+ohsVbcuuDjoLDjE
         ok7uQXndColbCJNlYV76QLS6Y6Sy6zW21BNi/GbKNDUQcoUd+j2pikDx/Heec07H0Wv5
         RilMrCbS8Dr2DssaJDj+Qajm/33piDPSdBx4UTDLN329L3bC2JxNdxV/fNv2tbmFl/hF
         5SM4UYUqGjKaY6NZd6bGbid6Oq254vtdLOshCGS2Q7zO/+TGFYZ0NuWhSAeY4eWgbM/7
         pWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iXGgb/5Va0eqpRGTSVzjW8LDpHV/dLXtU//ErgInw+M=;
        b=qhNVsAFvcsYAZx4E4WNPFnFoz0NlkcuXT3/GkXBAZsllsjEpgfehi0SZgjKMuHzUIu
         yJVFM20qXmRuzIAWMZXvx4jwltO2TCy78jFilAvMPYVoEvQsUDpCthkqe5rsnGkTOAwq
         b2DOH/VV//5cfkDe4Y44J9+bVkXghlXSwqN3BxNEFXK2lkq9LlIsXfbery/X2/fXO/G6
         PKHm6lQuAj8zNsWmFXiXCpZ/uxZoQ604Om11h/AwOOlckx+Sl1VE4aV8Q2rWXZ3s03ke
         Ca9NsOAdQkIL5iuvmdNKjzao3maClTzIjpNr1P1T3j9P9GJoLAbxPcKioMwv8rFlaV8r
         C76A==
X-Gm-Message-State: AOAM532YHL8pV+c3MnfwAiNVH5sw+jNeoeOr1vBcMVgRFOeivrEAeyDe
        7BWBp7CTLgBxifUBZOcQ5F8=
X-Google-Smtp-Source: ABdhPJwmLvmTbw6c+J0LkX71SrVmkzTc2XGeAjYD7caA5SiZG0Ttv/ab891S5JLeRlFZmD3/pQ5Eeg==
X-Received: by 2002:a37:2d04:: with SMTP id t4mr8839951qkh.160.1626424096100;
        Fri, 16 Jul 2021 01:28:16 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id q199sm3603540qka.112.2021.07.16.01.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:28:15 -0700 (PDT)
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
Subject: [PATCH v5 08/11] powerpc/pseries/iommu: Update remove_dma_window() to accept property name
Date:   Fri, 16 Jul 2021 05:27:53 -0300
Message-Id: <20210716082755.428187-9-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716082755.428187-1-leobras.c@gmail.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
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
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 108c3dcca686..17c6f4706e76 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -830,31 +830,32 @@ static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
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
@@ -907,7 +908,7 @@ static int find_existing_ddw_windows(void)
 	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
 		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
 		if (!direct64 || len < sizeof(*direct64)) {
-			remove_ddw(pdn, true);
+			remove_ddw(pdn, true, DIRECT64_PROPNAME);
 			continue;
 		}
 
@@ -1382,7 +1383,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	kfree(win64);
 
 out_remove_win:
-	remove_ddw(pdn, true);
+	remove_ddw(pdn, true, DIRECT64_PROPNAME);
 
 out_failed:
 	if (default_win_removed)
@@ -1547,7 +1548,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
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

