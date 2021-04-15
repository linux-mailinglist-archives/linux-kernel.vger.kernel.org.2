Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BCF36060F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhDOJnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:43:45 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:59976 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhDOJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:43:42 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 13372C8357;
        Thu, 15 Apr 2021 17:43:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P13171T139812676667136S1618479787805733_;
        Thu, 15 Apr 2021 17:43:08 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b89a07e032a563fb55c0761d28643f7a>
X-RL-SENDER: zhaoxiao@uniontech.com
X-SENDER: zhaoxiao@uniontech.com
X-LOGIN-NAME: zhaoxiao@uniontech.com
X-FST-TO: tglx@linutronix.de
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, nivedita@alum.mit.edu, clin@suse.com,
        andriy.shevchenko@linux.intel.com, ndesaulniers@google.com,
        dan.j.williams@intel.com, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jroedel@suse.de, peterz@infradead.org, jpoimboe@redhat.com,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] X86: Makefile: Replace -pg with CC_FLAGS_FTRACE
Date:   Thu, 15 Apr 2021 17:43:05 +0800
Message-Id: <20210415094305.30964-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for x86 supporting ftrace built on other compiler
options, let's have the x86 Makefiles remove the $(CC_FLAGS_FTRACE)
flags, whatever these may be, rather than assuming '-pg'.

There should be no functional change as a result of this patch.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 arch/x86/kernel/Makefile | 16 ++++++++--------
 arch/x86/lib/Makefile    |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2ddf08351f0b..2811fc6a17ba 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -13,14 +13,14 @@ CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
-CFLAGS_REMOVE_tsc.o = -pg
-CFLAGS_REMOVE_paravirt-spinlocks.o = -pg
-CFLAGS_REMOVE_pvclock.o = -pg
-CFLAGS_REMOVE_kvmclock.o = -pg
-CFLAGS_REMOVE_ftrace.o = -pg
-CFLAGS_REMOVE_early_printk.o = -pg
-CFLAGS_REMOVE_head64.o = -pg
-CFLAGS_REMOVE_sev-es.o = -pg
+CFLAGS_REMOVE_tsc.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_paravirt-spinlocks.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_pvclock.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_kvmclock.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_early_printk.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_head64.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_sev-es.o = $(CC_FLAGS_FTRACE)
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index bad4dee4f0e4..0aa71b8a5bc1 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -21,7 +21,7 @@ KASAN_SANITIZE_cmdline.o  := n
 KCSAN_SANITIZE_cmdline.o  := n
 
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_cmdline.o = -pg
+CFLAGS_REMOVE_cmdline.o = $(CC_FLAGS_FTRACE)
 endif
 
 CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
-- 
2.20.1



