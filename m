Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754B8457868
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 22:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhKSV5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 16:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhKSV5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 16:57:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4AB9F61B1E;
        Fri, 19 Nov 2021 21:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637358869;
        bh=OKEsBpmdjX2YA0L1jECCHRY3gZ9s0bCfxw3goGkgU/o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QFTKQ9XGPLVP+beOAt/qKbsXWBPzVFUItrX081CbUUAtxkZXIxQQPsnvi+fHM0mXq
         J8MZo5XvgobbjLVE198iQOb1f47kKGxuF94mzKxCmTveX6gaQhpy3RlXUlQZNXwb9G
         HUVbK+ikNxSSQ87y4nLgQK11cVFhZBbCIKnsbgnD8dtUJQBGhuBbZqtDdKECzsXtdx
         wmSFwVhOohG9XrU68Ea4hEqEb5d8fy0N+0XvCMwwMQF+Gl5+jYXeuLbKIWXO6S8UML
         uEUP5Ls1PIhfkW1oPV6h4D/4FQQKB5pLab1E87vxbuvWaHIaRCXANJ36GjOJl77fre
         bd9nlYS7PSjfw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 402A4604EB;
        Fri, 19 Nov 2021 21:54:29 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Histogram fix take two and two more fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211119161228.18322a90@gandalf.local.home>
References: <20211119161228.18322a90@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211119161228.18322a90@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-6
X-PR-Tracked-Commit-Id: 2ef75e9bd2c998f1c6f6f23a3744136105ddefd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4365e369fcc974057377e8cdcd9dfe5a7b05b62
Message-Id: <163735886920.25895.7897363333203698688.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Nov 2021 21:54:29 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Nov 2021 16:12:28 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4365e369fcc974057377e8cdcd9dfe5a7b05b62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
