Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34BA41297D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244938AbhITXjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 19:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239846AbhITXhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:37:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83DC46124C;
        Mon, 20 Sep 2021 23:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632180763;
        bh=9VfWPpmolgcnU4FcIDFCZf2W+aZhBSZ8ekrhvSjR4iI=;
        h=From:To:Cc:Subject:Date:From;
        b=f3LBl4Wvlb+Rb0LRPqBh4ZqCbX9uFzJHYyp3w4dwHAFwPht5+VGjKSHFCcdgWlJA8
         takGMgR6Wm4gClGUIPi9TpcVq6EAHQ3IVRULriCY9FDidReUZQGtripTcb259TzeCZ
         tRGB2J3eNOrZBaZBtuc4KzcHCZvDsc2TCdmfMUiuQq3ppaUwjR5zxBcp53rF21Fln6
         sniaeurH9BPSzBmzuwjWcJowskNJDhbT98L40Ng493O4nGVtEGqDxANtCi/J65xCSR
         NyP6PEb0tBzc2rlv6p47shMrsQzUSPKoL4Y3YvQXEJv0eQs/AIpCrXJCybbmkZc2sv
         81WeVbPdJWHyA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/4] arm64: Support dynamic preemption
Date:   Tue, 21 Sep 2021 01:32:33 +0200
Message-Id: <20210920233237.90463-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally the preemption flavour was defined on Kconfig then fixed
in stone. Now with CONFIG_PREEMPT_DYNAMIC the users can overwrite that
on boot with the "preempt=" boot option (and also through debugfs but
that's a secret).

Linux distros can be particularly fond of this because it allows them
to rely on a single kernel image for all preemption flavours.

x86 was the only supported architecture so far but interests are
broader.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	preempt/arm

HEAD: 351eaa68b5304b8b0e7c6e7b4470dd917475e65e

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      sched/preempt: Prepare for supporting !CONFIG_GENERIC_ENTRY dynamic preemption
      arm64: Implement IRQ exit preemption static call for dynamic preemption
      arm64: Implement HAVE_PREEMPT_DYNAMIC

Ard Biesheuvel (1):
      arm64: implement support for static call trampolines


 arch/Kconfig                         |  1 -
 arch/arm64/Kconfig                   |  2 ++
 arch/arm64/include/asm/insn.h        |  2 ++
 arch/arm64/include/asm/preempt.h     | 23 ++++++++++++++++++++++-
 arch/arm64/include/asm/static_call.h | 28 ++++++++++++++++++++++++++++
 arch/arm64/kernel/Makefile           |  4 ++--
 arch/arm64/kernel/entry-common.c     | 15 ++++++++++++---
 arch/arm64/kernel/patching.c         | 14 +++++++++++---
 arch/arm64/kernel/vmlinux.lds.S      |  1 +
 include/linux/entry-common.h         |  3 ++-
 kernel/sched/core.c                  |  6 ++++--
 11 files changed, 86 insertions(+), 13 deletions(-)
