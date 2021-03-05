Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5D332E6F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhCELDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:03:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13068 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCELC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:02:56 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DsPsk6NggzMjRP;
        Fri,  5 Mar 2021 19:00:42 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Mar 2021
 19:02:45 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH 6/9] riscv: syscall_table: Reduce W=1 compilation warnings noise
Date:   Fri, 5 Mar 2021 19:33:29 +0800
Message-ID: <20210305113332.428048-7-sunnanyong@huawei.com>
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

Building riscv syscall table with W=1 throws the warning as
following pattern:
arch/riscv/kernel/syscall_table.c:14:36: warning: initialized field overwritten [-Woverride-init]
   14 | #define __SYSCALL(nr, call) [nr] = (call),
      |                                    ^
./include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro ‘__SYSCALL’
   29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
      |                                     ^~~~~~~~~
./include/uapi/asm-generic/unistd.h:34:1: note: in expansion of macro ‘__SC_COMP’
   34 | __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
      | ^~~~~~~~~
arch/riscv/kernel/syscall_table.c:14:36: note: (near initialization for ‘sys_call_table[0]’)
   14 | #define __SYSCALL(nr, call) [nr] = (call),
      |                                    ^
./include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro ‘__SYSCALL’
   29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
      |                                     ^~~~~~~~~
./include/uapi/asm-generic/unistd.h:34:1: note: in expansion of macro ‘__SC_COMP’
   34 | __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
      | ^~~~~~~~~
arch/riscv/kernel/syscall_table.c:14:36: warning: initialized field overwritten [-Woverride-init]
...

Since we intentionally build the syscall tables this way,ignore the warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/riscv/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 3dc0abde988a..647a47f5484a 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -8,6 +8,7 @@ CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
+CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
 
 extra-y += head.o
 extra-y += vmlinux.lds
-- 
2.25.1

