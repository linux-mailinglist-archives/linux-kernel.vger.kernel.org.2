Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476C336FC88
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhD3Ohg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhD3Ohe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:37:34 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BBEC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:36:45 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id u20so38688819qku.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alyS840WpTY55RdF+7Kqh/069+/rmbTaDiI+qnnTJwM=;
        b=c8VZuzhHSyKUnoyRpry9HnofH2E3TKJSC5Dx7anszw68lOhGBhyzyGz7fRsk0Wtayy
         WQiWwi6GDC3A8SPS32rdvg9m3/o5XrwEKWzX/CDDrimzSD7zypjo2/Z7FkelKzlfbAQs
         8M3hLf8iioo8MjzGBapd1TCJ0NOVNgOP3S0zyRZ5g/VCTnA4vncy/SvAB2IyoQqXwtXt
         I5THmLp/IHCjGsPhQ5CAouOFAh/v9u9lH9RyRTlupM+oJUsiOv8qAj7kqndH5y6fJuXf
         RCSbYfGJao1cVYHjKZ6QwWqu3SwbQDa6TfsmgDWLQ05xMRL79jsCiQ4a94wdGgfV3lbn
         C3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alyS840WpTY55RdF+7Kqh/069+/rmbTaDiI+qnnTJwM=;
        b=ZyBTNhtmLeJnqxq6QaIXsAuTYlQFgOeXKOuoDa5211KLSztHQefjVTQpKSusUJzYt+
         RqAn4qpcDkYwzwIWlypKH+AlfPTK+RnOq6Y8HpVDechHaf4rnUy9EAsp9z3kMP9scS04
         FCM+lQr7XyZyMMrVE+gNuXv/+G8x7vhvoVu9xFqycM+uL/4PpEUfGcmSOkmepfYkZ/yl
         d68CtYfasXVF8g8C1R5UTFRGXM+GYnqgB4LGEizerhqia6/hclgGitPhLNG/u07Svo2L
         JadGyTYRiZ0r/rQB06oJ8V6Iek8RfzfMXrujjSyMA/M5s31u0KB3VTokUvyO9zFwMKPx
         Y3mw==
X-Gm-Message-State: AOAM533en16vyzcyoc9DC2Ca9eY2ZbuI9AIlFPG+QqwNJaWQd9Y78zWM
        yl10oJiLv6kkhDX606Orr0w=
X-Google-Smtp-Source: ABdhPJw7izh38YAvpwf5z4TKLLJtQ6zNbOrQKLzjbpHnS+3xmj9H9Dq846g3uQjOCGoDxuVcsk5ulg==
X-Received: by 2002:a37:688:: with SMTP id 130mr5759408qkg.499.1619793404447;
        Fri, 30 Apr 2021 07:36:44 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id 190sm1532560qki.115.2021.04.30.07.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:36:44 -0700 (PDT)
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
Subject: [PATCH v2 1/3] powerpc/mm/hash: Avoid resizing-down HPT on first memory hotplug
Date:   Fri, 30 Apr 2021 11:36:06 -0300
Message-Id: <20210430143607.135005-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430143607.135005-1-leobras.c@gmail.com>
References: <20210430143607.135005-1-leobras.c@gmail.com>
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
index 581b20a2feaf..608e4ed397a9 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -795,7 +795,7 @@ static unsigned long __init htab_get_table_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static int resize_hpt_for_hotplug(unsigned long new_mem_size)
+static int resize_hpt_for_hotplug(unsigned long new_mem_size, bool shrinking)
 {
 	unsigned target_hpt_shift;
 
@@ -804,19 +804,25 @@ static int resize_hpt_for_hotplug(unsigned long new_mem_size)
 
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
@@ -829,7 +835,7 @@ int hash__create_section_mapping(unsigned long start, unsigned long end,
 		return -1;
 	}
 
-	resize_hpt_for_hotplug(memblock_phys_mem_size());
+	resize_hpt_for_hotplug(memblock_phys_mem_size(), false);
 
 	rc = htab_bolt_mapping(start, end, __pa(start),
 			       pgprot_val(prot), mmu_linear_psize,
@@ -848,7 +854,7 @@ int hash__remove_section_mapping(unsigned long start, unsigned long end)
 	int rc = htab_remove_mapping(start, end, mmu_linear_psize,
 				     mmu_kernel_ssize);
 
-	if (resize_hpt_for_hotplug(memblock_phys_mem_size()) == -ENOSPC)
+	if (resize_hpt_for_hotplug(memblock_phys_mem_size(), true) == -ENOSPC)
 		pr_warn("Hash collision while resizing HPT\n");
 
 	return rc;
-- 
2.30.2

