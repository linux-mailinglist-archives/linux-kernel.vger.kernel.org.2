Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9842DDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhJNPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhJNPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:18:19 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD225C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:16:14 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w4-20020a1709029a8400b00138e222b06aso2573117plp.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8lwRp3uP8+IKYysxWAf8gbvxjj8gBa/nFz3RxTvcuPo=;
        b=oJGw/QMmi9y17ZRzapZ6AW2NqjA67q2aRYewaRrOpIgd5leninbEz/X70fFAv2Tkyr
         tK4schSZy5xEATUYHCSx4ertgr+8G6lysBxuYmHYCKm01igmwtPNBZL10n9vtUHVoceC
         O7oUkdYT3NMshazQZbMIaGQsREoQuo5eao+1Z3zZ0z6M7E7FFD2JSQobCOQqG6y+Un5y
         XTzKDHVN9DkIcxjf9l3ztuNBu5zq+mMErnq7BEW+9GDjPOdw2fBMz1p4RTBFrTeVi6u8
         Q0sR/ABZD6FSDzNrx4/Hw2+/7E/qpUZ+2z90EwCVBL3U9JP9G7tL22uJ7LCj3EiyYaFS
         VNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8lwRp3uP8+IKYysxWAf8gbvxjj8gBa/nFz3RxTvcuPo=;
        b=rzXucl1h/l9ZJgOGgb7VGjiP9il1trpThqsO1Zvs5igoNx65LK/HvIAgmA6wZ07Lm/
         Mww4HLM2i2TBhkrKqyU6UcYpkcssMf4kOcl074NLjKAw5++QvqtD0SI0v5BokwdN+FD1
         xCDqz3rfGVW+D2SWtWyqa2JNeYYm/lCbZHjNqkHranXbxV32QEm4LkzZnE/KB+5cm673
         fO5nBWKiT6afc01qjIo44pZ39PHgu4zbgmTPbwG0HulTYKXZ2sv9gSOE2uRZwOTLSHnh
         qHkYeZidVvaNhBeYM6/jTuhOMHRhybAfqT7tcHhmfRQve6yTMSzAZN6D+EDJYm4KfjvL
         KhDQ==
X-Gm-Message-State: AOAM532SDZ/2JrJEVWejJXqB+87kvAXGxboujIZnTeoMJX8orsMDkdgq
        qYDAp51YsJ6ooLIkDmxi71q6+4OzN42Xjw==
X-Google-Smtp-Source: ABdhPJw+Wctx4vD1oG672/mLpw+81PzUDFwQ6/X9iV9MtZR4g0zPLuHZt2SN2+IVZ+mEQ6AmxssCTwZmjPSGYg==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:1581:9ea1:b658:109a])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:1d0d:: with SMTP id
 on13mr6901295pjb.118.1634224574128; Thu, 14 Oct 2021 08:16:14 -0700 (PDT)
Date:   Thu, 14 Oct 2021 08:16:07 -0700
Message-Id: <20211014151607.2171970-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in
__vmalloc_area_node()") switched to bulk page allocator for order 0
allocation backing vmalloc. However bulk page allocator does not support
__GFP_ACCOUNT allocations and there are several users of
kvmalloc(__GFP_ACCOUNT).

For now make __GFP_ACCOUNT allocations bypass bulk page allocator. In
future if there is workload that can be significantly improved with the
bulk page allocator with __GFP_ACCCOUNT support, we can revisit the
decision.

Fixes: 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- do fallback allocation instead of failure, suggested by Michal Hocko.
- Added memcg_kmem_enabled() check, corrected by Vasily Averin

 mm/page_alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 668edb16446a..9ca871dc8602 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5230,6 +5230,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(page_array && nr_pages - nr_populated == 0))
 		goto out;
 
+	/* Bulk allocator does not support memcg accounting. */
+	if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT))
+		goto failed;
+
 	/* Use the single page allocator for one page. */
 	if (nr_pages - nr_populated == 1)
 		goto failed;
-- 
2.33.0.882.g93a45727a2-goog

