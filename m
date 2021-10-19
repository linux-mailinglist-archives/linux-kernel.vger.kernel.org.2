Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDC7432D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhJSFUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhJSFUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:20:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C71C061769
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id kk10so13832196pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CdG0RVNBWcqQw3zs+cjsQldLBf7DFcbPNI5BlnMPCmE=;
        b=LLzK9miIgzF5zl3lJAsPflvm0sjSIoEoITPzH4Bn+syLlfqS+c2Hu28apgu4f/NINK
         rrkSRRsWHYbmQ+lqgwow1GTvic0zq8nwK/lSsIQj0flHLI8sl05UerbwS/FJmZdH1Wan
         OfkWC9w3LxsEKh7ObzJ6pUjGUXY7q/Kn8M7u5qP8SmM+Fqg4piYLL8yE5838hUNI1a+m
         DXnouE3G+lhTBgZY2BVa3DiAdw0G6+aGpdD7Ha6Uf8WP2a91JLIXWXvCK17EKhGE3YSA
         XmAyqYkCaJbb2NTZZZFKhI7HMCz7XGIHLkriI2cjoV31v6EIFi7E6WwMNPTyAAhItbkI
         xluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdG0RVNBWcqQw3zs+cjsQldLBf7DFcbPNI5BlnMPCmE=;
        b=lmr+hMadEJA1G2RM78Jc1Qxhat13CyxemDRDPbCgx2s5gV+9UMXm9nqohzitgiVbD9
         npEgoED+QnCgw5n2xPxjzwEnnicVJOHL/bueBO+VgyNmW420Hhsz2FGFZqHh3CFF/aDk
         2BMAtZMMujNsaNbydkBMaYRhDaxm6COd9zLSBrQRwww0rIYNUC5j9D4Nu9fVTwP7VJ5d
         M2EGCbq4hpldyWbzwQVoxG7crnp8a1Zj1UN9pnvtlZuTYLf41MSWK7dntzcR0Gg6QdAF
         fK96NslpDWkCPB0pbJUIFSKQI1bUHG2iOPi6DPig1fKDQPykNvA2GGrlFeaarEvKq604
         08Jw==
X-Gm-Message-State: AOAM532qn33OQuPh7pAu6yCzqw1+9Ijf/AE2inh/nRa+V61WoixG6yV/
        Z5IHpcGJIxYG8V5mnpeEtshQkRRn0hg=
X-Google-Smtp-Source: ABdhPJwAngjvuX18gs+olI5F7Jn5DCc8eCedvyS0yvV5BGjn8if+Stm0wNkPVtkaYlDuRP11pneuqw==
X-Received: by 2002:a17:903:4042:b0:13f:a8ef:7334 with SMTP id n2-20020a170903404200b0013fa8ef7334mr16317806pla.43.1634620667606;
        Mon, 18 Oct 2021 22:17:47 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:47 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 10/10] xtensa: move section symbols to asm/sections.h
Date:   Mon, 18 Oct 2021 22:17:16 -0700
Message-Id: <20211019051716.4173-11-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019051716.4173-1-jcmvbkbc@gmail.com>
References: <20211019051716.4173-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce asm/sections.h and move section declarations to this header
from setup.c. Assign section symbols char array type uniformly and drop
address operator from section symbol references in code.
Sort headers in setup.c while at it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/sections.h |  41 ++++++++++++
 arch/xtensa/kernel/setup.c         | 100 +++++++++--------------------
 2 files changed, 70 insertions(+), 71 deletions(-)
 create mode 100644 arch/xtensa/include/asm/sections.h

diff --git a/arch/xtensa/include/asm/sections.h b/arch/xtensa/include/asm/sections.h
new file mode 100644
index 000000000000..a8c42d08e281
--- /dev/null
+++ b/arch/xtensa/include/asm/sections.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _XTENSA_SECTIONS_H
+#define _XTENSA_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+#ifdef CONFIG_VECTORS_ADDR
+extern char _WindowVectors_text_start[];
+extern char _WindowVectors_text_end[];
+extern char _DebugInterruptVector_text_start[];
+extern char _DebugInterruptVector_text_end[];
+extern char _KernelExceptionVector_text_start[];
+extern char _KernelExceptionVector_text_end[];
+extern char _UserExceptionVector_text_start[];
+extern char _UserExceptionVector_text_end[];
+extern char _DoubleExceptionVector_text_start[];
+extern char _DoubleExceptionVector_text_end[];
+extern char _exception_text_start[];
+extern char _exception_text_end[];
+extern char _Level2InterruptVector_text_start[];
+extern char _Level2InterruptVector_text_end[];
+extern char _Level3InterruptVector_text_start[];
+extern char _Level3InterruptVector_text_end[];
+extern char _Level4InterruptVector_text_start[];
+extern char _Level4InterruptVector_text_end[];
+extern char _Level5InterruptVector_text_start[];
+extern char _Level5InterruptVector_text_end[];
+extern char _Level6InterruptVector_text_start[];
+extern char _Level6InterruptVector_text_end[];
+#endif
+#ifdef CONFIG_SMP
+extern char _SecondaryResetVector_text_start[];
+extern char _SecondaryResetVector_text_end[];
+#endif
+#ifdef CONFIG_XIP_KERNEL
+extern char _xip_start[];
+extern char _xip_end[];
+#endif
+
+#endif
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 3638fb98a1ab..c9fc39883ea9 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -37,14 +37,15 @@
 #include <asm/bootparam.h>
 #include <asm/kasan.h>
 #include <asm/mmu_context.h>
-#include <asm/processor.h>
-#include <asm/timex.h>
-#include <asm/platform.h>
 #include <asm/page.h>
-#include <asm/setup.h>
 #include <asm/param.h>
+#include <asm/platform.h>
+#include <asm/processor.h>
+#include <asm/sections.h>
+#include <asm/setup.h>
 #include <asm/smp.h>
 #include <asm/sysmem.h>
+#include <asm/timex.h>
 
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
 struct screen_info screen_info = {
@@ -271,49 +272,6 @@ void __init init_arch(bp_tag_t *bp_start)
  * Initialize system. Setup memory and reserve regions.
  */
 
-extern char _end[];
-extern char _stext[];
-extern char _WindowVectors_text_start;
-extern char _WindowVectors_text_end;
-extern char _DebugInterruptVector_text_start;
-extern char _DebugInterruptVector_text_end;
-extern char _KernelExceptionVector_text_start;
-extern char _KernelExceptionVector_text_end;
-extern char _UserExceptionVector_text_start;
-extern char _UserExceptionVector_text_end;
-extern char _DoubleExceptionVector_text_start;
-extern char _DoubleExceptionVector_text_end;
-extern char _exception_text_start;
-extern char _exception_text_end;
-#if XCHAL_EXCM_LEVEL >= 2
-extern char _Level2InterruptVector_text_start;
-extern char _Level2InterruptVector_text_end;
-#endif
-#if XCHAL_EXCM_LEVEL >= 3
-extern char _Level3InterruptVector_text_start;
-extern char _Level3InterruptVector_text_end;
-#endif
-#if XCHAL_EXCM_LEVEL >= 4
-extern char _Level4InterruptVector_text_start;
-extern char _Level4InterruptVector_text_end;
-#endif
-#if XCHAL_EXCM_LEVEL >= 5
-extern char _Level5InterruptVector_text_start;
-extern char _Level5InterruptVector_text_end;
-#endif
-#if XCHAL_EXCM_LEVEL >= 6
-extern char _Level6InterruptVector_text_start;
-extern char _Level6InterruptVector_text_end;
-#endif
-#ifdef CONFIG_SMP
-extern char _SecondaryResetVector_text_start;
-extern char _SecondaryResetVector_text_end;
-#endif
-#ifdef CONFIG_XIP_KERNEL
-extern char _xip_start[];
-extern char _xip_end[];
-#endif
-
 static inline int __init_memblock mem_reserve(unsigned long start,
 					      unsigned long end)
 {
@@ -350,50 +308,50 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_VECTORS_ADDR
 #ifdef SUPPORT_WINDOWED
-	mem_reserve(__pa(&_WindowVectors_text_start),
-		    __pa(&_WindowVectors_text_end));
+	mem_reserve(__pa(_WindowVectors_text_start),
+		    __pa(_WindowVectors_text_end));
 #endif
 
-	mem_reserve(__pa(&_DebugInterruptVector_text_start),
-		    __pa(&_DebugInterruptVector_text_end));
+	mem_reserve(__pa(_DebugInterruptVector_text_start),
+		    __pa(_DebugInterruptVector_text_end));
 
-	mem_reserve(__pa(&_KernelExceptionVector_text_start),
-		    __pa(&_KernelExceptionVector_text_end));
+	mem_reserve(__pa(_KernelExceptionVector_text_start),
+		    __pa(_KernelExceptionVector_text_end));
 
-	mem_reserve(__pa(&_UserExceptionVector_text_start),
-		    __pa(&_UserExceptionVector_text_end));
+	mem_reserve(__pa(_UserExceptionVector_text_start),
+		    __pa(_UserExceptionVector_text_end));
 
-	mem_reserve(__pa(&_DoubleExceptionVector_text_start),
-		    __pa(&_DoubleExceptionVector_text_end));
+	mem_reserve(__pa(_DoubleExceptionVector_text_start),
+		    __pa(_DoubleExceptionVector_text_end));
 
-	mem_reserve(__pa(&_exception_text_start),
-		    __pa(&_exception_text_end));
+	mem_reserve(__pa(_exception_text_start),
+		    __pa(_exception_text_end));
 #if XCHAL_EXCM_LEVEL >= 2
-	mem_reserve(__pa(&_Level2InterruptVector_text_start),
-		    __pa(&_Level2InterruptVector_text_end));
+	mem_reserve(__pa(_Level2InterruptVector_text_start),
+		    __pa(_Level2InterruptVector_text_end));
 #endif
 #if XCHAL_EXCM_LEVEL >= 3
-	mem_reserve(__pa(&_Level3InterruptVector_text_start),
-		    __pa(&_Level3InterruptVector_text_end));
+	mem_reserve(__pa(_Level3InterruptVector_text_start),
+		    __pa(_Level3InterruptVector_text_end));
 #endif
 #if XCHAL_EXCM_LEVEL >= 4
-	mem_reserve(__pa(&_Level4InterruptVector_text_start),
-		    __pa(&_Level4InterruptVector_text_end));
+	mem_reserve(__pa(_Level4InterruptVector_text_start),
+		    __pa(_Level4InterruptVector_text_end));
 #endif
 #if XCHAL_EXCM_LEVEL >= 5
-	mem_reserve(__pa(&_Level5InterruptVector_text_start),
-		    __pa(&_Level5InterruptVector_text_end));
+	mem_reserve(__pa(_Level5InterruptVector_text_start),
+		    __pa(_Level5InterruptVector_text_end));
 #endif
 #if XCHAL_EXCM_LEVEL >= 6
-	mem_reserve(__pa(&_Level6InterruptVector_text_start),
-		    __pa(&_Level6InterruptVector_text_end));
+	mem_reserve(__pa(_Level6InterruptVector_text_start),
+		    __pa(_Level6InterruptVector_text_end));
 #endif
 
 #endif /* CONFIG_VECTORS_ADDR */
 
 #ifdef CONFIG_SMP
-	mem_reserve(__pa(&_SecondaryResetVector_text_start),
-		    __pa(&_SecondaryResetVector_text_end));
+	mem_reserve(__pa(_SecondaryResetVector_text_start),
+		    __pa(_SecondaryResetVector_text_end));
 #endif
 	parse_early_param();
 	bootmem_init();
-- 
2.20.1

