Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37BB4440CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 12:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhKCLxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 07:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhKCLxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 07:53:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B23C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 04:50:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v20so2287827plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7WTRWE2Tx5rUYcgUyt1HD8zRPERENbRuNdBuXXDi2wA=;
        b=S2IijSX0oEbq28PNJ7sscwPJlTX8Sp9Dqz1T3E131g5SWFvStknnwiBvn8DNaye+5G
         5I/iYKbhh0shIRisK9Fhljb9VnBb5OUrSSTrsD10OGSb2imcnMPztyzggd/EuF7Z6BhA
         EaY52eu05YF78nIfL5QrUs1HanDAqxvJ4cW3+Gel4LKHzjvZWyW1mqLTr615yGOBvn5M
         hEjQEnsBb6hJmCP5CSqKXOJCrG/rFzH7Xs2KJBJ7eEeJSM1AUPz9gSTyeHQ8r76WVhtM
         4uSqNqK7jzG9bakj32avDGAntYAN+IiPEu5OngWa5IOIGSWwZZ3vKpSmGjk3i7nfGnzN
         K+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7WTRWE2Tx5rUYcgUyt1HD8zRPERENbRuNdBuXXDi2wA=;
        b=fjEx4pJUrdV29UebwYLmGZfhGNh+5eY3ex5B3HjkeAEGdmQ33vzKQubFKCOv/tnsmH
         LsHCev2otEe2AjDZ1A78PeqAmL6CHkRtfGnqWO+UEJc28GZWYTfrlg7xOiySL5spmmdJ
         mIPx0kd349eG8RJHDViZ/68l/OxegpV4AXcK1uC2Q1JNxeF+PJrdTi+CL7rGiXQdKeMQ
         ygOwbb/5YNiJh21AY29R5kNAcpbvZNY1ZzYQw5fqxM7Pcw1pDkNlUBvqOI1MgDsMvnYv
         S9i4XxlrOruHcqUxbG1/WdoE81VneKgYa3xeq1vpEScFhXCM3WVWGCddtHbpEBt4HKqL
         KZdw==
X-Gm-Message-State: AOAM533Z2tUZtwpK9S1vN2HfGBS8zURAR9L5QBN/T70TeWLy4O16qhzA
        UClsidLJucij7Cilm82kdYyty353MLA=
X-Google-Smtp-Source: ABdhPJyD1OZmjdcpH7CwX0ShazGT6wIn1YSDudlQlWHYR+LiRAoUv0cQM9hL4et5QV9daNHCG0PqRg==
X-Received: by 2002:a17:90b:4b01:: with SMTP id lx1mr1763752pjb.38.1635940239343;
        Wed, 03 Nov 2021 04:50:39 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id z24sm1896529pgu.54.2021.11.03.04.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 04:50:38 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: fix SMP tlb flush NULL pointer dereference
Date:   Wed,  3 Nov 2021 20:50:15 +0900
Message-Id: <20211103115016.318043-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Throughout the OpenRISC kernel port VMA is passed as NULL when flushing
kernel tlb entries.  Somehow this was missed when I was testing
c28b27416da9 ("openrisc: Implement proper SMP tlb flushing") and now the
SMP kernel fails to completely boot.

In OpenRISC VMA is used only to determine which cores need to have their
TLB entries flushed.

This patch updates the logic to flush tlbs on all cores when the VMA is
passed as NULL.  Also, we update places VMA is passed as NULL to use
flush_tlb_kernel_range instead.  Now, the only place VMA is passed as
NULL is in the implementation of flush_tlb_kernel_range.

Fixes: c28b27416da9 ("openrisc: Implement proper SMP tlb flushing")
Reported-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/dma.c | 4 ++--
 arch/openrisc/kernel/smp.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 1b16d97e7da7..a82b2caaa560 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -33,7 +33,7 @@ page_set_nocache(pte_t *pte, unsigned long addr,
 	 * Flush the page out of the TLB so that the new page flags get
 	 * picked up next time there's an access
 	 */
-	flush_tlb_page(NULL, addr);
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 
 	/* Flush page out of dcache */
 	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache_block_size)
@@ -56,7 +56,7 @@ page_clear_nocache(pte_t *pte, unsigned long addr,
 	 * Flush the page out of the TLB so that the new page flags get
 	 * picked up next time there's an access
 	 */
-	flush_tlb_page(NULL, addr);
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 
 	return 0;
 }
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 415e209732a3..ba78766cf00b 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -272,7 +272,7 @@ static inline void ipi_flush_tlb_range(void *info)
 	local_flush_tlb_range(NULL, fd->addr1, fd->addr2);
 }
 
-static void smp_flush_tlb_range(struct cpumask *cmask, unsigned long start,
+static void smp_flush_tlb_range(const struct cpumask *cmask, unsigned long start,
 				unsigned long end)
 {
 	unsigned int cpuid;
@@ -320,7 +320,9 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 void flush_tlb_range(struct vm_area_struct *vma,
 		     unsigned long start, unsigned long end)
 {
-	smp_flush_tlb_range(mm_cpumask(vma->vm_mm), start, end);
+	const struct cpumask *cmask = vma ? mm_cpumask(vma->vm_mm)
+					  : cpu_online_mask;
+	smp_flush_tlb_range(cmask, start, end);
 }
 
 /* Instruction cache invalidate - performed on each cpu */
-- 
2.31.1

