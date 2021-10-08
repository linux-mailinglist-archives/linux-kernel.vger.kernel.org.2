Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415674270DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhJHSi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhJHSi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:38:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C50E60F6B;
        Fri,  8 Oct 2021 18:36:59 +0000 (UTC)
Date:   Fri, 8 Oct 2021 19:36:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] arm64 fixes for 5.15-rc5
Message-ID: <YWCPyK+xotTgUMy/@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 22b70e6f2da0a4c8b1421b00cfc3016bc9d4d9d4:

  arm64: Restore forced disabling of KPTI on ThunderX (2021-09-23 15:59:15 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 0350419b14b98fd6f36801583360c36c8820c2e6:

  arm64/hugetlb: fix CMA gigantic page order for non-4K PAGE_SIZE (2021-10-06 11:11:13 +0100)

----------------------------------------------------------------
arm64 fixes:

- Avoid double accounting of irq_{entry,exit}_rcu().

- Fix CMA gigantic page order for 16K/64K page sizes.

----------------------------------------------------------------
Mark Rutland (1):
      arm64: entry: refactor EL1 interrupt entry logic

Mike Kravetz (1):
      arm64/hugetlb: fix CMA gigantic page order for non-4K PAGE_SIZE

Pingfan Liu (2):
      kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch optional
      arm64: entry: avoid double-accounting IRQ RCU entry

 arch/arm64/Kconfig               |  1 +
 arch/arm64/kernel/entry-common.c | 47 +++++++++++++++++++++-------------------
 arch/arm64/mm/hugetlbpage.c      |  2 +-
 kernel/irq/Kconfig               |  3 +++
 kernel/irq/irqdesc.c             |  4 ++++
 5 files changed, 34 insertions(+), 23 deletions(-)

-- 
Catalin
