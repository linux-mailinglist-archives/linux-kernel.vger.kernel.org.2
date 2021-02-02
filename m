Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222C130BD0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhBBL2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:28:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:33618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231339AbhBBLZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:25:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6972B18C;
        Tue,  2 Feb 2021 11:24:57 +0000 (UTC)
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
Subject: [PATCH 0/2] Cleanup and fixups for vmemmap handling
Date:   Tue,  2 Feb 2021 12:24:48 +0100
Message-Id: <20210202112450.11932-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

During the review of patch#2, David noticed that we could remove the
!PAGE_ALIGNED handling in remove_pte_table, as we should never get there.
Therefore, let us place that cleanup before the sub-pmd-populated fixup.

More details can be found in the respective changelogs.

[1] https://lkml.org/lkml/2021/1/29/82

Oscar Salvador (2):
  x86/vmemmap: Remove !PAGE_ALIGNED case in remove_pte_table
  x86/vmemmap: Handle unpopulated sub-pmd ranges

 arch/x86/mm/init_64.c | 148 +++++++++++++++++++++++++++++-------------
 1 file changed, 103 insertions(+), 45 deletions(-)

-- 
2.26.2

