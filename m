Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD63408488
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhIMGOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbhIMGOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:14:12 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sqr8wYM7BeNj0Y/QdcRcYmKG3RoaNCFM/D2ySX9lLbs=; b=P/zwUPdqSEY48+fdIAlnQbP+qj
        cgVcT5824TqEHcX0N8OgLjuu/0oSaFjdgDqU1q/jt92m+ZYZzZG1uGzqLsh4cmVzftVzsAudRZVRt
        ruCicNWlehNB7v8JoWU01AFL2P3PndFTsCTkaCI29zYkAe+SWPDPqqXMCxdfahHIz0g9Gv6yv6yW8
        lOE+Clk4AWZwzHgEK60HWHzI8twflo+0E6nXK9a7CdRpSmvWB382SJNpYHqEcDmcHThYlswCu39Mn
        UN7vMR0D5qgoQxRhWB5W+mHYuyvVs+b0EBm+hn1qt06WbfF1615bb6w8LD30BfyUS2WYuABM2Z5Pv
        OI5IP9Eg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPfD4-000Pu0-DO; Mon, 13 Sep 2021 06:12:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH] um: registers: rename function names to avoid conflicts and build problems
Date:   Sun, 12 Sep 2021 23:12:52 -0700
Message-Id: <20210913061252.15582-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function names init_registers() and restore_registers() are used
in several net/ethernet/ and gpu/drm/ drivers for other purposes (not
calls to UML functions), so rename them.

This fixes multiple build errors.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
---
 arch/um/include/shared/registers.h |    4 ++--
 arch/um/os-Linux/registers.c       |    4 ++--
 arch/um/os-Linux/start_up.c        |    2 +-
 arch/x86/um/syscalls_64.c          |    3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)

--- lnx-515-rc1.orig/arch/um/include/shared/registers.h
+++ lnx-515-rc1/arch/um/include/shared/registers.h
@@ -16,8 +16,8 @@ extern int restore_fp_registers(int pid,
 extern int save_fpx_registers(int pid, unsigned long *fp_regs);
 extern int restore_fpx_registers(int pid, unsigned long *fp_regs);
 extern int save_registers(int pid, struct uml_pt_regs *regs);
-extern int restore_registers(int pid, struct uml_pt_regs *regs);
-extern int init_registers(int pid);
+extern int restore_pid_registers(int pid, struct uml_pt_regs *regs);
+extern int init_pid_registers(int pid);
 extern void get_safe_registers(unsigned long *regs, unsigned long *fp_regs);
 extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 extern int get_fp_registers(int pid, unsigned long *regs);
--- lnx-515-rc1.orig/arch/um/os-Linux/registers.c
+++ lnx-515-rc1/arch/um/os-Linux/registers.c
@@ -21,7 +21,7 @@ int save_registers(int pid, struct uml_p
 	return 0;
 }
 
-int restore_registers(int pid, struct uml_pt_regs *regs)
+int restore_pid_registers(int pid, struct uml_pt_regs *regs)
 {
 	int err;
 
@@ -36,7 +36,7 @@ int restore_registers(int pid, struct um
 static unsigned long exec_regs[MAX_REG_NR];
 static unsigned long exec_fp_regs[FP_SIZE];
 
-int init_registers(int pid)
+int init_pid_registers(int pid)
 {
 	int err;
 
--- lnx-515-rc1.orig/arch/um/os-Linux/start_up.c
+++ lnx-515-rc1/arch/um/os-Linux/start_up.c
@@ -368,7 +368,7 @@ void __init os_early_checks(void)
 	check_tmpexec();
 
 	pid = start_ptraced_child();
-	if (init_registers(pid))
+	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
 	stop_ptraced_child(pid, 1, 1);
 }
--- lnx-515-rc1.orig/arch/x86/um/syscalls_64.c
+++ lnx-515-rc1/arch/x86/um/syscalls_64.c
@@ -11,6 +11,7 @@
 #include <linux/uaccess.h>
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <os.h>
+#include <registers.h>
 
 long arch_prctl(struct task_struct *task, int option,
 		unsigned long __user *arg2)
@@ -35,7 +36,7 @@ long arch_prctl(struct task_struct *task
 	switch (option) {
 	case ARCH_SET_FS:
 	case ARCH_SET_GS:
-		ret = restore_registers(pid, &current->thread.regs.regs);
+		ret = restore_pid_registers(pid, &current->thread.regs.regs);
 		if (ret)
 			return ret;
 		break;
