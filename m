Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBB3DE1FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhHBVzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbhHBVyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:54:46 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC2DC061799
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:54:29 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 3so9650568qvd.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r+CYCZCiU1cMcD+VmU9RhDaYUtg7Su3wxwCheymC23U=;
        b=jctFebjkj3S+TT2x0nauprSV2wyj0PwRV40R5o4/TRvvfjkGSMl96RZP+Aqp2IFQ5m
         IR9X6dgSW4nno0xAh35XttKT4va3Hvq6tlueaS40BE+3FKdhcycgnE6xBVMQT7TAZqUE
         71O9mr3Wl8Mt6kce6WpT8dOMeSrUaOYwFzLXe3sdZHUGXr6ohZfCVt6qsTEC9SNDWKkm
         R4+sJuqlCeOZZi5H9J3GsMLXN4keopqd+c5IcdI6xf4XJNoEwSiPEuX0wV5kIrPmvVHC
         01mW7aNFawtNFDhbUR4mjsfOOn0j1N9LKv2W8Lkg0DREVeqoFcXJ+gaiBNsjZ5hVnO2K
         kaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+CYCZCiU1cMcD+VmU9RhDaYUtg7Su3wxwCheymC23U=;
        b=UyKD2MRn01d91PZveqOlCY7YE242JuwmqDtirve8Fon1YNWZh3YV6TmDo0Da2NPsmY
         7TJxh/CHd3VUj7hbhS7yfjZu1o51jxu/efQx/6wa4h6rZwTPzU7+LG4QV9m0FsM5dbfm
         kluyWKRoDM/WzJLa4AfxlW8lc7AHsSpt4XIuXJOPi9z59jRx/BHZbu+tCc1aWj6zPahD
         98d0SwEse/9g5B27o9L1pchw1l5S7h3Q2GNh6PCazjVnur0T1QuJLem04TF242AQ593T
         hRqABKi9N/0yrPKz8orqc06k41//UOT0XLxXHMsr/SLF9OgP0z5sRB4FB4lrgGaCmV9c
         Mizw==
X-Gm-Message-State: AOAM5326fzy73+4aXkJDYFukXu3FIqGx3CZlEwrW0w4TxvOh0PcFUSBM
        MvH97zrv5ynvbpUJkc9EiRlk/Q==
X-Google-Smtp-Source: ABdhPJyd/VxX84pagYf1ZcTV+T5GT+qS17GuV4XbvkFGYFpX9dQIB5Z9oz1yWxX+Lk4ixOmma8alIw==
X-Received: by 2002:a0c:c2d3:: with SMTP id c19mr18681667qvi.62.1627941268973;
        Mon, 02 Aug 2021 14:54:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v11sm5479216qtc.0.2021.08.02.14.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:54:28 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: [PATCH v16 13/15] arm64: kexec: remove the pre-kexec PoC maintenance
Date:   Mon,  2 Aug 2021 17:54:06 -0400
Message-Id: <20210802215408.804942-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that kexec does its relocations with the MMU enabled, we no longer
need to clean the relocation data to the PoC.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/machine_kexec.c | 43 -------------------------------
 1 file changed, 43 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index b43195a7fcb6..b1856f34cc51 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -77,48 +77,6 @@ int machine_kexec_prepare(struct kimage *kimage)
 	return 0;
 }
 
-/**
- * kexec_list_flush - Helper to flush the kimage list and source pages to PoC.
- */
-static void kexec_list_flush(struct kimage *kimage)
-{
-	kimage_entry_t *entry;
-
-	dcache_clean_inval_poc((unsigned long)kimage,
-			       (unsigned long)kimage + sizeof(*kimage));
-
-	for (entry = &kimage->head; ; entry++) {
-		unsigned int flag;
-		unsigned long addr;
-
-		/* flush the list entries. */
-		dcache_clean_inval_poc((unsigned long)entry,
-				    (unsigned long)entry +
-					    sizeof(kimage_entry_t));
-
-		flag = *entry & IND_FLAGS;
-		if (flag == IND_DONE)
-			break;
-
-		addr = (unsigned long)phys_to_virt(*entry & PAGE_MASK);
-
-		switch (flag) {
-		case IND_INDIRECTION:
-			/* Set entry point just before the new list page. */
-			entry = (kimage_entry_t *)addr - 1;
-			break;
-		case IND_SOURCE:
-			/* flush the source pages. */
-			dcache_clean_inval_poc(addr, addr + PAGE_SIZE);
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
@@ -207,7 +165,6 @@ int machine_kexec_post_load(struct kimage *kimage)
 			       (unsigned long)reloc_code +  reloc_size);
 	icache_inval_pou((uintptr_t)reloc_code,
 			 (uintptr_t)reloc_code + reloc_size);
-	kexec_list_flush(kimage);
 	kexec_image_info(kimage);
 
 	return 0;
-- 
2.25.1

