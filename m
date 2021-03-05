Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF032E6F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCELDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:03:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13440 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCELC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:02:56 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DsPtd69zrzjVjh;
        Fri,  5 Mar 2021 19:01:29 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Mar 2021
 19:02:46 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH 8/9] riscv: ftrace: Use ftrace_get_regs helper
Date:   Fri, 5 Mar 2021 19:33:31 +0800
Message-ID: <20210305113332.428048-9-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305113332.428048-1-sunnanyong@huawei.com>
References: <20210305113332.428048-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ftrace_get_regs() helper call to get pt_regs from ftrace_regs struct,
this makes the code simpler.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/riscv/kernel/probes/ftrace.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
index e6372490aa0b..2dfb33fdac74 100644
--- a/arch/riscv/kernel/probes/ftrace.c
+++ b/arch/riscv/kernel/probes/ftrace.c
@@ -4,37 +4,39 @@
 
 /* Ftrace callback handler for kprobes -- called under preepmt disabed */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
-			   struct ftrace_ops *ops, struct ftrace_regs *regs)
+			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
 	struct kprobe *p;
+	struct pt_regs *regs;
 	struct kprobe_ctlblk *kcb;
 
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
 		return;
 
+	regs = ftrace_get_regs(fregs);
 	kcb = get_kprobe_ctlblk();
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(p);
 	} else {
-		unsigned long orig_ip = instruction_pointer(&(regs->regs));
+		unsigned long orig_ip = instruction_pointer(regs);
 
-		instruction_pointer_set(&(regs->regs), ip);
+		instruction_pointer_set(regs, ip);
 
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
-		if (!p->pre_handler || !p->pre_handler(p, &(regs->regs))) {
+		if (!p->pre_handler || !p->pre_handler(p, regs)) {
 			/*
 			 * Emulate singlestep (and also recover regs->pc)
 			 * as if there is a nop
 			 */
-			instruction_pointer_set(&(regs->regs),
+			instruction_pointer_set(regs,
 				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
 			if (unlikely(p->post_handler)) {
 				kcb->kprobe_status = KPROBE_HIT_SSDONE;
-				p->post_handler(p, &(regs->regs), 0);
+				p->post_handler(p, regs, 0);
 			}
-			instruction_pointer_set(&(regs->regs), orig_ip);
+			instruction_pointer_set(regs, orig_ip);
 		}
 
 		/*
-- 
2.25.1

