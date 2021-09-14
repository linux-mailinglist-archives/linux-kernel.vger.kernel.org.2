Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A5040A778
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbhINHe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbhINHeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:34:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669DBC061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w7so11899397pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWCb9mX5Tccbd9CST9przEKxw+x/XOfn2zfVE9J87jE=;
        b=gt93lYs0v6WgNM7WwrP6n5fC0cnWuhYjHWP5ts7TA1kWd1STI2P9UTp4wCFszZaY6P
         DN/+6d4qFvixYVGP/2yCdaPcxRIQRH8Ecy+RtUMRiTQVSfp3Et36RMJoZR1xY5uYiJ5k
         iSjuu8vqQxPjxQOBCFMFMCwR7CnjUTGY8CgeeEc6s1nhstrlQG/Y94OeeAro0vR8WnFz
         Yj0gns/NpEwYPxjKuWKEeRQStLOT6m3DoutxVOgqLtU60JHoAq5mco39Y0lDHVWYwgt1
         sHwPDxp+ast9TcqJP+owH12ttPCvkChcWwxVCaskkOLiZHhgoRAqYd+PKDjF7rrjxWRJ
         00tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWCb9mX5Tccbd9CST9przEKxw+x/XOfn2zfVE9J87jE=;
        b=JOmv4Xok13B9fjlZYLAtk3mjKfjLoqiwSNkPjBdzthVklI0HtWwshKFCmEnKApXFjX
         t16j8aYvi17H4PQ08mSne+wI1K2d1YWSXkmHm/tCWLB+RG0eU9HDsG+DCJZuzB5miht4
         8M6lVUEBFg3l5I4s+SBENFq+RAzURlnouvM7qF8rz8BRrQXziYIjzPnhaKh/NcniOr3w
         C3Y3fOiuIiPAYTfCkPKtCqLhOM6Q1YLtdYPrk6kSyQpIEPnpBdSmN2gaYXd80pHCRERZ
         CVY530wheXff4f2Q13CauzqCMRwzlPSknua/XVhKiP6jcOtru3sIPyjk0YMXHf9KRNty
         p7ew==
X-Gm-Message-State: AOAM530IhX7rmjmZaBO9wAB1MybxyVXRoMpG+oiHAyY9NVKRtoEa9/Pl
        V4F8q3YF51m7/MJCyr4ArIjkOA==
X-Google-Smtp-Source: ABdhPJxskCh3uAqwW44HafdpZET2ZOfsNGGneakGYVgU3YZLmwPaFGYlMvKICArQQ4Dg52CAuCfOiQ==
X-Received: by 2002:a63:4344:: with SMTP id q65mr14370885pga.364.1631604782954;
        Tue, 14 Sep 2021 00:33:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.32.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 01/76] mm: list_lru: fix the return value of list_lru_count_one()
Date:   Tue, 14 Sep 2021 15:28:23 +0800
Message-Id: <20210914072938.6440-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2788cf0c401c ("memcg: reparent list_lrus and free kmemcg_id
on css offline"), ->nr_items can be negative during memory cgroup reparenting.
In this case, list_lru_count_one() returns an unusual and huge value, which
will surprise users. So let it returns zero when ->nr_items is negative.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index cd58790d0fb3..4962d48d4410 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -176,13 +176,16 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
-	unsigned long count;
+	long count;
 
 	rcu_read_lock();
 	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
 	count = READ_ONCE(l->nr_items);
 	rcu_read_unlock();
 
+	if (unlikely(count < 0))
+		count = 0;
+
 	return count;
 }
 EXPORT_SYMBOL_GPL(list_lru_count_one);
-- 
2.11.0

