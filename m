Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8440036259E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhDPQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235385AbhDPQZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:25:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A0F46137D;
        Fri, 16 Apr 2021 16:24:57 +0000 (UTC)
Date:   Fri, 16 Apr 2021 17:24:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] arm64 fix for 5.12-rc8/final
Message-ID: <20210416162451.GA11506@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A recent commit (2decad92f473, "arm64: mte: Ensure TIF_MTE_ASYNC_FAULT
is set atomically") broke the kernel build when using the LLVM
integrated assembly (only noticeable with clang-12 as MTE is not
supported by earlier versions and the code in question not compiled).
The Fixes: tag in the commit refers to the original patch introducing
subsections for the alternative code sequences.

Please pull the fix below for -rc8/final (Will's off today). Thanks.

The following changes since commit 738fa58ee1328481d1d7889e7c430b3401c571b9:

  arm64: kprobes: Restore local irqflag if kprobes is cancelled (2021-04-13 09:30:16 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 22315a2296f4c251fa92aec45fbbae37e9301b6c:

  arm64: alternatives: Move length validation in alternative_{insn, endif} (2021-04-15 18:33:25 +0100)

----------------------------------------------------------------
Fix kernel compilation when using the LLVM integrated assembly.

----------------------------------------------------------------
Nathan Chancellor (1):
      arm64: alternatives: Move length validation in alternative_{insn, endif}

 arch/arm64/include/asm/alternative-macros.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
Catalin
