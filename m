Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244A0324F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhBYMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhBYMCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:02:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF4B064F13;
        Thu, 25 Feb 2021 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614254522;
        bh=4Pq422Itf89+OrodC2mwEq/0imUv3fCzqXQVp2vZYds=;
        h=From:To:Cc:Subject:Date:From;
        b=QipSahcE+T4vHUk3JnIh5AvqbsZVZ7zUugBIhMwxgbY/wwi3RDwHuy5+Yh95OHPMj
         Ts5AfFycQ1uRko7UyijHOK2llpMeb+qrJ59weTgjchrEKK0Arrk+24c9KwagVdg4ys
         g48mojWZQF541W1U528LH1abzTwtbt+VvHWz0CvcAObdgSz07AxokPlx0VrZuKWo76
         K9Z+QYxvSYWEs4xzwlHtPsZGEVAmuE9HJ0ksvn2lKbLnD2yNPk+CM+b14M62Jetb0E
         9Z9eQjaO6mjc5Ne++ItbLMwIgtTBQuSLmdZuHHpycvRWXnkrsZgVrdKs8faZcHidRw
         6Xw8dSpcrN3Qg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org, x86@kernel.org
Subject: [BUGFIX PATCH -tip 0/2] x86/kprobes: Fix bugs in resume execution code
Date:   Thu, 25 Feb 2021 21:01:57 +0900
Message-Id: <161425451732.93763.18329509061375062554.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 2 bugfixes I have found in set_resume_flags().

The [1/2] fixes a bug which I have introduced by commit
abd82e533d88 ("x86/kprobes: Do not decode opcode in
resume_execution()"), and [2/2] has been there in the origin
of the x86 kprobes (before 2.6.12). Anyway, [2/2] is something
like a cosmetic patch, because the original code was mis-
understanding the opcode encoding, but the result is same.

Thank you,

---

Masami Hiramatsu (2):
      x86/kprobes: Retrieve correct opcode for group instruction
      x86/kprobes: Identify far indirect JMP correctly


 arch/x86/kernel/kprobes/core.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
