Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FDE31509D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhBINoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:44:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:33056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231261AbhBINka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:40:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C6A1B113;
        Tue,  9 Feb 2021 13:39:03 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 5/7] mm,memory_hotplug: Enforce pageblock alignment when memmap_on_memory
Date:   Tue,  9 Feb 2021 14:38:52 +0100
Message-Id: <20210209133854.17399-6-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210209133854.17399-1-osalvador@suse.de>
References: <20210209133854.17399-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many places expects us to pass a pageblock aligned range.
E.g: memmap_init_zone() needs a pageblock aligned range in order
to set the proper migrate type for it.
online_pages() needs to operate on a pageblock aligned range for
isolation purposes.

Make sure we disable the feature in case we cannot guarantee the
right alignment.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d3fb036d33fd..1a4d5dd1a2c8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -56,12 +56,16 @@ static int memmap_on_memory_show(char *buffer, const struct kernel_param *kp)
 static __meminit int memmap_on_memory_store(const char *val,
 					    const struct kernel_param *kp)
 {
+	unsigned long pageblock_size = PFN_PHYS(pageblock_nr_pages);
+
 	/*
 	 * Fail silently in case we cannot enable it due to system constraints.
 	 * User can always check whether it is enabled or not via /sys/module.
 	 */
 	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE) ||
-	    (PMD_SIZE % sizeof(struct page)))
+	    (PMD_SIZE % sizeof(struct page)) ||
+	    !(MIN_MEMORY_BLOCK_SIZE - PMD_SIZE) ||
+	    !(MIN_MEMORY_BLOCK_SIZE - PMD_SIZE) % pageblock_size)
 		return 0;
 
 	return param_set_bool(val, kp);
-- 
2.16.3

