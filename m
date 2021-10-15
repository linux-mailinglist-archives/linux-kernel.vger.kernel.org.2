Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631FD42F16B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbhJOMxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239248AbhJOMxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:53:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13FCB6108E;
        Fri, 15 Oct 2021 12:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302274;
        bh=/6Ses4iOpFuwfQyjHXNpCu4Cpb2y9TUHV8jz9fN04Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZD+YgR37fo5+Ms9i8CZvcGHzzgUehgFm0vKsvUk1RE75cth5o0EyuST2r56ToabsW
         mlp1cIoYacIoxrMTUkEeWQHCUtejHJBB4/7fIM/qQatgyIX574bYOs9az/dBlojMWB
         kskLLFI0FBRpXdG7ip2KifRdzrOtH1+jiKRqTEEaaBkJc3WUF15Y7V8C1zQ4hzfLQo
         1xuaZkmbLDjidVIJxjsz3kqq/TeZr91Og5U1XZr25KXpp3C63uwegFEPf9Vzx823yj
         4MW/G68+B6g7k4VEKGN5tBnfU1K6tP9awnsOsE06Yv0eqlBBfs6ZVNlbm9H5q8tZNg
         +B9nghvGGPKMQ==
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
Subject: [PATCH 03/10] x86/unwind: Compile kretprobe fixup code only if CONFIG_KRETPROBES=y
Date:   Fri, 15 Oct 2021 21:51:10 +0900
Message-Id: <163430227030.459050.12754362425825951410.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163430224341.459050.2369208860773018092.stgit@devnote2>
References: <163430224341.459050.2369208860773018092.stgit@devnote2>
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

