Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB873F28B5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhHTIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhHTIxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:53:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D89E76103A;
        Fri, 20 Aug 2021 08:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629449588;
        bh=P0m8ta93af/fEEn+Cf3KaTsEJZZP3kZlKQCgiAglX0k=;
        h=Date:From:To:Cc:Subject:From;
        b=lRgsxhg2vp76vEmimhkV2WjB6b+ThMoovd6dz3FsNHUHXp5YhEPwwNwbbHA4+CDok
         WPgHBel/GYO7IGQ6uw+N2AlH88c8nZdyTcAKV0/zSrVpkYgUsX97+pE0QQvsKIeC61
         BqSsqWdsWb4fMfWy1zD2HdEHzRSUKThHgUnsDa5RUmjQ5tObU4ePraWK7pqmfgp2Zd
         Y/l+n+DKSzNuEiOD+vjBQ/Tq4gSz5RJijlLIUpPhUIkl2iJBHn6Ae2kUgbb1F78Hs1
         iwItB5OxT8fKx/URpSWwMcWPTazq7y0xjxoItoqmRMt6JUUiu4OItO0x93PyeT5Cw6
         9KT0GEvVzKjBg==
Date:   Fri, 20 Aug 2021 09:53:03 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
Subject: [GIT PULL] arm64 fixes for -rc7
Message-ID: <20210820085302.GA17037@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these two straightforward fixes for -rc7. Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 0c32706dac1b0a72713184246952ab0f54327c21:

  arm64: stacktrace: avoid tracing arch_stack_walk() (2021-08-03 10:39:35 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to bde8fff82e4a4b0f000dbf4d5eadab2079be0b56:

  arm64: initialize all of CNTHCTL_EL2 (2021-08-19 10:02:10 +0100)

----------------------------------------------------------------
arm64 fixes for -rc7

- Fix cleaning of vDSO directories

- Ensure CNTHCTL_EL2 is fully initialised when booting at EL2

----------------------------------------------------------------
Andrew Delgadillo (1):
      arm64: clean vdso & vdso32 files

Mark Rutland (1):
      arm64: initialize all of CNTHCTL_EL2

 arch/arm64/Makefile                | 2 ++
 arch/arm64/include/asm/el2_setup.h | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)
