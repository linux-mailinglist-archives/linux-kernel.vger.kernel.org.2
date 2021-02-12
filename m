Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7381D31A43B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 19:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhBLSHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 13:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhBLSHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 13:07:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6277D64DBA;
        Fri, 12 Feb 2021 18:06:54 +0000 (UTC)
Date:   Fri, 12 Feb 2021 18:06:52 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix for 5.11
Message-ID: <20210212180649.GA11697@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below for 5.11 (final or -rc8). Thanks.

The following changes since commit 22cd5edb2d9c6d68b6ac0fc9584104d88710fa57:

  arm64: Use simpler arithmetics for the linear map macros (2021-02-02 17:45:09 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 68d54ceeec0e5fee4fb8048e6a04c193f32525ca:

  arm64: mte: Allow PTRACE_PEEKMTETAGS access to the zero page (2021-02-12 16:08:31 +0000)

----------------------------------------------------------------
Fix PTRACE_PEEKMTETAGS access to an mmapped region before the first
write.

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: mte: Allow PTRACE_PEEKMTETAGS access to the zero page

 arch/arm64/kernel/cpufeature.c | 6 +-----
 arch/arm64/kernel/mte.c        | 3 ++-
 2 files changed, 3 insertions(+), 6 deletions(-)

-- 
Catalin
