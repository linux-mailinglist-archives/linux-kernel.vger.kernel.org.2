Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212C1367A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhDVHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhDVHIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:08:49 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9F6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h3so20766048qve.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VYO/WSrJUAQuhWN9PmepPjluMGVj7vrr4kT01MiVYuU=;
        b=kWxMvTk4s6xV02bgiiwW4Vt9R1l9ULpEn1AJ/KlPj6EDJPaBl+d/RsYEJ3tAhzPohH
         DMWRlrW7uST8omMQG5kCdpym7Sun2ZVVH4zV0DbXHqtLEKBl7X47iyhv5g/lw/V8BGwD
         sHn07B/9vH2tR5EatcpiXZngF3wPTfWobyNJhOikyt6s5KHXZKhGNyFGgytCUh/DGfZe
         LCNm3jPwvtKkBSNcnc/nZxG7E4F0vGLEmgAhNc0pJAIGC/mjNZLwnirpGiS9y93OsXEH
         FwSWPSlcOZewRFFMDY4QI20hxsKApRpYc3ysxuUpy1bohfXTiR7poAuJfLN5oa3aNrRm
         M/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VYO/WSrJUAQuhWN9PmepPjluMGVj7vrr4kT01MiVYuU=;
        b=LzrbjnaYOQuUJhonNtfrdBk3ESYPctnfkgTBYDNVlphnzh8vW7/5q7ifzmF+/gecC0
         3lvU7YTjXmg1WcMxNZlGXUDt+ksE3E28+wsohSFFlJLYbCkVjlH//N+uGbA0pDQNOlnY
         mmSVneunHystvR6M//icB3k47OiXc/Uj+ISCRXMcLG+YK8ziX/6Pvfd1UoOAxaBvwrz+
         kzRHArBYDNmY/EUb9waPzl6TYXXn64qVxbfyt9xP8vFs64jm01zCRx0IuI6zHwrsjUiz
         VgaaJkNuSztSp/N4Awez525BFS9BsGBhIUh9V+ohPb3szH09OJ+mtb5cllY2AMiltcfs
         CrAw==
X-Gm-Message-State: AOAM532NAZUqgGix2t1ujuvtxLKaokAZkWyUPu64k/dGHWA9NCup0ExO
        xk2dys2hDs5wajzH+/pAI71VmI8xSHk=
X-Google-Smtp-Source: ABdhPJzlCrT7uAANQ2LSFJPELAJ9m8CfM2/wnmanAuGDDIoGU4hN9JCP/l2I1Fyid5sfe+06ZXVleg==
X-Received: by 2002:a0c:fb43:: with SMTP id b3mr1837220qvq.42.1619075293159;
        Thu, 22 Apr 2021 00:08:13 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id w67sm1658329qkc.79.2021.04.22.00.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:08:12 -0700 (PDT)
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
Subject: [PATCH v3 03/11] powerpc/pseries/iommu: Add iommu_pseries_alloc_table() helper
Date:   Thu, 22 Apr 2021 04:07:15 -0300
Message-Id: <20210422070721.463912-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422070721.463912-1-leobras.c@gmail.com>
References: <20210422070721.463912-1-leobras.c@gmail.com>
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

