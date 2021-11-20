Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13004457FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 18:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbhKTRbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 12:31:02 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44265 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231142AbhKTRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 12:31:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UxSuoAS_1637429275;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UxSuoAS_1637429275)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 21 Nov 2021 01:27:56 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 1/2] mm/damon/dbgfs: Modify Damon dbfs interface dependency in Kconfig
Date:   Sun, 21 Nov 2021 01:27:53 +0800
Message-Id: <fbf27c39e8f23d12d5474b9b659d3d45f8dd38ca.1637429074.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you want to support "DAMON_DBGFS" in config file, it only depends on
any one of "DAMON_VADDR" and "DAMON_PADDR".

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

