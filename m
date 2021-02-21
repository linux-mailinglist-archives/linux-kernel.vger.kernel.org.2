Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15A320DBD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhBUUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhBUUy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:54:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CA85164EC8;
        Sun, 21 Feb 2021 20:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613940825;
        bh=Q9xvOu8QML+bnkurGG/Yas7VGk7auG0sxA4ZDmbMfY0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qyvLML1YVIFDBF/T6kR4XtVr3qKP+MPTNkcg/Yqa1GlwGRsOpm9S15xSgxbz03yRW
         1RVh3V/yrIKjiX2kAhHnGQTCYSJCvqoF+TJN8rdgx/RPmIwnTnXGzlLQYL0ZWMymoA
         eX8bntfnuGgPFUQx3jWfxFaLW/6IpZuBNUGBRcv8u+b1ntitzvLITe0Mf6AslSBtI5
         C80aUYkQ4hMQNW1w+rVer/lAzDeITVFnGNoJ9zxoeaNOHzXVxNyhHvb9YiLafqZmav
         l8me4irIjAcvWeUpXRnrt/sZRU2s1wZNqggJuaPDbqrM1MrBoS/sz4YJ4pCmKlMRPf
         7NB3NTJMW0ZuA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BD61A60192;
        Sun, 21 Feb 2021 20:53:45 +0000 (UTC)
Subject: Re: [GIT PULL] locking updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210217114054.GA80562@gmail.com>
References: <20210217114054.GA80562@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210217114054.GA80562@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-02-17
X-PR-Tracked-Commit-Id: 3765d01bab73bdb920ef711203978f02cd26e4da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9eef02334505411667a7b51a8f349f8c6c4f3b66
Message-Id: <161394082577.25590.7321959020424139138.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 20:53:45 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 12:40:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9eef02334505411667a7b51a8f349f8c6c4f3b66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
