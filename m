Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8893315D72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhBJCjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:39:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhBJCfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:35:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A020564E6C;
        Wed, 10 Feb 2021 02:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924433;
        bh=EndaGyRdjN9oy9Zca2ujwb1bEzZLVxLQbsL8F5iThuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctb5fIbAFcuSYro0m5gatX6VCcabk0pUfsB6pfbWiuzTK7meZJ/Qx4JlomvaZPyE2
         uN3EIp5ad0f4t+Ka+SGEisk/CfW3U9Qwkizu4CT4qjdx8XFs77Yz19KDoeVRQibQLg
         5iUFcM58vjfMqbZeV5Ec2B1bWp4F/6CazKETAZTaEH4So0iR0ttKgGMBQj3vTbSzkg
         yzsVrfK9wBIIbFxW8Y70MGSZG7Bm/8WdJ9GztyZQoof5UxPy8sH66NFGgzwrMnWLj8
         4WC00C1CZElgyK0koeYNcXln2biN59EuyS8xXJe6IGfO903g7A/veWfEnBGa+eg7UU
         PbNJZFwjExA/Q==
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
Subject: [PATCH v2 07/14] x86/fault: Improve kernel-executing-user-memory handling
Date:   Tue,  9 Feb 2021 18:33:39 -0800
Message-Id: <ab8719c7afb8bd501c4eee0e36493150fbbe5f6a.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
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
 arch/x86/mm/fault.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b1104844260d..cbb1a9754473 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -447,6 +447,9 @@ static int is_errata93(struct pt_regs *regs, unsigned long address)
 	    || boot_cpu_data.x86 != 0xf)
 		return 0;
 
+	if (user_mode(regs))
+		return 0;
+
 	if (address != regs->ip)
 		return 0;
 
@@ -744,9 +747,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (is_prefetch(regs, error_code, address))
 		return;
 
-	if (is_errata93(regs, address))
-		return;
-
 	/*
 	 * Buggy firmware could access regions which might page fault, try to
 	 * recover from such faults.
@@ -1239,6 +1239,21 @@ void do_user_addr_fault(struct pt_regs *regs,
 	tsk = current;
 	mm = tsk->mm;
 
+	if (unlikely((error_code & (X86_PF_USER | X86_PF_INSTR)) == X86_PF_INSTR)) {
+		/*
+		 * Whoops, this is kernel mode code trying to execute from
+		 * user memory.  Unless this is AMD erratum #93, which
+		 * corrupts RIP such that it looks like a user address,
+		 * this is unrecoverable.  Don't even try to look up the
+		 * VMA.
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

