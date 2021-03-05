Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406C232E6F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhCELDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:03:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13438 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCELC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:02:56 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DsPtX3GNgzjVcX;
        Fri,  5 Mar 2021 19:01:24 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Mar 2021
 19:02:40 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH 0/9] riscv: misc cleanup
Date:   Fri, 5 Mar 2021 19:33:23 +0800
Message-ID: <20210305113332.428048-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some compilation warnings,improve code style

Nanyong Sun (9):
  riscv: traps: Fix no prototype warnings
  riscv: irq: Fix no prototype warning
  riscv: sbi: Fix comment of __sbi_set_timer_v01
  riscv: ptrace: Fix no prototype warnings
  riscv: time: Fix no prototype for time_init
  riscv: syscall_table: Reduce W=1 compilation warnings noise
  riscv: process: Fix no prototype for show_regs
  riscv: ftrace: Use ftrace_get_regs helper
  riscv: process: Fix no prototype for arch_dup_task_struct

 arch/riscv/include/asm/asm-prototypes.h | 16 ++++++++++++++++
 arch/riscv/include/asm/irq.h            |  2 ++
 arch/riscv/include/asm/processor.h      |  1 +
 arch/riscv/include/asm/ptrace.h         |  5 +++++
 arch/riscv/include/asm/timex.h          |  2 ++
 arch/riscv/kernel/Makefile              |  1 +
 arch/riscv/kernel/probes/ftrace.c       | 16 +++++++++-------
 arch/riscv/kernel/process.c             |  1 +
 arch/riscv/kernel/sbi.c                 |  2 +-
 arch/riscv/kernel/time.c                |  1 +
 arch/riscv/kernel/traps.c               |  1 +
 11 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.25.1

