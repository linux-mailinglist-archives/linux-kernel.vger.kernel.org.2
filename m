Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B23A5B82
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhFNCO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhFNCOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 22:14:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D95C0617AF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:12:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v11so5743420ply.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06DPK/DIEfCFono0yuu1MCmhjq2CI/XtitXHneoP5fU=;
        b=oWnsV+BezW5KT/QArk9QVETWeqDfJl2d0xSVEz5fNV0UeDg3N0nGB6rHIPLkhFMd/l
         3CDyZjxsWdP0wNJJ09O9ZUkWN3NL2fnd92bwl6sjl34LSCcfK8bguFt6wZlcqfswg9pa
         mrveVeMvidjJcKOLFf9eeAQvIRJIi+VnGYGTvCwf0dF3a7NbNRUWrYk9ECL8+s6chqk1
         uLXgBjnhawBe2UKbquoCWVnptyLHUIzTBgkTIjQlAEB2Tf4+ytkwIMOFcaGUdA+d/jS+
         Wgt2DoNznNULS4i12VJM4IW/Y+bRX5LXLjw4GXcc7LGQ5Wa4Xmhz2nx2xvY4ocpBGps4
         dqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06DPK/DIEfCFono0yuu1MCmhjq2CI/XtitXHneoP5fU=;
        b=cUjURGNNfkqLY6/KIfJOKjX7Rx6PEOXHWdLZuTaot8gcGhinOTfV9rYUWCZ3NnfFPn
         Tvexok3cX+GtHpKeoAgWVXRi3Tne5/UreYf61xXGZ8GVabSTLW7Z+JkKSoyX7k3Nrb+n
         u5XaOkHm8B5Yc9k/4Dw9Mpz7KTwt2VzggWgYqGkpvTC39wI48tT5im/lLoSAExEk53w9
         KXU5gBU2B460Vtye5Hs7CR5US/FSVA3oIg+g41+6frE4ObtH5NUWJqbuG6fp9OAndJy1
         KIt2kBG6O5kImNQhPsnghQGx32OT04zLzmoj5bAV8BJ37dhNq2u5CWXCiVfD0Z/mk8vi
         Gdsg==
X-Gm-Message-State: AOAM5331dtzpbznoFpSpDyolmWG9b9LTQHqelp7kYAwxwHBTBxPdLJzC
        M+f59xuB8scuq+GPJj1BFg==
X-Google-Smtp-Source: ABdhPJyvl4bHahHn/RdmP86pL4VEvHOHD7AGza4lyMnl4KqJiAGuiYT+fHhiTBjNKFUP12KiHPsRMA==
X-Received: by 2002:a17:90a:8816:: with SMTP id s22mr16662503pjn.231.1623636759326;
        Sun, 13 Jun 2021 19:12:39 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id z14sm10952986pfn.11.2021.06.13.19.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 19:12:39 -0700 (PDT)
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
Subject: [PATCH v1 5/6] mm/hwpoison: make some kernel pages handlable
Date:   Mon, 14 Jun 2021 11:12:11 +0900
Message-Id: <20210614021212.223326-6-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614021212.223326-1-nao.horiguchi@gmail.com>
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

HWPoisonHandlable() introduced by patch "mm,hwpoison: fix race with hugetlb
page allocation" filters error events by page type, and only limited events
reach get_page_unless_zero() to avoid race.

Actually this is too restictive because get_hwpoison_page always fails
to take refcount for any types of kernel page, leading to
MF_MSG_KERNEL_HIGH_ORDER.  This is not critical (no panic), but less
informative than MF_MSG_SLAB or MF_MSG_PAGETABLE, so extend
HWPoisonHandlable() to some basic types of kernel pages (slab, pgtable,
and reserved pages).

The "handling" for these types are still primitive (just taking refcount
and setting PG_hwpoison) and some more aggressive actions for memory
error containment are possible and wanted.  But compared to the older code,
these cases never enter the code block of page locks (note that
page locks is not well-defined on these pages), so it's a little safer
for functions intended for user pages not to be called for kernel pages.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git v5.13-rc5/mm/memory-failure.c v5.13-rc5_patched/mm/memory-failure.c
index b986936e50eb..0d51067f0129 100644
--- v5.13-rc5/mm/memory-failure.c
+++ v5.13-rc5_patched/mm/memory-failure.c
@@ -1113,7 +1113,8 @@ static int page_action(struct page_state *ps, struct page *p,
  */
 static inline bool HWPoisonHandlable(struct page *page)
 {
-	return PageLRU(page) || __PageMovable(page);
+	return PageLRU(page) || __PageMovable(page) ||
+		PageSlab(page) || PageTable(page) || PageReserved(page);
 }
 
 static int __get_hwpoison_page(struct page *page)
@@ -1260,12 +1261,6 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	struct page *hpage = *hpagep;
 	bool mlocked = PageMlocked(hpage);
 
-	/*
-	 * Here we are interested only in user-mapped pages, so skip any
-	 * other types of pages.
-	 */
-	if (PageReserved(p) || PageSlab(p))
-		return true;
 	if (!(PageLRU(hpage) || PageHuge(p)))
 		return true;
 
@@ -1670,7 +1665,10 @@ int memory_failure(unsigned long pfn, int flags)
 				action_result(pfn, MF_MSG_BUDDY, res);
 				res = res == MF_RECOVERED ? 0 : -EBUSY;
 			} else {
-				action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
+				if (PageCompound(p))
+					action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
+				else
+					action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
 				res = -EBUSY;
 			}
 			goto unlock_mutex;
@@ -1681,6 +1679,20 @@ int memory_failure(unsigned long pfn, int flags)
 		}
 	}
 
+	if (PageSlab(p)) {
+		action_result(pfn, MF_MSG_SLAB, MF_IGNORED);
+		res = -EBUSY;
+		goto unlock_mutex;
+	} else if (PageTable(p)) {
+		action_result(pfn, MF_MSG_PAGETABLE, MF_IGNORED);
+		res = -EBUSY;
+		goto unlock_mutex;
+	} else if (PageReserved(p)) {
+		action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
+		res = -EBUSY;
+		goto unlock_mutex;
+	}
+
 	if (PageTransHuge(hpage)) {
 		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
 			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
-- 
2.25.1

