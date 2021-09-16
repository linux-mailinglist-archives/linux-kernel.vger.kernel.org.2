Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF540EDC9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbhIPXPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbhIPXPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:15:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B0C061768
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:47 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id u21so7157000qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GN2IcTbnQy/l+AFlkLqiV8UzoxXsj+8ZLQih7s8aKx8=;
        b=M5CTfZo1Z3z8nnNhnSFnT5bZBoCyHcCSNQY5IAC70LR1ZVyh+O5AiCH+3JYzT54AO6
         cogP5W8eYZVIR2HOkx271Tj9VX8PBKz8/eNdidBdVg6QXW33cttuUdaqwjaZ70DOvRyQ
         urh5mgNU8A9pRPwtSyQnngaEuDTYYjvPzcqsyq7+Zt33I/s9aPLeGoYRv0xCRcZPFjAg
         rw5EHVkik9ia9CQVkBGQ0DyL76YQByOc8x2ktd7fEnxBHGxeswnzAPZNf/nDH85hlAML
         5haphvkFDZ3lgxc1HuLEOZ4EcyLLdUqdW35viL7w2GR0UsaCv1Z1s8rbSdWn4NYvDQh6
         vtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GN2IcTbnQy/l+AFlkLqiV8UzoxXsj+8ZLQih7s8aKx8=;
        b=aqBwa2FSsx2PW/feXsAz56Y+Tpok5gi9p+D+/sEmIuMyXQ8Jsie3o1O4YzwTEjn139
         bQOyaOKBe3mXPcORhKl0At7Xq4rWC69C81guSYu0GZ1JMwNj6DBnD5aY2u+zCtUfP4ix
         ofV+5Tzxj7dJKJXLz5gHo8sVGPJqGRwq9l32m4JwDUeQYgZTHnu0cUq7tk6/odimtOCN
         DbHp4MpgDfgtmJV0NM+nAbd+9GRsscKRXHukfzYQEqfkUtEAPbOIiKzeXJUgmD5RkEGK
         LkT86VTCLCdEmvRk/QCrB5paZ1t0oo7oGVY6TGLgLoVvXN2bRWP6Pna6h6onq3Wvm1ZJ
         7NWQ==
X-Gm-Message-State: AOAM532n/MwZC/hlUjQM7ue3AcXNex0a3whXaGBG3FAMV/nuk21VgR9s
        a35kheD8AF7CbmzsCDqANcqkLA==
X-Google-Smtp-Source: ABdhPJwIqEQH++TUi7ZgjSc7lOCNqi10ZjOdZ+AKQdZt+gJhzCLC515q41J5bOiRYru4kSW7phljFQ==
X-Received: by 2002:ac8:4149:: with SMTP id e9mr7629536qtm.249.1631834026997;
        Thu, 16 Sep 2021 16:13:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id az6sm3312891qkb.70.2021.09.16.16.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:13:46 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
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
Subject: [PATCH v17 13/15] arm64: kexec: remove the pre-kexec PoC maintenance
Date:   Thu, 16 Sep 2021 19:13:23 -0400
Message-Id: <20210916231325.125533-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that kexec does its relocations with the MMU enabled, we no longer
need to clean the relocation data to the PoC.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
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

