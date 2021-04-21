Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEF36633A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbhDUA6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhDUA6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:58:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D319C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:57:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f29so28105189pgm.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nq3/ECMlWFOh9aBfURRW3bFhH3w1pC1RXXgmopGjoU=;
        b=RX8GqcDVqZryXJsFgtBirG/p+dv1y2g1b+RWkMv0FQyh6r5Ipj7L6leC1fIJSC/9n3
         28PxkUuszl8U/a7UgsjXKZyGL6Sj2ptJBc/sts2+QhRCiZ8s+ZMW2bFg7eWXdiWzr1TA
         Xaf8FKzhhDJ/zSf1ilrHy17GfNF0xRqvhOs55tac5DqxOZTAoU0rwZ6OAookbT5S6yHT
         57ptXEh+pvDkg0orHgcgYYvztvSjIJWtn/JEmQB59nxhlMNIFZnqxSV/IqI7iP1N5BTL
         DLH4GuI2CsgZUCqrHe+4LYcJ7OJLPdwyP9VPfRvG74jnazmIaY1ZFE2iuC58AFfMm1vy
         6Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nq3/ECMlWFOh9aBfURRW3bFhH3w1pC1RXXgmopGjoU=;
        b=Sg92642qyw33yzCK/O79snmwPqcYdW/HzKcT8Uu3yTAsKlwKqY3JpVx+JlvKF8qNMp
         fZjh3npXq/koGELGOdiPBoPeVjp0rcg3EJmyAHh9NvKugwTmxcbcisz4xyxAJKcDIlIy
         MdYGehmXxzQmul4XXKOQIe57GgUTC5X4VYbKsNBCtGRkbXRQXIO+rTIty63fNLBdyC/D
         +dAAME9asw2irP1590K7VtGgHAF5t/nYL87dbb8NQKR//SCZ+k5yLo6w3wLmXX0ZxBTQ
         fFuHuIP10w94pbYE6OGdKIdamdUCjFuHcmIcXTkbW1qVb7Dl7V5yE6eYfY/2LdBASTVO
         GSiA==
X-Gm-Message-State: AOAM532wfekIzguDl8SBlTlkJCLm+ZxAgQB2f7QBLMA0Pb/YGkbHUPQy
        AY4AHaJF1bKTGnzBE8JW+A==
X-Google-Smtp-Source: ABdhPJwZIo48/xU0japGGgAYMRnjMEC6BjOY0TIBYvR1Z6I1QyWJulIj08Iac3q+WSoNK7ZCcx85rw==
X-Received: by 2002:a63:344:: with SMTP id 65mr19429870pgd.24.1618966662035;
        Tue, 20 Apr 2021 17:57:42 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id e13sm178278pfi.199.2021.04.20.17.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:57:41 -0700 (PDT)
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
Subject: [PATCH v3 1/3] mm/memory-failure: Use a mutex to avoid memory_failure() races
Date:   Wed, 21 Apr 2021 09:57:26 +0900
Message-Id: <20210421005728.1994268-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
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
---
 mm/memory-failure.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git v5.12-rc8/mm/memory-failure.c v5.12-rc8_patched/mm/memory-failure.c
index 24210c9bd843..4087308e4b32 100644
--- v5.12-rc8/mm/memory-failure.c
+++ v5.12-rc8_patched/mm/memory-failure.c
@@ -1381,6 +1381,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+static DEFINE_MUTEX(mf_mutex);
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -1404,7 +1406,7 @@ int memory_failure(unsigned long pfn, int flags)
 	struct page *hpage;
 	struct page *orig_head;
 	struct dev_pagemap *pgmap;
-	int res;
+	int res = 0;
 	unsigned long page_flags;
 	bool retry = true;
 
@@ -1424,13 +1426,18 @@ int memory_failure(unsigned long pfn, int flags)
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
@@ -1463,17 +1470,19 @@ int memory_failure(unsigned long pfn, int flags)
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
@@ -1497,7 +1506,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (PageCompound(p) && compound_head(p) != orig_head) {
 		action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
 		res = -EBUSY;
-		goto out;
+		goto unlock_page;
 	}
 
 	/*
@@ -1517,14 +1526,14 @@ int memory_failure(unsigned long pfn, int flags)
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
@@ -1543,7 +1552,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!hwpoison_user_mappings(p, pfn, flags, &p)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
-		goto out;
+		goto unlock_page;
 	}
 
 	/*
@@ -1552,13 +1561,15 @@ int memory_failure(unsigned long pfn, int flags)
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

