Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9221367A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhDVHIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhDVHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:08:44 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A628C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:09 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d19so9682761qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I4QRVxLCAXlMYXP/RCpevP+dV/qRZSoD5enD89iFcqY=;
        b=XpqwUuL2ZYmiSKlOyucgu6dStg2r0g9v1+y3IUG9PU/je4dSGI2x+nekvye5OMleu8
         xK+SzgD9hIiIWRaFrbK5ETC8y9gGnQpzYX8Dc5UVoqKa/zYLbCLucIZu9hja5H6chE8w
         r4rD61GQxLvAqp+BYPhbK4e0GS+bR+WevdEo5FaIBnPMWXFGOoAWFSy3QxAsEZ17LEHd
         ANjK2QsR6Oc1HLG5QKTqyHUJVROyrIwO5/mgbaXizf/6h8l9uE8wA9j4r1ov0PBIQeNP
         RBNpZTxO32v6zj9jrzC3zCHu3Crw1YJR1wLUScaJXIksZxGTTQR9FrXk0QflG9lbGtRk
         Vq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4QRVxLCAXlMYXP/RCpevP+dV/qRZSoD5enD89iFcqY=;
        b=FK3DEznCb1LUiDUHG+L+shPsn/fNZiy5mME+s4KppXsxf4MeMCeerCZJUUqONlnuP5
         1Qy/WCsDo1noi0LZJbIhxyRqZ5SYZ0Wc5gr7xrwhzNDh9wTzn5U9LT9ePHpkqbCFnCsC
         nheLmegX22eoAZWm3ygUDy3pF+794ldWmY9cd1XH/3Qn/5C/nHqUwpwq1E7FjK8ACo6W
         f6cDXexIV79oZ1UR28PjxM2g78D23MKgK4WrmccavsSL4jb/J3U6hNd9EVxG5nGydtpS
         OX528U6bB4ktdQNZlrwVBLK/dvGzfdSPuMx7lDiZjnbDs5Mw+cJA2K2oMh9fO8CS+V7u
         Y7VA==
X-Gm-Message-State: AOAM531vtgo9cF0lpGII/q/IgLdnC56n51VxHSOSCnKlW47tgxiBqI1j
        w1b+p+kqeAqmAA72RZkJg2Y=
X-Google-Smtp-Source: ABdhPJz/8+PHDvo2/6In/AoYq1bfyfq0t/wW7Alj0qzagwbFO+22iYQOHQzYN0WsWZX96UTwUbTNtA==
X-Received: by 2002:a05:620a:1092:: with SMTP id g18mr2212434qkk.57.1619075288518;
        Thu, 22 Apr 2021 00:08:08 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id w67sm1658329qkc.79.2021.04.22.00.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:08:08 -0700 (PDT)
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
Subject: [PATCH v3 02/11] powerpc/kernel/iommu: Add new iommu_table_in_use() helper
Date:   Thu, 22 Apr 2021 04:07:14 -0300
Message-Id: <20210422070721.463912-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422070721.463912-1-leobras.c@gmail.com>
References: <20210422070721.463912-1-leobras.c@gmail.com>
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

