Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5C93BC201
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhGERI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGERIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:08:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96078C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 10:05:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a6so25480547ljq.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGMvtUgewm/pnTgoaVGJAzPLbufZv86mnnPtFfh0Rgo=;
        b=POfF5dlOAdmirxobhHMh3TJy78VntyYxGctMCRvmdH17frLPfVcpL6Bik8V67t+wYd
         VnFqYFQYOgsgu8FkQY0cYi0JGHMipTwPgVtfVOomtdSK44Ypx8E9ZzLbyIklBSEi6k4D
         O1JjI1p+mpFgVp6VujJP8CxZh03xLstElCHcDd1v0nzDX1Mk8/efXzC3S0SlA3i1G8p7
         EI0VbI7wuCaIxWWCBfB7laIWjzJu/J9ynZFw8d9/PlNUK3PhNQ9gFEU5f7GDZ1Ri5gbh
         pQEmquESWjnuXracA3Jmzg9kEckDbxRU3eFBlIZjDKFbXb0U5o1p6igiGz9C1pIn4Ibg
         pqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGMvtUgewm/pnTgoaVGJAzPLbufZv86mnnPtFfh0Rgo=;
        b=Ki+mQ/E3nHvIU5kOFF9wmx0aRjqRt1acOsmF/T0l4B6ss/9rLQvCdaP49PgEHb6X9W
         rrN/zoI0UygLYTSDIyQCjK3tb5y8hklBtH+D5JKEvcl1XDtKJaFCmRILN1ThrQVKd7UN
         Igf456a/mXt7vdldlA6I9l5aIuaGWA/FgDWjrMcDXE4YPc1GjJNttrVtk95U31aRyY5b
         kxG5DAIPUxvm1L200FPOnKzyU1Pdg42vGRtI0X8RgtkEdzb9GnehXZXXh/KycuEWVetY
         fKjNLx/fG//5tahEqJBEbkK7oit5LgwlHSsklwm1N4VumPsnbrQ242wYOBuyKGPPQhN5
         F3QA==
X-Gm-Message-State: AOAM530XFLbBCXonmYfofMf+8IVxRXBC0LhUDi0eHJqooAYSBcyARpQa
        PeTTpg+aNBs6QdiUEfsigxI=
X-Google-Smtp-Source: ABdhPJyuObFZhY2YELGTG2rFayXoPBMoqNumzENOIcxR/n/t5JQmlDGjeZHOfarJGgrpZJLsfn+Gug==
X-Received: by 2002:a2e:9710:: with SMTP id r16mr11783059lji.366.1625504746913;
        Mon, 05 Jul 2021 10:05:46 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id k12sm578501lfv.14.2021.07.05.10.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 10:05:46 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/2] mm/vmalloc: Use batched page requests in bulk-allocator
Date:   Mon,  5 Jul 2021 19:05:36 +0200
Message-Id: <20210705170537.43060-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of simultaneous vmalloc allocations, for example it is 1GB and
12 CPUs my system is able to hit "BUG: soft lockup" for !CONFIG_PREEMPT
kernel.

<snip>
[   62.512621] RIP: 0010:__alloc_pages_bulk+0xa9f/0xbb0
[   62.512628] Code: ff 8b 44 24 48 44 29 f8 83 f8 01 0f 84 ea fe ff ff e9 07 f6 ff ff 48 8b 44 24 60 48 89 28 e9 00 f9 ff ff fb 66 0f 1f 44 00 00 <e9> e8 fd ff ff 65 48 01 51 10 e9 3e fe ff ff 48 8b 44 24 78 4d 89
[   62.512629] RSP: 0018:ffffa7bfc29ffd20 EFLAGS: 00000206
[   62.512631] RAX: 0000000000000200 RBX: ffffcd5405421888 RCX: ffff8c36ffdeb928
[   62.512632] RDX: 0000000000040000 RSI: ffffa896f06b2ff8 RDI: ffffcd5405421880
[   62.512633] RBP: ffffcd5405421880 R08: 000000000000007d R09: ffffffffffffffff
[   62.512634] R10: ffffffff9d63c084 R11: 00000000ffffffff R12: ffff8c373ffaeb80
[   62.512635] R13: ffff8c36ffdf65f8 R14: ffff8c373ffaeb80 R15: 0000000000040000
[   62.512637] FS:  0000000000000000(0000) GS:ffff8c36ffdc0000(0000) knlGS:0000000000000000
[   62.512638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.512639] CR2: 000055c8e2fe8610 CR3: 0000000c13e10000 CR4: 00000000000006e0
[   62.512641] Call Trace:
[   62.512646]  __vmalloc_node_range+0x11c/0x2d0
[   62.512649]  ? full_fit_alloc_test+0x140/0x140 [test_vmalloc]
[   62.512654]  __vmalloc_node+0x4b/0x70
[   62.512656]  ? fix_size_alloc_test+0x44/0x60 [test_vmalloc]
[   62.512659]  fix_size_alloc_test+0x44/0x60 [test_vmalloc]
[   62.512662]  test_func+0xe7/0x1f0 [test_vmalloc]
[   62.512666]  ? fix_align_alloc_test+0x50/0x50 [test_vmalloc]
[   62.512668]  kthread+0x11a/0x140
[   62.512671]  ? set_kthread_struct+0x40/0x40
[   62.512672]  ret_from_fork+0x22/0x30
<snip>

To address this issue invoke a bulk-allocator many times until all pages
are obtained, i.e. do batched page requests adding cond_resched() meanwhile
to reschedule. Batched value is hard-coded and is 100 pages per call.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index aaad569e8963..5297958ac7c5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2785,10 +2785,32 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * to fails, fallback to a single page allocator that is
 	 * more permissive.
 	 */
-	if (!order)
-		nr_allocated = alloc_pages_bulk_array_node(
-			gfp, nid, nr_pages, pages);
-	else
+	if (!order) {
+		while (nr_allocated < nr_pages) {
+			int nr, nr_pages_request;
+
+			/*
+			 * A maximum allowed request is hard-coded and is 100
+			 * pages per call. That is done in order to prevent a
+			 * long preemption off scenario in the bulk-allocator
+			 * so the range is [1:100].
+			 */
+			nr_pages_request = min(100, (int)(nr_pages - nr_allocated));
+
+			nr = alloc_pages_bulk_array_node(gfp, nid,
+				nr_pages_request, pages + nr_allocated);
+
+			nr_allocated += nr;
+			cond_resched();
+
+			/*
+			 * If zero or pages were obtained partly,
+			 * fallback to a single page allocator.
+			 */
+			if (nr != nr_pages_request)
+				break;
+		}
+	} else
 		/*
 		 * Compound pages required for remap_vmalloc_page if
 		 * high-order pages.
-- 
2.20.1

