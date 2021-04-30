Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD5836FC89
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhD3Ohx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhD3Oht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:37:49 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAEDC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:37:01 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id j19so11446164qtx.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrdezJ4pdCtm9VV6EXYt28y/b60CBWuF37yCYjbQazM=;
        b=rO50kzg0l9E+8Eg+I65gJrSxNnjQtRijxEk2BsbLQoYrMAxxd+6IJf1LdDx3tU5zev
         1nqp89tKL4Rh4bgn/90v/493AFaPuDvFQvFoAbjKgeE0zh4bGQE0p2h3ASQiTOJWKOpl
         FmebhSkeRXDQyEoXa30OO/Ij+zkoURFOYaNXF1683ve/nowQwTk0KD1CDHG2hezw4fQY
         zp5R6jBHMdgfiuC1k7pAZAL4hEqTAS5TVLcmmd0JiXVOJRgAw1DDkI4SenOD7kqRcNVi
         tnCPDB7CVNWHug6yLfQR2AMxXgDlqZhh1Bsfbk4bY44wIw1jcLAz8JEw330qSLsfOgqR
         HEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrdezJ4pdCtm9VV6EXYt28y/b60CBWuF37yCYjbQazM=;
        b=MjNtcfTa+lK0SryEMetSKz8sluU5DvFiYYYsItFPNCiuUN8lLYPf2Xh1jEoQ3HKDtm
         CyBgb3OeK5bnQP9RL4kNJBM7q5Racw5wu+xfEP/JsBwn553ZAi+F3z7vQCqXcNLIn4sh
         1RyC8xI3Lul81jpyplauFxSmjR4tkrXnojT1bpNu+xM6fDvLu1tF+Xk4RYGA8OpUb2TI
         v0GSrBAgI9c5LFOUr9zCv9io/Y485vARpV7dFM/il7tuwFbQv82uRmMK4dNTBBwPPfHv
         HYF+2SKor9iBN7ObAglJbJk2DeF4jZanMvX3vfkxUKTgDmzSz078MIdGMxWzfguZuO11
         Xx1Q==
X-Gm-Message-State: AOAM531T903K7qBwzLhVieuiExjRQLO25UBPm4Nqe0WPkZ+jQ5bic7wo
        5XNvFmyy4hiijSgy/em8W/c=
X-Google-Smtp-Source: ABdhPJxhmKbcPVKKKaeOcfVyZbISGyjoYrD0vwX7Ak3/6ff5O4h3kDte6NVXtK31M5o/UXRQAe2Dew==
X-Received: by 2002:ac8:75ca:: with SMTP id z10mr4722997qtq.137.1619793420373;
        Fri, 30 Apr 2021 07:37:00 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id 190sm1532560qki.115.2021.04.30.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:37:00 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] powerpc/mm/hash: Avoid multiple HPT resize-ups on memory hotplug
Date:   Fri, 30 Apr 2021 11:36:08 -0300
Message-Id: <20210430143607.135005-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430143607.135005-1-leobras.c@gmail.com>
References: <20210430143607.135005-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time a memory hotplug happens, and the memory limit crosses a 2^n
value, it may be necessary to perform HPT resizing-up, which can take
some time (over 100ms in my tests).

It usually is not an issue, but it can take some time if a lot of memory
is added to a guest with little starting memory:
Adding 256G to a 2GB guest, for example will require 8 HPT resizes.

Perform an HPT resize before memory hotplug, updating HPT to its
final size (considering a successful hotplug), taking the number of
HPT resizes to at most one per memory hotplug action.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h     |  2 ++
 arch/powerpc/mm/book3s64/hash_utils.c         | 20 +++++++++++++++++++
 .../platforms/pseries/hotplug-memory.c        |  9 +++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d959b0195ad9..fad4af8b8543 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -255,6 +255,8 @@ int hash__create_section_mapping(unsigned long start, unsigned long end,
 				 int nid, pgprot_t prot);
 int hash__remove_section_mapping(unsigned long start, unsigned long end);
 
+void hash_batch_expand_prepare(unsigned long newsize);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 608e4ed397a9..3fa395b3fe57 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -859,6 +859,26 @@ int hash__remove_section_mapping(unsigned long start, unsigned long end)
 
 	return rc;
 }
+
+void hash_batch_expand_prepare(unsigned long newsize)
+{
+	const u64 starting_size = ppc64_pft_size;
+
+	/*
+	 * Resizing-up HPT should never fail, but there are some cases system starts with higher
+	 * SHIFT than required, and we go through the funny case of resizing HPT down while
+	 * adding memory
+	 */
+
+	while (resize_hpt_for_hotplug(newsize, false) == -ENOSPC) {
+		newsize *= 2;
+		pr_warn("Hash collision while resizing HPT\n");
+
+		/* Do not try to resize to the starting size, or bigger value */
+		if (htab_shift_for_mem_size(newsize) >= starting_size)
+			break;
+	}
+}
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 static void __init hash_init_partition_table(phys_addr_t hash_table,
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 8377f1f7c78e..48b2cfe4ce69 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -13,6 +13,7 @@
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
 #include <linux/slab.h>
+#include <linux/pgtable.h>
 
 #include <asm/firmware.h>
 #include <asm/machdep.h>
@@ -671,6 +672,10 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 	if (lmbs_available < lmbs_to_add)
 		return -EINVAL;
 
+	if (!radix_enabled())
+		hash_batch_expand_prepare(memblock_phys_mem_size() +
+						 lmbs_to_add * drmem_lmb_size());
+
 	for_each_drmem_lmb(lmb) {
 		if (lmb->flags & DRCONF_MEM_ASSIGNED)
 			continue;
@@ -788,6 +793,10 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
 	if (lmbs_available < lmbs_to_add)
 		return -EINVAL;
 
+	if (!radix_enabled())
+		hash_batch_expand_prepare(memblock_phys_mem_size() +
+					  lmbs_to_add * drmem_lmb_size());
+
 	for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
 		if (lmb->flags & DRCONF_MEM_ASSIGNED)
 			continue;
-- 
2.30.2

