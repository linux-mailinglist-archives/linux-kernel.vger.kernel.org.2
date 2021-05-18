Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C923882FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhERXOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhERXOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:14:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD693C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:13:12 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q15so8077776pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=huCBrE9a/oWNLiRVwLfWwsvpIpFCkRlFZQ5wu5G4KFk=;
        b=ZwuG7+88G0fq+W7g33WE2tS7NoGQ2tAENO0XHJWiui/ToYyj/fKlIdX5YNqk7ykWXz
         Ukc8MQZY5PjLBOlCL/U7e0+PumD3Gf18+6SNQ33ZZ3BqEmc/GQz95i5A3ekO3uKoQFGt
         iMdyr+/4gz282q0MqYnBjBB8cKpLwMK7R5Cs3mz3Z2jCQbKXqgpyf9RFBK83luHyVnwL
         3QL5lFKe1do4YvbilBeA/J7aOp/nSTAI73xj1icWlLTJXdt5KqWSwbykE/UkPEHh+e5P
         1ZzKdV0OMPG4LQGHDRiwLnHDMTV3T/JMOclsYkHmzzIYaOMM7geeH0jDQR16MBD2UV/W
         B04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=huCBrE9a/oWNLiRVwLfWwsvpIpFCkRlFZQ5wu5G4KFk=;
        b=gJzAln7D2UoeMtA6mzA/4IPmvydG9Wz9ZTV+9o7gqVVDIbtjSHxVQMVMKs+4w1h2CR
         xuippz4UDcVJ7/f0UI1sS5TzsUBEZP1HDjkp3nyaco2IyBFT7pgKeP2axOddN+U8MUv2
         chxFIiPX2Mvn2OSabfXh+fMOxZvERXe3Cw7wMaFPqrkkdDvzI2BsLg+HaWgDMBRi8AgU
         ahVIJcoZ1Bs5fWPETBBlXGdhQOGA946LzB9/naBuo2UWuo2cVQjzp5w8snxarF6MYGiX
         FMC6VAj4Hb6BsgzySnNBXu//hA/I5djUpeiUwmN6metwCMplseMiXL8jECnnAMrk5dqc
         xqYQ==
X-Gm-Message-State: AOAM530yBnEoAKvqFkqBv859WLO0RW0Pe0yYYf5Vb3EAcC32ZqdxA8Q3
        iskz42ENa855+djkFTL19w==
X-Google-Smtp-Source: ABdhPJxMenOrrbrJAPDR1sdVGWDgPgURf6Eg/1zu39tJ0kgEUHLXl3RjlKbYCl5SE6zSDU7DcEsYhQ==
X-Received: by 2002:a63:5d19:: with SMTP id r25mr7395719pgb.317.1621379592309;
        Tue, 18 May 2021 16:13:12 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id f14sm14437473pjq.50.2021.05.18.16.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:13:12 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] mm,hwpoison: fix race with hugetlb page allocation
Date:   Wed, 19 May 2021 08:12:58 +0900
Message-Id: <20210518231259.2553203-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518231259.2553203-1-nao.horiguchi@gmail.com>
References: <20210518231259.2553203-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

When hugetlb page fault (under overcommitting situation) and
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

__get_hwpoison_page() only checks the page refcount before taking an
additional one for memory error handling, which is wrong because there's
a time window where compound pages have non-zero refcount during
initialization.  So make __get_hwpoison_page() check page status a bit
more for hugetlb pages.

Fixes: ead07f6a867b ("mm/memory-failure: introduce get_hwpoison_page() for consistent refcount handling")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reported-by: Muchun Song <songmuchun@bytedance.com>
Cc: stable@vger.kernel.org # 5.12+
---
 include/linux/hugetlb.h |  6 ++++++
 mm/hugetlb.c            | 15 +++++++++++++++
 mm/memory-failure.c     |  8 +++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git v5.13-rc2/include/linux/hugetlb.h v5.13-rc2_patched/include/linux/hugetlb.h
index b92f25ccef58..790ae618548d 100644
--- v5.13-rc2/include/linux/hugetlb.h
+++ v5.13-rc2_patched/include/linux/hugetlb.h
@@ -149,6 +149,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool isolate_huge_page(struct page *page, struct list_head *list);
+int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
 void putback_active_hugepage(struct page *page);
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
 void free_huge_page(struct page *page);
@@ -339,6 +340,11 @@ static inline bool isolate_huge_page(struct page *page, struct list_head *list)
 	return false;
 }
 
+static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
+{
+	return 0;
+}
+
 static inline void putback_active_hugepage(struct page *page)
 {
 }
diff --git v5.13-rc2/mm/hugetlb.c v5.13-rc2_patched/mm/hugetlb.c
index 95918f410c0f..f138bae3e302 100644
--- v5.13-rc2/mm/hugetlb.c
+++ v5.13-rc2_patched/mm/hugetlb.c
@@ -5847,6 +5847,21 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 	return ret;
 }
 
+int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
+{
+	int ret = 0;
+
+	*hugetlb = false;
+	spin_lock_irq(&hugetlb_lock);
+	if (PageHeadHuge(page)) {
+		*hugetlb = true;
+		if (HPageFreed(page) || HPageMigratable(page))
+			ret = get_page_unless_zero(page);
+	}
+	spin_unlock_irq(&hugetlb_lock);
+	return ret;
+}
+
 void putback_active_hugepage(struct page *page)
 {
 	spin_lock_irq(&hugetlb_lock);
diff --git v5.13-rc2/mm/memory-failure.c v5.13-rc2_patched/mm/memory-failure.c
index 85ad98c00fd9..353c6177e489 100644
--- v5.13-rc2/mm/memory-failure.c
+++ v5.13-rc2_patched/mm/memory-failure.c
@@ -959,8 +959,14 @@ static int page_action(struct page_state *ps, struct page *p,
 static int __get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
+	int ret = 0;
+	bool hugetlb = false;
+
+	ret = get_hwpoison_huge_page(head, &hugetlb);
+	if (hugetlb)
+		return ret;
 
-	if (!PageHuge(head) && PageTransHuge(head)) {
+	if (PageTransHuge(head)) {
 		/*
 		 * Non anonymous thp exists only in allocation/free time. We
 		 * can't handle such a case correctly, so let's give it up.
-- 
2.25.1

