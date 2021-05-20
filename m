Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A05738A020
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhETIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:50:32 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:42843 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231303AbhETIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:50:25 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 3EB531C399E
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:49:03 +0100 (IST)
Received: (qmail 5179 invoked from network); 20 May 2021 08:49:03 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:49:02 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 04/14] mm/mapping_dirty_helpers: Remove double Note in kerneldoc
Date:   Thu, 20 May 2021 09:47:59 +0100
Message-Id: <20210520084809.8576-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for mm/mapping_dirty_helpers.c

mm/mapping_dirty_helpers.c:325: warning: duplicate section name 'Note'

The helper function is very specific to one driver -- vmwgfx. While
the two notes are separate, all of it needs to be taken into account
when using the helper so make it one note.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/mapping_dirty_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index b890854ec761..ea734f248fce 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -317,7 +317,7 @@ EXPORT_SYMBOL_GPL(wp_shared_mapping_range);
  * pfn_mkwrite(). And then after a TLB flush following the write-protection
  * pick up all dirty bits.
  *
- * Note: This function currently skips transhuge page-table entries, since
+ * This function currently skips transhuge page-table entries, since
  * it's intended for dirty-tracking on the PTE level. It will warn on
  * encountering transhuge dirty entries, though, and can easily be extended
  * to handle them as well.
-- 
2.26.2

