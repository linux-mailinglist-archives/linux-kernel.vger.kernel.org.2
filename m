Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85D9359EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhDIMdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhDIMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:32:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EF4C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:32:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bg21so2847018pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGnIcRUphb33Z52wrBzQRy2lP1/tCopQL4vrXFnFrmI=;
        b=S0AxdzbO4aXq30Vi35yMmb1Li/r3E9lW60nwWLlDMZRGKCvNrSuk9f6rMufTdhOyqF
         uGM5dcZ1TcR1fLjFFyIpJRKkjjDhlTNaqc5Ies/YjdlKakn02dWQ1V9zj1k2tXWloykp
         KcViVWqi0wDeQZoFgkHypenGAb2l/C8qnB/RTFfInSkCaTPj860ShomNWih9FAhRvtwR
         dUQj3pch7N74sEvRDw5muZ+tU8TCL9Ks18Tp/EOpqWvNbEPBoKAHXwT5/HHUz3MIeEvg
         UKnRw93yBCLGcNZUgOQr80Hfj3NdocAyk/VRGGBHm0O+YugvFmpwgS/3TWpCtBReAJON
         gv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGnIcRUphb33Z52wrBzQRy2lP1/tCopQL4vrXFnFrmI=;
        b=GLZ6qXvwePUiWP1/7sLh7X8IUmCGp7smCVg78oH5ipe6m6iGXuGLchh59Nzce1NN9o
         AnObDhs7TqPj/Fd6UMl0oOjP3VsZ6fNhcULpwckUPYTIRZ8WmGrGwL4QQJpw20oRoOPH
         MdZK4Z3MfKXyiemgtP3JJUGElP2Vc4byTbr1e787XK9eK0k04Xav9w/4VarHd9tcZY3a
         3NIAYxG5rC7snDSm3k2bpdqI47WNYGBh8WLBS61NkFv7le7SwVkKIsMsMLykJiibcsks
         LGaT3yFEKOyY6I+pvVFhwiNgzUstklsy1WHJBKTbzjCWcnHyxcbwlL/5KSJheEJx5pRv
         fEoQ==
X-Gm-Message-State: AOAM531IUdJXoAJwzr3Ur/ffx02IFltJQAtGa/wH2mcvAitsfOddgtoa
        NvJcjRBFS6MKd9LmW6sWfN6YJA==
X-Google-Smtp-Source: ABdhPJwn8UgcJ7e8pfW/StQ/oe2JyK5NB/2gozqFYTM0tv5Cti79xM30O0H5IkxlZ8bpV8sY/ILxdQ==
X-Received: by 2002:a17:90a:de89:: with SMTP id n9mr13461586pjv.180.1617971564855;
        Fri, 09 Apr 2021 05:32:44 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.32.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:32:44 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 09/18] mm: vmscan: remove noinline_for_stack
Date:   Fri,  9 Apr 2021 20:29:50 +0800
Message-Id: <20210409122959.82264-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
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

