Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE70532B736
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442130AbhCCKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237782AbhCCAZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:25:32 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0163C061223
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:42 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id a9so7781936qkn.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FcIEg/sDUKkdURMCkTF1KW5fxOPpkw674yFxDZdydcg=;
        b=O7cPe49tVOcGseTiLHnzDyJZBZLGwQ8Mqe5Dn8mcQ7k5iBMuCobmbyqA2O4I+bELpB
         zHLp06elBMsXF5GXqnhfiFgVl8HzIeeAxXZanZh9XuGoGveIfu8Logb3klD20cg4Lajg
         camd8RfSe3wGmyeRjz3ajPwHXzU4RxSIsDAkaf3k/Ym8xBkcBk/VVx0mn/4+26u0Jk9y
         E9oPu8omML486M7rrPC5Fi8osaWQbS4+CuhExOmrALnpB9CgOvT1M9JrxHC17qiWLnOl
         lJtLtc7A4zTfzbV0WqzqanyzS2CyWzkHN3ltfjyEQs54FPOEDCa4pJ3trCc+b9GEUq4a
         XcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcIEg/sDUKkdURMCkTF1KW5fxOPpkw674yFxDZdydcg=;
        b=TKLBy+FjWPRNcqknZeaC50nzp2VuGpBmomR/UyyjZdZO19I4jgVOczhz/Q2k18fZQX
         iMoP2EyAPui3YjhJgKXouAXJzXRaKnVqpHHjF7bJTOJ4Pgq2xk2M0WxTPa69YA6Ajd3x
         d3GZiQ4mnYpfoqcRwkKZFyh0ECnFI0oQ4dmStYcnqOoS/bKL0cwAhfkqAXt0/d4pluv5
         8yufYZKTq2CwdU9AnxXA/tk9/MFnVBMwC4uARWqiBR/p5RY7WGBJ5ThzkfBHRLD16DX+
         i2ZK0Y7QOPR2kYyIiczFV7aQ1DWieD3xOXtX2kKHXjhroKWJ5xcWhemj3gzL5BcNJF/6
         pbrA==
X-Gm-Message-State: AOAM530g29kD0ydfQSvTysN4umiPZKtazc6Q3PADGbDyQuAe42UlnZtA
        yBCNo9fi4FpnZ5PlK3LUZhHLDw==
X-Google-Smtp-Source: ABdhPJwfuxp+t9/gww6zzmUbohUN1pBfabKCa8Gw5J69qpWws0xk/h6jJgeII7h77ZjFF8nEckCeZQ==
X-Received: by 2002:a37:2795:: with SMTP id n143mr21781313qkn.292.1614730962187;
        Tue, 02 Mar 2021 16:22:42 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:41 -0800 (PST)
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
Subject: [PATCH v12 07/17] arm64: kexec: flush image and lists during kexec load time
Date:   Tue,  2 Mar 2021 19:22:20 -0500
Message-Id: <20210303002230.1083176-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
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

