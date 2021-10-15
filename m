Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0942F168
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbhJOMxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239182AbhJOMwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:52:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA77860ED4;
        Fri, 15 Oct 2021 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302248;
        bh=h8PVGKy7AZLLt4A4MFd/SwUgcbAlvVwYsYk9VVpprvg=;
        h=From:To:Cc:Subject:Date:From;
        b=ITg7dZgMJi6lOjRNDFvnzxW58CJUmOePHIZxeSrw3f74wsHcFm/LeipMq4mONGwYF
         o1pLz0jDbSNnrEbQYwdl8pLpFSCJ7tmUBlNcw7gR4mFNoC5S933VpuRFmLMuIDlMW4
         t6B7tPTDK5G+shBplIMpS0z2wY2cWS8p+NTPBXw7tKnjgP2Mu2U0LbSoSSh2F7j/hl
         9iF3nPtlXBu7GHrcJ7aGY3/ICsvYX0WL/qVGnzl/fZmSilVlCIK8k82HhO9lVQqcWP
         rqvZxUnc0n0BACKjTR1V9AAoUtpiRiL43rD8SxRN/NsM9Vk+cBUg2ApDyKYjxtcnBf
         F40XWrVcPSRRg==
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
Subject: [PATCH 00/10] kprobes: Make KUnit and add stacktrace on kretprobe tests
Date:   Fri, 15 Oct 2021 21:50:43 +0900
Message-Id: <163430224341.459050.2369208860773018092.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of the series to change the kprobes selftest
to KUnit and add testcases for stacktrace on kretprobes, which has
been fixed recently on x86. The previous version is here;

https://lore.kernel.org/all/163369609308.636038.15295764725220907794.stgit@devnote2/

In this version, I fixed some typos and coding issues according to
Will and Mark's comments. Thanks!

And I added 1 RFC patch, which will detect the unwinding error on
arm64 (just for testing) according to Mark's comment. But since
I'm not sure how to handle that error correctly in the unwinder
code. So this is just for testing.

Mark, can you tell me how can I handle it? Just asserted by WARN_ON_ONCE()
is OK? Or print out more error information? For the debugging, we need
more information, so I printed out the error code.

Thank you,

---

Masami Hiramatsu (9):
      kprobes: Add a test case for stacktrace from kretprobe handler
      x86/unwind: Compile kretprobe fixup code only if CONFIG_KRETPROBES=y
      arm64: kprobes: Record frame pointer with kretprobe instance
      arm64: kprobes: Make a frame pointer on __kretprobe_trampoline
      arm64: Recover kretprobe modified return address in stacktrace
      ARM: clang: Do not rely on lr register for stacktrace
      ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
      ARM: Recover kretprobe modified return address in stacktrace
      [RFC] arm64: kprobes: Detect error of kretprobe return address fixup

Sven Schnelle (1):
      kprobes: convert tests to kunit


 arch/Kconfig                                  |    8 +
 arch/arm/Kconfig                              |    1 
 arch/arm/include/asm/stacktrace.h             |    9 +
 arch/arm/kernel/return_address.c              |    4 
 arch/arm/kernel/stacktrace.c                  |   17 +
 arch/arm/probes/kprobes/core.c                |   29 ++
 arch/arm64/Kconfig                            |    1 
 arch/arm64/include/asm/stacktrace.h           |    4 
 arch/arm64/kernel/probes/kprobes.c            |    4 
 arch/arm64/kernel/probes/kprobes_trampoline.S |    4 
 arch/arm64/kernel/stacktrace.c                |   13 +
 arch/x86/Kconfig                              |    1 
 arch/x86/include/asm/unwind.h                 |    6 
 include/linux/kprobes.h                       |    2 
 kernel/kprobes.c                              |   52 +++
 kernel/test_kprobes.c                         |  374 ++++++++++++++-----------
 lib/Kconfig.debug                             |    3 
 17 files changed, 359 insertions(+), 173 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
