Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A1A307445
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhA1K6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhA1K6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:58:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D006364DDE;
        Thu, 28 Jan 2021 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611831462;
        bh=5Sw4HTwjI2sdnT2rdgUGy47J/eSb+BY4hM6CzexHw0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUrpTULtXjISGGuNLkaWh0nyyzZTs9ivBnwvmEUajVOVy7MPcr4Q/xpz7PolcSOe3
         jqvC7zsMVzYIpbYOD+jVkZzBawXWFJzSMeWk3AllXmiBbp6ouGo+sEkeBhy7QZ2Oie
         WshwKwijExbs5ruO/r+CwGxVC9g7roLLAdP1Ddy8vBM2I7BhCa/S1QGpLyimd8o294
         tf4QED1f0++AjJxWmganQ0ultc8Rt6YUcmfqx6N0pXOXplv/yI4raNAjABC8RL8v0s
         iufvLT80AvYfodt5kYUFKRef3EhEF/zmcIea3wZABPlKWPk+XPq93X0tT5VjeNzEbT
         g1DZaRo+kBUAA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 2/2] x86/setup: merge several reservations of start of the memory
Date:   Thu, 28 Jan 2021 12:57:11 +0200
Message-Id: <20210128105711.10428-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210128105711.10428-1-rppt@kernel.org>
References: <20210128105711.10428-1-rppt@kernel.org>
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
 arch/x86/kernel/setup.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3b582406363a..b36624e3dc9e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -703,20 +703,6 @@ static int __init parse_reservelow(char *p)
 
 early_param("reservelow", parse_reservelow);
 
-static void __init trim_low_memory_range(void)
-{
-	/*
-	 * A special case is the first 4Kb of memory;
-	 * This is a BIOS owned area, not kernel ram, but generally
-	 * not listed as such in the E820 table.
-	 *
-	 * This typically reserves additional memory (64KiB by default)
-	 * since some BIOSes are known to corrupt low memory.  See the
-	 * Kconfig help text for X86_RESERVE_LOW.
-	 */
-	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
-}
-
 static void __init early_reserve_memory(void)
 {
 	/*
@@ -729,10 +715,17 @@ static void __init early_reserve_memory(void)
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
 
@@ -745,7 +738,6 @@ static void __init early_reserve_memory(void)
 	reserve_bios_regions();
 
 	trim_snb_memory();
-	trim_low_memory_range();
 }
 
 /*
-- 
2.28.0

