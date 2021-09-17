Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA7940FD00
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbhIQPp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234037AbhIQPp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:45:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F69D61212;
        Fri, 17 Sep 2021 15:44:33 +0000 (UTC)
Date:   Fri, 17 Sep 2021 16:44:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.15-rc2
Message-ID: <YUS33qojC6HpxtFw@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 changes below. Thanks.

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 9fcb2e93f41c07a400885325e7dbdfceba6efaec:

  arm64: Mark __stack_chk_guard as __ro_after_init (2021-09-16 17:59:17 +0100)

----------------------------------------------------------------
arm64 fixes/cleanups:

- Fix the memset() size when re-initialising the SVE state.

- Mark __stack_chk_guard as __ro_after_init.

- Remove duplicate include.

----------------------------------------------------------------
Dan Li (1):
      arm64: Mark __stack_chk_guard as __ro_after_init

Lv Ruyi (1):
      arm64/kernel: remove duplicate include in process.c

Mark Brown (1):
      arm64/sve: Use correct size when reinitialising SVE state

 arch/arm64/kernel/fpsimd.c  | 2 +-
 arch/arm64/kernel/process.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Catalin
