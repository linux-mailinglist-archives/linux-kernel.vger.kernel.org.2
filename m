Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E48362DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbhDQEiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbhDQEiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:38:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C67DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nk8so1906603pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzztEYThC68iA+/H3mXFzISa6K0UiM/T7EUy8N400kM=;
        b=ZwQpZdb4P0z3JJJBaiDRn34BsDhgV7N2sSEU+RfSVAHDy77bCYUa42yOlGOKs0A7TU
         Kj/xw6XNgYv+qS/dwBKrd0p60qYp8yqtTQL3ftFDEKcKFFzEeWz0rK/vStgWPGu4vVXi
         Ekr8fx3oRHT4pJI4I3clORCRCha9uLyLk1MfV1EJQuayfM3Yzqo3rDKwziEv+xt7lfBX
         8/9AC9jvuQdU5UU3o0mHBbePSwRw8Gw3WvWgATwgkfdqt5vxl4KGi2Va3k23f+nUNrt3
         7wbApWm3nKoM1btFRS9BmewuR1HjYvLBDNKauYYE1i9M8bWV4DB+JqUdbbxCFb6xTO0n
         OCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzztEYThC68iA+/H3mXFzISa6K0UiM/T7EUy8N400kM=;
        b=ZpHtJ4s6hhks0bjbvyVC68aTmhjiqZNXnch7eJC+R5auQz/AkEt9UHyl9Ku0uILDbU
         76TSj5+Lu3SxYjPNw7AIAauDxde/BptSczdANBHFJLwqav+Fu2XQbOETYJMFkj4X2jh5
         psFv33m0UlKZrJc3gCUE45b2meVsIbcLbzWWThrjBxLDr3+pRmssMlLyNLrUdq27qilV
         B2VwH0oGzIQ22R69vLVA9o/1HcWLxTGl4IekiQsDjqSL+HlX6aZRqFmS/IpDN/6VNmIO
         SY/Ii8JR+et8xSuejnB7/ysCLArdTkjewHsUhDHLw3vokwNEeXG0FObp81mj/+wpRxpM
         7n1A==
X-Gm-Message-State: AOAM531OCxK/1gK3WlUAoe7oP8Q4l9iayvZAdjQAVY3l1ZemKa2gRQMG
        5rTwWed5nge9jvcycaepDzeZZ08Qhsjt1A==
X-Google-Smtp-Source: ABdhPJwHJOXNxCRxaiJNn5wSMEycirv4bY2+aWCTu05ryyJoj5mcg7Rh8aN85bWBwHXTFU/RExwEkQ==
X-Received: by 2002:a17:90a:9312:: with SMTP id p18mr12986286pjo.171.1618634305772;
        Fri, 16 Apr 2021 21:38:25 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id w21sm7064775pjy.21.2021.04.16.21.38.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 21:38:25 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 5/8] mm: memcontrol: rename lruvec_holds_page_lru_lock to page_matches_lruvec
Date:   Sat, 17 Apr 2021 12:35:35 +0800
Message-Id: <20210417043538.9793-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210417043538.9793-1-songmuchun@bytedance.com>
References: <20210417043538.9793-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lruvec_holds_page_lru_lock() doesn't check anything about locking and is
used to check whether the page belongs to the lruvec. So rename it to
page_matches_lruvec().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 8 ++++----
 mm/vmscan.c                | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2fc728492c9b..0ce97eff79e2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1492,8 +1492,8 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 }
 
-static inline bool lruvec_holds_page_lru_lock(struct page *page,
-					      struct lruvec *lruvec)
+/* Test requires a stable page->memcg binding, see page_memcg() */
+static inline bool page_matches_lruvec(struct page *page, struct lruvec *lruvec)
 {
 	return lruvec_pgdat(lruvec) == page_pgdat(page) &&
 	       lruvec_memcg(lruvec) == page_memcg(page);
@@ -1504,7 +1504,7 @@ static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
 		struct lruvec *locked_lruvec)
 {
 	if (locked_lruvec) {
-		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
+		if (page_matches_lruvec(page, locked_lruvec))
 			return locked_lruvec;
 
 		unlock_page_lruvec_irq(locked_lruvec);
@@ -1518,7 +1518,7 @@ static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
 		struct lruvec *locked_lruvec, unsigned long *flags)
 {
 	if (locked_lruvec) {
-		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
+		if (page_matches_lruvec(page, locked_lruvec))
 			return locked_lruvec;
 
 		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bb8321026c0c..2bc5cf409958 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2062,7 +2062,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		 * All pages were isolated from the same lruvec (and isolation
 		 * inhibits memcg migration).
 		 */
-		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
+		VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.11.0

