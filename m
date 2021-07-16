Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A93CB447
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhGPIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbhGPIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:30:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F363CC061762
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:03 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d15so6516928qte.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUrP4QoTCQR8l2iwLnjTudvlnGjF3JRrmtcKOvLOyXM=;
        b=eMigb/+hbnh2dGBnlbD76LJ2Dr7FOwy2oIadfCLKGD0T1aYdJypepfilstJd0n6HNO
         m4ijjKBtHsDVZw87cc4BNpKYGUmPwxfOWZvXgUyvHqdJq40F8lXfxhcK+5r3/Ps98nIf
         hjdMAuBtt0nQpxg93/qRy4OGfDbdC6i0Pi6ADsj7jeJ21hj31i0mJW6c+G7/zFBWe1ml
         oUQbqfUEmmfzPrk3W7lsCaqhHb8KsTagpbU9C9levolQZtWHMoYWwU4r3JBqADLYGqIk
         WQhoncKrzXXL06xcBG8fP7YcYRiCOpf7484KXNMXumJ0G7sbiDSAjlY5gJrSoW7SlOm3
         xD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUrP4QoTCQR8l2iwLnjTudvlnGjF3JRrmtcKOvLOyXM=;
        b=nnIkJETPt55HEk2ppU8mpCqsug/6nXfU3jqyA+Hkt3RBv5gNoi8v9GfGpm2I6LcrfZ
         guMC2RS/XzQAeQagiVJ5K8amyr592WKweJ3LbKNFG/KmU9cr7UMt/+0CX0byLxEtokyp
         CuBAei1GmRhcq+KNh0AyL1f2tTIyODoLhbH35T3UQEikds2K5lteo1ieVSEIA3hU+1c8
         aeejBBKNAUldRDSxH5fvIgTsDUVACo98DMlbZ/yh/WZ0oQ0RzG4kyYHgpZpEWDnVN1OV
         8uqdr+iafVsoepmdJUy1JiUupKTO2Uu9Ljcg2I+WMU8EBP3z9Ji5BL4jNCFwkBlD9J88
         IeRg==
X-Gm-Message-State: AOAM530oCl+RIQNGqjMrAgmnZYoJOaHWS/7t5RRVgrxPZgNm6095u6RS
        BV2zeA50kcvaEBI/QD5pclc=
X-Google-Smtp-Source: ABdhPJyb03w2NRFpPVWrL6j1Ohf0onxKemSXngfKd4TuPTI5bYR42ZcAlOIxPk75FFkLVTLQ3fll6w==
X-Received: by 2002:a05:622a:10d:: with SMTP id u13mr3357982qtw.369.1626424083146;
        Fri, 16 Jul 2021 01:28:03 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id q199sm3603540qka.112.2021.07.16.01.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:28:02 -0700 (PDT)
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
Subject: [PATCH v5 03/11] powerpc/pseries/iommu: Add iommu_pseries_alloc_table() helper
Date:   Fri, 16 Jul 2021 05:27:48 -0300
Message-Id: <20210716082755.428187-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716082755.428187-1-leobras.c@gmail.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates a helper to allow allocating a new iommu_table without the need
to reallocate the iommu_group.

This will be helpful for replacing the iommu_table for the new DMA window,
after we remove the old one with iommu_tce_table_put().

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index b1b8d12bab39..33d82865d6e6 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -53,28 +53,31 @@ enum {
 	DDW_EXT_QUERY_OUT_SIZE = 2
 };
 
-static struct iommu_table_group *iommu_pseries_alloc_group(int node)
+static struct iommu_table *iommu_pseries_alloc_table(int node)
 {
-	struct iommu_table_group *table_group;
 	struct iommu_table *tbl;
 
-	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
-			   node);
-	if (!table_group)
-		return NULL;
-
 	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
 	if (!tbl)
-		goto free_group;
+		return NULL;
 
 	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
 	kref_init(&tbl->it_kref);
+	return tbl;
+}
 
-	table_group->tables[0] = tbl;
+static struct iommu_table_group *iommu_pseries_alloc_group(int node)
+{
+	struct iommu_table_group *table_group;
+
+	table_group = kzalloc_node(sizeof(*table_group), GFP_KERNEL, node);
+	if (!table_group)
+		return NULL;
 
-	return table_group;
+	table_group->tables[0] = iommu_pseries_alloc_table(node);
+	if (table_group->tables[0])
+		return table_group;
 
-free_group:
 	kfree(table_group);
 	return NULL;
 }
-- 
2.32.0

