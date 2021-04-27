Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D23836BF51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhD0Gav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhD0Gat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:30:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1591EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:30:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h20so30302566plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjbUpDY56wXOesrg6GNwI3LYisi2P4HtofaGW6JDxic=;
        b=bgvlCsmYMZyGhWOl8DcOU2ZkVIIyMBiK7tQis1z/N3tjcSguLnIYTF9vb3Cue3lwlI
         A4gJTl7i02E7oSkuKrKD9ON3oLFYbcquASqV5Scs7LHLgVV0rH9eKy9gNXJu+zVo1Bw3
         d48auHf78UbJRG2qRB+JbJW37VqL/LxDTkOFjgQG/XoPQ4PhwM+HJh1dyEM5BymifsOL
         lkh1m/EhBc8g3bKdRVuMjVCY57X8wek5PnzwEsmmUnprI2UqtbMFII4AbPtiC4KfrNfq
         gYx4FEF8thIUg4iz3txbbRp+PXztDqq3NSOdUjOXbSttob1uJjtvxsUVuQmLe5/sYNFP
         BKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjbUpDY56wXOesrg6GNwI3LYisi2P4HtofaGW6JDxic=;
        b=MpRM3RmPYSNq2SKipf1zohjJHRdCzdq7pg/jAboaCrGtJJ1WneT44EOJf9GVIWtc/E
         BszatTI41CE8yu79PEVxu/qk0YnEFkWdkY4Slm+aEOsVnWxJxt11BxccISst8CJOjTjl
         9ZLy6mhn09PyDsZameVR/a3hGOThP9rZqThKvsNjcQOAMh7ILtFzpOIL9FApmLXV3QUN
         kmrCDL4w4l8s03O3xBkLPTBPtu4zmPH8GiLv7NZV2apEuJh3sGB5M+XSOF8USxYI31q2
         0r6lLtWvJ68QoyQtcytHzzk38/+6V5V/N+IANkjxm3lh9jQTI0zv650pm9T9jLpv0cX+
         CnOw==
X-Gm-Message-State: AOAM530LF6ab4B35e0x9T9d48zN+4BJVw93mjkjcpJFJ6vGFi0x0khun
        XiXDsJdZ50ogfOvlzmX/eQ==
X-Google-Smtp-Source: ABdhPJzBbcSJ4pf6ikTwULLfBEmvMLlIaVS36i5qsnQpRoOZfsjmUEPYc/mGsf3wx+qk71nv4gTb+Q==
X-Received: by 2002:a17:90b:1646:: with SMTP id il6mr3255353pjb.27.1619505006702;
        Mon, 26 Apr 2021 23:30:06 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id t9sm902704pgg.6.2021.04.26.23.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 23:30:06 -0700 (PDT)
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
Subject: [PATCH v4 1/2] mm/memory-failure: Use a mutex to avoid memory_failure() races
Date:   Tue, 27 Apr 2021 15:29:52 +0900
Message-Id: <20210427062953.2080293-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
References: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
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

diff --git v5.12/mm/memory-failure.c v5.12_patched/mm/memory-failure.c
index 24210c9bd843..4087308e4b32 100644
--- v5.12/mm/memory-failure.c
+++ v5.12_patched/mm/memory-failure.c
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

