Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F8830F806
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbhBDQd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbhBDQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:31:49 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10190C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:31:09 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o63so2466959pgo.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ci1gXzshUKxf8ZHIFWrDVwutYRYOBcIY5pJ9Y3PAGTs=;
        b=YZLEXsBAH1Q6e3Y+HQtqMaUhliU9SQ3zmhdOHQH+2rBPWuZlC8ivhzt6Rp6OoEW/zI
         +t4hg5wwXDDgx7ZNPxXGePwQ4/FKQIYYw5+JknWED8xyAERQ6TzplGInxk5/dNmSJLKc
         1Flm0SpW/RqCoLemrCbH1+qDjpIFDsQu7DlVvxFXWkY1q7U/mJH3XJIuHHXtTtU/9sEP
         2n9WfMvAUFGCWLbLDaLrhc3U0cscXjgE4aE9lItHCXtTvFU1lvmuLzMpd5yJ75vEPyQD
         /0Z3nI5rplhLrYHOkjAz2j0jNo1PTBXBbnVVzziipPHWjAGbQijoHvNCAOyip/wI6HXi
         atwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ci1gXzshUKxf8ZHIFWrDVwutYRYOBcIY5pJ9Y3PAGTs=;
        b=l8UFJOtLldf/x6Bm7bLuCtAjGUJwGi6MscRJ+YGf9GGaosfsDGQxGjsl4ZtSnCZImV
         9MlqWJRdXB0EDcBaPPPY2p9k6t/QHgLnOuin5lw2hli3q5UQp7KMnYyT/jmMwV+tx3yu
         CrH2Pr2iyP3GoROWXpp5j3TNQni+DEgkxlm/w+SiOuicMrdAqdmZRcoBgJKLqednmpux
         /fdClvx40vWQfX/Iw5cKD63wjjiFI0OlzVt/QmHslm+2tWSeOB2pDi/T4q9lZ8cM6AaP
         NuCb0Z5IqHQDmu4P7SB4JD+fvcUG/hzLsrKZX2xnAmvpgov9A3Utzyq2IxUWO44gi96C
         Wz4Q==
X-Gm-Message-State: AOAM532vDaxS2nhfr38+hVS3Dzs4CufYtcRTsXBqtUbJh+wl4Xagn/HM
        Roive9a3Pbyk8nImuQXYW2uGgg==
X-Google-Smtp-Source: ABdhPJwYlQXBXlvG9krnqTBuDUsLn1Qrh7OgLBhLSDi/A7rfI8RShj/W7jKDY33fbqL9CVTrk5oc1A==
X-Received: by 2002:a62:6382:0:b029:1d2:46ed:d813 with SMTP id x124-20020a6263820000b02901d246edd813mr32411pfb.44.1612456268576;
        Thu, 04 Feb 2021 08:31:08 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id v23sm4728843pgo.43.2021.02.04.08.31.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 08:31:07 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: memcontrol: replace the loop with a list_for_each_entry()
Date:   Fri,  5 Feb 2021 00:30:55 +0800
Message-Id: <20210204163055.56080-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rule of list walk has gone since:

 commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")

So remove the strange comment and replace the loop with a
list_for_each_entry().

There is only one caller of the uncharge_list(). So just fold it into
mem_cgroup_uncharge_list() and remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
 - Fold uncharge_list() to mem_cgroup_uncharge_list().

 mm/memcontrol.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ed5cc78a8dbf..8c035846c7a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6862,31 +6862,6 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	css_put(&ug->memcg->css);
 }
 
-static void uncharge_list(struct list_head *page_list)
-{
-	struct uncharge_gather ug;
-	struct list_head *next;
-
-	uncharge_gather_clear(&ug);
-
-	/*
-	 * Note that the list can be a single page->lru; hence the
-	 * do-while loop instead of a simple list_for_each_entry().
-	 */
-	next = page_list->next;
-	do {
-		struct page *page;
-
-		page = list_entry(next, struct page, lru);
-		next = page->lru.next;
-
-		uncharge_page(page, &ug);
-	} while (next != page_list);
-
-	if (ug.memcg)
-		uncharge_batch(&ug);
-}
-
 /**
  * mem_cgroup_uncharge - uncharge a page
  * @page: page to uncharge
@@ -6918,11 +6893,17 @@ void mem_cgroup_uncharge(struct page *page)
  */
 void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
+	struct uncharge_gather ug;
+	struct page *page;
+
 	if (mem_cgroup_disabled())
 		return;
 
-	if (!list_empty(page_list))
-		uncharge_list(page_list);
+	uncharge_gather_clear(&ug);
+	list_for_each_entry(page, page_list, lru)
+		uncharge_page(page, &ug);
+	if (ug.memcg)
+		uncharge_batch(&ug);
 }
 
 /**
-- 
2.11.0

