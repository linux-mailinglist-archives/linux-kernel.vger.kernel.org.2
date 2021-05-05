Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25038373321
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhEEAdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:33:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:19816 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhEEAdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:33:20 -0400
IronPort-SDR: hTKWfWwn6xtyaK+NkDZBsqKCvJ2WBFYLPuq0z/G4ibQcK7ofR20CLAIH5xrvU88If51uBv0aLh
 TtXGwVbGWG3A==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="196058584"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="196058584"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:24 -0700
IronPort-SDR: FQrxJIOXl9kjvrzWySZvwZA5n2LRdmCwrFZ3HtrZs6RGPwdS5P3Kd3qwLAIlzOpv20rOSyaeQT
 ucepazSWdRBA==
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="429490746"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.26.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:22 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Cc:     ira.weiny@intel.com, rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 0/9] PKS write protected page tables
Date:   Tue,  4 May 2021 17:30:23 -0700
Message-Id: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a POC for write protecting page tables with PKS (Protection Keys for 
Supervisor) [1]. The basic idea is to make the page tables read only, except 
temporarily on a per-cpu basis when they need to be modified. I’m looking for 
opinions on whether people like the general direction of this in terms of 
value and implementation.

Why would people want this?
===========================
Page tables are the basis for many types of protections and as such, are a 
juicy target for attackers. Mapping them read-only will make them harder to 
use in attacks.

This protects against an attacker that has acquired the ability to write to 
the page tables. It's not foolproof because an attacker who can execute 
arbitrary code can either disable PKS directly, or simply call the same 
functions that the kernel uses for legitimate page table writes.

Why use PKS for this?
=====================
PKS is an upcoming CPU feature that allows supervisor virtual memory 
permissions to be changed without flushing the TLB, like PKU does for user 
memory. Protecting page tables would normally be really expensive because you 
would have to do it with paging itself. PKS helps by providing a way to toggle 
the writability of the page tables with just a per-cpu MSR.

Performance impacts
===================
Setting direct map permissions on whatever random page gets allocated for a 
page table would result in a lot of kernel range shootdowns and direct map 
large page shattering. So the way the PKS page table memory is created is 
similar to this module page clustering series[2], where a cache of pages is 
replenished from 2MB pages such that the direct map permissions and associated 
breakage is localized on the direct map. In the PKS page tables case, a PKS 
key is pre-applied to the direct map for pages in the cache.

There would be some costs of memory overhead in order to protect the direct 
map page tables. There would also be some extra kernel range shootdowns to 
replenish the cache on occasion, from setting the PKS key on the direct map of 
the new pages. I don’t have any actual performance data yet.

This is based on V6 [1] of the core PKS infrastructure patches. PKS 
infrastructure follow-on’s are planned to enable keys to be set to the same 
permissions globally. Since this usage needs a key to be set globally 
read-only by default, a small temporary solution is hacked up in patch 8. Long 
term, PKS protected page tables would use a better and more generic solution 
to achieve this.

[1]
https://lore.kernel.org/lkml/20210401225833.566238-1-ira.weiny@intel.com/
[2]
https://lore.kernel.org/lkml/20210405203711.1095940-1-rick.p.edgecombe@intel.com
/

Thanks,

Rick


Rick Edgecombe (9):
  list: Support getting most recent element in list_lru
  list: Support list head not in object for list_lru
  x86/mm/cpa: Add grouped page allocations
  mm: Explicitly zero page table lock ptr
  x86, mm: Use cache of page tables
  x86/mm/cpa: Add set_memory_pks()
  x86/mm/cpa: Add perm callbacks to grouped pages
  x86, mm: Protect page tables with PKS
  x86, cpa: PKS protect direct map page tables

 arch/x86/boot/compressed/ident_map_64.c |   5 +
 arch/x86/include/asm/pgalloc.h          |   6 +
 arch/x86/include/asm/pgtable.h          |  26 +-
 arch/x86/include/asm/pgtable_64.h       |  33 ++-
 arch/x86/include/asm/pkeys_common.h     |   8 +-
 arch/x86/include/asm/set_memory.h       |  23 ++
 arch/x86/mm/init.c                      |  40 +++
 arch/x86/mm/pat/set_memory.c            | 312 +++++++++++++++++++++++-
 arch/x86/mm/pgtable.c                   | 144 ++++++++++-
 include/asm-generic/pgalloc.h           |  42 +++-
 include/linux/list_lru.h                |  26 ++
 include/linux/mm.h                      |   7 +
 mm/Kconfig                              |   6 +-
 mm/list_lru.c                           |  38 ++-
 mm/memory.c                             |   1 +
 mm/swap.c                               |   7 +
 mm/swap_state.c                         |   6 +
 17 files changed, 705 insertions(+), 25 deletions(-)

-- 
2.30.2

