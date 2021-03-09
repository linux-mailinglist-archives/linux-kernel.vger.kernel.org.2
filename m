Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48370332DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhCIRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:55:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:56354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231522AbhCIRzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:55:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE230AF0C;
        Tue,  9 Mar 2021 17:55:51 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 2/5] acpi,memhotplug: Enable MHP_MEMMAP_ON_MEMORY when supported
Date:   Tue,  9 Mar 2021 18:55:43 +0100
Message-Id: <20210309175546.5877-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210309175546.5877-1-osalvador@suse.de>
References: <20210309175546.5877-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the caller check whether it can pass MHP_MEMMAP_ON_MEMORY by
checking mhp_supports_memmap_on_memory().
MHP_MEMMAP_ON_MEMORY can only be set in case
ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE is enabled, the architecture supports
altmap, and the range to be added spans a single memory block.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/acpi_memhotplug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index b02fd51e5589..8cc195c4c861 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -171,6 +171,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 	acpi_handle handle = mem_device->device->handle;
 	int result, num_enabled = 0;
 	struct acpi_memory_info *info;
+	mhp_t mhp_flags = MHP_NONE;
 	int node;
 
 	node = acpi_get_node(handle);
@@ -194,8 +195,10 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		if (node < 0)
 			node = memory_add_physaddr_to_nid(info->start_addr);
 
+		if (mhp_supports_memmap_on_memory(info->length))
+			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
 		result = __add_memory(node, info->start_addr, info->length,
-				      MHP_NONE);
+				      mhp_flags);
 
 		/*
 		 * If the memory block has been used by the kernel, add_memory()
-- 
2.16.3

