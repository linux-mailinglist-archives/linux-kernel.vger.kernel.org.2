Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F78325FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhBZJWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhBZJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:20:32 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D698C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:17:41 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id h126so6831905qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Sbwg5mnD28MfpC+5A1wM48SOZxACByUsBU0/u8gNTKY=;
        b=pDKOOjv7DnHHQqrg/o+zEsKkWF6x5gJ8Fur6sxRl9VJeF+L2t+3lXAtN4UD3QfSEGf
         gNuU11Wvw8rCxdt+EtvkzV0n17p5vz/d2YcjCL/AJ+Wq2obyFyYTXnOQmxJoPP2Vfqjg
         egIrc2c6XpfhqnxV640YmCd8zBD/336iPLy2rZ/sgobFxh0J2C9KF4lJFihbfy5U41Z0
         KXTFcssDgfbdmsGx08n3uKiG3a+GYRPOmiGO7rCb/QJ9JtlMgmnW4mH4b7olvP1gnS3e
         KZA231HlJ5VE7LiFn+VXX19WqPl501ql30DaMJFESUtP7G1mUtQPxdck5md0v29w6DPM
         5Qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sbwg5mnD28MfpC+5A1wM48SOZxACByUsBU0/u8gNTKY=;
        b=ClvY0K+gwuvNXSwpwt3luAz7jTZiN0kio3kPVLDV9G75NZo2WQQs1rbtD9arlSxxnm
         nhIR/yFMWQcfnV+Eg0uJqpsDV+3ERDjOO82dqUDTfzxkj6VeHqPTar/aGgVFioQ4b/VO
         Cy0qzAc74LnuiRLL0LIM0VMND0+HHoxlzA0B7eSPqQo5XE3Eyypd5KpHN+RV8XLbbh6z
         cM4+KYI+9wdv+hVpWJ5miYu/6fIZ8yIwxnN59HPtr5inozP6BBncsXdktqx/T/VkizU+
         yqSvIjCYL82N4Uv8YEvMOQYtfiYYwKsOJ3vsUHiIpuGzUqEs+pUC16KTKl4isZwSYYDK
         s4Xg==
X-Gm-Message-State: AOAM533nk7JveaqBTgW4Iinq5Eem4HfISkr9nvEhIuv7BqGc+pLPVa5F
        RJfZ1k1zN4P6it27ump4k824sV2ocAU=
X-Google-Smtp-Source: ABdhPJw49NwW1osDcsWfZjZWCmhBnG2VmrWEsp3yjpjWhKXeQaLf57JEP91v5nodzzC+al8WBoFwA4ENe74=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:69b6:2618:c96a:ceba])
 (user=yuzhao job=sendgmr) by 2002:a0c:b998:: with SMTP id v24mr1673365qvf.4.1614331060711;
 Fri, 26 Feb 2021 01:17:40 -0800 (PST)
Date:   Fri, 26 Feb 2021 02:17:18 -0700
In-Reply-To: <20210226091718.2927291-1-yuzhao@google.com>
Message-Id: <20210226091718.2927291-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20210224084807.2179942-1-yuzhao@google.com> <20210226091718.2927291-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 3/3] mm: use PF_ONLY_HEAD for PG_active and PG_unevictable
From:   Yu Zhao <yuzhao@google.com>
To:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        vbabka@suse.cz, willy@infradead.org
Cc:     guro@fb.com, hannes@cmpxchg.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All places but one test, set or clear PG_active and PG_unevictable on
small or head pages. Use compound_head() explicitly for that singleton
so the rest can rid of redundant compound_head().

bloat-o-meter result:
  add/remove: 0/0 grow/shrink: 3/38 up/down: 388/-4270 (-3882)

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 fs/proc/task_mmu.c         |  3 ++-
 include/linux/page-flags.h | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3cec6fbef725..c866c363bb41 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1712,6 +1712,7 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
 			unsigned long nr_pages)
 {
 	int count = page_mapcount(page);
+	struct page *head = compound_head(page);
 
 	md->pages += nr_pages;
 	if (pte_dirty || PageDirty(page))
@@ -1720,7 +1721,7 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
 	if (PageSwapCache(page))
 		md->swapcache += nr_pages;
 
-	if (PageActive(page) || PageUnevictable(page))
+	if (PageActive(head) || PageUnevictable(head))
 		md->active += nr_pages;
 
 	if (PageWriteback(page))
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index c9626e54df8d..b7fe855a6ee9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -335,8 +335,8 @@ PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
 	__CLEARPAGEFLAG(Dirty, dirty, PF_HEAD)
 PAGEFLAG(LRU, lru, PF_NO_TAIL) __CLEARPAGEFLAG(LRU, lru, PF_NO_TAIL)
 	TESTCLEARFLAG(LRU, lru, PF_NO_TAIL)
-PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
-	TESTCLEARFLAG(Active, active, PF_HEAD)
+PAGEFLAG(Active, active, PF_ONLY_HEAD) __CLEARPAGEFLAG(Active, active, PF_ONLY_HEAD)
+	TESTCLEARFLAG(Active, active, PF_ONLY_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
 	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
 __PAGEFLAG(Slab, slab, PF_NO_TAIL)
@@ -407,9 +407,9 @@ CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
 PAGEFLAG_FALSE(SwapCache)
 #endif
 
-PAGEFLAG(Unevictable, unevictable, PF_HEAD)
-	__CLEARPAGEFLAG(Unevictable, unevictable, PF_HEAD)
-	TESTCLEARFLAG(Unevictable, unevictable, PF_HEAD)
+PAGEFLAG(Unevictable, unevictable, PF_ONLY_HEAD)
+	__CLEARPAGEFLAG(Unevictable, unevictable, PF_ONLY_HEAD)
+	TESTCLEARFLAG(Unevictable, unevictable, PF_ONLY_HEAD)
 
 #ifdef CONFIG_MMU
 PAGEFLAG(Mlocked, mlocked, PF_NO_TAIL)
-- 
2.30.1.766.gb4fecdf3b7-goog

