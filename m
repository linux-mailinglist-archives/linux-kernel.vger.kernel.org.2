Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B1E4505F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhKONxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:53:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231966AbhKONxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636984222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Mopq8eqVCQt3k2LgKCs45drQOHTZZHv/QrpqMo5cqQ=;
        b=D9uQ7l6qE02q6MhVKWGX/u+fsKYzEPHW+9x+8gsRYzASfGlmm+DBH+YcVHCRiFci5yJz9P
        oMhlwS5tl0DOnBLA/bSDlhpMKAvX8QMfFdRVjewyZ8cmLGHIJYAsCknmrRjXwS5lTrHmPu
        8O9qxS2dxXmTSiInSXA8a0zcsGUMfHg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-EgcMWcMzNN-aol_0TGWoJw-1; Mon, 15 Nov 2021 08:50:20 -0500
X-MC-Unique: EgcMWcMzNN-aol_0TGWoJw-1
Received: by mail-pj1-f72.google.com with SMTP id r23-20020a17090a941700b001a74be6cf80so5097066pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Mopq8eqVCQt3k2LgKCs45drQOHTZZHv/QrpqMo5cqQ=;
        b=BJpkTltIOm3NcRJOmw4aDKlCloYxAxhvnH4ZAY5JXzU3y72jcU8K/Bqj4a68SS2rBs
         DZ3MWW7o1TSV2X70195YS/Jhu6RhlBLjJeLq5TPAundMSkkVUhMbdzf70eXVGqEDoRCf
         rRWX/V+iICEtIG0bIin4wxdEFrjaK4oTU6mbqOr6h3eGOaaDbyRdLDI9JMQ3uc0Kcr75
         9p+nYzao5r5zwZp3MhDDR8zqyXEb2d29n+rbvCaE3/S3y/btvkPgqoZID70OJsToEi4x
         kvAPp0S59dLU6F8DBuEC+gd5Q4Lugaw3wRsd79kLNhE7BBmBPdPOwjipipLbdaB581vx
         yHmQ==
X-Gm-Message-State: AOAM531JGFzOKg94ay4fZo2Zl6uuTtRuhN5M+M2HqUd6yXmqzhfrwNPI
        vq8SEOvmQp7S4f6nRlg4q8tndThDShntTM7I92G6xK3ufdYK+pRhAS+T7RcTcbAEp/HR4Ay0S00
        AnaSSNpLLulvxpjnT1sBOzgFYDc0Gb/xRLqwOUGMhDViLs6X/J7x/QehMOeXexjHqcUUrmrwNfQ
        ==
X-Received: by 2002:a05:6a00:8c4:b0:44c:9827:16cc with SMTP id s4-20020a056a0008c400b0044c982716ccmr32671009pfu.7.1636984219323;
        Mon, 15 Nov 2021 05:50:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6qrMgzTa1gzoxCkZL1qeOAjLUb/BBgC3H5Gijen4dm8xnmmk9vd5L0ATwGFMxJeM3vHMokQ==
X-Received: by 2002:a05:6a00:8c4:b0:44c:9827:16cc with SMTP id s4-20020a056a0008c400b0044c982716ccmr32670970pfu.7.1636984218969;
        Mon, 15 Nov 2021 05:50:18 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.72])
        by smtp.gmail.com with ESMTPSA id p188sm15499471pfg.102.2021.11.15.05.50.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 05:50:18 -0800 (PST)
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
Subject: [PATCH RFC v2 2/2] mm: Rework swap handling of zap_pte_range
Date:   Mon, 15 Nov 2021 21:49:51 +0800
Message-Id: <20211115134951.85286-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115134951.85286-1-peterx@redhat.com>
References: <20211115134951.85286-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean the code up by merging the device private/exclusive swap entry handling
with the rest, then we merge the pte clear operation too.

struct* page is defined in multiple places in the function, move it upward.

free_swap_and_cache() is only useful for !non_swap_entry() case, put it into
the condition.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e454f3c6aeb9..e5d59a6b6479 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1326,6 +1326,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_enter_lazy_mmu_mode();
 	do {
 		pte_t ptent = *pte;
+		struct page *page;
+
 		if (pte_none(ptent))
 			continue;
 
@@ -1333,8 +1335,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		if (pte_present(ptent)) {
-			struct page *page;
-
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(zap_skip_check_mapping(details, page)))
 				continue;
@@ -1368,32 +1368,23 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		entry = pte_to_swp_entry(ptent);
 		if (is_device_private_entry(entry) ||
 		    is_device_exclusive_entry(entry)) {
-			struct page *page = pfn_swap_entry_to_page(entry);
-
+			page = pfn_swap_entry_to_page(entry);
 			if (unlikely(zap_skip_check_mapping(details, page)))
 				continue;
-			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
-
 			if (is_device_private_entry(entry))
 				page_remove_rmap(page, false);
-
 			put_page(page);
-			continue;
-		}
-
-		if (!non_swap_entry(entry))
-			rss[MM_SWAPENTS]--;
-		else if (is_migration_entry(entry)) {
-			struct page *page;
-
+		} else if (is_migration_entry(entry)) {
 			page = pfn_swap_entry_to_page(entry);
 			if (unlikely(zap_skip_check_mapping(details, page)))
 				continue;
 			rss[mm_counter(page)]--;
+		} else if (!non_swap_entry(entry)) {
+			rss[MM_SWAPENTS]--;
+			if (unlikely(!free_swap_and_cache(entry)))
+				print_bad_pte(vma, addr, ptent, NULL);
 		}
-		if (unlikely(!free_swap_and_cache(entry)))
-			print_bad_pte(vma, addr, ptent, NULL);
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
-- 
2.32.0

