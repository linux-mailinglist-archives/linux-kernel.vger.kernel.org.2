Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E9426ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbhJHMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhJHMaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:30:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2F8760F48;
        Fri,  8 Oct 2021 12:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633696097;
        bh=JfCUmjaLkUSD15VcAhkRn1LbezN+xsj1TN/vh4p83DE=;
        h=From:To:Cc:Subject:Date:From;
        b=g223vqRtq6KNgcgConU7RQQ+pVnkqgzBTKCdbqP/UzuJd+cgEgn056KrocDoLfZa4
         MtbdsjG5gheIHe2VcjX96J05tJ6rI0IWuNcyeF7X9pWrMNmsqU3JB04CCvetasCGfR
         FgfUYgoJ/kOJKJD5PhiQ58YhPb6y+CSv5s3AIoQZDcxJqnaHEtJWBt2C7TWdysjg5F
         jZTesbId0gF2LoL4THkndVZgTUcXohkxklQ21mRxcMuYXqH+Ahy/qYqYs+zDqoUdkS
         2hepQ9aNFoJK3wksFv2FScFPfr35B4onnXyxTooKgt5XqN1DYfculQQThqqRIjq7sz
         CCtTleXUT1rzg==
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
Subject: [PATCH 0/8] kprobes: Make KUnit and add stacktrace on kretprobe tests
Date:   Fri,  8 Oct 2021 21:28:13 +0900
Message-Id: <163369609308.636038.15295764725220907794.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the series to change the kprobes selftest to KUnit and
add testcases for stacktrace on kretprobes, which has been fixed
recently on x86.

KUnit conversion work has been done by Sven. (Thanks!)
I found that if there are testcases for the stacktrace on kretprobes
we can make sure that the stacktrace can work or not while booting.
So I added 2 additinal Kunit test cases for stacktrace on kretprobe.
One is for a simple stacktrace on kretprobe, the other is for the
stacktrace with kretprobes on nested functions.

But actually, this is currently only for the x86. Thus I also added
some fixes to enable stacktrace on kretprobe on arm and arm64.

Note that for the arm, this series only supports framepointer
based stacktrace. To support ARM unwinder, will need more work.

Thank you,

---

Masami Hiramatsu (7):
      kprobes: Add a test case for stacktrace from kretprobe handler
      arm64: kprobes: Record frame pointer with kretprobe instance
      arm64: kprobes: Make a frame pointer on __kretprobe_trampoline
      arm64: Recover kretprobe modified return address in stacktrace
      ARM: clang: Do not relay on lr register for stacktrace
      ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
      ARM: Recover kretprobe modified return address in stacktrace

Sven Schnelle (1):
      kprobes: convert tests to kunit


 arch/Kconfig                                  |    8 +
 arch/arm/Kconfig                              |    1 
 arch/arm/include/asm/stacktrace.h             |    5 
 arch/arm/kernel/return_address.c              |    2 
 arch/arm/kernel/stacktrace.c                  |   11 +
 arch/arm/probes/kprobes/core.c                |   29 ++
 arch/arm64/Kconfig                            |    1 
 arch/arm64/include/asm/stacktrace.h           |    2 
 arch/arm64/kernel/probes/kprobes.c            |    4 
 arch/arm64/kernel/probes/kprobes_trampoline.S |    4 
 arch/arm64/kernel/stacktrace.c                |    3 
 arch/x86/Kconfig                              |    1 
 kernel/kprobes.c                              |    3 
 kernel/test_kprobes.c                         |  374 ++++++++++++++-----------
 lib/Kconfig.debug                             |    3 
 15 files changed, 278 insertions(+), 173 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
