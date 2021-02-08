Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34E3140B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhBHUnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:43:47 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50045 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhBHTc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:32:28 -0500
X-Originating-IP: 2.7.49.219
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 916D420002;
        Mon,  8 Feb 2021 19:31:24 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 1/4] riscv: Improve kasan definitions
Date:   Mon,  8 Feb 2021 14:30:14 -0500
Message-Id: <20210208193017.30904-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210208193017.30904-1-alex@ghiti.fr>
References: <20210208193017.30904-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no functional change here, only improvement in code readability
by adding comments to explain where the kasan constants come from and by
replacing hardcoded numerical constant by the corresponding define.

Note that the comments come from arm64.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/include/asm/kasan.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index b04028c6218c..a2b3d9cdbc86 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -8,12 +8,28 @@
 
 #ifdef CONFIG_KASAN
 
+/*
+ * The following comment was copied from arm64:
+ * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
+ * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/N of kernel virtual addresses,
+ * where N = (1 << KASAN_SHADOW_SCALE_SHIFT).
+ *
+ * KASAN_SHADOW_OFFSET:
+ * This value is used to map an address to the corresponding shadow
+ * address by the following formula:
+ *     shadow_addr = (address >> KASAN_SHADOW_SCALE_SHIFT) + KASAN_SHADOW_OFFSET
+ *
+ * (1 << (64 - KASAN_SHADOW_SCALE_SHIFT)) shadow addresses that lie in range
+ * [KASAN_SHADOW_OFFSET, KASAN_SHADOW_END) cover all 64-bits of virtual
+ * addresses. So KASAN_SHADOW_OFFSET should satisfy the following equation:
+ *      KASAN_SHADOW_OFFSET = KASAN_SHADOW_END -
+ *                              (1ULL << (64 - KASAN_SHADOW_SCALE_SHIFT))
+ */
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
-#define KASAN_SHADOW_SIZE	(UL(1) << (38 - KASAN_SHADOW_SCALE_SHIFT))
-#define KASAN_SHADOW_START	KERN_VIRT_START /* 2^64 - 2^38 */
+#define KASAN_SHADOW_SIZE	(UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
+#define KASAN_SHADOW_START	KERN_VIRT_START
 #define KASAN_SHADOW_END	(KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
-
 #define KASAN_SHADOW_OFFSET	(KASAN_SHADOW_END - (1ULL << \
 					(64 - KASAN_SHADOW_SCALE_SHIFT)))
 
-- 
2.20.1

