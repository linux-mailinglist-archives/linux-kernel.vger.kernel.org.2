Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125DA3E32F3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 05:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhHGDZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 23:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhHGDZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 23:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628306727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M89IpDmqpLb2E2sKYTfviaRjvA8qgBHjWuv99Q1xOu4=;
        b=en9Soz2BWBLUZI6eKo7OXvaY9RvpL7ELntwXVmK0KAtQHXSceQHYEKSWDcZguAdVJIcDvy
        PbzHeODpiVeN6U/0+PHvNXprdA9ncVnwtsudWt9lv3Qtard7dK2uLfLhADgoZOLNKTPWg1
        jo1NdtbllRDbCMX9b26PwHaW19/4l00=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-BJMo-Cu_Mqm2_oWwNnBpFQ-1; Fri, 06 Aug 2021 23:25:26 -0400
X-MC-Unique: BJMo-Cu_Mqm2_oWwNnBpFQ-1
Received: by mail-qv1-f72.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so7739530qvt.20
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 20:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M89IpDmqpLb2E2sKYTfviaRjvA8qgBHjWuv99Q1xOu4=;
        b=Uo+in0qgSCU1MX3ORJtUOJ/pglti/YnWwIBtvkZNj8JQXwJL1aYkiDBkaRMxpdgzss
         C/sIRm/GulBHOdgNFirfpSh0fNl90hSmsqko+4S1MYyKDLC63t7/hSeVi/oK+dTn0JXX
         2KeJVvFx4hknwMXxisnGiBXmyNzfsGxc3OLESyC6qQA2AIgmmtmlFnHOtaE1yrLGmd9J
         YtRSpP6I5Cl/cLlmFC9LKooO9Beg8EhcW6LDaO+WddkFJED7vULmiUhfNTMlAY/wb4Kp
         zloU824RzMkw1B7mi0Eh9P8Ee7Aw5GvWzMNSaZDtbpFI1yIgIsEi7fj2OOUvHGacqCe5
         AS9g==
X-Gm-Message-State: AOAM531oKGNoALim1FyyAHnMkaf6VRtICCaxdsyg9MwUUkxeWcDaq5Qv
        7Ro5s1x8HTg10pcGYnVp02x6UI7Ne3tZ+kyOADXzK4CEDtWrCqCmw+72JVXMxEc3TZjP3lKY5y4
        OCET3i9uSWOhEuCGNJurlnZEJsimstUEyqcwW598/aZ31+4zS9QKgodHQgRdAL3BFPIPp/ImrOg
        ==
X-Received: by 2002:a05:620a:20d3:: with SMTP id f19mr13477931qka.304.1628306725829;
        Fri, 06 Aug 2021 20:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwudqdogHpREEXwWEO5+43wkxQbUYyM7tOd7/XM0TXNcdPIMwjzcLULEbq1V0TujbxiOXrmmw==
X-Received: by 2002:a05:620a:20d3:: with SMTP id f19mr13477901qka.304.1628306725555;
        Fri, 06 Aug 2021 20:25:25 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id a5sm5514875qkk.92.2021.08.06.20.25.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 20:25:25 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        ivan.teterevkov@nutanix.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC 1/4] mm: Introduce PTE_MARKER swap entry
Date:   Fri,  6 Aug 2021 23:25:18 -0400
Message-Id: <20210807032521.7591-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807032521.7591-1-peterx@redhat.com>
References: <20210807032521.7591-1-peterx@redhat.com>
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

The first marker bit that is introduced together with the new swap pte is the
PAGEOUT marker.  When that bit is set, it means this pte used to point to a
page which got swapped out.  It's mostly a definition so the swap type is not
totally nothing, however the functions are not implemented yet to handle the
new swap type.

A new config CONFIG_PTE_MARKER is introduced too; it's by default off.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swap.h    | 14 ++++++++++++-
 include/linux/swapops.h | 45 +++++++++++++++++++++++++++++++++++++++++
 mm/Kconfig              | 17 ++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6f5a43251593..545dc8e0b0fb 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -55,6 +55,18 @@ static inline int current_is_kswapd(void)
  * actions on faults.
  */
 
+/*
+ * PTE markers are used to persist information onto PTEs that are mapped with
+ * file-backed memories.
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
@@ -100,7 +112,7 @@ static inline int current_is_kswapd(void)
 
 #define MAX_SWAPFILES \
 	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
-	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM)
+	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - SWP_PTE_MARKER_NUM)
 
 /*
  * Magic header for a swap area. The first part of the union is
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d356ab4047f7..3fec83449e1e 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -247,6 +247,51 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
 
 #endif
 
+#ifdef CONFIG_PTE_MARKER
+
+#ifdef CONFIG_PTE_MARKER_PAGEOUT
+/* When this bit is set, it means this page is swapped out previously */
+#define  PTE_MARKER_PAGEOUT  (1UL << 0)
+#else
+#define  PTE_MARKER_PAGEOUT  0
+#endif
+
+#define  PTE_MARKER_MASK     (PTE_MARKER_PAGEOUT)
+
+static inline swp_entry_t make_pte_marker_entry(unsigned long marker)
+{
+	return swp_entry(SWP_PTE_MARKER, marker);
+}
+
+static inline bool is_pte_marker_entry(swp_entry_t entry)
+{
+	return swp_type(entry) == SWP_PTE_MARKER;
+}
+
+static inline unsigned long pte_marker_get(swp_entry_t entry)
+{
+	return swp_offset(entry) & PTE_MARKER_MASK;
+}
+
+#else /* CONFIG_PTE_MARKER */
+
+static inline swp_entry_t make_pte_marker_entry(unsigned long marker)
+{
+	return swp_entry(0, 0);
+}
+
+static inline bool is_pte_marker_entry(swp_entry_t entry)
+{
+	return false;
+}
+
+static inline unsigned long pte_marker_get(swp_entry_t entry)
+{
+	return 0;
+}
+
+#endif /* CONFIG_PTE_MARKER */
+
 static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 {
 	struct page *p = pfn_to_page(swp_offset(entry));
diff --git a/mm/Kconfig b/mm/Kconfig
index 40a9bfcd5062..6043d8f1c066 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -889,4 +889,21 @@ config IO_MAPPING
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
 
+config PTE_MARKER
+        def_bool n
+        bool "Marker PTEs support"
+
+	help
+	  Allows to create marker PTEs for file-backed memory.
+
+config PTE_MARKER_PAGEOUT
+        def_bool n
+        depends on PTE_MARKER
+        bool "Shmem pagemap PM_SWAP support"
+
+	help
+	  Allows to create marker PTEs for file-backed memory when the page is
+	  swapped out.  It's required for pagemap to work correctly with shmem
+	  on page swapping.
+
 endmenu
-- 
2.32.0

