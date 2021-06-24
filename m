Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F02E3B2E75
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhFXMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:04:10 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38367 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhFXMEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:04:09 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 219A7E000F;
        Thu, 24 Jun 2021 12:01:45 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v8 1/2] riscv: Introduce set_kernel_memory helper
Date:   Thu, 24 Jun 2021 14:00:40 +0200
Message-Id: <20210624120041.2786419-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210624120041.2786419-1-alex@ghiti.fr>
References: <20210624120041.2786419-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper should be used for setting permissions to the kernel
mapping as it takes pointers as arguments and then avoids explicit cast
to unsigned long needed for the set_memory_* API.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/set_memory.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 9d4d455726d4..96e317dcab13 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -17,6 +17,16 @@ int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 int set_memory_rw_nx(unsigned long addr, int numpages);
 void protect_kernel_text_data(void);
+static __always_inline int set_kernel_memory(char *startp, char *endp,
+					     int (*set_memory)(unsigned long start,
+							       int num_pages))
+{
+	unsigned long start = (unsigned long)startp;
+	unsigned long end = (unsigned long)endp;
+	int num_pages = PAGE_ALIGN(end - start) >> PAGE_SHIFT;
+
+	return set_memory(start, num_pages);
+}
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
@@ -24,6 +34,12 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 static inline void protect_kernel_text_data(void) {}
 static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
+static inline int set_kernel_memory(char *startp, char *endp,
+				    int (*set_memory)(unsigned long start,
+						      int num_pages))
+{
+	return 0;
+}
 #endif
 
 #if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
-- 
2.30.2

