Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFD032A432
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380039AbhCBK0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:26:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349563AbhCBKFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:05:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 031E164F1B;
        Tue,  2 Mar 2021 10:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614679471;
        bh=pACDq5dh9SnWHeToI15lAiv7Zc9+44fWIB6RMHF0BEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFZA3+CfC+xOMR2lWPr7on7rEzOVojEsEaxFZgnroqRvY/QhbYpKja31vbfao/GJk
         WGP8F0Si5Hc7JLt9UEQFGXi18MZvPWJz5us7WBglcI8Ev4eJmo5H3F7WxtNrESNiVx
         +kJVAWKpUOiXAlmie414eLbuDHDF1tYHtQSeWg2mJRSEObt+tXTd0xj4Gptsstsm5H
         qklhTAn6uuNmVk6A6sYV7kXF3Su/kjHE9ROUGUgv16/RTVON3ulgull8dX6yH6Vyp2
         9g2HqqqVK7LFWIkZDeU/n/coy8Iqagxp3YsBv93SPrBpmMkNzgfYB+XIK7czAhaqFR
         b2+Gevc5FCo9g==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v3 2/2] x86/setup: merge several reservations of start of the memory
Date:   Tue,  2 Mar 2021 12:04:06 +0200
Message-Id: <20210302100406.22059-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210302100406.22059-1-rppt@kernel.org>
References: <20210302100406.22059-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Currently the first several pages are reserved both to avoid leaking their
contents on systems with L1TF and to avoid corrupting BIOS memory.

Merge the two memory reservations.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/setup.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3e3c6036b023..776fc9b3fafe 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -713,11 +713,6 @@ static int __init parse_reservelow(char *p)
 
 early_param("reservelow", parse_reservelow);
 
-static void __init trim_low_memory_range(void)
-{
-	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
-}
-
 static void __init early_reserve_memory(void)
 {
 	/*
@@ -730,10 +725,17 @@ static void __init early_reserve_memory(void)
 			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
 
 	/*
-	 * Make sure page 0 is always reserved because on systems with
-	 * L1TF its contents can be leaked to user processes.
+	 * The first 4Kb of memory is a BIOS owned area, but generally it is
+	 * not listed as such in the E820 table.
+	 *
+	 * Reserve the first memory page and typically some additional
+	 * memory (64KiB by default) since some BIOSes are known to corrupt
+	 * low memory. See the Kconfig help text for X86_RESERVE_LOW.
+	 *
+	 * In addition, make sure page 0 is always reserved because on
+	 * systems with L1TF its contents can be leaked to user processes.
 	 */
-	memblock_reserve(0, PAGE_SIZE);
+	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
 
 	early_reserve_initrd();
 
@@ -746,7 +748,6 @@ static void __init early_reserve_memory(void)
 	reserve_bios_regions();
 
 	trim_snb_memory();
-	trim_low_memory_range();
 }
 
 /*
-- 
2.28.0

