Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90457311187
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhBESJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:09:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233196AbhBEPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612544443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tR/UuXaqBaROltUbV2RDYpoyLXOK1N4qjZ6UzYcMHb0=;
        b=JDGUx094SD1FGeHmTDxoyarZsInfGNl6Mtla+b32/AvIu2Ct6YM6ZSGdguj6+0ygHEBoWo
        l3StRt0/5/DnQb45CVJEbzwDEGPKouzshLRNFaNg5ha4qHQkUP492pGE7JQG4EgeVPh/DW
        JsFx+TZ7tB7CwOzWztpCSqJW1u5EnxQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-n4u-BNF3PWOCCWvS3vRzkQ-1; Fri, 05 Feb 2021 11:53:33 -0500
X-MC-Unique: n4u-BNF3PWOCCWvS3vRzkQ-1
Received: by mail-qv1-f71.google.com with SMTP id d26so5435217qve.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tR/UuXaqBaROltUbV2RDYpoyLXOK1N4qjZ6UzYcMHb0=;
        b=YajUefwqs4JU7C6fZWubN/FU1b+5dcq9xNq7bftfrzx7Iz2utxdsp14pncTBPCnZNw
         3N6l67hMYTX19bLjgubgAHbC+hrJcQSSGAntp+5u+xMHaaaOpEI8X+kd6xlhVDrU3dH3
         1ya7Ll8O+UUv+2D05NmOPUwDHkaDO87gcjQoZjOBpgaF+GZRnjSoVoDUrkitl0jxi2GN
         2XMVSOCDQSHTlToQmi9/11R6BPlSyPKji0PYP8NqNtctwTow4BeuBAQBTixBXmoD1xMr
         5NZ+gG9pf7B3HynDrHqQRCVCuTxD0FkhoBIOIr+ELFC9+FsDOG/4mgrVtJFtoRQ52/9S
         UTaQ==
X-Gm-Message-State: AOAM533cTze14llbaGf3J4tqApd/34VwHC76DrjXHotqyinZmtlZ3CQx
        qVF3Y4h/rwqnCAUMfxuGmAfIL2XErpNpEXN5/oGYMbAW0RXP3RjbbhYKSfmi03mrFJFJMKH0gup
        mZJ/oyVlat7rUvtYc5pZfJTB7
X-Received: by 2002:ac8:23f0:: with SMTP id r45mr4834204qtr.345.1612544012685;
        Fri, 05 Feb 2021 08:53:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJLoIssHDvkJfBmCjyZhFqfntCVz8qYhtn6INdIk/dYPa81yrmZmAl6ZslVudgD8VCc3c9gQ==
X-Received: by 2002:ac8:23f0:: with SMTP id r45mr4834171qtr.345.1612544012473;
        Fri, 05 Feb 2021 08:53:32 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 12sm9618893qkg.39.2021.02.05.08.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:53:31 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Wei Zhang <wzam@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 1/5] hugetlb: Dedup the code to add a new file_region
Date:   Fri,  5 Feb 2021 11:54:02 -0500
Message-Id: <20210205165406.4655-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205165406.4655-1-peterx@redhat.com>
References: <20210205165406.4655-1-peterx@redhat.com>
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

