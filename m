Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2657144BCE2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhKJIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230290AbhKJIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636533009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zc9KdahAguXkghVeJqdY3150Du1QUqNhK9U4RYp1RCU=;
        b=RByG1jlub1KTpZ2nQTePIh1H/Kdu7gduUC3zdqNmdtdGYU/FiNqUn6MpiFbPcInFw+Yvc3
        3pCVnwHKtwoq8cwhfcBP3lqgalqZfRIoI6wgCezppbJJeFsKq6DeopFMiHDH6RawAMHbpH
        3zakxDk5POvfF5qs36qHslGG8/7rgAc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-Ucn6SWz5POm13inzkJkT1g-1; Wed, 10 Nov 2021 03:30:08 -0500
X-MC-Unique: Ucn6SWz5POm13inzkJkT1g-1
Received: by mail-pl1-f197.google.com with SMTP id k9-20020a170902ba8900b00141f601d5c8so1347629pls.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zc9KdahAguXkghVeJqdY3150Du1QUqNhK9U4RYp1RCU=;
        b=WV4mf5+ZvhNeBOb/eHlGd3V66ojvi3BcsPrYYpRtBnY8M+UbwZlX4fJOfam/FVfTpo
         TDBCIbICaIgge0YjnJo4MyobjRigmMw3ovhzPUvLEKILK7NyMCeY0QELi1dNY0pXelCB
         PreJGeGKMGwvIBhyGK6T7oHtPS3YYGrmZodiS8CpLzVzTRigH6eB+yXOhLQrMqe+ZKRP
         VgwaX60REsgpilCcbFGz4PggnffdrtAfN82ugQPeDt/ckUyFgjNPGBVLsNdVLabkuDX9
         x2WAHWhDdlRUsebsvOu/JhDrNT30zhZh5xjcQIGKAocBBWxQyQXHMZ/XwsxNJXoG1RfE
         ZQoA==
X-Gm-Message-State: AOAM530CP90fjPpO641EbnhKzj1goNda8h0CXIEda121ATwPLtF+ltI8
        aCxF0JP931cBEfZkw9qkHe89GzgZyYzwtLGi9BLuFAjeHO7sG7rAkK2sOmsVdun19VmXePzZnLM
        8qf3V8M9TV0XV7gy1wGbYInLnvk0Q7VRJYYiZyjuXasDm8zrL17FoiBNRXnCmet7iBROS9LCVgA
        ==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr14429792pfj.15.1636533006883;
        Wed, 10 Nov 2021 00:30:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5G/zio2lUCBLScLXJPHr7YuBo+SEEpRo7ak25/Vhyewmy2QoxXzy6zMkmUgeA4ABnG5roEw==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr14429751pfj.15.1636533006522;
        Wed, 10 Nov 2021 00:30:06 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.35])
        by smtp.gmail.com with ESMTPSA id s7sm23709986pfu.139.2021.11.10.00.30.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:30:06 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH RFC 1/2] mm: Don't skip swap entry even if zap_details specified
Date:   Wed, 10 Nov 2021 16:29:51 +0800
Message-Id: <20211110082952.19266-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211110082952.19266-1-peterx@redhat.com>
References: <20211110082952.19266-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check existed since the 1st git commit of Linux repository, but at that
time there's no page migration yet so I think it's okay.

With page migration enabled, it should logically be possible that we zap some
shmem pages during migration.  When that happens, IIUC the old code could have
the RSS counter accounted wrong on MM_SHMEMPAGES because we will zap the ptes
without decreasing the counters for the migrating entries.  I have no unit test
to prove it as I don't know an easy way to trigger this condition, though.

Besides, the optimization itself is already confusing IMHO to me in a few points:

  - The wording "skip swap entries" is confusing, because we're not skipping all
    swap entries - we handle device private/exclusive pages before that.

  - The skip behavior is enabled as long as zap_details pointer passed over.
    It's very hard to figure that out for a new zap caller because it's unclear
    why we should skip swap entries when we have zap_details specified.

  - With modern systems, especially performance critical use cases, swap
    entries should be rare, so I doubt the usefulness of this optimization
    since it should be on a slow path anyway.

  - It is not aligned with what we do with huge pmd swap entries, where in
    zap_huge_pmd() we'll do the accounting unconditionally.

This patch drops that trick, so we handle swap ptes coherently.  Meanwhile we
should do the same mapping check upon migration entries too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dc..e454f3c6aeb9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1382,16 +1382,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
-			continue;
-
 		if (!non_swap_entry(entry))
 			rss[MM_SWAPENTS]--;
 		else if (is_migration_entry(entry)) {
 			struct page *page;
 
 			page = pfn_swap_entry_to_page(entry);
+			if (unlikely(zap_skip_check_mapping(details, page)))
+				continue;
 			rss[mm_counter(page)]--;
 		}
 		if (unlikely(!free_swap_and_cache(entry)))
-- 
2.32.0

