Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94932324F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhBYMC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:02:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhBYMCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:02:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C017364F16;
        Thu, 25 Feb 2021 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614254533;
        bh=3NYrEFNraX/ruCCDsNPPlY3VNMC7MnHOJ8iEj90kc54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dC5oHmgF63fxi8VGhU7lWw7WVxv3ArcAVrQNSKadasv2PfmEEc4kqRKkEqnIpjJXd
         d+4Ez2vKBeeMbnOER6MFvD2+Xy6GZx+KruCBRGPsWQVRY8qBwaASiM6FxwtQnS0Bh/
         zi52QUi7Wf+QO0QVoVYGqxXhPl1nLuzvcuBqiUz+X3UM1GcgI1KGAVteL28WeS2XRJ
         fgfQqF3tUaB45CqO6Hf4Yzf/Q2EnyALtUjUtSlUv30Y/fxdewwYBbnKhh7cBFqfmjR
         +ajgPZHMIsBxnjV4829YCdUBJfwGBAxYUmgynLA7Uz+AFIwWqA8n6VC4C0uhl0ViX1
         TVlwz4qpLHV/A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org, x86@kernel.org
Subject: [BUGFIX PATCH -tip 1/2] x86/kprobes: Retrieve correct opcode for group instruction
Date:   Thu, 25 Feb 2021 21:02:08 +0900
Message-Id: <161425452807.93763.16971315111567129320.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161425451732.93763.18329509061375062554.stgit@devnote2>
References: <161425451732.93763.18329509061375062554.stgit@devnote2>
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

