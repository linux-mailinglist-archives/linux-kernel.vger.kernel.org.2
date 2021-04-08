Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B0357B13
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhDHEGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhDHEF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:05:59 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3F1C061763
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:49 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y12so446273qtx.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FcIEg/sDUKkdURMCkTF1KW5fxOPpkw674yFxDZdydcg=;
        b=K1NsbXiptJWAFjDZB69MTcxq+sVd357Lm9DKIwBQhxbGV3HftSKBeUqa23Wmi5KKNU
         zvjcqW4fvbuFxiDUEdiWh3Mcf9hsDD6xZvknyHE0ctG5bfVF8q4qEwPS0v1jcEKtMcbA
         8nKTdc1FLRCDhKH+sT2n8fMhr1u+4HPurVK8/xjKe/Z9Cy3im6HxbQ+zh7vl4AwQ97/T
         ZODphpRxpUyYHVXtt6c71a1yPBcTrl3qHz4ut24V8AGbtwoYkqrh2tIBNNyfurAIblR4
         QypVLYj0CXuJ3SBllkLS4gaJWPnDY2g4n0RpZpXaLWcaMPu4cnP4N2D+arBerwRT+OoS
         Yx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcIEg/sDUKkdURMCkTF1KW5fxOPpkw674yFxDZdydcg=;
        b=Ulhm+do4yOQYpRpBV6N2xD81ZWFMGGDSnVjjPKOvu0d+K/f7/chtXsRRDUgRvLCNed
         jCaldpXflvZ3Tb57mIzu5w+UDWCEhulqIWFoVEQyrz9RPc69PQclF12ocByMfhkx4V6n
         7vcBwRqkERooIb7tsLlJZkvqYDH6+g+D2kbgY3XUbhkEQF9iaySQLTkMCuEOpvJgfkR7
         VObITyUHTcqXLv4Yr8ooqEBRfGJ2AA9s2lSc+71qxufeZIMpuN3yqbc1bHeFdY97qfnW
         bvwh47fQuB9qkK9bXXzeHJrdDShqD+Z1T//ZCq2z6NKlM6IuhL9ExYnw/jiOW4NsnoXo
         nWdw==
X-Gm-Message-State: AOAM533XvCMsqVHXa/bRn6fgiu9dvi/ZOQ7fL7Pd7rOgPQTvVZnJWwKx
        mn4KXtsd2qu17HxQ9BhKiKIQ8Q==
X-Google-Smtp-Source: ABdhPJz+49F5sFnvxO3bcbTDIuYVduCfSWrd4A61z5Tt8rvcCW5QOx1alJlSaDZm0kDJxf714A6VuA==
X-Received: by 2002:ac8:5313:: with SMTP id t19mr5657090qtn.148.1617854748347;
        Wed, 07 Apr 2021 21:05:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:47 -0700 (PDT)
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
Subject: [PATCH v13 07/18] arm64: kexec: flush image and lists during kexec load time
Date:   Thu,  8 Apr 2021 00:05:26 -0400
Message-Id: <20210408040537.2703241-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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

