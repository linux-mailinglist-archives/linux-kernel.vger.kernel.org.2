Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7630F15C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhBDK5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbhBDK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:56:59 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD700C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 02:56:19 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r38so1796911pgk.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bomnKjBCXlMUt7cumGwFSxIt2tLEfiNfG1uDxtiHzHo=;
        b=meRFeoFABKNahcTD5pEZi9cJb0xVYtEo0jR+vAzCdEludgjz8sf1Qlv2/xeRPDfibp
         /MMKS0gDIAcIwS+spfwSSxSYmiHHlYLXKz78sdAEln7aHWvn0QsCJNlPvKVOmygR7EfF
         nSWXTdN5o2V9xWtAhYeJgMlGZE86yc7er/RVSRnjuvKWa6RjgUQXsVKFyMLzh72oLILh
         ZefaeRzKTsudfYwco8W1CE1Vr2eIFb+VxUGIitkSeo2UM5YS+/bx7Xwr9TH4t1EkX+rc
         uS0RLOQkFJ07jRmOC12Y7X8c6oWiSWepD2xx1ceyRtqiYop3Hqiqt9lcpsOK7wc4pLM+
         sZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bomnKjBCXlMUt7cumGwFSxIt2tLEfiNfG1uDxtiHzHo=;
        b=qBBuN9ErbiT+UsDP2ocdZr/0w6/QN8EC+M+qCQ/Gz5PurZwI0IhzgvEwI5CbTNAjJT
         JzMzr2ctzr9kuwLuEGmLgp0ocl0OUytKBIPKaB243PzI/AZvR4q5+KZGK4UJQDozpoki
         3JDP+OgOETPgx9r9jK26haJjQa+VZ0YWqaUJb0c5889wuz39f7upyHedo+W6hp2fCFk9
         LOhl9qmH9UKI1R08Ee3n6D4pAz092oNheF3F3jn9RGv29EUUpa6Ngn4ShZM54H+a5Q8n
         ZPfTqk3N/FiJ06wcUGfrDw5Et/6toq+1qC5WKyIH4p7t5P7SvLx/P+IylqQMjmhxOCon
         YW4A==
X-Gm-Message-State: AOAM533Xy09sti+FQz3TUO/TaFs2Zz/LPxAXxRvOpmanuNOHS24GQHN8
        t+fgnbEOigIjHfFjUnd51KZpCg==
X-Google-Smtp-Source: ABdhPJxUgUArlXg8y2yW1BuiqYJ2lzKT+G+NfzP6TzP4jp5cEnjoQAINnZWIf/miYy7OqREs06CHgA==
X-Received: by 2002:a63:375d:: with SMTP id g29mr4490430pgn.226.1612436179150;
        Thu, 04 Feb 2021 02:56:19 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id z15sm2043493pjz.41.2021.02.04.02.56.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 02:56:18 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: replace the loop with a list_for_each_entry()
Date:   Thu,  4 Feb 2021 18:53:20 +0800
Message-Id: <20210204105320.46072-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rule of list walk has gone since:

 commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")

So remove the strange comment and replace the loop with a
list_for_each_entry().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6c7f1ea3955e..43341bd7ea1c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6891,24 +6891,11 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 static void uncharge_list(struct list_head *page_list)
 {
 	struct uncharge_gather ug;
-	struct list_head *next;
+	struct page *page;
 
 	uncharge_gather_clear(&ug);
-
-	/*
-	 * Note that the list can be a single page->lru; hence the
-	 * do-while loop instead of a simple list_for_each_entry().
-	 */
-	next = page_list->next;
-	do {
-		struct page *page;
-
-		page = list_entry(next, struct page, lru);
-		next = page->lru.next;
-
+	list_for_each_entry(page, page_list, lru)
 		uncharge_page(page, &ug);
-	} while (next != page_list);
-
 	uncharge_batch(&ug);
 }
 
-- 
2.11.0

