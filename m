Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7B4357F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 02:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhJUA5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 20:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhJUA5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:57:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C7F9610A1;
        Thu, 21 Oct 2021 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634777685;
        bh=/6Ses4iOpFuwfQyjHXNpCu4Cpb2y9TUHV8jz9fN04Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGba/T9nv9XcVTyQ1ZY6+S7JA1Ucv6GR6g1kJbkXLvFWgkt94SyjRhvCtIN+7fbMP
         JX+NonR/s9ZrPDONB1oIcyT1p5NqpjDrHRidigDV5frWYTKEnnlm8JXEhaAL+HGARm
         qFu2QmAV345H36PD0xxYvwhFLdcMuF10+VshvcKeDEZ1HI22GhE4sn7sdfNdWNg7CY
         RinCT89jSzw8UPbF+T/q9+VULr0SVcXdWWNkEtGgDytWsoLKrv+xdKjucV7es9nVIr
         X4IcgUTNXIgRlCwPuDdSdzIITukKojfGhOrLhciyBQ6qNO8y+4CPMjFCtOkkUK86KX
         tegcYVOPFunew==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/9] x86/unwind: Compile kretprobe fixup code only if CONFIG_KRETPROBES=y
Date:   Thu, 21 Oct 2021 09:54:42 +0900
Message-Id: <163477768249.264901.5797532967197120056.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163477765570.264901.3851692300287671122.stgit@devnote2>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile kretprobe related stacktrace entry recovery code and
unwind_state::kr_cur field only when CONFIG_KRETPROBES=y.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/unwind.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index fca2e783e3ce..2a1f8734416d 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -16,7 +16,9 @@ struct unwind_state {
 	unsigned long stack_mask;
 	struct task_struct *task;
 	int graph_idx;
+#ifdef CONFIG_KRETPROBES
 	struct llist_node *kr_cur;
+#endif
 	bool error;
 #if defined(CONFIG_UNWINDER_ORC)
 	bool signal, full_regs;
@@ -105,9 +107,13 @@ static inline
 unsigned long unwind_recover_kretprobe(struct unwind_state *state,
 				       unsigned long addr, unsigned long *addr_p)
 {
+#ifdef CONFIG_KRETPROBES
 	return is_kretprobe_trampoline(addr) ?
 		kretprobe_find_ret_addr(state->task, addr_p, &state->kr_cur) :
 		addr;
+#else
+	return addr;
+#endif
 }
 
 /* Recover the return address modified by kretprobe and ftrace_graph. */

