Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67528359EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhDIMcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDIMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:32:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4333EC061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:32:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso3113710pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4a9s9eaaqji3vjC/5YOcby1VxJlho+mBaQ9dB0G314=;
        b=hxZly7/E5IKIeIk6u/EZCEyIoZ/xMYLvSN8rF8942v1a/+cwKmYifDXgBLVJKTj1Yz
         bpm5VsIWOcAU6I3tPtaofuBvT1HgIAsy26FDVfyheNOij9bcP4XLantQoaBp1IFNolOS
         zC92u44wbSgqqNgc3ljNUsqbqJVBA1NlDiwUZeaouYqD/Aoj4a24QBBz5o0/6o4MSXu/
         8ojwfYriBdUqDqEq3TbLXQQ3yIQnPoPXD/YYXaycOoMmVNgvC9hfAHsKB6aNYHo00rGo
         F2urOomjz+EwEnaZJgiTJLdM1ptrfPAqKst4fUI4fyx2KV+gnkUpaRaEzG0UtiHKGzWG
         3qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4a9s9eaaqji3vjC/5YOcby1VxJlho+mBaQ9dB0G314=;
        b=D360RaWOeTm/2y226Nq/V6Ws+LnpmTPZAmyEvHZtAave50dtDtnNYS/NImcyaiEGSQ
         uIyxRzJNzbh82PjC6TpoFYxSUW/m4dCee3UdNQy6H/V6zxn7WuLN2LbDTNOzd2PBH69l
         IzvAbg/mDmbadRxjEwq3OCAk+GcrOu7EPh/PU5gWjaN46auWBCWyV5oE5R0WCZ5CLlf5
         wGNCGUg2lHxO4pT8gkOjklSNEEDzAzKLMl2TWB0ridDL2+tx7C0wVBd5937f9RWd9SXk
         ibuyjP0BZW5c0I94R3GrSDSyHPpaN2x5UCMRQxwthJ7wwSpfmE4kdTQKtnG3xD1vstV7
         Fi4A==
X-Gm-Message-State: AOAM532YQWcN+OuId0x2zwKOUDh7Wiqn9n3n62J8Ca1t/msC9Y3c7j9g
        S5GtypgLjHCNvXOrilPkaOV0KA==
X-Google-Smtp-Source: ABdhPJxUTMey7XOyvG1I+G4Ben3Ww5Kwa5QoiZhplW2u/vumLA6YeXi0uVU8sX4JsFQHGC5wctmeOw==
X-Received: by 2002:a17:90a:4498:: with SMTP id t24mr13735310pjg.78.1617971523836;
        Fri, 09 Apr 2021 05:32:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.31.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:32:03 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 02/18] mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
Date:   Fri,  9 Apr 2021 20:29:43 +0800
Message-Id: <20210409122959.82264-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mm is NULL, we do not need to hold rcu lock and call css_tryget for
the root memcg. And we also do not need to check !mm in every loop of
while. So bail out early when !mm.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f229de925aa5..9cbfff59b171 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -901,20 +901,19 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	if (mem_cgroup_disabled())
 		return NULL;
 
+	/*
+	 * Page cache insertions can happen without an
+	 * actual mm context, e.g. during disk probing
+	 * on boot, loopback IO, acct() writes etc.
+	 */
+	if (unlikely(!mm))
+		return root_mem_cgroup;
+
 	rcu_read_lock();
 	do {
-		/*
-		 * Page cache insertions can happen without an
-		 * actual mm context, e.g. during disk probing
-		 * on boot, loopback IO, acct() writes etc.
-		 */
-		if (unlikely(!mm))
+		memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+		if (unlikely(!memcg))
 			memcg = root_mem_cgroup;
-		else {
-			memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
-			if (unlikely(!memcg))
-				memcg = root_mem_cgroup;
-		}
 	} while (!css_tryget(&memcg->css));
 	rcu_read_unlock();
 	return memcg;
-- 
2.11.0

