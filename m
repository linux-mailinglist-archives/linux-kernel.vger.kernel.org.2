Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC032290A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhBWKuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhBWKum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:50:42 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDF6C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 02:50:01 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:254f:253d:debc:790b])
        by baptiste.telenet-ops.be with bizsmtp
        id Yapz2400X1v7dkx01apzC6; Tue, 23 Feb 2021 11:49:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lEVGR-0011PW-91; Tue, 23 Feb 2021 11:49:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lEVGQ-009GjK-Ji; Tue, 23 Feb 2021 11:49:58 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: Fix virt_addr_valid() W=1 compiler warnings
Date:   Tue, 23 Feb 2021 11:49:57 +0100
Message-Id: <20210223104957.2209219-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DEBUG_SG=y, and CONFIG_MMU=y:

    include/linux/scatterlist.h: In function ‘sg_set_buf’:
    arch/m68k/include/asm/page_mm.h:174:49: warning: ordered comparison of pointer with null pointer [-Wextra]
      174 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
	  |                                                 ^~

or CONFIG_MMU=n:

    include/linux/scatterlist.h: In function ‘sg_set_buf’:
    arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
       33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
	  |                                                  ^~

Fix this by doing the comparison in the "unsigned long" instead of the
"void *" domain.

Note that for now this is only seen when compiling btrfs, due to commit
e9aa7c285d20a69c ("btrfs: enable W=1 checks for btrfs"), but as people
are doing more W=1 compile testing, it will start to show up elsewhere,
too.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Probably we want this as a fix for v5.12, to avoid the build bots
nagging about it all the time?

 arch/m68k/include/asm/page_mm.h | 2 +-
 arch/m68k/include/asm/page_no.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index 7f5912af2a52ea0a..9b1672f9b2e22cdf 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -171,7 +171,7 @@ static inline __attribute_const__ int __virt_to_node_shift(void)
 #include <asm-generic/memory_model.h>
 #endif
 
-#define virt_addr_valid(kaddr)	((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
+#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && ((unsigned long)kaddr) < (unsigned long)high_memory)
 #define pfn_valid(pfn)		virt_addr_valid(pfn_to_virt(pfn))
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index 6bbe52025de3c5c6..8d0f862ee9d79532 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -30,8 +30,8 @@ extern unsigned long memory_end;
 #define page_to_pfn(page)	virt_to_pfn(page_to_virt(page))
 #define pfn_valid(pfn)	        ((pfn) < max_mapnr)
 
-#define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
-				((void *)(kaddr) < (void *)memory_end))
+#define	virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET) && \
+				((unsigned long)(kaddr) < memory_end))
 
 #endif /* __ASSEMBLY__ */
 
-- 
2.25.1

