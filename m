Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D91334631
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhCJSBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhCJSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:01:09 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E61C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:01:09 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e6so11902892pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jmoenAGMFpKHfMNt6zq7dsNBrDUYlAgJfLcxbv2cwY=;
        b=DSDRCT2Gn+BkaXVqZYpRnM7Vhl8kTYeebkTTSNqc3y/R+hb3F3LaGSctN8hAACu8uU
         elN/UzMtTqpKCHQBiyFOJiubnRHsoveuM8VqSRjPWzZDXq9XiecLx5mVmSz/LKqtLqZo
         7HvM9Z6lk92sjl9yJ1au8+pZSyqWM1fvkiUl4mcGLdPtzy1JlMdTFUYrIw1GcPSYBFUd
         tPwipmpQRHoZn0H4A3vkjF38cUtcDdmrcm1AcoijWUlVE4uG5V/+u5XP0uUREbfQ/2im
         Fc3Ligirw05nZA5HdqP4gXTnEGNs4ETlwRS7lgHm2onoBfgaTTeaV4em9NDqSAKHe8mH
         XQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9jmoenAGMFpKHfMNt6zq7dsNBrDUYlAgJfLcxbv2cwY=;
        b=MR20fNUIJ5TTSkuvP8I6c2ddXW8R+m1WOKsaMrTG+0s47Kx4KAL8yeP0mUBZ7L+Ofc
         Z7Uo/jEKRXPvfSYfSV33OIFYNoSL6g0pxAjhTkDUJIFGiG3ptdRe78SUE9/9K7Kgy55L
         pVN7j7yhBYaIR1nqaNf2JqW3pinHZ3cbJ6vgHV3f8tdcZjEUHlDuBRsK98NfJaEWNRc0
         NiIqWQG2KuD+YjvrvTH7HNSbqDYQGT99LKCTNGgKo7dbcUWDoufbLG9ZKStpp3oztk5o
         2Bl+ykXbGar+Po8PreihXPbdDquH2hsZeDQm4isc3eLuehMjHes/im03zxkzJEG+hsWJ
         h3jg==
X-Gm-Message-State: AOAM530RCGMH09y2Q91je0PmU50dvMdPtFpQ8ff/j3vjaSlfQnhw4qzV
        +AYUo2zK0tHKh24SV/cbZg4=
X-Google-Smtp-Source: ABdhPJwzWYaUv5g003e42TPTQsAVKPBZ10h8/tuAidHFZ0TQfUXW/Oxu4Xxn3w9OBBdo3pAwzS81TA==
X-Received: by 2002:a63:cd09:: with SMTP id i9mr3806659pgg.407.1615399269162;
        Wed, 10 Mar 2021 10:01:09 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id 35sm217683pgr.14.2021.03.10.10.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 10:01:08 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3] mm: page_alloc: dump migrate-failed pages
Date:   Wed, 10 Mar 2021 10:01:04 -0800
Message-Id: <20210310180104.517886-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
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

	echo "func dump_migrate_failure_pages +p" > control

Admin could disable it.

	echo "func dump_migrate_failure_pages =_" > control

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
* from v2 - https://lore.kernel.org/linux-mm/20210308202047.1903802-1-minchan@kernel.org/
  * remove ratelimit - mhocko

* from v1 - https://lore.kernel.org/linux-mm/20210217163603.429062-1-minchan@kernel.org/
  * use dynamic debugging with system wide instead of per-call site - mhocko

 mm/page_alloc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..f42f3e208794 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8453,6 +8453,27 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
 				pageblock_nr_pages));
 }
 
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+static void alloc_contig_dump_pages(struct list_head *page_list)
+{
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
+			"migrate failure");
+
+	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
+		struct page *page;
+
+		WARN(1, "failed callstack");
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
@@ -8496,6 +8517,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
 	if (ret < 0) {
+		alloc_contig_dump_pages(&cc->migratepages);
 		putback_movable_pages(&cc->migratepages);
 		return ret;
 	}
-- 
2.30.1.766.gb4fecdf3b7-goog

