Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3211F3A0DA8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhFIHWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbhFIHWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:22:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58276C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 00:20:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p13so8165009pfw.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/MZL9GnN7cMYmNxZNzQu4EfClaV6/mydVmBdwbhvsW8=;
        b=GQkDvL7x43XLd+tZX+oYPQq/Op72lOo3JK5A2hm2kPZCSVoMnpaaFR91PiJQS0/vt/
         29K2fsKIO1FCXrAxcKmCRG3n83RZutV1eWaJ/b60yf2Bi56jgBFcB8Kzu1OqH3rK6xJl
         AhFCmKjYg5YEH9REdDX9dnli3xtXaMzlRyOExVppx3e8OrR4nPKnbjnsE48hQFoXgdD1
         eWdFTOOKx5VgTnm0n48Wgozgb3eBZfSmB/4wscrujSk9NW+VIJB3CLor31wf3Z003vX7
         ZITYcURt5q8kfYIXTlCtHIUpJfHFXZHdNtIMexDSfd2bAvw7YV0rwCj4ydsPDrL12RGd
         x0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/MZL9GnN7cMYmNxZNzQu4EfClaV6/mydVmBdwbhvsW8=;
        b=bykqpBfQZlKshPAxgJAX228KbOCVUff91fNcYsb2KY8+S05M+NXa1xtvV21MWhli7P
         Ts33PFWWVy2LGCy+XGV49ROMp6M73h14myWemAhNxUbNBNHqCe2N0jkg/42pegDO8hqe
         l87FKzTxx7IJaGJlstgyaG4Uaecx6eOp93Um/vQJhBjMJJSOt9jzPZkwkWzsGenwb8On
         ougiA7remMxD42cA3l1YvN0eb5xIY10mbhCVtW8TD0U5zicK6tGD0XbKqw2nhJMLXwpT
         IqALNKAeNFznxcP/VGxchpaVrYywoxp1o39z4h63Y+pvgIRgA6GwDUyjkjj7Q1AAh5vA
         mx6A==
X-Gm-Message-State: AOAM533eta2iE9OYoXnfDdY8B6+DJQyVRPAQgIr6oTKnd46tKbhTFmww
        2kBDPfBH1pudK+XfY9efnQ==
X-Google-Smtp-Source: ABdhPJxy4psHo6/EJX1GkSIVJ8lstih6LmYcwilcflZPmeH0jh8gYpS80/8I7kRHfLL+p7MHP6yMbg==
X-Received: by 2002:a63:1011:: with SMTP id f17mr2451249pgl.274.1623223243793;
        Wed, 09 Jun 2021 00:20:43 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id r9sm12833852pfq.158.2021.06.09.00.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 00:20:43 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/hwpoison: do not lock page again when me_huge_page() successfully recovers
Date:   Wed,  9 Jun 2021 16:20:29 +0900
Message-Id: <20210609072029.74645-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Currently me_huge_page() temporary unlocks page to perform some actions
then locks it again later.  My testcase (which calls hard-offline on
some tail page in a hugetlb, then accesses the address of the hugetlb
range) showed that page allocation code detects this page lock on buddy
page and printed out "BUG: Bad page state" message.

check_new_page_bad() does not consider a page with __PG_HWPOISON as bad
page, so this flag works as kind of filter, but this filtering doesn't
work in this case because the "bad page" is not the actual hwpoisoned
page. So stop locking page again.  Actions to be taken depend on the
page type of the error, so page unlocking should be done in ->action()
callbacks.  So let's make it assumed and change all existing callbacks
that way.

Fixes: commit 78bb920344b8 ("mm: hwpoison: dissolve in-use hugepage in unrecoverable memory error")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: stable@vger.kernel.org
---
ChangeLog v3:
- switch to "unlock page in ->action()" approach based on suggestion from Linus
  https://lore.kernel.org/linux-mm/CAHk-=wht_gk_d9k+NZs7eJvBeLOQT4xGcykgaCRHuiQ+LbReRw@mail.gmail.com/
---
 mm/memory-failure.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git v5.13-rc2/mm/memory-failure.c v5.13-rc2_patched/mm/memory-failure.c
index 763955dd6431..e5a1531f7f4e 100644
--- v5.13-rc2/mm/memory-failure.c
+++ v5.13-rc2_patched/mm/memory-failure.c
@@ -801,6 +801,7 @@ static int truncate_error_page(struct page *p, unsigned long pfn,
  */
 static int me_kernel(struct page *p, unsigned long pfn)
 {
+	unlock_page(p);
 	return MF_IGNORED;
 }
 
@@ -810,6 +811,7 @@ static int me_kernel(struct page *p, unsigned long pfn)
 static int me_unknown(struct page *p, unsigned long pfn)
 {
 	pr_err("Memory failure: %#lx: Unknown page state\n", pfn);
+	unlock_page(p);
 	return MF_FAILED;
 }
 
@@ -818,6 +820,7 @@ static int me_unknown(struct page *p, unsigned long pfn)
  */
 static int me_pagecache_clean(struct page *p, unsigned long pfn)
 {
+	int ret;
 	struct address_space *mapping;
 
 	delete_from_lru_cache(p);
@@ -826,8 +829,10 @@ static int me_pagecache_clean(struct page *p, unsigned long pfn)
 	 * For anonymous pages we're done the only reference left
 	 * should be the one m_f() holds.
 	 */
-	if (PageAnon(p))
-		return MF_RECOVERED;
+	if (PageAnon(p)) {
+		ret = MF_RECOVERED;
+		goto out;
+	}
 
 	/*
 	 * Now truncate the page in the page cache. This is really
@@ -841,7 +846,8 @@ static int me_pagecache_clean(struct page *p, unsigned long pfn)
 		/*
 		 * Page has been teared down in the meanwhile
 		 */
-		return MF_FAILED;
+		ret = MF_FAILED;
+		goto out;
 	}
 
 	/*
@@ -849,7 +855,10 @@ static int me_pagecache_clean(struct page *p, unsigned long pfn)
 	 *
 	 * Open: to take i_mutex or not for this? Right now we don't.
 	 */
-	return truncate_error_page(p, pfn, mapping);
+	ret = truncate_error_page(p, pfn, mapping);
+out:
+	unlock_page(p);
+	return ret;
 }
 
 /*
@@ -925,24 +934,26 @@ static int me_pagecache_dirty(struct page *p, unsigned long pfn)
  */
 static int me_swapcache_dirty(struct page *p, unsigned long pfn)
 {
+	int ret;
+
 	ClearPageDirty(p);
 	/* Trigger EIO in shmem: */
 	ClearPageUptodate(p);
 
-	if (!delete_from_lru_cache(p))
-		return MF_DELAYED;
-	else
-		return MF_FAILED;
+	ret = delete_from_lru_cache(p) ? MF_FAILED : MF_DELAYED;
+	unlock_page(p);
+	return ret;
 }
 
 static int me_swapcache_clean(struct page *p, unsigned long pfn)
 {
+	int ret;
+
 	delete_from_swap_cache(p);
 
-	if (!delete_from_lru_cache(p))
-		return MF_RECOVERED;
-	else
-		return MF_FAILED;
+	ret = delete_from_lru_cache(p) ? MF_FAILED : MF_RECOVERED;
+	unlock_page(p);
+	return ret;
 }
 
 /*
@@ -963,6 +974,7 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 	mapping = page_mapping(hpage);
 	if (mapping) {
 		res = truncate_error_page(hpage, pfn, mapping);
+		unlock_page(hpage);
 	} else {
 		res = MF_FAILED;
 		unlock_page(hpage);
@@ -977,7 +989,6 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		}
-		lock_page(hpage);
 	}
 
 	return res;
@@ -1009,6 +1020,8 @@ static struct page_state {
 	unsigned long mask;
 	unsigned long res;
 	enum mf_action_page_type type;
+
+	/* Callback ->action() has to unlock the relevant page inside it. */
 	int (*action)(struct page *p, unsigned long pfn);
 } error_states[] = {
 	{ reserved,	reserved,	MF_MSG_KERNEL,	me_kernel },
@@ -1072,6 +1085,7 @@ static int page_action(struct page_state *ps, struct page *p,
 	int result;
 	int count;
 
+	/* page p should be unlocked after returning from ps->action().  */
 	result = ps->action(p, pfn);
 
 	count = page_count(p) - 1;
@@ -1476,7 +1490,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 		goto out;
 	}
 
-	res = identify_page_state(pfn, p, page_flags);
+	return identify_page_state(pfn, p, page_flags);
 out:
 	unlock_page(head);
 	return res;
@@ -1768,6 +1782,8 @@ int memory_failure(unsigned long pfn, int flags)
 
 identify_page_state:
 	res = identify_page_state(pfn, p, page_flags);
+	mutex_unlock(&mf_mutex);
+	return res;
 unlock_page:
 	unlock_page(p);
 unlock_mutex:
-- 
2.25.1

