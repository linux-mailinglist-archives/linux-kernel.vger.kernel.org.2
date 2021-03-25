Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EB348DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCYKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhCYKIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:08:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E28F619FF;
        Thu, 25 Mar 2021 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616666928;
        bh=dWbTqapzKLdCj+x1fPAhWWABKy8LLjVWxDCqrUn7AuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reajFy1eCWRgukEgszUgRIMGHEPpcD5SKtdAhYfg7nB9k3CbuU06DcRIEFQ6L0OVr
         rD5EX7hvBgiy+WL47on/QeDsXVf/QjYvnaapEvLbIZYjsIdUYFGe7XA73rxklEQT+x
         QDPKq2yBDTYUT+gxHtrSWpcXJGQo0BlGb67M8riPuU5qVi5tntj4Eo50e07nkPKJZR
         pM4/YOIaOP79tdd3V3AZDChJDqoKbwQqaOOVH/tbZC6vN48YN1yV1he6nHrsGqszS2
         sxvvU8IkldCvy/lTMwgeVtNQ4o/4cp/akMkAYKgJGSF9GCIgaEBGhZCaww6k/gqsWG
         VR8F+eJtDD/Tg==
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
Subject: [PATCH -tip 2/2] x86/kprobes: Fix to identify indirect jmp and others using range case
Date:   Thu, 25 Mar 2021 19:08:43 +0900
Message-Id: <161666692308.1120877.4675552834049546493.stgit@devnote2>
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

Fix can_boost() to identify indirect jmp and others using range case
correctly.

Since the condition in switch statement is opcode & 0xf0, it can not
evaluate to 0xff case. This should be under the 0xf0 case. However,
there is no reason to use the conbinations of the bit-masked condition
and lower bit checking.

Use range case to clean up the switch statement too.

Fixes: 6256e668b7 ("x86/kprobes: Use int3 instead of debug trap for single-step")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |   44 ++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 503958f15cf9..c1c763840d6e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -164,32 +164,28 @@ int can_boost(struct insn *insn, void *addr)
 
 	opcode = insn->opcode.bytes[0];
 
-	switch (opcode & 0xf0) {
-	case 0x60:
-		/* can't boost "bound" */
-		return (opcode != 0x62);
-	case 0x70:
-		return 0; /* can't boost conditional jump */
-	case 0x90:
-		return opcode != 0x9a;	/* can't boost call far */
-	case 0xc0:
-		/* can't boost software-interruptions */
-		return (0xc1 < opcode && opcode < 0xcc) || opcode == 0xcf;
-	case 0xd0:
-		/* can boost AA* and XLAT */
-		return (opcode == 0xd4 || opcode == 0xd5 || opcode == 0xd7);
-	case 0xe0:
-		/* can boost in/out and absolute jmps */
-		return ((opcode & 0x04) || opcode == 0xea);
-	case 0xf0:
-		/* clear and set flags are boostable */
-		return (opcode == 0xf5 || (0xf7 < opcode && opcode < 0xfe));
-	case 0xff:
-		/* indirect jmp is boostable */
+	switch (opcode) {
+	case 0x62:		/* bound */
+	case 0x70 ... 0x7f:	/* Conditional jumps */
+	case 0x9a:		/* Call far */
+	case 0xc0 ... 0xc1:	/* Grp2 */
+	case 0xcc ... 0xce:	/* software exceptions */
+	case 0xd0 ... 0xd3:	/* Grp2 */
+	case 0xd6:		/* (UD) */
+	case 0xd8 ... 0xdf:	/* ESC */
+	case 0xe0 ... 0xe3:	/* LOOP*, JCXZ */
+	case 0xe8 ... 0xe9:	/* near Call, JMP */
+	case 0xeb:		/* Short JMP */
+	case 0xf0 ... 0xf4:	/* LOCK/REP, HLT */
+	case 0xf6 ... 0xf7:	/* Grp3 */
+	case 0xfe:		/* Grp4 */
+		/* ... are not boostable */
+		return 0;
+	case 0xff:		/* Grp5 */
+		/* Only indirect jmp is boostable */
 		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
 	default:
-		/* call is not boostable */
-		return opcode != 0x9a;
+		return 1;
 	}
 }
 

