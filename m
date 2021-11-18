Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E0645647F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhKRUwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234007AbhKRUwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:52:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0BC2E61929;
        Thu, 18 Nov 2021 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637268557;
        bh=zbGiRBbhEMy7dh3436HFSPUGwjcGhwnT0VoB+0nfYZQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BaaRip5jp1oIK3c85AP17UBaEcw+8drZnFEprcJB38j78Oh1FPXSgYfFwQ0S6deAU
         vBnSlzedXbq3tfeKyMTJDqGwmONJI1KfhA/JW8805ouP3UQu6JxoQMiE7eZmsVcJMO
         LT3Y2EmsmAMZTetxxiYMSAmOs5nAy8k1p5MAEMG2iNS9I7P9CSWYwAzuOzprxWDg/y
         dlwWloT1toJXtY+9poxvbNMiAIu/a0LZHDfA3O6VkJ+aqkt+BfdGhRFVjZ7qFlwrO8
         axqXOwXmwvINzMvf8ZVI8UIebcnFog23bNTkHekMCr2oAmrOV9H0Xt670WNh9P0SLH
         ZkQ+8/GqGN96A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 047AA60A4E;
        Thu, 18 Nov 2021 20:49:17 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 5.16 fixup
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YZYd5N29dc6KRhye@alley>
References: <YZYd5N29dc6KRhye@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YZYd5N29dc6KRhye@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.16-fixup
X-PR-Tracked-Commit-Id: bf6d0d1e1ab38309ea2a234e2e4ba2a18d014af9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d5775d49e4a488bc8a07e5abb2b71a4c28aadbb
Message-Id: <163726855701.10311.4052027667825775051.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 20:49:17 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 10:33:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.16-fixup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d5775d49e4a488bc8a07e5abb2b71a4c28aadbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
