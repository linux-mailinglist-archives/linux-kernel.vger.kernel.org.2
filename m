Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89B3308D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhA2TFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231485AbhA2TEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:04:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75E9464DFB;
        Fri, 29 Jan 2021 19:03:27 +0000 (UTC)
Date:   Fri, 29 Jan 2021 19:03:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: [GIT PULL] arm64 fixes for 5.11-rc6
Message-ID: <20210129190322.GA4590@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 75bd4bff300b3c5252d4a0e7a959569c62d1dbae:

  arm64: kprobes: Fix Uexpected kernel BRK exception at EL1 (2021-01-22 16:05:29 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to a1df829ead5877d4a1061e976a50e2e665a16f24:

  ACPI/IORT: Do not blindly trust DMA masks from firmware (2021-01-27 12:26:24 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix the virt_addr_valid() returning true for < PAGE_OFFSET addresses.

- Do not blindly trust the DMA masks from ACPI/IORT.

----------------------------------------------------------------
Moritz Fischer (1):
      ACPI/IORT: Do not blindly trust DMA masks from firmware

Vincenzo Frascino (1):
      arm64: Fix kernel address detection of __is_lm_address()

 arch/arm64/include/asm/memory.h |  6 ++++--
 drivers/acpi/arm64/iort.c       | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

-- 
Catalin
