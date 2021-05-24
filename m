Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A481D38DFDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 05:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhEXD1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 23:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhEXD1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 23:27:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A64EB61168;
        Mon, 24 May 2021 03:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621826740;
        bh=o5q0+MEnJH+hhRHy3KMD7gHupn225nz83GMRQ+4JxmE=;
        h=From:To:Cc:Subject:Date:From;
        b=Zu4VLWceJsSiy62fF24MX9+Ybo6GyntpjYgjaCFbRnDAvphM0Bnu/4TJklsmHyGDW
         zNaghNrJEX4ZtjuJZ4zn2N6X9qYLphMc3BtJ4VoVgNMH9IFBmOmomxEgxz3YmPesAr
         d+QaJVJdVlLFt6Wp8Mu33ur6cVib/k5MMnX8/F44VCJIj5XB9MlCjXxkqgpgdHEMyj
         VZzOlVxPsvaNiV+O28tGLLbx5FM/l/rO+j2kODy4/Y4VT33dAPep8awoivErdbf/vN
         +jE6jmadygjhnl1Q/giPUD1CwI/MyRLaxP/ZmZA+hbL4jX/tU6b+32JZz6iple18vs
         AxcTzcfpXozuQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org, x86@kernel.org
Subject: [BUGFIX PATCH -tip] x86/kprobes: Fix to call previous kprobe's fault handler
Date:   Mon, 24 May 2021 12:25:36 +0900
Message-Id: <162182673618.114649.7393137495689996180.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to call the previous kprobe's fault handler when a page fault
occurred in reentered kprobes.
This may happen if kprobes handler calls a function which can cause
a page fault (e.g. access user page) and another kprobe probes that
instruction.
Without the 2nd kprobe, the 1st kprobe can handle the page fault,
but with the 2nd kprobe, the 1st one can not handle it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7c4d0736a998..ac2514f1e195 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1098,12 +1098,21 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 */
 		regs->flags |= kcb->kprobe_old_flags;
 
-		if (kcb->kprobe_status == KPROBE_REENTER)
-			restore_previous_kprobe(kcb);
-		else
+		if (kcb->kprobe_status != KPROBE_REENTER) {
 			reset_current_kprobe();
-	} else if (kcb->kprobe_status == KPROBE_HIT_ACTIVE ||
-		   kcb->kprobe_status == KPROBE_HIT_SSDONE) {
+			return 0;
+		}
+		restore_previous_kprobe(kcb);
+		/*
+		 * If reentered kprobes caused a page fault, it must be
+		 * handled by the previous kprobe too. But we don't bother
+		 * checking KPROBE_HIT_SS again because kprobes can not
+		 * probe another kprobe's single stepping buffer.
+		 */
+	}
+
+	if (kcb->kprobe_status == KPROBE_HIT_ACTIVE ||
+	    kcb->kprobe_status == KPROBE_HIT_SSDONE) {
 		/*
 		 * We increment the nmissed count for accounting,
 		 * we can also use npre/npostfault count for accounting

