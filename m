Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3498C418ABD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhIZTXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 15:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhIZTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 15:23:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DFAC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 12:21:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id bb10so10274681plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8VoC22VdCllOXZFZ1LpEuBes/M4AcpmZRe4ChismgTw=;
        b=FB+sD0lH8m3BwjrgcAS4fuDSbMgqQA8XKScYogSP2U9uTMifHqFqUc4+8Z59GBAZSt
         FOIUXHF5HQaaXgjkAjl7oUmw1jA2RXW0Leb2Vhe+Yyw6Ipy4J+zx5VhfHB8v6XpLYZm+
         43L1CIF1yb4YeSfklNS2gBUHAj8arIlU+ZVhywtNDgTIGlGN/GBA7WfDZ7U/UL0wwz4m
         KW7pLiut9pLXNBcF4YTXSQPa7ABQRBtcuDM+6lUlPYGu6WuLGctFnwED8ai1JYaBJtT4
         k9bfMvs15P0MXgxywYwBCAO0VNMCB+U5JqpAwuqRsOS0kw7VN+TPBZZKjpTlu2K+MOD6
         LEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8VoC22VdCllOXZFZ1LpEuBes/M4AcpmZRe4ChismgTw=;
        b=7UgQFoZdDP+Ze2K/OZYM5t0y4lBk1Eg3dLMCcXNJJY8aw6oDTtj89qa+nRGK6emUdd
         KgzpLk/gFlMMABjLwRs4BXA7ynJZswuu+2iCyQgckB33tiWGlCIxtieT/MxI6yHhVqad
         4AmTY6M1+Mxn1Q3+ovaf0e/1doDTPj/kW0ZFSmSE62HytYOSsKbGrV6eIWYaNLXEdMqU
         T7hTSvZNJz+20WmggIcBo3i/2tMqpqLI4tqZcWzj1U1bow5Gds9c8NdyPy/Tbi4RnDwA
         tW7gRj3aEU/66uGWnUNw9D3fJX+8VUOgS5d0SjVDccklzwJC6vUOK0mhds/LLJ/WRaPF
         B8Vg==
X-Gm-Message-State: AOAM531m3QWAGmbjraKDM8Bn4lL5wG1PtZz9Nz4wEX3CgSExm+a3EfqR
        wKWx7tjkjLMlleuhw/aBiag=
X-Google-Smtp-Source: ABdhPJwnpi0+fpKK+6zgN8PmF3urOWPgkwWq+//M4cZNC4qQJXNUuOudHq5kOWgAJaRlLfPgGuOQEw==
X-Received: by 2002:a17:90a:1a58:: with SMTP id 24mr15472973pjl.45.1632684097413;
        Sun, 26 Sep 2021 12:21:37 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:794c:d573:9874:654d])
        by smtp.gmail.com with ESMTPSA id e14sm15862802pga.23.2021.09.26.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:21:36 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: use CONFIG_USE_OF instead of CONFIG_OF
Date:   Sun, 26 Sep 2021 12:21:06 -0700
Message-Id: <20210926192106.1943-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

CONFIG_OF can be set by a randconfig or by a user -- without setting the
early flattree option (OF_EARLY_FLATTREE).  This causes build errors.
However, if randconfig or a user sets USE_OF in the Xtensa config,
the right kconfig symbols are set to fix the build.

Fixes these build errors:

../arch/xtensa/kernel/setup.c:67:19: error: ‘__dtb_start’ undeclared here (not in a function); did you mean ‘dtb_start’?
   67 | void *dtb_start = __dtb_start;
      |                   ^~~~~~~~~~~
../arch/xtensa/kernel/setup.c: In function 'xtensa_dt_io_area':
../arch/xtensa/kernel/setup.c:201:14: error: implicit declaration of function 'of_flat_dt_is_compatible'; did you mean 'of_machine_is_compatible'? [-Werror=implicit-function-declaration]
  201 |         if (!of_flat_dt_is_compatible(node, "simple-bus"))
../arch/xtensa/kernel/setup.c:204:18: error: implicit declaration of function 'of_get_flat_dt_prop' [-Werror=implicit-function-declaration]
  204 |         ranges = of_get_flat_dt_prop(node, "ranges", &len);
../arch/xtensa/kernel/setup.c:204:16: error: assignment to 'const __be32 *' {aka 'const unsigned int *'} from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  204 |         ranges = of_get_flat_dt_prop(node, "ranges", &len);
      |                ^
../arch/xtensa/kernel/setup.c: In function 'early_init_devtree':
../arch/xtensa/kernel/setup.c:228:9: error: implicit declaration of function 'early_init_dt_scan'; did you mean 'early_init_devtree'? [-Werror=implicit-function-declaration]
  228 |         early_init_dt_scan(params);
../arch/xtensa/kernel/setup.c:229:9: error: implicit declaration of function 'of_scan_flat_dt' [-Werror=implicit-function-declaration]
  229 |         of_scan_flat_dt(xtensa_dt_io_area, NULL);

xtensa-elf-ld: arch/xtensa/mm/mmu.o:(.text+0x0): undefined reference to `xtensa_kio_paddr'

Fixes: da844a81779e ("xtensa: add device trees support")
Fixes: 6cb971114f63 ("xtensa: remap io area defined in device tree")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/kmem_layout.h |  2 +-
 arch/xtensa/kernel/setup.c            | 12 ++++++------
 arch/xtensa/mm/mmu.c                  |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/xtensa/include/asm/kmem_layout.h b/arch/xtensa/include/asm/kmem_layout.h
index 7cbf68ca7106..6fc05cba61a2 100644
--- a/arch/xtensa/include/asm/kmem_layout.h
+++ b/arch/xtensa/include/asm/kmem_layout.h
@@ -78,7 +78,7 @@
 #endif
 #define XCHAL_KIO_SIZE			0x10000000
 
-#if (!XCHAL_HAVE_PTP_MMU || XCHAL_HAVE_SPANNING_WAY) && defined(CONFIG_OF)
+#if (!XCHAL_HAVE_PTP_MMU || XCHAL_HAVE_SPANNING_WAY) && defined(CONFIG_USE_OF)
 #define XCHAL_KIO_PADDR			xtensa_get_kio_paddr()
 #ifndef __ASSEMBLY__
 extern unsigned long xtensa_kio_paddr;
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index ed184106e4cf..ee9082a142fe 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -63,7 +63,7 @@ extern unsigned long initrd_end;
 extern int initrd_below_start_ok;
 #endif
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 void *dtb_start = __dtb_start;
 #endif
 
@@ -125,7 +125,7 @@ __tagtable(BP_TAG_INITRD, parse_tag_initrd);
 
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 
 static int __init parse_tag_fdt(const bp_tag_t *tag)
 {
@@ -135,7 +135,7 @@ static int __init parse_tag_fdt(const bp_tag_t *tag)
 
 __tagtable(BP_TAG_FDT, parse_tag_fdt);
 
-#endif /* CONFIG_OF */
+#endif /* CONFIG_USE_OF */
 
 static int __init parse_tag_cmdline(const bp_tag_t* tag)
 {
@@ -183,7 +183,7 @@ static int __init parse_bootparam(const bp_tag_t *tag)
 }
 #endif
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 
 #if !XCHAL_HAVE_PTP_MMU || XCHAL_HAVE_SPANNING_WAY
 unsigned long xtensa_kio_paddr = XCHAL_KIO_DEFAULT_PADDR;
@@ -232,7 +232,7 @@ void __init early_init_devtree(void *params)
 		strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 }
 
-#endif /* CONFIG_OF */
+#endif /* CONFIG_USE_OF */
 
 /*
  * Initialize architecture. (Early stage)
@@ -253,7 +253,7 @@ void __init init_arch(bp_tag_t *bp_start)
 	if (bp_start)
 		parse_bootparam(bp_start);
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 	early_init_devtree(dtb_start);
 #endif
 
diff --git a/arch/xtensa/mm/mmu.c b/arch/xtensa/mm/mmu.c
index 7e4d97dc8bd8..38acda4f04e8 100644
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -101,7 +101,7 @@ void init_mmu(void)
 
 void init_kio(void)
 {
-#if XCHAL_HAVE_PTP_MMU && XCHAL_HAVE_SPANNING_WAY && defined(CONFIG_OF)
+#if XCHAL_HAVE_PTP_MMU && XCHAL_HAVE_SPANNING_WAY && defined(CONFIG_USE_OF)
 	/*
 	 * Update the IO area mapping in case xtensa_kio_paddr has changed
 	 */
-- 
2.20.1

