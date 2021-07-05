Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9961B3BBE88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhGEO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhGEO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:58:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D254C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 07:56:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c28so9503396lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yv5RwknvEQySeDC9OAlYHWoQ26Z/PWkUBzvHahNxvFo=;
        b=o7argocKDB8tA0Hdbbg7cYRYXiR4TrYWrlnGaXwlbSBE+9182XUWAaGXAKsmHF9gWa
         6+F8kvkgN9Z1mxteEc7QQEHCy9rp2RTucLav4YDdjqFH6hnEmeazOTxljowuOhZW5BN4
         GYKtQYrWOMvyOJCMbNhP2xui+KjGTezHKPmCW0/jNpMe1zq48A7iqemJZcmTN1lB+rc3
         SXkP72xASEtmrnpPI7UqJCLakyi8rteoUObdFEk5lvSBoaj7yOWYGnUxK6qFqLESaF2q
         R0qOUGR5UPc/pcsrTXjKgKWQxjoHI+AXRTzefAW5DWSXmsoJmVrzpvs5Uune5l182Q7Z
         f7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yv5RwknvEQySeDC9OAlYHWoQ26Z/PWkUBzvHahNxvFo=;
        b=UnWMrEnY6sSoWCOuhLKvnO/bCsrXBtgF+HFQhE7hE68OtEgfTupHgysXGgKR5Knc8l
         ys9qgAuhIs4FaFw4/odcOusTITeuKYz/YEk8h3PjrbCaoP4j2N/EmSVqKcjHrlF/2Wuc
         UY0Vmw3q+4X2qOvbMExmyUfoJ11UEMyMxgCu+LERWGNyh4vMLxzVf70J0EQfDhKYvuOY
         t7OJE5W8oEgaCd1w0jEUUowhJ1r6eTXOyRgiIayGmihWTOVfSooF8y8Ox9gvTl9Lm5RR
         gIEMkWOaY2aV5XOXT3oz1URDvUydtbGEUDuek+gIIL4g4QnFii0F34D/2NAKpVhoNTMk
         4syQ==
X-Gm-Message-State: AOAM5326ACeiKEpAz+eBk5o2ZoWF+xPvfjb5R3jlv8XSof7X4vXFTHcw
        rUOrayTao2Frt7yLcXFAp34=
X-Google-Smtp-Source: ABdhPJy3Z4VavKV2wXCzPYEEL12FeAebb7ybftnLZKtrYVuiw6tAarZc320nEdLbps10ACRL2Qi3WQ==
X-Received: by 2002:a05:6512:2601:: with SMTP id bt1mr10631219lfb.590.1625496959384;
        Mon, 05 Jul 2021 07:55:59 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i15sm1481816lja.135.2021.07.05.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:55:58 -0700 (PDT)
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
Subject: [PATCH] mm/vmalloc: Use batched page requests in bulk-allocator
Date:   Mon,  5 Jul 2021 16:55:47 +0200
Message-Id: <20210705145547.41206-1-urezki@gmail.com>
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
 mm/vmalloc.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index aaad569e8963..01ad46f97365 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2785,10 +2785,34 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
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
+
+			if (gfpflags_allow_blocking(gfp))
+				cond_resched();
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

