Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1551833A808
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhCNUlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:41:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13529 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbhCNUl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:41:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DzBGv4TN1zNmXh;
        Mon, 15 Mar 2021 04:39:03 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.142) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 04:41:14 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <jan.kiszka@siemens.com>,
        <kbingham@kernel.org>
CC:     <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@openeuler.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [RESEND PATCH v2 2/2] scripts/gdb: add lx_current support for arm64
Date:   Mon, 15 Mar 2021 09:34:44 +1300
Message-ID: <20210314203444.15188-3-song.bao.hua@hisilicon.com>
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

