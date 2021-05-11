Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AA037AA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhEKPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhEKPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:11:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE99C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:10:34 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l70so1267410pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UbtTKJ2DcWa23Eh4eF2HPJAjR+99XcZMmH1/neJWDQ8=;
        b=QTNSiMVFnSywFux8M9OXGZ5EQbqceGuac6FMw6rHlU9KjCFrPf0bHZ3Xr0Z04QlKTy
         sA3ePnvTS+Vx7qR1qZJ+iQMmxOHMiVY1GR1ZVI0GaB3Zc4qr5IXji+4iwWdg6he7JAqt
         FCa4lVCA9NPPBs5p7xl7LkW9z1TEfROS9Y/ncwasROYr1+luDNmk2XRfXCdU8tJFzPkY
         CeVS0n3O50AYYAyD9IW14nc0ZvKxpr0/GwJaat5dWo87ur9SBELo0k6Ox18m280o3Nnt
         xuZ0h9OUGtUmYOhT1Dge2BV/rSH1VdPdZIlmzvw0MikdDNsPZTqL0nGamvETt+gSXQUq
         XBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UbtTKJ2DcWa23Eh4eF2HPJAjR+99XcZMmH1/neJWDQ8=;
        b=fL13Ud17kirwabqRBJR4r6NKqxDwOwsssMP4E9VpaJWCa36W2ZP9kbpEuQ87SSA26/
         j5toPY9cxguaCikn15k3p7xfyF3FyIImKq11Mq/yz1HTYF7Cps48LsYZflyu8o6FS4hM
         wAbvhUJim0F3lwrWAjGLVb5RDEGC2kvGOjbHRSOJ7zYVAPkq7lkozDfvexgvQYXWu+Dv
         VKPZcMM/e89XGDkrcKhhPc66lT/vjcwizx9JnlPpZ0g3W97bkYZPm/G72CIrGPqN4Brp
         4lycQvrBi1L/SPVUJBjE0LANni6J88xFFrkc1jjmQFXvLn61cosHPx560wAnfW7NP2R5
         ISOQ==
X-Gm-Message-State: AOAM532EmXYMXu3FJrad6nWKNhlcvHWP5dszIxWdXKcIETSB6d2jAu60
        ++bukyy383UTOdgoYgEvZQ==
X-Google-Smtp-Source: ABdhPJyBocarp5TadCgoUJ4Mj42j/CEn57OApWlVWJIzIHWBYeuT8aU50JM0Z099WD8uJmDWdomLxQ==
X-Received: by 2002:a63:575b:: with SMTP id h27mr31948674pgm.180.1620745834264;
        Tue, 11 May 2021 08:10:34 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id a18sm14376456pgg.51.2021.05.11.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:10:34 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm,hwpoison: fix race with compound page allocation
Date:   Wed, 12 May 2021 00:10:15 +0900
Message-Id: <20210511151016.2310627-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
References: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

When hugetlb page fault (under overcommiting situation) and
memory_failure() race, VM_BUG_ON_PAGE() is triggered by the following race:

    CPU0:                           CPU1:

                                    gather_surplus_pages()
                                      page = alloc_surplus_huge_page()
    memory_failure_hugetlb()
      get_hwpoison_page(page)
        __get_hwpoison_page(page)
          get_page_unless_zero(page)
                                      zero = put_page_testzero(page)
                                      VM_BUG_ON_PAGE(!zero, page)
                                      enqueue_huge_page(h, page)
      put_page(page)

__get_hwpoison_page() only checks page refcount before taking additional
one for memory error handling, which is wrong because there's time
windows where compound pages have non-zero refcount during initialization.

So makes __get_hwpoison_page() check page status a bit more for a few
types of compound pages. PageSlab() check is added because otherwise
"non anonymous thp" path is wrongly chosen.

Fixes: ead07f6a867b ("mm/memory-failure: introduce get_hwpoison_page() for consistent refcount handling")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reported-by: Muchun Song <songmuchun@bytedance.com>
Cc: stable@vger.kernel.org # 5.12+
---
changelog v3:
- recheck PageHuge after holding hugetlb_lock,
---
 mm/memory-failure.c | 55 ++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git v5.12/mm/memory-failure.c v5.12_patched/mm/memory-failure.c
index a3659619d293..02668b24e512 100644
--- v5.12/mm/memory-failure.c
+++ v5.12_patched/mm/memory-failure.c
@@ -1095,30 +1095,43 @@ static int __get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
 
-	if (!PageHuge(head) && PageTransHuge(head)) {
-		/*
-		 * Non anonymous thp exists only in allocation/free time. We
-		 * can't handle such a case correctly, so let's give it up.
-		 * This should be better than triggering BUG_ON when kernel
-		 * tries to touch the "partially handled" page.
-		 */
-		if (!PageAnon(head)) {
-			pr_err("Memory failure: %#lx: non anonymous thp\n",
-				page_to_pfn(page));
-			return 0;
+	if (PageCompound(page)) {
+		if (PageSlab(page)) {
+			return get_page_unless_zero(page);
+		} else if (PageHuge(head)) {
+			int ret = 0;
+
+			spin_lock(&hugetlb_lock);
+			if (!PageHuge(head))
+				ret = -EBUSY;
+			else if (HPageFreed(head) || HPageMigratable(head))
+				ret = get_page_unless_zero(head);
+			spin_unlock(&hugetlb_lock);
+			return ret;
+		} else if (PageTransHuge(head)) {
+			/*
+			 * Non anonymous thp exists only in allocation/free time. We
+			 * can't handle such a case correctly, so let's give it up.
+			 * This should be better than triggering BUG_ON when kernel
+			 * tries to touch the "partially handled" page.
+			 */
+			if (!PageAnon(head)) {
+				pr_err("Memory failure: %#lx: non anonymous thp\n",
+				       page_to_pfn(page));
+				return 0;
+			}
+			if (get_page_unless_zero(head)) {
+				if (head == compound_head(page))
+					return 1;
+				pr_info("Memory failure: %#lx cannot catch tail\n",
+					page_to_pfn(page));
+				put_page(head);
+			}
 		}
+		return 0;
 	}
 
-	if (get_page_unless_zero(head)) {
-		if (head == compound_head(page))
-			return 1;
-
-		pr_info("Memory failure: %#lx cannot catch tail\n",
-			page_to_pfn(page));
-		put_page(head);
-	}
-
-	return 0;
+	return get_page_unless_zero(page);
 }
 
 /*
-- 
2.25.1

