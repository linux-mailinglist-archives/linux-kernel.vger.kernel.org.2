Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4399936E44B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 06:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhD2EoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 00:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2EoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:44:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D76AC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:43:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y1so18437762plg.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=dYuU5G7Tok7W7dteeCw6ZMzwcEHLOIU+TkutgZ/lpVQ=;
        b=oZYFFE+Bkk/IeFoxxL5IEGMza6qcQMtcphBKKgOPvFRBJ/A/UxQOUgWqXISyL47oq0
         QJxhycOwaHu3xPeTTTnxbH5il2GAr+OGBa3hZDXqRTZJKuyvMZCP9h64a+zTQVM0YuLj
         f7kuAgnv3Z9xrKYYPdHKxM3PVXKG0brumHKSaL1EiSRfjJFZ31hqb97KLubg17FnRb+j
         JW5sQBv/5TdAEf17pYJ2LHxb9IaR9B3PfncY4vjzjFa7tjRhoHUYsz3uiTHIA5NeZFT+
         ijyhmjmPzJyl320tohcGYOvmLZ2n7FHXUpHQdMH7GuyeLU9AmP3bKlOtgWJeYNAABdwC
         2ubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=dYuU5G7Tok7W7dteeCw6ZMzwcEHLOIU+TkutgZ/lpVQ=;
        b=a6d8i+iinGM+p99T5feeczTuwysLb+bK89ItjYBPpqf/anYqzRGhmbgatgzjqCYpnT
         0H0GVHPIH2Wrn55IR4pqcM+DXBWqYDYda7Lr3GrmGQCf51UMmbKW6oKZwXyPrqJla0Cz
         3t3I8ua9BYv88xIjKpaQ45G4Y1AUnFrVWQ20A0HLu26roTPlyEkdqH/2bIne73O1Ge3G
         taD6gK6TAJG1O+sUywVnoo0v38F76sq9lnPXzq2M3KQ2/wcQ9iUUQ1WQiJuPC3Ldtbc1
         rre9DiK2D3o23nyQog/uaJ65Q+5kpKuMu0ajobFLBSNkrB7KV8i0LG2qtz6oF6/jV2gw
         01EA==
X-Gm-Message-State: AOAM531SiiAXrjbblN3vqLSDpBChYgXjZTywObmJ7a9S+zVfrm7aqLaH
        DvfBMjnZIvXVt2/3hHDuPLyVlA==
X-Google-Smtp-Source: ABdhPJzbBoKq0CWXBqDbKoCDFpbY3JZr/Wxs75/h7bIUGoyXzgdWJ2Tu4Dj6t0ZUrWhVEID5QI3Sxg==
X-Received: by 2002:a17:90b:78d:: with SMTP id l13mr7789191pjz.182.1619671398668;
        Wed, 28 Apr 2021 21:43:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id gm17sm898788pjb.11.2021.04.28.21.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 21:43:18 -0700 (PDT)
Subject: [PATCH v2] RISC-V: Always define XIP_FIXUP
Date:   Wed, 28 Apr 2021 14:45:12 -0700
Message-Id: <20210428214512.551153-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>, akpm@linux-foundation.org,
        rppt@kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        wangkefeng.wang@huawei.com, vitaly.wool@konsulko.com,
        alex@ghiti.fr, greentime.hu@sifive.com, 0x7f454c46@gmail.com,
        chenhuang5@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Guenter Roeck <linux@roeck-us.net>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

XIP depends on MMU, but XIP_FIXUP is used throughout the kernel in
order to avoid excessive ifdefs.  This just makes sure to always define
XIP_FIXUP, which will fix MMU=n builds.  XIP_OFFSET is used by assembly
but XIP_FIXUP is C-only, so they're split.

Fixes: 44c922572952 ("RISC-V: enable XIP")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
Changes since v1:

* Clean up the commit text.
* Define XIP_OFFSET for assembly.
---
 arch/riscv/include/asm/pgtable.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2f1384e14e31..9469f464e71a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -73,18 +73,10 @@
 #endif
 #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
 
+#endif
+
 #ifdef CONFIG_XIP_KERNEL
 #define XIP_OFFSET		SZ_8M
-#define XIP_FIXUP(addr) ({							\
-	uintptr_t __a = (uintptr_t)(addr);					\
-	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
-		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
-		__a;								\
-	})
-#else
-#define XIP_FIXUP(addr)		(addr)
-#endif /* CONFIG_XIP_KERNEL */
-
 #endif
 
 #ifndef __ASSEMBLY__
@@ -101,6 +93,17 @@
 #include <asm/pgtable-32.h>
 #endif /* CONFIG_64BIT */
 
+#ifdef CONFIG_XIP_KERNEL
+#define XIP_FIXUP(addr) ({							\
+	uintptr_t __a = (uintptr_t)(addr);					\
+	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
+		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
+		__a;								\
+	})
+#else
+#define XIP_FIXUP(addr)		(addr)
+#endif /* CONFIG_XIP_KERNEL */
+
 #ifdef CONFIG_MMU
 /* Number of entries in the page global directory */
 #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
-- 
2.31.1.498.g6c1eba8ee3d-goog

