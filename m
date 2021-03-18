Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AFA34043C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCRLJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCRLIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:08:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5BDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:48 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id n11so1200170pgm.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2a1Q2yqghil2SSuBrZCKn/WKXtEY0qZpSKwUUGtGYmY=;
        b=hX6/GKnUT+Ilw/SDCCSBWdFzs4WAT6mGp/EfDQfq8LGKDxZ+SKKA7NxoIHTfJ+a/nX
         VhS0xLPj5LjDtRdfrNYbeEO+LRjq69d8n50zryDPlHp2Ojva4nqea0rDXjk+UlaCJIab
         WyDJBosKmTyQw3uRCCHZjq25G8//ycGePxYRHo+ydN8I/qVMx1Vnts6J6F8Bu11BtY/9
         IUflt7mGSnn+997hIM8VMWgmrhrO8wt94uFlH2jpVIuJR/H3UXMpvdxP0y8dpio8WM1z
         GL0ejD58nG7HecS6pj5zUo1KZKmgu/RjQ91OkKYJ7yeAjwBLYThZp+GYxSrcnRPjUVem
         jetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2a1Q2yqghil2SSuBrZCKn/WKXtEY0qZpSKwUUGtGYmY=;
        b=BrFOEv8kJNYKm4Jd3KxglZGkpD6VAfyWOlCUeFP8rnMz9jPOdFgyG5wHLQuzX1ffZI
         rqN0uGoezAzQlP3n1kRLF0GmMhAF6v37pnsfyItfNoAD98AP7NQWLOKllbRM3mRCTEoC
         FrpejAwF8fdFEm5DjfW3HCHptPhmHA2R9/o/dQf5i7BLBIVYdcqAxH4rRN8jmOjlx4Rx
         7sNt7uxAd4VuyHXDpp++kwyJV+j4uk+cxZ6gWM2r4YkUsM+QbPhScGpmDGyg/6eNHvsR
         FGQltBoWLqTyBRghm4mgQXZRqwnM5o2oRCDYG5Nz7Lrzeu2DQuqB4LRDyzEXjwpGVbTh
         lJHw==
X-Gm-Message-State: AOAM533NSlYs/CR3dEBUdOuOoopnQsErPfXRfCvNQKwm4UpK50gSFSnE
        YJtUrqV4A/lnUdR2U0PzWHtenQ==
X-Google-Smtp-Source: ABdhPJxFBl9WuSrFTiRWvdlXHku6toNPWED+IUaMV77zPDYMhGWwbqGQh69e6odC2uF5ITmlXNk3BQ==
X-Received: by 2002:aa7:8e51:0:b029:1ed:2928:18ff with SMTP id d17-20020aa78e510000b02901ed292818ffmr3514424pfr.76.1616065728142;
        Thu, 18 Mar 2021 04:08:48 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id e21sm1779509pgv.74.2021.03.18.04.08.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 04:08:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 5/5] mm: memcontrol: move PageMemcgKmem to the scope of CONFIG_MEMCG_KMEM
Date:   Thu, 18 Mar 2021 19:06:58 +0800
Message-Id: <20210318110658.60892-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210318110658.60892-1-songmuchun@bytedance.com>
References: <20210318110658.60892-1-songmuchun@bytedance.com>
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

