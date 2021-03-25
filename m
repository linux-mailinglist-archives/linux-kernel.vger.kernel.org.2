Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D663348DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhCYKJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhCYKIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:08:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4419861A2B;
        Thu, 25 Mar 2021 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616666917;
        bh=oyzN3FRBz5UFGN/56rP3v7bYva/GwUBeoyF7tGxcGq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjIgeGs+DqVQJ87QIGFNOAr/EoGelkcqnrdxT8H2viQKLlmz92NvVoUWdAmjG2rln
         rZZHDerzm49Q1WLu7mgsjsKF59GPArwBjRmv/ySTyIQzpWzDfA6GKBBjJZ8e98FNqd
         zRYtYAEa8Nfe9CagYQkWhY+wYFfGQMma/n0Y/AgaA5/C6CzvyM6myWtCmKgCw/sXPG
         cePSDhk5S4PVTVrZvxji1kw7RQemihOfc6DEQzIRzr45IFjvyRdAzbWyUCem+nuPnP
         otTPECrOyJ0V+PVH/I/2MEerYsE337ucvNJ9uoCyFt5JAI3jLawWHHx8H8QiDqikd1
         jUgzYHo03Laew==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        dan.carpenter@oracle.com,
        Muhammad Usama Anjum <musamaanjum@gmail.com>
Subject: [PATCH -tip 1/2] x86/kprobes: Fix to check non boostable prefixes correctly
Date:   Thu, 25 Mar 2021 19:08:31 +0900
Message-Id: <161666691162.1120877.2808435205294352583.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161666690060.1120877.4569379871114610764.stgit@devnote2>
References: <161666690060.1120877.4569379871114610764.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 bugs in the can_boost() function because of using
x86 insn decoder. Since the insn->opcode never has a prefix byte,
it can not find CS override prefix in it. And the insn->attr is
the attribute of the opcode, thus inat_is_address_size_prefix(
insn->attr) always returns false.

Fix those by checking each prefix bytes with for_each_insn_prefix
loop and getting the correct attribute for each prefix byte.
Also, this removes unlikely, because this is a slow path.

Fixes: a8d11cd0714f ("kprobes/x86: Consolidate insn decoder users for copying code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 89d9f26785c7..503958f15cf9 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -139,6 +139,8 @@ NOKPROBE_SYMBOL(synthesize_relcall);
 int can_boost(struct insn *insn, void *addr)
 {
 	kprobe_opcode_t opcode;
+	insn_byte_t prefix;
+	int i;
 
 	if (search_exception_tables((unsigned long)addr))
 		return 0;	/* Page fault may occur on this address. */
@@ -151,9 +153,14 @@ int can_boost(struct insn *insn, void *addr)
 	if (insn->opcode.nbytes != 1)
 		return 0;
 
-	/* Can't boost Address-size override prefix */
-	if (unlikely(inat_is_address_size_prefix(insn->attr)))
-		return 0;
+	for_each_insn_prefix(insn, i, prefix) {
+		insn_attr_t attr;
+
+		attr = inat_get_opcode_attribute(prefix);
+		/* Can't boost Address-size override prefix and CS override prefix */
+		if (prefix == 0x2e || inat_is_address_size_prefix(attr))
+			return 0;
+	}
 
 	opcode = insn->opcode.bytes[0];
 
@@ -181,8 +188,8 @@ int can_boost(struct insn *insn, void *addr)
 		/* indirect jmp is boostable */
 		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
 	default:
-		/* CS override prefix and call are not boostable */
-		return (opcode != 0x2e && opcode != 0x9a);
+		/* call is not boostable */
+		return opcode != 0x9a;
 	}
 }
 

