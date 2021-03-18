Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17045340439
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCRLJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhCRLIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:08:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81373C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h20so1120784plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xtw62qD+a/Q8lM+edqL90eMuRS6Phfvme83OFdVlXw=;
        b=rB7UVX6Cw0ILixk1ob5vWfS1HkVmsmbTSSwfxC7TE5WQ3fh+AvmkDsV1Qx1cqFM2A6
         FItEFb7z4z34js3YLg3dXSGQiLrS0rQEDhX6OsyLtz4LHOm6A6WuR/2KiGdFE+/neqvy
         +wWHWlp8OCl290Ds7S6MKE4TT19nkgoNHkdkC1d8bWuH13kfs6sjYwDKLJG14NWGRMaX
         rCVfNanTnlMuhyxKyLqY4VIlGGeXZkV4uCDnyQTRukB7VNm9ZgXfQPLsWpn9QTkJdxAo
         PaC52X38X5Cs2cI/CQVmw1MbkMKivRczESS0Y9WReaIG8x7/Yp/6O/GTVQk3B0GDQvzP
         HeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xtw62qD+a/Q8lM+edqL90eMuRS6Phfvme83OFdVlXw=;
        b=qoI71YAC5AHWl/P+NA6ui/HSDgrahQHvtcAhokMFMjjWJ+S7TB5A4xslj9oc6qpQ5o
         X6+5PEn+pEBSgxIuTgSWR+d5+21uAqhbIGX6WWcuPQjVv/1JJ/pOz43bDt3mEjMevlQA
         BebtdVFStNRFJ6kYivmZCYThuEIIJj1VHATEyFkpygmO0tRejT9pZSkXXNaD8w8TJOQu
         z5VhMe24QHxflV0yYmo22MC660MUalebTpmM8W4bND1ahrO4E5fcpItqDJcWWoZgHDul
         gp0nRXhA3Bwax9oCtVxd4euntYMmhvc6p858h24cYc37iapPSNO/HYM4jkOUSnTYuZit
         /rPg==
X-Gm-Message-State: AOAM5304JA4rXR6cWDC3Y1v7CXEP7DkoD5K8yLYsMJlgT3tSr/aFfT9z
        F4jd7xRATxFNITZLU0moM+bkCQ==
X-Google-Smtp-Source: ABdhPJzIa469RR5z4zKgOSL2tgWTJOS7BOpGioj765KvTrpGIKZhprUgxCm/4fFELrfQOwe7585A4w==
X-Received: by 2002:a17:90a:bc06:: with SMTP id w6mr3707116pjr.44.1616065715161;
        Thu, 18 Mar 2021 04:08:35 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id e21sm1779509pgv.74.2021.03.18.04.08.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 04:08:34 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 2/5] mm: memcontrol: directly access page->memcg_data in mm/page_alloc.c
Date:   Thu, 18 Mar 2021 19:06:55 +0800
Message-Id: <20210318110658.60892-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210318110658.60892-1-songmuchun@bytedance.com>
References: <20210318110658.60892-1-songmuchun@bytedance.com>
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

