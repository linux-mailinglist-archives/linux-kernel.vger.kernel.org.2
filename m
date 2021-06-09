Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073CB3A0895
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhFIArp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:47:45 -0400
Received: from mail-qv1-f45.google.com ([209.85.219.45]:41522 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhFIArl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:47:41 -0400
Received: by mail-qv1-f45.google.com with SMTP id x2so11258746qvo.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vcjYajrJXv/lTpIFROIc3rQPTqnw03xFW9e2NsWvMmk=;
        b=SgxuxwSh4m1h9hRbLSuPfBWqYm1As0EuKsoebPFcfd02FoFxpOL3mT49jSoUnPLaoY
         xXYMG+tTO3C+N7O2Oa8tDi6s3ZDHgA3UT3Zd6sJ4IAddJ8riUwdeXtuSRY8OeoY6B9bN
         Qvg/1asVoH690WnwI+WVu/qNQPr848I0tiZ0Cyc8bOt5OyMCHQO+FBh4aacOcfQj6fDb
         ImY6AVSlcszk63W/OPJ/U1o/2NdSKg0m/IOcyH415Qun96VY7uwVn4/mZTzN4O/gXnVz
         aus3TnuWpj+obaFwUe1jmETnpKTJh9r58mmHR1KQwsYmxORiX/pUvrT1lCDV6ddrY1uo
         LOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcjYajrJXv/lTpIFROIc3rQPTqnw03xFW9e2NsWvMmk=;
        b=iNK4Ngp+tMxLY5Z4OylcFP3z/RW93AAmceiMFs/B+DMlsadSeXlJtztohOpGQdv48s
         KTySYR8YTzUfd5bBY4oc8jbUDTg5I6qTFMom9w+1fTvw7eGpuYCWW1fdPFWc/Ut0pnam
         apyQmOq01sd9FsSNsD/FbGHHqFyN9OhCgMpMcaRcpb+BOLaM/PFrPCbSrjas/SLxNsuq
         xcUZt7rR1EyL4xYptvZrNMAxl09msrpN9H9WWD7ZXRWiWk4vXzSW6j+DTf6KNtDCaw1m
         ZSgU1EQkox2MmMK7I5ywANM+I5J1WHRxujKemZ/oxy2vqYPhrJ//tgi7nfd3p0ZxOkWb
         1+vA==
X-Gm-Message-State: AOAM530N4LldCvIM2hgUfXLgmodvTXCAwqLdN5kcK/rA+wcyysc7t+hC
        joxllSGD2nqvBp6ccQE2MQFxmw==
X-Google-Smtp-Source: ABdhPJwHZbV81EmFC6ZnIEtukl3+Va3nM0ikxHKwWsJt6Ayst+Mc2MnTDU4ZHzbTNSVXncCD8AXVhw==
X-Received: by 2002:a05:6214:21c8:: with SMTP id d8mr3294306qvh.35.1623199480026;
        Tue, 08 Jun 2021 17:44:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n194sm12869011qka.66.2021.06.08.17.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:44:39 -0700 (PDT)
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
Subject: [PATCH v15 13/15] arm64: kexec: remove the pre-kexec PoC maintenance
Date:   Tue,  8 Jun 2021 20:44:17 -0400
Message-Id: <20210609004419.936873-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
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
 arch/arm64/kernel/machine_kexec.c | 40 -------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index a2163ea24fc1..8f8962f53ba2 100644
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

