Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607C93E8754
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhHKAnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235977AbhHKAnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4815A60C40;
        Wed, 11 Aug 2021 00:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642597;
        bh=ErFVGLefxP4MHVDH8Q7kswgyJ2BqPsS+5BKbLRJMXC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egE2spqBx9LY1O7g9Vel5aVr2I9KAWdVGpTZz7DgmNWefl5hyvv2tvPorFxHkRDM6
         71q003FAcfpShb9J3ju2shYDhiSXfgvywX1nA6koVInrgfrBNwBCZCDXr3f7iqGnGk
         wOWsQuPFRv7iEzuOIANE9FD5R1TosNU3At/HgbrtDMrxyQdmOXDghsduu2L9ilt14G
         qAGZuuhrLvsYi5uN86y5YuDxQK+if4ld8+jYDyb90HcE5WSW+GXfQHPr8D43pX0abq
         dz+hrCoqbVnJwkM/RlUwdmYnwPxroHVgLApEPTTYHjfz1UO4oTLFrD+5HFlwoMesVi
         4WVmPOy3cmk1g==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Vineet Gupta <vgupta@kernel.com>
Subject: [PATCH 03/18] ARC: mm: move mmu/cache externs out to setup.h
Date:   Tue, 10 Aug 2021 17:42:43 -0700
Message-Id: <20210811004258.138075-4-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811004258.138075-1-vgupta@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.com>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/cache.h |  4 ----
 arch/arc/include/asm/mmu.h   |  4 ----
 arch/arc/include/asm/setup.h | 12 ++++++++++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index d8ece4292388..f0f1fc5d62b6 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -62,10 +62,6 @@
 #define ARCH_SLAB_MINALIGN	8
 #endif
 
-extern void arc_cache_init(void);
-extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
-extern void read_decode_cache_bcr(void);
-
 extern int ioc_enable;
 extern unsigned long perip_base, perip_end;
 
diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
index 38a036508699..762cfe66e16b 100644
--- a/arch/arc/include/asm/mmu.h
+++ b/arch/arc/include/asm/mmu.h
@@ -64,10 +64,6 @@ typedef struct {
 	unsigned long asid[NR_CPUS];	/* 8 bit MMU PID + Generation cycle */
 } mm_context_t;
 
-void arc_mmu_init(void);
-extern char *arc_mmu_mumbojumbo(int cpu_id, char *buf, int len);
-void read_decode_mmu_bcr(void);
-
 static inline int is_pae40_enabled(void)
 {
 	return IS_ENABLED(CONFIG_ARC_HAS_PAE40);
diff --git a/arch/arc/include/asm/setup.h b/arch/arc/include/asm/setup.h
index 01f85478170d..028a8cf76206 100644
--- a/arch/arc/include/asm/setup.h
+++ b/arch/arc/include/asm/setup.h
@@ -2,8 +2,8 @@
 /*
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  */
-#ifndef __ASMARC_SETUP_H
-#define __ASMARC_SETUP_H
+#ifndef __ASM_ARC_SETUP_H
+#define __ASM_ARC_SETUP_H
 
 
 #include <linux/types.h>
@@ -34,4 +34,12 @@ long __init arc_get_mem_sz(void);
 #define IS_AVAIL2(v, s, cfg)	IS_AVAIL1(v, s), IS_AVAIL1(v, IS_USED_CFG(cfg))
 #define IS_AVAIL3(v, v2, s)	IS_AVAIL1(v, s), IS_AVAIL1(v, IS_DISABLED_RUN(v2))
 
+extern void arc_mmu_init(void);
+extern char *arc_mmu_mumbojumbo(int cpu_id, char *buf, int len);
+extern void read_decode_mmu_bcr(void);
+
+extern void arc_cache_init(void);
+extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
+extern void read_decode_cache_bcr(void);
+
 #endif /* __ASMARC_SETUP_H */
-- 
2.25.1

