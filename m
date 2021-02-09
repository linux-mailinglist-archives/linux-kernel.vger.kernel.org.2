Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC39315087
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhBINl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:41:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:60528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231536AbhBINjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:39:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50111AFF6;
        Tue,  9 Feb 2021 13:39:02 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 4/7] mm,memory_hotplug: Enforce struct page size to be multiple of PMD
Date:   Tue,  9 Feb 2021 14:38:51 +0100
Message-Id: <20210209133854.17399-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210209133854.17399-1-osalvador@suse.de>
References: <20210209133854.17399-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When struct page's size is not multiple of PMD, these do not get
fully populated when adding sections, hence two sections will
intersect the same the PMD. This goes against the vmemmap-per-device
premise, so reject it if that is the case.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 95695483a622..d3fb036d33fd 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -57,10 +57,11 @@ static __meminit int memmap_on_memory_store(const char *val,
 					    const struct kernel_param *kp)
 {
 	/*
-	 * Fail silently in case we cannot enable it due to platform constraints.
+	 * Fail silently in case we cannot enable it due to system constraints.
 	 * User can always check whether it is enabled or not via /sys/module.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE))
+	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE) ||
+	    (PMD_SIZE % sizeof(struct page)))
 		return 0;
 
 	return param_set_bool(val, kp);
-- 
2.16.3

