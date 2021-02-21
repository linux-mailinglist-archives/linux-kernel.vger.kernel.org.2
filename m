Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E207320E0C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 22:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBUVmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 16:42:22 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12197 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBUVmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 16:42:20 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DkJcV6GNdzlNC8;
        Mon, 22 Feb 2021 05:39:38 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.172) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Feb 2021 05:41:27 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <jan.kiszka@siemens.com>, <kbingham@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] scripts/gdb: document lx_current is only supported by x86
Date:   Mon, 22 Feb 2021 10:35:27 +1300
Message-ID: <20210221213527.22076-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.172]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lx_current depends on the per_cpu current_task which exists on x86 only:

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

