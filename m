Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C34532348E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhBXAAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233632AbhBWXju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:39:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 25D0964EBA;
        Tue, 23 Feb 2021 23:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614123393;
        bh=IzUNOlH3yLRdtbSW+bRGG51uO0W3tO9lyjlUs7JC3dY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A7abFtG/aR4a8NFTYeP/0N8A02M4SspPf06uSyVd9H60M4NOXTs0fp3SxTwVtgbu1
         A82Ot+aa6vX6ncj4B19280v2tGEGYevr7oVsvEhXp9gCpjRTckzcjyNSFAWv1JHGyg
         tCG3q+Ns5Jf5BuYd+ru/ScQcAGqPbRPewd3DRRGAl1dJFNblV9M4+X9YGjW7fa2cNO
         0ZnrRvpikA9Ooz4X/vCNIeIh30YbXiZIusoBAISE74YeRs9uyNv7zl2BnBYk6i11A9
         9g1pcFt7m4rnZvNDJej5iutpg1KLL3FPZNhPmkP9ChMQ1dQHtY28ZdeuUOAZuuZ0Eq
         EXrcbd5GfeFCQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 20EED60176;
        Tue, 23 Feb 2021 23:36:33 +0000 (UTC)
Subject: Re: [GIT PULL] clang-lto (part 2) for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202102231416.F35628E@keescook>
References: <202102231416.F35628E@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202102231416.F35628E@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1-part2
X-PR-Tracked-Commit-Id: 5e95325fbbbdea96de91e7bdb05fe95a3031e37d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 414eece95b98b209cef0f49cfcac108fd00b8ced
Message-Id: <161412339312.20258.3918342161141874906.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 23:36:33 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 14:32:23 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/414eece95b98b209cef0f49cfcac108fd00b8ced

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
