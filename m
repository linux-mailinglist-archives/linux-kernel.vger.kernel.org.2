Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C823C8168
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbhGNJX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhGNJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:23:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68ACC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:21:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id a2so1773449pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1wb5iN6C/r/jl8NTvJ6JTzD0t7BIT0w39tfIUzR0c+I=;
        b=zplQE4G7tcgmBinMSn8w4wPywLrIByLSGqitptn1ZR9FdsRi1QXv75GdAavbVA7JN4
         LyVVy0vtZerXQwmXr6nlVQzQ3wBO5qAZAXBObfbOI49LsAX5QlP+g6vJsXVcdvmcZwT6
         Gtv+myhlxOWU74E1cjQjT6kd3Y5OOiBtoi7kmyBlIfLms9+pQsxkmrhpzv2F7OGgj/Cg
         QjRJvLHu25gepnxpMVz6Q15ZrVzwLM4tpLz3sboZo42D7V6oxAwSsJmTab3xWFFXa7Ki
         mrOks3PQ1/lBeMR5srIeZCq9NCxEM81sIhf5bY2Hz1lS64edYvUANFsmm+YFyDWPIdhV
         rHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1wb5iN6C/r/jl8NTvJ6JTzD0t7BIT0w39tfIUzR0c+I=;
        b=gqxVB2qcT0VB8FnM+G+mZUI2C5dViIQMblYVBt3xmuHPj3nWeMKyyzErCoS5fyYwLV
         pHbIWNH1tUnC2ce84Jeq8hFKBN+2ZaTOBs7k97j5Hhjl89WIKa7Bl2OshsUgzA9s5jJm
         CX9KDH8pAPrhT9iJZPnTZ+ERus9FJhUkgOFvUb6TekalanrjIrYmOyjjLROfEI7USIMD
         anttrEndVKHFITIz47kVzcA9IxjuemkxlJI8hI5WKXIX/RfS+hQUwSUA5tK4T1M29Muo
         P+sXe+TdUzd9cjXvAfQT3wN0H+nswNEUBvqifLkdbXQEDhm49GSoAAnsGXOqBOgA/7Xh
         D4Pw==
X-Gm-Message-State: AOAM5306Auw7IkbU9eb8bPjf+4lbaOs097hveQm1593V5h6bL1OPM3s8
        PPdQd2s09uDGR6Mg8B6NkLE35Q==
X-Google-Smtp-Source: ABdhPJzEijXZzF0Qf19GMjfpTQOk+y74uZh4grXC65z8xbeHoDsVcjqOTYZMN3z9W/kZBgak8cDqZQ==
X-Received: by 2002:a65:564f:: with SMTP id m15mr8717302pgs.346.1626254464534;
        Wed, 14 Jul 2021 02:21:04 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id k19sm1742540pji.32.2021.07.14.02.20.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jul 2021 02:21:04 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/5] mm: introduce save_page_flags to cooperate with show_page_flags
Date:   Wed, 14 Jul 2021 17:17:57 +0800
Message-Id: <20210714091800.42645-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210714091800.42645-1-songmuchun@bytedance.com>
References: <20210714091800.42645-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce save_page_flags to return the page flags which can cooperate
with show_page_flags. If we want to hihe some page flags from users, it
will be useful to alter save_page_flags directly. This is a preparation
for the next patch to hide some page flags from users.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/trace/events/mmflags.h  | 3 +++
 include/trace/events/page_ref.h | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 390270e00a1d..69cb84b1257e 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -121,6 +121,9 @@ IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
 IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)		\
 IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
 
+#define save_page_flags(page)						\
+	(((page)->flags & ~PAGEFLAGS_MASK))
+
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
 	__def_pageflag_names						\
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 643b1b4e9f27..53d303048d27 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_fast_assign(
 		__entry->pfn = page_to_pfn(page);
-		__entry->flags = page->flags;
+		__entry->flags = save_page_flags(page);
 		__entry->count = page_ref_count(page);
 		__entry->mapcount = page_mapcount(page);
 		__entry->mapping = page->mapping;
@@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
 		__entry->pfn,
-		show_page_flags(__entry->flags & ~PAGEFLAGS_MASK),
+		show_page_flags(__entry->flags),
 		__entry->count,
 		__entry->mapcount, __entry->mapping, __entry->mt,
 		__entry->val)
@@ -77,7 +77,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 
 	TP_fast_assign(
 		__entry->pfn = page_to_pfn(page);
-		__entry->flags = page->flags;
+		__entry->flags = save_page_flags(page);
 		__entry->count = page_ref_count(page);
 		__entry->mapcount = page_mapcount(page);
 		__entry->mapping = page->mapping;
@@ -88,7 +88,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 
 	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
 		__entry->pfn,
-		show_page_flags(__entry->flags & ~PAGEFLAGS_MASK),
+		show_page_flags(__entry->flags),
 		__entry->count,
 		__entry->mapcount, __entry->mapping, __entry->mt,
 		__entry->val, __entry->ret)
-- 
2.11.0

