Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA94362DBC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhDQEjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhDQEjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:39:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so11466416pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQtbD7P4vc1vn6sj+rqk5iopinYS+ejCLWKURjwvog0=;
        b=b5xz3eTkB17OddKFPj9hsXB5jtbQcup9TatoeWEFMiLXgVOzdU/wufc+cbr67DMZbj
         pcL65OQ+PfpKe9nyEAdQ7pJwBauH6prg0T52NdN7LIVPLXlgnhRwD9J7C64wFliCY02C
         vOpWyJq/xqMrXg+v7VrKmwAysRwv1yXube8PuOhJKdy3v6ZRt1VK9Q6oNo5WjwGkznCw
         1MCvHnf18yaeW9ZHhowTtnu/aT0mYYIWc1UpD54stMe+sYVN+mkwS+Zb81hLvNz+cXD9
         6iImyuGI6UO+plKqcv/GGIed7d4nrLA/Z5ytpzOJZPncUXhLFopRtKdXO15m6t28SelW
         u3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQtbD7P4vc1vn6sj+rqk5iopinYS+ejCLWKURjwvog0=;
        b=msLOaptZ7o6nb4S1tL1wKe9UHCl8EHVGBGOLg4tcc0BHO5yOohusd8MoqqODQ77NPs
         Gng/uvERKSxNKwbeqC1c9/tCV8HPgKVmZ1pUcvWkVFygmDyfFcVGtHlfafw+N+fRSjRU
         mpxZhhafdzHU9qR9Tv+9+zGckbFvwRLy/XBTX1iJ2+p7huH+zR6eC38PVjM3uRQp6vlK
         ckNEEy9XASsHpFlhISR8BSymKaq19H4oABFp46H9vGh4vnt43+z4nGCJ7//gfaHySCWD
         2v6DiCNrzw+thVulXLhVXL2OJ6cXR6fWDpUjJJv+6NHXapoHq9xUtzKlqSNYAjqM7DMq
         1iGg==
X-Gm-Message-State: AOAM531xAq9AmblFyZtVWnNmPWNeJjG8mq009mZt2htIRaExYjbx+hdE
        22KtUmzIhZyT0jDMo04JDBMyOw==
X-Google-Smtp-Source: ABdhPJy8VZmbHWqkDJIrzx05dg1KyMDeoaA6atPoRgpSAyr6k02STX0M9UPOZ/Gg1bLONaZEENhGhg==
X-Received: by 2002:a17:90a:c81:: with SMTP id v1mr12749439pja.23.1618634322480;
        Fri, 16 Apr 2021 21:38:42 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id w21sm7064775pjy.21.2021.04.16.21.38.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 21:38:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 8/8] mm: vmscan: remove noinline_for_stack
Date:   Sat, 17 Apr 2021 12:35:38 +0800
Message-Id: <20210417043538.9793-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210417043538.9793-1-songmuchun@bytedance.com>
References: <20210417043538.9793-1-songmuchun@bytedance.com>
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
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2bc5cf409958..2d2727b78df9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2014,8 +2014,8 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
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
@@ -2095,7 +2095,7 @@ static int current_may_throttle(void)
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

