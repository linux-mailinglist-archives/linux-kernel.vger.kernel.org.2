Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A634324F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhBYMDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhBYMDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:03:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFBF264F17;
        Thu, 25 Feb 2021 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614254542;
        bh=/EPeHsysmS5j3gWA7LCRzNunRpVIQ12uGcFenvOaMHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HugT/bq9zKB+phfnsPOpPec7Gf73SeZnQnuY/irQfxQMNhzEYXXDezk1fvLYuHfBL
         eksRIOtNjSiGq2B83t2cKlE3Zh9+7GHxlIYTMUVf9GTdo/rg8lVieIc+RNfm4pmBr6
         HZ7gf9kAvO7m4qJPRg7BMDRdTuq5ZBAmXHqOMdHmU9wCxYar4h2EpVXcIlsQanFcHa
         eX5NprcwRQiZV+0UW0osk0XzLE/edzufuCf9LsoL7xxLi7EXbcuuvns5ypUfafBSkB
         a5kNUW8mXo734FD4K+0Y+LR3LKblUIuK0rywzqiZpVVoJ6Mieh1t1qg3T61HEdNeUJ
         widLRfVmUgMyg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org, x86@kernel.org
Subject: [BUGFIX PATCH -tip 2/2] x86/kprobes: Identify far indirect JMP correctly
Date:   Thu, 25 Feb 2021 21:02:18 +0900
Message-Id: <161425453835.93763.14098305070550862436.stgit@devnote2>
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

