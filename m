Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AAA3FA04D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhH0ULq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhH0ULp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:11:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 00CB160EAF;
        Fri, 27 Aug 2021 20:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630095056;
        bh=TSPJ9B5ctmgXYEYzurJRuzp+UPhIYcPkRusYE3OfY6E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G69j/RXTUAxUTeK9GgKSfQ9pPT23M4QoaOP8Jx/vb/lKY8y8a/rdJY9VXRkzFFebC
         a15pbkyowkZ4fYmmhw6MmwBEYydawrLfMLFIfjvNss6TsLRCUrdM8jSmxooN0DGiMR
         Ou184zSNXHSb1g54/gQz0mM07vQ5dIjZtxEPbRc/thQZYksNuzQYZUq/eqWFNdmr3C
         1OnCj1N4hZTr3YBJLg62NbW9oBFnFnG+WK40wnzadGvmNExPmyUxq5Ud0uI+wDuYO9
         DEzzL8pP9G4l/uR1zFas5HHqIjz/U41EaQBgbzDXiib8HoQ4Xh1I4fLUCke9KCaOgK
         VZdJ/M7ma54fA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E02C4609D2;
        Fri, 27 Aug 2021 20:10:55 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.14-rc8 (or 5.14)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-f06b0a4c-f321-4c14-9378-da36fbf6212f@palmerdabbelt-glaptop>
References: <mhng-f06b0a4c-f321-4c14-9378-da36fbf6212f@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-f06b0a4c-f321-4c14-9378-da36fbf6212f@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc8
X-PR-Tracked-Commit-Id: 417166ddec020c4e969aea064e23822591ad54df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a61b7a29647ed7c939ca76d3bf83c75d10ba16e
Message-Id: <163009505585.27622.7254144734962070601.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Aug 2021 20:10:55 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Aug 2021 10:45:51 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a61b7a29647ed7c939ca76d3bf83c75d10ba16e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
