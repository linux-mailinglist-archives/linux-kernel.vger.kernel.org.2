Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE330E2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhBCSpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233087AbhBCSoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:44:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B41B264DA1;
        Wed,  3 Feb 2021 18:44:13 +0000 (UTC)
Date:   Wed, 3 Feb 2021 18:44:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [GIT PULL] arm64 fixes for 5.11-rc7
Message-ID: <20210203184408.GA5226@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit a1df829ead5877d4a1061e976a50e2e665a16f24:

  ACPI/IORT: Do not blindly trust DMA masks from firmware (2021-01-27 12:26:24 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 22cd5edb2d9c6d68b6ac0fc9584104d88710fa57:

  arm64: Use simpler arithmetics for the linear map macros (2021-02-02 17:45:09 +0000)

----------------------------------------------------------------
Fix the arm64 linear map range detection for tagged addresses and
replace the bitwise operations with subtract (virt_addr_valid(),
__is_lm_address(), __lm_to_phys()).

----------------------------------------------------------------
Catalin Marinas (2):
      arm64: Do not pass tagged addresses to __is_lm_address()
      arm64: Use simpler arithmetics for the linear map macros

 arch/arm64/include/asm/memory.h | 6 +++---
 arch/arm64/mm/physaddr.c        | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
Catalin
