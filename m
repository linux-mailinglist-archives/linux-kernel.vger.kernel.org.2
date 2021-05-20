Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1122538A018
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhETIuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:50:05 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:60303 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231179AbhETIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:50:03 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 09E75FAB50
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:48:42 +0100 (IST)
Received: (qmail 3920 invoked from network); 20 May 2021 08:48:41 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:48:41 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 02/14] mm/vmalloc: Include header for prototype of set_iounmap_nonlazy
Date:   Thu, 20 May 2021 09:47:57 +0100
Message-Id: <20210520084809.8576-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for mm/vmalloc.c

  mm/vmalloc.c:1599:6: warning: no previous prototype for ‘set_iounmap_nonlazy’ [-Wmissing-prototypes]
   void set_iounmap_nonlazy(void)
        ^~~~~~~~~~~~~~~~~~~

This is an arch-generic function only used by x86. On other arches,
it's dead code. Include the header with the definition and make
it x86-64 specific.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a13ac524f6ff..0522a418b1c5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -36,6 +36,7 @@
 #include <linux/overflow.h>
 #include <linux/pgtable.h>
 #include <linux/uaccess.h>
+#include <linux/io.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
@@ -1592,6 +1593,7 @@ static DEFINE_MUTEX(vmap_purge_lock);
 /* for per-CPU blocks */
 static void purge_fragmented_blocks_allcpus(void);
 
+#ifdef CONFIG_X86_64
 /*
  * called before a call to iounmap() if the caller wants vm_area_struct's
  * immediately freed.
@@ -1600,6 +1602,7 @@ void set_iounmap_nonlazy(void)
 {
 	atomic_long_set(&vmap_lazy_nr, lazy_max_pages()+1);
 }
+#endif /* CONFIG_X86_64 */
 
 /*
  * Purges all lazily-freed vmap areas.
-- 
2.26.2

