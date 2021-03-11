Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA5B337CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhCKSbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCKSax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:30:53 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FD7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:30:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so3608298pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRdnc5SDeTexTqP3MNLjYUShpFLyOV3cOuJK17cu5t0=;
        b=Eaj7BV16iNhjkvv7eG9kOZ8zk1a4xmieMjdQxgljP4biZbBHY2uAqoNmKGJGJEJnEA
         M2cSgRjJLVejPbnNJ+rVEnXl90dYWv7w2tzA2lpPxnOz1hUtTemOZVy9V1pYWryz3JAt
         LFRGGfy4fHK0c3A1cjcc167ElOkhu33LZjXeap50pWivUFVnh9yfdiNY7cFNeWoHCaap
         /4NNFips0lYMT2/J3+MKl0dSyYdbHMkiI4eipFaLHZuOhM0bdeNSybJ6auM6NpIQ+3yj
         DGxQ67VcvpXgEavIpyT2nVj0OHfFzZCH8OPefqyplYFZNft1+Z8Bc3X0odViHIOieVPq
         7Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XRdnc5SDeTexTqP3MNLjYUShpFLyOV3cOuJK17cu5t0=;
        b=uI16/4t1r84Y1m9M8KqaLvaOlObieJ10T0ksgpRlfh9CrJuXXRlx+SuXLYzD2hNZcQ
         mtYXx23vMExZZsK6qXPST8fWEc3GLYhSu4uJmyvL4HQUbD0bNlBTJKqE0d4LK9GN3Q3b
         zSrsSEP4mwkxziNnzoj67JoIo9FUYycmcrfAjS4qqOJjwTdGl2NVUINotZRQezTe+Cki
         YFIXf6FTgxbTMwcyN7Xp1CgYzsn6ecGTFPO4X3mE81Zyx9wNQeFjKHQ6OE8wF2beQwpu
         2NVe9dlO1H1r+TUirnF16u/52qifO0sfCuEGrpePS2IufW6DB8olPIimcZ8SxPX1HU2O
         ciJw==
X-Gm-Message-State: AOAM533LRiwx3I9cenDqU4E3tnt6AjxgV7mj90Mf7QL3jUUwxcV9tF6m
        lPUNM1pCDLdfup58HH32UJE=
X-Google-Smtp-Source: ABdhPJzqBu2Y0YEvVsaYJofwr2522kQDsScN0UT+21p/DRbEssyzHF6cjwld6nLX4UJ+uxf3JZzCQg==
X-Received: by 2002:a17:902:6b42:b029:e6:733a:332 with SMTP id g2-20020a1709026b42b02900e6733a0332mr856614plt.35.1615487453005;
        Thu, 11 Mar 2021 10:30:53 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id k127sm3308590pfd.63.2021.03.11.10.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 10:30:51 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4] mm: page_alloc: dump migrate-failed pages
Date:   Thu, 11 Mar 2021 10:30:47 -0800
Message-Id: <20210311183047.805891-1-minchan@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, debugging CMA allocation failures is quite limited.
The most commong source of these failures seems to be page
migration which doesn't provide any useful information on the
reason of the failure by itself. alloc_contig_range can report
those failures as it holds a list of migrate-failed pages.

page refcount, mapcount with page flags on dump_page are
helpful information to deduce the culprit. Furthermore,
dump_page_owner was super helpful to find long term pinner
who initiated the page allocation.

The reason it approach with dynamic debug is the debug message
could emit lots of noises as alloc_contig_range calls more
frequently since it's a best effort allocator.

There are two ifdefery conditions to support common dyndbg options:

- CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE
It aims for supporting the feature with only specific file
with adding ccflags.

- CONFIG_DYNAMIC_DEBUG
It aims for supporting the feature with system wide globally.

A simple example to enable the feature:

Admin could enable the dump like this(by default, disabled)

	echo "func alloc_contig_dump_pages +p" > control

Admin could disable it.

	echo "func alloc_contig_dump_pages =_" > control

Detail goes Documentation/admin-guide/dynamic-debug-howto.rst

A concern is utility functions in dump_page uses inconsistent
loglevels.

__dump_page: KERN_WARNING
__dump_page_owner: KERN_ALERT
        stack_trace_print: KERN_DEFAULT

There are bunch of places to use the inconsistent loglevel
utility functions(e.g., just grep dump_page/strace_trace_print).
It's unfortunate but here we are. It could be addressed
different patchset.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v3 - https://lore.kernel.org/linux-mm/20210310180104.517886-1-minchan@kernel.org
  * add dyndgb usage comment - akpm
  * use dumpstack instead of warn_on - david

* from v2 - https://lore.kernel.org/linux-mm/20210308202047.1903802-1-minchan@kernel.org/
  * remove ratelimit - mhocko

* from v1 - https://lore.kernel.org/linux-mm/20210217163603.429062-1-minchan@kernel.org/
  * use dynamic debugging with system wide instead of per-call site - mhocko

 mm/page_alloc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..76fc202cb105 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8453,6 +8453,36 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
 				pageblock_nr_pages));
 }
 
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+/*
+ * usage)
+ * 	dyndbg_dir="/sys/kernel/debug/dynamic_debug"
+ * To enable:
+ * 	echo "func alloc_contig_dump_pages +p" > $dyndbg_dir/control
+ * To disable:
+ * 	echo "func alloc_contig_dump_pages =_" > $dyndbg_dir/control
+ * For detail, read dynamic-debug-howto.rst
+ */
+static void alloc_contig_dump_pages(struct list_head *page_list)
+{
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
+			"migrate failure");
+
+	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
+		struct page *page;
+
+		dump_stack();
+		list_for_each_entry(page, page_list, lru)
+			dump_page(page, "migration failure");
+	}
+}
+#else
+static inline void alloc_contig_dump_pages(struct list_head *page_list)
+{
+}
+#endif
+
 /* [start, end) must belong to a single zone. */
 static int __alloc_contig_migrate_range(struct compact_control *cc,
 					unsigned long start, unsigned long end)
@@ -8496,6 +8526,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
 	if (ret < 0) {
+		alloc_contig_dump_pages(&cc->migratepages);
 		putback_movable_pages(&cc->migratepages);
 		return ret;
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

