Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A25144654F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhKEPCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhKEPCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:02:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F1EF611C0;
        Fri,  5 Nov 2021 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636124364;
        bh=pKL79R6e/6XFSt3xwJ9CLWqM2WH3RKaSvXVeu+Riva8=;
        h=From:To:Cc:Subject:Date:From;
        b=STO1ghN4zaCF5IOzyYOj6Ff3mkZPthU7Jl8FcSWcjF7begjBgU4eRF9AWyvCZlj2h
         /q2/7GHX0sPDqAIT7aLttfpmonsLzAOhXT26w3dzeFkFeimq3GmpNvjf33b63bofXe
         SQmLWGYS6qmw2lFUrpBMOITGM1ZIvECPprmLTpNFVucBlhETHzmn26/vOxm3smwXmh
         8PmIlxm2j9sD2bMN8dErb4ZtjGw0o2Os0eQ1/ZIJZFihREQVwC7IQHD7/1tBHZD7mM
         rMekz8dZD2XIT5l+8tr4v3vWzDNz2hdo1/pd7asr6rwG4gLSm4QqJCZ4M2bbtJxLQu
         bortuVTSAA9fQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v6 0/2] static call support for arm64
Date:   Fri,  5 Nov 2021 15:59:15 +0100
Message-Id: <20211105145917.2828911-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; h=from:subject; bh=pKL79R6e/6XFSt3xwJ9CLWqM2WH3RKaSvXVeu+Riva8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhhUbAj5SBIcvjKtxaOssCNZgQWw/pHGgDQICvYqHa 6zjLF4+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYYVGwAAKCRDDTyI5ktmPJBUdC/ 0T1Dc01GVgdNiLpzvWkonon53HTdb9vEYTLLXfwNKsjnI3kcz6LRWtjpSTcxNcryANcq7X+L9ofz59 6E+iEqAMlAKovbJlF4E99DPgtpEM50bn96RAk7eDbESggSRW5JD4OHK/6HlHPk3rjrGLrDPIeC5PJy noVUMVClmR07CPEniOq4FDwBTkEfEk9LwKjCfsQu0gAozt9APTnk0xKi/GkJriwKnozkrEWbSnwuZy qmuLorCxBAZmxWVG4Uh4XPBWNPHruLB4PAcxXrp1Dz+P1w8NOs2mt6pOxxecVCiPK+ITkhmOwyTgVc pTsWlmWrtXdOH4qKr4LGph0PQwVFJhBRWbMlQq8W/2ZLeHDcAsl0WiGnvM1EVW17al/Xs0S/05l6Ne PINHHrYdhlHKXjDK6WTAoroh8Sq9it5dG2FyihmJqyINHjNju/4zGHrHUYzeuAcYadHUJad+pz7KOd kHuYusJV+htQgWVsSyvXE648BA98I+8649MFyyadZRSMc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements non-inline static calls for arm64. This is rather
straight-forward, as we don't rely on any tooling to look for static
call sites etc. The only minor complication is Clang CFI, which is
already in mainline for arm64, and requires a little tweak to ensure
that we don't end up patching the CFI jump table instead of the static
call trampoline itself.

Changes since v5:
- drop the patch that works around issues with references to symbols
  with static linkage from asm blocks; this is specific to Clang+ThinLTO
  in versions before 13, so we can just decide not to support that config.
- add a patch to use non-function type symbols for the trampolines, to
  ensure that taking the address gives us the trampoline itself rather
  than the address of a CFI jump table entry that branches to it.

Changes since v4:
- add preparatory patch to address generic CFI/LTO issues with static
  calls
- add comment to patch #2 describing the trampoline layout
- add handling of Clang CFI jump table entries
- add PeterZ's ack to patch #2

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>

Ard Biesheuvel (2):
  static_call: use non-function types to refer to the trampolines
  arm64: implement support for static call trampolines

 arch/arm64/Kconfig                   |  2 +
 arch/arm64/include/asm/static_call.h | 40 ++++++++++
 arch/arm64/kernel/patching.c         | 77 +++++++++++++++++++-
 arch/arm64/kernel/vmlinux.lds.S      |  1 +
 include/linux/static_call.h          |  4 +-
 include/linux/static_call_types.h    | 11 ++-
 6 files changed, 127 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/static_call.h

-- 
2.30.2

