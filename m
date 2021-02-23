Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E083233EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhBWWsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:48:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12642 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbhBWWc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:32:59 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DlYf45Jcqz16BrH;
        Wed, 24 Feb 2021 06:30:20 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.133) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Feb 2021 06:31:49 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <jan.kiszka@siemens.com>, <kbingham@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 2/2] scripts/gdb: add lx_current support for arm64
Date:   Wed, 24 Feb 2021 11:25:40 +1300
Message-ID: <20210223222540.9120-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210223222540.9120-1-song.bao.hua@hisilicon.com>
References: <20210223222540.9120-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 uses SP_EL0 to save the current task_struct address. While running
in EL0, SP_EL0 is clobbered by userspace. So if the upper bit is not 1
(not TTBR1), the current address is invalid. This patch checks the upper
bit of SP_EL0, if the upper bit is 1, lx_current() of arm64 will return
the derefrence of current task. Otherwise, lx_current() will tell users
they are running in userspace(EL0).

While arm64 is running in EL0, it is actually pointless to print current
task as the memory of kernel space is not accessible in EL0.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/dev-tools/gdb-kernel-debugging.rst |  2 +-
 scripts/gdb/linux/cpus.py                        | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/gdb-kernel-debugging.rst b/Documentation/dev-tools/gdb-kernel-debugging.rst
index 1586901b683c..8e0f1fe8d17a 100644
--- a/Documentation/dev-tools/gdb-kernel-debugging.rst
+++ b/Documentation/dev-tools/gdb-kernel-debugging.rst
@@ -114,7 +114,7 @@ Examples of using the Linux-provided gdb helpers
     [     0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
     ....
 
-- Examine fields of the current task struct(supported by x86 only)::
+- Examine fields of the current task struct(supported by x86 and arm64 only)::
 
     (gdb) p $lx_current().pid
     $1 = 4998
diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index f382762509d3..15fc4626d236 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -16,6 +16,9 @@ import gdb
 from linux import tasks, utils
 
 
+task_type = utils.CachedType("struct task_struct")
+
+
 MAX_CPUS = 4096
 
 
@@ -157,9 +160,19 @@ Note that VAR has to be quoted as string."""
 PerCpu()
 
 def get_current_task(cpu):
+    task_ptr_type = task_type.get_type().pointer()
+
     if utils.is_target_arch("x86"):
          var_ptr = gdb.parse_and_eval("&current_task")
          return per_cpu(var_ptr, cpu).dereference()
+    elif utils.is_target_arch("aarch64"):
+         current_task_addr = gdb.parse_and_eval("$SP_EL0")
+         if((current_task_addr >> 63) != 0):
+             current_task = current_task_addr.cast(task_ptr_type)
+             return current_task.dereference()
+         else:
+             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
+                                "while running in userspace(EL0)")
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
-- 
2.25.1

