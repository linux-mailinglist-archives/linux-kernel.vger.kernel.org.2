Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADE0338694
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhCLHbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhCLHbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:31:49 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403F5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:31:49 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id m186so6756090qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fc4O5pv8w+UBOc7tpUHlG/tnzkEXWGcP/NkkMTj4HMY=;
        b=WnrHTrQ9rMGxhYK4b0QrGskBKMQhbpuaGqvmnn4rgSgmcAL3savA+xCqvbdGpvcgnE
         QDZWdRutIOgzjvPUmDleii6sqx+ju3o9ARd8iDbi/nH0zSrCM0TPYBiIfPp62qct0FRx
         s6r15iEep1O0HBzOd3W3cjg8zI6TSrLMj68rufPiOosq2deyRLPkw9RdXIJaUzI0tu8w
         sui28kyfCiSCYb66GXwEEPcaAezV7TXvqdYpuVq7usm7e/wnTOjO83e4Iq7sB6Oic79f
         xI5LWhh/V5SKNELDQ+jZYu7XrT9UWE4iEocRsY4UU6dh6U3pS55WxP/ZbCfuRR0y1w7u
         A4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fc4O5pv8w+UBOc7tpUHlG/tnzkEXWGcP/NkkMTj4HMY=;
        b=EAQ06d+ubH1dq8uD5S1MrtwNO9JYeNNgZlIrAQ4dOHvzqTZJ5lXkjeEwGA0SUEAnjm
         O0SERA27e4n96GsYYhWY6x++aoFmP1rKfMfPFsjvTeWYRvq82iZPh9I8SIuWc/if1KJq
         3z2d61CXF1N2kR9KS/Zi/4cwGw99T2D3Pae/UZjutsz4b0lD21nWfgO965/10y7jNH98
         2KHtX/08pAM/876uZzRDl2eLQFfqUNzwewolpXy/aUDpPAhKCB081fBpQPt08/Xz/mCF
         3PSbSBjcEBBYDNoXCgGvS7L9t6ui1GbNslPP6/TJCZq+kcSCFPClwRMGfJyM5ad56Sk8
         8PAA==
X-Gm-Message-State: AOAM531J4bWMtTEPFufqYPAkhY+ugU9K9l/6OpgYA5Gc+84yIbkWVJRQ
        Np9J+ZE4I+YCddU6yfvASdg=
X-Google-Smtp-Source: ABdhPJxPASBlXNxbx3G4ZP89CIihfT21I2UHj792PRIeqO9rwGBCFMzd1o926upif/uvr4znSkrsOA==
X-Received: by 2002:a05:620a:31c:: with SMTP id s28mr11303310qkm.342.1615534308550;
        Thu, 11 Mar 2021 23:31:48 -0800 (PST)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com (177-131-89-8.dynamic.desktop.com.br. [177.131.89.8])
        by smtp.gmail.com with ESMTPSA id t6sm3434026qti.2.2021.03.11.23.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 23:31:48 -0800 (PST)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] powerpc/mm/hash: Avoid resizing-down HPT on first memory hotplug
Date:   Fri, 12 Mar 2021 04:29:39 -0300
Message-Id: <20210312072940.598696-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312072940.598696-1-leobras.c@gmail.com>
References: <20210312072940.598696-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because hypervisors may need to create HPTs without knowing the guest
page size, the smallest used page-size (4k) may be chosen, resulting in
a HPT that is possibly bigger than needed.

On a guest with bigger page-sizes, the amount of entries for HTP may be
too high, causing the guest to ask for a HPT resize-down on the first
hotplug.

This becomes a problem when HPT resize-down fails, and causes the
HPT resize to be performed on every LMB added, until HPT size is
compatible to guest memory size, causing a major slowdown.

So, avoiding HPT resizing-down on hot-add significantly improves memory
hotplug times.

As an example, hotplugging 256GB on a 129GB guest took 710s without this
patch, and 21s after applied.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 36 ++++++++++++++++-----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 73b06adb6eeb..cfb3ec164f56 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -794,7 +794,7 @@ static unsigned long __init htab_get_table_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static int resize_hpt_for_hotplug(unsigned long new_mem_size)
+static int resize_hpt_for_hotplug(unsigned long new_mem_size, bool shrinking)
 {
 	unsigned target_hpt_shift;
 
@@ -803,19 +803,25 @@ static int resize_hpt_for_hotplug(unsigned long new_mem_size)
 
 	target_hpt_shift = htab_shift_for_mem_size(new_mem_size);
 
-	/*
-	 * To avoid lots of HPT resizes if memory size is fluctuating
-	 * across a boundary, we deliberately have some hysterisis
-	 * here: we immediately increase the HPT size if the target
-	 * shift exceeds the current shift, but we won't attempt to
-	 * reduce unless the target shift is at least 2 below the
-	 * current shift
-	 */
-	if (target_hpt_shift > ppc64_pft_size ||
-	    target_hpt_shift < ppc64_pft_size - 1)
-		return mmu_hash_ops.resize_hpt(target_hpt_shift);
+	if (shrinking) {
 
-	return 0;
+		/*
+		 * To avoid lots of HPT resizes if memory size is fluctuating
+		 * across a boundary, we deliberately have some hysterisis
+		 * here: we immediately increase the HPT size if the target
+		 * shift exceeds the current shift, but we won't attempt to
+		 * reduce unless the target shift is at least 2 below the
+		 * current shift
+		 */
+
+		if (target_hpt_shift >= ppc64_pft_size - 1)
+			return 0;
+
+	} else if (target_hpt_shift <= ppc64_pft_size) {
+		return 0;
+	}
+
+	return mmu_hash_ops.resize_hpt(target_hpt_shift);
 }
 
 int hash__create_section_mapping(unsigned long start, unsigned long end,
@@ -828,7 +834,7 @@ int hash__create_section_mapping(unsigned long start, unsigned long end,
 		return -1;
 	}
 
-	resize_hpt_for_hotplug(memblock_phys_mem_size());
+	resize_hpt_for_hotplug(memblock_phys_mem_size(), false);
 
 	rc = htab_bolt_mapping(start, end, __pa(start),
 			       pgprot_val(prot), mmu_linear_psize,
@@ -847,7 +853,7 @@ int hash__remove_section_mapping(unsigned long start, unsigned long end)
 	int rc = htab_remove_mapping(start, end, mmu_linear_psize,
 				     mmu_kernel_ssize);
 
-	if (resize_hpt_for_hotplug(memblock_phys_mem_size()) == -ENOSPC)
+	if (resize_hpt_for_hotplug(memblock_phys_mem_size(), true) == -ENOSPC)
 		pr_warn("Hash collision while resizing HPT\n");
 
 	return rc;
-- 
2.29.2

