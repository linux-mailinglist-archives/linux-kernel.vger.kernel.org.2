Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E618366608
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhDUHD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbhDUHCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:02:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B7C061347
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:02:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p67so22873180pfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOblc09270R2YgCzxHlhlETixqfgTKHJT/cm7rGcYUo=;
        b=RF1ysiV28VxzaF1ysZc4wEH9jpvmcmRlh2M3QS/VhGtLEXHMz4izDOMjByfkMqCcZq
         cK919VxFqPTLk7y1j3W/Nlt32PGxgxmokZLs9CQjSyOAcLaPHd9qeHJYOcmottRzMzE+
         A4BN3maC37t6kQulCaJwH2EKWnTGljZ0O31RLeAezhRx1VicEDeYIIxBE5AkMfZA/ufP
         +chI6py9LFmfkw42ZHkvzyyEuMIE8fcS8fsax34NGhhV7tlJX9gWnahJb2rMUI/3t8NO
         IVIRs2PfUYMy+y+pLzWvirk1F2q3Zeyq3zeMz+NZNKJJVZwtv3HwCoZYKjKP9IWGiVnD
         sCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOblc09270R2YgCzxHlhlETixqfgTKHJT/cm7rGcYUo=;
        b=JpxQejzYTzPNkH0pQ2KPave859emARO3pwBQ3HB8SgMbPQjbjr2Y03FdBys6yyc/xg
         VcYAHP3oHaUQ9O8QIARq11DE/Tw+Uj5Zs5a8kQxAlDklxbX/NBrCKWselZqD2N8H3jrA
         PflLYI/nXbULb3JquvTmd1SMQLiae/bJuxvYgpeACQEnJwopS0i/N6A1CLYkmEPKwb2I
         oO+dJym+rCfN3XBb5LFHT/cJFqhExf1VnSJfiK1jI3n92SQJCfZvOUISqbbNVAjLdy8/
         u9Kkcn+8VJkGras8iTliPWgPsP53ch3ShbGYStBx2jfq2Y2etYoWL1Lau30pV6a3iTer
         dhcA==
X-Gm-Message-State: AOAM532ky1Oo3XB3umq7n6Cj80Ui3++pAblFw+T4KG2oMxiGaMPmv8dt
        oCdUzjYnRYHQFWvX3cV+P9Es1g==
X-Google-Smtp-Source: ABdhPJx7/71OWFCapSEQ0oUaHcpYmyXIj3bJgHdJlsg95On9aDQe2/EQzYcZB1U8cPGS1S5lmj8vlw==
X-Received: by 2002:a62:bd13:0:b029:25f:cd51:7bb5 with SMTP id a19-20020a62bd130000b029025fcd517bb5mr13848048pff.74.1618988539521;
        Wed, 21 Apr 2021 00:02:19 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.02.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:02:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 11/12] mm: lru: add VM_BUG_ON_PAGE to lru maintenance function
Date:   Wed, 21 Apr 2021 15:00:58 +0800
Message-Id: <20210421070059.69361-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
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
index 02d14a377b0e..924db107fad7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2062,7 +2062,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.11.0

