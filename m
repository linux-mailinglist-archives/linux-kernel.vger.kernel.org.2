Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EF739AEC0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFCXin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFCXim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:38:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647FDC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 16:36:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c13so3739879plz.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjnQVlfhhnPtvKZ7HMAj13JlaIK7MEFp7/1Fbt+A8DM=;
        b=ukmRhG8sN49CIpk7u1KCSmIRloFmkc4imCu5PEIQg7yVTueBXtEfbOrrnVs0WzGT4b
         8P993IYlwkjlE4+5bHbZC2SUUSEjjjuwldK8+p3D6m0Ne1GukFKwCRkGSHj6l8wbkFI0
         X+eqXQZCjZAv53i4Vv4mQcdSGjDXn4qPoYOZfgyAriJke++qIm3kt2O5ocWBejpOtZtr
         P4nkDXzZSn+KIINxJLhzLUgeCBqKBo+998zsDOokPWxBgAkJSC48Gy6gM0kebalDoWec
         5A1K1WptdBwIKcOAyihqgiu7JbAhAF+sFkfSOQgrn3UffmazsVnuUCjpFEopImkwmvMS
         GLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjnQVlfhhnPtvKZ7HMAj13JlaIK7MEFp7/1Fbt+A8DM=;
        b=IbybRTj4R90OPkPMLhJL7gftcFVpcXPsl6cFl7k+G7qUKDxqFWReTXJimM+eVszEBG
         GaPmB3X1aHXqz6YH+VkV7NQY5h5UAmB0pv6r5f4fR3gnNqKcZ++Q80andHkEh9vCDGfQ
         Vs75zboInbtW/6BaJ+2i2FfDVlNt/LBBAxz8977lM+Ii+BA2XA5keeGpMFCLMBFKMfBT
         nyAnRsYUrPpmjc1s9FkvYazN/nBEZSFAu/Nv7FEosPEWRy9nNoTAIR3hiLZMcbegmI6b
         GR6kUYksFnYiLxS4UmOSzU/nhOfuy1jggefITzZKt0M+Pl7sJbIwfpy7rWPtXunzsotG
         nDYQ==
X-Gm-Message-State: AOAM532RJateIUBX1Rt1Y7exs5nzSAw9u2wypP9Uy39Ml1Ej5jpdjcxP
        VW9UwsK5mzAW5HU1U3SogA==
X-Google-Smtp-Source: ABdhPJyHz2SLBe6npopV6lbeFvS40tBDp0MeNRVEIHdVjG+p8twfpzwJ29JbUvfVpNMR2jqZWcFbew==
X-Received: by 2002:a17:90a:f193:: with SMTP id bv19mr715773pjb.86.1622763403800;
        Thu, 03 Jun 2021 16:36:43 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id gg22sm3009818pjb.17.2021.06.03.16.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:36:43 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] mm,hwpoison: fix race with hugetlb page allocation
Date:   Fri,  4 Jun 2021 08:36:31 +0900
Message-Id: <20210603233632.2964832-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
References: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
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
additional one for memory error handling, which is not enough because
there's a time window where compound pages have non-zero refcount during
hugetlb page initialization.

So make __get_hwpoison_page() check page status a bit more for hugetlb
pages with get_hwpoison_huge_page(). Checking hugetlb-specific flags
under hugetlb_lock makes sure that the hugetlb page is not transitive.
It's notable that another new function, HWPoisonHandlable(), is helpful
to prevent a race against other transitive page states (like a generic
compound page just before PageHuge becomes true).

Fixes: ead07f6a867b ("mm/memory-failure: introduce get_hwpoison_page() for consistent refcount handling")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reported-by: Muchun Song <songmuchun@bytedance.com>
Cc: stable@vger.kernel.org # 5.12+
---
ChangeLog v6:
- defined HWPoisonHandlable(),
- updated comment and patch description.
---
 include/linux/hugetlb.h |  6 ++++++
 mm/hugetlb.c            | 15 +++++++++++++++
 mm/memory-failure.c     | 29 +++++++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 2 deletions(-)

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
index 470f7b5b437e..0c1d87b1e303 100644
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
index 86e9a2217716..0caedbeeed77 100644
--- v5.13-rc2/mm/memory-failure.c
+++ v5.13-rc2_patched/mm/memory-failure.c
@@ -1092,6 +1092,17 @@ static int page_action(struct page_state *ps, struct page *p,
 	return (result == MF_RECOVERED || result == MF_DELAYED) ? 0 : -EBUSY;
 }
 
+/*
+ * Return true if a page type of a given page is supported by hwpoison
+ * mechanism (while handling could fail), otherwise false.  This function
+ * does not return true for hugetlb or device memory pages, so it's assumed
+ * to be called only in the context where we never have such pages.
+ */
+static inline bool HWPoisonHandlable(struct page *page)
+{
+	return PageLRU(page) || __PageMovable(page);
+}
+
 /**
  * __get_hwpoison_page() - Get refcount for memory error handling:
  * @page:	raw error page (hit by memory error)
@@ -1102,8 +1113,22 @@ static int page_action(struct page_state *ps, struct page *p,
 static int __get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
+	int ret = 0;
+	bool hugetlb = false;
+
+	ret = get_hwpoison_huge_page(head, &hugetlb);
+	if (hugetlb)
+		return ret;
+
+	/*
+	 * This check prevents from calling get_hwpoison_unless_zero()
+	 * for any unsupported type of page in order to reduce the risk of
+	 * unexpected races caused by taking a page refcount.
+	 */
+	if (!HWPoisonHandlable(head))
+		return 0;
 
-	if (!PageHuge(head) && PageTransHuge(head)) {
+	if (PageTransHuge(head)) {
 		/*
 		 * Non anonymous thp exists only in allocation/free time. We
 		 * can't handle such a case correctly, so let's give it up.
@@ -1160,7 +1185,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 			ret = -EIO;
 		}
 	} else {
-		if (PageHuge(p) || PageLRU(p) || __PageMovable(p)) {
+		if (PageHuge(p) || HWPoisonHandlable(p)) {
 			ret = 1;
 		} else {
 			/*
-- 
2.25.1

