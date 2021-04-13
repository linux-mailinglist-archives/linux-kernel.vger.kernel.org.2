Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B29735D86B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345288AbhDMG7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245259AbhDMG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:58:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90108C06138C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:58:06 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id p12so11253536pgj.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdhaQ5mP8Ps2L1OS7f25L6onCgsPCveY4DfI6OcUTcA=;
        b=zGHAEn5+HYX5vVZwfFXCcJNdGf6EJdpTl1UmeK5gSzvLt16cZ4/g1Qs53J0H0mtrdt
         HumqY6jWtfForTqeYwAAPCzyywtO+c+A0kEohE6BZCcpzejZt36TkbLlfj4xitbnfGRR
         zv7DhDVV53ex62qdLzmAjz7sb41qMJ+awZfmCAK636xBgZYJF3Hr7ykdOMkgmyGJRKiu
         3Uj7ti3Sc9tyU5RYMveeV0ABz+EJwCc73UZZdLVXdjAUiLI70A37vdWl7UIY5HITqh+7
         4cpZ1lJmVsms91ZQAn0kiELwhnBQuSH3ZEl2c3RibhgZsjAsWIAk2ObGXXCT2x19KRZU
         MOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdhaQ5mP8Ps2L1OS7f25L6onCgsPCveY4DfI6OcUTcA=;
        b=JhCcAMd3EWJnK205iBO/vY17RtXlfTePv+5TIvBLzjGcBe5TCYJFf78iI8Ax1OS6Fx
         kPmDXhYaWE6Cn7obKCq0W9Vn/jwpjw++Xut7IRBQGX4//JWEuMrQKY6xx16jbScyLJ4U
         JXXdemNQ73yycCMVzdeXot4nca14hcozDTqimtcnt4bVXMuhKKOBIGfKjCoJOZQ1ymPd
         tqEzg2WcfakEnNL5L2MtveZWkYjWJoRVRX9HJKufT2OkCu5JjYRtDgdhMchm8Ja5dH+c
         wfFKJn/RlMsh7uC/zLrhUaM+KkCmSEAspM1Ocbgw4J5J6idU8QvZY8LKhH22Mc61lmyH
         N/Bg==
X-Gm-Message-State: AOAM530tP4D1wcYg56mqxfyIitrBDRJ3sqKHZAZZgH8+fHaWEim3GyLf
        smBwLlxjcLvYw6Pq3O9v4cgO7w==
X-Google-Smtp-Source: ABdhPJxkqc0xpu3YaF1nM5me0VVuSkfci2Ug8vJGDZJJiMNgpqzmmeNsvLCbaDDCl7NfZxWPPWIj8w==
X-Received: by 2002:a63:e707:: with SMTP id b7mr30425925pgi.389.1618297086205;
        Mon, 12 Apr 2021 23:58:06 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 78sm11508562pfu.40.2021.04.12.23.58.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 23:58:05 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 7/7] mm: vmscan: remove noinline_for_stack
Date:   Tue, 13 Apr 2021 14:51:53 +0800
Message-Id: <20210413065153.63431-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210413065153.63431-1-songmuchun@bytedance.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The noinline_for_stack is introduced by commit 666356297ec4 ("vmscan:
set up pagevec as late as possible in shrink_inactive_list()"), its
purpose is to delay the allocation of pagevec as late as possible to
save stack memory. But the commit 2bcf88796381 ("mm: take pagevecs off
reclaim stack") replace pagevecs by lists of pages_to_free. So we do
not need noinline_for_stack, just remove it (let the compiler decide
whether to inline).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 64bf07cc20f2..e40b21298d77 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2015,8 +2015,8 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
  *
  * Returns the number of pages moved to the given lruvec.
  */
-static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
-						     struct list_head *list)
+static unsigned int move_pages_to_lru(struct lruvec *lruvec,
+				      struct list_head *list)
 {
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
@@ -2096,7 +2096,7 @@ static int current_may_throttle(void)
  * shrink_inactive_list() is a helper for shrink_node().  It returns the number
  * of reclaimed pages
  */
-static noinline_for_stack unsigned long
+static unsigned long
 shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 		     struct scan_control *sc, enum lru_list lru)
 {
-- 
2.11.0

