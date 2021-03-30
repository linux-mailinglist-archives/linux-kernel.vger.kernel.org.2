Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307DC34E555
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhC3KVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhC3KV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:21:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA047C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:21:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h25so11404797pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XlrhlWJR5eNlgc0Go1Prosg77ePOmL9XygDOYDXK/A=;
        b=pvDGPRY/fpgSyM+8p66+cRR8V+TEw7yXpz6hylJ2TOHDCX/h1BX+s70mvfl1sceihz
         6RybxuB3YVqzfFlaLjiRueifOx11usygHge7HKzTGG5ErzbPF5GcDt8ZlSYjOUALa1ya
         ElMNWMeE9F53ruq0CC4Ln9+e6lwyh+53D5JG6d/IoYzVZIO5iRG9pso6hY/ZqEner/ns
         Ilrhg2IwnGmhWJwgJDglkFzaAdNPpvh5KG9tvYt8tibfsNzjmD5zkmTVQd8GbxmG/SjO
         gtV6tu0RZfuawBgGSu832rWw0EaOj/jj/pHnR3bRi1XRIED5esFL/JCvvGVz1doZUKhd
         cu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XlrhlWJR5eNlgc0Go1Prosg77ePOmL9XygDOYDXK/A=;
        b=oe4v5jpK0+lV24+yLBtJscOMi+h1xU2gy+nB73C2VmAYaevoWwmCRSGrhyw1EbywHG
         ztA6ZS2Z8aMqhGq+YoBigfjU78xOpBkmGZeVgHhG3zlPeScSP+E0OAji3fSmWMBsD9eJ
         2DuhPkmfxTKtvQaiZSivO37E96d9vkZPqdCfTXKK5Yd2IPik4Ga+hqt4bvREEjKLf6uB
         Eg8Q1+ILAesfrKqlybzFp9JD+Wdrs6GUWf9EDK7BvWTup9vo6wzFlgvKd7QZsV8US0UP
         TeRPjDka3RSJsxRB7z/pT8/UNLtkSFZaBaz76rriMVDEzSmK5YSNpUA2lrhFObvrnbxA
         fQZg==
X-Gm-Message-State: AOAM531f+moWG/MBytM0/f5SyRxMU6Re6yjUI0hfM6j/Sn/YXn9mXth5
        c8eW6T25tUqJcMo6kcdK/xdJ2w==
X-Google-Smtp-Source: ABdhPJzWM4NKDxc668yTzYqUP3ZuqGSp3kSwjeplcYCLk4ruq3hI+7jSjTn6delF4WVuCuZwBohCgg==
X-Received: by 2002:a63:fc58:: with SMTP id r24mr8111385pgk.368.1617099687301;
        Tue, 30 Mar 2021 03:21:27 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.21.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:21:27 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 05/15] mm: memcontrol: simplify the logic of objcg pinning memcg
Date:   Tue, 30 Mar 2021 18:15:21 +0800
Message-Id: <20210330101531.82752-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The obj_cgroup_release() and memcg_reparent_objcgs() are serialized by
the css_set_lock. We do not need to care about objcg->memcg being
released in the process of obj_cgroup_release(). So there is no need
to pin memcg before releasing objcg. Remove those pinning logic to
simplfy the code.

There are only two places that modifies the objcg->memcg. One is the
initialization to objcg->memcg in the memcg_online_kmem(), another
is objcgs reparenting in the memcg_reparent_objcgs(). It is also
impossible for the two to run in parallel. So xchg() is unnecessary
and it is enough to use WRITE_ONCE().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 405c9642aac0..fdabe12e9df0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,7 +261,6 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
 	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
-	struct mem_cgroup *memcg;
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
 	unsigned long flags;
@@ -291,11 +290,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
 	spin_lock_irqsave(&css_set_lock, flags);
-	memcg = obj_cgroup_memcg(objcg);
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 	list_del(&objcg->list);
-	mem_cgroup_put(memcg);
 	spin_unlock_irqrestore(&css_set_lock, flags);
 
 	percpu_ref_exit(ref);
@@ -330,17 +327,14 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 
 	spin_lock_irq(&css_set_lock);
 
-	/* Move active objcg to the parent's list */
-	xchg(&objcg->memcg, parent);
-	css_get(&parent->css);
-	list_add(&objcg->list, &parent->objcg_list);
+	/* 1) Ready to reparent active objcg. */
+	list_add(&objcg->list, &memcg->objcg_list);
 
-	/* Move already reparented objcgs to the parent's list */
-	list_for_each_entry(iter, &memcg->objcg_list, list) {
-		css_get(&parent->css);
-		xchg(&iter->memcg, parent);
-		css_put(&memcg->css);
-	}
+	/* 2) Reparent active objcg and already reparented objcgs to parent. */
+	list_for_each_entry(iter, &memcg->objcg_list, list)
+		WRITE_ONCE(iter->memcg, parent);
+
+	/* 3) Move already reparented objcgs to the parent's list */
 	list_splice(&memcg->objcg_list, &parent->objcg_list);
 
 	spin_unlock_irq(&css_set_lock);
-- 
2.11.0

