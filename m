Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3B732B73F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357515AbhCCKvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbhCCA0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:26:41 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880FC0611BD
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:54 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d11so15555803qtx.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mQmK3SsBkKt3YHt5HRugbQ4C32Fw5itH9aDNQf+nmJI=;
        b=cbwp13Q2ddpME4q7SnIYDmvYSLO9Ch0h6chGS0mJcuKYrVSiyW9RqugBaVOLREGq/3
         RaXjQUi+1f2H7Dq7uhH7XbTZd4G8/Xc+rFwYUEEx/AdUSO30WgYG1LUfV2w1G6wCcjc2
         /8GAhHNr0K4pH8SgFuD2VradryKueR66b6D+IX/xPN+SlF18R9pC4oMGtJaJMn5wE4eO
         2KXKyC3D/rElN2+qfLl+X13RT9wKObgzzMT/qtKkvQmWMY9NClwSB/YVP+mMnf17tCpK
         BcdzbAKBOoD7Tz3sqa63lxj0/n8gza47BWFQQyLZKmLhuN8xvSXm97fDqDAG6jrXOUvD
         BH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQmK3SsBkKt3YHt5HRugbQ4C32Fw5itH9aDNQf+nmJI=;
        b=nQeIUFmxN7KUwPJ45qpU4zVd6zI/dU5jzAf9/uPy6yzmCDqeyLKBWdTefv+qdGdKaB
         RKwilkTVNKbpG8KBVRHpESpkxc80P9UHNZ/WAbd8dDkSVE1vXQOlPtlRKX7pSr7laKKR
         /AiAuvrZ+xXzhAdy5WLC2Zn/omS7ssXUMksM2hCKQvHTwr1YTN9Ezw1SsdX5zPlmgiNc
         IjpOdCtBf8LjKvrKby9+DxkAcouLYVUVAKTdXQ290/qsZTiGuMfvzUpcLL+sI/m4v9q7
         qv4dwTKPXy9pWYNF0lLvHZ78p9y0P3wroVKEE08Z2zxoTEFlHxdg49zTiHy3qWrq5WSz
         RbEg==
X-Gm-Message-State: AOAM530QM8KvSkvKPZ8WkPbAK07NjBJFDGSBN/qkiGgJMda3ujR5kjlw
        KpfWx5yacqCqPhygsEcUg9PUQg==
X-Google-Smtp-Source: ABdhPJzDM5pLJqM5foQKA752jyI+AxEsX2Dhp+xecxEILxLFKkHZG6f5Ei6Ery303Y4YtrOKPjg5sg==
X-Received: by 2002:ac8:72cf:: with SMTP id o15mr15747863qtp.118.1614730973753;
        Tue, 02 Mar 2021 16:22:53 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:53 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v12 16/17] arm64: kexec: remove the pre-kexec PoC maintenance
Date:   Tue,  2 Mar 2021 19:22:29 -0500
Message-Id: <20210303002230.1083176-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that kexec does its relocations with the MMU enabled, we no longer
need to clean the relocation data to the PoC.

Co-developed-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/machine_kexec.c | 40 -------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index d5c8aefc66f3..a1c9bee0cddd 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -76,45 +76,6 @@ int machine_kexec_prepare(struct kimage *kimage)
 	return 0;
 }
 
-/**
- * kexec_list_flush - Helper to flush the kimage list and source pages to PoC.
- */
-static void kexec_list_flush(struct kimage *kimage)
-{
-	kimage_entry_t *entry;
-
-	__flush_dcache_area(kimage, sizeof(*kimage));
-
-	for (entry = &kimage->head; ; entry++) {
-		unsigned int flag;
-		void *addr;
-
-		/* flush the list entries. */
-		__flush_dcache_area(entry, sizeof(kimage_entry_t));
-
-		flag = *entry & IND_FLAGS;
-		if (flag == IND_DONE)
-			break;
-
-		addr = phys_to_virt(*entry & PAGE_MASK);
-
-		switch (flag) {
-		case IND_INDIRECTION:
-			/* Set entry point just before the new list page. */
-			entry = (kimage_entry_t *)addr - 1;
-			break;
-		case IND_SOURCE:
-			/* flush the source pages. */
-			__flush_dcache_area(addr, PAGE_SIZE);
-			break;
-		case IND_DESTINATION:
-			break;
-		default:
-			BUG();
-		}
-	}
-}
-
 /**
  * kexec_segment_flush - Helper to flush the kimage segments to PoC.
  */
@@ -200,7 +161,6 @@ int machine_kexec_post_load(struct kimage *kimage)
 	__flush_dcache_area(reloc_code, reloc_size);
 	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
 			   reloc_size);
-	kexec_list_flush(kimage);
 	kexec_image_info(kimage);
 
 	return 0;
-- 
2.25.1

