Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1D841F17D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355132AbhJAPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353716AbhJAPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:50:13 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5AEC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 08:48:28 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2b5b0.dip0.t-ipconnect.de [79.242.181.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 8317D25C;
        Fri,  1 Oct 2021 17:48:26 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] x86/realmode: Add comment for Global bit usage in trampline_pgd
Date:   Fri,  1 Oct 2021 17:48:14 +0200
Message-Id: <20211001154817.29225-2-joro@8bytes.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211001154817.29225-1-joro@8bytes.org>
References: <20211001154817.29225-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Document the fact that using the trampoline_pgd will result in the
creation of global TLB entries in the user range of the address
space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 23a14d82e783..accd702d4253 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -714,6 +714,11 @@ static void __init memory_map_bottom_up(unsigned long map_start,
 static void __init init_trampoline(void)
 {
 #ifdef CONFIG_X86_64
+	/*
+	 * The code below will alias kernel page-tables in the user-range of the
+	 * address space, including the Global bit. So global TLB entries will
+	 * be created when using the trampoline page-table.
+	 */
 	if (!kaslr_memory_enabled())
 		trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
 	else
-- 
2.33.0

