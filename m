Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051EB41DC59
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348476AbhI3OfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351935AbhI3OdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:12 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F260C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:30 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o15so3706338qvq.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5Swv6lplDzjvDpp+CqlYUWQ4CihY4pr+PdPAAcX6X0k=;
        b=QIl+s6AgZb/E9V+qFkaJv28iDbmNKtriCkBKOedA+vTjWGPQUHwOWsSN82vUhYFDPa
         aKGX8pbht4XajcOxe9AsUPnPHyFeMsy53kNmxOp3NUiw7gCTOFbJHD2xFmkobfsYc6tc
         +a3sdvCpBBLPEhOdR01yAiMVZgRcqbM5QUcmBf0qkoXY2cJCdwNF4UEA2JfG0IDurSJL
         wCqpUukwDUB5zPuu1BM5g/ZOGHHARNjAM79AbZES71bLfS3MSsmn1x/xQsLYN7rTb6s9
         X7JRzwlBTy1hpr+G/1SwuZkqioteecdFDqEFHGew47hr8gs54RBmUJ+WmmZ3E1UZGl1E
         MNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Swv6lplDzjvDpp+CqlYUWQ4CihY4pr+PdPAAcX6X0k=;
        b=CO+3xhNjTE+pFuLzxN8rhtsiOTvkn/re0IfCOkw/B/+BH8TcRxLpSK8EHTx2erd7Vh
         kfZUMroptuaHRYjWGGUD2nD5kK78w2U9oGoLnifkE1K5w9QxFLJc80q5dXLGZdBuEPop
         DLfHbfYyfc94/38tFnvbacdnMqsIwThvZzS8YrVj0nPgjhw/sbV1kp0NITKWXtl3xEAC
         NMCHcrq1Pi/AVpva/4CWAoisH7GGjrvWCdmwMx9J7wdwj2n8V57dU8WRsVfBqXxJHSTV
         vg7k48ELXrTju9EeEyBMhkkvIDoHMWsBV77b2bZsz+Cw52DsjGFmEO75ajQwZvM5QQrT
         rFYw==
X-Gm-Message-State: AOAM532T8CH2JYqsabiDbGSGspBnKKwr7zmD8jCHOL0wuUMeUzk3HTwD
        D8JgpUi7HhQWhIPh5P8aiaboOQ==
X-Google-Smtp-Source: ABdhPJxh6s/187JmlvOIcH5ROC+cTxyh2kXDCoA5lkqv5O44XaWCE6Q0LOi1e6FSLI9Y930/MBRD8A==
X-Received: by 2002:a05:6214:1427:: with SMTP id o7mr5627954qvx.45.1633012289388;
        Thu, 30 Sep 2021 07:31:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:28 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, kernelfans@gmail.com, akpm@linux-foundation.org
Subject: [PATCH v18 13/15] arm64: kexec: remove the pre-kexec PoC maintenance
Date:   Thu, 30 Sep 2021 14:31:11 +0000
Message-Id: <20210930143113.1502553-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that kexec does its relocations with the MMU enabled, we no longer
need to clean the relocation data to the PoC.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/machine_kexec.c | 43 -------------------------------
 1 file changed, 43 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 1e9a2a45e016..559d47a3c59c 100644
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
 			       (unsigned long)reloc_code + reloc_size);
 	icache_inval_pou((uintptr_t)reloc_code,
 			 (uintptr_t)reloc_code + reloc_size);
-	kexec_list_flush(kimage);
 	kexec_image_info(kimage);
 
 	return 0;
-- 
2.33.0.800.g4c38ced690-goog

