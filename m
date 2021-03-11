Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01585337E54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCKTlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhCKTks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:40:48 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFD5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:40:47 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 16so7907407pgo.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LalnUbYf3ptXykE/fAOITuo1+VnkRoBvM429zzABfbw=;
        b=QH29SGQv+qsfrY41BlWBCcR/c2jDruOpA9TAaYWeoasgmytXsqzci0c823NzjDj0Ro
         XyWzpCzjwptQ+6PKMTLnBYDgNspqbEM4QppGppJtu7qFnpRscNSYdhIQoR/wAmKKv7s/
         2DGWXNNnmubpk8YUYEiZ9S+nDpMFd8FLRqs77caG4Lfq6Y6ToTuE18cTk7IsPK/28+In
         yg3Pj6Fq1iVKThomdPxQ//TOtXD7Fm7kNDIRRyY6v2efLWqilv3jjNGrO0X9ceMjHkNy
         ZLj4pOnV82V/hcLM3Iu3NKtxP3RMqPKLkrAa5YyZmKt7W72fGdVYTjkJ4oq9TgUCKR9Y
         1LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LalnUbYf3ptXykE/fAOITuo1+VnkRoBvM429zzABfbw=;
        b=KPUxCvwYWa8tUSGPgwTBhKISNo/5zk7j1/EqPlilz4EE9XTsxRCovLLd4/4P+OwO4S
         CEaSs+RTsr/8tPvYjFSFWT4szZqxoRZxbxDRNbYTzGIXcdcBKaU8XExkY3VfDhR0RSul
         8URW5sFeHNJRw0Zoa3I63geyEDK1cTpJ6ixylz6R7uVqPmzyjYxU2/cNStl8VB0O0bbs
         L/ropF95zU5iVTeP40hmm2uBRWxlP5d/VNdTUS4uZIviA4OFqc2kvqR/O5k/JVAs5iyq
         e5CmW+cOkiJUYa2yFhBWKWU4FNqksBzMEa1syu3RhVLqSWGRUp1YQbKxx5wKTS4422oh
         RBKQ==
X-Gm-Message-State: AOAM532GWCn/YwHGO6uW0qWiU6EOhWDhe01zD+vni0j91n7p3AF0PQfQ
        351yHKdZxRbkwtesMj8d30M=
X-Google-Smtp-Source: ABdhPJwKSdw3/TfsN8wIXuBnCAgQYOOM2hbHIv3zxJLQl4ktRA4SMuF+hzU8rSVY9On7VZeQW7AQfw==
X-Received: by 2002:a62:5bc4:0:b029:1fe:86f7:3a66 with SMTP id p187-20020a625bc40000b02901fe86f73a66mr5871557pfb.42.1615491647278;
        Thu, 11 Mar 2021 11:40:47 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id s194sm3251595pfs.57.2021.03.11.11.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:40:46 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v5] mm: page_alloc: dump migrate-failed pages
Date:   Thu, 11 Mar 2021 11:40:42 -0800
Message-Id: <20210311194042.825152-1-minchan@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, debugging CMA allocation failures is quite limited.
The most common source of these failures seems to be page
migration which doesn't provide any useful information on the
reason of the failure by itself. alloc_contig_range can report
those failures as it holds a list of migrate-failed pages.

The information logged by dump_page() has already proven helpful
for debugging allocation issues, like identifying long-term
pinnings on ZONE_MOVABLE or MIGRATE_CMA.

Let's use the dynamic debugging infrastructure, such that we
avoid flooding the logs and creating a lot of noise on frequent
alloc_contig_range() calls. This information is helpful for
debugging only.

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

A concern is utility functions in dump_page use inconsistent
loglevels. In the future, we might want to make the loglevels
used inside dump_page() consistent and eventually rework the way
we log the information here. See [1].

[1] https://lore.kernel.org/linux-mm/YEh4doXvyuRl5BDB@google.com/

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v4 - https://lore.kernel.org/linux-mm/20210311183047.805891-1-minchan@kernel.org/
  * better description - david
  * add reviewed-by - david

* from v3 - https://lore.kernel.org/linux-mm/20210310180104.517886-1-minchan@kernel.org
  * add dyndgb usage comment - akpm
  * use dumpstack instead of warn_on - david

* from v2 - https://lore.kernel.org/linux-mm/20210308202047.1903802-1-minchan@kernel.org/
  * remove ratelimit - mhocko

* from v1 - https://lore.kernel.org/linux-mm/20210217163603.429062-1-minchan@kernel.org/
  * use dynamic debugging with system wide instead of per-call site - mhocko

 mm/page_alloc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..d4b72b6682b6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8453,6 +8453,27 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
 				pageblock_nr_pages));
 }
 
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+/* Usage: See admin-guide/dynamic-debug-howto.rst */
+static void alloc_contig_dump_pages(struct list_head *page_list)
+{
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "migrate failure");
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
@@ -8496,6 +8517,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
 	if (ret < 0) {
+		alloc_contig_dump_pages(&cc->migratepages);
 		putback_movable_pages(&cc->migratepages);
 		return ret;
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

