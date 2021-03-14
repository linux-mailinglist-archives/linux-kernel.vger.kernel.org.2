Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F4333A800
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhCNUjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234084AbhCNUis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:38:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BF9AE64EC3;
        Sun, 14 Mar 2021 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615754327;
        bh=OuczVesYEZ0EZdwZfNG5IxrJ9G3NowBxgLp5lKiNvP4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hYDaJSJ/PPuTmJ9hAk6K/L6XL5Jgf3YW7lWQ6uTK+lzsylJwgtHk0Gasz9eYuXLRj
         OWY0dDwH7Hn7GnLW8MictlPv8nCgp2HAzvKcjoa8qryDtvgsjoBaMPfu+UZQOrNO85
         e3ENcbDM15uehsXeVpxBTSBH6Y595k5f2EmIn6Pcndtiot3BDABib5d+R7t2v3OKeZ
         zuEptEk1lsHagQGXNO1IH1qPE6KnJ6qCnOHGb2V296TKLcYeMWcFZFEUH4EfCbcMbE
         D1d1/xCOP4HsEo6dZj26T/dp90LJzHT2S+NZcWTmmUJXBenV8qoVxfLgpOGetbqUDh
         2DMDFToIl7bfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B9D65609C5;
        Sun, 14 Mar 2021 20:38:47 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161573640030.27979.11632442807067871943.tglx@nanos>
References: <161573639668.27979.17827928369874291298.tglx@nanos> <161573640030.27979.11632442807067871943.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161573640030.27979.11632442807067871943.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-03-14
X-PR-Tracked-Commit-Id: 46eb1701c046cc18c032fa68f3c8ccbf24483ee4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 802b31c0dd7f44c9ab44d39c6c4af22d958ad803
Message-Id: <161575432775.20317.6497290089089056120.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Mar 2021 20:38:47 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Mar 2021 15:40:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/802b31c0dd7f44c9ab44d39c6c4af22d958ad803

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
