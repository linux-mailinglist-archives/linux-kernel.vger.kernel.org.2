Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF043AD2DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhFRTdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233978AbhFRTcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:32:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1D0F6613BA;
        Fri, 18 Jun 2021 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624044626;
        bh=NSY71auSyZ+nAHsNcPV2LMxpoeDp0V1oPupSOTVkVwY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BAvhQb/yhd4pwi6A8EKW0Nw16gK3i54aZPDe3GBwDeBsJvhoKfoDCKqERW8Q0PBfV
         Yx+8k5QEaNMN6lXJV7An1UN3arzI8aqCZWznDfxY6NPtxQ8eUChJCJeaYLsvYbfKHs
         ZJjLke06nqKRrQd4cutoJSQ5EjT/iBP16DRY8cA8pgCeFPG7ivlzGk9btCLBFc0+jp
         xmVEGPJATp+NlVas4d/rTl01h9kKiit5PJTLvJDPKMvc2WG+NewDT6G7zzoOesgA1y
         a6M/AAfXYBlHlZ/NZE+O7RMgnmXi9ZM2r5mKZ/dnWMPm5DuegA/WwBLHLjIsX6UqZw
         8KdQghc0WuZdQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1698E609EA;
        Fri, 18 Jun 2021 19:30:26 +0000 (UTC)
Subject: Re: [GIT PULL] printk fixup for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMyPuzVfVbShxdeJ@alley>
References: <YMyPuzVfVbShxdeJ@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMyPuzVfVbShxdeJ@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.13-fixup
X-PR-Tracked-Commit-Id: 6262e1b906a1ba12688ea6039453b4a088dbaf44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f4022a490ad68846062186f481defd53be69743
Message-Id: <162404462608.17995.15591135013169804097.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jun 2021 19:30:26 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jun 2021 14:21:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.13-fixup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f4022a490ad68846062186f481defd53be69743

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
