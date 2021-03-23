Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB534542C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhCWAuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231308AbhCWAtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t66g/F9+6bLvOsk6XEcPT7bVSiazBzgvig/355lAXQE=;
        b=WYmf4o52iZLgghSLq54sofb81QJhUPd0XBLha1vxMJrBiDiEfNu93FgUXeAW+vNsd1PVTB
        SYpU5lEieaDOpUw/DXWaOJ2y9ADOE8Mm1JNUxaX0y4fI9ZzXOAWbSCV7majqAR8Ty7kneC
        QJeEZmFfh19U8cYlavJFxZVzNER4IRY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-PFhXdqFKOPaG-N-i0rjWMA-1; Mon, 22 Mar 2021 20:49:28 -0400
X-MC-Unique: PFhXdqFKOPaG-N-i0rjWMA-1
Received: by mail-qt1-f197.google.com with SMTP id f8so380185qtv.22
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t66g/F9+6bLvOsk6XEcPT7bVSiazBzgvig/355lAXQE=;
        b=E6rdCWV2vYwBwjgkp9FrDau4JqBS5vw5Kq6T+QmBXjLscleixTs8gX/1YQl/yh6ujj
         DWMlQvBULrGWcpx6qnQf1THOQdx3LHrtn9+dmFtxej1EW5Ir/DAiW/ZTvKUVXHdDSYNQ
         gpm92/O077V4BmOsuiWhf2xfUZz8CbMAhAc7fURe3j6HyQEmhLG/e8VykOTqMK9/3jPe
         UYursolwf0nK/UqkvBT3MCnzH5ZbQCsej1VW7AuP3obQyC4U2dlgq6Ma6qKSM0Sb0Iv7
         lzvgioO6+hl0KLsQVhdLkxvLgQUSHtXBJxRlq3dqjncyjRZJ9CFVOHzi38YjfdXDDzSF
         EjGA==
X-Gm-Message-State: AOAM532B3/dud/ZCzPKJEJ77XRjgqIXJOLfOPBPCdPbFR620Fw2k3+ri
        bfO7n2QStamKSh0UPgKooz8Ub8lkW7tGKOxOgPHf/gnxq2W5WxZ1dnN0GDCdtP7USt37efIoFjo
        eWLujfFNNHRS2+5kORJKZHrOtZ5694Jy8EKYe1TAVa2FvjQhgdtqdcA3M1KhoL4LxiANUta/2ZQ
        ==
X-Received: by 2002:ac8:520d:: with SMTP id r13mr2445803qtn.38.1616460567904;
        Mon, 22 Mar 2021 17:49:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQ3OkZpVOpbW4WMpnPVKmwjNCxNhfbWMLukWj6w5MQB4ZMF7sL7y6kqxbDNBAVeG3FmEY40Q==
X-Received: by 2002:ac8:520d:: with SMTP id r13mr2445775qtn.38.1616460567535;
        Mon, 22 Mar 2021 17:49:27 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 08/23] mm: Introduce ZAP_FLAG_SKIP_SWAP
Date:   Mon, 22 Mar 2021 20:48:57 -0400
Message-Id: <20210323004912.35132-9-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 12 ++++++++++++
 mm/memory.c        |  8 +++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bb513a346beb..c11fbce0d557 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1704,6 +1704,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
 
 /* Whether to check page->mapping when zapping */
 #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+/* Whether to skip zapping swap entries */
+#define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
@@ -1726,6 +1728,16 @@ zap_check_mapping_skip(struct zap_details *details, struct page *page)
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
index 2e540b315481..a02c4d851cd4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1284,8 +1284,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
+		if (unlikely(zap_skip_swap(details)))
 			continue;
 
 		if (!non_swap_entry(entry))
@@ -3225,7 +3224,10 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
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
2.26.2

