Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F53E8E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhHKKPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhHKKPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:15:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EC9C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 03:14:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so8755876pjn.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WTYHCuEFnDXdB595cBPoi/SpKE+ZbfqYRRPA09fPLBw=;
        b=jx8AUoTQAOgs9ofWY5K5kxiwPKCVzGGBeoXdoH4akiiVwKI77R0i3HxPQbzo/YR6jI
         7X6/CA7cLOifwYEJq6WzFM0QbqUuMCCcEOY4OUpORmKj4aYj/YY1wmo3PRW2G+yLBoUp
         LWiOmBwXejyksqxHaRJtUVmWJOzdEeQH6EZXDBMSczddBmT26nk/u19+be42Nxvf46Hc
         OjBSA+EFAu5EyxGpASDFnq8q3CwDPosjc4c/OUGbSNsWrnCVZXMG+BSHb+m2X7dHwnXM
         LlJs3CyuKeVDHumGce0tbWEAGPMTIefdMWhvRu44uqIIcGMj835j891v7uZshwcMz+1w
         XPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WTYHCuEFnDXdB595cBPoi/SpKE+ZbfqYRRPA09fPLBw=;
        b=BBmBthHCU1UnX3ndRNsG9MUe9ER4GbqVT6aMlHS1zv8d/hZBW1NTdmDSIN753IKOyE
         KOyChwaBEcxBEO86YiqWtP2yWh/3OAgBtWjg6FmLbkyXKX75oF40+LxeYkWJW5kwEPtc
         qfe8V1dDFfWQmgrEzE0/f/xDf42qUpvQ/J5ZUxc4k9r5qfS7eM4zRq5jqbCyHoNg+mYI
         lpJLMtP2rwL87xZF9dyaKFwBTfHdF2UuBmnJ4U80+1NyzXHS5jMqZSa3pu+TMaXE2sd8
         xMyJnhuyPG4cYR869HpMnuqenOCLx5m0EysW8FNrBlih0y1qRBJVZgFI0WH33YVPmHPA
         QKMA==
X-Gm-Message-State: AOAM531wbc8VQwXTQPQSJ5mvwC3WT/BsLwx8ZWT5XkblJpiW+7tXGQC+
        +qmTQhLknGBAEHq5c7rtcDBDwg==
X-Google-Smtp-Source: ABdhPJx+cDYF/LEloaMQBMlcUPfXkUTsidMnZGGA13tVHR88Xitp2kznMxEPgg5Hi5y6anpDDS8leQ==
X-Received: by 2002:a63:4245:: with SMTP id p66mr269734pga.402.1628676883499;
        Wed, 11 Aug 2021 03:14:43 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id m6sm14598674pjv.40.2021.08.11.03.14.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 03:14:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        william.kucharski@oracle.com, kirill.shutemov@linux.intel.com,
        dhowells@redhat.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: remove redundant compound_head() calling
Date:   Wed, 11 Aug 2021 18:14:31 +0800
Message-Id: <20210811101431.83940-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a READ_ONCE() in the macro of compound_head(), which will
prevent compiler from optimizing the code when there are more than
once calling of it in a function. Remove the redundant calling of
compound_head() from page_to_index() and page_add_file_rmap() for
better code generation.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/pagemap.h | 7 +++----
 mm/rmap.c               | 6 ++++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 79ec90e97e94..03b9a957ef10 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -608,18 +608,17 @@ static inline struct page *read_mapping_page(struct address_space *mapping,
  */
 static inline pgoff_t page_to_index(struct page *page)
 {
-	pgoff_t pgoff;
+	struct page *head;
 
 	if (likely(!PageTransTail(page)))
 		return page->index;
 
+	head = compound_head(page);
 	/*
 	 *  We don't initialize ->index for tail pages: calculate based on
 	 *  head page
 	 */
-	pgoff = compound_head(page)->index;
-	pgoff += page - compound_head(page);
-	return pgoff;
+	return head->index + page - head;
 }
 
 extern pgoff_t hugetlb_basepage_index(struct page *page);
diff --git a/mm/rmap.c b/mm/rmap.c
index 232494888628..2e216835f07c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1231,11 +1231,13 @@ void page_add_file_rmap(struct page *page, bool compound)
 						nr_pages);
 	} else {
 		if (PageTransCompound(page) && page_mapping(page)) {
+			struct page *head = compound_head(page);
+
 			VM_WARN_ON_ONCE(!PageLocked(page));
 
-			SetPageDoubleMap(compound_head(page));
+			SetPageDoubleMap(head);
 			if (PageMlocked(page))
-				clear_page_mlock(compound_head(page));
+				clear_page_mlock(head);
 		}
 		if (!atomic_inc_and_test(&page->_mapcount))
 			goto out;
-- 
2.11.0

