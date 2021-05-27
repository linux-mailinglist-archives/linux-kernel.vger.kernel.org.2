Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9145D3935E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhE0TE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236621AbhE0TEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:04:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 655B1613DC;
        Thu, 27 May 2021 19:02:34 +0000 (UTC)
Date:   Thu, 27 May 2021 20:02:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.13-rc4
Message-ID: <20210527190230.GA4576@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to e69012400b0cb42b2070748322cb72f9effec00f:

  arm64: mm: don't use CON and BLK mapping if KFENCE is enabled (2021-05-25 14:04:38 +0100)

----------------------------------------------------------------
arm64 fixes:

- Don't use contiguous or block mappings for the linear map when KFENCE
  is enabled.

- Fix link in the arch_counter_enforce_ordering() comment.

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Fix stale link in the arch_counter_enforce_ordering() comment

Jisheng Zhang (1):
      arm64: mm: don't use CON and BLK mapping if KFENCE is enabled

 arch/arm64/include/asm/barrier.h | 2 +-
 arch/arm64/mm/mmu.c              | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
Catalin
