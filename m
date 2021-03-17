Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E533F280
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhCQOXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:23:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14078 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCQOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:23:17 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F0slh052dz17LBs;
        Wed, 17 Mar 2021 22:21:20 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 22:23:03 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rui.xiang@huawei.com>
Subject: [PATCH 2/2] arm64: stacktrace: Add skip when task == current
Date:   Wed, 17 Mar 2021 14:20:50 +0000
Message-ID: <20210317142050.57712-3-chenjun102@huawei.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20210317142050.57712-1-chenjun102@huawei.com>
References: <20210317142050.57712-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ARM64, cat /sys/kernel/debug/page_owner, all pages return the same
stack:
 stack_trace_save+0x4c/0x78
 register_early_stack+0x34/0x70
 init_page_owner+0x34/0x230
 page_ext_init+0x1bc/0x1dc

The reason is that:
check_recursive_alloc always return 1 because that
entries[0] is always equal to ip (__set_page_owner+0x3c/0x60).

The root cause is that:
commit 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
make the save_trace save 2 more entries.

Add skip in arch_stack_walk when task == current.

Fixes: 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 arch/arm64/kernel/stacktrace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index ad20981..c26b0ac 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -201,11 +201,12 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 
 	if (regs)
 		start_backtrace(&frame, regs->regs[29], regs->pc);
-	else if (task == current)
+	else if (task == current) {
+		((struct stacktrace_cookie *)cookie)->skip += 2;
 		start_backtrace(&frame,
 				(unsigned long)__builtin_frame_address(0),
 				(unsigned long)arch_stack_walk);
-	else
+	} else
 		start_backtrace(&frame, thread_saved_fp(task),
 				thread_saved_pc(task));
 
-- 
2.9.4

