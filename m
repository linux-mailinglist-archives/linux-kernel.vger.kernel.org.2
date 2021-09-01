Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA3C3FE459
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbhIAU63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231340AbhIAU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630529850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWrZC5R796B6AxPjLXJOHfEspvF6TQvhNiM+3hpUqTo=;
        b=Za3fQZtPQmNQ17zeDL8QfmpZT5Tcg//BvnzrY4pirjKJHT0rH38mtggaapCy6bJvmkJ7co
        lQNnnTHxmp6+DKTV/aaHe4ka7u5tsylwJ5ipcl8IRZIuEKW6Uz3ikyodfSJrUD8/TO82sg
        6SI61+uBkNyGnkr7SSKgDUziz6oBxrA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-LfwW54pPOYmzewx3FcUgOg-1; Wed, 01 Sep 2021 16:57:29 -0400
X-MC-Unique: LfwW54pPOYmzewx3FcUgOg-1
Received: by mail-qk1-f197.google.com with SMTP id h186-20020a3785c3000000b00425f37f792aso798154qkd.22
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWrZC5R796B6AxPjLXJOHfEspvF6TQvhNiM+3hpUqTo=;
        b=FPM/x44kdA4+O/hQncG9VXFNsEQ4r2BS2hK4b+6U/blF1+mNMhTmM5U0yyUtCBnFhf
         kyBj7Im4jRJBiY3f5E6/Sfr+J8XczJQLa2mJzlbT685RSGrJvsBm3yCSv2bjDHKfQad3
         qKDHg+VNJSGpDTS66G7KktfIV0f5M/Dv4vhjhhVEmeiv2TzK9lt4dtEioTfWUwZ/i9wg
         hvetBOs1MG4w9grg35PjvvEXRtwk184dbSlbPczqK0kXA4z+8BnHFCi1n1zJNqU9Usib
         fT4iPDUy2dHxd3g+cXFfmW4xycAdJJadV1zbSRc0Z6wU7jnCbUMoVlqUnAUyNk1i3CIm
         TB4Q==
X-Gm-Message-State: AOAM532F0pFE2D+fyi3Jm6T3VnTVmCtFfWGg9zYQAeWhSxeyGj74s35i
        fTuURAk8lztNRGhvlzt56f4O6CfFgf/hta+4IngAiP16tLEwLFgWiQZBZbZREfOJVo3Xfbud5dm
        q8z5xYj31L/dU4D95LkqzSqeO8w+4n6lGrPbPP/XhIJLPPUN325j7eEC2EE6TxcX+lacWmdTvrA
        ==
X-Received: by 2002:a37:6c2:: with SMTP id 185mr1619304qkg.260.1630529849165;
        Wed, 01 Sep 2021 13:57:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAT0cwh0fiCuGBlVwkSIV+oBHm4p8ri9MOokNJ6Nf3K4EOtcbAo8KK7ymA6ffmkzusdLOapw==
X-Received: by 2002:a37:6c2:: with SMTP id 185mr1619264qkg.260.1630529848869;
        Wed, 01 Sep 2021 13:57:28 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id h17sm562359qtu.68.2021.09.01.13.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:57:28 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 5/5] mm: Introduce ZAP_FLAG_SKIP_SWAP
Date:   Wed,  1 Sep 2021 16:57:25 -0400
Message-Id: <20210901205725.7381-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901205622.6935-1-peterx@redhat.com>
References: <20210901205622.6935-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the comment in zap_pte_range() is misleading because it checks against
details rather than check_mappings, so it's against what the code did.

Meanwhile, it's confusing too on not explaining why passing in the details
pointer would mean to skip all swap entries.  New user of zap_details could
very possibly miss this fact if they don't read deep until zap_pte_range()
because there's no comment at zap_details talking about it at all, so swap
entries could be errornously skipped without being noticed.

This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
"details" parameter: the caller should explicitly set this to skip swap
entries, otherwise swap entries will always be considered (which is still the
major case here).

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 12 ++++++++++++
 mm/memory.c        |  8 +++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fcbc1c4f8e8e..f798f5e4baa5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1718,6 +1718,8 @@ extern void user_shm_unlock(size_t, struct ucounts *);
 
 /* Whether to check page->mapping when zapping */
 #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+/* Whether to skip zapping swap entries */
+#define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
@@ -1741,6 +1743,16 @@ zap_skip_check_mapping(struct zap_details *details, struct page *page)
 	return details->zap_mapping != page_rmapping(page);
 }
 
+/* Return true if skip swap entries, false otherwise */
+static inline bool
+zap_skip_swap(struct zap_details *details)
+{
+	if (!details)
+		return false;
+
+	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 05ccacda4fe9..79957265afb4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1379,8 +1379,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
+		if (unlikely(zap_skip_swap(details)))
 			continue;
 
 		if (!non_swap_entry(entry))
@@ -3379,7 +3378,10 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
-	struct zap_details details = { .zap_mapping = mapping };
+	struct zap_details details = {
+		.zap_mapping = mapping,
+		.zap_flags = ZAP_FLAG_SKIP_SWAP,
+	};
 
 	if (!even_cows)
 		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
-- 
2.31.1

