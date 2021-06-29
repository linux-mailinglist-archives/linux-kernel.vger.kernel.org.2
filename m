Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6693B78F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhF2UAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232315AbhF2UAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:00:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B93BF61D9A;
        Tue, 29 Jun 2021 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624996661;
        bh=8+6a+fyxTo4lN/61UMuS5PVgBidVMf+ZXOZzcRIhg+4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=klmaXkUIt7VY/0EiL1EE/bS+DyPux7pLjIiTpihlfsKuOEvKCkVK1OAbUX02fcamZ
         +e+dm73+rLHQbffQbK9SOhmmRy139VcOOmXC24oe7lms2m7zru6774ncK9GiDPSirM
         FPU+/OjJBo4udqIdWmwpwwynLtP7Pe2IgAlpoUFypAmcLG/BVNBoBoxDXkHSW4XzAY
         ztxv9d00NzffAcv+LcLznK3+PGf5yo/bvVof4mjtm4BVj8AeQLBM+4WnrFWLHyvAE/
         JENHfDhAyeJmZJmkDPwmZreFnewOWcRsEj9U71CK5jL5UvivahxMiTqfzuXDOL9kiQ
         PUUjwRGa4VBjA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B2EC0609A3;
        Tue, 29 Jun 2021 19:57:41 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNshegt/DQV1JDc9@alley>
References: <YNshegt/DQV1JDc9@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNshegt/DQV1JDc9@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.14
X-PR-Tracked-Commit-Id: 94f2be50badfa88e96033e77621c6711d58f84d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e563592c3e4296780e5a184a917b8b86e126f0b3
Message-Id: <162499666172.30376.640337616785113430.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 19:57:41 +0000
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

The pull request you sent on Tue, 29 Jun 2021 15:34:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e563592c3e4296780e5a184a917b8b86e126f0b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
