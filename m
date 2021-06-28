Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2013B69BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhF1UgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234575AbhF1UgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CF0AD61CD8;
        Mon, 28 Jun 2021 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624912413;
        bh=HUvxaPj3XVnO3MUYtWfBjrTLlJZEImN00WYJ12cLf+k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M5d3mxJy9lctVfSckryTGwyS9iPanxEVp01XtdY8Mkc/u3LipaIR+4nK3uIfNWm1r
         M2NmW9TWdUtXZNqAhCDyjzrCnVNkSDyJlpKuH8ebh1WzcRA9AsIvDiK79A0tFvfou7
         3Myc9nxUkkGiMee/jz2+9ZMMGGBU8TnsMEcVEWtnlbQ71xLaEAuLfmpMqMpKY+mFVQ
         XKP9voxNKLWLQsSnL19rWz6EXRPnHUk7bNP4ZkE8R6rAlniAa1qNaYY2K3Ws4XUyp1
         e0SQx7+apS9F16e7UL3s2WrLIPLZceE6h0C3HItc/IyB4B5Dg+ZUQobXab+odKBQ9O
         ybMEUiWE/7bHQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C892260A6C;
        Mon, 28 Jun 2021 20:33:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNl5x+NnCqi5DyG6@gmail.com>
References: <YNl5x+NnCqi5DyG6@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNl5x+NnCqi5DyG6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-2021-06-28
X-PR-Tracked-Commit-Id: fd2afa70eff057fab57c9e06708b68677b261a0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98e62da8b3ee9ac3faf388fd78ee982a765170a7
Message-Id: <162491241381.14584.3086189428801384770.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 20:33:33 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 09:27:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98e62da8b3ee9ac3faf388fd78ee982a765170a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
