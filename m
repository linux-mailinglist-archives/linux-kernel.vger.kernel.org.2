Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7097331858
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCHUVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCHUU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:20:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01DEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 12:20:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so3815802pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 12:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=csGvzyVxMjdQkcW+Isd77wk7YphcfPE9DgicYzGkyLE=;
        b=ehsPqZWxk85w4HGbpw9PXVVdgMdfSGJvH685P2AwQapZ1TQGdgn75UQNV1tj9YkoVy
         0mgUL+Z3/F2OhIBZIqJnXoTaGpOEZs+G7KD6j/zOACgYPx24CMQIX4qNazvOx6dzSKCa
         rTqfbG/W7xqdmSVOriErC/aux/8wVOTu0t51lO1g7nc3AQEmE3/NJK5lu777SEUe/UWI
         T7P/XFkojV2OUF4OwAuL9gWgbRs+sGDZmmLYo9VCopU49+gDKuKkoqGGRGjpTbnL1ycA
         zWe7QTjRGB/Uy9w4STy5dozxmgDPsjvwPxEWaicFZIvyVw0W1Yu82Qg65jcpYSYEgGwD
         euVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=csGvzyVxMjdQkcW+Isd77wk7YphcfPE9DgicYzGkyLE=;
        b=JYDbum1DgAkdkWlw5kUZnS575UBREjcJbumvUKoYogOmyBf1O6wu/ntb2/xlQZ7d/c
         2rNa25ExOWmW3eV90QBakjb3sBjsCd1oMmQD94Oeutq9acmpJaUauqKeut56G01HK2YS
         BlFHN2SZOrKBytuZwDGLSIZD/FDdBVsKyQwNQTz1y4VnHEfE7vfHmUXzbzpj+tuJ1zmy
         Dc9LeKEx9xZyjFA64XEz2fGeLHPIrsueDaA6iJ/SIS3RnFuhXoeIyhTfYpdVSH1lOEeA
         kEgCtYHOZIAy5sggwYP1XgBzyQ+E1xFh62oYHMaPsX31BDirz1B3s9rp2IELzBDC7Ndn
         uUyw==
X-Gm-Message-State: AOAM532hWYB1ePlm3AePo3LOa0aEDfjEhgPMDjlC2CT7iFkG2oHhKne4
        yyPuikuICZZtv9OcFAA+tmI=
X-Google-Smtp-Source: ABdhPJw2BopEs7NcQbmzx23rnm0ntcqcZ9j4B5IC2fBwB+PNRppULRwJ1K2odDzBIiiE/4q13Huh3A==
X-Received: by 2002:a17:903:2283:b029:e4:8a:d7cb with SMTP id b3-20020a1709032283b02900e4008ad7cbmr23015562plh.5.1615234855395;
        Mon, 08 Mar 2021 12:20:55 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id b15sm10987910pgj.84.2021.03.08.12.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:20:54 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Date:   Mon,  8 Mar 2021 12:20:47 -0800
Message-Id: <20210308202047.1903802-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_contig_range is usually used on cma area or movable zone.
It's critical if the page migration fails on those areas so
dump more debugging message.

page refcount, mapcount with page flags on dump_page are
helpful information to deduce the culprit. Furthermore,
dump_page_owner was super helpful to find long term pinner
who initiated the page allocation.

Admin could enable the dump like this(by default, disabled)

	echo "func dump_migrate_failure_pages +p" > control

Admin could disable it.

	echo "func dump_migrate_failure_pages =_" > control

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v1 - https://lore.kernel.org/linux-mm/20210217163603.429062-1-minchan@kernel.org/
  * use dynamic debugging with system wide instead of per-call site - mhocko

 mm/page_alloc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..bb0aeca2069c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8453,6 +8453,34 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
 				pageblock_nr_pages));
 }
 
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+static DEFINE_RATELIMIT_STATE(alloc_contig_ratelimit_state,
+		DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+int alloc_contig_ratelimit(void)
+{
+	return __ratelimit(&alloc_contig_ratelimit_state);
+}
+
+void dump_migrate_failure_pages(struct list_head *page_list)
+{
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
+			"migrate failure");
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
+			alloc_contig_ratelimit()) {
+		struct page *page;
+
+		WARN(1, "failed callstack");
+		list_for_each_entry(page, page_list, lru)
+			dump_page(page, "migration failure");
+	}
+}
+#else
+static inline void dump_migrate_failure_pages(struct list_head *page_list)
+{
+}
+#endif
+
 /* [start, end) must belong to a single zone. */
 static int __alloc_contig_migrate_range(struct compact_control *cc,
 					unsigned long start, unsigned long end)
@@ -8496,6 +8524,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
 	if (ret < 0) {
+		dump_migrate_failure_pages(&cc->migratepages);
 		putback_movable_pages(&cc->migratepages);
 		return ret;
 	}
-- 
2.30.1.766.gb4fecdf3b7-goog

