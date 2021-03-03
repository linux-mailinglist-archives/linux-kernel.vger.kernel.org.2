Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9232BDC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbhCCQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:33:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43458 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357663AbhCCLzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:55:41 -0500
Message-Id: <20210303114727.967383885@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614772458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eWdIiVkP8/X3j2/negs822pPzotc1RS3VDSLc2vlH3s=;
        b=KJGW07a0B+9U0rAjZaZ0eOfQUeUJTgZJxgiG6TjHLaVci9q/7crMVYj1Di/6TeLi352JEe
        AqFbndGwi9aMI//Et7nakmQmclVxTn41icrrpk8bmKGOJzjieFpgaCrHMkrlZozYJCu9s2
        nvGxuDOA+kP44ZY/cxW+wA44FMm5+7r7f4wvsCXGv4veQX23kE/28XIMZ+snZCpaMGal0M
        PcJ8inqdKYuYwgeSdAtWCh2Ys/sTaQNfx4YcEPZFe7V8eK02ofuf5ISz4UpZSeR979WTX4
        vfiVI6TEofzRAWjql4i4SBmJQ7M2nqO9AXtsqiGPM3O3PxBx7qjkGBOyxkrpYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614772458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eWdIiVkP8/X3j2/negs822pPzotc1RS3VDSLc2vlH3s=;
        b=wscu+3YV+RmkZqcTLn44nZQTQMhbSfgQTfXb7ByZjvUKmrlA648K0PddMzi5GOpJTu603o
        psRRivF4wN0+bzCQ==
Date:   Wed, 03 Mar 2021 12:45:12 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [patch 1/2] ARM: mm: Replace kmap_atomic_pfn()
References: <20210303114511.927078317@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is no requirement to disable pagefaults and preemption for these
cache management mappings.

Replace kmap_atomic_pfn() with kmap_local_pfn(). This allows to remove
kmap_atomic_pfn() in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mm/cache-feroceon-l2.c |    6 +++---
 arch/arm/mm/cache-xsc3l2.c      |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -49,9 +49,9 @@ static inline unsigned long l2_get_va(un
 	 * we simply install a virtual mapping for it only for the
 	 * TLB lookup to occur, hence no need to flush the untouched
 	 * memory mapping afterwards (note: a cache flush may happen
-	 * in some circumstances depending on the path taken in kunmap_atomic).
+	 * in some circumstances depending on the path taken in kunmap_local).
 	 */
-	void *vaddr = kmap_atomic_pfn(paddr >> PAGE_SHIFT);
+	void *vaddr = kmap_local_pfn(paddr >> PAGE_SHIFT);
 	return (unsigned long)vaddr + (paddr & ~PAGE_MASK);
 #else
 	return __phys_to_virt(paddr);
@@ -61,7 +61,7 @@ static inline unsigned long l2_get_va(un
 static inline void l2_put_va(unsigned long vaddr)
 {
 #ifdef CONFIG_HIGHMEM
-	kunmap_atomic((void *)vaddr);
+	kunmap_local((void *)vaddr);
 #endif
 }
 
--- a/arch/arm/mm/cache-xsc3l2.c
+++ b/arch/arm/mm/cache-xsc3l2.c
@@ -59,7 +59,7 @@ static inline void l2_unmap_va(unsigned
 {
 #ifdef CONFIG_HIGHMEM
 	if (va != -1)
-		kunmap_atomic((void *)va);
+		kunmap_local((void *)va);
 #endif
 }
 
@@ -75,7 +75,7 @@ static inline unsigned long l2_map_va(un
 		 * in place for it.
 		 */
 		l2_unmap_va(prev_va);
-		va = (unsigned long)kmap_atomic_pfn(pa >> PAGE_SHIFT);
+		va = (unsigned long)kmap_local_pfn(pa >> PAGE_SHIFT);
 	}
 	return va + (pa_offset >> (32 - PAGE_SHIFT));
 #else


