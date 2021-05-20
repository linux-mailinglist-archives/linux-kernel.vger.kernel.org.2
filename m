Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B238A02B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhETIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:51:20 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:39979 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231398AbhETIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:51:19 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 8A3371C3BF7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:49:56 +0100 (IST)
Received: (qmail 8544 invoked from network); 20 May 2021 08:49:56 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:49:56 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 09/14] mm/zbud: Add kerneldoc fields for zbud_pool
Date:   Thu, 20 May 2021 09:48:04 +0100
Message-Id: <20210520084809.8576-10-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for zbud_pool

  mm/zbud.c:105: warning: Function parameter or member 'zpool' not described in 'zbud_pool'
  mm/zbud.c:105: warning: Function parameter or member 'zpool_ops' not described in 'zbud_pool'

Commit 479305fd7172 ("zpool: remove zpool_evict()") removed the zpool_evict
helper and added the associated zpool and operations structure in struct
zbud_pool but did not add documentation for the fields. Add rudimentary
documentation.

Fixes: 479305fd7172 ("zpool: remove zpool_evict()")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/zbud.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zbud.c b/mm/zbud.c
index 7ec5f27a68b0..a200121da400 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -87,6 +87,8 @@
  * @pages_nr:	number of zbud pages in the pool.
  * @ops:	pointer to a structure of user defined operations specified at
  *		pool creation time.
+ * @zpool:	zpool driver
+ * @zpool_ops:	zpool operations structure with an evict callback
  *
  * This structure is allocated at pool creation time and maintains metadata
  * pertaining to a particular zbud pool.
-- 
2.26.2

