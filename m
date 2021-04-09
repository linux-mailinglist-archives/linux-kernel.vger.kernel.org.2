Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E40F359EB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhDIMcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDIMcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:32:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C98C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:31:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ep1-20020a17090ae641b029014d48811e37so3109718pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58kw73zULk1M3QRMYpGesyQhzu0BFPE8Fnems3AjAyI=;
        b=jSUh5hJWnp8EpV/wkefSJdZoi2UIab+EAWPvsDiKxRQZFhbegQ6L+Dl6eawxYH4xVP
         Z5VSbvD4uyhDlqJvsvJE7nm/k4W55DfqLKoNSuW9g0pMbgvsj6VyLm54oHXzQYVgaYOE
         1eLC/i/3dlP0Ne5mvo6Zr5HbA191dng758K50uL4U8eC04wsiOi6hu06CioZQfggRe1l
         cTX182sfC625GWoWUSxyVFANLDFjhgIeRuJ8PabTFygDuLtG7KPWnb+YCntxJixUVreS
         fnBFBvxfh8qKkvW8XSdGg6kg0d4QTUqphO4HAAsi7LIkqyhWlhrUvL9nB9J62VMFJRCT
         AIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58kw73zULk1M3QRMYpGesyQhzu0BFPE8Fnems3AjAyI=;
        b=MhLrPTpnvWdfLFfqzRvwEoDLIG00KhwBhRYcLfGFBsYmrZsPDOA/s45WRhFP9Ba3QO
         rE3GRuwfJZ5AWkehK//hFKcxP754YlMFmNk0gtQpe7YTXVa5E8syxnlWNcXZ711EUrHS
         WBkAGGNfs9cOYKu+D/0lwhQA4ipuW5Ub9JMxEhYX7RI2Me+zNThVU1kFfb+MQ4Fkb6WU
         XCAx7iATPECEnGR6NsYeJbMV2OCLAYAhvvhKcCWMgavAIoHRAVD5h/88L5bj71hDkugD
         YNM1Czj+x7U4IJcLteqgjaBe3FzADQLJNaes5znzgtM014dmFjcFAtZYuJR5QQusBDUk
         dX5Q==
X-Gm-Message-State: AOAM531v6KG+PMRXQXVTWyx0qxCh7OtNDsDX5jSxZWtSEXghA8ICvOEj
        xDQW3W4e8Xbm46J9qeBylqgyFA==
X-Google-Smtp-Source: ABdhPJxT5HnFu/JWiq7mOhBolL3h47S0OslJDo9Gs2/ZnJOGN15SbV0U6S25bb3U+N8skATR+PwuPQ==
X-Received: by 2002:a17:90a:e016:: with SMTP id u22mr13094679pjy.134.1617971518281;
        Fri, 09 Apr 2021 05:31:58 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:31:57 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 01/18] mm: memcontrol: fix page charging in page replacement
Date:   Fri,  9 Apr 2021 20:29:42 +0800
Message-Id: <20210409122959.82264-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pages aren't accounted at the root level, so do not charge the page
to the root memcg in page replacement. Although we do not display the
value (mem_cgroup_usage) so there shouldn't be any actual problem, but
there is a WARN_ON_ONCE in the page_counter_cancel(). Who knows if it
will trigger? So it is better to fix it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e650a5..f229de925aa5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6806,9 +6806,11 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	/* Force-charge the new page. The old one will be freed soon */
 	nr_pages = thp_nr_pages(newpage);
 
-	page_counter_charge(&memcg->memory, nr_pages);
-	if (do_memsw_account())
-		page_counter_charge(&memcg->memsw, nr_pages);
+	if (!mem_cgroup_is_root(memcg)) {
+		page_counter_charge(&memcg->memory, nr_pages);
+		if (do_memsw_account())
+			page_counter_charge(&memcg->memsw, nr_pages);
+	}
 
 	css_get(&memcg->css);
 	commit_charge(newpage, memcg);
-- 
2.11.0

