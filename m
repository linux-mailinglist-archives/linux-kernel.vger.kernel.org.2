Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0712E44D57F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhKKLFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhKKLFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:05:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63CEE6128E;
        Thu, 11 Nov 2021 11:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636628583;
        bh=C499/2hTJ14vnl1FV0Xf5J75LUu/RzkRDs4KKoGOgkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTR2SpHej8j0Ax4Mic9kpxxMMP8YRAnumNAMNE8Vr9BSavLwQYw98GNE/WagoWtpl
         ODBiBAeEnhVF5YNrMAm6uWwy2pcELCFlUJBUkvYFTT7XS0XRZOhZESiPdVx/wW9149
         1m4DWtqlAYsNyyNgzCRJfGk4IgnFD+UTSHB5bIKblqGZLoOenKNoZFAf5Nii8K6KA1
         tPSN57/vQMMYIE93u2otQhBV6IQV8OVl/JzXIPmI4ixleaH+b0n9iR/jw6JSMd5yx8
         IJ3d3CRxFOOvju+rNcEHeIE3AeB8VZq3oW2lSCABlyOqp/um4XINf1nBRhbV1nQreJ
         7OMGBCMdMsFNQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] x86/mm: replace GFP_ATOMIC with GFP_KERNEL for direct map allocations
Date:   Thu, 11 Nov 2021 13:02:41 +0200
Message-Id: <20211111110241.25968-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211111110241.25968-1-rppt@kernel.org>
References: <20211111110241.25968-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The allocations of the direct map pages are mostly happen very early during
the system boot and they use either the page table cache in brk area of bss
or memblock.

The few callers that effectively use page allocator for the direct map
updates are gart_iommu_init() and memory hotplug. Neither of them happen in
an atomic context so there is no reason to use GFP_ATOMIC for these
allocations.

Replace GFP_ATOMIC with GFP_KERNEL to avoid using atomic reserves for
allocations that do not require that.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/mm/init.c    | 2 +-
 arch/x86/mm/init_64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 1895986842b9..c01f144e0015 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -120,7 +120,7 @@ __ref void *alloc_low_pages(unsigned int num)
 		unsigned int order;
 
 		order = get_order((unsigned long)num << PAGE_SHIFT);
-		return (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
+		return (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
 	}
 
 	if ((pgt_buf_end + num) > pgt_buf_top || !can_use_brk_pgt) {
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e46d2f18d895..f3924f1a953d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -227,7 +227,7 @@ static __ref void *spp_getpage(void)
 	void *ptr;
 
 	if (after_bootmem)
-		ptr = (void *) get_zeroed_page(GFP_ATOMIC);
+		ptr = (void *) get_zeroed_page(GFP_KERNEL);
 	else
 		ptr = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
-- 
2.28.0

