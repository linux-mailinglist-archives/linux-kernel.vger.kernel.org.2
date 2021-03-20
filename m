Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF98342EBB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhCTSGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCTSGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:06:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BF9D361935;
        Sat, 20 Mar 2021 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616263583;
        bh=l/dFfg5NxQ55PxNwRp8gJUtrRQ2/YWk39vMk1+eRi9U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E5yaq0AjpI8ySz6gjSYRTp4gmppZEXfRwEuVIPXhFCtQ7GRPhFnFwIchNCe3ckMRl
         RWLqMOeALSc4+XVT3kyTV2MHoXUhDvljaAqldkVfyBOKINs+/iI1IwXpPB6L14PxWP
         Y7u3J+/I7ZtEJ2VLxTHMNo5EMYca+EPLu6HaggTVQPJKXAgcz/cmDCXN4oJUfJzwSG
         E/SZwuju1SCZf554RYg/3F9bFE12qLMxFkPLNwUCjN64mGHXgSXk5k6C0T4aAaGSW1
         CzjjF7pWV/XCUz9vAmRtxDRr0jDx7zVBHpE7HNInwUD9Cc1pxxAyAeGWfr8Fbsljam
         BRid+gjNjgGfw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A81F36096D;
        Sat, 20 Mar 2021 18:06:23 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-b3197f76-bb8d-4834-810e-3b255c26a5fd@palmerdabbelt-glaptop>
References: <mhng-b3197f76-bb8d-4834-810e-3b255c26a5fd@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-b3197f76-bb8d-4834-810e-3b255c26a5fd@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-rc4
X-PR-Tracked-Commit-Id: a5406a7ff56e63376c210b06072aa0ef23473366
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 812da4d39463a060738008a46cfc9f775e4bfcf6
Message-Id: <161626358362.25184.15422694224081714197.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Mar 2021 18:06:23 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Mar 2021 22:39:23 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/812da4d39463a060738008a46cfc9f775e4bfcf6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
