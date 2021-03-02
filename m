Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438FA32A910
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580632AbhCBSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:05:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578662AbhCBP0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:26:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8DC264F20;
        Tue,  2 Mar 2021 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614698740;
        bh=/EPeHsysmS5j3gWA7LCRzNunRpVIQ12uGcFenvOaMHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2BCBMsoM9mQMmO2W4Je3E72ULRAyyTdR2MYJ1t5dnL3DrDcWprZyW6vEPtiQijNE
         C0za1WE3tpEZhYdq6ATAyT1dUo81kCHsulekTzgazxmjjnZunmbAVJnnLMJJmG8WTG
         DInWI7RELv33JoLxp80bbo61hvynXnD2gEDo64FW9rg1cTrBsgRaUYhPhrP7gsaeKA
         ob09r1EqQjV11x/jKP6EkHk+9GkKeNHD1DuhbdC5PDpSdjpVI3dh5xY4HtiSNCpyNG
         ziuZDpcp3eC/UnjURgBVAEZ8oqVsukySJ8PIKZHHqnIhnnY/ig9o8holPsi9PrsbEN
         KUyZw7yEko+SQ==
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
Subject: [PATCH -tip 2/3] x86/kprobes: Identify far indirect JMP correctly
Date:   Wed,  3 Mar 2021 00:25:34 +0900
Message-Id: <161469873475.49483.13257083019966335137.stgit@devnote2>
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

Since Grp5 far indirect JMP is FF "mod 101 r/m", it should be
(modrm & 0x38) == 0x28, and near indirect JMP is also 0x38 == 0x20.
So we can mask modrm with 0x30 and check 0x20.
This is actually what the original code does, it also doesn't care
the last bit. So the result code is same.

Thus, I think this is just a cosmetic cleanup.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 08674e7a5d7b..be76568d57a5 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -462,8 +462,7 @@ static void set_resume_flags(struct kprobe *p, struct insn *insn)
 			p->ainsn.is_call = 1;
 			p->ainsn.is_abs_ip = 1;
 			break;
-		} else if (((opcode & 0x31) == 0x20) ||
-			   ((opcode & 0x31) == 0x21)) {
+		} else if ((opcode & 0x30) == 0x20) {
 			/*
 			 * jmp near and far, absolute indirect
 			 * ip is correct.

