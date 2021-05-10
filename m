Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A679C377FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhEJJos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:44:48 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39589 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230153AbhEJJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:44:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UYMytMa_1620639817;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UYMytMa_1620639817)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 May 2021 17:43:38 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] x86/unwind/orc: Remove redundant initialization of 'mid'
Date:   Mon, 10 May 2021 17:43:35 +0800
Message-Id: <1620639815-93579-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer mid is being initialized however this value is never
read as mid is assigned an updated value in while statement.
Remove the redundant initialization. At the same time, adjust the
declarations order of variables to keep the "upside-down x-mas tree"
look of them.

Clean up clang warning:

arch/x86/kernel/unwind_orc.c:38:7: warning: Value stored to 'mid' during
its initialization is never read [clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/x86/kernel/unwind_orc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index a120253..bb76f4f 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -33,9 +33,10 @@ static inline unsigned long orc_ip(const int *ip)
 static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
 				    unsigned int num_entries, unsigned long ip)
 {
-	int *first = ip_table;
 	int *last = ip_table + num_entries - 1;
-	int *mid = first, *found = first;
+	int *first = ip_table;
+	int *found = first;
+	int *mid;
 
 	if (!num_entries)
 		return NULL;
-- 
1.8.3.1

