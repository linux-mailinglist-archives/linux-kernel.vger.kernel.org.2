Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74C3F0213
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhHRK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:57:59 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14273 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhHRK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:57:55 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GqPx16M9Zz7yxR;
        Wed, 18 Aug 2021 18:57:09 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 18:57:17 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 18 Aug 2021 18:57:16 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <liuqi115@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] arm64: Enable OPTPROBE for arm64
Date:   Wed, 18 Aug 2021 15:33:34 +0800
Message-ID: <20210818073336.59678-1-liuqi115@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce optprobe for ARM64, using a branch instruction
to replace probed instruction.

The test result on Hip08 platform is shown here, and optprobe could
reduce the latency to 1/4 of normal kprobe

kprobe before optimized:
[280709.846380] do_empty returned 0 and took 1530 ns to execute
[280709.852057] do_empty returned 0 and took 550 ns to execute
[280709.857631] do_empty returned 0 and took 440 ns to execute
[280709.863215] do_empty returned 0 and took 380 ns to execute
[280709.868787] do_empty returned 0 and took 360 ns to execute
[280709.874362] do_empty returned 0 and took 340 ns to execute
[280709.879936] do_empty returned 0 and took 320 ns to execute
[280709.885505] do_empty returned 0 and took 300 ns to execute
[280709.891075] do_empty returned 0 and took 280 ns to execute
[280709.896646] do_empty returned 0 and took 290 ns to execute
[280709.902220] do_empty returned 0 and took 290 ns to execute
[280709.907807] do_empty returned 0 and took 290 ns to execute

optprobe:
[ 2965.964572] do_empty returned 0 and took 90 ns to execute
[ 2965.969952] do_empty returned 0 and took 80 ns to execute
[ 2965.975332] do_empty returned 0 and took 70 ns to execute
[ 2965.980714] do_empty returned 0 and took 60 ns to execute
[ 2965.986128] do_empty returned 0 and took 80 ns to execute
[ 2965.991507] do_empty returned 0 and took 70 ns to execute
[ 2965.996884] do_empty returned 0 and took 70 ns to execute
[ 2966.002262] do_empty returned 0 and took 80 ns to execute
[ 2966.007642] do_empty returned 0 and took 70 ns to execute
[ 2966.013020] do_empty returned 0 and took 70 ns to execute
[ 2966.018400] do_empty returned 0 and took 70 ns to execute
[ 2966.023779] do_empty returned 0 and took 70 ns to execute
[ 2966.029158] do_empty returned 0 and took 70 ns to execute

Changes since V3:
- Address the comments from Masami, reduce the number of aarch64_insn_patch_text
in arch_optimize_kprobes() and arch_unoptimize_kprobes().
- Link: https://lore.kernel.org/lkml/20210810055330.18924-1-liuqi115@huawei.com/

Changes since V2:
- Address the comments from Masami, prepare another writable buffer in
arch_prepare_optimized_kprobe()and build the trampoline code on it.
- Address the comments from Amit, move save_all_base_regs and
restore_all_base_regs to <asm/assembler.h>, as these two macros are reused
in optprobe.
- Link: https://lore.kernel.org/lkml/20210804060209.95817-1-liuqi115@huawei.com/

Changes since V1:
- Address the comments from Masami, checks for all branch instructions, and
use aarch64_insn_patch_text_nosync() instead of aarch64_insn_patch_text()
in each probe.
- Link: https://lore.kernel.org/lkml/20210719122417.10355-1-liuqi115@huawei.com/

Qi Liu (2):
  Make save_all_base_regs and restore_all_base_regs as common macro
  arm64: kprobe: Enable OPTPROBE for arm64

 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/assembler.h            |  52 ++++
 arch/arm64/include/asm/kprobes.h              |  24 ++
 arch/arm64/kernel/probes/Makefile             |   2 +
 arch/arm64/kernel/probes/kprobes.c            |  19 +-
 arch/arm64/kernel/probes/kprobes_trampoline.S |  52 ----
 arch/arm64/kernel/probes/opt_arm64.c          | 276 ++++++++++++++++++
 .../arm64/kernel/probes/optprobe_trampoline.S |  37 +++
 8 files changed, 408 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm64/kernel/probes/opt_arm64.c
 create mode 100644 arch/arm64/kernel/probes/optprobe_trampoline.S

-- 
2.17.1

