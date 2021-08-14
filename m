Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C73EC0B3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhHNF1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbhHNF1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:27:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53929C061575
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso4896773pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QA9/p/h+KpQBCu0VXssIO4coGl6opMzNI5lAhcd+PlA=;
        b=KDQ5YMhgkeEAvreorbhUVEHxzOIds006yyG7sFmzuFq31cEDc/SNg2TOFchU4xbqWa
         1XBG/aepaxXn4ctwfkD+f/wOUrWBRIMwaiB/0STszbdDRmsudQEoxsiLYs+6OMrNMJmB
         lNnQy25bdCLe9AuL4d7jAWRz+ndeHYY94Nn9oZEZoNugTMW9s5H3sbODiyzgNZyUnu+R
         y5KbGSFShj/a7gotHGrE44xj0sl1YilJ1zP19RRFJhAZpTYnFgzpUTJG5HHTeNOY75vA
         ZCLc90EFBuIz3S94EHEGHwZZxcvZnVnCXiwTvgtNKIrH0DnSsXops3lWSlu3cQ7tjJNW
         tHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QA9/p/h+KpQBCu0VXssIO4coGl6opMzNI5lAhcd+PlA=;
        b=CKhcPGOhrh36WltX15p6CuzT+kVDXyJKFgJ1A0V7bDTlAjgiY7LUSsp0XTyqgQS03m
         joylt6V15AgotlVsvcsS3RFKCwP41YnwA+GtbNLGmmLE+ntjmmizvNbINePUmFBwNCbo
         SoeAR9Z6ZiCNcklHloGvzBTAr26xr8GSoUJT7zrlkFCRnc9N3ba3hyCpYMLnWOw7pUa3
         2DnZAOe7KUNhq8D3bI4fSrhlJUxdPa4vRltocA5OWTr1sj7emALVF4Tzepo0j35eROdN
         X3yIbFUqxTIhyJNvq48U58Ln6czsMIKyXgXnt2xkqkbQ6r5o2irRn6N7EN4Pe9P4sHVj
         VLpQ==
X-Gm-Message-State: AOAM531D34IvAztL3KYA4aoWnmXwgfsyXIpREg1pXVRKMUmaVQ7gyGzG
        esojJqoaaGvgqDy34bwrxcK1iw==
X-Google-Smtp-Source: ABdhPJxgg7nnSBePeld5ZlmypZa6XkSzDz0hdBCtPjQN0Tp1f4d/XEOeVbI75li7/4OYOqGU73DoMg==
X-Received: by 2002:a65:62c1:: with SMTP id m1mr5447376pgv.339.1628918796923;
        Fri, 13 Aug 2021 22:26:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.26.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:26:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 11/12] mm: lru: add VM_BUG_ON_FOLIO to lru maintenance function
Date:   Sat, 14 Aug 2021 13:25:18 +0800
Message-Id: <20210814052519.86679-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to make sure that the page is deleted from or added to the
correct lruvec list. So add a VM_BUG_ON_FOLIO() to catch invalid
users.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm_inline.h | 15 ++++++++++++---
 mm/vmscan.c               |  1 -
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e2ec68b0515c..60eb827a41fe 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -103,7 +103,10 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 static __always_inline void add_page_to_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
-	lruvec_add_folio(lruvec, page_folio(page));
+	struct folio *folio = page_folio(page);
+
+	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+	lruvec_add_folio(lruvec, folio);
 }
 
 static __always_inline
@@ -119,7 +122,10 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 static __always_inline void add_page_to_lru_list_tail(struct page *page,
 				struct lruvec *lruvec)
 {
-	lruvec_add_folio_tail(lruvec, page_folio(page));
+	struct folio *folio = page_folio(page);
+
+	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+	lruvec_add_folio_tail(lruvec, folio);
 }
 
 static __always_inline
@@ -133,6 +139,9 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 static __always_inline void del_page_from_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
-	lruvec_del_folio(lruvec, page_folio(page));
+	struct folio *folio = page_folio(page);
+
+	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+	lruvec_del_folio(lruvec, folio);
 }
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8ce42858ad5d..902d36ec91a3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2204,7 +2204,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.11.0

