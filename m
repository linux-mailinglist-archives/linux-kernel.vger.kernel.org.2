Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A703834E550
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhC3KVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhC3KUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:20:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:20:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bt4so7494747pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vv0fgzpNtXFXrGhCyirhwBALxnuEbM4AMJFXSO3pFg=;
        b=2HE2ueFDVsGNMUAshabKdYu6Q3JHI1+rwf/EjY6KNcooThpqp06667KERB5xeYj/Lv
         GKc9jxRp30VUTisgvgoI67Z44ogXJZ/Mv5yCBV0rVx4MNf2y4hJ4biP0NmLf/EtfsNxE
         dLGkGb6tKysZ4cCYyuqqpMRMLJvR7U3mBCmsiSSedZfBZAl3U6DWs4kgRRDsqyNOkR6z
         jtrTjwkggHL5mjhKf/TsrMseR3AAeR9F/fDhk8zttbLlsW9tSS73wK9brfDm0W/VVw0X
         200tz++gF9wQiPmBk7xQGV9c/lh/nbTi8UXEcpOmVZVkyCNRpJDrSV2TgGjHKkH3CzSA
         a9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vv0fgzpNtXFXrGhCyirhwBALxnuEbM4AMJFXSO3pFg=;
        b=sqB6cG82GQhrw3Vb1GX0Lwf4qLitIXBiw0T6twefMWuJJ0bPm5pEmhnjdev+jS1QrL
         r9F++zLagYqDEqvdqxdul/ODPMIRWbBIBVmj6h/Jawb5rYaQ7O+UEoewUSDP6vpwGkfU
         GALzWbudtAd29SX8GcJUh4vZLVm3XzciZ6GevdS7pm8L1HMrvGXdf1CoEapKw7ks8mS3
         mPul4218VYC6Djkqd/vjMJAT4ObfXufICQM397ubKbFp16BxCRPOGblBJahkpNz8S3O0
         oNy0Nzh8Wn91ahP9FZrgzuesa+HvZFRwS8IHy8b9J5F9xUx2fOn/wH3vIwmH5x9VibaW
         NIZA==
X-Gm-Message-State: AOAM531T3joO97sajhhJpYprBxWSzQv6au4PhEyPSmq19/dYR//HRpZF
        f0eWfy1C1iVpYbL/YpSRtx4HTg==
X-Google-Smtp-Source: ABdhPJyi8G/6wIWqYCU0GDx98hfZpDTpTad1jbbdH67t8tYd2VN4fJf09V0yhNqEvksyMvsfulZZhA==
X-Received: by 2002:a17:90a:3b0e:: with SMTP id d14mr3659046pjc.198.1617099654608;
        Tue, 30 Mar 2021 03:20:54 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.20.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:20:54 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 02/15] mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
Date:   Tue, 30 Mar 2021 18:15:18 +0800
Message-Id: <20210330101531.82752-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mm is NULL, we do not need to hold rcu lock and call css_tryget for
the root memcg. And we also do not need to check !mm in every loop of
while. So bail out early when !mm.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d0c4f6e91e17..48e4c20bf115 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1029,20 +1029,19 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	if (mem_cgroup_disabled())
 		return NULL;
 
+	/*
+	 * Page cache insertions can happen withou an
+	 * actual mm context, e.g. during disk probing
+	 * on boot, loopback IO, acct() writes etc.
+	 */
+	if (unlikely(!mm))
+		return root_mem_cgroup;
+
 	rcu_read_lock();
 	do {
-		/*
-		 * Page cache insertions can happen withou an
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

