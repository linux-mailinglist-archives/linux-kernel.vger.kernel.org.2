Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510A135F99C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349034AbhDNROE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347495AbhDNROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:14:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EB3D6105A;
        Wed, 14 Apr 2021 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618420419;
        bh=WQq9WQ8YmZerfUOMQcrnFFazcCugJEQgQmNIPNDw2ck=;
        h=Date:From:To:Cc:Subject:From;
        b=VhCWsbX0XEnxOZLuyiTtLFsh1iwCkojK38LAHcGSiqVufuTgjDclWCZPKlUwgTmgM
         5yN/6WfNLQA1VGgyC/DYD/3FyxFjZgJHHNao4Rh/z9Rj40zBCgT7fZ8n5q5nXCYSo7
         Bs50nT783dxiqThvpnFEJuC2zHjLtjSKu6LWMBLfYQsuQuSCiSe2cc3crqlszQxt6W
         Sr0LvL1rQpSlme/JDx07DOWZRzyJUfCj1vNEsm8Xgjt8iGa7APl9wC8CZwh2ZSZ+az
         OZTyxohdyXunyECgbInre2Qw3tCAT20g9Y5kzVCfxIzcAJvdr24baDr+cxr9NBrlCo
         hxP8APY3FoTFA==
Date:   Wed, 14 Apr 2021 18:13:35 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, kernel-team@android.com
Subject: [GIT PULL] arm64: Fixes for -rc8
Message-ID: <20210414171334.GA25300@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these three arm64 fixes for -rc8; summary in the tag. We
don't have anything else on the horizon, although two of these issues
(the asm constraint and kprobes bugs) have been around for a while so
you never know.

Cheers,

Will

--->8

The following changes since commit 20109a859a9b514eb10c22b8a14b5704ffe93897:

  arm64: kernel: disable CNP on Carmel (2021-03-25 10:00:23 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 738fa58ee1328481d1d7889e7c430b3401c571b9:

  arm64: kprobes: Restore local irqflag if kprobes is cancelled (2021-04-13 09:30:16 +0100)

----------------------------------------------------------------
arm64 fixes for -rc8

- Fix incorrect asm constraint for load_unaligned_zeropad() fixup

- Fix thread flag update when setting TIF_MTE_ASYNC_FAULT

- Fix restored irq state when handling fault on kprobe

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: mte: Ensure TIF_MTE_ASYNC_FAULT is set atomically

Jisheng Zhang (1):
      arm64: kprobes: Restore local irqflag if kprobes is cancelled

Peter Collingbourne (1):
      arm64: fix inline asm in load_unaligned_zeropad()

 arch/arm64/Kconfig                      |  6 +++++-
 arch/arm64/include/asm/word-at-a-time.h | 10 +++++-----
 arch/arm64/kernel/entry.S               | 10 ++++++----
 arch/arm64/kernel/probes/kprobes.c      |  6 ++++--
 4 files changed, 20 insertions(+), 12 deletions(-)
