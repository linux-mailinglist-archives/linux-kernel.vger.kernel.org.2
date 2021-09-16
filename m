Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E1040EDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbhIPXPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241480AbhIPXOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:14:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0292C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b64so11735611qkg.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Gd/bGj4Nwzpg1oqGDK3dKyYdSLy7Idt++VqAt+4ZWi4=;
        b=PdS3WIztg0/FRRtRRTtPPxtFIldbe++n6HCVMM6V0yGOpBq5XsN2nTiu23qMmZdl8q
         UA5t8YTZtjM0INsMm1j5XpUeJQCvNSXi4Rq+hRSx8IZ2tKHgAeE6k1wOiFqeKPRpYTGj
         zRK1b3KP5CjtP6keZb3NU4vaQeXPW1AEYLAEn2/dz1SITPu6y8Td5DSwFsE+M2382rk0
         cfy3A1wF4r2QdsnvixiMLxjZsAm3BnZjF692O3QVY4jYrCvOzUBT/aeQWJUMtPNwhut0
         mSdS9tjivQ9eqe5Ke36xs36CO+CdTVkXk7rAL7kWFu+iMdYsA/i/iS9kUia9rdNF6KX3
         BPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gd/bGj4Nwzpg1oqGDK3dKyYdSLy7Idt++VqAt+4ZWi4=;
        b=k7p2zrM0QlEuJwAWv0m1QrWLmCWsTghSvFmPkKo9VuhkkQFCnOQ4TfWX59AZN5RV+2
         5jIaXWOP1MbMZyfHEtjKlBRGLp8UlvzCukxJt6spzVtRI2ngd7IjgKJ47IcuzyyTqGdh
         IZcDq3wGllDi+5caaq19OoV4UOMfV3Wiw+Ztwij+/x+HgHOnJUhBZa3H7HKPsyomtLjD
         2VulQKz/H5OCjdm2E9nV7XvgTj+zJ8PgZiGvqksCME03mV3ikbEzLUkAevDfUnBdit5V
         0J6COgkW0jkMMQSfILiXxP3FfT1CyKowwF7O70Kg0E9dNPF9l2jOk5qwihnmzHDRxl/h
         pyFA==
X-Gm-Message-State: AOAM532rZUfBqRfdjrmDIDkXET4NFosePZZFovRV0yfermsgYlDmWc1Q
        XgmLdEYT8hUOoyAand6Yp21oZg==
X-Google-Smtp-Source: ABdhPJxpsmcX5Y/ALpzZd3SrKNGuslXcDYHnRWX9AFYJaIjAKYK0WUYvvI7zcdvzBL3J+s6eb2VL7w==
X-Received: by 2002:a05:620a:1998:: with SMTP id bm24mr7898451qkb.444.1631834013914;
        Thu, 16 Sep 2021 16:13:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id az6sm3312891qkb.70.2021.09.16.16.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:13:33 -0700 (PDT)
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
Subject: [PATCH v17 04/15] arm64: kexec: flush image and lists during kexec load time
Date:   Thu, 16 Sep 2021 19:13:14 -0400
Message-Id: <20210916231325.125533-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
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
2.25.1

