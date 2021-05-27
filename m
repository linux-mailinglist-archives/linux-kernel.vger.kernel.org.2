Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A96392AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhE0Jge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbhE0Jg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:36:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5A4C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l70so3288119pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6BVXsaS11IAfMyHtJiAg5Ol68mjN6vT4RM+MpSdQtA=;
        b=szBVqK4TJXUoZMJ5L2aPdAKI91Hi8jBSP6ql9PZS4s3V23KtjKAziLLp0qpU5VOQSg
         DKG+rubBXkdzsRQf86Z6YhUxEJV9qloQuQLLub0EE5XLIs0PYzvUMVfunjUPP45EugxZ
         QZ5VQ6AySA+Zbk1di5M8YWcwGO6VrLXNIxt99S8DYxdDtNUhIVaG8viJ6H3nKdLIoQlz
         WoDF0OiQ3xyficaDKjxcITXwmSguyfk5+KUMPK3vAO65L046nMt2ZBTutnVwSOxNNcfx
         5J/CWPaSTo7VIho+yY4MTvQmjXWYhF0PeCXDG7d5aARD+CNTQ4sQrBRSnxSahrSdg3EM
         5acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6BVXsaS11IAfMyHtJiAg5Ol68mjN6vT4RM+MpSdQtA=;
        b=OcfMu9AzIEmUHtz6zA5hubDU16m9An+Z2wmoDOBELAds2XJrAcjS+8nje4oMs3CPLZ
         4Y01joEnolg20sik0Qp4mWMDoToM1mWAD5mzlYDI5qvn9BOWn3m6o0Id0VbMp7ihpcU1
         70lUgvjCTes8GEoZLNpUVbq8QzTZbu6ifk99Zl01DX1OYdrF8IT2+GBGMnJM80xnIIc9
         YBc3ARznDfsTzZAvovdx2WXi2x885tejuDTJXFbEHJExB3wLPWbiMRy5xGFwa2ELCmAJ
         7MZWggwWrBFTWjvE/pfGll32Q2ItIglcZXDZigaE94fut9NuOGqeC/aDmkiGNtDXEfZk
         ikPw==
X-Gm-Message-State: AOAM530umkPpeiP+O9ZPkSMLK1SQ5/a7qQxQEBzeeM9MK2p8PJKmE3Qm
        G/kcfqFrEhw2TrobeLlfQpdSrg==
X-Google-Smtp-Source: ABdhPJyf5GyjKjc67XHYiDY5BLcexKS9X52KNX4XLqz3/n1TTECE4ihpT7tVtQG1w2c3JGNf4AqI7A==
X-Received: by 2002:a63:e709:: with SMTP id b9mr2849946pgi.153.1622108094821;
        Thu, 27 May 2021 02:34:54 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a9sm1418917pfl.57.2021.05.27.02.34.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 02:34:54 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v4 11/12] mm: lru: add VM_BUG_ON_PAGE to lru maintenance function
Date:   Thu, 27 May 2021 17:33:35 +0800
Message-Id: <20210527093336.14895-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527093336.14895-1-songmuchun@bytedance.com>
References: <20210527093336.14895-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to make sure that the page is deleted from or added to the
correct lruvec list. So add a VM_BUG_ON_PAGE() to catch invalid
users.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm_inline.h | 6 ++++++
 mm/vmscan.c               | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..1ca1e2ab8565 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -84,6 +84,8 @@ static __always_inline void add_page_to_lru_list(struct page *page,
 {
 	enum lru_list lru = page_lru(page);
 
+	VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
+
 	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add(&page->lru, &lruvec->lists[lru]);
 }
@@ -93,6 +95,8 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
 {
 	enum lru_list lru = page_lru(page);
 
+	VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
+
 	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add_tail(&page->lru, &lruvec->lists[lru]);
 }
@@ -100,6 +104,8 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
 static __always_inline void del_page_from_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
+	VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
+
 	list_del(&page->lru);
 	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
 			-thp_nr_pages(page));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 731a8f5a4128..5c30dffce768 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2063,7 +2063,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.11.0

