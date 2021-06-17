Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5856C3AB47F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhFQNVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:21:21 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56417 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhFQNVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:21:17 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2C19D60003;
        Thu, 17 Jun 2021 13:18:56 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v6 1/2] riscv: Introduce set_kernel_memory helper
Date:   Thu, 17 Jun 2021 15:17:33 +0200
Message-Id: <20210617131734.1923932-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617131734.1923932-1-alex@ghiti.fr>
References: <20210617131734.1923932-1-alex@ghiti.fr>
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
 arch/riscv/include/asm/set_memory.h |  5 +++++
 arch/riscv/mm/pageattr.c            | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 9d4d455726d4..59f242abe969 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -16,6 +16,7 @@ int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 int set_memory_rw_nx(unsigned long addr, int numpages);
+int set_kernel_memory(char *start, char *end, int (*set_memory)(unsigned long, int));
 void protect_kernel_text_data(void);
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
@@ -24,6 +25,10 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 static inline void protect_kernel_text_data(void) {}
 static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
+static inline int set_kernel_memory(char *start, char *end, int (*set_memory)(unsigned long, int))
+{
+	return 0;
+}
 #endif
 
 #if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 5e49e4b4a4cc..c47ac6a432ac 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -156,6 +156,16 @@ int set_memory_nx(unsigned long addr, int numpages)
 	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
 }
 
+int set_kernel_memory(char *startp, char *endp,
+		      int (*set_memory)(unsigned long start, int num_pages))
+{
+	unsigned long start = (unsigned long)startp;
+	unsigned long end = (unsigned long)endp;
+	int num_pages = PAGE_ALIGN(end - start) >> PAGE_SHIFT;
+
+	return set_memory(start, num_pages);
+}
+
 int set_direct_map_invalid_noflush(struct page *page)
 {
 	int ret;
-- 
2.30.2

