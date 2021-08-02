Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05473DE1F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhHBVyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhHBVy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:54:27 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EA1C0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:54:17 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id b1so12769025qtx.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=j+M5hF4GoTM52s3DZq4Ce8jXkOdwrhiLtHbwgSj+FD0=;
        b=l6aqL1CM2TQZNGjxlG/OMB4a6O9NQjV7sXgli2BxOuiZqOg1+R4L39Hu+XxA1MP2s5
         t4dP5Us1cylcgLhIaClJU45qlE2AWSN05gLhWbNEddIvUnvOppiFWBMN2dBLty8Bu7WE
         6gaf3VroJKSsrw0OpzaZNzXBElExwfW5ATW9eqbqeBEBmhBNUHbqNvkji2FfJ/IGEybJ
         ZpKuE68zFf/xMo0Q4srgWww79rMfb7cNXt6JS4zZ6O5a2P7HnD1tEpc/dGa5a406/pco
         wPgUP5aLSqk1c0Bu/yhNnpFj30p70V3WrBAZsa/YupGYPMXcilEBYoBGGqiU7xVgLZb1
         yBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+M5hF4GoTM52s3DZq4Ce8jXkOdwrhiLtHbwgSj+FD0=;
        b=I8BW+qwyTsSHqtTbCjG/KEA5JG+kbgAR+651gWfZIxtrtn3WpAPeWFNuDEhXKPnwey
         L2srIrq7H8bXhKEjqfabi8yxn50HUYEDU86VOLkqa+Xd+2dWORDowcoPNsU+BMDtNkIx
         t1kPjl49bPBs1UcmMUImHgqyp0qTFsUxqaS00qizzhaxv8mN/cm4lJbGLq0fA6F1Wzfu
         uAB1+2hjLdMBgY5WMIIkDpYn3TPgMLLniAQakeKVPaCJxhCAzkqtfHnNpUwFei4Z+AHW
         KkUBN84kjCjCfKPuE9om49vWxxaoOFsjh+HF0JfRW5RhvDYSyUZ4qLVXhKBaM29SzRZx
         YRzA==
X-Gm-Message-State: AOAM5326qj1rIdl1t27z+YR1d4WyVio2/f8rR238au6wZX3YX6WeJPJg
        1LjNSsX1kTWa7ZKsDI8uWKxkvQ==
X-Google-Smtp-Source: ABdhPJzftvfeQfBpD80+56bQsic+tvcE4+ki6fuiemQ88Y64RUc79X5wGWVVM3Jr7aFMFqrTIyjfxw==
X-Received: by 2002:ac8:57c4:: with SMTP id w4mr15810018qta.39.1627941256639;
        Mon, 02 Aug 2021 14:54:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v11sm5479216qtc.0.2021.08.02.14.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:54:16 -0700 (PDT)
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
Subject: [PATCH v16 04/15] arm64: kexec: flush image and lists during kexec load time
Date:   Mon,  2 Aug 2021 17:53:57 -0400
Message-Id: <20210802215408.804942-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
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

