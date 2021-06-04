Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551A039C167
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFDUh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFDUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:37:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935BEC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 13:35:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso5712440pjx.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/LF0w3ZuuV4uKZVE77K5/SgS+KwM0fDxpNt19bsUYJM=;
        b=T58CnhvoMWwCn0bbPqNWxSRKvP434+uc9yZ6b5QXY2l5JE2w8dRFBZN33lp9oJZUKf
         yEMIYQAt+W1Kpcx8BDudGkLnVhrTMBT7Tk+KOM98HdMveCvWwpyjORZCXa/nqxrVgrR3
         lqyY8j3gctlmBuGkbb7d0iQfnqi/Kww1ZaT9H/jJH969/rdOn/CQ7wTsRAMMPPvq+z65
         XuxpBLFTGIZAx+P/ejpwjS1LhGDsGjK+RqYvDSXlRvuf3hHOwJ0ZJ+4WqhALr+4WVOsI
         FELFflq7pYpnb7M8W+hqBrWzAn0bukTY4Ht4vU2tg5JV1kH5qR4XtHRGqxItaM8ibOiv
         b+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/LF0w3ZuuV4uKZVE77K5/SgS+KwM0fDxpNt19bsUYJM=;
        b=NtbkQIdSaL1Yt7ZF8KrVIhobWZiW/FAmkPPLzhh2ITpTQkvH0B/gzKO2d66ysgQIFo
         +ttpFEIe5xwsGFXX91/Zz2iGog7uNIkXvyluwMMjp5Su01nJ1latwS0MrJNT/zXf0g2W
         PMpmWTs79cSfJ2j6pbyUvCOVHDKEPyqXTamcRy2IfVr6xNjbJYd0bEUATdQ5SlbRUE4i
         hhDsUPcjT4cLtmxjmScX6bOT0NLcV8NSmGK2v+Rz+gRgDMBfvWt7Fr/kIuOTmH8Kahno
         mn7AEPwHKu61iMOtMrl1tFydJUZsA9Q8KoyMIIHFU2R/jO21rUJZjLv308hBY15gLo13
         ZctQ==
X-Gm-Message-State: AOAM531Boaw+gt2RqO/5f5W46F25lhxcTnPvj0M5Nd7DqtikdAHHyBJI
        pOt5Hai7dPgnavNfneic7Qs=
X-Google-Smtp-Source: ABdhPJypjvGssCA5hHYSUIGwDK2ejRTX84JJX9jwU6SOoC1y+dS2NZ0w9LXvF/FTi3diMKY3kEu91A==
X-Received: by 2002:a17:902:eac1:b029:108:4a7c:ff2d with SMTP id p1-20020a170902eac1b02901084a7cff2dmr6181973pld.62.1622838916660;
        Fri, 04 Jun 2021 13:35:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id z23sm5262455pjh.44.2021.06.04.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 13:35:15 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     ziy@nvidia.com, nao.horiguchi@gmail.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
Date:   Fri,  4 Jun 2021 13:35:13 -0700
Message-Id: <20210604203513.240709-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to migrate pages to obey mempolicy, the huge zero page is
split then the page table walk at PTE level just skips zero page.  So it
seems pointless to split huge zero page, it could be just skipped like
base zero page.

Set ACTION_CONTINUE to prevent the walk_page_range() split the pmd for
this case.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
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

