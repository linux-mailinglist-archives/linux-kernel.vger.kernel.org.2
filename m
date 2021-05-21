Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DFE38BB5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhEUBOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235906AbhEUBOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:14:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E48661353;
        Fri, 21 May 2021 01:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621559601;
        bh=+6C+cr5HO4NbLyPRrtVLTzaPTBlY9RN2z1+pK+H8LLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iaZs6nUYEdOc4U3htY3V5EoWYZsECBXQfjjVdsa3Xx/GVCOWVDBVXTpzUZsDCekzZ
         nivT0K3oaigk+g8zp8NWJmLlHa0UhYN+NwhbBrMRi+AJOM0LaK+RUDy3meR1DhgGRj
         tfDKZL0RJ22kuiQoGGZdMujZai2Ge9l0Pn26gUtgCkVbSK687q7VAZn/wpLEfyoCcj
         3ZR+ce45dlLNdw2T1YvwrEPqKj4g8WeMIflrf1WtOaN8ycLTFd+d/2Y7uo0bpH3z+v
         DDY0jxPHXqB8teiET2WeabkQVlRBqMgHVZPDRAQ7rzylCI2E/vuiBBnZn7P81dbdNW
         TEia06vbngZyQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Brian Cain <bcain@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/3] hexagon: Handle {,SOFT}IRQENTRY_TEXT in linker script
Date:   Thu, 20 May 2021 18:12:37 -0700
Message-Id: <20210521011239.1332345-2-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521011239.1332345-1-nathan@kernel.org>
References: <20210521011239.1332345-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch "mm/slub: use stackdepot to save stack trace in objects" in -mm
selects CONFIG_STACKDEPOT when CONFIG_STACKTRACE_SUPPORT is selected and
CONFIG_STACKDEPOT requires IRQENTRY_TEXT and SOFTIRQENTRY_TEXT to be
handled after commit 505a0ef15f96 ("kasan: stackdepot: move
filter_irq_stacks() to stackdepot.c") due to the use of the
__{,soft}irqentry_text_{start,end} section symbols. If those sections
are not handled, the build is broken.

$ make ARCH=hexagon CROSS_COMPILE=hexagon-linux- LLVM=1 LLVM_IAS=1 defconfig all
...
ld.lld: error: undefined symbol: __irqentry_text_start
>>> referenced by stackdepot.c
>>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
>>> referenced by stackdepot.c
>>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a

ld.lld: error: undefined symbol: __irqentry_text_end
>>> referenced by stackdepot.c
>>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
>>> referenced by stackdepot.c
>>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a

ld.lld: error: undefined symbol: __softirqentry_text_start
>>> referenced by stackdepot.c
>>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
>>> referenced by stackdepot.c
>>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a

ld.lld: error: undefined symbol: __softirqentry_text_end
>>> referenced by stackdepot.c
>>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
>>> referenced by stackdepot.c
>>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
...

Add these sections to the Hexagon linker script so the build continues
to work. ld.lld's orphan section warning would have caught this prior to
the -mm commit mentioned above:

ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is being placed in '.softirqentry.text'
ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is being placed in '.softirqentry.text'
ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is being placed in '.softirqentry.text'

Fixes: 505a0ef15f96 ("kasan: stackdepot: move filter_irq_stacks() to stackdepot.c")
Link: https://github.com/ClangBuiltLinux/linux/issues/1381
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/hexagon/kernel/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 35b18e55eae8..20f19539c5fc 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -38,6 +38,8 @@ SECTIONS
 	.text : AT(ADDR(.text)) {
 		_text = .;
 		TEXT_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
-- 
2.32.0.rc0

