Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7800433311D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhCIVlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:41:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:51192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhCIVlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:41:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 83297AFF1;
        Tue,  9 Mar 2021 21:41:11 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 0/4] Cleanup and fixups for vmemmap handling
Date:   Tue,  9 Mar 2021 22:40:46 +0100
Message-Id: <20210309214050.4674-1-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series contains cleanups to remove dead code that handles
unaligned cases for 4K and 1GB pages (patch#1 and patch#2) when
removing the vemmmap range, and a fix (patch#3) to handle the case
when two vmemmap ranges intersect the same PMD.

More details can be found in the respective changelogs.
 
 v5 -> v6:
 - Fix some compilation errors when !CONFIG_MEMORY_HOTPLUG
   (Reported by Zi Yan)
 - Collect Acked-by from Dave

 v4 -> v5:
 - Rebase on top of 5.12-rc2
 - Addessed feedback from Dave
 - Split previous patch#3 into core-changes (current patch#3) and
   the optimization (current patch#4)
 - Document better what is unused_pmd_start and its optimization
 - Added Acked-by for patch#1

 v3 -> v4:
 - Rebase on top of 5.12-rc1 as Andrew suggested
 - Added last Reviewed-by for the last patch

 v2 -> v3:
 - Make sure we do not clear the PUD entry in case
   we are not removing the whole range.
 - Add Reviewed-by

 v1 -> v2:
 - Remove dead code in remove_pud_table as well
 - Addessed feedback by David
 - Place the vmemap functions that take care of unaligned PMDs
   within CONFIG_SPARSEMEM_VMEMMAP


Oscar Salvador (4):
  x86/vmemmap: Drop handling of 4K unaligned vmemmap range
  x86/vmemmap: Drop handling of 1GB vmemmap ranges
  x86/vmemmap: Handle unpopulated sub-pmd ranges
  x86/vmemmap: Optimize for consecutive sections in partial populated
    PMDs

 arch/x86/mm/init_64.c | 203 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 128 insertions(+), 75 deletions(-)

-- 
2.16.3

