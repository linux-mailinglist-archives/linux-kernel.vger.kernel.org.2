Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535C538A033
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhETIwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:52:12 -0400
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:35867 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229536AbhETIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:52:11 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id 9B296FAB59
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:50:49 +0100 (IST)
Received: (qmail 11710 invoked from network); 20 May 2021 08:50:49 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:50:49 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 14/14] mm/swap: Make NODE_DATA an inline function on CONFIG_FLATMEM
Date:   Thu, 20 May 2021 09:48:09 +0100
Message-Id: <20210520084809.8576-15-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning in mm/workingset.c for allnoconfig

  mm/workingset.c: In function ‘unpack_shadow’:
  mm/workingset.c:201:15: warning: variable ‘nid’ set but not used [-Wunused-but-set-variable]
    int memcgid, nid;
                 ^~~

On FLATMEM, NODE_DATA returns a global pglist_data without dereferencing
nid. Make the helper an inline function to suppress the warning, add type
checking and to apply any side-effects in the parameter list.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0d53eba1c383..8af2f9ff9737 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1044,7 +1044,10 @@ extern char numa_zonelist_order[];
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 
 extern struct pglist_data contig_page_data;
-#define NODE_DATA(nid)		(&contig_page_data)
+static inline struct pglist_data *NODE_DATA(int nid)
+{
+	return &contig_page_data;
+}
 #define NODE_MEM_MAP(nid)	mem_map
 
 #else /* CONFIG_NEED_MULTIPLE_NODES */
-- 
2.26.2

