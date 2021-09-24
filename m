Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC8D417843
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347334AbhIXQOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:14:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:43617 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347332AbhIXQO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:14:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="220906291"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="220906291"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 09:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="551865372"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.28.105])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Sep 2021 09:12:53 -0700
Subject: [PATCH 1/2] mm/migrate: optimize hotplug-time demotion order updates
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        oliver.sang@intel.com, ying.huang@intel.com, mhocko@suse.com,
        weixugc@google.com, osalvador@suse.de, rientjes@google.com,
        dan.j.williams@intel.com, david@redhat.com, gthelen@google.com,
        yang.shi@linux.alibaba.com, akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 24 Sep 2021 09:12:53 -0700
References: <20210924161251.093CCD06@davehans-spike.ostc.intel.com>
In-Reply-To: <20210924161251.093CCD06@davehans-spike.ostc.intel.com>
Message-Id: <20210924161253.D7673E31@davehans-spike.ostc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>
== tl;dr ==

Automatic demotion opted for a simple, lazy approach to handling
hotplug events.  This noticeably slows down memory hotplug[1].
Optimize away updates to the demotion order when memory hotplug
events should have no effect.

This has no effect on CPU hotplug.  There is no known problem on
the CPU side and any work there will be in a separate series.

== Background ==

Automatic demotion is a memory migration strategy to ensure that
new allocations have room in faster memory tiers on tiered memory
systems.  The kernel maintains an array (node_demotion[]) to
drive these migrations.

The node_demotion[] path is calculated by starting at nodes with
CPUs and then "walking" to nodes with memory.  Only hotplug
events which online or offline a node with memory (N_ONLINE) or
CPUs (N_CPU) will actually affect the migration order.

== Problem ==

However, the current code is lazy.  It completely regenerates the
migration order on *any* CPU or memory hotplug event.  The logic
was that these events are extremely rare and that the overhead
from indiscriminate order regeneration is minimal.

Part of the update logic involves a synchronize_rcu(), which is a
pretty big hammer.  Its overhead was large enough to be detected
by some 0day tests that watch memory hotplug performance[1].

== Solution ==

Add a new helper (node_demotion_topo_changed()) which can
differentiate between superfluous and impactful hotplug events.
Skip the expensive update operation for superfluous events.

== Aside: Locking ==

It took me a few moments to declare the locking to be safe enough
for node_demotion_topo_changed() to work.  It all hinges on the
memory hotplug lock:

During memory hotplug events, 'mem_hotplug_lock' is held for
write.  This ensures that two memory hotplug events can not be
called simultaneously.

CPU hotplug has a similar lock (cpuhp_state_mutex) which also
provides mutual exclusion between CPU hotplug events.  In
addition, the demotion code acquire and hold the mem_hotplug_lock
for read during its CPU hotplug handlers.  This provides mutual
exclusion between the demotion memory hotplug callbacks and the
CPU hotplug callbacks.

This effectively allows treating the migration target generation
code to act as if it is single-threaded.

1. https://lore.kernel.org/all/20210905135932.GE15026@xsang-OptiPlex-9020/

Fixes: 884a6e5d1f93 ("mm/migrate: update node demotion order on hotplug events")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

 b/mm/migrate.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff -puN mm/migrate.c~faster-node-order mm/migrate.c
--- a/mm/migrate.c~faster-node-order	2021-09-24 09:12:30.988377798 -0700
+++ b/mm/migrate.c	2021-09-24 09:12:30.988377798 -0700
@@ -3239,8 +3239,18 @@ static int migration_offline_cpu(unsigne
  * set_migration_target_nodes().
  */
 static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
-						 unsigned long action, void *arg)
+						 unsigned long action, void *_arg)
 {
+	struct memory_notify *arg = _arg;
+
+	/*
+	 * Only update the node migration order when a node is
+	 * changing status, like online->offline.  This avoids
+	 * the overhead of synchronize_rcu() in most cases.
+	 */
+	if (arg->status_change_nid < 0)
+		return notifier_from_errno(0);
+
 	switch (action) {
 	case MEM_GOING_OFFLINE:
 		/*
_
