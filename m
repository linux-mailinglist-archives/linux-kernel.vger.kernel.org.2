Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8591038BCC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 05:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhEUDDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 23:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhEUDDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 23:03:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACFEC061763
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:02:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso6329748pjx.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gmn+77caXUMJ4caoqVqQUZ1bs4QzEShm2/YkSqe/I/E=;
        b=gBprfNO0r40StCr1EKtjQyFNmJ/3h0TWADQlG9H2814dyqK6YYA0B+jBSv/lpDJajG
         uR/ACB82FwsWQN+4K8gaoIBAazyMtsRsXADQpQE2msBBJlrJM3ukzxxDPAJV1RXrMjim
         FqY6oJ+EGHKlkhbOzgo1LGnQuRW1N5Ez0pNXdqnO0ZHVHmpGN/qDPfrfdfhjkvpjQM+i
         YOw7hITzdED2GnCiPuBqhpgIuzjeVV9nYZuP0Gr3m3GSRnWPUo15rsYzKX7+o223L8Y8
         Cm62D8GQx8wH6fzZoMlQTdh786b/dLIfxFRwHJPYmhlfmsFSoHmU/xNF1RSm4G52WK7t
         BzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gmn+77caXUMJ4caoqVqQUZ1bs4QzEShm2/YkSqe/I/E=;
        b=Sb1BQ7PV5h91BVifLb1JH/vtu8z/D9FTuaD/ZQIlck1KNnU1nMXedBTYKw71B9fMxx
         bbUCZsQNZqFLho6FXbSDgwAg7c9YFJfZX7cYDfE28ZdwDwT4a/EGk8yFk/GQb7FO9UJu
         2IvNQiCj2ADha0dIOKDefQwK37rLKrZkIgLNeEahd6K5A/UbQ4Wu7icztfW2B0BovQIC
         yAh0T0kSZt2CdUxI595qxYmoL2flLgIoqRkevN9s4g2PQEcjHmy9RI7pLVwuvXsz4JSR
         mnDnlSicUBOYqLLasr5hLShQ6ij8dmTkO8d6RHc4PnncUSsJH5YYczCg0l1qKQR0TNYx
         Sr3w==
X-Gm-Message-State: AOAM531XXMr81yjtRgjdSl4jvV9ZdbQwISf3PnfNKc/Mz+ZCcbldP1Bh
        SfwhzCewgTDy74OKkVljzP3/kPqXf0WgyFg=
X-Google-Smtp-Source: ABdhPJxRtjfTUESVH4jVOuiT/Er6wTL+7Qo724pplulYgttBkTDucJcWrjra9CjvWSPfrPRJmTASLQ==
X-Received: by 2002:a17:90a:29c4:: with SMTP id h62mr8613595pjd.177.1621566126847;
        Thu, 20 May 2021 20:02:06 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id 191sm2959677pfx.121.2021.05.20.20.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 20:02:06 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] mm/memory-failure: Use a mutex to avoid memory_failure() races
Date:   Fri, 21 May 2021 12:01:54 +0900
Message-Id: <20210521030156.2612074-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
References: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

There can be races when multiple CPUs consume poison from the same
page. The first into memory_failure() atomically sets the HWPoison
page flag and begins hunting for tasks that map this page. Eventually
it invalidates those mappings and may send a SIGBUS to the affected
tasks.

But while all that work is going on, other CPUs see a "success"
return code from memory_failure() and so they believe the error
has been handled and continue executing.

Fix by wrapping most of the internal parts of memory_failure() in
a mutex.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 mm/memory-failure.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git v5.13-rc2/mm/memory-failure.c v5.13-rc2_patched/mm/memory-failure.c
index 9a7c12ace9e2..0f0b932ccbca 100644
--- v5.13-rc2/mm/memory-failure.c
+++ v5.13-rc2_patched/mm/memory-failure.c
@@ -1400,6 +1400,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+static DEFINE_MUTEX(mf_mutex);
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -1423,7 +1425,7 @@ int memory_failure(unsigned long pfn, int flags)
 	struct page *hpage;
 	struct page *orig_head;
 	struct dev_pagemap *pgmap;
-	int res;
+	int res = 0;
 	unsigned long page_flags;
 	bool retry = true;
 
@@ -1443,13 +1445,18 @@ int memory_failure(unsigned long pfn, int flags)
 		return -ENXIO;
 	}
 
+	mutex_lock(&mf_mutex);
+
 try_again:
-	if (PageHuge(p))
-		return memory_failure_hugetlb(pfn, flags);
+	if (PageHuge(p)) {
+		res = memory_failure_hugetlb(pfn, flags);
+		goto unlock_mutex;
+	}
+
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	orig_head = hpage = compound_head(p);
@@ -1482,17 +1489,19 @@ int memory_failure(unsigned long pfn, int flags)
 				res = MF_FAILED;
 			}
 			action_result(pfn, MF_MSG_BUDDY, res);
-			return res == MF_RECOVERED ? 0 : -EBUSY;
+			res = res == MF_RECOVERED ? 0 : -EBUSY;
 		} else {
 			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
-			return -EBUSY;
+			res = -EBUSY;
 		}
+		goto unlock_mutex;
 	}
 
 	if (PageTransHuge(hpage)) {
 		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
 			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
-			return -EBUSY;
+			res = -EBUSY;
+			goto unlock_mutex;
 		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
 	}
@@ -1516,7 +1525,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (PageCompound(p) && compound_head(p) != orig_head) {
 		action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
 		res = -EBUSY;
-		goto out;
+		goto unlock_page;
 	}
 
 	/*
@@ -1536,14 +1545,14 @@ int memory_failure(unsigned long pfn, int flags)
 		num_poisoned_pages_dec();
 		unlock_page(p);
 		put_page(p);
-		return 0;
+		goto unlock_mutex;
 	}
 	if (hwpoison_filter(p)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
 		unlock_page(p);
 		put_page(p);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	if (!PageTransTail(p) && !PageLRU(p))
@@ -1562,7 +1571,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!hwpoison_user_mappings(p, pfn, flags, &p)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
-		goto out;
+		goto unlock_page;
 	}
 
 	/*
@@ -1571,13 +1580,15 @@ int memory_failure(unsigned long pfn, int flags)
 	if (PageLRU(p) && !PageSwapCache(p) && p->mapping == NULL) {
 		action_result(pfn, MF_MSG_TRUNCATED_LRU, MF_IGNORED);
 		res = -EBUSY;
-		goto out;
+		goto unlock_page;
 	}
 
 identify_page_state:
 	res = identify_page_state(pfn, p, page_flags);
-out:
+unlock_page:
 	unlock_page(p);
+unlock_mutex:
+	mutex_unlock(&mf_mutex);
 	return res;
 }
 EXPORT_SYMBOL_GPL(memory_failure);
-- 
2.25.1

