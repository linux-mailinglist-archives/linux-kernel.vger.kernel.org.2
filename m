Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1234583FB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 15:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbhKUOKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 09:10:18 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:43360 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238225AbhKUOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 09:10:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UxWwTCe_1637503628;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UxWwTCe_1637503628)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 21 Nov 2021 22:07:10 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] mm/damon/dbgfs: Modify Damon dbfs interface dependency in Kconfig
Date:   Sun, 21 Nov 2021 22:07:04 +0800
Message-Id: <39a61385187fbc293dcf0e32f20137148ca97db6.1637503141.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1637503141.git.xhao@linux.alibaba.com>
References: <cover.1637503141.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you want to support "DAMON_DBGFS" in config file, it only depends on
any one of "DAMON_VADDR" and "DAMON_PADDR", and sometimes we just want to
use damon virtual address function, but it is unreasonable to include "DAMON_PADDR"
in config file which cause the damon/paddr.c be compiled, so there fix it.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h | 12 ++++++++++++
 mm/damon/Kconfig      |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8a73e825e0d5..00ad96f2ec10 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -463,11 +463,23 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 #ifdef CONFIG_DAMON_VADDR
 void damon_va_set_primitives(struct damon_ctx *ctx);
 bool damon_va_target_valid(void *t);
+#else
+static inline void damon_va_set_primitives(struct damon_ctx *ctx) {}
+static inline bool damon_va_target_valid(void *t)
+{
+	return false;
+}
 #endif	/* CONFIG_DAMON_VADDR */
 
 #ifdef CONFIG_DAMON_PADDR
 void damon_pa_set_primitives(struct damon_ctx *ctx);
 bool damon_pa_target_valid(void *t);
+#else
+static inline void damon_pa_set_primitives(struct damon_ctx *ctx) {}
+static inline bool damon_pa_target_valid(void *t)
+{
+	return false;
+}
 #endif	/* CONFIG_DAMON_PADDR */
 
 #endif	/* _DAMON_H */
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 5bcf05851ad0..971ffc496596 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -54,7 +54,7 @@ config DAMON_VADDR_KUNIT_TEST
 
 config DAMON_DBGFS
 	bool "DAMON debugfs interface"
-	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
+	depends on DAMON_VADDR || DAMON_PADDR && DEBUG_FS
 	help
 	  This builds the debugfs interface for DAMON.  The user space admins
 	  can use the interface for arbitrary data access monitoring.
-- 
2.31.0

