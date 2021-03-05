Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8832E6F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhCELD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:03:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13441 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCELC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:02:56 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DsPtd6ST6zjVjt;
        Fri,  5 Mar 2021 19:01:29 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Mar 2021
 19:02:43 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH 4/9] riscv: ptrace: Fix no prototype warnings
Date:   Fri, 5 Mar 2021 19:33:27 +0800
Message-ID: <20210305113332.428048-5-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305113332.428048-1-sunnanyong@huawei.com>
References: <20210305113332.428048-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel compilation warnings:
arch/riscv/kernel/ftrace.c:186:6: warning: no previous prototype for ‘prepare_ftrace_return’ [-Wmissing-prototypes]
  186 | void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
      |      ^~~~~~~~~~~~~~~~~~~~~
arch/riscv/kernel/ptrace.c:239:15: warning: no previous prototype for ‘do_syscall_trace_enter’ [-Wmissing-prototypes]
  239 | __visible int do_syscall_trace_enter(struct pt_regs *regs)
      |               ^~~~~~~~~~~~~~~~~~~~~~
arch/riscv/kernel/ptrace.c:262:16: warning: no previous prototype for ‘do_syscall_trace_exit’ [-Wmissing-prototypes]
  262 | __visible void do_syscall_trace_exit(struct pt_regs *regs)
      |                ^~~~~~~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/riscv/include/asm/ptrace.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index cb4abb639e8d..09ad4e923510 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -119,6 +119,11 @@ extern int regs_query_register_offset(const char *name);
 extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 					       unsigned int n);
 
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long frame_pointer);
+int do_syscall_trace_enter(struct pt_regs *regs);
+void do_syscall_trace_exit(struct pt_regs *regs);
+
 /**
  * regs_get_register() - get register value from its offset
  * @regs:	pt_regs from which register value is gotten
-- 
2.25.1

