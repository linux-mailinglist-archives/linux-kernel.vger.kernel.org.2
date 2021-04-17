Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD620362DB6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhDQEif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhDQEie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:38:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74092C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 20so11050840pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NE/BcoGMuqPyqQGyjWQGMTxC1WpQbz3TqD3QbwUvSZY=;
        b=HCYBSuWL5lNSfyR1c5D+bsBKj9KEfSpvl6qC9ksYnjL148APwpW4TAUtqKdnJ7pC7A
         TcpivOKDUXNMLR3P+FWv0R6KBx0FXOHEtaFTOTJjSlGGMEKxleb0kqY6b+3DAzr/+qMO
         yUn6B0VTyigbyVwQw5NZ3llxK3JzpPsR4mNmCT8d1ttTFw24RIUEdIoPxa7Hr+KPWBxb
         P8YHj4MA8iPuorRIuQPnQgP4eCAw+CDbYwkVLDQxwWWIhoiTTe8bIpNqwVa1ED87nl6A
         fW/wJXy4jF0w1hZj+aZIv7N5SUCY68+4Hz3w1OYGvkhz307Khf9vrRxWNo24RfqfKG8A
         gaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NE/BcoGMuqPyqQGyjWQGMTxC1WpQbz3TqD3QbwUvSZY=;
        b=fqaA+gfwBfLavCuqCA3eVzynLMppniRlew8jeYLO1YX8/9+hOIkItiirhCJfLW5Mrq
         BktJUi4x5d7qpvtoLy1Fx05sRt7V0hEupZ42vHA2eTzClJVwDA2H5kikC2Ou5UznLIKM
         utwqxjFHF5HWdGJNLMY5t9ViwUv5A8vv5bl1LFv2u0qI9KUOh7q3wVuo7oV+KI8dWkUz
         PRi88wVQpgSrSwZcgP2rtFJ3S8P/RJ/oxb6YstCGUXSBoby2fZfYBpp/rKG+7dOT49zO
         WL6yJ7lgC9cPVQAjq07uauVl7wOEBGfR/sqWTOmtsZkNnPjp9iNBmBS0bIrcn27tii5I
         nzNw==
X-Gm-Message-State: AOAM530hZqv0BKbw3rP95IfI1+lLrs+M9HtRN9TX7riQvBw6LaV/6GQ2
        5Rhc36hv2Pu0EImtCbNTLgDxoFDfrXFfBw==
X-Google-Smtp-Source: ABdhPJzWa9DWpbE9nY7cRes3aa7lKCkPT7KXRZi0kgxvIDJ4A4qJBPj3gK6804vLQ/irrw+KbLogpQ==
X-Received: by 2002:a17:902:cec4:b029:e9:58eb:562b with SMTP id d4-20020a170902cec4b02900e958eb562bmr12659796plg.63.1618634288058;
        Fri, 16 Apr 2021 21:38:08 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id w21sm7064775pjy.21.2021.04.16.21.38.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 21:38:07 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 2/8] mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
Date:   Sat, 17 Apr 2021 12:35:32 +0800
Message-Id: <20210417043538.9793-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210417043538.9793-1-songmuchun@bytedance.com>
References: <20210417043538.9793-1-songmuchun@bytedance.com>
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

