Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F3241DC4E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350283AbhI3OdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350226AbhI3OdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:03 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5FFC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:20 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x9so3661416qvn.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wvhp7Shwzj2V1AcHSUNo3T+jO//upg214s/8JF7+8X4=;
        b=WzTIvObi8BmW8NTQjOqb0FOv0H/1NPIY+oIISBMpm8fDw4WooAALyuQ8nS0FbKt/SD
         oG484TyexjpEF9PLSUf6FoVGHUmJa7wCuNbtCA+2gWYOBP7IMxuKsxo2SB2qce1734pU
         xsEoWg7TnfyCy6fwEslgvv5G4WPjSmJb/ebM1dBbO3PAOPhAMBgXqHNADEKlZZw80hfB
         UHXFu0nSxEI896qgpyWWYjO5i4k8yAw4Zdf5kcNiCy9l3kfnM4g1YbizWJfXBfT0X1pO
         i58tA/zr32BfcRs2J3R6EKHkuX/khIa1jSiNc1733FUETlk2PlBrtbTQuqXUQUOrPrxJ
         0vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvhp7Shwzj2V1AcHSUNo3T+jO//upg214s/8JF7+8X4=;
        b=f8imNMHyn+nHl6r2lozKQ/21HA2psdwp9dkhPqSZvOssofNkEhvCtreun+a9Wj/ZRw
         s6r9l4T7B2aKLaDJgn7Z/VbvxbuVaVbjEsm2TDkHbpxFZC2U+yxPW0/5mcv0mzxKjO4c
         vXmvZbVUzeSQGlJcKCWh0ok167HyZGfYd6u6p6+HgRT1z/POyzVeK3MfEvKwxBMkX22u
         fNNPei7imUC6cMeFAids3CETbHlDdiuM2e80b/FeW0ZB3R+dn/U4pXQLmMNP+DGNGDGa
         ZI4EWYXMqPWoUhMQLicz26walf6WBQTUGCT+73QB0/XETX580ZKVaauowQdioeSbI7Bp
         wplA==
X-Gm-Message-State: AOAM532Y0X78ZeoNVSEbDVOfonW1VZq6eDkLwUmwYFpajlXtkjs+NncM
        i3eys7aKUYM1kOcF7YiqUeg1Eg==
X-Google-Smtp-Source: ABdhPJyRpe+0jXAcRshmB05WHMM4GvLP/u4h4SOYX1etnyUhK8wl9VzQ7qbqdCBBQWvQ1rXkOCyYsA==
X-Received: by 2002:a05:6214:90:: with SMTP id n16mr4150225qvr.1.1633012279941;
        Thu, 30 Sep 2021 07:31:19 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:19 -0700 (PDT)
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
Subject: [PATCH v18 04/15] arm64: kexec: flush image and lists during kexec load time
Date:   Thu, 30 Sep 2021 14:31:02 +0000
Message-Id: <20210930143113.1502553-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, during kexec load we are copying relocation function and
flushing it. However, we can also flush kexec relocation buffers and
if new kernel image is already in place (i.e. crash kernel), we can
also flush the new kernel image itself.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/machine_kexec.c | 58 ++++++++++++++-----------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 213d56c14f60..b6d5a02cba2e 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -60,29 +60,6 @@ void machine_kexec_cleanup(struct kimage *kimage)
 	/* Empty routine needed to avoid build errors. */
 }
 
-int machine_kexec_post_load(struct kimage *kimage)
-{
-	void *reloc_code = page_to_virt(kimage->control_code_page);
-
-	memcpy(reloc_code, arm64_relocate_new_kernel,
-	       arm64_relocate_new_kernel_size);
-	kimage->arch.kern_reloc = __pa(reloc_code);
-	kexec_image_info(kimage);
-
-	/*
-	 * For execution with the MMU off, reloc_code needs to be cleaned to the
-	 * PoC and invalidated from the I-cache.
-	 */
-	dcache_clean_inval_poc((unsigned long)reloc_code,
-			    (unsigned long)reloc_code +
-				    arm64_relocate_new_kernel_size);
-	icache_inval_pou((uintptr_t)reloc_code,
-				(uintptr_t)reloc_code +
-					arm64_relocate_new_kernel_size);
-
-	return 0;
-}
-
 /**
  * machine_kexec_prepare - Prepare for a kexec reboot.
  *
@@ -163,6 +140,32 @@ static void kexec_segment_flush(const struct kimage *kimage)
 	}
 }
 
+int machine_kexec_post_load(struct kimage *kimage)
+{
+	void *reloc_code = page_to_virt(kimage->control_code_page);
+
+	/* If in place flush new kernel image, else flush lists and buffers */
+	if (kimage->head & IND_DONE)
+		kexec_segment_flush(kimage);
+	else
+		kexec_list_flush(kimage);
+
+	memcpy(reloc_code, arm64_relocate_new_kernel,
+	       arm64_relocate_new_kernel_size);
+	kimage->arch.kern_reloc = __pa(reloc_code);
+	kexec_image_info(kimage);
+
+	/* Flush the reloc_code in preparation for its execution. */
+	dcache_clean_inval_poc((unsigned long)reloc_code,
+			       (unsigned long)reloc_code +
+			       arm64_relocate_new_kernel_size);
+	icache_inval_pou((uintptr_t)reloc_code,
+			 (uintptr_t)reloc_code +
+			 arm64_relocate_new_kernel_size);
+
+	return 0;
+}
+
 /**
  * machine_kexec - Do the kexec reboot.
  *
@@ -180,13 +183,6 @@ void machine_kexec(struct kimage *kimage)
 	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
-	/* Flush the kimage list and its buffers. */
-	kexec_list_flush(kimage);
-
-	/* Flush the new image if already in place. */
-	if ((kimage != kexec_crash_image) && (kimage->head & IND_DONE))
-		kexec_segment_flush(kimage);
-
 	pr_info("Bye!\n");
 
 	local_daif_mask();
@@ -261,8 +257,6 @@ void arch_kexec_protect_crashkres(void)
 {
 	int i;
 
-	kexec_segment_flush(kexec_crash_image);
-
 	for (i = 0; i < kexec_crash_image->nr_segments; i++)
 		set_memory_valid(
 			__phys_to_virt(kexec_crash_image->segment[i].mem),
-- 
2.33.0.800.g4c38ced690-goog

