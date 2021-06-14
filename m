Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7EC3A5B84
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 04:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhFNCPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 22:15:48 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:33682 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhFNCPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 22:15:47 -0400
Received: by mail-pl1-f182.google.com with SMTP id u18so5120533plc.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vdMGIW3kH9wsKcFDP9ep4AZRTLAnVl6tpWr1FVt4M0=;
        b=Mpd1k+BpOuolkJoCsSxTQ13L6/VHwy0QbCKwaGlxzCMP/wxROPvRVQ9NNsbITJD4Lq
         n0e9Ew2CprYBhVPB8b6K/UENJrJ0KAiAcezsoZUrMBW1P4qdeCHuPBuJPftPRSSLBj+1
         yMYEse3kXdDCDdlEHL/vpO1Rew/NoIIjbfz/dGMcEmBS0ZShaURcYgsH4eTr42Zy3VNO
         Z8Y+UHcPa89mL8n/INVVR4hPm0zqYDYPjvNul/AumfOcdSlVwjope/8j4mxW9g6eFaHv
         9yzBs2/uTefvTtnZczQOWT697Syo8X0c3U6RUaNLM6LGd7lrOWB3behfItAyp0WCcmNc
         6nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vdMGIW3kH9wsKcFDP9ep4AZRTLAnVl6tpWr1FVt4M0=;
        b=LZhuHTmBPlmELnlyhScba2Qs3sJKE2dQzx/9gYwEc+sFqaAE2WppN6G/QXSk7C1jFU
         0BEglsnnhsQvsjJZ0oufWbazNtgdc4KMWFMOrIvyz9kH7OK1f2amM7EHzgCLwaFF87O7
         H6Y8hYHVMmhMXAHF7j1kcdzZA8Hta1ABZ6COcIM0dCBGNttwp19FYqgUkCcm2ov6jOua
         AjNl0mjWHaq8lfw9sm85ysfTgDtsb4ZZ2602bg/LtkptGH1Ym5jmmhL2idnSJCVTxwsM
         3RjmqI8t1Aak64gFs+34D3YKTHeM/4Fa/x9iOWhXHu7EDAJXtKQJvXv8IZhos22Ijqjm
         I9EA==
X-Gm-Message-State: AOAM531u2uHKg0oPiluLMjZM4rN7Upft7xDvFHFGpF8Gd1fz+Ob2zZnZ
        CPpB6+XQ0cSHim2MK6lRHw==
X-Google-Smtp-Source: ABdhPJy9ExdxUVcz/l5+hEZ86ATtZOzE+wZeDhbCyXaRLE0w51mObupsZVVjbyjVrKMZrjT2TiDPBQ==
X-Received: by 2002:a17:90a:708a:: with SMTP id g10mr21223850pjk.108.1623636751104;
        Sun, 13 Jun 2021 19:12:31 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id z14sm10952986pfn.11.2021.06.13.19.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 19:12:30 -0700 (PDT)
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
Subject: [PATCH v1 2/6] mm/hwpoison: remove race consideration
Date:   Mon, 14 Jun 2021 11:12:08 +0900
Message-Id: <20210614021212.223326-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614021212.223326-1-nao.horiguchi@gmail.com>
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Now memory_failure() and unpoison_memory() are protected by mf_mutex,
so no need to explicitly check races between them.  So remove them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git v5.13-rc5/mm/memory-failure.c v5.13-rc5_patched/mm/memory-failure.c
index 280eb6d6dd15..e7910386fc9c 100644
--- v5.13-rc5/mm/memory-failure.c
+++ v5.13-rc5_patched/mm/memory-failure.c
@@ -1461,14 +1461,6 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	lock_page(head);
 	page_flags = head->flags;
 
-	if (!PageHWPoison(head)) {
-		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
-		num_poisoned_pages_dec();
-		unlock_page(head);
-		put_page(head);
-		return 0;
-	}
-
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
@@ -1730,16 +1722,6 @@ int memory_failure(unsigned long pfn, int flags)
 	 */
 	page_flags = p->flags;
 
-	/*
-	 * unpoison always clear PG_hwpoison inside page lock
-	 */
-	if (!PageHWPoison(p)) {
-		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
-		num_poisoned_pages_dec();
-		unlock_page(p);
-		put_page(p);
-		goto unlock_mutex;
-	}
 	if (hwpoison_filter(p)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
@@ -1956,17 +1938,6 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	/*
-	 * unpoison_memory() can encounter thp only when the thp is being
-	 * worked by memory_failure() and the page lock is not held yet.
-	 * In such case, we yield to memory_failure() and make unpoison fail.
-	 */
-	if (!PageHuge(page) && PageTransHuge(page)) {
-		unpoison_pr_info("Unpoison: Memory failure is now running on %#lx\n",
-				 pfn, &unpoison_rs);
-		goto unlock_mutex;
-	}
-
 	if (!get_hwpoison_page(p, flags)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
@@ -1975,20 +1946,12 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	lock_page(page);
-	/*
-	 * This test is racy because PG_hwpoison is set outside of page lock.
-	 * That's acceptable because that won't trigger kernel panic. Instead,
-	 * the PG_hwpoison page will be caught and isolated on the entrance to
-	 * the free buddy page pool.
-	 */
 	if (TestClearPageHWPoison(page)) {
 		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
 				 pfn, &unpoison_rs);
 		num_poisoned_pages_dec();
 		freeit = 1;
 	}
-	unlock_page(page);
 
 	put_page(page);
 	if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
-- 
2.25.1

