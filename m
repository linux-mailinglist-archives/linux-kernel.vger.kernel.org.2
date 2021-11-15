Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BFB45060B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhKONx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:53:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231941AbhKONxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636984214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zc9KdahAguXkghVeJqdY3150Du1QUqNhK9U4RYp1RCU=;
        b=Qru4zU55cIDtWPs99U1q3XnTN/AqdmI3Ah3leSxsGBp1dWeyTCetKYA0d4h8EGnUrvrYd1
        jIaGALIJnywAy0vS517Bnyd2x4q1rHHeMDNN0Z3M/1hJxy+L7GYNjkVtkf4C9JwcXUzFjL
        AcZoSiBke3BnDkk6WeRq/mqLFxEq+Gc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-lDgiGwW_O0613tuaCdAPvg-1; Mon, 15 Nov 2021 08:50:13 -0500
X-MC-Unique: lDgiGwW_O0613tuaCdAPvg-1
Received: by mail-pg1-f200.google.com with SMTP id q15-20020a65624f000000b002e6a7b9f4b8so1866786pgv.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zc9KdahAguXkghVeJqdY3150Du1QUqNhK9U4RYp1RCU=;
        b=RQNLLDEIYysHAbSK5myrmVRByM+dU9ccgSqeOz6B2eu0IXIcxwdS1wlRxMcdmbPmM/
         HKurr+dXTyYylrF4G1BE5+8X6l7Liek/yiz6t0k0jIqN0ErOUfFzD+KhtRksApnPIlCm
         w2lMuALAof4Vl68jI1sz2D9MIA2eRhX16ZYadzjk9Cl4sfvQuy+Lp6ql39YvjBtgyEJp
         dM6RrjhkAus/Xxj4VujcgomhmIeMLqpbFjXsddSD9s8pewNJLXqsLlRoPJuIe+pywPK+
         WFp0cz2fGYtX6fd2wwYcKROxF9ME62i22Y9S3QL6QAnZeL6OZdiXC0tM2cSh9yxVkkXb
         uzrg==
X-Gm-Message-State: AOAM5306gAhkks7Q2LSNcF4qvlJ4BuL5uqUnxKGSPOU6aFnKweB4kg6Y
        rz7MggT/+aTKG/sPRwuZNw/E2M87/8I3f0qsLJxE0+HlCpjhI8oBKeSYzrE8D8K49vG7vLS+3jm
        nt+KbIuMLenooI7TsPRxd0jIuvSa6y9e//diEBDRIOvxyrjRAoitgPkqvQcJw9dvlRPXf4Y9Aow
        ==
X-Received: by 2002:a17:902:c7c4:b0:141:deb4:1b2f with SMTP id r4-20020a170902c7c400b00141deb41b2fmr35276058pla.44.1636984212312;
        Mon, 15 Nov 2021 05:50:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVSWk3fByWPePLZoQ7jzLPYtHg8URAdE0VnftMpGgFIdHPUy8j42a0fPsBR8PAdhvEB0sRZw==
X-Received: by 2002:a17:902:c7c4:b0:141:deb4:1b2f with SMTP id r4-20020a170902c7c400b00141deb41b2fmr35276002pla.44.1636984211931;
        Mon, 15 Nov 2021 05:50:11 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.72])
        by smtp.gmail.com with ESMTPSA id p188sm15499471pfg.102.2021.11.15.05.50.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 05:50:11 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details specified
Date:   Mon, 15 Nov 2021 21:49:50 +0800
Message-Id: <20211115134951.85286-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115134951.85286-1-peterx@redhat.com>
References: <20211115134951.85286-1-peterx@redhat.com>
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

