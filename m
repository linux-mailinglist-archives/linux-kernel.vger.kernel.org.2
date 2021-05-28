Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9871B3944CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 17:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhE1PLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 11:11:54 -0400
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:40635 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230039AbhE1PLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 11:11:48 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 083501935
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 16:10:12 +0100 (IST)
Received: (qmail 7428 invoked from network); 28 May 2021 15:10:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 May 2021 15:10:11 -0000
Date:   Fri, 28 May 2021 16:10:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [PATCH] mm/page_alloc: Introduce vm.percpu_pagelist_high_fraction
 -fix
Message-ID: <20210528151010.GQ30378@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil Babka pointed out that the documentation for
vm.percpu_pagelist_high_fraction is potentially misleading so fix it.

This is a fix to the mmotm patch
mm-page_alloc-introduce-vmpercpu_pagelist_high_fraction.patch

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 Documentation/admin-guide/sysctl/vm.rst | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index e85c2f21d209..2da25735a629 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -793,15 +793,16 @@ why oom happens. You can get snapshot.
 percpu_pagelist_high_fraction
 =============================
 
-This is the fraction of pages in each zone that are allocated for each
-per cpu page list.  The min value for this is 8.  It means that we do
-not allow more than 1/8th of pages in each zone to be allocated in any
-single per_cpu_pagelist.  This entry only changes the value of hot per
-cpu pagelists. User can specify a number like 100 to allocate 1/100th
-of each zone to each per cpu page list.
-
-The batch value of each per cpu pagelist remains the same regardless of the
-value of the high fraction so allocation latencies are unaffected.
+This is the fraction of pages in each zone that are can be stored to
+per-cpu page lists. It is an upper boundary that is divided depending
+on the number of online CPUs. The min value for this is 8 which means
+that we do not allow more than 1/8th of pages in each zone to be stored
+on per-cpu page lists. This entry only changes the value of hot per-cpu
+page lists. A user can specify a number like 100 to allocate 1/100th of
+each zone between per-cpu lists.
+
+The batch value of each per-cpu page list remains the same regardless of
+the value of the high fraction so allocation latencies are unaffected.
 
 The initial value is zero. Kernel uses this value to set the high pcp->high
 mark based on the low watermark for the zone and the number of local
