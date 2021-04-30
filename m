Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0636FE90
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhD3QdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhD3QdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:33:01 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F083C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:32:10 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d12so13981229qtr.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I4QRVxLCAXlMYXP/RCpevP+dV/qRZSoD5enD89iFcqY=;
        b=qFwcpe5Y1475O5k50BkxZMR3qD6vW1DIUbs/kEgfV2D/ey0ZHC/pAsm+YjWIt5ZDOP
         WEBRGN153hcoXmytAxffhYArAR64OAXc5FQ8ECuWOe8qId/iPafv/gPqsLcvRfi0+976
         qISwZj95vFcTD9fIkmg/2e7CzHGP5GmeRhJwCeJnBkCt2bgT01byzTqcpxvBTDz6myIk
         5Vt2urRTB5Q4J4CB4fJ7HNRfsMdDOF5BEKRGKKckNjo7XtQDsfp9Bq0fH0rgyoczNM92
         krqzdUdpSjc6lQaqT2LVBCLrbKKn9AoMliyEIRdbtHIbCNcernzL9n60sK7o8kaoSlGP
         9jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4QRVxLCAXlMYXP/RCpevP+dV/qRZSoD5enD89iFcqY=;
        b=qVTjpKa2CwXV2JnwxM4Ys4yR0xaXgpS4nKAbL3LYQQu+HoJSespogu0/Gv/hA099qn
         +M+47mr9C7f2EZQAzL+ozUzIglukouixgtif9dZUSlDC8H9YmeGvxJcRRKX5j868FEWZ
         APtuHy4DlEW72plNYXGsLiF8dJkFYfMFerQqX4dbT6jJCefh/VNKr20eKErvveg33VtM
         KkRuIUzM7sQrkZqKvb5ZXTk6XEXP7QhLXXPOd4UA4RSaUK3254k1d4cex5ZwCAmXAyt2
         Jw9URADs7ADj6f4PCISPQi21ATLuDqp0Oc8jGtStDI5Dli1nmpi//vFXpawxpfps/b7D
         nmHQ==
X-Gm-Message-State: AOAM530o3Rv86W/FeltCRL65SmXNbEx4K3hpDiwXE/agdQfplfF3Ue5v
        eOjT0Q/NBO+TKsLaTJMjPGE=
X-Google-Smtp-Source: ABdhPJxZlx+8siUQANjeDJF/jHb9HeHjTomfkZdKXEvvYqrclxqfxiI3uaQ/QfSmmepXY8+igcSNVQ==
X-Received: by 2002:ac8:e09:: with SMTP id a9mr5307013qti.238.1619800329681;
        Fri, 30 Apr 2021 09:32:09 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id p1sm2624334qtu.89.2021.04.30.09.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 09:32:09 -0700 (PDT)
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
Subject: [PATCH v4 02/11] powerpc/kernel/iommu: Add new iommu_table_in_use() helper
Date:   Fri, 30 Apr 2021 13:31:37 -0300
Message-Id: <20210430163145.146984-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430163145.146984-1-leobras.c@gmail.com>
References: <20210430163145.146984-1-leobras.c@gmail.com>
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
index ad82dda81640..5e168bd91401 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -691,32 +691,24 @@ static void iommu_table_reserve_pages(struct iommu_table *tbl,
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
@@ -781,6 +773,22 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid,
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
 	unsigned long bitmap_sz;
@@ -799,10 +807,8 @@ static void iommu_table_free(struct kref *kref)
 
 	iommu_debugfs_del(tbl);
 
-	iommu_table_release_pages(tbl);
-
 	/* verify that table contains no entries */
-	if (!bitmap_empty(tbl->it_map, tbl->it_size))
+	if (iommu_table_in_use(tbl))
 		pr_warn("%s: Unexpected TCEs\n", __func__);
 
 	/* calculate bitmap size in bytes */
@@ -1108,18 +1114,13 @@ int iommu_take_ownership(struct iommu_table *tbl)
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_lock(&tbl->pools[i].lock);
 
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
2.30.2

