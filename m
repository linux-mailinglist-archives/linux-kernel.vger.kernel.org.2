Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F50E357B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhDHEGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhDHEGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:06:11 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7370C061761
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:06:00 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q26so928959qkm.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mQmK3SsBkKt3YHt5HRugbQ4C32Fw5itH9aDNQf+nmJI=;
        b=elWVu7ElduDgar7M15pPxIjNtGuFk2IxD56SO/LLqYMadH0bLeFPVdDJrrgXHMQQHY
         5O+hPoZGbI2/fKrRlolSphZQemU4b8fO04rT4MR4ge8GzoS//g8BcNoHJnDWpxtXN6m6
         K4yt0Ll7DaykR8Tyr8MCv2ALdhZZld2Z8v2GxISaLhL5P8n+yqVTAzsr885OTW/r/CaI
         ZWy3CSy0Jkc5aLPCQK2fFbp0qgOEgsvZVoIRkykT6rD/cRQui4N8LS/GWlBbLALSY4Jx
         +gOmt9BWnaITKKFW5XLWpNvETX8hDJzB/44NqbVBwH4mg3CMwDb3PBBB0DlOUtBELbj+
         7j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQmK3SsBkKt3YHt5HRugbQ4C32Fw5itH9aDNQf+nmJI=;
        b=Hg63/wNmkVXWukboHhALGskLzqAqcu9Wg+PbgC7mEhAa2HEUQ/Z++pqljH1sX7AsEq
         NgYc8dBf79mpIIfJUi01YtRoWx2uNCyWbqgCsIGr4YZBseQQ0ae+MsTg6lGv5QJYSigw
         t43leHU3RFmNLYP2PqGSo3pXMeLfvodalsGhFDYEjD+b8wY/mHl0JU1p6hgt7p+wSB8B
         ZznC/pxznD7SyEHIkKvBLUuznpxiATmhzYTHIk6uLyzSy777qvOiYNUBflAc5o3neGwF
         KLKa+P/RSq8KdSw6I9IL4qGRECe0RuG1ih2rS/fqYyvm1S6KCgtnk4XMePgyj9fJHRLh
         i3mQ==
X-Gm-Message-State: AOAM532ZQDtONtdnVINqNOcbm3V03II1Eppmnh3b4KG00i/LKunrReVb
        jJPWddKI+Iel4S9HKW4zlcknkA==
X-Google-Smtp-Source: ABdhPJw8BJbPk7oxJbt5TiRHY20STpCei8pN80U8MVBJiPqRcb2nWUnW5QpsnWL/n+1r5eSXF613pQ==
X-Received: by 2002:a37:c92:: with SMTP id 140mr6714935qkm.177.1617854760170;
        Wed, 07 Apr 2021 21:06:00 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:59 -0700 (PDT)
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
        kernelfans@gmail.com
Subject: [PATCH v13 16/18] arm64: kexec: remove the pre-kexec PoC maintenance
Date:   Thu,  8 Apr 2021 00:05:35 -0400
Message-Id: <20210408040537.2703241-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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

