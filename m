Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922B234D705
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhC2S0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhC2S01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:26:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:26:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m7so9946082pgj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u+59y0AgHiCfa77pcnvLNXwvfOfWr12NxzeqiJWwICM=;
        b=tvc0JlPZB8KS4gWQqc3cM0KfLUX2R4UXyDMt7DKDT1Mm1ogaDmzTmMvdYRkvoJsXcx
         s2qQjvRu1JexihwYHvQ4vrexUlbJGnrq9XlA7HIwIojtQUTgKzL0N/lvsA0emx4asMDV
         IEGD5KJZOvtIrdQRAC+TW7dyncY3IPDd8sQsR5cLkqLTp7n9hGiiK9dO9z6knnwtihcD
         MATMTm0EZ4ZAICybtQC5wK8ctU8k86o07hkx35QjZES5X6n+CDyKuEpsmidGHfDciwsb
         fYhfAVKdNZox00icj/0jAsx5J287lNMYdFHoidLDDG4Th32d0Ag3DFqMWSO+bRV1vnNC
         QbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=u+59y0AgHiCfa77pcnvLNXwvfOfWr12NxzeqiJWwICM=;
        b=FGvsCs6iBzRNy6746pYZPMQWs98/MxtizG2Xrke6NG4N3jPVPRa6eU1CdKUH/md7vM
         Dm7p8xCcwcastk36njZPoB46O5FB6MYA03I4tuDlIr9ta8OkNCfHdNtmJ4Q390WpbwoP
         zPtNUeN2FpTTEib24/bqAe/OWNsPEuZdQ3rIgdJDI64hZRUUxJzGfQwPMlgA7fS39U4v
         3NUIETZ7HnGisRp4r11sQLwHAS9J2X/M7BU2YCUt7RJDt4o+xAY7nZDrK3/iPFDsBJFJ
         G2YYtDXemhOQd7lZ03ur40rtQhwLZ1FicqlPQILepAnItciST+eIWO3oGc+sp3LkHy3w
         l7qQ==
X-Gm-Message-State: AOAM5310AHDakE/Vfz9Ud4QoKlSEcl8kEEXyUS57ZACWcBDnwO3adxEh
        apVc1ZNOJ50acVOf1mIR05g=
X-Google-Smtp-Source: ABdhPJwp8ypTTZarskX1sJRiiD2a2nR+WHK4mxCU+pXx+fgTZeG9QwpK6DEFiWtzZ7tCN7QppynIeg==
X-Received: by 2002:a63:4944:: with SMTP id y4mr3304413pgk.9.1617042386769;
        Mon, 29 Mar 2021 11:26:26 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:e9af:f14a:516c:eaef])
        by smtp.gmail.com with ESMTPSA id w191sm20034744pfd.25.2021.03.29.11.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:26:25 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] mm: change size_t to unsigned int for cma_alloc
Date:   Mon, 29 Mar 2021 11:25:53 -0700
Message-Id: <20210329182553.3129234-1-minchan@kernel.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

size_t in cma_alloc is confusing since it makes people think
it's byte count, not pages. Fix it.

Link: https://lore.kernel.org/linux-mm/20210324043434.GP1719932@casper.infradead.org/
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/cma.h | 2 +-
 mm/cma.c            | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 217999c8a762..a873edc20ca2 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -44,7 +44,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					const char *name,
 					struct cma **res_cma);
-extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
+extern struct page *cma_alloc(struct cma *cma, unsigned int count, unsigned int align,
 			      bool no_warn);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
 
diff --git a/mm/cma.c b/mm/cma.c
index 08c45157911a..24dc01e26d45 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -423,21 +423,21 @@ static inline void cma_debug_show_areas(struct cma *cma) { }
  * This function allocates part of contiguous memory on specific
  * contiguous memory area.
  */
-struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
+struct page *cma_alloc(struct cma *cma, unsigned int count, unsigned int align,
 		       bool no_warn)
 {
 	unsigned long mask, offset;
 	unsigned long pfn = -1;
 	unsigned long start = 0;
 	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
-	size_t i;
+	unsigned int i;
 	struct page *page = NULL;
 	int ret = -ENOMEM;
 
 	if (!cma || !cma->count || !cma->bitmap)
 		goto out;
 
-	pr_debug("%s(cma %p, count %zu, align %d)\n", __func__, (void *)cma,
+	pr_debug("%s(cma %p, count %u, align %d)\n", __func__, (void *)cma,
 		 count, align);
 
 	if (!count)
@@ -500,7 +500,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	}
 
 	if (ret && !no_warn) {
-		pr_err_ratelimited("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
+		pr_err_ratelimited("%s: %s: alloc failed, req-size: %u pages, ret: %d\n",
 				   __func__, cma->name, count, ret);
 		cma_debug_show_areas(cma);
 	}
-- 
2.31.0.291.g576ba9dcdaf-goog

