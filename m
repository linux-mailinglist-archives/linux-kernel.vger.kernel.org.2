Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CB44357F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 02:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJUA4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 20:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJUA4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:56:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92C05610A1;
        Thu, 21 Oct 2021 00:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634777659;
        bh=rK7WeQOEydZ5+taz9kl7I5pTx3YbEnObXpG1n7q5aN0=;
        h=From:To:Cc:Subject:Date:From;
        b=QstN+bLoFfnnOb4B8OAUIzH+VaE6Twd63XuVcONwQje/n4zDB72e4PGluVMwq9wur
         u9BHXvHw7OT69Bc0jaMYhPmsZIghP4Ko+aEntFxOTA07MjHWZ8SinBtkpbhTpWq/QI
         +PplWqNDUdVUqd8SNWrUQi7ssJbdGmkJm6A3mXOi3n47GDVUic4FpWYxu1gc/NrSAu
         ZKZWrbGkP5V9ORftD44id33vLlUQC38VYZrYB9WQSKrhgYzLSBVDx342CsA4nCINXS
         TA148fEJR3LK6uRveelqKKGgA52e7N0Ddk/5wRido/e0Hb/0+Y54i/swkstVBSaOKr
         CIdiD+WmvjGPQ==
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
Subject: [PATCH v3 0/9] kprobes: Make KUnit and add stacktrace on kretprobe tests
Date:   Thu, 21 Oct 2021 09:54:16 +0900
Message-Id: <163477765570.264901.3851692300287671122.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 3rd version of the series to change the kprobes selftest
to KUnit and add testcases for stacktrace on kretprobes, which has
been fixed recently on x86. The previous version is here;

https://lore.kernel.org/all/163430224341.459050.2369208860773018092.stgit@devnote2/T/#u

In this version, I fixed arm's trampoline code, and add the version tag.
And I also dropped the RFC patch. It may be discussed in another series.

Thank you,

---

Masami Hiramatsu (8):
      kprobes: Add a test case for stacktrace from kretprobe handler
      x86/unwind: Compile kretprobe fixup code only if CONFIG_KRETPROBES=y
      arm64: kprobes: Record frame pointer with kretprobe instance
      arm64: kprobes: Make a frame pointer on __kretprobe_trampoline
      arm64: Recover kretprobe modified return address in stacktrace
      ARM: clang: Do not rely on lr register for stacktrace
      ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
      ARM: Recover kretprobe modified return address in stacktrace

Sven Schnelle (1):
      kprobes: convert tests to kunit


 arch/Kconfig                                  |    8 +
 arch/arm/Kconfig                              |    1 
 arch/arm/include/asm/stacktrace.h             |    9 +
 arch/arm/kernel/return_address.c              |    4 
 arch/arm/kernel/stacktrace.c                  |   17 +
 arch/arm/probes/kprobes/core.c                |   28 ++
 arch/arm64/Kconfig                            |    1 
 arch/arm64/include/asm/stacktrace.h           |    4 
 arch/arm64/kernel/probes/kprobes.c            |    4 
 arch/arm64/kernel/probes/kprobes_trampoline.S |    4 
 arch/arm64/kernel/stacktrace.c                |    7 
 arch/x86/Kconfig                              |    1 
 arch/x86/include/asm/unwind.h                 |    6 
 kernel/kprobes.c                              |    3 
 kernel/test_kprobes.c                         |  374 ++++++++++++++-----------
 lib/Kconfig.debug                             |    3 
 16 files changed, 302 insertions(+), 172 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
