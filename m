Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A7B34E565
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhC3KX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhC3KXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:23:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D072C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:23:48 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h3so11820442pfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zl+lZA6IhpCUdnBZY8wrlIzpChNsz+rycB3YEkTf9d8=;
        b=jFmF1YweAfzCVW5eqeWZ6Wo5H2khjQVMjiHyanNyg6cfLPNR69RzaFvzTv5BCuFeeY
         kn4hrQEOWLZyoALmJ/9YjSod4oMunh8bu9E1BHxTdkklBsUMbCUHK3qmC0FpAmeYKmXW
         3QUJOTX1TY2viaAiH6YZ35hoI3TzS5dTvChl4oM0uHXFybdk0T+8Z1ezdg9HRstUInBF
         G+V6B9oQ86nel9+i/N94+u4H27ha13gSyfVSElV4s1a9UjwxrM7I3ckM+Px2Tq30y79e
         QBRt4L0utaWecE4FCLY1xbwc1c+eiKB2kzTEQx6uc8BikMu809d+RPCs9fnGrS8ms/t6
         usGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zl+lZA6IhpCUdnBZY8wrlIzpChNsz+rycB3YEkTf9d8=;
        b=SJ2LqY6C7npweDiL90RWIBTrVFYAWNvq8qj28jPlfT+FOCMcbJ1aNwGOMqe7f2WHIQ
         g8/Of3Z3+Qm/HBwz2X9DWJXU6XDqZnj3IX/fEoTt4lZAiKz57EnDl8vVs0Fchv1CW9Ph
         BpDX9yJwjGhaRYi0+qowmjAU0n/mqRZzUyV1BWqKutiz+gCDzgCVlSJL3I+B3j1G8P8X
         fjyTkDOfcA9/xz2YpV3YdNnt8ooksxlNS2OEZDuOnj0k5lYAOgQaj0fcO1CdzKLTdZib
         4EdxyrE9LByoVQsHiP6bN1eQtfFW52NncEiYUlfK9BJM0jmGfsk7fx/nBe+W+F2Vo6te
         E/+g==
X-Gm-Message-State: AOAM530YXOtObu9j1U/QZkw5KcGVk+ZdftlO6LcwNBMKzQVeZV/yIRTi
        OZMRc1UQJGqGNXQmtEUYcwt+Yg==
X-Google-Smtp-Source: ABdhPJzQlV5q8vaRIDxPUz0GLjpfRCT4vVajWn0k9HKajxPtZV/x9+IEGJqZR3HRCpycu/Y5CXYmNQ==
X-Received: by 2002:aa7:93af:0:b029:1ef:1bb9:b1a1 with SMTP id x15-20020aa793af0000b02901ef1bb9b1a1mr29893022pff.49.1617099827671;
        Tue, 30 Mar 2021 03:23:47 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.23.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:23:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 15/15] mm: lru: add VM_BUG_ON_PAGE to lru maintenance function
Date:   Tue, 30 Mar 2021 18:15:31 +0800
Message-Id: <20210330101531.82752-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
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
 mm/vmscan.c               | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..d19870448287 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -84,6 +84,8 @@ static __always_inline void add_page_to_lru_list(struct page *page,
 {
 	enum lru_list lru = page_lru(page);
 
+	VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
+
 	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add(&page->lru, &lruvec->lists[lru]);
 }
@@ -93,6 +95,8 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
 {
 	enum lru_list lru = page_lru(page);
 
+	VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
+
 	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add_tail(&page->lru, &lruvec->lists[lru]);
 }
@@ -100,6 +104,8 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
 static __always_inline void del_page_from_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
+	VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
+
 	list_del(&page->lru);
 	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
 			-thp_nr_pages(page));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fea6b43bc1f9..0a4a3072d092 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1656,6 +1656,8 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
+		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
+
 		nr_pages = compound_nr(page);
 		total_scan += nr_pages;
 
@@ -1866,7 +1868,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		 * All pages were isolated from the same lruvec (and isolation
 		 * inhibits memcg migration).
 		 */
-		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.11.0

