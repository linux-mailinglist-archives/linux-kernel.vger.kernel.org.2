Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B843844BCE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhKJIdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:33:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230362AbhKJIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636533014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Mopq8eqVCQt3k2LgKCs45drQOHTZZHv/QrpqMo5cqQ=;
        b=EayQi99fOa6zjgJeXtX1eY7m7qSjrovVN/8AIEG0XSapHT9Dlw/F68KfW0h9MBqw8+Yx+w
        ShqQ6OEEWLj/iTRq4xMninaIG6IdZuYrkyA8P5W8cxDzKrTyacjdB6emTzk45GYMq2X7Zm
        2S8cw5XDNzCFdayzRNasyRQ/Z+b/UHM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-E2q-MBkLMNmZZERQmWGMwQ-1; Wed, 10 Nov 2021 03:30:13 -0500
X-MC-Unique: E2q-MBkLMNmZZERQmWGMwQ-1
Received: by mail-pg1-f200.google.com with SMTP id z7-20020a63c047000000b0026b13e40309so1118398pgi.19
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Mopq8eqVCQt3k2LgKCs45drQOHTZZHv/QrpqMo5cqQ=;
        b=oumdw23ew99uycTwUr/mLYLPsVdllPdMdlajCcXP4GbeFcDfeNX05joonGhF7jdUCJ
         M9f9snkJsKOEh4axaF0SaJ1UqjEe+7TcU6p5lPIbNQzqVsS9YbloBmHSovwO8JtdiMk3
         3IfuKGpAtc7UZpBkZKlTMizjlsFYAdKk4f9c5w9EjzaHZZnNKiNicUoSsWk0mGOVx8Xd
         EA0oTC0FhzloR5qS1zvE1EK2L+FjR+hiwzAiE/W06JhDLjrKGbO/Q6epo3AfZjjvFh0+
         GoHVF6k9HunFvh292b5Gb4I2Heun+S7zdpSpup/a6I1Nd8QW8IfGRKvEtbTPkUQdSRni
         ir6A==
X-Gm-Message-State: AOAM533YY5ArI5cAI5bPIR2OXmrl1K8udsYU9rt7CPpM85unLkl6wG7u
        QB6lvKPu+3v05xpJFxrpe/Y2QWqKWXvLonVv+Uew0031PWjuoZPFVTQCSsHJ7vvEm5CfDu7NfXM
        KTsRh8h6f7u6w3dg0dGvvHMeCiM0ZBSMIV0IFjLmV4Koz3+nvQm6nSU0RrYx3j65f7lbsKrH/aQ
        ==
X-Received: by 2002:a17:902:744b:b0:142:46fe:7fbf with SMTP id e11-20020a170902744b00b0014246fe7fbfmr13548627plt.83.1636533011889;
        Wed, 10 Nov 2021 00:30:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDXOtXqxrc8KYS1LcooPeq0n9NmJXaoIsx8EsNg1RzMgg48pAAzDRcIkBGlG9WlDWha2HVhg==
X-Received: by 2002:a17:902:744b:b0:142:46fe:7fbf with SMTP id e11-20020a170902744b00b0014246fe7fbfmr13548581plt.83.1636533011533;
        Wed, 10 Nov 2021 00:30:11 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.35])
        by smtp.gmail.com with ESMTPSA id s7sm23709986pfu.139.2021.11.10.00.30.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:30:11 -0800 (PST)
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
Subject: [PATCH RFC 2/2] mm: Rework swap handling of zap_pte_range
Date:   Wed, 10 Nov 2021 16:29:52 +0800
Message-Id: <20211110082952.19266-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211110082952.19266-1-peterx@redhat.com>
References: <20211110082952.19266-1-peterx@redhat.com>
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

