Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A827142AA14
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 18:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJLQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 12:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhJLQ5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 12:57:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43D3E60462;
        Tue, 12 Oct 2021 16:55:41 +0000 (UTC)
Date:   Tue, 12 Oct 2021 17:55:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] arm64 fixes for 5.15-rc6
Message-ID: <YWW+CSv9tLuteHQm@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I dropped the IRQ changes and I'm re-submitting the pull request.
Thanks.

The following changes since commit 22b70e6f2da0a4c8b1421b00cfc3016bc9d4d9d4:

  arm64: Restore forced disabling of KPTI on ThunderX (2021-09-23 15:59:15 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 596143e3aec35c93508d6b7a05ddc999ee209b61:

  acpi/arm64: fix next_platform_timer() section mismatch error (2021-10-12 17:41:19 +0100)

----------------------------------------------------------------
arm64 fixes:

- Fix CMA gigantic page order for 16K/64K page sizes.

- Fix section mismatch error in drivers/acpi/arm64/gtdt.c.

----------------------------------------------------------------
Jackie Liu (1):
      acpi/arm64: fix next_platform_timer() section mismatch error

Mike Kravetz (1):
      arm64/hugetlb: fix CMA gigantic page order for non-4K PAGE_SIZE

 arch/arm64/mm/hugetlbpage.c | 2 +-
 drivers/acpi/arm64/gtdt.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Catalin
