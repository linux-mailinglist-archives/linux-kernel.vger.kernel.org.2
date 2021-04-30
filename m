Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A9936FE91
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhD3QdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhD3QdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:33:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F7C06138E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:32:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k127so15668325qkc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VYO/WSrJUAQuhWN9PmepPjluMGVj7vrr4kT01MiVYuU=;
        b=r5wG4ZIp0DghweYrb7BhTEg3Kw1src5C+ZZBqCXlTWE1bZV7bFSh/xbKn1I6HnSmVZ
         Y6BRnXi613ZhHJDDVj96/JeNtkFJb6utsFpxhCCGvpQB2vOXfWEwzrD6UkyBqb6aqTqC
         Z539mxM8+agShzuMop5DKz1Jh+KRUvJrvvBNomfNzxooHM/5rknJd6Rh7PIgvlxf1NYV
         9iP82LDonuG4dacJwqh4Vya58EnUDAjYUIS/y8r+52Ed5Ra2B/7GXC2vberWnLGvzhTS
         81Cp+Ymq20OoFZR+XRfi/zqTpiZshA8PMnbqT/CMp6oLfN7AwCBQ6K0qLSo9FPrSb4XD
         4COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VYO/WSrJUAQuhWN9PmepPjluMGVj7vrr4kT01MiVYuU=;
        b=jICNOIC1Jwqc1eckhM2KkfB65sih4xV54Gvn1+SXB3WOdBz+DBH6f06HBF9IjXrPZN
         QchwIUFTj513KXnw19memMPh2DoIW/CoJ8ab/ZF6qNcxAiyFeLJRuktA5NiQjlgDjmJk
         Z8M9hdKnJkfXb1PrFUFPyZx27AVfGWkf0Z9ZPMNZ8FYdwrzBh+2YgsJpcsCfRMFiK8Jh
         piHNX26FFPPHHPAU84danxUXvV3VG/kl5H029FPuph03pUIsaAz1htCjL0MN4KNmJwuc
         k9ZWH0O8Ye64zY9ggx2ldDm3O2fybxVqSR2Yz2K2NHMj2DE8FWJnkjnbGKpRNZFWZ6Af
         QM5Q==
X-Gm-Message-State: AOAM533KnQXXN+vVcIQNEi5hxBCd1/Fk9moj0A7Lc4M3n1nCwgtjE4+L
        EM7MSthSxgFugEbo3TUu84TvzoiBlHs=
X-Google-Smtp-Source: ABdhPJzSO3lpl1iJqvmYeVyf7bcnQVMCcwNDY+IHlHL+v09OKq08YVc22NCUBY8t9ef9gScU0RU2KA==
X-Received: by 2002:a37:492:: with SMTP id 140mr6290975qke.161.1619800334473;
        Fri, 30 Apr 2021 09:32:14 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id p1sm2624334qtu.89.2021.04.30.09.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 09:32:14 -0700 (PDT)
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
Subject: [PATCH v4 03/11] powerpc/pseries/iommu: Add iommu_pseries_alloc_table() helper
Date:   Fri, 30 Apr 2021 13:31:38 -0300
Message-Id: <20210430163145.146984-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430163145.146984-1-leobras.c@gmail.com>
References: <20210430163145.146984-1-leobras.c@gmail.com>
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
index 796ab356341c..d02359ca1f9f 100644
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
2.30.2

