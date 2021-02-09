Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52C93146CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBIDGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:06:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230318AbhBIDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612839756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tR/UuXaqBaROltUbV2RDYpoyLXOK1N4qjZ6UzYcMHb0=;
        b=eygfmraVcggz6cjWuRjIfViVhoGglkjOU4whRyEIpmohAAI3wVdJDRCunOt+X+t45nyPCN
        tmDdfulWVL+UXXBaZrBihTYU6sj22uXvFJJIlWD+gVb2bXtMJg9AchIStLuVM/IcxCIhJp
        UHN919Bg9+wZ6hP4xDJQxjE2Acd/RDA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-ZiYxE_K-NZWzzq-cHJFZbw-1; Mon, 08 Feb 2021 22:02:34 -0500
X-MC-Unique: ZiYxE_K-NZWzzq-cHJFZbw-1
Received: by mail-qk1-f198.google.com with SMTP id 124so2012267qkg.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 19:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tR/UuXaqBaROltUbV2RDYpoyLXOK1N4qjZ6UzYcMHb0=;
        b=rfeBKZPZv7e+uSYvjab09ZHi4DMtCKQt0R12ebJihq0pbvtXi1CmVi9Xy7M7vXu+lG
         ll1+onZx580MLxY7s7qDGd196DDY36IS7nDootw+ta2nbT+402YAeEAM5DQLDUaEMHyl
         LqejBmh5jjozlzrS3+B22lZTL5i+6KJivKXWqBPX0KFKeYCj4gN6EiB0haWt981AdlKV
         BUlyM/MoSN2+T5vPyZe/fnan7rPWxG+ARdIYiXZOhUbkmoZpIYVWp6JPI11lGNi8uGvA
         yHix+2jvYEQ00RuJ1L3307Pf0WNqVQOKKeY1nrrWUg3rp/vHd0kXEU985Wb756E04UJ/
         c4+w==
X-Gm-Message-State: AOAM5303UKz4tmeCeXTvUhhqmdMNHj7oJr1In/MyJNjql0i/LzU3rkPc
        cFAr8Hl0xJfV7LZBZv4zkKd7o8ES8USo228W7regoz37SuKJw1KxKQRothPUg+it7uJ0+byjJis
        oBx6NC24Znyu93K9m/MQ+3bDY
X-Received: by 2002:a0c:a905:: with SMTP id y5mr19341915qva.55.1612839754083;
        Mon, 08 Feb 2021 19:02:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLHspfWpI6dEM2H1FKYzO8yoaXtFXKAxy9ewDvI5IRLUI759Dc6OnoCgk4yPZj+ynYz1yRpQ==
X-Received: by 2002:a0c:a905:: with SMTP id y5mr19341901qva.55.1612839753827;
        Mon, 08 Feb 2021 19:02:33 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z20sm17078830qki.93.2021.02.08.19.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 19:02:33 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirill Shutemov <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        peterx@redhat.com, Jan Kara <jack@suse.cz>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 1/5] hugetlb: Dedup the code to add a new file_region
Date:   Mon,  8 Feb 2021 22:02:25 -0500
Message-Id: <20210209030229.84991-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209030229.84991-1-peterx@redhat.com>
References: <20210209030229.84991-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce hugetlb_resv_map_add() helper to add a new file_region rather than
duplication the similar code twice in add_reservation_in_range().

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 51 +++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6ef278ecf7ff..ec8e29c805fe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -331,6 +331,24 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 	}
 }
 
+static inline long
+hugetlb_resv_map_add(struct resv_map *map, struct file_region *rg, long from,
+		     long to, struct hstate *h, struct hugetlb_cgroup *cg,
+		     long *regions_needed)
+{
+	struct file_region *nrg;
+
+	if (!regions_needed) {
+		nrg = get_file_region_entry_from_cache(map, from, to);
+		record_hugetlb_cgroup_uncharge_info(cg, h, map, nrg);
+		list_add(&nrg->link, rg->link.prev);
+		coalesce_file_region(map, nrg);
+	} else
+		*regions_needed += 1;
+
+	return to - from;
+}
+
 /*
  * Must be called with resv->lock held.
  *
@@ -346,7 +364,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	long add = 0;
 	struct list_head *head = &resv->regions;
 	long last_accounted_offset = f;
-	struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
+	struct file_region *rg = NULL, *trg = NULL;
 
 	if (regions_needed)
 		*regions_needed = 0;
@@ -375,18 +393,11 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		/* Add an entry for last_accounted_offset -> rg->from, and
 		 * update last_accounted_offset.
 		 */
-		if (rg->from > last_accounted_offset) {
-			add += rg->from - last_accounted_offset;
-			if (!regions_needed) {
-				nrg = get_file_region_entry_from_cache(
-					resv, last_accounted_offset, rg->from);
-				record_hugetlb_cgroup_uncharge_info(h_cg, h,
-								    resv, nrg);
-				list_add(&nrg->link, rg->link.prev);
-				coalesce_file_region(resv, nrg);
-			} else
-				*regions_needed += 1;
-		}
+		if (rg->from > last_accounted_offset)
+			add += hugetlb_resv_map_add(resv, rg,
+						    last_accounted_offset,
+						    rg->from, h, h_cg,
+						    regions_needed);
 
 		last_accounted_offset = rg->to;
 	}
@@ -394,17 +405,9 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	/* Handle the case where our range extends beyond
 	 * last_accounted_offset.
 	 */
-	if (last_accounted_offset < t) {
-		add += t - last_accounted_offset;
-		if (!regions_needed) {
-			nrg = get_file_region_entry_from_cache(
-				resv, last_accounted_offset, t);
-			record_hugetlb_cgroup_uncharge_info(h_cg, h, resv, nrg);
-			list_add(&nrg->link, rg->link.prev);
-			coalesce_file_region(resv, nrg);
-		} else
-			*regions_needed += 1;
-	}
+	if (last_accounted_offset < t)
+		add += hugetlb_resv_map_add(resv, rg, last_accounted_offset,
+					    t, h, h_cg, regions_needed);
 
 	VM_BUG_ON(add < 0);
 	return add;
-- 
2.26.2

