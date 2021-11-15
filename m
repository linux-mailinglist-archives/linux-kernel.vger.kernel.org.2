Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B6044FF8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhKOH6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229963AbhKOH6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636962947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tB7XXxUDPClsvCRJSlQGXzWYmuo0RbrsIC/Jp1UIRWI=;
        b=YvkrP+zm74uJSOPGDY/+Gxj1y5q6uY4KsRP2N3emv9T72ZJxFRRgmVwfuM7OMN4qMc5Scj
        zk+GdvTjy0W7MlSNbKXnSLjORW9klEaPwsiU0XhGaBxVdv/vsM+z4n5Ie9kQgwBiXmGh/6
        1CQOV8r5UrDJtS2MzWcz+9z9nsJfpeM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-rs65WneROrSbWHIcOrRIjg-1; Mon, 15 Nov 2021 02:55:46 -0500
X-MC-Unique: rs65WneROrSbWHIcOrRIjg-1
Received: by mail-pj1-f70.google.com with SMTP id n2-20020a17090a2fc200b001a1bafb59bfso4872990pjm.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tB7XXxUDPClsvCRJSlQGXzWYmuo0RbrsIC/Jp1UIRWI=;
        b=br1JdoiZclzhJ2TN6/LVcgs42UIFW66T2h9az5X9Ta7yQ4oa27XMt4QEw6aH8vm02t
         03Q2CtPtC0+CLJJKd0wUmCFD+quTmgmZBwAtrUBTtmunUmHpGpFw+iquHJEbjz1KabTG
         eQXlhXNdyBZwwI8aF8tqi6KBTi8EeIcA2vpzXR5d8ilbIKEpE76ABJ4kKRV1b/YZoWVi
         jSJqUA6cp/nXXF+UwCOoRHM6iCzDXDgr5J0qFHZY1cUtOPJi86qcoPHYdmdHUu1mBofD
         6Uv8CyL4y0bu+Hqu8SSnnnclS+lNTQ0eCcWW5/pO+y5cLj2JU+kFMLnputCCUSixAWEy
         zmCQ==
X-Gm-Message-State: AOAM531+oiXbNNg7ygNiV9uqA6o/I5OnGc2ycsr+7zl0WodixqhuJ7UD
        N0wYgGpq8DMDIFp+OpusGFxRBDT1mQre6fWYft49nkQNiK9bfTeMYkg+haUAjkQprsh/cpc2eO3
        ug7guXYF/eZH7U/Z0/75s8Xaj
X-Received: by 2002:a17:902:ced0:b0:142:189a:4284 with SMTP id d16-20020a170902ced000b00142189a4284mr33424049plg.79.1636962945486;
        Sun, 14 Nov 2021 23:55:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIh24oN/aOHwQNeFngZZiEj6k+znRNmUOXfm7wYUcH1IH7Mfl4beexyoTb5Mv7N+ELT1eiqg==
X-Received: by 2002:a17:902:ced0:b0:142:189a:4284 with SMTP id d16-20020a170902ced000b00142189a4284mr33424023plg.79.1636962945136;
        Sun, 14 Nov 2021 23:55:45 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.223])
        by smtp.gmail.com with ESMTPSA id e10sm15792796pfv.140.2021.11.14.23.55.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:55:44 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v6 01/23] mm: Introduce PTE_MARKER swap entry
Date:   Mon, 15 Nov 2021 15:55:00 +0800
Message-Id: <20211115075522.73795-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new swap entry type called PTE_MARKER.  It can be
installed for any pte that maps a file-backed memory when the pte is
temporarily zapped, so as to maintain per-pte information.

The information that kept in the pte is called a "marker".  Here we define the
marker as "unsigned long" just to match pgoff_t, however it will only work if
it still fits in swp_offset(), which is e.g. currently 58 bits on x86_64.

A new config CONFIG_PTE_MARKER is introduced too; it's by default off.  A bunch
of helpers are defined altogether to service the rest of the pte marker code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/asm-generic/hugetlb.h |  9 ++++
 include/linux/swap.h          | 15 ++++++-
 include/linux/swapops.h       | 78 +++++++++++++++++++++++++++++++++++
 mm/Kconfig                    |  7 ++++
 4 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 8e1e6244a89d..f39cad20ffc6 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -2,6 +2,9 @@
 #ifndef _ASM_GENERIC_HUGETLB_H
 #define _ASM_GENERIC_HUGETLB_H
 
+#include <linux/swap.h>
+#include <linux/swapops.h>
+
 static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
 {
 	return mk_pte(page, pgprot);
@@ -80,6 +83,12 @@ static inline int huge_pte_none(pte_t pte)
 }
 #endif
 
+/* Please refer to comments above pte_none_mostly() for the usage */
+static inline int huge_pte_none_mostly(pte_t pte)
+{
+	return huge_pte_none(pte) || is_pte_marker(pte);
+}
+
 #ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index d1ea44b31f19..cc9adcfd666f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -55,6 +55,19 @@ static inline int current_is_kswapd(void)
  * actions on faults.
  */
 
+/*
+ * PTE markers are used to persist information onto PTEs that are mapped with
+ * file-backed memories.  As its name "PTE" hints, it should only be applied to
+ * the leaves of pgtables.
+ */
+#ifdef CONFIG_PTE_MARKER
+#define SWP_PTE_MARKER_NUM 1
+#define SWP_PTE_MARKER     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
+			    SWP_MIGRATION_NUM + SWP_DEVICE_NUM)
+#else
+#define SWP_PTE_MARKER_NUM 0
+#endif
+
 /*
  * Unaddressable device memory support. See include/linux/hmm.h and
  * Documentation/vm/hmm.rst. Short description is we need struct pages for
@@ -100,7 +113,7 @@ static inline int current_is_kswapd(void)
 
 #define MAX_SWAPFILES \
 	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
-	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM)
+	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - SWP_PTE_MARKER_NUM)
 
 /*
  * Magic header for a swap area. The first part of the union is
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d356ab4047f7..5103d2a4ae38 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -247,6 +247,84 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
 
 #endif
 
+typedef unsigned long pte_marker;
+
+#define  PTE_MARKER_MASK     (0)
+
+#ifdef CONFIG_PTE_MARKER
+
+static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
+{
+	return swp_entry(SWP_PTE_MARKER, marker);
+}
+
+static inline bool is_pte_marker_entry(swp_entry_t entry)
+{
+	return swp_type(entry) == SWP_PTE_MARKER;
+}
+
+static inline pte_marker pte_marker_get(swp_entry_t entry)
+{
+	return swp_offset(entry) & PTE_MARKER_MASK;
+}
+
+static inline bool is_pte_marker(pte_t pte)
+{
+	return is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte));
+}
+
+#else /* CONFIG_PTE_MARKER */
+
+static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
+{
+	/* This should never be called if !CONFIG_PTE_MARKER */
+	WARN_ON_ONCE(1);
+	return swp_entry(0, 0);
+}
+
+static inline bool is_pte_marker_entry(swp_entry_t entry)
+{
+	return false;
+}
+
+static inline pte_marker pte_marker_get(swp_entry_t entry)
+{
+	return 0;
+}
+
+static inline bool is_pte_marker(pte_t pte)
+{
+	return false;
+}
+
+#endif /* CONFIG_PTE_MARKER */
+
+static inline pte_t make_pte_marker(pte_marker marker)
+{
+	return swp_entry_to_pte(make_pte_marker_entry(marker));
+}
+
+/*
+ * This is a special version to check pte_none() just to cover the case when
+ * the pte is a pte marker.  It existed because in many cases the pte marker
+ * should be seen as a none pte; it's just that we have stored some information
+ * onto the none pte so it becomes not-none any more.
+ *
+ * It should be used when the pte is file-backed, ram-based and backing
+ * userspace pages, like shmem.  It is not needed upon pgtables that do not
+ * support pte markers at all.  For example, it's not needed on anonymous
+ * memory, kernel-only memory (including when the system is during-boot),
+ * non-ram based generic file-system.  It's fine to be used even there, but the
+ * extra pte marker check will be pure overhead.
+ *
+ * For systems configured with !CONFIG_PTE_MARKER this will be automatically
+ * optimized to pte_none().
+ */
+static inline int pte_none_mostly(pte_t pte)
+{
+	return pte_none(pte) || is_pte_marker(pte);
+}
+
 static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 {
 	struct page *p = pfn_to_page(swp_offset(entry));
diff --git a/mm/Kconfig b/mm/Kconfig
index 068ce591a13a..66f23c6c2032 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -897,6 +897,13 @@ config IO_MAPPING
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
 
+config PTE_MARKER
+	def_bool n
+	bool "Marker PTEs support"
+
+	help
+	  Allows to create marker PTEs for file-backed memory.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.32.0

