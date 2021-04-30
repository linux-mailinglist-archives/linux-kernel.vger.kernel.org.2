Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B337020F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhD3U3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbhD3U3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:29:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B0C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:28:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n84so11300023wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iw+V37JgA+F4SsYKf28zN0ap1ybGadX/nBD4+2JYyZo=;
        b=R8G/zQ0WwQGRAzVaUBGE3Mp1kmXtje3K1nEAaxUYEsSoqdsRBfbOtctF4/ymUKFbpz
         fx0NfcGbhtDCgEmlJXaCxA13cAoR+5wMzuKGP90Al38HvbRmZJPGG018yP+/+WEOD5ZY
         43q4G6K4zSKOu1doN010oIpChV49/HpCTMzq6qVmpGX/Tc21yt5Zj2sN/18demT3gQwy
         kdfzt08EVxDpsJt3m/EEzBQTrbAYXjqMdRhR8YEIKKwlk3qGmtGUjeXKk7JOjKO7ul5E
         1D1atm4yHnKUGsFitkXDBdGy3Q3DuP/3BUCC5i1PxGiPSrfmUJa9njamrnb38afrd3iq
         kmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iw+V37JgA+F4SsYKf28zN0ap1ybGadX/nBD4+2JYyZo=;
        b=OCcFsx2zcv0GtxTUmUUaDXSswtDtLDmvuxlJ2TS87bUf5yV9UwKE8BOrjJyNDjOkz6
         Iu1A6hrhxTZZl2aGSZ8nF0vbQOMpC9aarwrulYqAbRvdFClUsqsdk+2Eh7ox03by24Ie
         sf598bSCWRVznVAWPReyp+7ygLMe7GOBIe+613mzuT9k7ibwHiae28KcTZmlfKnoFOkD
         pWBg8ShtMhGr0Di1c6lcqDMU3NzcXgcGGYQofrU42lHUIYq36DjO7jFwjUdB8r/2E/VE
         ftXy6/OrGfQShhsd2jMBiO8peO3LuErY9rUjgmrOW3D/ENqSaMXxeeY9N5j4LWrN+edi
         tWWQ==
X-Gm-Message-State: AOAM533OHvR+wTMrVmdnvjrUjg+dMWfhC4riQ1bQHpjh5EMVD5Z9CLcZ
        CBFmYgfXH/h6xKY9UMgLurk=
X-Google-Smtp-Source: ABdhPJx2plv+lZ2c8L84PAXcEl2RtY4d/P83CJvfHH2dNR/L4jv88e5ZGbkR5TXd+I0WIYUDYwHKiw==
X-Received: by 2002:a1c:228a:: with SMTP id i132mr7932536wmi.10.1619814521905;
        Fri, 30 Apr 2021 13:28:41 -0700 (PDT)
Received: from amanieu-desktop.home ([2a00:23c6:f081:f801:93ef:94e:9f8:1f0])
        by smtp.gmail.com with ESMTPSA id p7sm3359519wrt.24.2021.04.30.13.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:28:41 -0700 (PDT)
From:   Amanieu d'Antras <amanieu@gmail.com>
Cc:     Amanieu d'Antras <amanieu@gmail.com>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] mm: Add arch_get_mmap_base_topdown macro
Date:   Fri, 30 Apr 2021 21:28:03 +0100
Message-Id: <20210430202810.44092-2-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430202810.44092-1-amanieu@gmail.com>
References: <20210430202810.44092-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows architectures to customize the mmap base to use depending on
the direction of allocation.

The base argument is also removed from arch_get_mmap_base[_topdown] in
prepartion for future changes.

arm64 is currently the only user of the arch_get_mmap_* macros and is
adjusted accordingly. Specifically it only needs to limit the upper
bound of VM allocations and therefore only needs to customize
arch_get_mmap_base_topdown but not arch_get_mmap_base.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 arch/arm64/include/asm/processor.h |  7 ++++---
 mm/mmap.c                          | 14 +++++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index efc10e9041a0..f47528aae321 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -88,9 +88,10 @@
 #define arch_get_mmap_end(addr) ((addr > DEFAULT_MAP_WINDOW) ? TASK_SIZE :\
 				DEFAULT_MAP_WINDOW)
 
-#define arch_get_mmap_base(addr, base) ((addr > DEFAULT_MAP_WINDOW) ? \
-					base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
-					base)
+#define arch_get_mmap_base_topdown(addr) \
+	((addr > DEFAULT_MAP_WINDOW) ? \
+	current->mm->mmap_base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
+	current->mm->mmap_base)
 #endif /* CONFIG_ARM64_FORCE_52BIT */
 
 extern phys_addr_t arm64_dma_phys_limit;
diff --git a/mm/mmap.c b/mm/mmap.c
index 3f287599a7a3..4937b34085cb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2139,11 +2139,15 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 }
 
 #ifndef arch_get_mmap_end
-#define arch_get_mmap_end(addr)	(TASK_SIZE)
+#define arch_get_mmap_end(addr)			(TASK_SIZE)
 #endif
 
 #ifndef arch_get_mmap_base
-#define arch_get_mmap_base(addr, base) (base)
+#define arch_get_mmap_base(addr)		(current->mm->mmap_base)
+#endif
+
+#ifndef arch_get_mmap_base_topdown
+#define arch_get_mmap_base_topdown(addr)	(current->mm->mmap_base)
 #endif
 
 /* Get an address range which is currently unmapped.
@@ -2184,7 +2188,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 
 	info.flags = 0;
 	info.length = len;
-	info.low_limit = mm->mmap_base;
+	info.low_limit = arch_get_mmap_base(addr);
 	info.high_limit = mmap_end;
 	info.align_mask = 0;
 	info.align_offset = 0;
@@ -2227,7 +2231,7 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
-	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
+	info.high_limit = arch_get_mmap_base_topdown(addr);
 	info.align_mask = 0;
 	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
@@ -2241,7 +2245,7 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	if (offset_in_page(addr)) {
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
+		info.low_limit = arch_get_mmap_base(addr);
 		info.high_limit = mmap_end;
 		addr = vm_unmapped_area(&info);
 	}
-- 
2.31.1

