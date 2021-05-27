Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9093931C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhE0PH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbhE0PHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:13 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896FEC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 82so920174qki.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FcIEg/sDUKkdURMCkTF1KW5fxOPpkw674yFxDZdydcg=;
        b=FoXurcNpRVh8PW9Lk8j7yxcfb9WhsD1odEsRlBENU4YBfTWy5FE7Pci3MirsOpLizl
         OAwkUiXNxiixolnp818py2J+B/N0h14eTcWXM9L2T3NeUf5C9R5OGcYfwKJsn7sjcW0y
         RlZ2lY5o9vDQkxgcwfg0mNbVjK/w5ueBm5N8jUlDq5eFUT44aspwJXmgwff2E9EiOGGc
         52TL/Kuuj7KVAqFRjlqujmS49xER8gmVrA135D9td7VASDqpb6Ou3adZ8eXy/q+KMWXP
         ACHn61DU7z5lzrxfnWLT9k5wcrTSFC0FGjeIZyFeGvHPa0mwpY/z2P37hkae3AzL+Xfg
         PhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcIEg/sDUKkdURMCkTF1KW5fxOPpkw674yFxDZdydcg=;
        b=CAviARWLMvr8XCmaxUQknXW3G4OuhNInpNQadCgGJWMBa5lKJ0vYNCSA9ZZ577qjg6
         XJNx/JXqTZZRW1J7G4CrSlqwZOJvZWt8W8IW51BDD6xTlEGc7ihUPJTeubevm0A+66ck
         29llWgWd5wqIZERz1G4XmmmUGR251e7V2Fs4Oq5tmwTc27O53l2ldJdN+YoNLHI7QeCN
         ljzfd7ZWldQ0GY0EFjfyASDwaDBZmxkSy9USPOckWlOlrlOml29NE9eJvtb4x0fRdopt
         X55Sp6xwJKs/ItbbOCyOMm9GdElLmFNy6Y0Xn5oX8b+f03wKg+LigHevyyWYXyFt02tL
         wa7Q==
X-Gm-Message-State: AOAM532Wp/1+6v/YnxeQtx4WrXSmXh4OYcO3hZx03OrhZlHgFjHN8I8f
        6GFWDdh0Z9VKJGGM03YM2SMisQ==
X-Google-Smtp-Source: ABdhPJzfd4jTVGoM6zB9+XxkahnEtHa/XkFTFTWTzzz5x2x/RbHjlysPqBPq0fd50bFxJPKMZb48wA==
X-Received: by 2002:a37:30c:: with SMTP id 12mr4018868qkd.355.1622127939672;
        Thu, 27 May 2021 08:05:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:39 -0700 (PDT)
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
Subject: [PATCH 07/18] arm64: kexec: flush image and lists during kexec load time
Date:   Thu, 27 May 2021 11:05:15 -0400
Message-Id: <20210527150526.271941-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
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

