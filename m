Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC33630E4B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhBCVKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:10:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232273AbhBCVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612386519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi+7C1TTEkkl4WRac4WQ2x2QuL/BvKdq/6D+mj3cbKc=;
        b=GOiVgxzbcC5QZZmXs/RRKU2nCt9Kldupa2QR/9cmLytGGWJ6YIoih0EaG/ZSZ+WRqeElnB
        cTvjPxCV0XSfHjguQ5ksPAP2c62wK4zovNB0ZdUozzsklx5oJ646SNcuMrcox17+r0MmTf
        vrpKX4qpqjK41Kfubd57ej5W1HP13Sg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-vqZlA48ZOnG6BKCelR9DwA-1; Wed, 03 Feb 2021 16:08:38 -0500
X-MC-Unique: vqZlA48ZOnG6BKCelR9DwA-1
Received: by mail-qt1-f199.google.com with SMTP id m21so919625qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 13:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hi+7C1TTEkkl4WRac4WQ2x2QuL/BvKdq/6D+mj3cbKc=;
        b=rZ91dzqSm88+qkxgbNwVelcuHo/GNYRYElPbQ7Wi1BsnPO3SWc83qjrngTYKBPKGHw
         rPvsvq/yGkEYbSxRwPnJh1XkZaNSpV38e0Tp+LidkIjPDMmKWEawZ2SMSX5FNKr7O+Se
         hGG2+zAc+PMndxdczUG/QnefR2u/hkP81JkzP76XQEMWw5gxPmgSbGt+Q4xJa7foyDto
         p5LOJHOmat3JUjWgwS9RqU4fNO3lav/SjMNKCIK3nk8nYHOxgKm7h3+quHJfaa9WMIqB
         GX+lSOP00gy9LdD7rrj8UDgHD+91TY0Tmq6yOef1R+1MGRzVWXp/ongy3QrkK9VUqj3C
         38vg==
X-Gm-Message-State: AOAM533ePYLyXpvILuJeICWs70ge/2fmYRKST+XjvCr0QlE4NEnNpy2s
        VIK3q3ANshJgK4eOegZ5xc2Z6nWCI5HKAXc10RJZtaWWkJgRuQ/DFlK8RV0izWNubMvBYTPG4d3
        Ldq/7un5sH7pUXpsrKvRPIjWpApFa4irY5IUnvusI+JDivlj+mBMCylaOnO/tZmV6gWn/X1SmvA
        ==
X-Received: by 2002:a05:622a:109:: with SMTP id u9mr4287336qtw.116.1612386517605;
        Wed, 03 Feb 2021 13:08:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsK56DJ4Ctms//4+fxvCDxExkPh+ZfRXVZ5RIfd/7b2Jecyo9d2wOQoUVa7DDZ2m6IK7Mk1Q==
X-Received: by 2002:a05:622a:109:: with SMTP id u9mr4287296qtw.116.1612386517306;
        Wed, 03 Feb 2021 13:08:37 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id t6sm2507659qti.2.2021.02.03.13.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:08:36 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Wei Zhang <wzam@amazon.com>, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>, peterx@redhat.com,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/4] hugetlb: Dedup the code to add a new file_region
Date:   Wed,  3 Feb 2021 16:08:29 -0500
Message-Id: <20210203210832.113685-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203210832.113685-1-peterx@redhat.com>
References: <20210203210832.113685-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce hugetlb_resv_map_add() helper to add a new file_region rather than
duplication the similar code twice in add_reservation_in_range().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 51 +++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 18f6ee317900..d2859c2aecc9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -321,6 +321,24 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
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
@@ -336,7 +354,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	long add = 0;
 	struct list_head *head = &resv->regions;
 	long last_accounted_offset = f;
-	struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
+	struct file_region *rg = NULL, *trg = NULL;
 
 	if (regions_needed)
 		*regions_needed = 0;
@@ -365,18 +383,11 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
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
@@ -384,17 +395,9 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
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

