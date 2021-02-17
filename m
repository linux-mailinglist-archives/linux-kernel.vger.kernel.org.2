Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6142A31E314
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhBQXhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:37:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232779AbhBQXhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613604954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJC/VlIq+91W98xndkPTGEyN7MrILcrOIZFc0zZvO1w=;
        b=F00Zb35laSSsRC6zQVv5eHbwrHwzDZuGMxX6e8u5T1uxp0kbV5KHXNfq3a6dSS5v5AvMaZ
        Y3tCmXRLFaQ0lkASJYac5uFF8s+Nsz5dm2L8noBelALjrNeJTnE++0pdjf+0r/Q1XJ1VIs
        gZyLa35zYzQrwrhLy4lzY2iXXANa/pE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30--QS-Vl_UN0GollWQbjJKDw-1; Wed, 17 Feb 2021 18:35:53 -0500
X-MC-Unique: -QS-Vl_UN0GollWQbjJKDw-1
Received: by mail-qv1-f71.google.com with SMTP id z28so65286qva.15
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJC/VlIq+91W98xndkPTGEyN7MrILcrOIZFc0zZvO1w=;
        b=I5bU2deEVolKSQXw23vLYLPtANcoaGQ4p32M/7V09P4El8RTbk3xwFgUX3SGV9wKZ6
         lyaGKSgXSNLavSwovMrQ2o4g6RdbZoyHuDhO++sUvFN1hE3KVEhoGzkILkbnxpbT7nL0
         RRhtG4NYYBqm7PkZROOWmfpH2LrLQScggb9hlHrHiuRJd/fCYZDPpX5eWuF/XX7oGm95
         JRQ5sZ3BNjCLdZHwsP8QlVoXZcfurmlnESSqaA9ckpkIN90nXbHPU2CKyNILPWt5aoWY
         OyEBaLWSCKecrZdKymTw4C35yATIAbdNUmaKbGutzqQP3940uldQlbyjlCMEDRAHo3Fe
         NJWw==
X-Gm-Message-State: AOAM533BLvv6LcolYtE7DWjm/e4NbWtXU0IfNGbMswxAr+BoEsguZM5D
        V3nGd8EdU6vU7bct/LmKcBzoMH5CcrOare9skuHzgfBDqKRtQEKWMt2eZMk6+WkcdD8rEVxVjqv
        BQ5/0s18akT+iLR/ZTi48tW81
X-Received: by 2002:a37:a452:: with SMTP id n79mr1749728qke.60.1613604951895;
        Wed, 17 Feb 2021 15:35:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYXiab+QHsGr+JgkvRch04EDItcq1JEuMGGAgiNB4vHvF7Kqj8vtVYT6KCzNXV5qB6U0d2ww==
X-Received: by 2002:a37:a452:: with SMTP id n79mr1749695qke.60.1613604951694;
        Wed, 17 Feb 2021 15:35:51 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id o5sm2739622qkh.59.2021.02.17.15.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 15:35:51 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v5 1/5] hugetlb: Dedup the code to add a new file_region
Date:   Wed, 17 Feb 2021 18:35:43 -0500
Message-Id: <20210217233547.93892-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217233547.93892-1-peterx@redhat.com>
References: <20210217233547.93892-1-peterx@redhat.com>
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
index b6992297aa16..e302ed715839 100644
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

