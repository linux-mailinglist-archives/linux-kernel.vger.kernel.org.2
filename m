Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8B440AB12
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhINJpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:45:41 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:45623 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhINJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:45:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UoNByb2_1631612648;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0UoNByb2_1631612648)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Sep 2021 17:44:20 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Li <ashimida@linux.alibaba.com>
Subject: [PATCH] [RFC]arm64:Mark __stack_chk_guard as __ro_after_init
Date:   Tue, 14 Sep 2021 17:44:02 +0800
Message-Id: <1631612642-102881-1-git-send-email-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__stack_chk_guard is setup once while init stage and never changed
after that.

Although the modification of this variable at runtime will usually
cause the kernel to crash (so dose the attacker), it should be marked
as _ro_after_init, and it should not affect performance if it is
placed in the ro_after_init section.

This should also be the case on the ARM platform, or am I missing
something?

Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
---
 arch/arm64/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c8989b9..c858b85 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -60,7 +60,7 @@
 
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
-unsigned long __stack_chk_guard __read_mostly;
+unsigned long __stack_chk_guard __ro_after_init;
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
-- 
2.7.4

