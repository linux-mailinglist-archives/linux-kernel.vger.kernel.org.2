Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C004342215
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCSQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhCSQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:39:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3320C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:39:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s21so4952400pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2a1Q2yqghil2SSuBrZCKn/WKXtEY0qZpSKwUUGtGYmY=;
        b=ts76DRlSUdCqKznHIFlxmkaJlHr7i6lQtNzoO/RMbIkr50NiOPe8TQWRN2ixR3V33V
         MSo2854BMApkQb62U5JW9wkPsfPYtTGC2w0eNR2VJcDOkmI0OCxK2tskqXLpMsQo5k6D
         I+9MF+0de3Cbo3B/emGkSQTZ9b8kytzbLLh/j7hBjH3RSTOab9/HOsEY5k0TVE2bTxrT
         HDUz3y6thtT6ym4M39vfRuGNeMWpbqVXC+l9xBR5ds5TgAFyMxiHBqq/RqrWxutVnF6b
         1EMyHafpSTsTHBvOaC6bx0muSqlYD9s4rvl0E+dFySVF/yoosEDrBi5U7q6ke41gt9lS
         09FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2a1Q2yqghil2SSuBrZCKn/WKXtEY0qZpSKwUUGtGYmY=;
        b=I7QHNTSWW9jLTQ0wN69ya/9uofm9DIOIJwJpID+JWXDSx9SV0C1BK79MClhSDDK3Z6
         HWZ9Iy+0gc7ghOk9EwlDMHAGVixN7Faus62hsUunl6l7m6I/+0H0qYytcYg1s4JPOC20
         MxkZhjYa+NLBrrLs5QvXM+q+/RAWQSMoI1eexPJfu/357kYq69SXNxPim1eHqLQTpjEl
         QBE9SKGuGI7IWDGFjoMxBNaMb6stVkew+xLKrjpcDSilEpHDZUizNoyHwB0nZxC2OVdq
         rzWzPteXQ4eh6MS8rAlQr+dTE5nOWKPdUrgip3Hkvg/Pn4/+6PRmI37N5o5CBQmhXcHB
         /nZg==
X-Gm-Message-State: AOAM533gieeA/BqM9yO/KWGXAtyetL1A54BiuViMwTfydgOquJ8Jn3sJ
        Vmn94Zq32a2my4qWRYF89sa9TQ==
X-Google-Smtp-Source: ABdhPJxLMtY1/YANoUnuBedOZOnF4FLQqQRkWkg4E+mDOLjpNusqnH6PFcwrpTUh62KkTCQDt9cozA==
X-Received: by 2002:a17:902:7682:b029:e6:2bc5:f005 with SMTP id m2-20020a1709027682b02900e62bc5f005mr14814810pll.32.1616171946396;
        Fri, 19 Mar 2021 09:39:06 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id z25sm5860239pfn.37.2021.03.19.09.39.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:39:06 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 7/7] mm: memcontrol: move PageMemcgKmem to the scope of CONFIG_MEMCG_KMEM
Date:   Sat, 20 Mar 2021 00:38:20 +0800
Message-Id: <20210319163821.20704-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210319163821.20704-1-songmuchun@bytedance.com>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page only can be marked as kmem when CONFIG_MEMCG_KMEM is enabled.
So move PageMemcgKmem() to the scope of the CONFIG_MEMCG_KMEM.

As a bonus, on !CONFIG_MEMCG_KMEM build some code can be compiled out.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 395a113e4a3b..7fdc92e1983e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -510,6 +510,7 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * PageMemcgKmem - check if the page has MemcgKmem flag set
  * @page: a pointer to the page struct
@@ -524,7 +525,6 @@ static inline bool PageMemcgKmem(struct page *page)
 	return page->memcg_data & MEMCG_DATA_KMEM;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 /*
  * page_objcgs - get the object cgroups vector associated with a page
  * @page: a pointer to the page struct
@@ -566,6 +566,11 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
 }
 
 #else
+static inline bool PageMemcgKmem(struct page *page)
+{
+	return false;
+}
+
 static inline struct obj_cgroup **page_objcgs(struct page *page)
 {
 	return NULL;
-- 
2.11.0

