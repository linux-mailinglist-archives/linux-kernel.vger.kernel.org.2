Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028133A0888
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhFIAqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhFIAqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:46:37 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3EC061789
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 17:44:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j184so22157348qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FcIEg/sDUKkdURMCkTF1KW5fxOPpkw674yFxDZdydcg=;
        b=QeK9i9pdmaa5nrGaHB0x+uBs1hguggMbvBuQFu3ngSXQDb/b76nSpsoWSwBEz1ZACF
         8ZX9NJFTN6TDfgF/DKMPtvjN3Ytjy+7x9eRS9YkXaGNzJPpop9/fOLqR31ZeGJJ2e7mA
         +esyIRxbARxZLUdDBflzEqprasBY+fb3LOQqwfPL1M7t0uOBFj8ptNfgn7d6wbFX6nH6
         sU/95ZCHJH2gX/SZiMrYBybdiyc7mOapL8IpuTw4ayFFpfIhy7lwlU/pCpKcMBKMIY5l
         GmNfsInXoZvl4nLA4vJg/YckdTiEwOA7CGMnn5e7ZmQg6RlxfdZk83AjSftF1dPIm3j6
         5m0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcIEg/sDUKkdURMCkTF1KW5fxOPpkw674yFxDZdydcg=;
        b=Vdt8EaQtPiK00AEVtvCstVV1jSzRBF7rmvmYa2FceAPrGOtZOYFdJ6x4eKCSNlCn6Y
         NlINTYYG/SemfrCwiaiFptjKf41WQVykgBYDWkPz27qdbhcrOST66xGT/NVE0gM+ZJJB
         3FqQXKpppjPTDsl420EuRRWLpWOBur5i/+UXdupQO0UKYvpRpQWwhtbwmZsGgp3h9akp
         S6SAMvtSThNRSesC9ey/S1fKuzFLKsVi3Ja6mnjuAcWEXxgumt83JBLPvPZOo8FdcfLa
         +m8y5/ano5Blw+eSz+ntm7y0VVC5J4rKvfBG7bf4T3wQ/LiaCsqmdEJeJFJ+CU4anfk6
         AsWg==
X-Gm-Message-State: AOAM533lx1KKIXqtXSNWS3bCk+ktkCt46yy8ciW6sKWi9Dk0Y2dgosSK
        9U1CoxRKXfcr8K5vula9CJvENg==
X-Google-Smtp-Source: ABdhPJzgsboPEWF+K2hwsvp2uYA2cq6gLqfyoPJs2qRhodktFoeQ6z2ViDG81uQldPhedYPiyLuRrw==
X-Received: by 2002:a37:5dc4:: with SMTP id r187mr23745072qkb.174.1623199467407;
        Tue, 08 Jun 2021 17:44:27 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n194sm12869011qka.66.2021.06.08.17.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:44:27 -0700 (PDT)
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
Subject: [PATCH v15 04/15] arm64: kexec: flush image and lists during kexec load time
Date:   Tue,  8 Jun 2021 20:44:08 -0400
Message-Id: <20210609004419.936873-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, during kexec load we are copying relocation function and
flushing it. However, we can also flush kexec relocation buffers and
if new kernel image is already in place (i.e. crash kernel), we can
also flush the new kernel image itself.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/machine_kexec.c | 49 +++++++++++++++----------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 90a335c74442..3a034bc25709 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -59,23 +59,6 @@ void machine_kexec_cleanup(struct kimage *kimage)
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
-	/* Flush the reloc_code in preparation for its execution. */
-	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
-	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
-			   arm64_relocate_new_kernel_size);
-
-	return 0;
-}
-
 /**
  * machine_kexec_prepare - Prepare for a kexec reboot.
  *
@@ -152,6 +135,29 @@ static void kexec_segment_flush(const struct kimage *kimage)
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
+	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
+	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
+			   arm64_relocate_new_kernel_size);
+
+	return 0;
+}
+
 /**
  * machine_kexec - Do the kexec reboot.
  *
@@ -169,13 +175,6 @@ void machine_kexec(struct kimage *kimage)
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
@@ -250,8 +249,6 @@ void arch_kexec_protect_crashkres(void)
 {
 	int i;
 
-	kexec_segment_flush(kexec_crash_image);
-
 	for (i = 0; i < kexec_crash_image->nr_segments; i++)
 		set_memory_valid(
 			__phys_to_virt(kexec_crash_image->segment[i].mem),
-- 
2.25.1

