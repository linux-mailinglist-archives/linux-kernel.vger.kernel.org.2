Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF171366929
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbhDUK1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:27:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238301AbhDUK1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:27:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33A68AEE7;
        Wed, 21 Apr 2021 10:27:06 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v10 1/8] drivers/base/memory: Introduce memory_block_{online,offline}
Date:   Wed, 21 Apr 2021 12:26:54 +0200
Message-Id: <20210421102701.25051-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210421102701.25051-1-osalvador@suse.de>
References: <20210421102701.25051-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory patch that introduces two new functions:
memory_block_online() and memory_block_offline().

For now, these functions will only call online_pages() and offline_pages()
respectively, but they will be later in charge of preparing the vmemmap
pages, carrying out the initialization and proper accounting of such
pages.

Since memory_block struct contains all the information, pass this struct
down the chain till the end functions.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 drivers/base/memory.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f35298425575..f209925a5d4e 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -169,30 +169,41 @@ int memory_notify(unsigned long val, void *v)
 	return blocking_notifier_call_chain(&memory_chain, val, v);
 }
 
+static int memory_block_online(struct memory_block *mem)
+{
+	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
+	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
+
+	return online_pages(start_pfn, nr_pages, mem->online_type, mem->nid);
+}
+
+static int memory_block_offline(struct memory_block *mem)
+{
+	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
+	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
+
+	return offline_pages(start_pfn, nr_pages);
+}
+
 /*
  * MEMORY_HOTPLUG depends on SPARSEMEM in mm/Kconfig, so it is
  * OK to have direct references to sparsemem variables in here.
  */
 static int
-memory_block_action(unsigned long start_section_nr, unsigned long action,
-		    int online_type, int nid)
+memory_block_action(struct memory_block *mem, unsigned long action)
 {
-	unsigned long start_pfn;
-	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	int ret;
 
-	start_pfn = section_nr_to_pfn(start_section_nr);
-
 	switch (action) {
 	case MEM_ONLINE:
-		ret = online_pages(start_pfn, nr_pages, online_type, nid);
+		ret = memory_block_online(mem);
 		break;
 	case MEM_OFFLINE:
-		ret = offline_pages(start_pfn, nr_pages);
+		ret = memory_block_offline(mem);
 		break;
 	default:
 		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
-		     "%ld\n", __func__, start_section_nr, action, action);
+		     "%ld\n", __func__, mem->start_section_nr, action, action);
 		ret = -EINVAL;
 	}
 
@@ -210,9 +221,7 @@ static int memory_block_change_state(struct memory_block *mem,
 	if (to_state == MEM_OFFLINE)
 		mem->state = MEM_GOING_OFFLINE;
 
-	ret = memory_block_action(mem->start_section_nr, to_state,
-				  mem->online_type, mem->nid);
-
+	ret = memory_block_action(mem, to_state);
 	mem->state = ret ? from_state_req : to_state;
 
 	return ret;
-- 
2.16.3

