Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551A740DBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbhIPNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbhIPNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:54:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5BDC0613EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:53:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e16so5975912pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QjeJQ0YTKzcUeZcg+zZ6AwSMvoUSpJAhbMH1V05RNeQ=;
        b=K1bHsyfWmH1qaHSYncFdFlHW5oAkrOJ7QNUWKGjw16s2Qr0IaVNZdV4PghIUXDGXbb
         /iu2WOu4QbtPdWZUiQh1puLHVJ6B2KIw1+BwIwfDrnfF2r3C6oc8tuGcE+mvKSDA9H3j
         LnT2Z/HWp/uDMuN2xuOMHhmsU/k4AzOQa1Wa1HvLcx7p/RQfKNNkAmLB+EpSeeKkBo8A
         1IYPpQbt62PZl6HBaMJqVdcgDJibZDVVkhpS+adIkaBKwSTRnOmN/xWP+uTs9pAy0C7r
         dx+IO7ME2oOHvedSlamFnXcjyLMuFlRd4/BcUUx5mAKPsNfQYI90EiUi9qGVcLyG8IR/
         gzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjeJQ0YTKzcUeZcg+zZ6AwSMvoUSpJAhbMH1V05RNeQ=;
        b=Q4bbTPaylXK+1XAbJFn7XsxXNTBsWC9gm6ok5ROkt6xWVMMOi5D3De4WPQgVkghROe
         Ydvckk/LW4FawIXACDLmmzqT84bBGg6gqmBdjA94fWghJM88FJkrjPd9GELqr56LKmwv
         H82C0IIygXeffT1npomOei+6wgRsyeUDjX7xkEkR5MvC9Muyqa9+eFwxlawtL7KjxfIt
         RoqTsUsvds/UaVtDtS9I/p/7O4Hi+xU2VIl45WEXa7p8/o3mrZ7KoKYkzYzebQLC0Xv3
         pwNDXwBCsdKlWUOW55JRhZcK5Isa7twhCzKqg9SK7IIbX5hRg7oiM0FGJUUi821JyOb4
         bz2w==
X-Gm-Message-State: AOAM5316myE10ti3D2Z8qac5m9na8xM6DLNCIYAiY0fSUcNHLu/LpI+c
        RQtqLc1IQ/f8cM23jUjdU2We0g==
X-Google-Smtp-Source: ABdhPJzkDf5eikgx9JbA3X/pRE/Z7u02fZ0xZpmaQ8o3VN8/kee21C1WAfd6LGjOPlCFJhJVj4KrYg==
X-Received: by 2002:a63:af4b:: with SMTP id s11mr5072323pgo.185.1631800399729;
        Thu, 16 Sep 2021 06:53:19 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.53.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:53:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 12/13] mm: lru: add VM_BUG_ON_PAGE to lru maintenance function
Date:   Thu, 16 Sep 2021 21:47:47 +0800
Message-Id: <20210916134748.67712-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
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
index 6878a6bff2f8..f38ec21babf3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2199,7 +2199,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.11.0

