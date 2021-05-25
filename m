Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B346438FC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhEYIOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:14:19 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:38259 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232062AbhEYIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:13:26 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 497371C3C8D
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:01:30 +0100 (IST)
Received: (qmail 4802 invoked from network); 25 May 2021 08:01:29 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 25 May 2021 08:01:29 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and active CPUs
Date:   Tue, 25 May 2021 09:01:13 +0100
Message-Id: <20210525080119.5455-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v1
o Clarification comments
o Sanity check pcp->high during reclaim				(dhansen)
o Handle vm.percpu_pagelist_high_fraction in zone_highsize	(hdanton)
o Sanity check pcp->batch versus pcp->high

This series has pre-requisites in mmotm so for convenience it is also
available at

https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-pcpburst-v2r3

The per-cpu page allocator (PCP) is meant to reduce contention on the zone
lock but the sizing of batch and high is archaic and neither takes the zone
size into account or the number of CPUs local to a zone. With larger zones
and more CPUs per node, the contention is getting worse. Furthermore,
the fact that vm.percpu_pagelist_fraction adjusts both batch and high
values means that the sysctl can reduce zone lock contention but also
increase allocation latencies.

This series disassociates pcp->high from pcp->batch and then scales
pcp->high based on the size of the local zone with limited impact to
reclaim and accounting for active CPUs but leaves pcp->batch static.
It also adapts the number of pages that can be on the pcp list based on
recent freeing patterns.

The motivation is partially to adjust to larger memory sizes but
is also driven by the fact that large batches of page freeing via
release_pages() often shows zone contention as a major part of the
problem. Another is a bug report based on an older kernel where a
multi-terabyte process can takes several minutes to exit. A workaround
was to use vm.percpu_pagelist_fraction to increase the pcp->high value
but testing indicated that a production workload could not use the same
values because of an increase in allocation latencies. Unfortunately,
I cannot reproduce this test case myself as the multi-terabyte machines
are in active use but it should alleviate the problem.

The series aims to address both and partially acts as a pre-requisite. pcp
only works with order-0 which is useless for SLUB (when using high orders)
and THP (unconditionally). To store high-order pages on PCP, the pcp->high
values need to be increased first.

 Documentation/admin-guide/sysctl/vm.rst |  29 ++--
 include/linux/cpuhotplug.h              |   2 +-
 include/linux/mmzone.h                  |   8 +-
 kernel/sysctl.c                         |   8 +-
 mm/internal.h                           |   2 +-
 mm/memory_hotplug.c                     |   4 +-
 mm/page_alloc.c                         | 196 ++++++++++++++++++------
 mm/vmscan.c                             |  35 +++++
 8 files changed, 212 insertions(+), 72 deletions(-)

-- 
2.26.2

