Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7103A5B80
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 04:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhFNCOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 22:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhFNCOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 22:14:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC35FC061766
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:12:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x19so5748893pln.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PD461rujAEvHxr+/423Md1bdyuXr957SSOfQ9o3RiIk=;
        b=Zg98D31y7/QomMWOeDbhAIjUUpumQ3WhsLgSXqChPuNcTO+2B3Yg3tFURj+HMYSTuY
         PMei/LmWGdXfCCmEKF9ncLLJrQ/jKYh0rTohjWY6rqlxctl4HwaV91DLBLy0OYa7dw+r
         MGa4EDsvCz+6oSI/dPLaVhDmrKlmWDjreg465vIppbjSNcGgDGSvyo108WGwpF5NK+62
         WzSZk9NMXQpwoC+XEiabwbJ7H3gRE0GRj/mtYQzhWAzNZNltfg+YM9S96fZDpiXLUkVC
         BA+dAoDG9gLipFKLklBHKCam2Wq/IIdiGC5c/yfYlUXKnr+/yQXjvvPVoauEVtILZ3ri
         uUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PD461rujAEvHxr+/423Md1bdyuXr957SSOfQ9o3RiIk=;
        b=REstNbDHaRABo9zWhZncFibN5tcq6RjU5f3D5TO3uEfWEO/18XHP1nTa3BNO1HoLOQ
         PWZrk0jLuUjLqMDt4yIHoeTpYWvKzWCyoIN/DXIyJqxsu6qGD+3ObMSo6Ju6zvhzUzQ9
         fKGaAnWnxivYT+zkmxHdvxJAUp/d07qE3kZzMSIHnCdU6V5Jx5uVYRmvARXuHnR6vqyx
         PJfNUO+/p3a3lp5889F+WV5ColzvudZgr4AicBxai/xS0LxCKRrvu9ze60mpn7VdrDJV
         38E2CYmPIgN7FRgMXoTc3cZ40zEZTpL8YmeMHdBjol0G1fHkB6Wq+OFOI7VPER/TVUEu
         UCGw==
X-Gm-Message-State: AOAM533+QVkXUzIA8fL2ornu5HNBXJJzfgNPikPr4UN0a0tAW6yetqxZ
        hCkzVqT/DlCl+yDQ3hmH8Q==
X-Google-Smtp-Source: ABdhPJwugd/Yot3NacwjR7y/JV2uBnlBgfNLUSBKKMWCNNy/msTA+QPtRFK0ZmFAhnIT4pJeCnUYrQ==
X-Received: by 2002:a17:90b:4b49:: with SMTP id mi9mr20470555pjb.219.1623636748399;
        Sun, 13 Jun 2021 19:12:28 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id z14sm10952986pfn.11.2021.06.13.19.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 19:12:28 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] mm/hwpoison: mf_mutex for soft offline and unpoison
Date:   Mon, 14 Jun 2021 11:12:07 +0900
Message-Id: <20210614021212.223326-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614021212.223326-1-nao.horiguchi@gmail.com>
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Originally mf_mutex is introduced to serialize multiple MCE events, but
it's also helpful to exclude races among  soft_offline_page() and
unpoison_memory().  So apply mf_mutex to them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git v5.13-rc5/mm/memory-failure.c v5.13-rc5_patched/mm/memory-failure.c
index ae30fd6d575a..280eb6d6dd15 100644
--- v5.13-rc5/mm/memory-failure.c
+++ v5.13-rc5_patched/mm/memory-failure.c
@@ -1583,6 +1583,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+static DEFINE_MUTEX(mf_mutex);
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -1609,7 +1611,6 @@ int memory_failure(unsigned long pfn, int flags)
 	int res = 0;
 	unsigned long page_flags;
 	bool retry = true;
-	static DEFINE_MUTEX(mf_mutex);
 
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
@@ -1918,6 +1919,7 @@ int unpoison_memory(unsigned long pfn)
 	struct page *page;
 	struct page *p;
 	int freeit = 0;
+	int ret = 0;
 	unsigned long flags = 0;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
@@ -1928,28 +1930,30 @@ int unpoison_memory(unsigned long pfn)
 	p = pfn_to_page(pfn);
 	page = compound_head(p);
 
+	mutex_lock(&mf_mutex);
+
 	if (!PageHWPoison(p)) {
 		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	if (page_count(page) > 1) {
 		unpoison_pr_info("Unpoison: Someone grabs the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	if (page_mapped(page)) {
 		unpoison_pr_info("Unpoison: Someone maps the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	if (page_mapping(page)) {
 		unpoison_pr_info("Unpoison: the hwpoison page has non-NULL mapping %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	/*
@@ -1960,7 +1964,7 @@ int unpoison_memory(unsigned long pfn)
 	if (!PageHuge(page) && PageTransHuge(page)) {
 		unpoison_pr_info("Unpoison: Memory failure is now running on %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	if (!get_hwpoison_page(p, flags)) {
@@ -1968,7 +1972,7 @@ int unpoison_memory(unsigned long pfn)
 			num_poisoned_pages_dec();
 		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	lock_page(page);
@@ -1990,7 +1994,9 @@ int unpoison_memory(unsigned long pfn)
 	if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
 		put_page(page);
 
-	return 0;
+unlock_mutex:
+	mutex_unlock(&mf_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(unpoison_memory);
 
@@ -2171,6 +2177,8 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return -EIO;
 	}
 
+	mutex_lock(&mf_mutex);
+
 	if (PageHWPoison(page)) {
 		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
 		put_ref_page(ref_page);
@@ -2194,5 +2202,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 			 __func__, pfn, page->flags, &page->flags);
 	}
 
+	mutex_unlock(&mf_mutex);
+
 	return ret;
 }
-- 
2.25.1

