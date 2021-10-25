Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F874396A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhJYMvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhJYMvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:51:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543EEC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:49:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id l203so5927669pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIr8TomifRdQW16cNm3Q1S6jeoHh7jjuLXp8SgxNC3Y=;
        b=w5Ov8eXqr5SfV+1QU3TsW2v2ae2rpirSISokBufoFLDgfs9c/z/0gDTtdhMqiTW5VY
         7uO7dTx6QKMO1kxEgMRyaMMqt71sw46H/wp3h4SSWw+eWsEvxKMD1hKSIROiQWdxlZqJ
         4GbSvqclvaSanWXYug8s+xPpZ3V4Gs+8nIs/oeSt3YWkK/bMEyyqJ2vt7J705UJCVY86
         IwTzw57CIKwZ3zjc/lXEN1VTO3/sg2v1wVel2S3NI9LnI5mRtxNRIc1ZmCLvjL2s6pvT
         hAWmKv6tleunXzlyeSVYW8gqftGdrtF2CqMo8gp/e13wrHqeTMVyko0WzHOlHzoGLY0i
         lvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIr8TomifRdQW16cNm3Q1S6jeoHh7jjuLXp8SgxNC3Y=;
        b=vScl0W2whDVYwxvfrVngY2JtVHKhvYd5w2enNa45VslqQzWiYkuW23eU6FlEX+pMDh
         rSdeLYwbds8QgIaB6CeK87F92aoUd9lLIED8esFigiUzzDG6H+0SfoJKsUUziN94EZdk
         ut9dxExrNm9UseB13I3jJZkCHcXZkCDjHJd9rQmnfln+paQIDgXwrhnPUkcECjMz4qi0
         9L/tQOo4tK4CyQW0G8Acp4o4nC0SkLFDdVtXQQK9qmdl59kwZfMmn2CM85tytE5wFpTa
         0z7gUN+MrGqn9TL4IVoIMMMBj/pKiAlUVFU7o6jA+x/YQ9CY4Jfy/Okd3cfb5kZaHDYR
         ablA==
X-Gm-Message-State: AOAM530zUMzhad81PSvxd2EKe0qzS2H1tkV7G8Kz8yisggGaxaeRNEVg
        9xWYjb/VT5u8riC7KHmfj08TBw==
X-Google-Smtp-Source: ABdhPJyLSFlTt23w1TIfAXTikh48BynT+U/IuIHjJ1vsDBQHj8P9zBC0euacHFnvryGFEcsSrTvHag==
X-Received: by 2002:a05:6a00:15c9:b0:44c:a998:b50d with SMTP id o9-20020a056a0015c900b0044ca998b50dmr18486801pfu.49.1635166164762;
        Mon, 25 Oct 2021 05:49:24 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id pg17sm5284577pjb.8.2021.10.25.05.49.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 05:49:24 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, mhocko@kernel.org, shakeelb@google.com,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: list_lru: fix the return value of list_lru_count_one()
Date:   Mon, 25 Oct 2021 20:49:10 +0800
Message-Id: <20211025124910.56433-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2788cf0c401c ("memcg: reparent list_lrus and free
kmemcg_id on css offline"), ->nr_items can be negative during
memory cgroup reparenting. In this case, list_lru_count_one()
will return an unusual and huge value, which can surprise
users. At least for now it hasn’t affected any users. But it
is better to let list_lru_count_ont() returns zero when ->nr_items
is negative.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index a6031f1c5bd7..2bba1cd68bb3 100644
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

