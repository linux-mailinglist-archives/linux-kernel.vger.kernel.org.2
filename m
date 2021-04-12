Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9D35D353
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbhDLWnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbhDLWnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:43:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7258C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:43:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p16so3201916plf.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JkA3Ny2V6Qq9Dk3aSySw7xYrKKcRmImrxlIoiSgIjQ0=;
        b=X0R7t1a+/vUebM2KusNVgIyrf8ZQZp4ygxUvDy25rGxEtvJoLMDsHRy7aV1gFRm/wk
         NM5SL9lNBEg7xDvdaBfI05WJqBVaArAYzFx5PMGvhQ5sEkph/y8LEjcXZStSlTqB2Xej
         XqaytIGgnAlq2YhnsXpj+uu0h1YWIE2qVUwrtrVWtKn9q9exriujEzk8rvqkz2mOwQuN
         +9mL+t1FV8qrKEJHe/TBJgLUA+fqpY6vGIjUCQULhxghq2pxhqpGoz6aPe6gILzvEIJ0
         msoxnEDFV+G5c0zmVQLP3NhTVz4ca+9EmUwwP3rwHFWLzuxkbdjTnqjPGDcGuBFcDzpp
         E2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkA3Ny2V6Qq9Dk3aSySw7xYrKKcRmImrxlIoiSgIjQ0=;
        b=sXy/zCnYJM/6YuhTygT0j2N6mVmAHTRcMYJ305oetNIGyEE0d8gNsomWg/X96cNDTa
         VVWftJuh65uaiAgo7u8OeVApiUCQp3YUTRk3ND6OPbajXOhsCcBz6kM6e37gvxe6rFRv
         sqR+gz1BgzHh9A9h6D/WOjhMpXe/RWBOsO1Mpd/EtZuRLhrgP+szwtEYiI0t18h1un8J
         xiAsgmIccZtLaekldcniWbrnY0PrEZzSsm2/d5hPXU8+/Tq7axf9LuaAizI920P6LHw7
         Fc6O293KHgg5nxZIqGD/nkMYUhOgK7hS7yTbgNBJxJiDUlJmBWhtdSLfsRhpo6LkIran
         D05A==
X-Gm-Message-State: AOAM531sK2TYCzIYwVaDNxUakI8R1LA2ra3Kh1I4wiRivOPriEzTIxe6
        sclPaFtBQpJyDkhK0BHWeA==
X-Google-Smtp-Source: ABdhPJykwz0wDYo5DwqyUPL0KJ+J6h8Y3bmJ5iNVsNLoy4vJCeDpgEL+MWPvo4ds3wa3fN4u8f0dXA==
X-Received: by 2002:a17:90b:4b8c:: with SMTP id lr12mr1556254pjb.124.1618267410185;
        Mon, 12 Apr 2021 15:43:30 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id l25sm13365373pgu.72.2021.04.12.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 15:43:29 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] mm/memory-failure: Use a mutex to avoid memory_failure() races
Date:   Tue, 13 Apr 2021 07:43:18 +0900
Message-Id: <20210412224320.1747638-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
References: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
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
 mm/memory-failure.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git v5.12-rc5/mm/memory-failure.c v5.12-rc5_patched/mm/memory-failure.c
index 24210c9bd843..c1509f4b565e 100644
--- v5.12-rc5/mm/memory-failure.c
+++ v5.12-rc5_patched/mm/memory-failure.c
@@ -1381,6 +1381,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+static DEFINE_MUTEX(mf_mutex);
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -1424,12 +1426,18 @@ int memory_failure(unsigned long pfn, int flags)
 		return -ENXIO;
 	}
 
+	mutex_lock(&mf_mutex);
+
 try_again:
-	if (PageHuge(p))
-		return memory_failure_hugetlb(pfn, flags);
+	if (PageHuge(p)) {
+		res = memory_failure_hugetlb(pfn, flags);
+		goto out2;
+	}
+
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
+		mutex_unlock(&mf_mutex);
 		return 0;
 	}
 
@@ -1463,9 +1471,11 @@ int memory_failure(unsigned long pfn, int flags)
 				res = MF_FAILED;
 			}
 			action_result(pfn, MF_MSG_BUDDY, res);
+			mutex_unlock(&mf_mutex);
 			return res == MF_RECOVERED ? 0 : -EBUSY;
 		} else {
 			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
+			mutex_unlock(&mf_mutex);
 			return -EBUSY;
 		}
 	}
@@ -1473,6 +1483,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (PageTransHuge(hpage)) {
 		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
 			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
+			mutex_unlock(&mf_mutex);
 			return -EBUSY;
 		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
@@ -1517,6 +1528,7 @@ int memory_failure(unsigned long pfn, int flags)
 		num_poisoned_pages_dec();
 		unlock_page(p);
 		put_page(p);
+		mutex_unlock(&mf_mutex);
 		return 0;
 	}
 	if (hwpoison_filter(p)) {
@@ -1524,6 +1536,7 @@ int memory_failure(unsigned long pfn, int flags)
 			num_poisoned_pages_dec();
 		unlock_page(p);
 		put_page(p);
+		mutex_unlock(&mf_mutex);
 		return 0;
 	}
 
@@ -1559,6 +1572,8 @@ int memory_failure(unsigned long pfn, int flags)
 	res = identify_page_state(pfn, p, page_flags);
 out:
 	unlock_page(p);
+out2:
+	mutex_unlock(&mf_mutex);
 	return res;
 }
 EXPORT_SYMBOL_GPL(memory_failure);
-- 
2.25.1

