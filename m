Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F1D33A806
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhCNUll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:41:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13923 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhCNUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:41:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DzBHn3yrSzjVMF;
        Mon, 15 Mar 2021 04:39:49 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.142) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 04:41:12 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <jan.kiszka@siemens.com>,
        <kbingham@kernel.org>
CC:     <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@openeuler.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [RESEND PATCH v2 1/2] scripts/gdb: document lx_current is only supported by x86
Date:   Mon, 15 Mar 2021 09:34:43 +1300
Message-ID: <20210314203444.15188-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210314203444.15188-1-song.bao.hua@hisilicon.com>
References: <20210314203444.15188-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.142]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 is the only architecture which has per_cpu current_task:
arch$ git grep current_task | grep -i per_cpu
x86/include/asm/current.h:DECLARE_PER_CPU(struct task_struct *, current_task);
x86/kernel/cpu/common.c:DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
x86/kernel/cpu/common.c:EXPORT_PER_CPU_SYMBOL(current_task);
x86/kernel/cpu/common.c:DEFINE_PER_CPU(struct task_struct *, current_task) = &init_task;
x86/kernel/cpu/common.c:EXPORT_PER_CPU_SYMBOL(current_task);
x86/kernel/smpboot.c:	per_cpu(current_task, cpu) = idle;

On other architectures, lx_current() will lead to a python exception:
(gdb) p $lx_current().pid
Python Exception <class 'gdb.error'> No symbol "current_task" in current context.:
Error occurred in Python: No symbol "current_task" in current context.

To avoid more people struggling and wasting time in other architectures,
document it.

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/dev-tools/gdb-kernel-debugging.rst |  2 +-
 scripts/gdb/linux/cpus.py                        | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/gdb-kernel-debugging.rst b/Documentation/dev-tools/gdb-kernel-debugging.rst
index 4756f6b3a04e..1586901b683c 100644
--- a/Documentation/dev-tools/gdb-kernel-debugging.rst
+++ b/Documentation/dev-tools/gdb-kernel-debugging.rst
@@ -114,7 +114,7 @@ Examples of using the Linux-provided gdb helpers
     [     0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
     ....
 
-- Examine fields of the current task struct::
+- Examine fields of the current task struct(supported by x86 only)::
 
     (gdb) p $lx_current().pid
     $1 = 4998
diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 008e62f3190d..f382762509d3 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -156,6 +156,13 @@ Note that VAR has to be quoted as string."""
 
 PerCpu()
 
+def get_current_task(cpu):
+    if utils.is_target_arch("x86"):
+         var_ptr = gdb.parse_and_eval("&current_task")
+         return per_cpu(var_ptr, cpu).dereference()
+    else:
+        raise gdb.GdbError("Sorry, obtaining the current task is not yet "
+                           "supported with this arch")
 
 class LxCurrentFunc(gdb.Function):
     """Return current task.
@@ -167,8 +174,7 @@ number. If CPU is omitted, the CPU of the current context is used."""
         super(LxCurrentFunc, self).__init__("lx_current")
 
     def invoke(self, cpu=-1):
-        var_ptr = gdb.parse_and_eval("&current_task")
-        return per_cpu(var_ptr, cpu).dereference()
+        return get_current_task(cpu)
 
 
 LxCurrentFunc()
-- 
2.25.1

