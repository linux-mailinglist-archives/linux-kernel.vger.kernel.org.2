Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17836353153
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDBWon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233665AbhDBWom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:44:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6906A61178;
        Fri,  2 Apr 2021 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617403480;
        bh=TevBS1e5JGG72SyihXyohtotR5Jbf94BdhvNsprfbuo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pwjnqb7LX6CZsBDv1hGG470ARzX6fe0mEXbJORI4JdJIXiQ/0l4S3yygUi7TyyK4Z
         /eVjrUgyNEV8Pm3uFNvvGVq6qDxb+wFN1qzMrDZiSeg0zVV/IACLuRNRr0d4I4hbAL
         aHElyV0Dgv4nNtO3NMYc1xo8+eqfh3EY8czOdd4AVNSgoYWwfy2zNnKMCav5uEPgCQ
         4tAHW5wmXZKDNEPuzyIbS2g4qEk2G4TJZ780XO163byt7pAjXMGv+tNLkL8GoW21Cr
         KuAd5J4DuBiWAAq47y8LtYgj8aEeIxltfaJ8zAW0Ka8OB7QF39Uly5h2UFoxDactHW
         LKjMsL9/efcXw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 569A6609CC;
        Fri,  2 Apr 2021 22:44:40 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix stack trace event size
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210402093315.1b692cbf@gandalf.local.home>
References: <20210402093315.1b692cbf@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210402093315.1b692cbf@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc5-2
X-PR-Tracked-Commit-Id: 9deb193af69d3fd6dd8e47f292b67c805a787010
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05de45383bd134fcb2b7d70d35ebb0bb50b5e4aa
Message-Id: <161740348029.31502.11415847898232927626.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Apr 2021 22:44:40 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Apr 2021 09:33:15 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05de45383bd134fcb2b7d70d35ebb0bb50b5e4aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
