Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6236E342211
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCSQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhCSQix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:38:53 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29FAC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c204so6277970pfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXGZ6vDG2a1eZeTzRSZB0jHuhMCuUpF3ItkaVaacSL8=;
        b=p7Y0nmmY5gp4ASuWh5hZmoWDSRrfcJZeWv6p/KSmtuKv7nZ21+azoq3I/s4Ij5Xx14
         IRkgxHEf7kksT7v1/fZ8TEC4Nmx+tP6gmhhGb9lcv4Kxr/o/e8DsYhpLt5CMGMJterX9
         ROFVTMT1IZtAkzrpW9saiD/E3ANHjzYINBid2I2x2URuIXZHvhJfOxCSqqMruh0COux8
         Uy8ejr7QAHfIMoGRsGpumyeHP4ILai4ijNONHUwxwcZJsGEW/BLf0qIKe9NQ4u2B1Z+b
         s0HJ67rK77lXXUM/HwlX9pYTjWMvcCc2CguiDQ0Wi5IRwwu7d6h64ZQYzeYVxNPNC6BP
         oT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXGZ6vDG2a1eZeTzRSZB0jHuhMCuUpF3ItkaVaacSL8=;
        b=n+g2jQlyMM9PYBAZVgGu9neOfUVfXNb90477JKLRH+Gq5JnIQdVEMgPGtXt0Ox3VT9
         E1K1nuFrgyLKv65QgupBSLibNGtQL3vlYb1nvHJJCsyTdY9FC0AxeQDLQZasIxmtnRxG
         Oy+/YEMzzcrkMA+FRRU1eLE450k+Cx1FnXNkuMN+tQXQhM91QUesjqn8bSLv0IEud+ZE
         dlLbSeE1P+DaDcRYFX+0s9lLGyu7R+tzrr8tyLRrlxJO8t/t+421Tlafrj2BzVMif8/D
         0V/DCXhYdI//vceQMH9p0Q1J1iWTx9iaJdzx+yWEY5JD+cQ4P2WnaaUH6Z+HfiA8SYCy
         9QcQ==
X-Gm-Message-State: AOAM530NM7xbt9tw/lAFrho+EdoCnTEv79yYX4KmC9UC7fESf3uAnmsj
        6ksbN4DI8Z3wAxaAexyl51UtUw==
X-Google-Smtp-Source: ABdhPJyhh2n5LgD32ubXUuyzP9bBzi7XNR7Nflj4NX51VQzHo76y7TCe9A8AahIe1urtB+xZFvKoxg==
X-Received: by 2002:a63:4421:: with SMTP id r33mr12025068pga.247.1616171930332;
        Fri, 19 Mar 2021 09:38:50 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id z25sm5860239pfn.37.2021.03.19.09.38.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:38:50 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 3/7] mm: memcontrol: directly access page->memcg_data in mm/page_alloc.c
Date:   Sat, 20 Mar 2021 00:38:16 +0800
Message-Id: <20210319163821.20704-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210319163821.20704-1-songmuchun@bytedance.com>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page_memcg() is not suitable for use by page_expected_state() and
page_bad_reason(). Because it can BUG_ON() for the slab pages when
CONFIG_DEBUG_VM is enabled. As neither lru, nor kmem, nor slab page
should have anything left in there by the time the page is freed, what
we care about is whether the value of page->memcg_data is 0. So just
directly access page->memcg_data here.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f10966e3b4a5..e5454b85a106 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1124,7 +1124,7 @@ static inline bool page_expected_state(struct page *page,
 	if (unlikely((unsigned long)page->mapping |
 			page_ref_count(page) |
 #ifdef CONFIG_MEMCG
-			(unsigned long)page_memcg(page) |
+			page->memcg_data |
 #endif
 			(page->flags & check_flags)))
 		return false;
@@ -1149,7 +1149,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 			bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
 	}
 #ifdef CONFIG_MEMCG
-	if (unlikely(page_memcg(page)))
+	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
 	return bad_reason;
-- 
2.11.0

