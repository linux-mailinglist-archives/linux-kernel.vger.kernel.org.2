Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51C231DDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 18:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhBQRBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 12:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbhBQRBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:01:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:00:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb24so1816584pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieECyghvBmC2satFZ6K4eL8/reOcYYWCYp0/BHVv4Os=;
        b=QA0EM6cke64ioEYU1NPofPda1QzGLV12C9sjiG+Dba8gviDszYiUWjOErf3QrrE3Vw
         SYLNaWdKykzhugsP+AaFbK+wn+IYtS/pDpTtoSHsphS2nlncH4K1xK0TKzvkyWsUGbe6
         4qnS0TnZY1NCRGWB79gGsF4xdTb3tDfVIKol1pDja3gmPS/adYeUDkWlquD2E6dT/AFb
         q2JvXJopIkSd5bdYUOybfDii4KBR8DRrp5NjmbmgGjnxg/QPnBQQV2uExdABJ1bNcvEI
         l5V4W35VaRgeuJTLtTi1eGGWOL1ALigd7Jozp99KFztfgL4YYxU0z3QcWLVjeRz2F/uB
         kf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ieECyghvBmC2satFZ6K4eL8/reOcYYWCYp0/BHVv4Os=;
        b=qAPrVYTn+PbOjVqvoB0afb3h68qunPvP8vlaQHl4QVLonB42eckS+URfJK2OMYz8va
         n7Rm/aV2ofYtXPi2m7igkgJ49g61zVl8unYFIyR8xu1hKDNZBh7f44kuI5mmrARmJfMs
         n5r8wpFmhcY0jRvPH3nNm3QgFYQNqLQH9pjfxv70q6cfUUIdF51K3IBNKi2ud9JPPhBe
         JatyDtIVT6CD/YQG/zhNBKNOo51Z48rx2nZSPiv8RCxK2oY8K1Abd6/2FNJlIQt2dcWu
         8XWOm9PgXbe6tvzDDfruIs0nRmc7g29MOKoHQPFX8D0xAXg3/Wwr0ZcPNLHVtrT42UWc
         VDWw==
X-Gm-Message-State: AOAM530zJHWJV/xePVBhzHynZ281GUwpwq/DXSWeVjBdfEdDoPF7OvdJ
        9mTubWUD/hGgJtRP8R9Qb70=
X-Google-Smtp-Source: ABdhPJz1vnmsl7qVhNZA1McdS5wSOaQXvHZL2mpixQck6Em2l2+hJ9DSFJ4wrgozlLmAQ7NvNVqT1w==
X-Received: by 2002:a17:90a:70c1:: with SMTP id a1mr10231855pjm.19.1613581229975;
        Wed, 17 Feb 2021 09:00:29 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:cdf7:1c5d:c444:e341])
        by smtp.gmail.com with ESMTPSA id k31sm2992096pgi.5.2021.02.17.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 09:00:29 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: vmstat: add cma statistics
Date:   Wed, 17 Feb 2021 09:00:25 -0800
Message-Id: <20210217170025.512704-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since CMA is used more widely, it's worth to have CMA
allocation statistics into vmstat. With it, we could
know how agressively system uses cma allocation and
how often it fails.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/vm_event_item.h |  3 +++
 mm/cma.c                      | 12 +++++++++---
 mm/vmstat.c                   |  4 ++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 18e75974d4e3..0c567014ce82 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -70,6 +70,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #endif
 #ifdef CONFIG_HUGETLB_PAGE
 		HTLB_BUDDY_PGALLOC, HTLB_BUDDY_PGALLOC_FAIL,
+#endif
+#ifdef CONFIG_CMA
+		CMA_ALLOC, CMA_ALLOC_FAIL,
 #endif
 		UNEVICTABLE_PGCULLED,	/* culled to noreclaim list */
 		UNEVICTABLE_PGSCANNED,	/* scanned for reclaimability */
diff --git a/mm/cma.c b/mm/cma.c
index 23d4a97c834a..ea1e39559526 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -434,14 +434,16 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	struct page *page = NULL;
 	int ret = -ENOMEM;
 
+	count_vm_event(CMA_ALLOC);
+
 	if (!cma || !cma->count || !cma->bitmap)
-		return NULL;
+		goto out;
 
 	pr_debug("%s(cma %p, count %zu, align %d)\n", __func__, (void *)cma,
 		 count, align);
 
 	if (!count)
-		return NULL;
+		goto out;
 
 	mask = cma_bitmap_aligned_mask(cma, align);
 	offset = cma_bitmap_aligned_offset(cma, align);
@@ -449,7 +451,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 
 	if (bitmap_count > bitmap_maxno)
-		return NULL;
+		goto out;
 
 	for (;;) {
 		mutex_lock(&cma->lock);
@@ -506,6 +508,10 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	}
 
 	pr_debug("%s(): returned %p\n", __func__, page);
+out:
+	if (!page)
+		count_vm_event(CMA_ALLOC_FAIL);
+
 	return page;
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 97fc32a53320..d8c32a33208d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1305,6 +1305,10 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_HUGETLB_PAGE
 	"htlb_buddy_alloc_success",
 	"htlb_buddy_alloc_fail",
+#endif
+#ifdef CONFIG_CMA
+	"cma_alloc_success",
+	"cma_alloc_fail",
 #endif
 	"unevictable_pgs_culled",
 	"unevictable_pgs_scanned",
-- 
2.30.0.478.g8a0d178c01-goog

