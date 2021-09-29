Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9041C778
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbhI2O5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:57:12 -0400
Received: from 8bytes.org ([81.169.241.247]:41156 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344800AbhI2O5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:57:08 -0400
Received: from cap.home.8bytes.org (p4ff2b5b0.dip0.t-ipconnect.de [79.242.181.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 398841036;
        Wed, 29 Sep 2021 16:55:23 +0200 (CEST)
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
Subject: [PATCH v2 2/4] x86/mm/64: Flush global TLB on AP bringup
Date:   Wed, 29 Sep 2021 16:54:59 +0200
Message-Id: <20210929145501.4612-3-joro@8bytes.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929145501.4612-1-joro@8bytes.org>
References: <20210929145501.4612-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The AP bringup code uses the trampoline_pgd page-table, which
establishes global mappings in the user range of the address space.
Flush the global TLB entries after CR4 is setup for the AP to make sure
no stale entries remain in the TLB.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/cpu/common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f8885949e8c..0f71ea2e5680 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -436,6 +436,12 @@ void cr4_init(void)
 
 	/* Initialize cr4 shadow for this CPU. */
 	this_cpu_write(cpu_tlbstate.cr4, cr4);
+
+	/*
+	 * Flush any global TLB entries that might be left from the
+	 * trampline_pgd.
+	 */
+	__flush_tlb_all();
 }
 
 /*
-- 
2.33.0

