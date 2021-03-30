Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D667134E554
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhC3KVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhC3KVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:21:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3B4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:21:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i6so4220611pgs.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5veAUhSS6Fz26qMprH/wcKOq7j9SHcNjy/OxtDgU18=;
        b=zmgA6N0P6xL+V29cMSaEkKDyFRe4H8XPXlM0+f6dCOZP38p5f58whv0lg+2tRIU9n4
         c7E0IsyjDNrfjBv7A2czlzFODQekAnNcftnNDdPW6e/iO1sELVQOI+fvR4OmbdsMdlGo
         EpZQGi3QbqjgKvnRW/cPYp/u/RcPZJFYSwm9w3jZd8BEQwDv0XPB8spHV94sM0kVpkNo
         kLXnRkq5NWdv7IrJugk0nfOtvEmSvWLglNZiHd9gj9sUg2/VkVFQPSSAxdWsv6xzqBUT
         IoMJVPGAVMtWEj/TwGv9tX+5ZzPz/mU5edg6TFzXtxGDV+EDqe7fjL8CQotZiyXl6TrA
         lGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5veAUhSS6Fz26qMprH/wcKOq7j9SHcNjy/OxtDgU18=;
        b=AbqChAWZUZYGSDZ/fV/BaNpvOe9f5Dv4fiOQMxH62KnbFx7yKBUtUnfhutdSf4JaQ4
         ozvNfBYoRczv4ZJtJVa5uvTgWiCbEOkZ7i6rTee8737+16YqvvXADABSFqxwxv0MufUy
         jq8TagketaRdZUwyX6xDeQorQ7ZCD2cP2ylBogZ1ZZqMr6/Ov2rbJbXIEDiOdMM4N1V0
         e6SV+OBSoiyoCEYpj0xnorwx+9mtTGRss+gNlqBso7bETCcB7V/5anlYjlyDviy2jKxq
         NRmB6qsxJ9+7hmCgo1VV5yM1YSila5u6WBp5GR6n2rC/ANOKK1WcANud/hiTvBBCqx4r
         fMrQ==
X-Gm-Message-State: AOAM5336aKe9UEkSQ7CL+C5zvnx2mQIuAFhcNnWjX8gbUrHmzDfb1hfq
        YJotnuKJ4lyIAo4SG/JRK8kJOw==
X-Google-Smtp-Source: ABdhPJz286lp8BRJWYf0CYMLqNmJOod7UzXekLsRaYeQsUYB9g/aG3ON62ct8biWttlwrCYtmaA77g==
X-Received: by 2002:a62:fc10:0:b029:1ef:141f:609 with SMTP id e16-20020a62fc100000b02901ef141f0609mr28684092pfh.78.1617099675662;
        Tue, 30 Mar 2021 03:21:15 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.21.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:21:15 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 04/15] mm: memcontrol: use lruvec_memcg in lruvec_holds_page_lru_lock
Date:   Tue, 30 Mar 2021 18:15:20 +0800
Message-Id: <20210330101531.82752-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have a helper lruvec_memcg() to get the memcg from lruvec, we
do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
lruvec_memcg() instead.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a35a22994cf7..6e3283828391 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -744,20 +744,20 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 	return mem_cgroup_lruvec(memcg, pgdat);
 }
 
+static inline struct mem_cgroup *lruvec_memcg(struct lruvec *lruvec);
+
 static inline bool lruvec_holds_page_lru_lock(struct page *page,
 					      struct lruvec *lruvec)
 {
 	pg_data_t *pgdat = page_pgdat(page);
 	const struct mem_cgroup *memcg;
-	struct mem_cgroup_per_node *mz;
 
 	if (mem_cgroup_disabled())
 		return lruvec == &pgdat->__lruvec;
 
-	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = page_memcg(page) ? : root_mem_cgroup;
 
-	return lruvec->pgdat == pgdat && mz->memcg == memcg;
+	return lruvec->pgdat == pgdat && lruvec_memcg(lruvec) == memcg;
 }
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
-- 
2.11.0

