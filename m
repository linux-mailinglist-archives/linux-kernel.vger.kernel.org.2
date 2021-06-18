Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E653AC093
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhFRBjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:39:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:58333 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233475AbhFRBjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:39:41 -0400
IronPort-SDR: Tmjcbm8ljyHvOgJ2oBsxJJV7R3DXqhod3YN/kPNqXkJ7O70o0oZ/dBuJ7spadLXw82SQikubc0
 5WzGVszxVpew==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="186857752"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="186857752"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 18:37:32 -0700
IronPort-SDR: o/Z4JXQCSd1IUV0zSLyRw1WVAFZaIPAVis68Mng5kIaIhj0Z5GR99KYLi/j6qnxSy1ZhnxKi23
 l8EC9VUUoMOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="638020733"
Received: from oosg.bj.intel.com (HELO localhost.bj.intel.com) ([10.238.153.110])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2021 18:37:30 -0700
From:   Fan Du <fan.du@intel.com>
To:     x86@kernel.org, sgx@eclists.intel.com
Cc:     jarkko@kernel.org, dan.j.williams@intel.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Fan Du <fan.du@intel.com>
Subject: [PATCH] x86,numa: Pick up reserved memblock from SRAT entries
Date:   Fri, 18 Jun 2021 09:36:52 -0400
Message-Id: <20210618133652.322463-1-fan.du@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spot below error message from 2 sockets server with SGX enabled:
[    2.264955] sgx: EPC section 0x2000c00000-0x207f7fffff
[    2.269093] sgx: EPC section 0x4000c00000-0x407fffffff
[    2.273242] sgx: [Firmware Bug]: Unable to map EPC section to online node. Fallback to the NUMA node 0.

SGX EPC ranges are reserved(E820) memory managed directly by SGX driver.
The second EPC section expected to be bound to NUMA node 1, while
phys_to_target_node failed to find a valid online NUMA node from this
address range.

Essentially it's not a firmware bug, the root cause is that the second EPC
section is arranged at the end of SRAT show as below, thus missed to be
picked up by numa_reserved_meminfo. Add additional check for such case.

[    0.022842] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.022844] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
[    0.022846] ACPI: SRAT: Node 1 PXM 1 [mem 0x2080000000-0x407fffffff]

w/o this patch:
crash> numa_meminfo
numa_meminfo = $1 = {
  nr_blks = 0x2,
  blk = {{
      start = 0x0,
      end = 0x2080000000,
      nid = 0x0
    }, {
      start = 0x2080000000,
      end = 0x4000000000,
      nid = 0x1
    }, {
crash> numa_reserved_meminfo
numa_reserved_meminfo = $2 = {
  nr_blks = 0x0,
  blk = {{
      start = 0x0,
      end = 0x0,
      nid = 0x0
    },

w/ this patch:
crash> numa_meminfo
numa_meminfo = $1 = {
  nr_blks = 0x2,
  blk = {{
      start = 0x0,
      end = 0x2080000000,
      nid = 0x0
    }, {
      start = 0x2080000000,
      end = 0x4000000000,
      nid = 0x1
    },
crash> numa_reserved_meminfo
numa_reserved_meminfo = $2 = {
  nr_blks = 0x1,
  blk = {{
      start = 0x4000000000,
      end = 0x4080000000,
      nid = 0x1
    },

Signed-off-by: Fan Du <fan.du@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Fixes: 5d30f92e7631 ("x86/NUMA: Provide a range-to-target_node lookup facility")
---
 arch/x86/mm/numa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 5eb4dc2b97da..e23af389cad9 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -254,7 +254,12 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
 
 		/* make sure all non-reserved blocks are inside the limits */
 		bi->start = max(bi->start, low);
-		bi->end = min(bi->end, high);
+
+		/* handle reserved memory at the end of the SRAT range */
+		if (bi->end > high) {
+			numa_add_memblk_to(bi->nid, high, bi->end, &numa_reserved_meminfo);
+			bi->end = high;
+		}
 
 		/* and there's no empty block */
 		if (bi->start >= bi->end)
-- 
2.27.0

