Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E534132A909
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580581AbhCBSE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578626AbhCBP0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:26:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9D1564F32;
        Tue,  2 Mar 2021 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614698729;
        bh=3NYrEFNraX/ruCCDsNPPlY3VNMC7MnHOJ8iEj90kc54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/c8ga0D9ldp2NTKJpgGXt+/CEpU1SWpJI5gPtFgIDDEQm3GeqpmCoe7Oj8YHwHgy
         dPZE6Oh/QBCT7RQJueVuquVkd+17XEOfCaeA3s9Y8XPQmrMQTZ71tec+beGfRXsntm
         LibAApEra7JBp+waB4aeU7KkEvOUoCbJ/Rhl/lUK31WVM7dPiuYawOPsCL4YZdqzOa
         SzVQ3BwmTqIPndwVizmt+YOUwkHFGygPtAaM5ebS9UD5nhz+Xop3Xflx07VUmLyi/a
         hBMJjNmetZ+4hTnD8b84vVFlWBqJWFp7LufRdOD5CS8qfkDwLAH2aflW4e27g4J1LR
         MDpd3+RepLLQA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip 1/3] x86/kprobes: Retrieve correct opcode for group instruction
Date:   Wed,  3 Mar 2021 00:25:24 +0900
Message-Id: <161469872400.49483.18214724458034233166.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161469871251.49483.9142858308048988638.stgit@devnote2>
References: <161469871251.49483.9142858308048988638.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the opcodes start from 0xff are group5 instruction group which is
not 2 bytes opcode but the extended opcode determined by the MOD/RM byte.

The commit abd82e533d88 ("x86/kprobes: Do not decode opcode in resume_execution()")
used insn->opcode.bytes[1], but that is not correct. We have to refer
the insn->modrm.bytes[1] instead.

Fixes: abd82e533d88 ("x86/kprobes: Do not decode opcode in resume_execution()")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index df776cdca327..08674e7a5d7b 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -448,7 +448,11 @@ static void set_resume_flags(struct kprobe *p, struct insn *insn)
 		break;
 #endif
 	case 0xff:
-		opcode = insn->opcode.bytes[1];
+		/*
+		 * Since the 0xff is an extended group opcode, the instruction
+		 * is determined by the MOD/RM byte.
+		 */
+		opcode = insn->modrm.bytes[0];
 		if ((opcode & 0x30) == 0x10) {
 			/*
 			 * call absolute, indirect

