Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78543F922E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 04:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbhH0CCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 22:02:48 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37610 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhH0CCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 22:02:47 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1mJRBp-0005il-UE; Thu, 26 Aug 2021 22:01:53 -0400
Date:   Thu, 26 Aug 2021 22:01:49 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, stable@kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH] mm,vmscan: fix divide by zero in get_scan_count
Message-ID: <20210826220149.058089c6@imladris.surriel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to
proportional memory.low reclaim") introduced a divide by zero corner
case when oomd is being used in combination with cgroup memory.low
protection.

When oomd decides to kill a cgroup, it will force the cgroup memory
to be reclaimed after killing the tasks, by writing to the memory.max
file for that cgroup, forcing the remaining page cache and reclaimable
slab to be reclaimed down to zero.

Previously, on cgroups with some memory.low protection that would result
in the memory being reclaimed down to the memory.low limit, or likely not
at all, having the page cache reclaimed asynchronously later.

With f56ce412a59d the oomd write to memory.max tries to reclaim all the
way down to zero, which may race with another reclaimer, to the point of
ending up with the divide by zero below.

This patch implements the obvious fix.

Fixes: f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to proportional memory.low reclaim")
Signed-off-by: Rik van Riel <riel@surriel.com>

diff --git a/mm/vmscan.c b/mm/vmscan.c
index eeae2f6bc532..f1782b816c98 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2592,7 +2592,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			cgroup_size = max(cgroup_size, protection);
 
 			scan = lruvec_size - lruvec_size * protection /
-				cgroup_size;
+				(cgroup_size + 1);
 
 			/*
 			 * Minimally target SWAP_CLUSTER_MAX pages to keep

