Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91C3CB446
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhGPIa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbhGPIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:30:57 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672F1C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id q15so1602181qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uhyjd06rye2Lt4itGL2yWFEWzknsfkWKzMVknqoxjo=;
        b=C6gJtDPi+QgGe0I/KAHMbCxzK8Ql4CGthKaGsRL3mpXJNJgSpkPnNbX1iX9WaLSx7v
         tsyOUEcLkMuv1Hjc/vm5veyPLShvl1askpHZjzC5STyv5zYJMZA6ReUi5Hn9V2hnzkKJ
         g7Ow4pzMLJAmcYKAeWIIgI+6yaV6VK/ZhgQfcI1oOQw2uI0MaZKNRDPUjyYd66RHZ1VH
         uozwxGY8mvnFxabW4EjbBwuqUAVEfNY79HsCFuPMJM8vijXSxtRXKWcRFs3hXtwbQ4re
         e5rX2do7cIiye+l4ogGMFOqMQVeEm2Ub+slzlJpgdKXGM2jL2gIW5lGjJqNjgc7HjrmX
         TKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uhyjd06rye2Lt4itGL2yWFEWzknsfkWKzMVknqoxjo=;
        b=Kaz+FJsdvrCiDY7kBX3H17pheLpP6AF1WbSjOFmc+sYGIWPBH3XAR7XW9ygdmBNCxi
         GAxvSGaFAgUCgU0Mi3Bd4TAylCEUx8g05Pi+FqoITVD9Vd4oV5Ea4hu4ijCUQLmGdmgt
         D2Nm5GUhlrnKg/NUTZS7sb/EVN88Gbz+wZEg9OrhulY9sBarUQQzsLB9q7FOvB1HE/yE
         Kp4w0RXM7rVDARmm5SCP+iKkh8C6o5j7x1cdkQNLZ9sDg+ghzsYxrz2Lcdf/YGVnVpKA
         tnBWTvIChp1aIy+LbSCrYda1w1N76MxabqL02KnRz5nUW4/+pX3xD0sOOKhlTHRUnfeM
         7EQg==
X-Gm-Message-State: AOAM532oIs5Htxvifzuo/JTAOUEZPtWxgSJaJLplaDlFS8lvHi00dRMG
        oiDZTkPagEjro16BfuIbgjo=
X-Google-Smtp-Source: ABdhPJxsnceLRCp9Soj8SJY4Lj3vpWs99j2D8GPEcK3bP8ORPfbRdGn86qVdxwAXpCC6W+ojvIkapA==
X-Received: by 2002:a05:622a:138d:: with SMTP id o13mr7943854qtk.134.1626424080614;
        Fri, 16 Jul 2021 01:28:00 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id q199sm3603540qka.112.2021.07.16.01.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:28:00 -0700 (PDT)
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
Subject: [PATCH v5 02/11] powerpc/kernel/iommu: Add new iommu_table_in_use() helper
Date:   Fri, 16 Jul 2021 05:27:47 -0300
Message-Id: <20210716082755.428187-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716082755.428187-1-leobras.c@gmail.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a function to check if the iommu table has any allocation helps
deciding if a tbl can be reset for using a new DMA window.

It should be enough to replace all instances of !bitmap_empty(tbl...).

iommu_table_in_use() skips reserved memory, so we don't need to worry about
releasing it before testing. This causes iommu_table_release_pages() to
become unnecessary, given it is only used to remove reserved memory for
testing.

Also, only allow storing reserved memory values in tbl if they are valid
in the table, so there is no need to check it in the new helper.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h |  1 +
 arch/powerpc/kernel/iommu.c      | 65 ++++++++++++++++----------------
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index deef7c94d7b6..bf3b84128525 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -154,6 +154,7 @@ extern int iommu_tce_table_put(struct iommu_table *tbl);
  */
 extern struct iommu_table *iommu_init_table(struct iommu_table *tbl,
 		int nid, unsigned long res_start, unsigned long res_end);
+bool iommu_table_in_use(struct iommu_table *tbl);
 
 #define IOMMU_TABLE_GROUP_MAX_TABLES	2
 
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 2af89a5e379f..b10bf58ae467 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -690,32 +690,24 @@ static void iommu_table_reserve_pages(struct iommu_table *tbl,
 	if (tbl->it_offset == 0)
 		set_bit(0, tbl->it_map);
 
-	tbl->it_reserved_start = res_start;
-	tbl->it_reserved_end = res_end;
-
-	/* Check if res_start..res_end isn't empty and overlaps the table */
-	if (res_start && res_end &&
-			(tbl->it_offset + tbl->it_size < res_start ||
-			 res_end < tbl->it_offset))
-		return;
+	if (res_start < tbl->it_offset)
+		res_start = tbl->it_offset;
 
-	for (i = tbl->it_reserved_start; i < tbl->it_reserved_end; ++i)
-		set_bit(i - tbl->it_offset, tbl->it_map);
-}
+	if (res_end > (tbl->it_offset + tbl->it_size))
+		res_end = tbl->it_offset + tbl->it_size;
 
-static void iommu_table_release_pages(struct iommu_table *tbl)
-{
-	int i;
+	/* Check if res_start..res_end is a valid range in the table */
+	if (res_start >= res_end) {
+		tbl->it_reserved_start = tbl->it_offset;
+		tbl->it_reserved_end = tbl->it_offset;
+		return;
+	}
 
-	/*
-	 * In case we have reserved the first bit, we should not emit
-	 * the warning below.
-	 */
-	if (tbl->it_offset == 0)
-		clear_bit(0, tbl->it_map);
+	tbl->it_reserved_start = res_start;
+	tbl->it_reserved_end = res_end;
 
 	for (i = tbl->it_reserved_start; i < tbl->it_reserved_end; ++i)
-		clear_bit(i - tbl->it_offset, tbl->it_map);
+		set_bit(i - tbl->it_offset, tbl->it_map);
 }
 
 /*
@@ -779,6 +771,22 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid,
 	return tbl;
 }
 
+bool iommu_table_in_use(struct iommu_table *tbl)
+{
+	unsigned long start = 0, end;
+
+	/* ignore reserved bit0 */
+	if (tbl->it_offset == 0)
+		start = 1;
+	end = tbl->it_reserved_start - tbl->it_offset;
+	if (find_next_bit(tbl->it_map, end, start) != end)
+		return true;
+
+	start = tbl->it_reserved_end - tbl->it_offset;
+	end = tbl->it_size;
+	return find_next_bit(tbl->it_map, end, start) != end;
+}
+
 static void iommu_table_free(struct kref *kref)
 {
 	struct iommu_table *tbl;
@@ -795,10 +803,8 @@ static void iommu_table_free(struct kref *kref)
 
 	iommu_debugfs_del(tbl);
 
-	iommu_table_release_pages(tbl);
-
 	/* verify that table contains no entries */
-	if (!bitmap_empty(tbl->it_map, tbl->it_size))
+	if (iommu_table_in_use(tbl))
 		pr_warn("%s: Unexpected TCEs\n", __func__);
 
 	/* free bitmap */
@@ -1099,18 +1105,13 @@ int iommu_take_ownership(struct iommu_table *tbl)
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_lock_nest_lock(&tbl->pools[i].lock, &tbl->large_pool.lock);
 
-	iommu_table_release_pages(tbl);
-
-	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
+	if (iommu_table_in_use(tbl)) {
 		pr_err("iommu_tce: it_map is not empty");
 		ret = -EBUSY;
-		/* Undo iommu_table_release_pages, i.e. restore bit#0, etc */
-		iommu_table_reserve_pages(tbl, tbl->it_reserved_start,
-				tbl->it_reserved_end);
-	} else {
-		memset(tbl->it_map, 0xff, sz);
 	}
 
+	memset(tbl->it_map, 0xff, sz);
+
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_unlock(&tbl->pools[i].lock);
 	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
-- 
2.32.0

