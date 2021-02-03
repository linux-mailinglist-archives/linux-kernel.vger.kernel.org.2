Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5E30D7EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhBCKsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:48:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:51586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233664AbhBCKsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:48:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF04CAF87;
        Wed,  3 Feb 2021 10:47:54 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/3] Cleanup and fixups for vmemmap handling
Date:   Wed,  3 Feb 2021 11:47:47 +0100
Message-Id: <20210203104750.23405-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series contains cleanups to remove dead code that handles
unaligned cases for 4K and 1GB pages (patch#1 and pathc#2) when
removing the vemmmap range, and a fix (patch#3) to handle the case
when two vmemmap ranges intersect a PMD.

More details can be found in the respective changelogs.


 v1 -> v2:
 - Remove dead code in remove_pud_table as well
 - Addessed feedback by David
 - Place the vmemap functions that take care of unaligned PMDs
   within CONFIG_SPARSEMEM_VMEMMAP

Oscar Salvador (3):
  x86/vmemmap: Drop handling of 4K unaligned vmemmap range
  x86/vmemmap: Drop handling of 1GB vmemmap ranges
  x86/vmemmap: Handle unpopulated sub-pmd ranges

 arch/x86/mm/init_64.c | 166 ++++++++++++++++++++++++------------------
 1 file changed, 96 insertions(+), 70 deletions(-)

-- 
2.26.2

