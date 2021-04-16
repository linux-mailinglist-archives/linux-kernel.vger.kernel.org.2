Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD9361920
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbhDPFQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDPFQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:16:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B03C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:15:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so15689395pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NE/BcoGMuqPyqQGyjWQGMTxC1WpQbz3TqD3QbwUvSZY=;
        b=x3mRR8adpG+SIPQvbajyUHRAzVYGQ9kXgMEs7JE0sm5iBBYsM7za2rneJ2x+zx7Alm
         nvjA0ySFpVE0MWfbuJUl+trTsqrxpnkGXWgmQ1htfWCvNWccRgTDGYGaEs7Feyw4sZ41
         Nyo0Z2ol/a0h+wdqzCXC58YJtzlmXejXT0oumYu+JvdMKtxzxN6FdzbxwmbUg8/S9Eap
         H4ZZve05NA7mvYp2zP0e740L9pte8vGxHJ68iJKbrfp6Xk5BJVu0G0bgdZWFZhcNG0MR
         WAdfx26I8k/nlMtz6X2Uhe00xyCK4COeU4jU9z0DBaM4bXqoCGlrnT/S13+W2n51u6bb
         wnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NE/BcoGMuqPyqQGyjWQGMTxC1WpQbz3TqD3QbwUvSZY=;
        b=AAXu5jlpKBFwlHjFpuk3Xw+5Ys0Zh+k9veAlsOfBIYQxPb+HAlwSTz5gX+ELtmnuhQ
         HeeMVWVUs01Yv8av9K8uYsoeS7q3+Hh+qmVY9IEiNf5EcJMkYrPJh8Oqh1+XttjXxG6f
         6P7DlzzGwZKk0WyWfcr2Wsx2pGEavH6OYyknVSdVeaSc5F+Agt2vjHy4HFH+LYWZlPW2
         XCHMinT3n4X6HPu6YZK4XXMvVYjVrXVSQXhuWkDjlS9WkylBBFHKlOTzhxR0DJ2F8sJF
         0ZTAAoE4Lrzje/+MgDl0833er/dEMPB+DxTJodM1yD3M3L/ReYuuAaSEK8zEMLt+NJF4
         VVZw==
X-Gm-Message-State: AOAM5310X/bHMepcPz7STX7Z81t3BAmmJZjJTeSu/BpCFh35jDwvA5Oo
        eONGG+REYNwOK+rgQZOFC/MRkg==
X-Google-Smtp-Source: ABdhPJyRUkfUK1Gz4fhB+MEe5DNop4sWVG+HsPBKJEMPEQLpoPtCsMG3b1+SKM+CihVIFoRzjH8IfQ==
X-Received: by 2002:a17:90a:9405:: with SMTP id r5mr8098835pjo.139.1618550148926;
        Thu, 15 Apr 2021 22:15:48 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id j7sm3518540pfd.129.2021.04.15.22.15.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 22:15:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 2/8] mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
Date:   Fri, 16 Apr 2021 13:14:01 +0800
Message-Id: <20210416051407.54878-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210416051407.54878-1-songmuchun@bytedance.com>
References: <20210416051407.54878-1-songmuchun@bytedance.com>
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
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f229de925aa5..50e3cf1e263e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -901,20 +901,23 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	if (mem_cgroup_disabled())
 		return NULL;
 
+	/*
+	 * Page cache insertions can happen without an
+	 * actual mm context, e.g. during disk probing
+	 * on boot, loopback IO, acct() writes etc.
+	 *
+	 * No need to css_get on root memcg as the reference
+	 * counting is disabled on the root level in the
+	 * cgroup core. See CSS_NO_REF.
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

