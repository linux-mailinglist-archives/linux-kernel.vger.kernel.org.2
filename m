Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2755309F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhAaXWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhAaXWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:22:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B33D164E41;
        Sun, 31 Jan 2021 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113891;
        bh=lq4ZxFmRpdCFZ2ngGIPT6XFBBMMwISWkJ4k3VKy0BMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lVxXwQK+AZQPdhPGApZo/Z/vVJKl/9AKzuVi4K2bcWZHI7Gi6oT+2XZNtus1gASOp
         MgRx8Owv1/5oZz++gHIG0vDiqqQmaHjBSWduxikLS1YIPiWvVRZfI543zF7IBevrRX
         lWIZlo7DAtTXmSBhtLKkuMlohxHeTJ+6ERggwOXnhjRgfe7ZnqsUPyXs6lhjgJaVvc
         F/rTYRV4cgHMdZzMObxqM/wP/NmoXJfNGntRQSJNdS9FduodEwNbOf9U2DiDrHhsvq
         Cv9j4cd67Ul27dVY6ID7iz0DX8JS5Z+ajy9CxxjyiiCnKpxDxhrTTp4EbYRjPcIo0H
         GL4Rc+Cw5wtMA==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/11] x86/fault: Improve kernel-executing-user-memory handling
Date:   Sun, 31 Jan 2021 09:24:37 -0800
Message-Id: <05e787a0d0661d0bfb40e44db39bf5ead5f7e4ef.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612113550.git.luto@kernel.org>
References: <cover.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we treat the case of the kernel trying to execute from user
memory more or less just like the kernel getting a page fault on a user
access.  In the failure path, we check for erratum #93, try to otherwise
fix up the error, and then oops.

If we manage to jump to the user address space, with or without SMEP, we
should not try to resolve the page fault.  This is an error, pure and
simple.  Rearrange the code so that we catch this case early, check for
erratum #93, and bail out.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 602cdf8e070a..1939e546beae 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -406,8 +406,11 @@ static void dump_pagetable(unsigned long address)
 static int is_errata93(struct pt_regs *regs, unsigned long address)
 {
 #if defined(CONFIG_X86_64) && defined(CONFIG_CPU_SUP_AMD)
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD
-	    || boot_cpu_data.x86 != 0xf)
+	if (likely(boot_cpu_data.x86_vendor != X86_VENDOR_AMD
+		   || boot_cpu_data.x86 != 0xf))
+		return 0;
+
+	if (user_mode(regs))
 		return 0;
 
 	if (address != regs->ip)
@@ -707,9 +710,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (is_prefetch(regs, error_code, address))
 		return;
 
-	if (is_errata93(regs, address))
-		return;
-
 	/*
 	 * Buggy firmware could access regions which might page fault, try to
 	 * recover from such faults.
@@ -1202,6 +1202,19 @@ void do_user_addr_fault(struct pt_regs *regs,
 	tsk = current;
 	mm = tsk->mm;
 
+	if (unlikely((error_code & (X86_PF_USER | X86_PF_INSTR)) == X86_PF_INSTR)) {
+		/*
+		 * Whoops, this is kernel mode code trying to execute from
+		 * user memory.  Unless this is AMD erratum #93, we are toast.
+		 * Don't even try to look up the VMA.
+		 */
+		if (is_errata93(regs, address))
+			return;
+
+		bad_area_nosemaphore(regs, error_code, address);
+		return;
+	}
+
 	/* kprobes don't want to hook the spurious faults: */
 	if (unlikely(kprobe_page_fault(regs, X86_TRAP_PF)))
 		return;
-- 
2.29.2

