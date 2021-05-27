Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0EC3931CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhE0PJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbhE0PHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:40 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818CCC06134B
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:53 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c10so408606qtx.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HZHOJzSFFbUuzx7eGvKvsp2IVzsfaWJrcIfDcXhfmjQ=;
        b=OE2Nv9rI1yl+eDr9xb/59iX9oopmd3JLdS6dWVrola8Od1OZixPXWsBxDTcSsG/BNj
         xqiP3/MtToHN8To0OOVfsTQ3FBtribEObmkQCfcGTb2XGrrt2TWIa9A+RUVytD4Z/F1Z
         kKpuTAqZN0nSiaH9NmXyCZVROaX3De/0QTwv6XiQhtVj2j7cm6+ofwNN8zS5yUCs8bE9
         5f7KTwgzvzQxt+xXns0fOIqMOfXSXcBgLh+YZVajTxS7x88UNgl5ov6gRjoqo7qNpKeE
         aJtrlwWbPDLsQi9BZulXO6txvlllHE94kB0RXJGsAb9bZtu3H53chND0bq2jH+PtgScr
         gSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZHOJzSFFbUuzx7eGvKvsp2IVzsfaWJrcIfDcXhfmjQ=;
        b=dMG4BtHF7BqUNfRj7OM+lCz2ZaP7NGKOwqcdrsa8K9+2TUqO97hUULRwh1ubehNj7A
         YlrleSK+59aphTQktF5ok4Jh7NDS3OOaZ1txtqXas3v4egRAO21rQFWvcu/n0nw0HHM5
         C0JY1dQ/t/G9RuPZqU5LfyqSJ+ygWSiJKIFcDy7OA/DY4Iuo+HfSQb2jYsxwFqGwC+a1
         f85sE8EVw40nCUVLzXvn9wwuUXaFQBcqdC7KCEDs0mcAjMO6s5GKdrE+KdUsVDbRNk5b
         dVuKUUTUyG05BVKIA/BIo/gScpoG82O0omx3IR9Mn3fQJv4vQUEd/jnrftN6RL45MFtB
         9DfA==
X-Gm-Message-State: AOAM530QeZBgG8UdcuIrcSqqVRpYpJZumZwYGLXDYRlf4MSf+tqUOizx
        zPJkwd2Ui78iq4vsXxQ0U1y4eA==
X-Google-Smtp-Source: ABdhPJwQ7PTEJ4bfTYMlyGqHPr1GFZ98OMMmMZTDk2VsdokJOvRo2GHvow0yZur+w4JE/untrcRTcA==
X-Received: by 2002:ac8:66da:: with SMTP id m26mr3565077qtp.102.1622127952711;
        Thu, 27 May 2021 08:05:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:52 -0700 (PDT)
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
Subject: [PATCH 16/18] arm64: kexec: remove the pre-kexec PoC maintenance
Date:   Thu, 27 May 2021 11:05:24 -0400
Message-Id: <20210527150526.271941-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
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
index 96a478d022b6..afbde4bb1829 100644
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

