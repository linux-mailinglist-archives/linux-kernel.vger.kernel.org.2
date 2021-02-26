Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E853266F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBZSdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:33:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhBZScs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:32:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5161064F1B;
        Fri, 26 Feb 2021 18:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614364328;
        bh=O4XNFLotOUyVka5JlD8Hwo53U3FmnPBkn72o56HjF6M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aBpDfwfS3qBdf9sQ43DlTkmafN2Npg1WY/42CHcwxid0afh4AIE70/b7A2pGGOkpi
         weO6lADCnDVMXWQKDLpd7u98VfxTPCpHOUh3o5Ey9Aym8Tj+f2v0pZuiBLPT5M3ckD
         X95e9SA2wyr2I3L/ESJn4Jn6YvnhDvY+8Ge33+2gEoBgGDciE+10xLNEZojA0mRh+9
         f3gcR8rzs7rut3UyeLnsp/yNVFMqWeGN34NtpaspS9nEadNZ5VP3EjIdId4IQkGYCd
         yfembEWidMGoTin05KtA/JVBUMGgPqIG0Wfqyvag2D7QtM4G/TMGwV5NJfzQN6F9OZ
         IEfJFMVKi9s0Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4CF8660A0E;
        Fri, 26 Feb 2021 18:32:08 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.12 Merge Window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-fc1ac1f4-4558-4cfc-aef5-bc486eed7953@palmerdabbelt-glaptop>
References: <mhng-fc1ac1f4-4558-4cfc-aef5-bc486eed7953@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-fc1ac1f4-4558-4cfc-aef5-bc486eed7953@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-mw0
X-PR-Tracked-Commit-Id: d7fbcf40df86bb67193d9faf52138fc1202decb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b83369ddcb3fb9cab5c1088987ce477565bb630
Message-Id: <161436432830.9780.2318490001072407190.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 18:32:08 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Feb 2021 07:39:42 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b83369ddcb3fb9cab5c1088987ce477565bb630

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
