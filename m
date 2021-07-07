Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1B3BEEA7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhGGS3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhGGS3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:29:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0247C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 11:26:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n14so6374026lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6Vax0DZu9/zEQ4mflRZs+GdOJbUoHKXVBfPpmObW7I=;
        b=YIFRQ16FXMx0sQBcdwP32kzHeP0LQNsMfY8IGc97+L4Y+m1GDhg1ri8h0SdC++tr7o
         Ui8VC7iKByCW95AM/dNs014Al/3sjoCpavddUwBWRHws7s2DbDBjfMkEQ4PcEt2YtcaZ
         BFSioQbqrPYX6gbbzCAqaT2B5hOCfb68Zp2T79/xKZPDp5h7rklJlompyZvqIM/cCu8v
         SE/aSZf7mhYvCOEgFXxR9L3VZfPMnuNESoKv10cPb4oMYGp5aTvXFQAbavnd95UB0iUV
         9qWGg/GIeeIyggjI+Bk6QYjt5bNfxxQs0W2ehzjRlz5d+Vkurs36sHhC/lul6eKe4LVv
         s7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6Vax0DZu9/zEQ4mflRZs+GdOJbUoHKXVBfPpmObW7I=;
        b=jloBfPxsaxCIRhjfgGLljQFP/G2Hrm9cS1PrIS4Q5HDqRiOfLPJXZY7OIxFtLIW6x8
         4l2ppZzcqyZdeTOoP9IZ6TN0thIkRZZmgY2ABbGDuWd96kbJ0+qym/YPWdZOQSuiaIAH
         jlTKIPfrYieHtnla+iA+/DyU2nsnA+5AcBgGWiSSyd+GHRKeVudAYS8nZSmilfNEo4yu
         RSUCUYA80rCTyUCBL68mfDKXLCoRswQZDmQ8NABtSCmtfTzF+hxfTzYkh3qzYAyI8V5D
         nQVzsrAwg+C1yiWSiDPxVMdRR2J55rmold8aKcgPnR9alS6B9ZlGJoiHyb9c9sWxBrnt
         1VZQ==
X-Gm-Message-State: AOAM533V1InjPW6eEC59TBomG/KRhk9u6RnU0X/HnBdsm20IsSXQPbZS
        URwmyggo6k9/YkIkqutFx7c=
X-Google-Smtp-Source: ABdhPJx9hsrdrNlNEmLWV6Fz2OG1hxARu0l4TtmFtTJMTyEIgiF9MFsRvCKK/sE784T3sMhyBOgT3A==
X-Received: by 2002:a05:6512:2629:: with SMTP id bt41mr19591460lfb.95.1625682410291;
        Wed, 07 Jul 2021 11:26:50 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id o15sm1767963lfu.134.2021.07.07.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:26:49 -0700 (PDT)
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
Subject: [PATCH v3 2/2] mm/vmalloc: Remove gfpflags_allow_blocking() check
Date:   Wed,  7 Jul 2021 20:26:39 +0200
Message-Id: <20210707182639.31282-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210707182639.31282-1-urezki@gmail.com>
References: <20210707182639.31282-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of gfpflags_allow_blocking() check from the vmalloc() path
as it is supposed to be sleepable anyway. Thus remove it from the
alloc_vmap_area() as well as from the vm_area_alloc_pages().

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a9a6d28c8baa..24a3955d5a36 100644
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

