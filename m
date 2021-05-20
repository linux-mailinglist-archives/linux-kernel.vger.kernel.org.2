Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BEE38A02F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhETIvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:51:51 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:36127 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231222AbhETIvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:51:50 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id 766E6FAB48
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:50:28 +0100 (IST)
Received: (qmail 10639 invoked from network); 20 May 2021 08:50:28 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:50:28 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 12/14] mm/mmap_lock: Remove dead code for !CONFIG_TRACING configurations
Date:   Thu, 20 May 2021 09:48:07 +0100
Message-Id: <20210520084809.8576-13-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning in mmap_lock.c for allnoconfig

  mm/mmap_lock.c:213:6: warning: no previous prototype for ‘__mmap_lock_do_trace_start_locking’ [-Wmissing-prototypes]
   void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  mm/mmap_lock.c:219:6: warning: no previous prototype for ‘__mmap_lock_do_trace_acquire_returned’ [-Wmissing-prototypes]
   void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  mm/mmap_lock.c:226:6: warning: no previous prototype for ‘__mmap_lock_do_trace_released’ [-Wmissing-prototypes]
   void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)

On !CONFIG_TRACING configurations, the code is dead so put it behind
an #ifdef.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/mmap_lock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index dcdde4f722a4..03ee85c696ef 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -205,6 +205,7 @@ void trace_mmap_lock_unreg(void)
 
 #endif /* CONFIG_MEMCG */
 
+#ifdef CONFIG_TRACING
 /*
  * Trace calls must be in a separate file, as otherwise there's a circular
  * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
@@ -228,3 +229,4 @@ void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
 	TRACE_MMAP_LOCK_EVENT(released, mm, write);
 }
 EXPORT_SYMBOL(__mmap_lock_do_trace_released);
+#endif /* CONFIG_TRACING */
-- 
2.26.2

