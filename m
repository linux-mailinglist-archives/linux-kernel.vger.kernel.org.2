Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7583FE776
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhIBCPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhIBCPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:15:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1E4DA610C9;
        Thu,  2 Sep 2021 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630548850;
        bh=DCr56WN9HzRB2mnp05CqcQ/P+4dta2QGdu2y+cdLdT0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FtWCdJQWSuZ9o5VdVwRKji6McjznlZ755pXsd+hzUxo4MvZEqFTD7I47lffXy+/yK
         enVgPOJCDKQGVtOf05c5ldG1mLhwUcxDP0q/RSwG9BzwEFrFdsFzIljnkOSfOE4TNr
         DBuX4aWcBCpZdj2s4qe4LWFeqIiiFSdb64skbas/+GodHx85LtHJ4rrLGGQwiVKOgN
         F5l7MHpnnEdAi7zQnVmK/1vTuUNa9ko1y0Pg05SqcKhKIIlANDQ8VJqet57jZggmf7
         x11/jn2oTZ1d307RX7euJbXj5dTnxh/2AQGi5lxCVSYWtYnejmyIv8n8i/vCOlxcO8
         XJeme8BL2zMDA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 08BD060965;
        Thu,  2 Sep 2021 02:14:10 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS4H+87KIBcdc0m2@alley>
References: <YS4H+87KIBcdc0m2@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS4H+87KIBcdc0m2@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.15
X-PR-Tracked-Commit-Id: c985aafb60e972c0a6b8d0bd65e03af5890b748a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df43d903828c59afb9e93b59835127a02e1f8144
Message-Id: <163054884997.9778.1984014370272837237.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 02:14:09 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 12:44:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df43d903828c59afb9e93b59835127a02e1f8144

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
