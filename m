Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4744FF90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhKOIAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:00:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230354AbhKOH7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636962971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmskQuQ5v+E/C6hWNn1p+tojqPkwHTmjUCaKkLoPmAQ=;
        b=E50XXQNuXfckZr7BGWobqqQ1bY8cOJfQ8DWzP5MHaw3y15bUUh2ATk6onmiaTO1OuYzpm4
        I1aozSGT6Fr2FaBLXOLW4bpwO9w4pGdUJCKza10XDY4ZI/u/wVP65hYyktZPHdrOTOoLn2
        ekcT2GRweYCLfJmHGxS2tnGx23bKqUw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-No0TQVycOXKdIAuQ3ztKAg-1; Mon, 15 Nov 2021 02:56:10 -0500
X-MC-Unique: No0TQVycOXKdIAuQ3ztKAg-1
Received: by mail-pj1-f69.google.com with SMTP id x1-20020a17090a294100b001a6e7ba6b4eso8618541pjf.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmskQuQ5v+E/C6hWNn1p+tojqPkwHTmjUCaKkLoPmAQ=;
        b=EmH2iTF/V8nhG9rwP8VmwXE7PCS5UcdapgpG/fKutMc0QGrCj3wPIK3POUrYPnhJO/
         PqRl/Y+UO4z6L6Go5co9TykDfKV8e/6d0D0w4RAi2dRvwXntHnks7P+f2oFoblg5e+/z
         lOXenN29cODMzA4GnSl4aRKWJ5wWA5YRJtR5iXVQgV2pbbNm+EZX2/qj23a9Nf1n7kR/
         JkElb9bmEUaFPz0SjSC5r+9gr/ZhUK/zDY/ZAYpRAAQv/Mt3T2O/4tjLWgwRMJtzzzB6
         o20T2dHqtXmzcyFYVn22gbgjUUCCb6MCsdub8rl0gbzvW1W5zyIRh5u8MO+V1K/25f7I
         Rbog==
X-Gm-Message-State: AOAM530z1e9FPHbrfJkAWSE+Z0pIk4xdzKIkpnZPHtTyWY1rO62HGwNw
        4itjn2HCNa/HrWt0uz5J7pa4WaBl9zUfl5JLXSIBQJjgsR+OTzWN2IjucaRWEGFKoBAUWE0eWoN
        Zwe4PD+llC26El1nGfiGxMj/f
X-Received: by 2002:a05:6a00:1901:b0:44b:e041:f07f with SMTP id y1-20020a056a00190100b0044be041f07fmr31906441pfi.52.1636962968532;
        Sun, 14 Nov 2021 23:56:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwO6oDN0fGNLF/myzmtv7RWKcD4B2LB1pQ6VJVj/upm3PYad0YwxcCTvIC/G3q3fUkWS4EYpg==
X-Received: by 2002:a05:6a00:1901:b0:44b:e041:f07f with SMTP id y1-20020a056a00190100b0044be041f07fmr31906409pfi.52.1636962968263;
        Sun, 14 Nov 2021 23:56:08 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.223])
        by smtp.gmail.com with ESMTPSA id e10sm15792796pfv.140.2021.11.14.23.56.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:56:07 -0800 (PST)
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
Subject: [PATCH v6 04/23] mm/uffd: PTE_MARKER_UFFD_WP
Date:   Mon, 15 Nov 2021 15:55:03 +0800
Message-Id: <20211115075522.73795-5-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the 1st user of pte marker: the uffd-wp marker.

When the pte marker is installed with the uffd-wp bit set, it means this pte
was wr-protected by uffd.

We will use this special pte to arm the ptes that got either unmapped or
swapped out for a file-backed region that was previously wr-protected.  This
special pte could trigger a page fault just like swap entries.

This idea is greatly inspired by Hugh and Andrea in the discussion, which is
referenced in the links below.

Some helpers are introduced to detect whether a swap pte is uffd wr-protected.
After the pte marker introduced, one swap pte can be wr-protected in two forms:
either it is a normal swap pte and it has _PAGE_SWP_UFFD_WP set, or it's a pte
marker that has PTE_MARKER_UFFD_WP set.

Link: https://lore.kernel.org/lkml/20201126222359.8120-1-peterx@redhat.com/
Link: https://lore.kernel.org/lkml/20201130230603.46187-1-peterx@redhat.com/
Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h       |  3 ++-
 include/linux/userfaultfd_k.h | 38 +++++++++++++++++++++++++++++++++++
 mm/Kconfig                    |  9 +++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 5103d2a4ae38..2cec3ef355a7 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -249,7 +249,8 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
 
 typedef unsigned long pte_marker;
 
-#define  PTE_MARKER_MASK     (0)
+#define  PTE_MARKER_UFFD_WP  BIT(0)
+#define  PTE_MARKER_MASK     (PTE_MARKER_UFFD_WP)
 
 #ifdef CONFIG_PTE_MARKER
 
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 33cea484d1ad..7d7ffec53ddb 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -15,6 +15,8 @@
 
 #include <linux/fcntl.h>
 #include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 #include <asm-generic/pgtable_uffd.h>
 
 /* The set of all possible UFFD-related VM flags. */
@@ -236,4 +238,40 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 
 #endif /* CONFIG_USERFAULTFD */
 
+static inline bool is_pte_marker_uffd_wp(pte_t pte)
+{
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
+	swp_entry_t entry;
+
+	if (!is_swap_pte(pte))
+		return false;
+
+	entry = pte_to_swp_entry(pte);
+
+	return is_pte_marker_entry(entry) &&
+	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
+#else
+	return false;
+#endif
+}
+
+/*
+ * Returns true if this is a swap pte and was uffd-wp wr-protected in either
+ * forms (pte marker or a normal swap pte), false otherwise.
+ */
+static inline bool pte_swp_uffd_wp_any(pte_t pte)
+{
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
+	if (!is_swap_pte(pte))
+		return false;
+
+	if (pte_swp_uffd_wp(pte))
+		return true;
+
+	if (is_pte_marker_uffd_wp(pte))
+		return true;
+#endif
+	return false;
+}
+
 #endif /* _LINUX_USERFAULTFD_K_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 66f23c6c2032..f01c8e0afadf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -904,6 +904,15 @@ config PTE_MARKER
 	help
 	  Allows to create marker PTEs for file-backed memory.
 
+config PTE_MARKER_UFFD_WP
+	bool "Marker PTEs support for userfaultfd write protection"
+	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP
+
+	help
+	  Allows to create marker PTEs for userfaultfd write protection
+	  purposes.  It is required to enable userfaultfd write protection on
+	  file-backed memory types like shmem and hugetlbfs.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.32.0

