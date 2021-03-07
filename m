Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F67F3304DF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 22:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhCGVbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 16:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231506AbhCGVa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 16:30:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E9D2365163;
        Sun,  7 Mar 2021 21:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615152656;
        bh=3NQ9rbSMP8zQpj/w+nKbXH8f2I6ye2W7V+xTPIvcmzE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q9jvHPvBldYG2snDcydXf19DN20NV+U0YjfNoQq0G8CGzOiyygalbrC7GJCFCrK0p
         41iwd8TLj9iyftjKMZslLrGyd9erXubUaTezoHDxPWW/ncio/KwRxIvBx3RrbNKGDx
         d7ZrW05ChYxRS5n0zWCYOO70WjwjB7gPXzHpQicvTkrRkz2O8lKRFpYyHC3Fn/aujX
         /wC9Of4BzYNOT2CRh7A2ewBTMfwskxDqLPl0R/hnSU4sNvRhe7ZG7ZwsKUlhzeclgP
         TVBD+OYs+Y4VDsAL+GH+tAqGOuHNaMYUhz3+swpSh12/Q/OuuJ9EJthIPYUculdnBY
         MYFVARh6665kg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E37B6609DB;
        Sun,  7 Mar 2021 21:30:55 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87mtvfqn03.fsf@mpe.ellerman.id.au>
References: <87mtvfqn03.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87mtvfqn03.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-2
X-PR-Tracked-Commit-Id: 5c88a17e15795226b56d83f579cbb9b7a4864f79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbda7904302499dd7ffc073a3c84eb7c9275db0a
Message-Id: <161515265592.2708.9563446741138400613.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Mar 2021 21:30:55 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        feng.tang@intel.com, atrajeev@linux.vnet.ibm.com,
        uwe@kleine-koenig.org, peterz@infradead.org,
        gregkh@linuxfoundation.org, groug@kaod.org,
        linux-kernel@vger.kernel.org, ljp@linux.ibm.com, npiggin@gmail.com,
        jniethe5@gmail.com, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 07 Mar 2021 21:25:16 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbda7904302499dd7ffc073a3c84eb7c9275db0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
