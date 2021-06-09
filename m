Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB63A1BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 19:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhFIRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFIRXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 13:23:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 10:21:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u18so18897672pfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E11fKiyQBeEIM/g2HQ/6iNNwM0cPjI01ktT51go/AqI=;
        b=Dmi8xcS7KbFcgMmCYjw4MiwffWeXDWuN53gaauvpFgGUrJMiq+YH4q6rV7AXkVqPHs
         7rVqNhjjPvD9e/3+yQh3Pdbzoo6qtWYLeAFm3FvAoFE97HFgOQoo9hWYLG9ee9zCtykW
         VIOPZF5gMWWsd2tzpiupRX+CFWITOWzAiXyOR0a4MDCPrmx+pxydldXbCvgzLJbJOVdL
         Qe+FJ8a5JmceYnfcssdh1Rn9qqSwQD4CPFeqkRUlLp9qiRVeFLLmqb7WB/s1fHp7CzPA
         aVhHhC0Aqh6JtlmA3BxIjPpH6lqEjVdKoD6oqP2R4Ho2L/TQd3koGuRIoBTXK5IpDuZw
         /DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E11fKiyQBeEIM/g2HQ/6iNNwM0cPjI01ktT51go/AqI=;
        b=D0piNYQv7WnQXs8Wn3WMRBmbD1jy622pFtAvX/fOCq9A5uSi8HZNMscBUXBGDYFsn3
         fxmwitW3fJWcSutS5hDHzm0O/LaLof7Hix7tpQI4orE6JoSkPpeiq0fKQMwoTBXxrFEw
         Z0n0115bH3Y+pvFoLT9hwAoLq4ymdGbpZhZczAhs/Gbke5wtcJAvjwq7He3+J823yxgF
         tFB7VR3SF5lvX20i9tBLY0J27v8+YnKP7YARJDdc0CtvTLZA1Lk5tUrJjmCxdLIzwJXR
         ClEdvcVh5lKvh1BAgpFFQXG8T8Mbgf0neF4MKBxri9w4DaV2QwLomBzEYZ+QaTfZv6Zj
         0u9Q==
X-Gm-Message-State: AOAM530kNpdRbVUwwCYhDJek3/fgw1a8L6vEAUSE6X+MrOlNu8uZuGii
        V8TnRp6xT6cTNVr7cSOqvdI=
X-Google-Smtp-Source: ABdhPJx99zKnbPaq93IhCTkYzCCq70PMOIiKpaq/rgwY6suzy/OxUfxSwQIlIHtrrGkuUcxosQkfKw==
X-Received: by 2002:a63:1f1a:: with SMTP id f26mr714106pgf.432.1623259310191;
        Wed, 09 Jun 2021 10:21:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id oc10sm243756pjb.44.2021.06.09.10.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 10:21:48 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, nao.horiguchi@gmail.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] mm: mempolicy: don't have to split pmd for huge zero page
Date:   Wed,  9 Jun 2021 10:21:46 -0700
Message-Id: <20210609172146.3594-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to migrate pages to obey mempolicy, the huge zero page is
split by inserting base zero pfn to all PTEs, then the page table walk
fallback to PTE level and just skips zero page.  Skipping zero page for
mempolicy has been the behavior of kernel since v2.6.16 due to commit
f4598c8b3678 ("[PATCH] migration: make sure there is no attempt to migrate
reserved pages.").  So it seems pointless to split huge zero page, it could
be just skipped like base zero page.

Set ACTION_CONTINUE to prevent the walk_page_range() split the pmd for
this case.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v2: Rephrased the commit log per Michal Hocko.
    Collected the review and ack tags.

 mm/mempolicy.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b5f4f584009b..205c1a768775 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -436,7 +436,8 @@ static inline bool queue_pages_required(struct page *page,
 
 /*
  * queue_pages_pmd() has four possible return values:
- * 0 - pages are placed on the right node or queued successfully.
+ * 0 - pages are placed on the right node or queued successfully, or
+ *     special page is met, i.e. huge zero page.
  * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
  *     specified.
  * 2 - THP was split.
@@ -460,8 +461,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 	page = pmd_page(*pmd);
 	if (is_huge_zero_page(page)) {
 		spin_unlock(ptl);
-		__split_huge_pmd(walk->vma, pmd, addr, false, NULL);
-		ret = 2;
+		walk->action = ACTION_CONTINUE;
 		goto out;
 	}
 	if (!queue_pages_required(page, qp))
@@ -488,7 +488,8 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
  * and move them to the pagelist if they do.
  *
  * queue_pages_pte_range() has three possible return values:
- * 0 - pages are placed on the right node or queued successfully.
+ * 0 - pages are placed on the right node or queued successfully, or
+ *     special page is met, i.e. zero page.
  * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
  *     specified.
  * -EIO - only MPOL_MF_STRICT was specified and an existing page was already
-- 
2.26.2

