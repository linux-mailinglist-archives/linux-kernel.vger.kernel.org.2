Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9B635D867
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245276AbhDMG7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbhDMG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:58:30 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239EEC06134A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id p12so11252966pgj.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtjjYxy6fbQMjrzo3+4P30oz5j5AuPoBCZ8FaKjHWIE=;
        b=y1rkSqiViCIp3wTOZ5QlJPLXK+Id87VZYWjp1ZyjjVXGVoEX1B6l280oeHYcRpB1KY
         9ESkPxUcqthFMWeaWmpwBsPAs3AcKDJrYuUE9hbn1eTCht6iIiiMtfmCcApQBtZCaikL
         5dqWFDHSIebonXesBLGxJVCC/6inWWBnQ4RI/iagNc9h3ODaXBWPgo9+IvWilMCTYrpe
         iQNvJUteDMc1T/AO22JtRuTo36GFapFcy5LB2fzqZTqtpysOxnQsFFqjKSt5VJlECY+I
         1pI6Cizi6IduIfyUxUUxlQRg9UqWAuAupLaQsD8V9H8d8Ra3B1qX4jDQpnVQsFnvvMnT
         yZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtjjYxy6fbQMjrzo3+4P30oz5j5AuPoBCZ8FaKjHWIE=;
        b=DRFC6QZdMopmBPFv8HJ+L5pNxlxFD0OXvRIeu4GJhgy5ZyzK62O9BN2ekUMForH99n
         s9cbdkSlp84D/x4HJrFSqEsK4i1J3q8FryWqmoACA2ieb7GYXsPjEPE5lcIeBJdN888k
         Gfwe/lyA7T1yDXE7Jfd1s9q/tahtmRqcioNLHI86juAgWIaRSOhKinW4/7WsQOBTOjlT
         Er3qnwpgHQ87uk8OPeaCQIImlPF3vHGiCGWY1IPOt60xo6mJJTd+XfI0SLuWDmvCtOtu
         Fh6ZkrKFcR7B9Qf0iCuwrXHv4E5I0gX8BWyk1R4y9kvJ3oVqa8z1pUyUIKydcdq2r4dX
         Zzrw==
X-Gm-Message-State: AOAM5305wR5i/9UY/YuedCX5y5Kap2zM8Hpl+VRgbR8wId0fCHUTxBju
        3blE7OSYt/aUf8DZIEE7hvwn9A==
X-Google-Smtp-Source: ABdhPJy7qTBayD0MjKH9mpcq9ysXSWq3mVkOTjl13qDTm/tP1B8q6Px9uYLgupMSHVay7ks/UL7ooQ==
X-Received: by 2002:a62:7b0e:0:b029:24c:3d81:8028 with SMTP id w14-20020a627b0e0000b029024c3d818028mr9200627pfc.58.1618297064697;
        Mon, 12 Apr 2021 23:57:44 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 78sm11508562pfu.40.2021.04.12.23.57.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 23:57:44 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/7] mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
Date:   Tue, 13 Apr 2021 14:51:48 +0800
Message-Id: <20210413065153.63431-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210413065153.63431-1-songmuchun@bytedance.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
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

