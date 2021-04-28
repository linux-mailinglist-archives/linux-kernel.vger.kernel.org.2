Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C3336E1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbhD1WwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240075AbhD1WwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619650284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mX5tB3J49H84VgNhuzdVmDuPOZ+GeLNjOa4r3iSgeg4=;
        b=Jt6OXs0RMK8kEOPshcdLvuIJ4303oiRaL3gcIQ4ahP//AKMWHU0D0E18upY00j7HsZc083
        qJAkikPhkr0TFmjEUmNgmRo3gIicZGcrEOOWiXgmJ2bbpQAmaOpHolwdpPXSvkHlkTIOst
        6bZQAsuYRicp6JTZU8OLguGnl7DVH2k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-P-42Xd2nPq2u9kPq6vgl-A-1; Wed, 28 Apr 2021 18:51:22 -0400
X-MC-Unique: P-42Xd2nPq2u9kPq6vgl-A-1
Received: by mail-qt1-f200.google.com with SMTP id u16-20020ac86f700000b02901baa6e2dbfcso7380536qtv.20
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mX5tB3J49H84VgNhuzdVmDuPOZ+GeLNjOa4r3iSgeg4=;
        b=LC/ae/3j9wOlSsod/Sy2KAvJC3gcwEMlxk9eotr4S0ZFkkk+f+jUi+pUrktsoUAz4h
         tO0MArnfQ/STQqkM5E5ehmjv/wZmVDaovek+5VdUQgAQo1zmwtha4B6x9SksLy8k4OqS
         GuDABdvg4H/UfNjqCzwIWukEBbEpY5cBdLIOZ6YBOS+kPuJd18GaPJN5ky6IWgUsKBWp
         fdbmqRnRC59aHobZHShVyh/PkZdrNP6GFwtA4Nkfluu9q6XuEPR7yOkOYfxDqRFYVnk5
         5QkLW3IK3DjHsyIPKiijmOvm8UE+gL3xwRFDSwxXt88+CbI/y+eGJHGjuz6FR9QSfjCe
         rdUw==
X-Gm-Message-State: AOAM532tLyddCYMkMrwDEfMtUUGboiCBy5IplnQQbh/cbv2PQaOomysi
        IQwqgpobbm/1sGMM71JpdB9StjNGidbKleCpEtsTPPfK2lSttOB1WqpQ7GYr65L3RNZv8/oNkLb
        Sb4MrlQU36aZ/97VHr7yYAOLf
X-Received: by 2002:a0c:fb4e:: with SMTP id b14mr31673236qvq.28.1619650282101;
        Wed, 28 Apr 2021 15:51:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4HCkJm81ksUeMlHST386Jw+apuC8iK/I7PR3SG4syb6rigMTQEREtHbkFfHxe1EdAh2hbFg==
X-Received: by 2002:a0c:fb4e:: with SMTP id b14mr31673214qvq.28.1619650281917;
        Wed, 28 Apr 2021 15:51:21 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 191sm897459qkk.31.2021.04.28.15.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:51:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 5/6] mm/pagemap: Export uffd-wp protection information
Date:   Wed, 28 Apr 2021 18:50:29 -0400
Message-Id: <20210428225030.9708-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210428225030.9708-1-peterx@redhat.com>
References: <20210428225030.9708-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the PTE/PMD status of uffd-wp to pagemap too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/admin-guide/mm/pagemap.rst | 2 ++
 fs/proc/task_mmu.c                       | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index 340a5aee9b802..fb578fbbb76ca 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -21,6 +21,8 @@ There are four components to pagemap:
     * Bit  55    pte is soft-dirty (see
       :ref:`Documentation/admin-guide/mm/soft-dirty.rst <soft_dirty>`)
     * Bit  56    page exclusively mapped (since 4.2)
+    * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
+      :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
     * Bits 57-60 zero
     * Bit  61    page is file-page or shared-anon (since 3.5)
     * Bit  62    page swapped
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc9784544b241..ce3b5f33b44c4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1302,6 +1302,7 @@ struct pagemapread {
 #define PM_PFRAME_MASK		GENMASK_ULL(PM_PFRAME_BITS - 1, 0)
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
+#define PM_UFFD_WP		BIT_ULL(57)
 #define PM_FILE			BIT_ULL(61)
 #define PM_SWAP			BIT_ULL(62)
 #define PM_PRESENT		BIT_ULL(63)
@@ -1375,10 +1376,14 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		page = vm_normal_page(vma, addr, pte);
 		if (pte_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
+		if (pte_uffd_wp(pte))
+			flags |= PM_UFFD_WP;
 	} else if (is_swap_pte(pte)) {
 		swp_entry_t entry;
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
+		if (pte_swp_uffd_wp(pte))
+			flags |= PM_UFFD_WP;
 		entry = pte_to_swp_entry(pte);
 		if (pm->show_pfn)
 			frame = swp_type(entry) |
@@ -1426,6 +1431,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			flags |= PM_PRESENT;
 			if (pmd_soft_dirty(pmd))
 				flags |= PM_SOFT_DIRTY;
+			if (pmd_uffd_wp(pmd))
+				flags |= PM_UFFD_WP;
 			if (pm->show_pfn)
 				frame = pmd_pfn(pmd) +
 					((addr & ~PMD_MASK) >> PAGE_SHIFT);
@@ -1444,6 +1451,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			flags |= PM_SWAP;
 			if (pmd_swp_soft_dirty(pmd))
 				flags |= PM_SOFT_DIRTY;
+			if (pmd_swp_uffd_wp(pmd))
+				flags |= PM_UFFD_WP;
 			VM_BUG_ON(!is_pmd_migration_entry(pmd));
 			page = migration_entry_to_page(entry);
 		}
-- 
2.26.2

