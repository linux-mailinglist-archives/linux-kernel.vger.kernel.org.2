Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2AA3874BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbhERJJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347846AbhERJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:08:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BCAC061343
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h4so9300994wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iw+V37JgA+F4SsYKf28zN0ap1ybGadX/nBD4+2JYyZo=;
        b=iTek3TJr/YFjmB4UfL1edPWpPsdj7IE8wcUP7qFv4mY9W3+0rrXVj2i4BAbIXp9MVz
         no224x94Qw8CWQxPyZxYsXrig3Ka0SnZJqSGshyuj/4FgA1tLLF49wvcdMZkZInVfKim
         kPApG10/E6NQjNu7KZulPTP6HZOhR3Nq+NfnJ2Epz9pF1sjPRchcUvbHOJLTrHN6XNkX
         fdbZVSSI/voKrJh+zBoYx/bMePq7Nwqvu/kkdg66zafR0egMiyT35X20TwM6lTMwcopz
         v2Lztg0+gawG427Kq/kUAtTBdOhLNGjOn3pabRp2oL/yiqJazMn7icnxAed9oE4cI5oB
         VCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iw+V37JgA+F4SsYKf28zN0ap1ybGadX/nBD4+2JYyZo=;
        b=TZGTpbRMuhUBtFfC7Kf8PZJX8EuzpQv3eqgj62egvgQepvPdybS+DUwi5jivA07MiG
         NOZAz4ELx0DjN2s/2DE8jaLI50AGR0KIhPnH/n9YNReK+9EzAg/VOYdq2BqE8ArnCegR
         Y8tcV+sG+pdWFCVnebTfyUwTWBO5r9BqNTmDJ1C/NUL5pvUhnn+bFlhvH38IyfBMQhk1
         nAvuoJcGMGdjAseL0j0eQRzGYkOONbgNK0tMccBb/G9cNuPtbj7gRzTSoKcWMNaljS7J
         8pY1Ngw+OjcGZWB9ikmmN88INKCY1/Sr8o4vo8ro+hf05euJi9Zef07dSph8plwVHVn4
         iftg==
X-Gm-Message-State: AOAM531kks2t4BngLzMAvX0bgBYP81B9AFeeRN5gc2UmSUviartnxnIM
        kEarcg0Wc7bksGFc7oK2Drc=
X-Google-Smtp-Source: ABdhPJwqlJzu9U/zTbd6UMrv4emOFKb20RwGvFolAezPWYNdsqqHpRvkUnjCsF+jPcrBgjwttyw0VQ==
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr5284414wrq.177.1621328827965;
        Tue, 18 May 2021 02:07:07 -0700 (PDT)
Received: from amanieu-laptop.home ([2a00:23c6:f081:f801:91cf:b949:c46c:f5a9])
        by smtp.gmail.com with ESMTPSA id z17sm7520306wrt.81.2021.05.18.02.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:07:07 -0700 (PDT)
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
Subject: [RESEND PATCH v4 1/8] mm: Add arch_get_mmap_base_topdown macro
Date:   Tue, 18 May 2021 10:06:51 +0100
Message-Id: <20210518090658.9519-2-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518090658.9519-1-amanieu@gmail.com>
References: <20210518090658.9519-1-amanieu@gmail.com>
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

