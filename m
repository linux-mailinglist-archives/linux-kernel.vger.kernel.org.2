Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56A7361923
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhDPFQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbhDPFQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:16:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7482EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:16:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m11so17587146pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=quvF2EjF/xPK4PyQGSt8Z2m2h60Cl4Xz0YmhFi/qiI8=;
        b=wT8QOhtF0Xk3DzJURDe0I2FPnhhBjN6WF3ukTAggd/ZvLUS8hIyGkQMjuXxsfhlJNK
         MA7nkojnWv4ZUHPHV0/jKpXU9mf79GZsZcfx5Qgo+YDZiNXpmMp80mPzbja4fl+Z0nkr
         7ny44DwYeAIT8iTY+qHqEulVRhBNOdmT7Z2pM82H9op1rRDKA5x8zQeQY+WP0mjjZYj4
         xBDpQc4C7hAbt7Q3AtV6SlDYT2kaS6AK+XuBEeVzg48e+Wk+cyxRS95bJvwJZLx9T2bx
         PfzfJkPH/kiRnFiQqdhVAZYclcXAQl8mz/mlu8d45AoSRk+Z6AE2rKpAPNBNGgtk8lor
         Wtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quvF2EjF/xPK4PyQGSt8Z2m2h60Cl4Xz0YmhFi/qiI8=;
        b=oDWj3LVwjsRZIVRMfXfdDtu+apAtY/CaSk/BISPZYWOhE0c+i+HgCBIwCaKCNnue/f
         YInDRcpbvgK90ptoDtEl2FuMVigmQOBs+OIGBL3UxuHNnRnzmOFUjH8sdEVKAXn5V8lt
         kb2F1N6qqvNdH2mJ4kHh/frdhexSNmTQQY9rjNWEs55LPMuzEeap2f6a8wlbsZp61pDy
         etBSkpFMFQjGz6O0VNzQeOQ0t4GUmyR0y9hpXLCwurb/FbNoCUFR43/BY90Qwzt791Rs
         Vq4hsMB8zMV8Qm/AxsfLhcoeiM3RJaYGyNe1M1xVbxUqvOmJ2JN0QoyLKWV9nREGN2+f
         5/JA==
X-Gm-Message-State: AOAM5306ZfPu/hvIjTC5chEUKz+7wzdv+CxNCXVo2CgDz35pZ2h9WU1S
        9z4056eXG+BXh4c2mZGFPwVMroxi1eBtI+zZ
X-Google-Smtp-Source: ABdhPJwLW+IwtkWVKRKXZQMrb5e0hyLANL5+//jsyPZ/VYECJqDhd2JzUG8ROI5TDfmpH9bmgwID1A==
X-Received: by 2002:a62:1ec1:0:b029:24d:b3de:25be with SMTP id e184-20020a621ec10000b029024db3de25bemr6421893pfe.17.1618550163986;
        Thu, 15 Apr 2021 22:16:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id j7sm3518540pfd.129.2021.04.15.22.15.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 22:16:03 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 5/8] mm: memcontrol: rename lruvec_holds_page_lru_lock to page_matches_lruvec
Date:   Fri, 16 Apr 2021 13:14:04 +0800
Message-Id: <20210416051407.54878-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210416051407.54878-1-songmuchun@bytedance.com>
References: <20210416051407.54878-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lruvec_holds_page_lru_lock() doesn't check anything about locking and is
used to check whether the page belongs to the lruvec. So rename it to
page_matches_lruvec().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 7 +++----
 mm/vmscan.c                | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2fc728492c9b..40b0c31ea4ba 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1492,8 +1492,7 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 }
 
-static inline bool lruvec_holds_page_lru_lock(struct page *page,
-					      struct lruvec *lruvec)
+static inline bool page_matches_lruvec(struct page *page, struct lruvec *lruvec)
 {
 	return lruvec_pgdat(lruvec) == page_pgdat(page) &&
 	       lruvec_memcg(lruvec) == page_memcg(page);
@@ -1504,7 +1503,7 @@ static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
 		struct lruvec *locked_lruvec)
 {
 	if (locked_lruvec) {
-		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
+		if (page_matches_lruvec(page, locked_lruvec))
 			return locked_lruvec;
 
 		unlock_page_lruvec_irq(locked_lruvec);
@@ -1518,7 +1517,7 @@ static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
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

