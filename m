Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A477C3A50BF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFLVHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 17:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFLVHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 17:07:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 61E3761009;
        Sat, 12 Jun 2021 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623531941;
        bh=mxL3orDQ2lIBWZJ8T+uJfTHiqMrrrpp603yP4M96s8Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=umLhcE9lJSM9DHg6x//TmMR6jam1Oy+uxHfq7dYh1URL1rGdGUwdcUkTu3mioyVNY
         Krd/Q3kqJkWZXLv4IawEN24ExoOWgMf7s3nnt6IO3St9efoIhG3iynggJTZq/zEUOg
         VOp1Ijc+f3/597qTWHQQHmyu9X3PHM/q8qspHakoi/dR2W1r+HzbZe+jMR3bsLVz2H
         94Mx1xZWRwThoxmn578W+td7hhFJf/QU4VIagjPCWed8HAYa3zUONK6sTukTBrh5JM
         D6iQnSjMu++g1FzhtDA3Dmau/e0YGK2/59KDH37GCZsbWdQF80WVz+iw7/hWSrVLb7
         RabLi3Ulgn69Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4E38C60BE1;
        Sat, 12 Jun 2021 21:05:41 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-eafb1de7-d58e-417f-9a42-76e32e2a04d5@palmerdabbelt-glaptop>
References: <mhng-eafb1de7-d58e-417f-9a42-76e32e2a04d5@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-eafb1de7-d58e-417f-9a42-76e32e2a04d5@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc6
X-PR-Tracked-Commit-Id: 0ddd7eaffa644baa78e247bbd220ab7195b1eed6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ecfa36cd4db3275bf3b6c6f32c7e3c6bb537de2
Message-Id: <162353194126.25557.17189221444801857836.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 21:05:41 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Jun 2021 08:58:05 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ecfa36cd4db3275bf3b6c6f32c7e3c6bb537de2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
