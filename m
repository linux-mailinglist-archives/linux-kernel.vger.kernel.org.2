Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6706343CFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbhJ0RrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243204AbhJ0Rq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:46:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3E49F610C7;
        Wed, 27 Oct 2021 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635356671;
        bh=sxSBCVSoDFRjEvZta3+7IW4iBIl7PkGKNdrrPYN1ZGY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OVQz1mtzM0xj6Uc1bGJrltvmZsFVg73KMOQKpmHmFSRe0Uq5Hh+R9tMO2HzR+MMeS
         J9yOVuVQpe5HamTvJIkeOMhvfWexaNeqEsCs9+RuaaAUJt9yhDgE/xgWJTZewxILnZ
         DpHk/Mz1P2XENxHgQUurvlU5J0oIAuQlYb+0Yn0PD+AeofuJuQOYP9m/mCL4V5XGO2
         HF03Y2bxfIxLZU7Lkfg/VS7muMTDZIYxqi82BFAZg6tmqWj3rQuBe0DIrNaDzx+WKv
         ntFwF6FJGWz/mCI4elBkSWg5oQPCJdnThnQ7ez3hDE6Ax+UjB6XSNsV9SKEewq0ufJ
         Xx5ezwhPhic0Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2AA6360A25;
        Wed, 27 Oct 2021 17:44:31 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace/nds32: Update the proto for ftrace_trace_function
 to match ftrace_stub
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211027132813.1e365f18@gandalf.local.home>
References: <20211027132813.1e365f18@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211027132813.1e365f18@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-rc6
X-PR-Tracked-Commit-Id: 4e84dc47bb48accbbeeba4e6bb3f31aa7895323c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fc596a56b334f4d593a2b49e5ff55af6aaa0816
Message-Id: <163535667116.24725.15250150955280091734.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Oct 2021 17:44:31 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Oct 2021 13:28:13 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fc596a56b334f4d593a2b49e5ff55af6aaa0816

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
