Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952543B6C88
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 04:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhF2Chv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 22:37:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6021 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhF2Chs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 22:37:48 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GDT2y1Qs2zXljJ;
        Tue, 29 Jun 2021 10:30:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 10:35:20 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 29 Jun
 2021 10:35:19 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <guoren@linux.alibaba.com>,
        <chenlifu@huawei.com>, <penberg@kernel.org>, <mhiramat@kernel.org>,
        <me@packi.ch>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/2] riscv: implemented auipc simulate instruction
Date:   Tue, 29 Jun 2021 10:34:54 +0800
Message-ID: <20210629023455.280998-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To test the kprobe-based event tracing, we prepare
a kernel module 'kprobe_test.ko' to add the probes.
The assembly codes (partially) of the module are as follows:
...
0000000000000000 <kprobe_test_branch>:
...
0000000000000038 <.LVL1>:
  38:	00000597          	auipc	a1,0x0
  3c:	00058593          	mv	a1,a1
...

Test the kprobe-based event tracing in qemu-system-riscv64:
First, install the kprobe test module:
insmod /root/kprobe_test.ko

Then, add a probe as a new event at an 'auipc' instruction,
the following error occurs due to the instruction not allowed to probe yet:
echo "p:auipc kprobe_test:kprobe_test_branch+0x38 epc=%epc opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
sh: write error: Invalid argument

This patch implemented the 'auipc' simulate instruction and allowed to probe it.
Merge this patch and perform the test again, the test results are as follows:
First, add a probe at the 'auipc' instruction:
echo "p:auipc kprobe_test:kprobe_test_branch+0x38 epc=%epc opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
echo 1 > /sys/kernel/debug/tracing/events/kprobes/auipc/enable

Then, do something to run to the probe.
After that, see the traced information:
cat /sys/kernel/debug/tracing/trace
sysctl-58      [001] d...   179.126350: auipc: (kprobe_test_branch+0x38/0x10e [kprobe_test]) epc=0xffffffff016122aa opcode=0x100073

Now we can see the traced information.
The actual address of the symbol 'kprobe_test_branch' is as follows:
cat /proc/kallsyms | grep kprobe_test_branch
ffffffff01612272 t kprobe_test_branch   [kprobe_test]

Based on the traced information and the actual address of the symbol
'kprobe_test_branch', we can also see that the 'auipc' instruction
has been replaced by 'ebreak(0x100073)' instruction.

--------

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 arch/riscv/kernel/probes/decode-insn.c   |  2 +-
 arch/riscv/kernel/probes/simulate-insn.c | 34 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
index 0ed043acc882..5eb03fb61450 100644
--- a/arch/riscv/kernel/probes/decode-insn.c
+++ b/arch/riscv/kernel/probes/decode-insn.c
@@ -38,11 +38,11 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
 	RISCV_INSN_REJECTED(c_ebreak,		insn);
 #endif
 
-	RISCV_INSN_REJECTED(auipc,		insn);
 	RISCV_INSN_REJECTED(branch,		insn);
 
 	RISCV_INSN_SET_SIMULATE(jal,		insn);
 	RISCV_INSN_SET_SIMULATE(jalr,		insn);
+	RISCV_INSN_SET_SIMULATE(auipc,		insn);
 
 	return INSN_GOOD;
 }
diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
index 2519ce26377d..b81719522d5c 100644
--- a/arch/riscv/kernel/probes/simulate-insn.c
+++ b/arch/riscv/kernel/probes/simulate-insn.c
@@ -83,3 +83,37 @@ bool __kprobes simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *reg
 
 	return ret;
 }
+
+#define auipc_rd_idx(opcode) \
+	((opcode >> 7) & 0x1f)
+
+#define auipc_imm(opcode) \
+	((((opcode) >> 12) & 0xfffff) << 12)
+
+#if __riscv_xlen == 64
+#define auipc_offset(opcode)	sign_extend64(auipc_imm(opcode), 31)
+#elif __riscv_xlen == 32
+#define auipc_offset(opcode)	auipc_imm(opcode)
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
+bool __kprobes simulate_auipc(u32 opcode, unsigned long addr, struct pt_regs *regs)
+{
+	/*
+	 * auipc instruction:
+	 *  31        12 11 7 6      0
+	 * | imm[31:12] | rd | opcode |
+	 *        20       5     7
+	 */
+
+	u32 rd_idx = auipc_rd_idx(opcode);
+	unsigned long rd_val = addr + auipc_offset(opcode);
+
+	if (!rv_insn_reg_set_val(regs, rd_idx, rd_val))
+		return false;
+
+	instruction_pointer_set(regs, addr + 4);
+
+	return true;
+}
-- 
2.32.0

