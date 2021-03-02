Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3054832AD34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383992AbhCBV3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbhCBSew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:34:52 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5325C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:33:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k22so12525820pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jCpVAboQLdBqZYKx26GU4neeHv3BGMTwSsImuS2ye0=;
        b=EGmNYL6mpzjRtbguBty8kgbusD3XtJx46CaEc7GOeJSxYrNgyratpeIG2/jHUugkjs
         q8rwN1WYBjIdZCXTuaRnfnXGtkPjww+ExhyTKbUyrrSjNp2Ou1zhz7dTQhWQ79U4Kmik
         LUprswxQiR1152CDyEi+IHaWR5GY1CzEPrU63GwOTzaahMc7xAKoLgtWxBF7KHX26bZO
         an4wk5zJqiYoiRjk//9xDaU0/VfxordRirMYF0YPBJhFa9FN+JFE+nTkNu07lpZPJ2+p
         oNzKkbjCAXuqLz3s0YVD+pouoyaqAvG6fFOd48GmAtKR7XIiYZxkuARCzpW2drfpmwtV
         XEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8jCpVAboQLdBqZYKx26GU4neeHv3BGMTwSsImuS2ye0=;
        b=g9yiBiZRFlVBtT0jrUi1nkQYK5luB2mVIVb0tQwg3hDk+zjZVhOa3klGhw8rLzEcNd
         Gm6ou5v5cZbb/IEQmFLULf2k6fWuQTzP/96FrIStw83n2h8kEQJPPmKvE+CtXAl9ajch
         MKbNSLv+Ddryr6wz+h9ZNYTCsFG0OszhCMHoIGZd5yf8i/r7dkcihJoGbGMAmC2gsAaK
         flxkjFU7+PJuz/ZEheqQa+Ehxf7/JBsSXYIhmQDpfu444l43WtdvGVhxhNjZxBQQDmpV
         otxTmtcwxgkc/dxES85muwJ0hpkYmXV81BUAyTTku9xYwcGEeqgpo3yFLqWHf1LaKVPX
         tEJg==
X-Gm-Message-State: AOAM532rB6IdqigNrTb1XfmbYS6mpit9X4uKCdOWYjcOn5GdI+dvriSY
        sUARJ2eJjIvUKjUyvs7rxpc=
X-Google-Smtp-Source: ABdhPJw654Ud+u9umslN5dXMXbXoDGr+fntXeAC/t6UIRLGvfDormS+Z2qPg1R4T7D8BtFOSh6kNyA==
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr5762459pjs.15.1614710031191;
        Tue, 02 Mar 2021 10:33:51 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:c87:c34:99dc:ba23])
        by smtp.gmail.com with ESMTPSA id c24sm1516531pjv.18.2021.03.02.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 10:33:50 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, jhubbard@nvidia.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2] mm: vmstat: add cma statistics
Date:   Tue,  2 Mar 2021 10:33:46 -0800
Message-Id: <20210302183346.3707237-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
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
* from v1 - https://lore.kernel.org/linux-mm/20210217170025.512704-1-minchan@kernel.org/
  * change alloc_attempt with alloc_success - jhubbard
  * item per line for vm_event_item - jhubbard

 include/linux/vm_event_item.h |  4 ++++
 mm/cma.c                      | 12 +++++++++---
 mm/vmstat.c                   |  4 ++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 18e75974d4e3..21d7c7f72f1c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -70,6 +70,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #endif
 #ifdef CONFIG_HUGETLB_PAGE
 		HTLB_BUDDY_PGALLOC, HTLB_BUDDY_PGALLOC_FAIL,
+#endif
+#ifdef CONFIG_CMA
+		CMA_ALLOC_SUCCESS,
+		CMA_ALLOC_FAIL,
 #endif
 		UNEVICTABLE_PGCULLED,	/* culled to noreclaim list */
 		UNEVICTABLE_PGSCANNED,	/* scanned for reclaimability */
diff --git a/mm/cma.c b/mm/cma.c
index 23d4a97c834a..04ca863d1807 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -435,13 +435,13 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	int ret = -ENOMEM;
 
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
@@ -449,7 +449,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 
 	if (bitmap_count > bitmap_maxno)
-		return NULL;
+		goto out;
 
 	for (;;) {
 		mutex_lock(&cma->lock);
@@ -506,6 +506,12 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	}
 
 	pr_debug("%s(): returned %p\n", __func__, page);
+out:
+	if (page)
+		count_vm_event(CMA_ALLOC_SUCCESS);
+	else
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
2.30.1.766.gb4fecdf3b7-goog

