Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7A30F56B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhBDOwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236858AbhBDOwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7jRvMA4HBy1aAj/yC80X2PETreSK76wGUdXXk+MGi4=;
        b=ade7RXe3TqOjxM6LQ0Jr8qQjXDSebX/Y8PdoH3l+NL09OC9iAl8YZaa4Fhv6gcxK1vPIOB
        8nK92pyaAU4GvePLm6z7xJylksb/iHltHULZSGE4Hl7eYbSWh7WCTBgBHly1V5ZLH87n4l
        RNkQ6h9NBNIVkqlOpPS9D0Xo+MAGwl0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-gD-V5JNAMqSKWIUaTXu5Mw-1; Thu, 04 Feb 2021 09:50:38 -0500
X-MC-Unique: gD-V5JNAMqSKWIUaTXu5Mw-1
Received: by mail-qv1-f69.google.com with SMTP id h13so2352882qvs.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7jRvMA4HBy1aAj/yC80X2PETreSK76wGUdXXk+MGi4=;
        b=BXrvKZQXfr/IZyNQ3btFMVc08CROldgicLvnx2Q4qXt0pYL6G6m6IeMhHNeBbp3H3u
         uwxbIDo97Q++xFssAj9JHVm3fAjTz+B3Um5fQDLXmbW+r1cRESmqQFeDyN+fq7XL01+W
         RpzHSPtZ00f+aRTjfI5wEDqmoriNaLZowMMaPn45yrqYQd5tBHmz6TZ0hCauva3ckW0v
         r/RYS+BqKyOaFJlxDTDIBFbITM7x53g8hPnnWBK5kA93Sym42hDTJLBMvsk+YxBRBuBh
         3XTLS06ZF1GjcFxzsLxyiAADRhggpciIWsbIAXynbci14kMUNPGDLnP2IpZLJNivGGGP
         qb8g==
X-Gm-Message-State: AOAM5308zZcAWaJnNVz9+wBFnRFRVa3HOkLeNGtwxBOVNeZ7ALRWwF1+
        8olQrkV8cze/xbdEc48ijAVf6DMxOhtLllUCN5/lb1EeKz2rlMHfbtfKmy/jsd5YWUnVKMHpndH
        +59geB5wHBpqi4IpD5fDNiEL5
X-Received: by 2002:ac8:6d2:: with SMTP id j18mr2156522qth.214.1612450237660;
        Thu, 04 Feb 2021 06:50:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzER/i1DvUdHrf1GPiOThk9/cqRKFwCL/S/o8WFC1+MtPN7xx83suFHqdyMHA+4tPyflgLFFg==
X-Received: by 2002:ac8:6d2:: with SMTP id j18mr2156499qth.214.1612450237441;
        Thu, 04 Feb 2021 06:50:37 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id e14sm4697589qte.18.2021.02.04.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:50:36 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/4] hugetlb: Dedup the code to add a new file_region
Date:   Thu,  4 Feb 2021 09:50:30 -0500
Message-Id: <20210204145033.136755-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210204145033.136755-1-peterx@redhat.com>
References: <20210204145033.136755-1-peterx@redhat.com>
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

