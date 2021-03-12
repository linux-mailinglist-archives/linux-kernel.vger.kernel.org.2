Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2C8338B76
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhCLL2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhCLL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:28:18 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:28:18 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t4so23880759qkp.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KilxK7cdzAcDImsrYn4FRTgOx1aju2O33SCteVknzS4=;
        b=R4SHxwx1Y6xGLxcY2c4ZD2u01Z350Kb2+LnLijpNN5celAQnC09BWElPHqx+Oc32x2
         x803J/e9v8ZYvtX8FFCNQGNLXZsxBEreZLANcIBYJpjYK0QfDR9eVQaTq/WaqjgW1I5Y
         uxKHXpJx1zE6C2OvaFS3j0InWMwhlIgjr2DQyTRltwwXlSzkvxd0Zm+Drrgu0y+RHwHY
         7JpV3SzJXj08Ch59RnVuQz5F23YV2pDqhQKcLQnHfIaFhMIs0L6iBmmYCO2mIjMoEi0Z
         qfJQ2vMOqRTsWoxQzM03RVGpQnlXZs9Shm/qpUTwZiZZVx8Aj+ywgfleV6wnvf1ZMxI8
         rgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KilxK7cdzAcDImsrYn4FRTgOx1aju2O33SCteVknzS4=;
        b=TZhpSo4u9OC35s5KxFg08xrlGq+x2WC4W+Aioo9OhILzxnKuDp24mckhiisSCYidMe
         vXe8zf2Ls+GYv0igjDPrq+IfnxDRms11Q+WvQI5cJfu662vAutb2KktDaHUgdXOQcjlX
         4okBlrpEsfNsHgiDT+I1+Vrfi2jTA2DURgzvs3hjFiC63eTcTuMsvY/rNNv9AqNaxsTF
         hqs0cVaQ7VaPG1fc6r7UBP/2zum3uluGm7jobjn2gkU5QE46BsbPzkHH31OGLA5zIhE1
         /LDcU1PsGoADz0n/QJkVPR/lXg+pu++3JU+mGzRNkRJ/pnlxvy2xU9NgQCEGeCfrPFVm
         aTFQ==
X-Gm-Message-State: AOAM530UA7IYYVx6KGIN8WxxCzwdXsqeP1rmaTjxK4m0anRcFzex/HJf
        WKfMEXUdlnUpovQxtO/EKUA=
X-Google-Smtp-Source: ABdhPJzvjzi04rjt+//P5Mvj0gHfU4HRRyBBNMjnDwsxCvwU+FpBxBKZ6pU7UFby9PbTjgdeFxTiGg==
X-Received: by 2002:a37:4716:: with SMTP id u22mr12417015qka.21.1615548497535;
        Fri, 12 Mar 2021 03:28:17 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.63])
        by smtp.gmail.com with ESMTPSA id s2sm3826926qti.54.2021.03.12.03.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:28:16 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, unixbhaskar@gmail.com,
        aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] powerpc: mm: book3s64: Fix a typo in the file mmu_context.c
Date:   Fri, 12 Mar 2021 16:55:37 +0530
Message-Id: <20210312112537.4585-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/detalis/details/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/mm/book3s64/mmu_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index 0c8557220ae2..c10fc8a72fb3 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -119,7 +119,7 @@ static int hash__init_new_context(struct mm_struct *mm)
 		/* This is fork. Copy hash_context details from current->mm */
 		memcpy(mm->context.hash_context, current->mm->context.hash_context, sizeof(struct hash_mm_context));
 #ifdef CONFIG_PPC_SUBPAGE_PROT
-		/* inherit subpage prot detalis if we have one. */
+		/* inherit subpage prot details if we have one. */
 		if (current->mm->context.hash_context->spt) {
 			mm->context.hash_context->spt = kmalloc(sizeof(struct subpage_prot_table),
 								GFP_KERNEL);
--
2.26.2

