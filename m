Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A203BC202
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhGERI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGERI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:08:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B79C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 10:05:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s18so3691881ljg.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YgGY083lvLVDzanfWlQ0rK3bjJx/pViz/NxffbwtZEQ=;
        b=dBFd5kkN5R/6BKe/bT+G6lO1i/6O5lC1M2dHb+86aXA/WXTYGQb6mBc3jetstUJQnm
         HXbWE5fWg3chcW44p0hQVeqQaFYNba7Bu5jYXfoTQJ+Sb0uvr/Tz0iCY3zHU6FKfVK1F
         WAsVdYzyzp+Wg/yekGnJXyDYW7bjliIGD8bUNSz4dgPjFeuA8/pyigatlDWXSQqN/1SX
         pf545g8syC+9gVQ+Xb++b/vT+AUytIT1bWfmsyfArGktScQSKysISgu63acfNQcl3WF+
         1DYXueqii2NRqNJW60hBN+btFonBeKqfy0VMfH6dKXd/90tQhCSXqcQ8S/jEQIhn3xsZ
         8Ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YgGY083lvLVDzanfWlQ0rK3bjJx/pViz/NxffbwtZEQ=;
        b=RHwEUb3Pm5bLhwn639dH3vX1MRZUuHHeliHepX+dd/uGVoQ2wy64kuIJvMksTSjeSu
         5J8Uqoh4l6hQOsjuVg0iXvJslE/wpNyxd+MTt7vJBjDhLIMnwop3bxwHP/M0zm+3f+Bj
         eCJFYrRitU2W6LnOsOZFPvYew23fcHnHMQK1RWdtZ1JxcKVwFxT6Yum/gPF+L9bEzj4m
         8uBPa/PfrsrCT+FclWoj9xvKlxIVhuKmqOaSFmaSr2LGzwj1Ea93pzeUq3zPEfy0SFGu
         SUl4d0VNKz2Z0JjokPap16q23QKYGZHHh9p9bbLxqjLPoovzk3X7xl20mF1JmR6xNQcN
         7GEg==
X-Gm-Message-State: AOAM533yZaoF3PH5Dny5izixYg/aFyJ1wSS9bEZRDVsPJap9gSghnzTH
        B57em/vVIaTnLaiAK1HXxoc=
X-Google-Smtp-Source: ABdhPJzj6R5GWsoGGDqn94UDvOZjb4i7iVY2GUrrj6lsJ5Pv6ar+475lKDyzdWG/6FUM0YFcm4Qa6A==
X-Received: by 2002:a2e:7210:: with SMTP id n16mr4930887ljc.8.1625504747828;
        Mon, 05 Jul 2021 10:05:47 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id k12sm578501lfv.14.2021.07.05.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 10:05:47 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 2/2] mm/vmalloc: Remove gfpflags_allow_blocking() check
Date:   Mon,  5 Jul 2021 19:05:37 +0200
Message-Id: <20210705170537.43060-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210705170537.43060-1-urezki@gmail.com>
References: <20210705170537.43060-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of gfpflags_allow_blocking() check from the vmalloc() path
as it is supposed to be sleepable anyway. Thus remove it from the
alloc_vmap_area() as well as from the vm_area_alloc_pages().

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5297958ac7c5..93a9cbdba905 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1479,6 +1479,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				int node, gfp_t gfp_mask)
 {
 	struct vmap_area *va;
+	unsigned long freed;
 	unsigned long addr;
 	int purged = 0;
 	int ret;
@@ -1542,13 +1543,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		goto retry;
 	}
 
-	if (gfpflags_allow_blocking(gfp_mask)) {
-		unsigned long freed = 0;
-		blocking_notifier_call_chain(&vmap_notify_list, 0, &freed);
-		if (freed > 0) {
-			purged = 0;
-			goto retry;
-		}
+	freed = 0;
+	blocking_notifier_call_chain(&vmap_notify_list, 0, &freed);
+
+	if (freed > 0) {
+		purged = 0;
+		goto retry;
 	}
 
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
@@ -2834,9 +2834,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		for (i = 0; i < (1U << order); i++)
 			pages[nr_allocated + i] = page + i;
 
-		if (gfpflags_allow_blocking(gfp))
-			cond_resched();
-
+		cond_resched();
 		nr_allocated += 1U << order;
 	}
 
-- 
2.20.1

